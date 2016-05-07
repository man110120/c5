include:
  - cmake.install
  - user.mysql

mysql-source-install:
  file.managed:
    - name: /usr/local/src/mysql-5.6.28.tar.gz
    - source: salt://mysql/files/mysql-5.6.28.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - names: 
      - mkdir -p /data/dbserver
      - cd /usr/local/src && tar zxf mysql-5.6.28.tar.gz && cd mysql-5.6.28/ && /usr/local/bin/cmake -DCMAKE_INSTALL_PREFIX=/data/dbserver/mysql -DMYSQL_UNIX_ADDR=/data/dbserver/mysql/mysql.sock -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_EXTRA_CHARSETS:STRING=utf8,gbk,gb2312 -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DENABLED_LOCAL_INFILE=1 -DMYSQL_DATADIR=/data/dbserver/mysql/data -DMYSQL_USER=mysql -DWITH_DEBUG=0 && make && make install
    - unless: test -d /data/dbserver/mysql
    - require:
      - user: mysql-user-group
      - file: mysql-source-install
      - pkg: pkg-init
      - cmd: cmake-source-install
