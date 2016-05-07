memcache-plugin:
  file.managed:
    - name: /usr/local/src/memcache-2.2.7.tgz
    - source: salt://php/files/memcache-2.2.7.tgz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf memcache-2.2.7.tgz && cd memcache-2.2.7 && /data/webserver/php/bin/phpize && ./configure --enable-memcache --with-php-config=/data/webserver/php/bin/php-config && make && make install
    - unless: test -f /data/webserver/php/lib/php/extensions/*/memcache.so
  require:
    - file: memcache-plugin
    - cmd: php-install

/data/webserver/php/etc/php.ini:
  file.append:
    - text:
      - extension=memcache.so
