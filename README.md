# 수집형 모바일 턴제 RPG 게임

Flask 기반 프로젝트 소개 웹 (EC2 + Docker, 또는 로컬)  
본 저장소는 캡스톤 프로젝트 단일 소개 페이지이며 API를 제공합니다.

## 1. 작품주제(Subject)

- 제목: 수집형 모바일 턴제 RPG 게임
- 요약: 다양한 캐릭터를 수집하고 육성하여 전략적인 턴제 전투를 즐기는 모바일 RPG 게임

## 2. 실용적 근거(Rationale)

- 문제: 기존 수집형 모바일 게임들의 단순 반복 플레이와 전략성 부족
- 근거(사회적/기술적/시장): 
  - 모바일 게임 시장 지속 성장 및 수집형 RPG 인기
  - Unity 엔진과 UGS를 활용한 안정적 멀티플레이어 환경 구축 가능
- 기대 가치: 전략적 요소 강화로 차별화된 게임 경험 제공 및 멀티플랫폼 지원

## 3. 핵심기능(Features)

- 기능 1: 캐릭터 수집 시스템 (가챠/소환)
- 기능 2: 전략적 턴제 전투 (스킬 조합, 속성 상성)
- 기능 3: 캐릭터 육성 시스템 (레벨업, 장비 강화, 스킬 업그레이드)
- 기능 4: AI 기반 적 전투 시스템 (PvE)
- 기능 5: 멀티플레이어 PvP (비동기 대전, 랭킹)

## 4. 구현환경(Environment)

- Front-End(프론트엔드): HTML5, CSS3, Jinja2
- Back-End(백엔드): Flask, JSON 데이터 관리
- Runtime(런타임): Python 3.x
- Deploy(배포): Docker Compose / AWS EC2 / (선택) AWS ECS

**실제 게임 개발 환경**
- 언어: C# 10.0
- 프레임워크: Unity 2022 LTS, Unity Gaming Services
- DB: Unity Cloud Save, Redis
- 배포: Google Play Console, Apple App Store Connect
- 도구: Git, GitHub, Visual Studio 2022, Spine

## 5. 팀원 구성 및 역할(Team)

- 이어진 - 팀장 / 서버 사이드 개발자
- 신우철 - 게임 시스템 개발자
- 홍요아 - 전투 시스템 개발자

협업: GitHub 버전 관리, 카카오워크 소통, 주 2회 회의

## 6. 실행 방법(Run)

```bash
docker compose up --build -d
# http://localhost:포트번호 < 프로젝트명 맞는 포트 또는 배포된 public IP >
```

## API 엔드포인트

- `GET /api/subject` - 작품 주제 정보
- `GET /api/rationale` - 실용적 근거
- `GET /api/features` - 핵심 기능
- `GET /api/environment` - 구현 환경
- `GET /api/team` - 팀 구성
- `GET /api/all` - 전체 데이터
