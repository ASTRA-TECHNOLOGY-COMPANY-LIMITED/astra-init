# DB Naming Rules

> Defines naming rules for table names and column names based on the public data standard terminology dictionary.
> Use `/lookup-term` to look up standard terms.

## 1. Table Naming

### 1.1 Prefix Rules

| Prefix | Type | Example |
|--------|------|---------|
| TB_ | General table | TB_COMM_USER (User) |
| TC_ | Code table | TC_COMM_CD (Common code) |
| TH_ | History table | TH_COMM_USER_AGRE (Consent history) |
| TL_ | Log table | TL_SYS_API_LOG (API log) |
| TR_ | Relation table | TR_USER_ROLE (User-Role mapping) |

### 1.2 Table Name Pattern

`{prefix}_{module_abbr}_{entity_name}`

| Module | Abbreviation | Example Tables |
|--------|-------------|----------------|
| Common | COMM | TB_COMM_USER, TC_COMM_CD |
| Payment | PAY | TB_PAY_PLAN, TB_PAY_SBSC |
| Order | ORDR | TB_ORDR, TB_ORDR_PRDT |
| Notification | NTFC | TH_NTFC_HIST |
| System | SYS | TL_SYS_API_LOG |

## 2. Column Naming

### 2.1 Base Pattern

`{English abbreviation of Korean meaning}`

- Use abbreviations registered in the standard terminology dictionary first.
- Look up abbreviations with `/lookup-term [Korean term]`.

### 2.2 Suffix Rules

| Suffix | Usage | Example |
|--------|-------|---------|
| _ID | Identifier | USER_ID, ORDR_ID |
| _SN | Sequence number | STLM_SN |
| _NM | Name | USER_NM, PRDT_NM |
| _CD | Code | ORDR_STTS_CD, PAY_MTHD_CD |
| _AMT | Amount | STLM_AMT, ORDR_AMT |
| _QTY | Quantity | ORDR_QTY |
| _DT | Datetime | ORDR_DT, CRT_DT |
| _YN | Boolean flag | USE_YN, DEL_YN |
| _CN | Content | NTFC_CN |
| _ADDR | Address | DLVR_ADDR |
| _TELNO | Phone number | MBTLNUM |

### 2.3 Common Audit Columns

Required columns included in all tables:

| Column Name | Type | Description |
|-------------|------|-------------|
| CRTR_ID | VARCHAR(50) | Creator ID |
| CRT_DT | TIMESTAMP | Creation datetime |
| MDFR_ID | VARCHAR(50) | Modifier ID |
| MDFCN_DT | TIMESTAMP | Modification datetime |

## 3. PK/FK Naming

### 3.1 PK (Primary Key)

- Constraint name: `PK_{module_abbr}_{entity_name}`
- Example: `PK_COMM_USER`, `PK_PAY_PLAN`

### 3.2 FK (Foreign Key)

- Constraint name: `FK_{child_table_abbr}_{parent_table_abbr}`
- Column name: Use the same column name as the referenced table's PK
- Example: USER_ID in TB_ORDR → References USER_ID in TB_COMM_USER

## 4. Index Naming

- Regular index: `IDX_{table_abbr}_{column_name}`
- Unique index: `UDX_{table_abbr}_{column_name}`
- Example: `IDX_COMM_USER_EMAIL`, `UDX_COMM_USER_LOGIN_ID`

## 5. Standard Term Mapping Examples

| Korean Term | English Abbreviation | Domain | Data Type |
|-------------|---------------------|--------|-----------|
| User | USER | | |
| Settlement amount | STLM_AMT | Amount | NUMERIC |
| Order number | ORDR_NO | Number | VARCHAR |
| Order datetime | ORDR_DT | Datetime | TIMESTAMP |
| Product name | PRDT_NM | Name | VARCHAR |

> Look up the full standard term list with the `/lookup-term` command.

---

> **Update Rules**:
> 1. Add to this document when new domain terms are needed.
> 2. For terms not in the standard terminology dictionary, VA determines and registers the abbreviation.
