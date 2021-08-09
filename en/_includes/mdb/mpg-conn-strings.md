{% list tabs %}

- Bash

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y postgresql-client
  ```

  **Connecting via SSL:**

  ```bash
  psql "host=<FQDN of one or multiple {{ PG }} hosts> \
      port=6432 \
      sslmode=verify-full \
      dbname=<DB name> \
      user=<username> \
      target_session_attrs=read-write"
  ```

  **Connecting without SSL:**

  ```bash
  psql "host=<FQDN of one or multiple {{ PG }} hosts> \
      port=6432 \
      sslmode=disable \
      dbname=<DB name> \
      user=<username> \
      target_session_attrs=read-write"
  ```

  After running any of the commands, enter the user password to complete the connection procedure.

  After connecting to the DBMS, run the command `SELECT version();`.

- Python

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y python3 python3-pip && \
  pip3 install psycopg2-binary
  ```

  **Code example for connecting via SSL:**

  `connect.py`

  ```python
  import psycopg2
  
  conn = psycopg2.connect("""
      host=<FQDN of one or multiple {{ PG }} hosts>
      port=6432
      sslmode=verify-full
      dbname=<DB name>
      user=<username>
      password=<user password>
      target_session_attrs=read-write
  """)
  
  q = conn.cursor()
  q.execute('SELECT version()')
  
  print(q.fetchone())
  
  conn.close()
  ```

  **Code example for connecting without SSL:**

  `connect.py`

  ```python
  import psycopg2
  
  conn = psycopg2.connect("""
      host=<FQDN of one or multiple {{ PG }} hosts>
      port=6432
      sslmode=disable
      dbname=<DB name>
      user=<username>
      password=<user password>
      target_session_attrs=read-write
  """)
  
  q = conn.cursor()
  q.execute('SELECT version()')
  
  print(q.fetchone())
  
  conn.close()
  ```

  {% endcut %}

  **Connecting:**

  ```bash
  python3 connect.py
  ```

