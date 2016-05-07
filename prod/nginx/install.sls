include:
  - pkg.pkg-init
  - pcre.install
  - user.www
nginx-install-dir:
  cmd.run:
    - names:
      - mkdir -p /data/webserver
    - require:
      - user: www-user-group  
    - unless: test -d /data/webserver
nginx-source-install:
  file.managed:
    - name: /usr/local/src/nginx-1.8.0.tar.gz
    - source: salt://nginx/files/nginx-1.8.0.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf nginx-1.8.0.tar.gz && cd nginx-1.8.0 && ./configure --prefix=/data/webserver/nginx --user=www --group=www --with-http_stub_status_module --with-http_ssl_module --with-file-aio --with-http_dav_module --with-pcre=/usr/local/src/pcre-8.37 && make && make install && chown -R www:www /data/webserver/nginx
    - unless: test -d /data/webserver/nginx
    - require:
      - user: www-user-group
      - file: nginx-source-install
      - pkg: pkg-init
      - cmd: pcre-source-install
