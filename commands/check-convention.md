---
description: 코드의 코딩 컨벤션 준수 여부를 검사하고 위반 사항을 보고합니다
argument-hint: "<파일경로 또는 디렉토리>"
allowed-tools: Read, Glob, Grep
---

# 코딩 컨벤션 검사

$ARGUMENTS 에 대해 코딩 컨벤션 준수 여부를 검사하라.

> 심층 분석이 필요하면 `convention-checker` 에이전트를 사용할 수 있다.

## 검사 절차

1. 대상 파일을 읽고 확장자로 언어를 판별한다
2. 해당 언어의 코딩 컨벤션 참조 문서를 확인한다
3. 아래 항목을 순서대로 검사한다

## 언어 판별 및 참조 문서

| 확장자 | 언어 | 참조 문서 |
|---|---|---|
| `.java` | Java | `skills/coding-convention/java-coding-convention.md` |
| `.ts`, `.tsx` | TypeScript | `skills/coding-convention/typescript-coding-convention.md` |
| `.py` | Python | `skills/coding-convention/python-coding-convention.md` |
| `.css`, `.scss`, `.sass` | CSS/SCSS | `skills/coding-convention/css-scss-coding-convention.md` |

검사 전 해당 언어의 참조 문서를 반드시 읽어 상세 규칙을 확인한다.

## 검사 항목

### 공통
- [ ] 파일 인코딩 (UTF-8)
- [ ] 줄 길이 제한 준수 (Java: 100자, TypeScript: Prettier, Python: 79자, CSS/SCSS: 80자)
- [ ] 들여쓰기 규칙 (Java: 2스페이스, Python: 4스페이스, CSS/SCSS: 2스페이스)
- [ ] import 순서 및 와일드카드 사용 여부
- [ ] 네이밍 컨벤션 (클래스, 메서드, 변수, 상수)

### Java 전용 (Google Java Style Guide)
- [ ] K&R 중괄호 스타일 (여는 중괄호 같은 줄)
- [ ] 단일 문장 본문에도 중괄호 사용
- [ ] @Override 어노테이션 사용 여부
- [ ] Javadoc 작성 여부 (public/protected 멤버)
- [ ] static 멤버 접근 방식 (클래스명으로만)
- [ ] 배열 선언 스타일 (`String[] args`)
- [ ] long 리터럴 대문자 L 접미사
- [ ] 예외 무시 금지

### TypeScript 전용 (Google TypeScript Style Guide)
- [ ] `export default` 사용 여부 (금지)
- [ ] `any` 타입 사용 여부 (금지 → `unknown`)
- [ ] `var` 사용 여부 (금지 → `const`/`let`)
- [ ] `.forEach()` 사용 여부 (금지 → `for...of`)
- [ ] `const enum` 사용 여부 (금지)
- [ ] `===` / `!==` 사용 여부 (`==`/`!=` 금지, `== null` 예외)
- [ ] 세미콜론 누락 여부
- [ ] `namespace` 사용 여부 (금지)
- [ ] `import type` 사용 여부
- [ ] 파일명 snake_case 여부

### Python 전용 (PEP 8)
- [ ] PEP 8 네이밍 (snake_case 함수/변수, CapWords 클래스)
- [ ] `is None` / `is not None` 사용 여부 (`== None` 금지)
- [ ] `isinstance()` 사용 여부 (`type()` 비교 금지)
- [ ] `with` 문 사용 여부 (리소스 관리)
- [ ] 빈 시퀀스 체크 (`if not seq:` 사용, `if len(seq):` 금지)
- [ ] bare `except:` 사용 여부 (금지 → 구체적 예외 타입)
- [ ] lambda 할당 여부 (금지)
- [ ] 독스트링 작성 여부 (삼중 큰따옴표)

### CSS/SCSS 전용 (CSS Guidelines + Sass Guidelines)
- [ ] BEM 네이밍 (`block__element--modifier`)
- [ ] ID 선택자 사용 여부 (금지)
- [ ] 네스팅 깊이 (최대 3레벨)
- [ ] 속성 순서 (Positioning → Box Model → Typography → Visual → Animation)
- [ ] 색상 표기 (소문자 hex, 키워드 금지)
- [ ] 단위 규칙 (폰트 `rem`, 0에 단위 금지)
- [ ] `!important` 남용 여부 (유틸리티 클래스에만 허용)
- [ ] 미디어 쿼리 방식 (모바일 퍼스트 `min-width`)
- [ ] `@extend` 사용 여부 (자제, `%placeholder`만)
- [ ] `transition: all` 사용 여부 (금지)
- [ ] 타입 한정 선택자 (`div.class` 금지)
- [ ] SCSS 변수 네이밍 (`$kebab-case`)

## 출력 형식

위반 사항을 아래 형식으로 보고하라:

| 심각도 | 카테고리 | 파일:라인 | 규칙 | 현재 코드 | 수정 제안 |
|---|---|---|---|---|---|
| Error | 금지패턴 | ... | ... | ... | ... |
| Warning | 네이밍 | ... | ... | ... | ... |
| Info | 포맷팅 | ... | ... | ... | ... |

심각도 기준:
- **Error**: 금지 패턴 위반 (var, any, export default, == None, bare except, ID 선택자, `!important` 남용 등)
- **Warning**: 컨벤션 불일치 (네이밍, 줄 길이, 들여쓰기, 속성 순서 등)
- **Info**: 개선 권장 (Javadoc 누락, 독스트링 미작성, BEM 불일치 등)

마지막에 총 위반 건수와 심각도별/카테고리별 요약을 보고하라.
