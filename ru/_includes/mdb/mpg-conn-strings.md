{% list tabs %}

- Bash

  **Перед подключением установите зависимости:**
  
  ```bash
  sudo apt update && sudo apt install -y postgresql-client
  ```

  **Подключение с использованием SSL-соединения:**
  
  ```bash
  psql "host=<FQDN одного или нескольких хостов {{ PG }}> \
      port=6432 \
      sslmode=verify-full \
      dbname=<имя БД> \
      user=<имя пользователя> \
      target_session_attrs=read-write"
  ```
  
  **Подключение без использования SSL-соединения:**
  
  ```bash
  psql "host=<FQDN одного или нескольких хостов {{ PG }}> \
      port=6432 \
      sslmode=disable \
      dbname=<имя БД> \
      user=<имя пользователя> \
      target_session_attrs=read-write"
  ```
  
  После выполнения любой из команд введите пароль пользователя для завершения процедуры подключения.
  
  После подключения к СУБД выполните команду `SELECT version();`. 

- Python

  **Перед подключением установите зависимости:**

  ```bash
  sudo apt update && sudo apt install -y python3 python3-pip && \
  pip3 install psycopg2-binary
  ```

  **Пример кода для подключения с использованием SSL-соединения:**
  
  `connect.py`
  ```python
  import psycopg2

  conn = psycopg2.connect("""
      host=<FQDN одного или нескольких хостов {{ PG }}>
      port=6432
      sslmode=verify-full
      dbname=<имя БД>
      user=<имя пользователя>
      password=<пароль пользователя>
      target_session_attrs=read-write
  """)
  
  q = conn.cursor()
  q.execute('SELECT version()')
  
  print(q.fetchone())
  
  conn.close()
  ```
  
  **Пример кода для подключения без использования SSL-соединения:**

  `connect.py`
  ```python
  import psycopg2

  conn = psycopg2.connect("""
      host=<FQDN одного или нескольких хостов {{ PG }}>
      port=6432
      sslmode=disable
      dbname=<имя БД>
      user=<имя пользователя>
      password=<пароль пользователя>
      target_session_attrs=read-write
  """)
  
  q = conn.cursor()
  q.execute('SELECT version()')
  
  print(q.fetchone())

  conn.close()
  ```
  {% endcut %}


  **Подключение:**
  
  ```bash
  python3 connect.py
  ```

