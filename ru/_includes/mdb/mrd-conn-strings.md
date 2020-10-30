{% list tabs %}

- Bash

  **Перед подключением установите зависимости:**
  
  ```bash
  sudo apt update && sudo apt install -y redis-tools
  ```
  
  **Подключение с помощью Sentinel:**
  
  1. Получите адрес хоста-мастера, используя Sentinel и любой хост {{ RD }}:
     
     ```bash
     redis-cli -h <FQDN любого хоста {{ RD }}> -p 26379 sentinel get-master-addr-by-name <имя кластера {{ RD }}> | head -n 1
     ```
   
  1. Подключитесь к хосту с этим адресом:
        
     ```bash
     redis-cli -с -h <адрес хоста-мастера {{ RD }}> -a <пароль {{ RD }}>
     ```
  
  **Подключение напрямую к мастеру:**
  
  ```bash
  redis-cli -c -h  <FQDN хоста-мастера {{ RD }}> -a <пароль>
  ```
  
  После подключения к кластеру выполните команды:
  1. `SET foo bar`
  1. `GET foo`

- Python

  **Перед подключением установите зависимости:**

  ```bash
  sudo apt update && sudo apt install -y python3 python3-pip && \
  pip3 install redis
  ```

  **Пример кода для подключения с помощью Sentinel:**

  `connect.py`
  ```python
  from redis.sentinel import Sentinel

  sentinels = ['<FQDN хоста 1 {{ RD }}>',
           ...
           '<FQDN хоста N {{ RD }}>']
  name = '<имя кластера {{ RD }}>'
  pwd = '<пароль>'
  
  sentinel = Sentinel([(h, 26379) for h in sentinels], socket_timeout=0.1)
  master = sentinel.master_for(name, password=pwd)
  slave = sentinel.slave_for(name, password=pwd)

  master.set('foo', 'bar')
  print(slave.get('foo'))
  ```
  
  **Пример кода для подключения напрямую к мастеру:**

  `connect.py`
  ```python
  import redis

  r = redis.StrictRedis(
  host='<FQDN хоста-мастера {{ RD }}>',
  port=6379,
  password='<пароль>',
  )

  r.set('foo', 'bar')
  print(r.get('foo'))
  ```

  **Подключение:**
  
  ```bash
  python3 connect.py
  ```

- PHP

  **Перед подключением установите зависимости:**
  
  ```
  sudo apt update && sudo apt install -y php php-dev php-pear && \
  sudo pear channel-discover pear.nrk.io && \
  sudo pear install nrk/Predis
  ```

  **Пример кода для подключения с помощью Sentinel:**

  `connect.php`
  ```php
  <?php
    require 'Predis/Autoloader.php';
    Predis\Autoloader::register();

    $sentinels = ['<FQDN хоста 1 {{ RD }}>:26379>',...,'<FQDN хоста N {{ RD }}>:26379>'];
    $options = [
      'replication' => 'sentinel',
      'service' => '<имя кластера {{ RD }}>',
      'parameters' => [
        'password' => '<пароль>'
      ]
    ];

    $conn = new Predis\Client($sentinels, $options);

    $conn->set('foo', 'bar');
    var_dump($conn->get('foo'));
  
    $conn->disconnect();
  ?>
  ```

  **Пример кода для подключения напрямую к мастеру:**

  `connect.php`
  ```php
  <?php
    require 'Predis/Autoloader.php';
    Predis\Autoloader::register();

    $host = ['<FQDN хоста-мастера {{ RD }}>:6379'];
    $options = [
      'parameters' => [
        'password' => '<пароль>'
      ]
    ];

    $conn = new Predis\Client($host, $options);

    $conn->set('foo', 'bar');
    var_dump($conn->get('foo'));
  
    $conn->disconnect();
  ?>
  ```

  **Подключение:**
  
  ```bash
  php connect.php
  ```

