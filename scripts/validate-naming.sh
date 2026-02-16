#!/bin/bash
# validate-naming.sh
# PostToolUse hook: Checks naming conventions in DB-related files after Write/Edit.
# Non-blocking (exit 0) — provides warnings only without interrupting workflow.

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.filePath // empty')

# Exit if no file path provided
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Exit if file does not exist
if [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

# Check only DB-related files
FILEPATH_LOWER=$(echo "$FILE_PATH" | tr '[:upper:]' '[:lower:]')
FILENAME=$(basename "$FILE_PATH")

IS_DB_FILE=false
case "$FILEPATH_LOWER" in
  *entity*|*model*|*.sql|*migration*|*schema*|*dto*|*vo*|*mapper*)
    IS_DB_FILE=true
    ;;
esac

case "$FILENAME" in
  *.sql)
    IS_DB_FILE=true
    ;;
esac

if [ "$IS_DB_FILE" = false ]; then
  exit 0
fi

WARNINGS=""
WARNING_COUNT=0

# === SQL file check ===
if [[ "$FILENAME" == *.sql ]]; then

  # 1. Check table name prefix in CREATE TABLE statements
  while IFS= read -r table_name; do
    # Trim whitespace
    table_name=$(echo "$table_name" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    if [ -z "$table_name" ]; then
      continue
    fi
    # Verify TB_, TC_, TH_, TL_, TR_ prefix
    if ! echo "$table_name" | grep -qE '^(TB_|TC_|TH_|TL_|TR_)'; then
      WARNINGS="${WARNINGS}[Table] '${table_name}': Missing standard prefix (TB_/TC_/TH_/TL_/TR_)\n"
      WARNING_COUNT=$((WARNING_COUNT + 1))
    fi
  done < <(grep -ioE 'CREATE[[:space:]]+TABLE[[:space:]]+(IF[[:space:]]+NOT[[:space:]]+EXISTS[[:space:]]+)?[A-Za-z_][A-Za-z0-9_]*' "$FILE_PATH" 2>/dev/null | sed -E 's/CREATE[[:space:]]+TABLE[[:space:]]+(IF[[:space:]]+NOT[[:space:]]+EXISTS[[:space:]]+)?//i')

  # 2. Check for lowercase table/column names (mixed case warning)
  if grep -qE 'CREATE[[:space:]]+TABLE' "$FILE_PATH" 2>/dev/null; then
    if grep -qE '[a-z]{3,}_[a-z]' "$FILE_PATH" 2>/dev/null; then
      # If lowercase snake_case found, recommend uppercase standard
      HAS_LOWERCASE=$(grep -cE 'CREATE[[:space:]]+TABLE[[:space:]]+[a-z]' "$FILE_PATH" 2>/dev/null || echo "0")
      if [ "$HAS_LOWERCASE" -gt 0 ]; then
        WARNINGS="${WARNINGS}[Naming] Lowercase table names found in SQL. Standard requires uppercase (e.g., TB_CSTMR)\n"
        WARNING_COUNT=$((WARNING_COUNT + 1))
      fi
    fi
  fi
fi

# === Java entity file check ===
if [[ "$FILENAME" == *.java ]]; then

  # Check table name prefix in @Table annotation
  while IFS= read -r table_name; do
    table_name=$(echo "$table_name" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | tr -d '"')
    if [ -z "$table_name" ]; then
      continue
    fi
    if ! echo "$table_name" | grep -qE '^(TB_|TC_|TH_|TL_|TR_)'; then
      WARNINGS="${WARNINGS}[Table] @Table(name=\"${table_name}\"): Missing standard prefix (TB_/TC_/TH_/TL_/TR_)\n"
      WARNING_COUNT=$((WARNING_COUNT + 1))
    fi
  done < <(grep -oE '@Table\s*\(\s*name\s*=\s*"[^"]*"' "$FILE_PATH" 2>/dev/null | sed -E 's/@Table\s*\(\s*name\s*=\s*"([^"]*)"/\1/')

fi

# === TypeScript file check (TypeORM/Prisma) ===
if [[ "$FILENAME" == *.ts || "$FILENAME" == *.tsx ]]; then

  # Check table name in @Entity() decorator
  while IFS= read -r table_name; do
    table_name=$(echo "$table_name" | sed "s/^[[:space:]]*//;s/[[:space:]]*$//" | tr -d "'" | tr -d '"')
    if [ -z "$table_name" ]; then
      continue
    fi
    if ! echo "$table_name" | grep -qE '^(TB_|TC_|TH_|TL_|TR_)'; then
      WARNINGS="${WARNINGS}[Table] @Entity('${table_name}'): Missing standard prefix (TB_/TC_/TH_/TL_/TR_)\n"
      WARNING_COUNT=$((WARNING_COUNT + 1))
    fi
  done < <(grep -oE "@Entity\s*\(\s*['\"][^'\"]*['\"]" "$FILE_PATH" 2>/dev/null | sed -E "s/@Entity\s*\(\s*['\"]([^'\"]*)['\"/\1/")

fi

# === Python file check (SQLAlchemy/Django) ===
if [[ "$FILENAME" == *.py ]]; then

  # Check table name in __tablename__
  while IFS= read -r table_name; do
    table_name=$(echo "$table_name" | sed "s/^[[:space:]]*//;s/[[:space:]]*$//" | tr -d "'" | tr -d '"')
    if [ -z "$table_name" ]; then
      continue
    fi
    if ! echo "$table_name" | grep -qE '^(TB_|TC_|TH_|TL_|TR_)'; then
      WARNINGS="${WARNINGS}[Table] __tablename__='${table_name}': Missing standard prefix (TB_/TC_/TH_/TL_/TR_)\n"
      WARNING_COUNT=$((WARNING_COUNT + 1))
    fi
  done < <(grep -oE "__tablename__\s*=\s*['\"][^'\"]*['\"]" "$FILE_PATH" 2>/dev/null | sed -E "s/__tablename__\s*=\s*['\"]([^'\"]*)['\"/\1/")

fi

if [ -n "$WARNINGS" ]; then
  echo -e "[astra-methodology] Naming convention check results (${FILE_PATH}):"
  echo -e "$WARNINGS"
fi

exit 0
