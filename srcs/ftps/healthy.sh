pgrep vsftpd
m=$?
pgrep telegraf
t=$?

if [ $m -eq 0 -a $t -eq 0 ];
then
  exit 0
else
  exit 1
fi


# Liveness probe : pod 의 상태를 확인 쿠버네티스의 방법 (yaml)
# 상태가 잘못되면 이 파일을 실행