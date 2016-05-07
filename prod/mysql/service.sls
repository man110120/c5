include:
  - mysql.install
/data/dbserver/mysql/my.cnf:
  file.managed:
    - name: /data/dbserver/mysql/my.cnf
    - source: salt://mysql/files/my.cnf
    - mode: 755
    - user: mysql
    - group: mysql
mysql.server:
  file.managed:
    - name: /etc/init.d/mysqld
    - source: salt://mysql/files/mysqld
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - names:
      - /sbin/chkconfig --add mysqld
      - /sbin/chkconfig --level 345 mysqld on
    - unless: /sbin/chkconfig --list | grep mysqld
    - require:
      - file: mysql.server
/usr/local/src/conf.sh:
  cmd.script:
  - source: salt://mysql/files/conf.sh
  - user: root
  - env:
    - BATCH: 'yes'
  - require:
    - cmd: mysql-source-install
  - unless: test -e /usr/bin/mysqladmin 
 

mysql-service:
  service.running:
    - name: mysqld
    - enable: True
    - reload: True
    - require:
      - cmd: mysql.server
    - watch:
      - file: /data/dbserver/mysql/my.cnf
