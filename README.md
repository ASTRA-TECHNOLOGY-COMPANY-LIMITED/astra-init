# ASTRA Methodology

**AI-augmented Sprint Through Rapid Assembly** - Claude Code plugin for Sprint 0 project initialization, data standard enforcement, and quality gates.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Overview

ASTRA는 Claude Code 기반의 AI 강화 스프린트 방법론 플러그인입니다. 한국 공공데이터 표준(행정안전부 공통표준용어 제8차)을 기반으로 DB 네이밍 검증, 엔티티 코드 생성, 품질 게이트를 자동화합니다.

### VIP 원칙

| 원칙 | 설명 |
|------|------|
| **V**ibe-driven Development | 자연어 기반 개발 — 프롬프트로 설계하고, AI가 구현 |
| **I**nstant Feedback Loop | 작성 즉시 검증 — Hook과 Agent가 실시간 품질 확인 |
| **P**lugin-powered Quality | 플러그인 기반 품질 관리 — 자동화된 게이트로 일관성 보장 |

## Installation

### 1. 글로벌 환경 설정

```bash
# Claude Code에서 실행
/astra-global-setup
```

이 명령은 다음을 설정합니다:
- `~/.claude/settings.json` — 전역 설정 (에이전트 팀, bypass 모드 등)
- `~/.claude/.mcp.json` — MCP 서버 등록 (Chrome DevTools, PostgreSQL, Context7)
- 필수 도구 확인 (Node.js, Git, GitHub CLI)

### 2. 플러그인 설치

```bash
claude plugin add github:ASTRA-TECHNOLOGY-COMPANY-LIMITED/astra-methodology
```

### 3. 프로젝트 초기화 (Sprint 0)

```bash
# Claude Code에서 실행
/astra-init [프로젝트명] [백엔드기술] [프론트엔드기술] [DB종류]
```

## Skills (슬래시 커맨드)

| 커맨드 | 설명 |
|--------|------|
| `/astra-init` | Sprint 0 프로젝트 구조 생성 — CLAUDE.md, 디자인 시스템, DB 설계 문서, 테스트 전략 템플릿 |
| `/astra-sprint` | 새 스프린트 초기화 — 프롬프트 맵, 회고 템플릿 자동 생성 |
| `/astra-guide` | ASTRA 방법론 퀵 레퍼런스 (sprint, review, release, gates, roles) |
| `/astra-checklist` | Sprint 0 완료 검증 — 프로젝트 구조, CLAUDE.md, 디자인 토큰, DB 설계, 테스트 전략 점검 |
| `/astra-global-setup` | 글로벌 개발 환경 설정 (Step 0.0) |
| `/astra-integration-test` | Chrome MCP 기반 E2E 통합 테스트 — 서버 기동, 시나리오 실행, 리포트 생성 |
| `/data-standard` | 한국 공공데이터 표준 용어 적용 가이드 |

## Commands (데이터 표준 도구)

| 커맨드 | 설명 | 사용 예시 |
|--------|------|-----------|
| `/lookup-term` | 표준 용어 조회 | `/lookup-term 고객명` |
| `/generate-entity` | 한글 정의 → 엔티티 코드 생성 | `/generate-entity 고객 테이블: 고객명, 고객번호, 생년월일` |
| `/check-naming` | DB 네이밍 표준 준수 검사 | `/check-naming src/entity/Customer.java` |

### `/lookup-term` 예시

```
입력: /lookup-term 가입일자

결과:
┌──────────────┬─────────────┬───────────┬──────────┐
│ 표준용어명    │ 영문약어명   │ 도메인    │ 데이터타입 │
├──────────────┼─────────────┼───────────┼──────────┤
│ 가입일자      │ JOIN_YMD    │ 연월일C8  │ CHAR(8)  │
└──────────────┴─────────────┴───────────┴──────────┘
```

### `/generate-entity` 예시

