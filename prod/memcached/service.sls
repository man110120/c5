include:
  - memcached.install
  - user.www
memcached-service:
  cmd.run:
    - name: /usr/local/memcached/bin/memcached -d -m 512 -p 11211 -c 2048 -u www
    - unless: netstat -nltp | grep 11211
    - require:
      - cmd: memcached-source-install
      - user: www-user-group

