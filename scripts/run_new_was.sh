# run_new_was.sh

#!/bin/bash

source ~/.bash_profile

REPOSITORY=/home/ubuntu/app

JAR_NAME=$(ls -tr $REPOSITORY/*SNAPSHOT.jar | tail -n 1)

CURRENT_PORT=$(cat /home/ubuntu/service_url.inc | grep -Po '[0-9]+' | tail -1)
TARGET_PORT=0

echo "> Current port of running WAS is ${CURRENT_PORT}."

if [ ${CURRENT_PORT} -eq 8081 ]; then
  TARGET_PORT=8082
elif [ ${CURRENT_PORT} -eq 8082 ]; then
  TARGET_PORT=8081
else
  echo "> No WAS is connected to nginx"
fi

TARGET_PID=$(lsof -Fp -i TCP:${TARGET_PORT} | grep -Po 'p[0-9]+' | grep -Po '[0-9]+')

if [ ! -z ${TARGET_PID} ]; then
  echo "> Kill WAS running at ${TARGET_PORT}."
  sudo kill ${TARGET_PID}
fi

#sudo chmod +x $JAR_NAME
sudo chmod +x /home/ubuntu/app/nohup.out

nohup java -jar \
        -Dserver.port=${TARGET_PORT} \
        -Dspring.profiles.active=prod \
        $JAR_NAME >> /home/ubuntu/app/nohup.out 2>&1 &
echo "> Now new WAS runs at ${TARGET_PORT}."
sleep 10s
exit 0
