include:
  - user.java-user

jdk-source-install:
  file.managed:
    - name: /usr/local/src/jdk-6u43-linux-x64.bin
    - source: salt://jdk/files/jdk-6u43-linux-x64.bin
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: 
      - cd /usr/local/src && /bin/chmod +x jdk-6u43-linux-x64.bin && /usr/local/src/jdk-6u43-linux-x64.bin && /bin/mv /usr/local/src/jdk1.6.0_43 /data/java 
    - unless: test -d /data/java
/etc/profile:
  file.append:
    - text: "export JAVA_HOME=/data/java"
    - text: "export PATH=${JAVA_HOME}/bin:${PATH}"
    - text: "export CLASSPATH=$CLASSPATH:${JAVA_HOME}/lib/dt.jar:$CLASSPATH:${JAVA_HOME}/lib/tools.jar"
  cmd.run:
    - name:
      - /bin/bash source /etc/profile
  require:
    - file: jdk-source-install
      
tomcat0-source-install:
  file.managed:
    - name: /data/sdplat/apache-tomcat-6.0.28.tar.gz
    - source: salt://jdk/files/apache-tomcat-6.0.28.tar.gz
    - user: sdplat
    - group: sdplat
    - mode: 755
  cmd.run:
    - name:
      - cd /data/sdplat && tar zxvf apache-tomcat-6.0.28.tar.gz
    - unless: test -d /data/sdplat/apache-tomcat-6.0.28
  require:
    - file: tomcat0-source-install
    - user: sdplat-user-group
tomcat1-source-install:
  file.managed:
    - name: /data/sdrop/apache-tomcat-6.0.28.tar.gz
    - source: salt://jdk/files/apache-tomcat-6.0.28.tar.gz
    - user: sdrop
    - group: sdrop
    - mode: 755
  cmd.run:
    - name:
      - cd /data/sdrop && tar zxvf apache-tomcat-6.0.28.tar.gz
    - unless: test -d /data/sdrop/apache-tomcat-6.0.28
  require:
    - file: tomcat1-source-install
    - user: sdrop-user-group
tomcat2-source-install:
  file.managed:
    - name: /data/dzsb/apache-tomcat-6.0.28.tar.gz
    - source: salt://jdk/files/apache-tomcat-6.0.28.tar.gz
    - user: dzsb
    - group: dzsb
    - mode: 755
  cmd.run:
    - name:
      - cd /data/dzsb && tar zxvf apache-tomcat-6.0.28.tar.gz
    - unless: test -d /data/dzsb/apache-tomcat-6.0.28
  require:
    - file: tomcat2-source-install
    - user: dzsb-user-group
tomcat3-source-install:
  file.managed:
    - name: /data/bbt/apache-tomcat-6.0.28.tar.gz
    - source: salt://jdk/files/apache-tomcat-6.0.28.tar.gz
    - user: bbt
    - group: bbt
    - mode: 755
  cmd.run:
    - name:
      - cd /data/bbt && tar zxvf apache-tomcat-6.0.28.tar.gz
    - unless: test -d /data/bbt/apache-tomcat-6.0.28
  require:
    - file: tomcat3-source-install
    - user: bbt-user-group