- PHP

  **Перед подключением установите зависимости:**
  
  ```bash
  sudo apt update && sudo apt install -y php php-pgsql
  ```

  **Пример кода для подключения с использованием SSL-соединения:**

  `connect.php`
  ``` php
  <?php
    $conn = pg_connect("
        host=<FQDN одного или нескольких хостов {{ PG }}>
        port=6432
        sslmode=verify-full
        dbname=<имя БД>
        user=<имя пользователя>
        password=<пароль пользователя>
        target_session_attrs=read-write
    ");
  
    $q = pg_query($conn, "SELECT version()");
    $result = pg_fetch_row($q);
    echo($result[0]);
  
    pg_close($conn);
  ?>
  ```

  **Пример кода для подключения без использования SSL-соединения:**

  `connect.php`
  ```php
  <?php
    $conn = pg_connect("
        host=<FQDN одного или нескольких хостов {{ PG }}>
        port=6432
        sslmode=disable
        dbname=<имя БД>
        user=<имя пользователя>
        password=<пароль пользователя>
        target_session_attrs=read-write
    ");
  
    $q = pg_query($conn, "SELECT version()");
    $result = pg_fetch_row($q);
    echo($result[0]);
  
    pg_close($conn);
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
     <project
	     xmlns="http://maven.apache.org/POM/4.0.0"
	     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
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
			     <groupId>org.postgresql</groupId>
			     <artifactId>postgresql</artifactId>
			     <version>42.2.16</version>
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
     
     Актуальная версия зависимости для Maven: [postgresql](https://mvnrepository.com/artifact/org.postgresql/postgresql).
  
  **Пример кода для подключения с использованием SSL-соединения:**
  
  `src/java/com/example/App.java`
  ```java
  package com.example;
  
  import java.sql.*;
  
  public class App {
    public static void main(String[] args) {
      String DB_URL     = "jdbc:postgresql://<хост 1 {{ PG }}:6432,...,хост N {{ PG }}:6432>/<имя БД>&targetServerType=master&ssl=true&sslmode=verify-full";
      String DB_USER    = "<имя пользователя>";
      String DB_PASS    = "<пароль пользователя>";
      
      try {
        Class.forName("org.postgresql.Driver");

        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        ResultSet q = conn.createStatement().executeQuery("SELECT version()");
        if(q.next()) {System.out.println(q.getString(1));}

        conn.close();
      }
      catch(Exception ex) {ex.printStackTrace();}
    }
  }
  ```
  
  **Пример кода для подключения без использования SSL-соединения:**
  
  `src/java/com/example/App.java`
  ```java
  package com.example;
  
  import java.sql.*;
  
  public class App {
    public static void main(String[] args) {
      String DB_URL     = "jdbc:postgresql://<хост 1 {{ PG }}:6432,...,хост N {{ PG }}:6432>/<имя БД>&targetServerType=master&ssl=true&sslmode=disable";
      String DB_USER    = "<имя пользователя>";
      String DB_PASS    = "<пароль пользователя>";
      
      try {
        Class.forName("org.postgresql.Driver");

        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        ResultSet q = conn.createStatement().executeQuery("SELECT version()");
        if(q.next()) {System.out.println(q.getString(1));}

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
  npm install pg
  ```
  
  **Пример кода для подключения с использованием SSL-соединения:**
  
  `app.js`
  ```js
  "use strict"
  const fs = require('fs');
  const pg = require('pg');
  
  const config = {
    connectionString: 'postgres://<имя пользователя>:<пароль пользователя>@c-<идентификатор кластера>.rw.mdb.yandexcloud.net:6432/<имя БД>',
    ssl: {
      rejectUnauthorized: true,
      ca: fs.readFileSync('/home/<домашняя директория>/.postgresql/root.crt').toString(),
    },
  }

  const conn = new pg.Client(config)

  conn.connect(err => {if (err) throw err})
  conn.query('SELECT version()', (err, q) => {
    if (err) throw err
    console.log(q.rows[0])
    conn.end()
  })
  ```
  
  В отличие от других способов подключения, в этом коде необходимо указывать полный путь к сертификату `root.crt` для {{ PG }} в переменной `ca`.
  
  **Пример кода для подключения без использования SSL-соединения:**

  `app.js`
  ```js
  "use strict"
  const pg = require('pg');
  
  const config = {
    connectionString: 'postgres://<имя пользователя>:<пароль пользователя>@c-<идентификатор кластера>.rw.mdb.yandexcloud.net:6432/<имя БД>',
  }

  const conn = new pg.Client(config)

  conn.connect(err => {if (err) throw err})
  conn.query('SELECT version()', (err, q) => {
    if (err) throw err
    console.log(q.rows[0])
    conn.end()
  })
  ```

  Идентификатор кластера можно получить со [списком кластеров](../../managed-postgresql/operations/cluster-list.md#list-clusters).

  **Подключение:**
  
  ```bash
  node app.js
  ```
  
- Go

  **Перед подключением установите зависимости:**
  
  ```bash
  sudo apt update && sudo apt install -y golang git && \
  go mod init example && go get github.com/jackc/pgx/v4
  ```
  
  **Пример кода для подключения с использованием SSL-соединения:**
  
  `connect.go`
  ```go
  package main

  import (
    "context"
    "crypto/tls"
    "crypto/x509"
    "fmt"
    "io/ioutil"
    "os"
  
    "github.com/jackc/pgx/v4"
  )

  const (
    host     = "<FQDN одного или нескольких хостов {{ PG }}>"
    port     = 6432
    user     = "<имя пользователя>"
    password = "<пароль пользователя>"
    dbname   = "<имя БД>"
    ca       = "/home/<домашняя директория>/.postgresql/root.crt"
  )
  
  func main() {
  
    rootCertPool := x509.NewCertPool()
    pem, err := ioutil.ReadFile(ca)
    if err != nil {
      panic(err)
    }
  
    if ok := rootCertPool.AppendCertsFromPEM(pem); !ok {
      panic("Failed to append PEM.")
    }
  
    connstring := fmt.Sprintf(
      "host=%s port=%d dbname=%s user=%s password=%s sslmode=verify-full target_session_attrs=read-write",
      host, port, dbname, user, password)
  
    connConfig, err := pgx.ParseConfig(connstring)
    if err != nil {
      fmt.Fprintf(os.Stderr, "Unable to parse config: %v\n", err)
      os.Exit(1)
    }
  
    connConfig.TLSConfig = &tls.Config{
      RootCAs:            rootCertPool,
      InsecureSkipVerify: true,
    }
  
    conn, err := pgx.ConnectConfig(context.Background(), connConfig)
    if err != nil {
      fmt.Fprintf(os.Stderr, "Unable to connect to database: %v\n", err)
      os.Exit(1)
    }
  
    defer conn.Close(context.Background())
  
    var version string
  
    err = conn.QueryRow(context.Background(), "select version()").Scan(&version)
    if err != nil {
      fmt.Fprintf(os.Stderr, "QueryRow failed: %v\n", err)
      os.Exit(1)
    }
  
    fmt.Println(version)  
  }
  ```
    
  В отличие от других способов подключения, в этом коде необходимо указывать полный путь к сертификату `root.crt` для {{ PG }} в переменной `ca`.
  
  **Пример кода для подключения без использования SSL-соединения:**

  `connect.go`
  ```go
  package main

  import (
    "context"
    "fmt"
    "os"
  
    "github.com/jackc/pgx/v4"
  )
  
  const (
    host     = "<FQDN одного или нескольких хостов {{ PG }}>"
    port     = 6432
    user     = "<имя пользователя>"
    password = "<пароль пользователя>"
    dbname   = "<имя БД>"
  )
  
  func main() {
  
    connstring := fmt.Sprintf(
      "host=%s port=%d dbname=%s user=%s password=%s target_session_attrs=read-write",
      host, port, dbname, user, password)
  
    connConfig, err := pgx.ParseConfig(connstring)
    if err != nil {
      fmt.Fprintf(os.Stderr, "Unable to parse config: %v\n", err)
      os.Exit(1)
    }
  
    conn, err := pgx.ConnectConfig(context.Background(), connConfig)
    if err != nil {
      fmt.Fprintf(os.Stderr, "Unable to connect to database: %v\n", err)
      os.Exit(1)
    }
  
    defer conn.Close(context.Background())
  
    var version string
  
    err = conn.QueryRow(context.Background(), "select version()").Scan(&version)
    if err != nil {
      fmt.Fprintf(os.Stderr, "QueryRow failed: %v\n", err)
      os.Exit(1)
    }
  
    fmt.Println(version)  
  }  
  ```
  
  **Подключение:**
  
  ```bash
  go run connect.go
  ```

- Ruby

  **Перед подключением установите зависимости:**
  
  ```bash
  sudo apt update && sudo apt install -y ruby ruby-pg
  ```
  
  **Пример кода для подключения с использованием SSL-соединения:**
  
  `connect.rb`
  ```ruby
  require "pg"

  conn = PG.connect("
          host=<FQDN одного или нескольких хостов {{ PG }}>
          port=6432
          dbname=<имя БД>
          user=<имя пользователя>
          password=<пароль пользователя>
          target_session_attrs=read-write
          sslmode=verify-full
  ")

  q = conn.exec("SELECT version()")
  puts q.getvalue 0, 0
  
  conn.close()
  ```
  
  **Пример кода для подключения без использования SSL-соединения:**

  `connect.rb`
  ```ruby
  require "pg"

  conn = PG.connect("
          host=<FQDN одного или нескольких хостов {{ PG }}>
          port=6432
          dbname=<имя БД>
          user=<имя пользователя>
          password=<пароль пользователя>
          target_session_attrs=read-write
          sslmode=disable
  ")

  q = conn.exec("SELECT version()")
  puts q.getvalue 0, 0
  
  conn.close()
  ```
  
  **Подключение:**
  
  ```bash
  ruby connect.rb
  ```
  
- C# EfCore

  **Перед подключением установите зависимости:**
  
  ```bash
  Install-Package Npgsql.EntityFrameworkCore.PostgreSQL
  ```
  
  **Пример настройек в файле `appsettings.json` для подключения с использованием SSL-соединения:**
  ```json
  ...
  "ConnectionStrings": {
	"Default": "Server=<FQDN одного или нескольких хостов {{ PG }}>;Database=<имя БД>;Port=6432;User Id=<имя пользователя>;Password=<пароль пользователя>;Ssl Mode=Require; Trust Server Certificate=true;"
  },
  ...
  ```

- ODBC

  **Перед подключением установите зависимости:**
  
  ```bash
  sudo apt update && sudo apt install -y unixodbc odbc-postgresql
  ```
  
  Драйвер {{ PG }} ODBC будет автоматически зарегистрирован в файле `/etc/odbcinst.ini`.
  
  **Пример настроек в файле `/etc/odbc.ini` для подключения с использованием SSL-соединения:**
  
  `odbc.ini`
  ```ini
  [postgresql]
  Driver=PostgreSQL Unicode
  Servername=<хост 1 {{ PG }}>,...,<хост N {{ PG }}>
  Username=<имя пользователя>
  Password=<пароль пользователя>
  Database=<имя БД>
  Port=6432
  Pqopt=target_session_attrs=read-write
  Sslmode= verify-full
  ```
  
  **Пример настроек в файле `/etc/odbc.ini` для подключения без использования SSL-соединения:**
  
  `odbc.ini`
  ```ini
  [postgresql]
  Driver=PostgreSQL Unicode
  Servername=<хост 1 {{ PG }}>,...,<хост N {{ PG }}>
  Username=<имя пользователя>
  Password=<пароль пользователя>
  Database=<имя БД>
  Port=6432
  Pqopt=target_session_attrs=read-write
  ```

  **Подключение:**
  
  ```bash
  isql -v postgresql
  ```

  После подключения к СУБД выполните команду `SELECT version();`.

{% endlist %}
