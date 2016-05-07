include:
  - pkg.pkg-init
cmake-source-install:
  file.managed:
    - name: /usr/local/src/cmake-2.8.4.tar.gz
    - source: salt://cmake/files/cmake-2.8.4.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf cmake-2.8.4.tar.gz && cd cmake-2.8.4 && ./bootstrap && make && make install
    - unless: test -e /usr/local/bin/cmake
    - require:
      - file: cmake-source-install
      - pkg: pkg-init 
