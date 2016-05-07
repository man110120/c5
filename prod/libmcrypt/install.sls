libmcrypt-source-install:
  file.managed:
    - name: /usr/local/src/libmcrypt-2.5.8.tar.gz
    - source: salt://libmcrypt/files/libmcrypt-2.5.8.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - names:
      - cd /usr/local/src && tar zxf libmcrypt-2.5.8.tar.gz && cd libmcrypt-2.5.8 && ./configure && make && make install && /sbin/ldconfig && cd libltdl/ && ./configure --enable-ltdl-install && make && make install 
      - ln -s /usr/local/lib/libmcrypt.la /usr/lib/libmcrypt.la
      - ln -s /usr/local/lib/libmcrypt.so /usr/lib/libmcrypt.so
      - ln -s /usr/local/lib/libmcrypt.so.4 /usr/lib/libmcrypt.so.4
      - ln -s /usr/local/lib/libmcrypt.so.4.4.8 /usr/lib/libmcrypt.so.4.4.8
      - ln -s /usr/local/bin/libmcrypt-config /usr/bin/libmcrypt-config
    - unless: test -f /usr/local/lib/libmcrypt.so
    - require:
      - file: libmcrypt-source-install
mcrypt-source-install:
  file.managed:
    - name : /usr/local/src/mcrypt-2.6.8.tar.gz
    - source: salt://libmcrypt/files/mcrypt-2.6.8.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src && tar zxf mcrypt-2.6.8.tar.gz && cd mcrypt-2.6.8 && LD_LIBRARY_PATH=/usr/local/lib && ./configure && make && make install
    - unless: test -d /usr/local/src/mcrypt-2.6.8
    - require:
      - file: mcrypt-source-install