```
입력: /generate-entity 고객 테이블: 고객명, 고객번호, 생년월일, 사용여부

생성 코드 (Java JPA):
@Entity
@Table(name = "TB_CSTMR")
public class TbCstmr {
    @Id @Column(name = "CSTMR_SN")
    private Long cstmrSn;

    @Column(name = "CSTMR_NM", length = 100)
    private String cstmrNm;

    @Column(name = "CSTMR_NO", length = 20)
    private String cstmrNo;

    @Column(name = "BRDT_YMD", columnDefinition = "CHAR(8)")
    private String brdtYmd;

    @Column(name = "USE_YN", columnDefinition = "CHAR(1) DEFAULT 'Y'")
    private String useYn;
}
```

## Agents

| 에이전트 | 모델 | 설명 |
|----------|------|------|
| `naming-validator` | default | DB 엔티티 네이밍 표준 검증 — 컬럼명, 접미사 패턴, 도메인 규칙, 금칙어 검출 |
| `astra-verifier` | haiku | ASTRA 방법론 준수 여부 검증 (읽기 전용) — 프로젝트 구조, CLAUDE.md, 설계 문서 점검 |

## Hooks (자동 품질 검증)

파일 작성/수정 시 자동으로 실행되는 PostToolUse 훅:

| 훅 | 트리거 | 동작 |
|----|--------|------|
| `validate-naming.sh` | Write/Edit (DB 관련 파일) | 테이블명 접두사 검증 (TB_, TC_, TH_, TL_, TR_) |
| `check-forbidden-words.sh` | Write/Edit (DB 관련 파일) | 금칙어 감지 및 표준어 대체 권장 |
| 설계 문서 알림 | Write/Edit (설계 문서) | database-design.md, blueprints 수정 시 알림 |

모든 훅은 non-blocking (exit 0) — 경고만 표시하고 작업을 중단하지 않습니다.

## Quality Gates

```
Gate 1 (작성 시)          Gate 2 (리뷰 시)         Gate 2.5 (디자인)        Gate 3 (릴리스)
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│ - 금칙어 검사    │    │ - 코드 리뷰      │    │ - 디자인 리뷰    │    │ - /check-naming  │
│ - 네이밍 검증    │    │ - PR 검토        │    │ - Chrome MCP     │    │ - 통합 테스트    │
│ - 자동 (Hook)    │    │ - 수동 + AI      │    │ - 반응형 검증    │    │ - 배포 전 검증   │
└─────────────────┘    └─────────────────┘    └─────────────────┘    └─────────────────┘
```

## Korean Public Data Standard

행정안전부 공공데이터 공통표준 제8차(2025-11) 기반:

| 데이터 | 건수 | 설명 |
|--------|------|------|
| `standard_terms.json` | 13,176건 | 표준용어 (한글명 → 영문약어 → 도메인) |
| `standard_words.json` | 3,284건 | 표준단어 (약어, 금칙어, 이음동의어) |
| `standard_domains.json` | 123건 | 표준도메인 (데이터타입, 길이, 소수점) |

### 네이밍 규칙

**테이블 접두사:**
- `TB_` — 일반 테이블
- `TC_` — 코드 테이블
- `TH_` — 이력 테이블
- `TL_` — 로그 테이블
- `TR_` — 관계 테이블

**컬럼 접미사:**

| 접미사 | 의미 | 예시 |
|--------|------|------|
| `_NM` | 명칭 | `CSTMR_NM` (고객명) |
| `_CD` | 코드 | `STTS_CD` (상태코드) |
| `_NO` | 번호 | `CSTMR_NO` (고객번호) |
| `_YMD` | 연월일 | `JOIN_YMD` (가입일자) |
| `_DT` | 일시 | `REG_DT` (등록일시) |
| `_AMT` | 금액 | `SLE_AMT` (매출금액) |
| `_CN` | 내용 | `NTIC_CN` (공지내용) |
| `_YN` | 여부 | `USE_YN` (사용여부) |
| `_SN` | 순번 | `CSTMR_SN` (고객순번) |
| `_CNT` | 건수 | `INQR_CNT` (조회건수) |
| `_ADDR` | 주소 | `BASS_ADDR` (기본주소) |

## Project Structure (생성되는 프로젝트)

`/astra-init` 실행 시 대상 프로젝트에 생성되는 구조:

