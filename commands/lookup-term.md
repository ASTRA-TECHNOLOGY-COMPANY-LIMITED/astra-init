---
description: Looks up English abbreviation, domain, and data type for a Korean term from the standard term dictionary
argument-hint: "<Korean term> (e.g., 고객명, 등록일시, 사업자등록번호)"
allowed-tools: Read
---

# Standard Term Lookup

Look up the standard term corresponding to "$ARGUMENTS".

## Reference Data

| File | Content | Purpose |
|---|---|---|
| `data/standard_terms.json` | 13,176 standard terms | Korean term name -> English abbreviation, domain, type |
| `data/standard_words.json` | 3,284 standard words | Individual word abbreviation, combination suggestions |
| `data/standard_domains.json` | 123 standard domains | Type/length details per domain |

## Lookup Procedure

1. Search the `공통표준용어명` field in `data/standard_terms.json`
2. If an exact match is found, output the detailed information
3. If no exact match, show up to 10 partial match results
4. If no term is found, search individual words in `data/standard_words.json` and suggest combinations

## Output Format

### Exact Match Found

| Item | Value |
|---|---|
| **Standard Term Name** | (Korean term name) |
| **English Abbreviation** | (physical column name) |
| **Term Description** | (description) |
| **Domain** | (domain name) |
| **Data Type** | (type + length) |
| **Storage Format** | (format) |
| **Display Format** | (screen format) |
| **Allowed Values** | (if applicable) |
| **Synonyms** | (if applicable) |

### Type Mapping by Language

| Language | Type | Notes |
|---|---|---|
| Java | (Java type + JPA annotation) | |
| TypeScript | (TS type) | |
| Python | (Python type) | |

### Partial Match Found

Display partial match results in a table:

| # | Term Name | English Abbreviation | Domain |
|---|---|---|---|
| 1 | ... | ... | ... |

### No Term Found

Suggest by combining individual words:

"The entered term is not found in the standard term dictionary. The following is suggested based on individual word combinations:"

| Korean Word | English Abbreviation | Notes |
|---|---|---|
| ... | ... | ... |

**Suggested Column Name**: (combined English abbreviation)
