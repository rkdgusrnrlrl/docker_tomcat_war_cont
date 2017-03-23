#!/bin/bash
echo "Docker 빌드를 시작합니다."

#변수들 설정
DIR=$(pwd)
IMAGE_NAME="tomcat_war"
IMAGE_VER="0.5"
CONT_NAME="tomcat_war_cont"

REAL_PORT=8000
CONTAINER_PORT=8080


# war 파일이 하나 뿐인지 체크 그렇지 않으면 바로 종료
if [ $(ls | grep .war | wc -l) -gt 1 ]
then
	echo "war 파일이 두개이상있음"
	exit 1
fi

# war 파일 명을 ROOT.war 로 변경
ls | grep .war | xargs -i mv {} ROOT.war

#Dockerfile 로 Docker 이미지 빌드 해당 버전이 있다면, 빌드 하지 않음
if [[ "$(docker images -q $IMAGE_NAME:$IMAGE_VER 2> /dev/null)" == "" ]]; then
	docker build -t $IMAGE_NAME:$IMAGE_VER .
fi

#Docker 컨테이너가 있다면 삭제 
if [[ "$(docker ps -a | grep $CONT_NAME 2> /dev/null)" != "" ]]; then
	docker rm -f $CONT_NAME
fi

#Docker 컨테이너를 올림
docker run -itd --name $CONT_NAME -p $REAL_PORT:$CONTAINER_PORT $IMAGE_NAME:$IMAGE_VER bash