```
{project}/
├── CLAUDE.md                              # 프로젝트 AI 규칙
├── .claude/settings.json                  # Claude Code 프로젝트 설정
├── docs/
│   ├── design-system/                     # 디자인 토큰, 컴포넌트, 레이아웃
│   │   └── references/                    # 디자인 참조 이미지
│   ├── blueprints/                        # 기능 설계 문서
│   ├── database/                          # DB 설계 (SSoT), 네이밍 규칙
│   │   └── migration/                     # 마이그레이션 이력
│   ├── tests/                             # 테스트 전략, 케이스, 리포트
│   │   ├── test-cases/
│   │   └── test-reports/
│   ├── prompts/                           # 스프린트 프롬프트 맵
│   ├── retrospectives/                    # 스프린트 회고
│   └── delivery/                          # 릴리스 산출물
└── src/                                   # 소스 코드
```

## Sprint Workflow

### Sprint 0 (프로젝트 셋업)

```
Step 0.0  /astra-global-setup     → 글로벌 환경 설정
Step 0.1  /astra-init             → 프로젝트 구조 생성
Step 0.2  설계 문서 작성            → 디자인 토큰, DB 설계, 테스트 전략
Step 0.3  /astra-checklist        → Sprint 0 완료 검증
```

### Sprint N (기능 개발)

```
월  Sprint Planning    → /astra-sprint N → 프롬프트 맵 작성
화  Feature Dev        → /feature-dev → 설계 → 구현 → 테스트
수  Feature Dev        → Hook 자동 검증 (금칙어, 네이밍)
목  Review             → /check-naming → 코드 리뷰 → 디자인 리뷰
금  Release            → /astra-integration-test → 배포
```

### Team Roles

| 역할 | 설명 |
|------|------|
| **VA** (Vibe Architect) | 프로젝트 비전 설계, Sprint 0 리드, 품질 게이트 관리 |
| **PE** (Prompt Engineer) | 프롬프트 맵 작성, AI 페어 프로그래밍, 코드 리뷰 |
| **DE** (Domain Expert) | 도메인 요구사항 정의, 데이터 표준 검증, 수용 테스트 |
| **DSA** (Design System Architect) | 디자인 토큰 관리, UI 일관성 검증, 반응형 테스트 |

## Repository Structure

```
astra-methodology/
├── skills/                        # 7 Claude Code skills
│   ├── astra-init/                #   Sprint 0 프로젝트 초기화
│   ├── astra-sprint/              #   새 스프린트 초기화
│   ├── astra-guide/               #   방법론 퀵 레퍼런스
│   ├── astra-checklist/           #   Sprint 0 완료 검증
│   ├── astra-global-setup/        #   글로벌 개발 환경 설정
│   ├── astra-integration-test/    #   Chrome MCP 통합 테스트
│   └── data-standard/             #   데이터 표준 적용 가이드
├── agents/                        # 2 specialized agents
│   ├── naming-validator.md        #   DB 네이밍 표준 검증
│   └── astra-verifier.md          #   ASTRA 준수 검증 (읽기 전용)
├── commands/                      # 3 slash commands
│   ├── generate-entity.md         #   /generate-entity
│   ├── check-naming.md            #   /check-naming
│   └── lookup-term.md             #   /lookup-term
├── hooks/                         # PostToolUse hooks
│   └── hooks.json
├── scripts/                       # Shell scripts
│   ├── verify-setup.sh            #   Sprint 0 검증
│   ├── init-project.sh            #   디렉토리 구조 생성
│   ├── validate-naming.sh         #   테이블명 접두사 검증
│   └── check-forbidden-words.sh   #   금칙어 감지
├── data/                          # 공공데이터 표준 사전
│   ├── standard_terms.json        #   13,176 표준용어
│   ├── standard_words.json        #   3,284 표준단어
│   └── standard_domains.json      #   123 표준도메인
├── .claude-plugin/
│   └── plugin.json                # 플러그인 매니페스트
└── CLAUDE.md                      # 프로젝트 AI 규칙
```

## Prerequisites

- [Claude Code](https://claude.com/claude-code) CLI
- Node.js 18+
- Git
- GitHub CLI (`gh`)

## License

MIT License - see [LICENSE](LICENSE) for details.

## Author

**Zeans.L** — [zeans@astravision.co.kr](mailto:zeans@astravision.co.kr)

ASTRA TECHNOLOGY COMPANY LIMITED
