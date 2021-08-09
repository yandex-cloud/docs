### Bash

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install -y redis-tools
```

{% note info %}

To connect to a SSL-enabled cluster, [download](https://redis.io/download) an archive with the utility's source code and build a version of the utility with TLS support using the `make BUILD_TLS=yes` command.

{% endnote %}

{% list tabs %}

- Connecting without using SSL

  **Connecting via Sentinel:**

  1. Get the address of the master host by using Sentinel and any {{ RD }} host:

     ```bash
     redis-cli -h <FQDN of any {{ RD }} host> -p 26379 sentinel get-master-addr-by-name <{{ RD }} cluster name> | head -n 1
     ```

  1. Connect to the host with this address:

     ```bash
     redis-cli -h <{{ RD }} master host address> -a <{{ RD }} password>
     ```

  **Connecting directly to the master:**

  ```bash
  redis-cli -h  <{{ RD }} master host FQDN> -a <password>
  ```

  {% include [use-special-fqdn](mrd-conn-strings-fqdn.md) %}

- Connecting via SSL

  **Connecting directly to the master:**

  ```bash
  redis-cli -h  <{{ RD }} master host FQDN> -a <password> -p 6380 --tls --cacert ~/.redis/YandexInternalRootCA.crt
  ```

  {% include [use-special-fqdn](mrd-conn-strings-fqdn.md) %}

{% endlist %}

When you are connected to the cluster, run the commands:

1. `SET foo bar`
1. `GET foo`

If the connection to the cluster and the test query are successful, the `bar` string is output.

### Python

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install -y python3 python3-pip && \
pip3 install redis
```

{% list tabs %}

- Connecting without using SSL

  **Code example for connecting via Sentinel:**

  `connect.py`

  ```python
  from redis.sentinel import Sentinel
  
  sentinels = ['<FQDN of {{ RD }} host 1>',
           ...
           '<FQDN of {{ RD }} host N>']
  name = '<{{ RD }} cluster name>'
  pwd = '<password>'
  
  sentinel = Sentinel([(h, 26379) for h in sentinels], socket_timeout=0.1)
  master = sentinel.master_for(name, password=pwd)
  slave = sentinel.slave_for(name, password=pwd)
  
  master.set('foo', 'bar')
  print(slave.get('foo'))
  ```

  **Code example for connecting directly to the master:**

  `connect.py`

  ```python
  import redis
  
  r = redis.StrictRedis(
      host='<FQDN of {{ RD }} master host>',
      port=6379,
      password='<password>',
  )
  
  r.set('foo', 'bar')
  print(r.get('foo'))
  ```

  {% include [use-special-fqdn](mrd-conn-strings-fqdn.md) %}

  **Connecting:**

  ```bash
  python3 connect.py
  ```

- Connecting via SSL

  **Code example for connecting directly to the master:**

  `connect.py`

  ```python
  import redis
  
  r = redis.StrictRedis(
      host='<FQDN of {{ RD }} master host>',
      port=6380,
      password='<password>',
      ssl=True, 
      ssl_ca_certs='~/.redis/YandexInternalRootCA.crt',
  )
  
  r.set('foo', 'bar')
  print(r.get('foo'))
  ```

  {% include [use-special-fqdn](mrd-conn-strings-fqdn.md) %}

  **Connecting:**

  ```bash
  python3 connect.py
  ```

{% endlist %}

If the connection to the cluster and the test query are successful, the `bar` string is output.

