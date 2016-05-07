include:
  - libevent.install
memcached-source-install:
  file.managed:
    - name: /usr/local/src/memcached-1.4.24.tar.gz
    - source: salt://memcached/files/memcached-1.4.24.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - names:
      - cd /usr/local/src && tar zxf memcached-1.4.24.tar.gz && cd memcached-1.4.24 && ./configure --prefix=/usr/local/memcached --enable-64bit --with-libevent=/usr/local/libevent && make
      - cd /usr/local/src/memcached-1.4.24 && sed -i 's/\-Werror//g' Makefile && make install
    - unless: test -d /usr/local/memcached
    - require:
      - cmd: libevent-source-install
      - file: memcached-source-install


  
