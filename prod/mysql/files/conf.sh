#!/bin/bash
/bin/chown -R mysql.mysql /data/dbserver/mysql/ && /bin/chmod +w /data/dbserver/mysql
/bin/ln -sv /data/dbserver/mysql/bin/mysql /usr/bin
/bin/ln -sv /data/dbserver/mysql/bin/mysqladmin /usr/bin/
/bin/ln -sv /data/dbserver/mysql/bin/mysqldump /usr/bin/
/data/dbserver/mysql/scripts/mysql_install_db --user=mysql --basedir=/data/dbserver/mysql/ --datadir=/data/dbserver/mysql/data/
/sbin/service mysqld start
/data/dbserver/mysql/bin/mysqladmin -u root password "songda@mysql"
/sbin/service mysqld restart
