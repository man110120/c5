mhash-source-install:
  file.managed:
    - name: /usr/local/src/mhash-0.9.9.9.tar.gz
    - source: salt://mhash/files/mhash-0.9.9.9.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - names:
      - cd /usr/local/src && tar zxf mhash-0.9.9.9.tar.gz && cd mhash-0.9.9.9 && ./configure && make && make install
      - ln -s /usr/local/lib/libmhash.a /usr/lib/libmhash.a
      - ln -s /usr/local/lib/libmhash.la /usr/lib/libmhash.la
      - ln -s /usr/local/lib/libmhash.so /usr/lib/libmhash.so
      - ln -s /usr/local/lib/libmhash.so.2 /usr/lib/libmhash.so.2
      - ln -s /usr/local/lib/libmhash.so.2.0.1 /usr/lib/libmhash.so.2.0.1
    - unless: test -f /usr/local/lib/libmhash.a
    - require:
      - file: mhash-source-install
