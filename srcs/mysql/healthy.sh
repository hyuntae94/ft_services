pgrep mysql 
m=$?
pgrep telegraf
t=$?

if [ $m -eq 0 -a $t -eq 0 ];
then
  exit 0
else
  exit 1
fi
