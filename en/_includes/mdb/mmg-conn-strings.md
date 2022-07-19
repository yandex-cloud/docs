{% list tabs %}

- Bash

  Before connecting, install the [Mongo Shell utility](https://docs.mongodb.com/manual/mongo/#download-the-mongo-shell).

  **Connecting via SSL for `mongo` version 4.2 and higher:**

  ```bash
  mongosh --norc \
          --tls \
          --tlsCAFile /home//.mongodb/root.crt \
          --host '<{{ MG }} host 1 FQDN>:{{ port-mmg }},...,<{{ MG }} host N FQDN>:{{ port-mmg }}' \
          --username <DB username> \
          --password <DB user password> \
          <DB name>
  ```

  **Connecting via SSL for older `mongo` versions:**

  {% include [default-connstring-old](./mmg/default-connstring-old.md) %}

  **Connecting without SSL:**

  ```bash
  mongosh --norc \
          --host '<{{ MG }} host 1 FQDN>:{{ port-mmg }},...,<{{ MG }} host N FQDN>:{{ port-mmg }}' \
          --username <DB username> \
          --password <DB user password> \
          <DB name>
  ```

  After connecting, run the `db` command.

- PowerShell

  Before connecting, install the [MongoDB Shell utility](https://www.mongodb.com/try/download/shell).

  **Connecting via SSL for `mongo` version 4.2 and higher:**

  ```powershell
  mongosh.exe --norc `
              --host '<{{ MG }} host 1 FQDN>:{{ port-mmg }},...,<{{ MG }} host N FQDN>:{{ port-mmg }}' `
              --tls `
              --tlsCAFile $HOME\.mongodb\root.crt `
              --username <DB username> `
              --password <DB user password> `
              <DB name>
  ```

  **Connecting without SSL:**

  ```powershell
  mongosh.exe --norc `
              --host '<{{ MG }} host 1 FQDN>:{{ port-mmg }},...,<{{ MG }} host N FQDN>:{{ port-mmg }}' `
              --username <DB username> `
              --password <DB user password> `
              <DB name>
  ```

  After connecting, run the `db` command.

- Python

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y python3 python3-pip && \
  pip3 install pyMongo
  ```

  **Code example for connecting via SSL:**

  `connect.py`

  ```python
  import ssl
  import pymongo
  from urllib.parse import quote_plus as quote
  
  CACERT = '/home/<home directory>/.mongodb/root.crt'
  DB_RS = '<replica set name>'
  DB_NAME = '<DB name>'
  DB_HOSTS =','.join([
        '<FQDN of {{ MG }} host 1>:27018',
        ...,
        '<FQDN of {{ MG }} host N>:27018'
      ])
  DB_USER = '<DB username>'
  DB_PASS = '<DB user password>'
  
  url = 'mongodb://{user}:{pw}@{hosts}/?replicaSet={rs}&authSource={auth_src}'.format(
            user = quote(DB_USER),
            pw = quote(DB_PASS),
            rs = DB_RS,
            hosts = DB_HOSTS,
            auth_src = DB_NAME)
  
  conn = pymongo.MongoClient(
      url,
      tlsCAFile=CACERT)
  
  db = conn[DB_NAME]
  print(db.name)
  
  conn.close()
  ```

  **Code example for connecting without SSL:**

  `connect.py`

  ```python
  import ssl
  import pymongo
  from urllib.parse import quote_plus as quote
  
  DB_RS = '<replica set name>'
  DB_NAME = '<DB name>'
  DB_HOSTS =','.join([
        '<FQDN of {{ MG }} host 1>:27018',
        ...,
        '<FQDN of {{ MG }} host N>:27018'
      ])
  DB_USER = '<DB username>'
  DB_PASS = '<DB user password>'
  
  url = 'mongodb://{user}:{pw}@{hosts}/?replicaSet={rs}&authSource={auth_src}'.format(
            user = quote(DB_USER),
            pw = quote(DB_PASS),
            rs = DB_RS,
            hosts = DB_HOSTS,
            auth_src = DB_NAME)
  
  conn = pymongo.MongoClient(url)
  
  db = conn[DB_NAME]
  print(db.name)
  
  conn.close()
  ```

  **Connecting:**

  ```bash
  python3 connect.py
  ```

- PHP

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y php php-mongodb
  ```

  **Code example for connecting via SSL:**

  `connect.php`

  ```php
  <?php
    $DB_RS    = '<replica set name>';
    $DB_NAME  = '<DB name>';
    $DB_HOSTS = '<FQDN of {{ MG }} host 1>:27018,...,<FQDN of {{ MG }} host 2>:27018'; 
    $DB_USER  = '<DB username>';
    $DB_PASS  = '<DB user password>';
    $CACERT   = '/home/<home directory>/.mongodb/root.crt';
  
    $uri = sprintf(
        'mongodb://%s:%s@%s/%s?replicaSet=%s',
        $DB_USER,
        $DB_PASS,
        $DB_HOSTS,
        $DB_NAME,
        $DB_RS
    );
  
    $conn = new \MongoDB\Driver\Manager($uri, ["tls" => "true", "tlsCAFile" => $CACERT], []);
    $command = new MongoDB\Driver\Command(array("ping" => 1));
  
    try {
        $cursor = $conn->executeCommand($DB_NAME, $command);
          $response = $cursor->toArray()[0];
    } catch(MongoDB\Driver\Exception $ex) {
        echo "$ex->getMessage()";
        exit;
    }
  
    var_dump($response);
  ?>
  ```

  **Code example for connecting without SSL:**

  `connect.php`

  ```php
  <?php
    $DB_RS    = '<replica set name>';
    $DB_NAME  = '<DB name>';
    $DB_HOSTS = '<FQDN of {{ MG }} host 1>:27018,...,<FQDN of {{ MG }} host 2>:27018'; 
    $DB_USER  = '<DB username>';
    $DB_PASS  = '<DB user password>';
  
    $uri = sprintf(
        'mongodb://%s:%s@%s/%s?replicaSet=%s',
        $DB_USER,
        $DB_PASS,
        $DB_HOSTS,
        $DB_NAME,
        $DB_RS
    );
  
    $conn = new \MongoDB\Driver\Manager($uri);
    $command = new MongoDB\Driver\Command(array("ping" => 1));
  
    try {
        $cursor = $conn->executeCommand($DB_NAME, $command);
        $response = $cursor->toArray()[0];
    } catch(MongoDB\Driver\Exception $ex) {
        echo "$ex->getMessage()";
        exit;
    }
  
    var_dump($response);
  ?>
  ```

  **Connecting:**
  ```bash
  php connect.php
  ```

- Java

  **Before connecting:**

  1. Install the dependencies:

     ```bash
     sudo apt update && sudo apt install -y default-jdk maven
     ```

  1. Add the SSL certificate to the Java trusted certificate store (Java Key Store) so that the {{ MG }} driver can use this certificate for secure connections to the cluster hosts. Make sure to set the password for storage security using the `-storepass` parameter:

     ```bash
     cd ~/.mongodb && \
     keytool -importcert -alias YARootCrt -file root.crt \
       -keystore YATrustStore -storepass <certificate store password> \
       --noprompt
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
                 <groupId>org.mongodb</groupId>
                 <artifactId>mongodb-driver-sync</artifactId>
                 <version>4.1.0</version>
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
     - [mongodb-driver-sync](https://mvnrepository.com/artifact/org.mongodb/mongodb-driver-sync).
     - [slf4j-simple](https://mvnrepository.com/artifact/org.slf4j/slf4j-simple).

  **Code example for connecting via SSL:**

  `src/java/com/example/App.java`

  ```java
  package com.example;
  
  import java.util.*;
  import com.mongodb.*;
  import com.mongodb.client.*;
  
  public class App {
    public static void main(String[] args) {
  
      System.setProperty("javax.net.ssl.trustStore", "/home/<home directory>/.mongodb/YATrustStore");
      System.setProperty("javax.net.ssl.trustStorePassword", "<certificate store password>");
  
      final Integer DB_PORT = 27018;
  
      List DB_HOSTS = new ArrayList<ServerAddress>();
      DB_HOSTS.add(new ServerAddress("<FQDN of {{ MG }} host 1>", DB_PORT));
      ...
      DB_HOSTS.add(new ServerAddress("<FQDN of {{ MG }} host N>", DB_PORT));
  
      final String DB_NAME = "<DB name>";
      final String DB_USER = "<DB username>";
      final String DB_PASS = "<DB user password>";
  
      MongoClient conn = MongoClients.create(
          MongoClientSettings.builder()
                .applyToClusterSettings(builder -> builder.hosts(DB_HOSTS))
                .applyToSslSettings(builder -> builder.enabled(true))
                .credential(MongoCredential.createCredential(DB_USER, DB_NAME, DB_PASS.toCharArray()))
                .build());
  
      System.out.println(conn.getDatabase(DB_NAME).getName());
  
      conn.close();
    }
  }
  ```

  **Code example for connecting without SSL:**

  `src/java/com/example/App.java`

  ```java
  package com.example;
  
  import java.util.*;
  import com.mongodb.*;
  import com.mongodb.client.*;
  
  public class App {
    public static void main(String[] args) {
  
      final Integer DB_PORT = 27018;
  
      List DB_HOSTS = new ArrayList<ServerAddress>();
      DB_HOSTS.add(new ServerAddress("<FQDN of {{ MG }} host 1>", DB_PORT));
      ...
      DB_HOSTS.add(new ServerAddress("<FQDN of {{ MG }} host N>", DB_PORT));
  
      final String DB_NAME = "<DB name>";
      final String DB_USER = "<DB username>";
      final String DB_PASS = "<DB user password>";
  
      MongoClient conn = MongoClients.create(
          MongoClientSettings.builder()
                .applyToClusterSettings(builder -> builder.hosts(DB_HOSTS))
                .credential(MongoCredential.createCredential(DB_USER, DB_NAME, DB_PASS.toCharArray()))
                .build());
  
      System.out.println(conn.getDatabase(DB_NAME).getName());
  
      conn.close();
    }
  }
  ```

  **Connecting:**

  ```bash
  mvn clean package && \
  java -jar target/app-0.1.0-jar-with-dependencies.jar
  ```

- Node.js

  ```bash
  sudo apt update && sudo apt install -y nodejs npm && \
  npm install mongodb
  ```

  **Code example for connecting via SSL:**

  `app.js`

  ```js
  const util = require('util');
  const MongoClient = require('mongodb').MongoClient;
  
  const DB_RS = '<replica set name>'
  const DB_NAME = '<DB name>'
  const DB_HOSTS = ['<FQDN of {{ MG }} host 1>:27018',
                    ... 
                    '<FQDN of {{ MG }} host N>:27018']
  const DB_USER  = '<DB username>'
  const DB_PASS  = '<DB user password>'
  const CACERT   = '/home/<home directory>/.mongodb/root.crt'
  
  const url = util.format('mongodb://%s:%s@%s/', DB_USER, DB_PASS, DB_HOSTS.join(','))
  
  const options = {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    tls: true,
    tlsCAFile: CACERT,
    replicaSet: DB_RS,
    authSource: DB_NAME
  }
  
  MongoClient.connect(url, options, function(err, conn) {
    if (conn.isConnected()) {
      const db = conn.db(DB_NAME)
      console.log(db.databaseName)
    }
  
    conn.close()
  })
  ```

  **Code example for connecting without SSL:**

  `app.js`

  ```js
  const util = require('util');
  const MongoClient = require('mongodb').MongoClient;
  
  const DB_RS = '<replica set name>'
  const DB_NAME = '<DB name>'
  const DB_HOSTS = ['<FQDN of {{ MG }} host 1>:27018',
                    ... 
                    '<FQDN of {{ MG }} host N>:27018']
  const DB_USER  = '<DB username>'
  const DB_PASS  = '<DB user password>'
  
  const url = util.format('mongodb://%s:%s@%s/', DB_USER, DB_PASS, DB_HOSTS.join(','))
  
  const options = {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    replicaSet: DB_RS,
    authSource: DB_NAME
  }
  
  MongoClient.connect(url, options, function(err, conn) {
    if (conn.isConnected()) {
      const db = conn.db(DB_NAME)
      console.log(db.databaseName)
    }
  
    conn.close()
  }) 
  ```

  **Connecting:**

  ```bash
  node app.js
  ```

- Go

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y golang git && \
  go get go.mongodb.org/mongo-driver/mongo
  ```

  **Code example for connecting via SSL:**

  `connect.go`

  ```go
  package main
  
  import (
        "fmt"
        "strings"
        "context"
        "go.mongodb.org/mongo-driver/mongo"
        "go.mongodb.org/mongo-driver/mongo/options"
  )
  
  func main() {
  
        const DB_RS = "<replica set name>"
        const DB_NAME = "<DB name>"
        DB_HOSTS := []string {"<FQDN of {{ MG }} host 1>:27018",
                              ... 
                              "<FQDN of {{ MG }} host N>:27018"}
        const DB_USER = "<DB username>"
        const DB_PASS = "<DB user password>"
  
        const CACERT = "/home/<home directory>/.mongodb/root.crt"
  
        url := fmt.Sprintf("mongodb://%s:%s@%s/%s?replicaSet=%s&tls=true&tlsCaFile=%s",
                DB_USER,
                DB_PASS,
                strings.Join(DB_HOSTS, ","),
                DB_NAME,
                DB_RS,
                CACERT)
  
        conn, err := mongo.Connect(context.Background(), options.Client().ApplyURI(url))
        if err != nil {
                panic(err)
        }
  
        defer conn.Disconnect(context.Background())
  
        fmt.Println(conn.Database(DB_NAME).Name())
  }
  ```

  **Code example for connecting without SSL:**

  `connect.go`

  ```go
  package main
  
  import (
        "fmt"
        "strings"
        "context"
        "go.mongodb.org/mongo-driver/mongo"
        "go.mongodb.org/mongo-driver/mongo/options"
  )
  
  func main() {
  
        const DB_RS = "<replica set name>"
        const DB_NAME = "<DB name>"
        DB_HOSTS := []string {"<FQDN of {{ MG }} host 1>:27018",
                              ... 
                              "<FQDN of {{ MG }} host N>:27018"}
        const DB_USER = "<DB username>"
        const DB_PASS = "<DB user password>"
  
        url := fmt.Sprintf("mongodb://%s:%s@%s/%s?replicaSet=%s&tls=false",
                DB_USER,
                DB_PASS,
                strings.Join(DB_HOSTS, ","),
                DB_NAME,
                DB_RS)
  
        conn, err := mongo.Connect(context.Background(), options.Client().ApplyURI(url))
        if err != nil {
                panic(err)
        }
  
        defer conn.Disconnect(context.Background())
  
        fmt.Println(conn.Database(DB_NAME).Name())
  }
  ```

  **Connecting:**

  ```bash
  go run connect.go
  ```

{% endlist %}

