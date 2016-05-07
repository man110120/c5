include:
  - nginx.install
nginx-init:
  file.managed:
    - name: /etc/init.d/nginx
    - source: salt://nginx/files/nginx-init
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: chkconfig --add nginx
    - unless: chkconfig --list | grep nginx
    - require:
      - file: nginx-init
/data/webserver/nginx/conf/nginx.conf:
  file.managed:
    - name: /data/webserver/nginx/conf/nginx.conf
    - source: salt://nginx/files/nginx.conf
    - user: www
    - group: www
    - mode: 644
nginx-service:
  file.directory:
    - name: /data/webserver/nginx/conf/vhost
    - require:
      - cmd: nginx-source-install
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - require:
      - cmd: nginx-init
    - watch:
      - file: /data/webserver/nginx/conf/nginx.conf 
