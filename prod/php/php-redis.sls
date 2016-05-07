redis-plugin:
  file.managed:
    - name: /usr/local/src/redis-2.2.7.tgz
    - source: salt://php/files/redis-2.2.7.tgz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf redis-2.2.7.tgz && cd redis-2.2.7 && /data/webserver/php/bin/phpize && ./configure --with-php-config=/data/webserver/php/bin/php-config && make && make install
    - unless: test -f /data/webserver/php/lib/php/extensions/*/redis.so
  require:
    - file: redis-plugin
    - cmd: php-source-install
/data/webserver/php/etc/php.ini:
  file.append:
    - text:
      - extension=redis.so
