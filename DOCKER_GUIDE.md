# Docker 사용 가이드

## 📋 사전 요구사항

- Docker 설치 (20.10 이상)
- Docker Compose 설치 (v2.0 이상)

### Docker 설치 확인
```bash
docker --version
docker-compose --version
```

---

## 🚀 빠른 시작

### 1. Docker Compose로 실행 (권장)

```bash
# 프로젝트 디렉토리로 이동
cd capstone_project

# 백그라운드에서 컨테이너 실행
docker-compose up -d

# 로그 확인
docker-compose logs -f

# 브라우저에서 확인
# http://localhost:5000
```

### 2. Docker만 사용하여 실행

```bash
# Docker 이미지 빌드
docker build -t capstone-flask-app .

# 컨테이너 실행
docker run -d -p 5000:5000 --name capstone_app capstone-flask-app

# 로그 확인
docker logs -f capstone_app
```

---

## 🛠️ Docker 명령어

### 컨테이너 관리

```bash
# 컨테이너 시작
docker-compose up -d

# 컨테이너 중지
docker-compose down

# 컨테이너 재시작
docker-compose restart

# 컨테이너 상태 확인
docker-compose ps

# 실시간 로그 보기
docker-compose logs -f web
```

### 이미지 관리

```bash
# 이미지 다시 빌드
docker-compose build

# 캐시 없이 빌드
docker-compose build --no-cache

# 이미지 목록 확인
docker images

# 사용하지 않는 이미지 삭제
docker image prune -a
```

### 컨테이너 내부 접근

```bash
# 컨테이너 내부 쉘 접속
docker-compose exec web /bin/bash

# 또는
docker exec -it capstone_flask_app /bin/bash
```

---

## 🔧 개발 모드

개발 중에는 코드 변경 시 자동으로 반영되도록 설정할 수 있습니다.

### docker-compose.override.yml 생성

```yaml
version: '3.8'

services:
  web:
    environment:
      - FLASK_ENV=development
      - FLASK_DEBUG=1
    volumes:
      - .:/app
    command: python app.py
```

이 파일을 추가하면 `docker-compose up` 실행 시 자동으로 적용됩니다.

---

## 🌐 EC2에서 실행

### 1. EC2 인스턴스 준비

```bash
# Docker 설치 (Ubuntu 기준)
sudo apt-get update
sudo apt-get install -y docker.io docker-compose

# Docker 서비스 시작
sudo systemctl start docker
sudo systemctl enable docker

# 현재 사용자를 docker 그룹에 추가
sudo usermod -aG docker $USER
newgrp docker
```

### 2. 프로젝트 배포

```bash
# Git으로 프로젝트 클론 (또는 파일 업로드)
git clone <your-repository-url>
cd capstone_project

# Docker Compose로 실행
docker-compose up -d
```

### 3. 보안 그룹 설정

EC2 보안 그룹에서 다음 포트를 열어야 합니다:
- **Inbound Rule**: TCP 5000 (또는 80으로 변경 가능)
- **Source**: 0.0.0.0/0 (모든 IP) 또는 특정 IP 범위

### 4. 접속 확인

```bash
# EC2 퍼블릭 IP 확인
curl ifconfig.me

# 브라우저에서 접속
# http://<EC2-PUBLIC-IP>:5000
```

---

## ⚙️ 포트 변경

기본 포트(5000)를 변경하려면 `docker-compose.yml`을 수정하세요:

```yaml
services:
  web:
    ports:
      - "80:5000"  # 호스트:컨테이너
```

이렇게 하면 http://localhost 또는 http://<EC2-IP>로 접속할 수 있습니다.

---

## 🧹 정리

```bash
# 컨테이너 중지 및 삭제
docker-compose down

# 볼륨까지 삭제
docker-compose down -v

# 이미지도 함께 삭제
docker-compose down --rmi all

# 전체 시스템 정리 (주의!)
docker system prune -a
```

---

## 📊 리소스 모니터링

```bash
# 컨테이너 리소스 사용량 확인
docker stats capstone_flask_app

# 또는
docker-compose stats
```

---

## 🐛 문제 해결

### 포트가 이미 사용 중일 때

```bash
# 5000 포트 사용 중인 프로세스 확인
lsof -i :5000

# 또는
netstat -tuln | grep 5000

# 프로세스 종료
kill -9 <PID>
```

### 컨테이너가 시작되지 않을 때

```bash
# 로그 확인
docker-compose logs web

# 컨테이너 재빌드
docker-compose build --no-cache
docker-compose up -d
```

### 권한 문제

```bash
# Docker를 sudo 없이 실행하려면
sudo usermod -aG docker $USER
newgrp docker
```

---

## 📝 참고사항

- 프로덕션 환경에서는 Gunicorn 또는 uWSGI 같은 WSGI 서버 사용 권장
- HTTPS 설정이 필요한 경우 Nginx 리버스 프록시 사용 고려
- 환경 변수는 `.env` 파일로 관리 가능

---

## 🔗 추가 리소스

- [Docker 공식 문서](https://docs.docker.com/)
- [Docker Compose 문서](https://docs.docker.com/compose/)
- [Flask 배포 가이드](https://flask.palletsprojects.com/en/3.0.x/deploying/)
