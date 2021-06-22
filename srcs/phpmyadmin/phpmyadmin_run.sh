wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
tar -xf phpMyAdmin-5.0.2-all-languages.tar.gz
mv phpMyAdmin-5.0.2-all-languages/* /www/
rm phpMyAdmin-5.0.2-all-languages.tar.gz

mv config.inc.php www/config.inc.php

supervisord -c /etc/supervisord.conf
