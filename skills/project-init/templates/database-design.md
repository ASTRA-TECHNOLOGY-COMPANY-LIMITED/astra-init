# Database Design Document

> **Single Source of Truth**: All table designs are managed centrally in this document.
> Do not scatter table DDL across feature-specific design documents.

## 1. Overall ERD

```
[Draw the module-level table relationship diagram here]

Example:
TB_COMM_USER ──┬── TH_COMM_USER_AGRE ── TB_COMM_TRMS
               │
               ├── TB_PAY_SBSC ── TB_PAY_PLAN
               │
               └── TB_ORDR ── TB_ORDR_PRDT
```

## 2. Common Rules

### 2.1 Table Prefixes

| Prefix | Type | Example |
|--------|------|---------|
| TB_ | General table | TB_COMM_USER (User) |
| TC_ | Code table | TC_COMM_CD (Common code) |
| TH_ | History table | TH_COMM_USER_AGRE (Consent history) |
| TL_ | Log table | TL_SYS_API_LOG (API log) |
| TR_ | Relation table | TR_USER_ROLE (User-Role mapping) |

### 2.2 Common Audit Columns

All tables include the following columns:

| Column Name | Type | Description | Notes |
|-------------|------|-------------|-------|
| CRTR_ID | VARCHAR(50) | Creator ID | NOT NULL |
| CRT_DT | TIMESTAMP | Creation datetime | NOT NULL, DEFAULT CURRENT_TIMESTAMP |
| MDFR_ID | VARCHAR(50) | Modifier ID | NULL allowed |
| MDFCN_DT | TIMESTAMP | Modification datetime | NULL allowed |

### 2.3 Naming Rules

- **Table name**: `{prefix}_{module_abbr}_{entity_name}` (e.g., TB_COMM_USER)
- **Column name**: `{English abbreviation of Korean meaning}` (e.g., USER_NM, TELNO, STLM_AMT)
- **PK**: `{entity}_ID` or `{entity}_SN` (sequence number)
- **FK**: Use the same column name as the referenced table's PK
- **Status code**: `{target}_STTS_CD` (e.g., ORDR_STTS_CD)
- **Code value**: `{meaning}_CD` (e.g., PAY_MTHD_CD)
- **Amount**: `{meaning}_AMT` (e.g., STLM_AMT)
- **Quantity**: `{meaning}_QTY` (e.g., ORDR_QTY)
- **Datetime**: `{meaning}_DT` (e.g., ORDR_DT)
- **Boolean flag**: `{meaning}_YN` (e.g., USE_YN)

> Follows the public data standard terminology dictionary. Use `/lookup-term` to look up terms.

## 3. Module Tables

### 3.1 Common Module (COMM)

#### TB_COMM_USER (User)

| Column Name | Type | PK | FK | NULL | Description |
|-------------|------|----|----|------|-------------|
| USER_ID | VARCHAR(50) | PK | | NOT NULL | User ID |
| ... | | | | | |

```sql
-- DDL
CREATE TABLE TB_COMM_USER (
    USER_ID VARCHAR(50) NOT NULL,
    -- ...
    CRTR_ID VARCHAR(50) NOT NULL,
    CRT_DT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MDFR_ID VARCHAR(50),
    MDFCN_DT TIMESTAMP,
    CONSTRAINT PK_COMM_USER PRIMARY KEY (USER_ID)
);
```

### 3.2 {Module Name} ({Abbreviation})

> When developing features, use `/feature-dev` to add tables to this section.

## 4. Enum/Code Value Definitions

| Code Type | Code Value | Description |
|-----------|-----------|-------------|
| | | |

## 5. FK Relationship Summary Between Tables

| FK Name | Child Table | Child Column | Parent Table | Parent Column | ON DELETE |
|---------|-------------|-------------|--------------|--------------|-----------|
| | | | | | |

---

> **Update Rules**:
> 1. When developing a new feature, add the table to this document first.
> 2. Verify compliance with the standard terminology dictionary using `/lookup-term`.
> 3. VA reviews and then proceeds with code implementation.
