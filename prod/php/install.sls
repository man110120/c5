include:
  - libiconv.install
  - mhash.install
  - libmcrypt.install
pkg-php:
  pkg.installed:
    - names:
      - mysql-devel
      - openssl-devel
      - swig
      - libjpeg
      - libjpeg-devel
      - libpng
      - libpng-devel
      - freetype
      - freetype-devel
      - libxml2
      - libxml2-devel
      - zlib
      - zlib-devel
      - glibc
      - glibc-devel
      - glib2
      - glib2-devel
      - bzip2 
      - bzip2-devel 
      - ncurses 
      - ncurses-devel 
      - curl
      - curl-devel
      - e2fsprogs
      - e2fsprogs-devel
      - krb5-devel
      - libidn
      - libidn-devel
      - nss_ldap
      - openldap
      - openldap-devel
      - openldap-clients
      - openldap-servers
php-source-install:
  file.managed:
    - name: /usr/local/src/php-5.3.29.tar.gz
    - source: salt://php/files/php-5.3.29.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf php-5.3.29.tar.gz && cd php-5.3.29 && ./configure --prefix=/data/webserver/php --with-config-file-path=/data/webserver/php/etc  --with-iconv-dir=/usr/local/libiconv --with-freetype-dir --with-gettext --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir --enable-xml --disable-rpath  --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-fpm  --enable-mbstring --with-mcrypt --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-ldap --with-ldap-sasl --with-xmlrpc --enable-zip --enable-soap --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-fpm-user=www --with-fpm-group=www && make && make install
    - require:
      - file: php-source-install
    - unless: test-d /data/webserver/php
pdo-plugin:
  cmd.run:
    - name: cd /usr/local/src/php-5.3.29/ext/pdo_mysql/ && /data/webserver/php/bin/phpize && ./configure --with-php-config=/data/webserver/php/bin/php-config && make && make install
    - unless: test -f
    - require:
      - cmd: php-source-install
php-ini:
  file.managed:
    - name: /data/webserver/php/etc/php.ini
    - source: salt://php/files/php.ini-production
    - user: root
    - group: root
    - mode: 644
php-fpm:
  file.managed:
    - name: /data/webserver/php/etc/php-fpm.conf
    - source: salt://php/files/php-fpm.conf.default
    - user: root
    - group: root
    - mode: 644
php-service:
  file.managed:
    - name: /etc/init.d/php-fpm
    - source: salt://php/files/init.d.php-fpm
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: chkconfig --add php-fpm
    - unless: chkconfig --list | grep php-fpm
    - require:
      - file: php-service
  service.running:
    - name: php-fpm
    - enable: True
    - require:
      - cmd: php-service
    - watch:
      - file: php-ini
      - file: php-fpm
