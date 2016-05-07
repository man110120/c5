base:
  '*':
    - init.env_init
prod:
  ha:
    - match: nodegroup
    - cluster.haproxy-outside
    - cluster.haproxy-outside-keepalived
  web:
    - match: nodegroup
    - php.install
    - nginx.service
  'xen005':
    - memcached.service
