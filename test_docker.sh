#!/bin/bash

echo "================================"
echo "   Docker 환경 테스트 스크립트"
echo "================================"
echo ""

# 색상 정의
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Docker 설치 확인
echo "1. Docker 설치 확인..."
if command -v docker &> /dev/null; then
    echo -e "${GREEN}✓ Docker 설치됨${NC}"
    docker --version
else
    echo -e "${RED}✗ Docker가 설치되지 않았습니다${NC}"
    echo "설치 방법: https://docs.docker.com/get-docker/"
    exit 1
fi

echo ""

# Docker Compose 설치 확인
echo "2. Docker Compose 설치 확인..."
if command -v docker-compose &> /dev/null; then
    echo -e "${GREEN}✓ Docker Compose 설치됨${NC}"
    docker-compose --version
else
    echo -e "${RED}✗ Docker Compose가 설치되지 않았습니다${NC}"
    echo "설치 방법: https://docs.docker.com/compose/install/"
    exit 1
fi

echo ""

# Docker 이미지 빌드
echo "3. Docker 이미지 빌드 중..."
if docker-compose build; then
    echo -e "${GREEN}✓ 이미지 빌드 성공${NC}"
else
    echo -e "${RED}✗ 이미지 빌드 실패${NC}"
    exit 1
fi

echo ""

# 컨테이너 실행
echo "4. 컨테이너 시작 중..."
if docker-compose up -d; then
    echo -e "${GREEN}✓ 컨테이너 시작 성공${NC}"
else
    echo -e "${RED}✗ 컨테이너 시작 실패${NC}"
    exit 1
fi

echo ""

# 컨테이너 상태 확인
echo "5. 컨테이너 상태 확인..."
sleep 3
docker-compose ps

echo ""

# 애플리케이션 접속 테스트
echo "6. 애플리케이션 접속 테스트..."
sleep 2
if curl -s http://localhost:5000 > /dev/null; then
    echo -e "${GREEN}✓ 애플리케이션 정상 작동${NC}"
    echo ""
    echo -e "${YELLOW}브라우저에서 확인하세요: http://localhost:5000${NC}"
else
    echo -e "${RED}✗ 애플리케이션 접속 실패${NC}"
    echo "로그 확인: docker-compose logs web"
fi

echo ""
echo "================================"
echo "   테스트 완료"
echo "================================"
echo ""
echo "유용한 명령어:"
echo "  - 로그 보기: docker-compose logs -f"
echo "  - 컨테이너 중지: docker-compose down"
echo "  - 컨테이너 재시작: docker-compose restart"
echo ""
