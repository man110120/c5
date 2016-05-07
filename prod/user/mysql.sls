mysql-user-group:
  user.present:
    - name: mysql
    - shell: /sbin/nologin