- PHP

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y php php-pgsql
  ```

  **Code example for connecting via SSL:**

  `connect.php`

  ```php
  <?php
    $conn = pg_connect("
        host=<FQDN of one or multiple {{ PG }} hosts>
        port=6432
        sslmode=verify-full
        dbname=<DB name>
        user=<username>
        password=<user password>
        target_session_attrs=read-write
    ");
  
    $q = pg_query($conn, "SELECT version()");
    $result = pg_fetch_row($q);
    echo($result[0]);
  
    pg_close($conn);
  ?>
  ```

  **Code example for connecting without SSL:**

  `connect.php`

  ```php
  <?php
    $conn = pg_connect("
        host=<FQDN of one or multiple {{ PG }} hosts>
        port=6432
        sslmode=disable
        dbname=<DB name>
        user=<username>
        password=<user password>
        target_session_attrs=read-write
    ");
  
    $q = pg_query($conn, "SELECT version()");
    $result = pg_fetch_row($q);
    echo($result[0]);
  
    pg_close($conn);
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

  1. Create a folder for the Maven project:

     ```bash
     cd ~/ && mkdir -p project/src/java/com/example && cd project/
     ```

  1. Create a configuration file for Maven:

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

     Current dependency version for Maven: [postgresql](https://mvnrepository.com/artifact/org.postgresql/postgresql).

  **Code example for connecting via SSL:**

  `src/java/com/example/App.java`

  ```java
  package com.example;
  
  import java.sql.*;
  
  public class App {
    public static void main(String[] args) {
      String DB_URL     = "jdbc:postgresql://<{{ PG }} host 1:6432,..., {{ PG }} host N:6432>/<DB name>&targetServerType=master&ssl=true&sslmode=verify-full";
      String DB_USER    = "<username>";
      String DB_PASS    = "<user password>";
  
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

  **Code example for connecting without SSL:**

  `src/java/com/example/App.java`

  ```java
  package com.example;
  
  import java.sql.*;
  
  public class App {
    public static void main(String[] args) {
      String DB_URL     = "jdbc:postgresql://<{{ PG }} host 1:6432,...,{{ PG }} host N:6432>/<DB name>&targetServerType=master&ssl=true&sslmode=disable";
      String DB_USER    = "<username>";
      String DB_PASS    = "<user password>";
  
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

  **Connecting:**

  ```bash
  mvn clean package && \
  java -jar target/app-0.1.0-jar-with-dependencies.jar
  ```

- Node.js

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y nodejs npm && \
  npm install pg
  ```

  **Code example for connecting via SSL:**

  `app.js`

  ```js
  "use strict"
  const fs = require('fs');
  const pg = require('pg');
  
  const config = {
    connectionString: 'postgres://<username>:<user password>@c-<cluster ID>.rw.mdb.yandexcloud.net:6432/<DB name>',
    ssl: {
      rejectUnauthorized: true,
      ca: fs.readFileSync('/home/<home directory>/.postgresql/root.crt').toString(),
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

  Unlike other connection methods, this code must specify the full path to the `root.crt` certificate for {{ PG }} in the `ca` variable.

  **Code example for connecting without SSL:**

  `app.js`

  ```js
  "use strict"
  const pg = require('pg');
  
  const config = {
    connectionString: 'postgres://<username>:<user password>@c-<cluster ID>.rw.mdb.yandexcloud.net:6432/<DB name>',
  }
  
  const conn = new pg.Client(config)
  
  conn.connect(err => {if (err) throw err})
  conn.query('SELECT version()', (err, q) => {
    if (err) throw err
    console.log(q.rows[0])
    conn.end()
  })
  ```

  You can fetch the cluster ID with a [list of clusters](../../managed-postgresql/operations/cluster-list.md#list-clusters).

  **Connecting:**

  ```bash
  node app.js
  ```

- Go

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y golang git && \
  go mod init example && go get github.com/jackc/pgx/v4
  ```

  **Code example for connecting via SSL:**

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
    host     = "<FQDN of one or multiple {{ PG }} hosts>"
    port     = 6432
    user     = "<username>"
    password = "<user password>"
    dbname   = "<DB name>"
    ca       = "/home/<home directory>/.postgresql/root.crt"
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

  Unlike other connection methods, this code must specify the full path to the `root.crt` certificate for {{ PG }} in the `ca` variable.

  **Code example for connecting without SSL:**

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
    host     = "<FQDN of one or multiple {{ PG }} hosts>"
    port     = 6432
    user     = "<username>"
    password = "<user password>"
    dbname   = "<DB name>"
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

  **Connecting:**

  ```bash
  go run connect.go
  ```

- Ruby

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y ruby ruby-pg
  ```

  **Code example for connecting via SSL:**

  `connect.rb`

  ```ruby
  require "pg"
  
  conn = PG.connect("
          host=<FQDN of one or multiple {{ PG }} hosts>
          port=6432
          dbname=<DB name>
          user=<username>
          password=<user password>
          target_session_attrs=read-write
          sslmode=verify-full
  ")
  
  q = conn.exec("SELECT version()")
  puts q.getvalue 0, 0
  
  conn.close()
  ```

  **Code example for connecting without SSL:**

  `connect.rb`

  ```ruby
  require "pg"
  
  conn = PG.connect("
          host=<FQDN of one or multiple {{ PG }} hosts>
          port=6432
          dbname=<DB name>
          user=<username>
          password=<user password>
          target_session_attrs=read-write
          sslmode=disable
  ")
  
  q = conn.exec("SELECT version()")
  puts q.getvalue 0, 0
  
  conn.close()
  ```

  **Connecting:**

  ```bash
  ruby connect.rb
  ```

- C# EfCore

  **Before connecting, install the dependencies:**

  ```bash
  Install-Package Npgsql.EntityFrameworkCore.PostgreSQL
  ```

  **Example of settings in the `appsettings.json` file for connecting via SSL:**

  ```json
  ...
  "ConnectionStrings": {
    "Default": "Server=<FQDN of one or multiple {{ PG }} hosts>;Database=<DB name>;Port=6432;User Id=<username>;Password=<user password>;Ssl Mode=Require; Trust Server Certificate=true;"
  },
  ...
  ```

- ODBC

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y unixodbc odbc-postgresql
  ```

  The {{ PG }} ODBC driver will be registered automatically in `/etc/odbcinst.ini`.

  **Example of settings in the `/etc/odbc.ini` file for connecting via SSL:**

  `odbc.ini`

  ```ini
  [postgresql]
  Driver=PostgreSQL Unicode
  Servername=<{{ PG }} host 1>,...,<{{ PG }} host N>
  Username=<username>
  Password=<user password>
  Database=<DB name>
  Port=6432
  Pqopt=target_session_attrs=read-write
  Sslmode= verify-full
  ```

  **Example of settings in the `/etc/odbc.ini` file for connecting without SSL:**

  `odbc.ini`

  ```ini
  [postgresql]
  Driver=PostgreSQL Unicode
  Servername=<{{ PG }} host 1>,...,<{{ PG }} host N>
  Username=<username>
  Password=<user password>
  Database=<DB name>
  Port=6432
  Pqopt=target_session_attrs=read-write
  ```

  **Connecting:**

  ```bash
  isql -v postgresql
  ```

  After connecting to the DBMS, run the command `SELECT version();`.

{% endlist %}