### PHP

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install -y php php-dev php-pear && \
sudo pear channel-discover pear.nrk.io && \
sudo pear install nrk/Predis
```

{% list tabs %}

- Connecting without using SSL

  **Code example for connecting via Sentinel:**

  `connect.php`

  ```php
  <?php
    require 'Predis/Autoloader.php';
    Predis\Autoloader::register();
  
    $sentinels = ['<FQDN of {{ RD }} host 1>:26379>',...,'<FQDN of {{ RD }} host N>:26379>'];
    $options = [
      'replication' => 'sentinel',
      'service' => '<{{ RD }} cluster name>',
      'parameters' => [
        'password' => '<password>'
      ]
    ];
  
    $conn = new Predis\Client($sentinels, $options);
  
    $conn->set('foo', 'bar');
    var_dump($conn->get('foo'));
  
    $conn->disconnect();
  ?>
  ```

  **Code example for connecting directly to the master:**

  `connect.php`

  ```php
  <?php
    require 'Predis/Autoloader.php';
    Predis\Autoloader::register();
  
    $host = ['<FQDN of {{ RD }} master host>:6379'];
    $options = [
      'parameters' => [
        'password' => '<password>'
      ]
    ];
  
    $conn = new Predis\Client($host, $options);
  
    $conn->set('foo', 'bar');
    var_dump($conn->get('foo'));
  
    $conn->disconnect();
  ?>
  ```

  {% include [use-special-fqdn](mrd-conn-strings-fqdn.md) %}

  **Connecting:**

  ```bash
  php connect.php
  ```

- Connecting via SSL

  **Code example for connecting directly to the master:**

  `connect.php`

  ```php
  <?php
    require 'Predis/Autoloader.php';
    Predis\Autoloader::register();
  
    $host = ['<FQDN of {{ RD }} master host>:6380'];
    $options = [
      'parameters' => [
        'scheme' => 'tls',
        'ssl'    => ['cafile' => '~/.redis/YandexInternalRootCA.crt', 'verify_peer' => true, 'verify_peer_name' => false],
        'password' => '<password>'
      ]
    ];
  
    $conn = new Predis\Client($host, $options);
  
    $conn->set('foo', 'bar');
    var_dump($conn->get('foo'));
  
    $conn->disconnect();
  ?>
  ```

  {% include [use-special-fqdn](mrd-conn-strings-fqdn.md) %}

  **Connecting:**

  ```bash
  php connect.php
  ```

{% endlist %}

If the connection to the cluster and the test query are successful, the `bar` string is output.

### Java

Before connecting:

1. Install the dependencies:

   ```bash
   sudo apt update && sudo apt install -y default-jdk maven
   ```

1. Create a folder for the Maven project:

   ```bash
   cd ~/ && mkdir -p project/src/java/com/example && cd project/
   ```

1. Create a configuration file for Maven:

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

   Up-to-date versions of dependencies for Maven:
   - [jedis](https://mvnrepository.com/artifact/redis.clients/jedis).
   - [slf4j-simple](https://mvnrepository.com/artifact/org.slf4j/slf4j-simple)

{% list tabs %}

- Connecting without using SSL

  **Code example for connecting via Sentinel:**

  `src/java/com/example/App.java`

  ```java
  package com.example;
  
  import java.util.HashSet;
  import redis.clients.jedis.JedisSentinelPool;
  import redis.clients.jedis.Jedis;
  
  public class App {
  public static void main(String[] args) {
    String redisName    = "<{{ RD }} cluster name>";
    String redisPass    = "<password>";
  
    HashSet sentinels = new HashSet();
    sentinels.add("<FQDN of {{ RD }} host 1>:26379");
    ...
    sentinels.add("<FQDN of {{ RD }} host N>:26379");
  
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

  **Code example for connecting directly to the master:**

  `src/java/com/example/App.java`

  ```java
  package com.example;
  
  import redis.clients.jedis.Jedis;
  
  public class App {
  public static void main(String[] args) {
    String redisHost    = "<FQDN of {{ RD }} master host>";
    String redisPass    = "<password>";
  
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

  {% include [use-special-fqdn](mrd-conn-strings-fqdn.md) %}

  **Connecting:**

     ```bash
     mvn clean package && \
     java -jar target/app-0.1.0-jar-with-dependencies.jar
     ```

- Connecting via SSL

  **Code example for connecting directly to the master:**

  `src/java/com/example/App.java`

  ```java
  package com.example;
  
  import redis.clients.jedis.Jedis;
  
  public class App {
  public static void main(String[] args) {
    String redisHost    = "<FQDN of {{ RD }} master host:6380>";
    String redisPass    = "<password>";
  
    try {
      Jedis conn = new Jedis("rediss://" + redisHost);
  
      conn.auth(redisPass);
      conn.set("foo", "bar");
      System.out.println(conn.get("foo"));
  
      conn.close();
    }
    catch(Exception ex) {ex.printStackTrace();}
  }
  }
  ```

  {% include [use-special-fqdn](mrd-conn-strings-fqdn.md) %}

  **Connecting:**

     ```bash
     mvn clean package && \
     java -jar target/app-0.1.0-jar-with-dependencies.jar
     ```

{% endlist %}

### Node.js

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install -y nodejs npm && \
npm install ioredis
```

{% list tabs %}

- Connecting without using SSL

  **Code example for connecting via Sentinel:**

  `app.js`

  ```js
  "use strict"
  const Redis = require('ioredis');
  
  const conn = new Redis({
    sentinels: [
      { host: "<FQDN of {{ RD }} host 1>", port: 26379 },
      ...,
      { host: "<FQDN of {{ RD }} host N>", port: 26379 },
    ],
    name: "<{{ RD }} cluster name>",
    password: "<password>",
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

  **Code example for connecting directly to the master:**

  `app.js`

  ```js
  "use strict"
  const Redis = require('ioredis');
  
  const conn = new Redis({
    host: "<FQDN of {{ RD }} master host>",
    port: 6379,
    password: "<password>",
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

  {% include [use-special-fqdn](mrd-conn-strings-fqdn.md) %}

  **Connecting:**

  ```bash
  node app.js
  ```

- Connecting via SSL

  **Code example for connecting directly to the master:**

  `app.js`

  ```js
  "use strict"
  const fs = require('fs');
  const Redis = require('ioredis');
  
  const conn = new Redis({
    host: "<FQDN of {{ RD }} master host>",
    port: 6380,
    password: "<password>",
    tls: {
        ca: fs.readFileSync('~/.redis/YandexInternalRootCA.crt')
    }
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

  {% include [use-special-fqdn](mrd-conn-strings-fqdn.md) %}

  **Connecting:**

  ```bash
  node app.js
  ```

{% endlist %}

If the connection to the cluster and the test query are successful, the `bar` string is output.

### Go

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install -y golang git && \
go mod init github.com/go-redis/redis && \
go get github.com/go-redis/redis/v7
```

{% list tabs %}

- Connecting without using SSL

  **Code example for connecting via Sentinel:**

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
                                        "<FQDN of {{ RD }} host 1>:26379",
                                        ...,
                                        "<FQDN of {{ RD }} host N>:26379"},
                          MasterName: "<{{ RD }} cluster name>",
                          Password:   "<password>",
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

  **Code example for connecting directly to the master:**

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
                          Addrs:      []string{ "<FQDN of {{ RD }} master host>:6379" },
                          Password:   "<password>",
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

  {% include [use-special-fqdn](mrd-conn-strings-fqdn.md) %}

  **Connecting:**

  ```bash
  go run connect.go
  ```

- Connecting via SSL

  **Code example for connecting directly to the master:**

  `connect.go`

  ```go
  package main
  
  import (
          "fmt"
          "github.com/go-redis/redis/v7"
          "crypto/tls"
          "crypto/x509"
          "io/ioutil"
  )
  
  const (
      cert = "~/.redis/YandexInternalRootCA.crt"
  )
  
  func main() {
          rootCertPool := x509.NewCertPool()
          pem, err := ioutil.ReadFile(cert)
          if err != nil {
              panic(err)
          }
  
          if ok := rootCertPool.AppendCertsFromPEM(pem); !ok {
              panic("Failed to append PEM.")
          }
  
          conn := redis.NewUniversalClient(
                  &redis.UniversalOptions{
                          Addrs:      []string{ "<FQDN of {{ RD }} master host>:6380" },
                          Password:   "<password>",
                          ReadOnly:   false,
                          TLSConfig: &tls.Config{
                                  RootCAs: rootCertPool,
                                  InsecureSkipVerify: true,
                          },
                  },
          )
          err = conn.Set("foo", "bar", 0).Err()
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

  {% include [use-special-fqdn](mrd-conn-strings-fqdn.md) %}

  **Connecting:**

  ```bash
  go run connect.go
  ```

{% endlist %}

If the connection to the cluster and the test query are successful, the `bar` string is output.

### Ruby

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install -y ruby && \
sudo gem install redis
```

{% list tabs %}

- Connecting without using SSL

  **Code example for connecting via Sentinel:**

  `connect.rb`

  ```ruby
  require "redis"
  
  SENTINELS = [{host: "<FQDN of {{ RD }} host 1>", port: 26379},
               ...,
               {host: "<FQDN of {{ RD }} host N>", port: 26379}]
  
  conn = Redis.new(
           host: "<{{ RD }} cluster name>",
           sentinels: SENTINELS,
           role: "master",
           password: "<password>"
         )
  
  conn.set("foo", "bar")
  puts conn.get("foo")
  
  conn.close()
  ```

  **Code example for connecting directly to the master:**

  `connect.rb`

  ```ruby
  require "redis"
  
  conn = Redis.new(
           host: "<FQDN of {{ RD }} master host>",
           port: 6379,
           password: "<password>"
         )
  
  conn.set("foo", "bar")
  puts conn.get("foo")
  
  conn.close() 
  ```

  {% include [use-special-fqdn](mrd-conn-strings-fqdn.md) %}

  **Connecting:**

  ```bash
  ruby connect.rb
  ```

- Connecting via SSL

  **Code example for connecting directly to the master:**

  `connect.rb`

  ```ruby
  require "redis"
  
  conn = Redis.new(
           host: "<FQDN of {{ RD }} master host>",
           port: 6380,
           password: "<password>",
           ssl: true,
           ssl_params: { ca_file: '~/.redis/YandexInternalRootCA.crt' },
         )
  
  conn.set("foo", "bar")
  puts conn.get("foo")
  
  conn.close() 
  ```

  {% include [use-special-fqdn](mrd-conn-strings-fqdn.md) %}

  **Connecting:**

  ```bash
  ruby connect.rb
  ```

{% endlist %}

If the connection to the cluster and the test query are successful, the `bar` string is output.