- Java

  **Перед подключением:**
  
  1. Установите зависимости:
    
     ```bash
     sudo apt update && sudo apt install -y default-jdk maven
     ```
  
  1. Создайте директорию для проекта Maven:
     
     ```bash
     cd ~/ && mkdir -p project/src/java/com/example && cd project/
     ```
     
  1. Создайте конфигурационный файл для Maven:  
     
     {% cut "pom.xml" %}
     ```xml
     <?xml version="1.0" encoding="UTF-8"?>
     <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
         <modelVersion>4.0.0</modelVersion>
         <groupId>com.example</groupId>
         <artifactId>app</artifactId>
         <packaging>jar</packaging>
         <version>0.1.0</version>
         <properties>
             <maven.compiler.source>1.8</maven.compiler.source>
             <maven.compiler.target>1.8</maven.compiler.target>
         </properties>
         <dependencies>
             <dependency>
                 <groupId>redis.clients</groupId>
                 <artifactId>jedis</artifactId>
                 <version>3.3.0</version>
             </dependency>
             <dependency>
                 <groupId>org.slf4j</groupId>
                 <artifactId>slf4j-simple</artifactId>
                 <version>1.7.30</version>
             </dependency>
         </dependencies>
         <build>
             <finalName>${project.artifactId}-${project.version}</finalName>
             <sourceDirectory>src</sourceDirectory>
             <resources>
                 <resource>
                     <directory>src</directory>
                 </resource>
             </resources>
             <plugins>
                 <plugin>
                     <groupId>org.apache.maven.plugins</groupId>
                     <artifactId>maven-assembly-plugin</artifactId>
                     <executions>
                         <execution>
                             <goals>
                                 <goal>attached</goal>
                             </goals>
                             <phase>package</phase>
                             <configuration>
                                 <descriptorRefs>
                                     <descriptorRef>jar-with-dependencies</descriptorRef>
                                 </descriptorRefs>
                                 <archive>
                                     <manifest>
                                         <mainClass>com.example.App</mainClass>
                                     </manifest>
                                 </archive>
                             </configuration>
                         </execution>
                     </executions>
                  </plugin>
                  <plugin>
                     <groupId>org.apache.maven.plugins</groupId>
                     <artifactId>maven-jar-plugin</artifactId>
                     <version>3.1.0</version>
                     <configuration>
                         <archive>
                             <manifest>
                                 <mainClass>com.example.App</mainClass>
                             </manifest>
                         </archive>
                     </configuration>
                 </plugin>
             </plugins>
         </build>
     </project>
     ```
     {% endcut %}     
     
     Актуальные версии зависимостей для Maven:
     - [jedis](https://mvnrepository.com/artifact/redis.clients/jedis).
     - [slf4j-simple](https://mvnrepository.com/artifact/org.slf4j/slf4j-simple).
  
  **Пример кода для подключения с помощью Sentinel:**
  
  `src/java/com/example/App.java`
  ```java
  package com.example;

  import java.util.HashSet;
  import redis.clients.jedis.JedisSentinelPool;
  import redis.clients.jedis.Jedis;

  public class App {
    public static void main(String[] args) {
      String redisName    = "<имя кластера {{ RD }}>";
      String redisPass    = "<пароль>";

      HashSet sentinels = new HashSet();
      sentinels.add("<FQDN хоста 1 {{ RD }}>:26379");
      ...
      sentinels.add("<FQDN хоста N {{ RD }}>:26379");

      try {
        JedisSentinelPool pool = new JedisSentinelPool(redisName, sentinels);
        Jedis conn = pool.getResource();

        conn.auth(redisPass);
        conn.set("foo", "bar");
        System.out.println(conn.get("foo"));

        pool.close();
      }
      catch(Exception ex) {ex.printStackTrace();}
    }
  }
  ```
  
  **Пример кода для подключения напрямую к мастеру:**
  
  `src/java/com/example/App.java`
  ```java
  package com.example;

  import redis.clients.jedis.Jedis;

  public class App {
    public static void main(String[] args) {
      String redisHost    = "<FQDN хоста-мастера {{ RD }}>";
      String redisPass    = "<пароль>";

      try {
        Jedis conn = new Jedis(redisHost);

        conn.auth(redisPass);
        conn.set("foo", "bar");
        System.out.println(conn.get("foo"));

        conn.close();
      }
      catch(Exception ex) {ex.printStackTrace();}
    }
  }
  ```

  **Подключение:**
  
  ```bash
  mvn clean package && \
  java -jar target/app-0.1.0-jar-with-dependencies.jar
  ```
  
- Node.js

  **Перед подключением установите зависимости:**
  
  ```bash
  sudo apt update && sudo apt install -y nodejs npm && \
  npm install ioredis
  ```
  
  **Пример кода для подключения с помощью Sentinel:**

  `app.js`
  ```js
  "use strict"
  const Redis = require('ioredis');

  const conn = new Redis({
    sentinels: [
      { host: "<FQDN хоста 1 {{ RD }}>", port: 26379 },
      ...,
      { host: "<FQDN хоста N {{ RD }}>", port: 26379 },
    ],
    name: "<имя кластера {{ RD }}>",
    password: "<пароль>",
  });

  conn.set("foo", "bar", function (err) {
    if (err) {
      console.error(err);
      conn.disconnect();
    }
  });

  conn.get("foo", function (err, result) {
    if (err) {
      console.error(err);
    } else {
      console.log(result);
    }

    conn.disconnect();
  });
  ```
  
  **Пример кода для подключения напрямую к мастеру:**

  `app.js`
  ```js
  "use strict"
  const Redis = require('ioredis');

  const conn = new Redis({
    host: "<FQDN хоста-мастера {{ RD }}>",
    port: 6379,
    password: "<пароль>",
  });

  conn.set("foo", "bar", function (err) {
    if (err) {
      console.error(err);
      conn.disconnect();
    }
  });

  conn.get("foo", function (err, result) {
    if (err) {
      console.error(err);
    } else {
      console.log(result);
    }

    conn.disconnect();
  });
  ```

  **Подключение:**
  
  ```bash
  node app.js
  ```
  
- Go

  **Перед подключением установите зависимости:**
  
  ```bash
  sudo apt update && sudo apt install -y golang git && \
  go mod init github.com/go-redis/redis && \
  go get github.com/go-redis/redis/v7
  ```
  
  **Пример кода для подключения с помощью Sentinel:**

  `connect.go`
  ```go
  package main

  import (
          "fmt"
          "github.com/go-redis/redis/v7"
  )

  func main() {
          conn := redis.NewUniversalClient(
                  &redis.UniversalOptions{
                          Addrs:      []string{
                                        "<FQDN хоста 1 {{ RD }}>:26379",
                                        ...,
                                        "<FQDN хоста N {{ RD }}>:26379"},
                          MasterName: "<имя кластера {{ RD }}>",
                          Password:   "<пароль>",
                          ReadOnly:   false,
                  },
          )
          err := conn.Set("foo", "bar", 0).Err()
          if err != nil {
                  panic(err)
          }
  
          result, err := conn.Get("foo").Result()
          if err != nil {
            panic(err)
          }
          fmt.Println(result)

          conn.Close()
  }
  ```
  
  **Пример кода для подключения напрямую к мастеру:**

  `connect.go`
  ```go
  package main

  import (
          "fmt"
          "github.com/go-redis/redis/v7"
  )

  func main() {
          conn := redis.NewUniversalClient(
                  &redis.UniversalOptions{
                          Addrs:      []string{ "<FQDN хоста-мастера {{ RD }}>:6379" },
                          Password:   "<пароль>",
                          ReadOnly:   false,
                  },
          )
          err := conn.Set("foo", "bar", 0).Err()
          if err != nil {
                  panic(err)
          }
  
          result, err := conn.Get("foo").Result()
          if err != nil {
            panic(err)
          }
          fmt.Println(result)

          conn.Close()
  }
  ```
  
  **Подключение:**
  
  ```bash
  go run connect.go
  ```

- Ruby

  **Перед подключением установите зависимости:**
  
  ```bash
  sudo apt update && sudo apt install -y ruby && \
  sudo gem install redis
  ```
  
  **Пример кода для подключения с помощью Sentinel:**

  `connect.rb`
  ```ruby
  require "redis"

  SENTINELS = [{host: "<FQDN хоста 1 {{ RD }}>", port: 26379},
               ...,
               {host: "<FQDN хоста N {{ RD }}>", port: 26379}]

  conn = Redis.new(
           host: "<имя кластера {{ RD }}>",
           sentinels: SENTINELS,
           role: "master",
           password: "<пароль>"
         )

  conn.set("foo", "bar")
  puts conn.get("foo")

  conn.close()
  ```
  
  **Пример кода для подключения напрямую к мастеру:**

  `connect.rb`
  ```ruby
  require "redis"

  conn = Redis.new(
           host: "<FQDN хоста-мастера {{ RD }}>",
           port: 6379,
           password: "<пароль>"
         )

  conn.set("foo", "bar")
  puts conn.get("foo")
  
  conn.close() 
  ```
  
  **Подключение:**
  
  ```bash
  ruby connect.rb
  ```

{% endlist %}