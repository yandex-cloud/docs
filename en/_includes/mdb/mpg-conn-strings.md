### 1C:Enterprise {#1c}

If the cluster uses a {{ PG }} version optimized to work with <q>1C:Enterprise</q>, specify in the settings:

* **Secure connection**: Disabled
* **DBMS type**: `PostgreSQL`
* **Database server**: `c-<cluster_ID>.rw.{{ dns-zone }} port={{ port-mpg }}`
* **Database name**: `<DB_name>`
* **Database user**: `<username>`
* **User password**: `<password>`
* **Create database if none present**: Disabled

### Bash {#bash}

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

   1. Connect to a database:

      ```bash
      psql "host=c-<cluster_ID>.rw.{{ dns-zone }} \
            port=6432 \
            sslmode=disable \
            dbname=<DB_name> \
            user=<username> \
            target_session_attrs=read-write"
      ```

      After running the command, enter the user password to complete the connection process.

   1. To check the connection, run this query:

      ```bash
      SELECT version();
      ```

- Connecting via SSL {#with-ssl}

   1. Connect to a database:

      {% include [default-connstring](./mpg/default-connstring.md) %}

      After running the command, enter the user password to complete the connection process.

   1. To check the connection, run this query:

      ```bash
      SELECT version();
      ```

{% endlist %}

### C# EF Core {#csharpefcore}

To connect to a cluster, you need the [Npgsql](https://www.nuget.org/packages/Npgsql/) package.

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

   ```csharp
   using Npgsql;

   namespace ConsoleApp
   {
       class Program
       {
           static async Task Main(string[] args)
           {
               var host       = "c-<cluster_ID>.rw.{{ dns-zone }}";
               var port       = "{{ port-mpg }}";
               var db         = "<DB_name>";
               var username   = "<username>";
               var password   = "<user_password>";
               var connString = $"Host={host};Port={port};Database={db};Username={username};Password={password};Ssl Mode=VerifyFull;";

               await using var conn = new NpgsqlConnection(connString);
               await conn.OpenAsync();

               await using (var cmd = new NpgsqlCommand("SELECT VERSION();", conn))
               await using (var reader = await cmd.ExecuteReaderAsync())
               {
                   while (await reader.ReadAsync())
                   {
                       Console.WriteLine(reader.GetInt32(0));
                   }
               }
           }
       }
   }
   ```

{% endlist %}

### Go {#go}

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install --yes golang git && \
go mod init example && go get github.com/jackc/pgx/v4
```

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

   1. Code example:

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
        host     = "c-<cluster_ID>.rw.{{ dns-zone }}"
        port     = 6432
        user     = "<username>"
        password = "<user_password>"
        dbname   = "<DB_name>"
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

   1. Connecting:

      ```bash
      go run connect.go
      ```

- Connecting via SSL {#with-ssl}

   1. Code example:

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
        host     = "c-<cluster_ID>.rw.{{ dns-zone }}"
        port     = 6432
        user     = "<username>"
        password = "<user_password>"
        dbname   = "<DB_name>"
        ca       = "/home/<home_directory>/.postgresql/root.crt"
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

      For this connection method, the code must include the full path to the `root.crt` certificate for {{ PG }} in the `ca` variable.

   1. Connecting:

      ```bash
      go run connect.go
      ```

{% endlist %}

### C++ userver {#userver}

Install the userver framework following the instauction as [official site](https://userver.tech/)
or use a [VM at Yandex Cloud Marketplace](https://yandex.cloud/en/marketplace/products/yc/userver).

Create your project using the service template [with gRPC](https://github.com/userver-framework/pg_grpc_service_template)
or using the service template [without gRPC](https://github.com/userver-framework/pg_service_template).

In `configs/config_vars.yaml` of your project change the `dbconnection` variable value to:

```yaml
dbconnection: postgres://<username>:<user_password>@c-<cluster_ID>.rw.{{ dns-zone }}:6432/<DB_name>"
```

You can get the cluster ID with a [list of clusters](../../managed-postgresql/operations/cluster-list.md#list-clusters).

Build the service and start it with the following commands:
```bash
make build-debug
./build_debug/pg_<grpc_>service_template -c configs/static_config.yaml --config_vars configs/config_vars.yaml
```

### Java {#java}

Before connecting:

1. Install the dependencies:

   ```bash
   sudo apt update && sudo apt install --yes default-jdk maven
   ```

1. Create a folder for the Maven project:

   ```bash
   cd ~/ && mkdir -p project/src/java/com/example && cd project/
   ```

1. Create a configuration file for Maven:

   {% cut "pom.xml" %}

   ```xml
   <?xml version="1.0" encoding="utf-8"?>
   <project xmlns="http://maven.apache.org/POM/4.0.0"
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
                   <descriptorRef>
                   jar-with-dependencies</descriptorRef>
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

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

   1. Code example:

      `src/java/com/example/App.java`

      ```java
      package com.example;

      import java.sql.*;

      public class App {
        public static void main(String[] args) {
          String DB_URL     = "jdbc:postgresql://c-<cluster_ID>.rw.{{ dns-zone }}:6432/<DB_name>?targetServerType=master&ssl=false&sslmode=disable";
          String DB_USER    = "<username>";
          String DB_PASS    = "<user_password>";

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

   1. Building and connecting:

      ```bash
      mvn clean package && \
      java -jar target/app-0.1.0-jar-with-dependencies.jar
      ```

- Connecting via SSL {#with-ssl}

   1. Code example:

      `src/java/com/example/App.java`

      ```java
      package com.example;

      import java.sql.*;

      public class App {
        public static void main(String[] args) {
          String DB_URL     = "jdbc:postgresql://c-<cluster_ID>.rw.{{ dns-zone }}:6432/<DB_name>?targetServerType=master&ssl=true&sslmode=verify-full";
          String DB_USER    = "<username>";
          String DB_PASS    = "<user_password>";

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

   1. Building and connecting:

      ```bash
      mvn clean package && \
      java -jar target/app-0.1.0-jar-with-dependencies.jar
      ```

{% endlist %}

### Node.js {#nodejs}

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install --yes nodejs npm && \
npm install pg
```

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

   `app.js`

   ```javascript
   "use strict";
   const pg = require("pg");

   const config = {
       connectionString:
           "postgres://<username>:<user_password>@c-<cluster_ID>.rw.{{ dns-zone }}:6432/<DB_name>"
   };

   const conn = new pg.Client(config);

   conn.connect((err) => {
       if (err) throw err;
   });
   conn.query("SELECT version()", (err, q) => {
       if (err) throw err;
       console.log(q.rows[0]);
       conn.end();
   });
   ```

- Connecting via SSL {#with-ssl}

   `app.js`

   ```javascript
   "use strict";
   const fs = require("fs");
   const pg = require("pg");

   const config = {
       connectionString:
           "postgres://<username>:<user_password>@c-<cluster_ID>.rw.{{ dns-zone }}:6432/<DB_name>",
       ssl: {
           rejectUnauthorized: true,
           ca: fs
               .readFileSync("/home/<home_directory>/.postgresql/root.crt")
               .toString(),
       },
   };

   const conn = new pg.Client(config);

   conn.connect((err) => {
       if (err) throw err;
   });
   conn.query("SELECT version()", (err, q) => {
       if (err) throw err;
       console.log(q.rows[0]);
       conn.end();
   });
   ```

   For this connection method, the code must include the full path to the `root.crt` certificate for {{ PG }} in the `ca` variable.

{% endlist %}

You can get the cluster ID with a [list of clusters](../../managed-postgresql/operations/cluster-list.md#list-clusters).

Connecting:

```bash
node app.js
```

### ODBC {#odbc}

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install --yes unixodbc odbc-postgresql
```

The {{ PG }} ODBC driver will be registered automatically in `/etc/odbcinst.ini`.

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

   1. Code example:

      `/etc/odbc.ini`

      ```ini
      [postgresql]
      Driver=PostgreSQL Unicode
      Servername=c-<cluster_ID>.rw.{{ dns-zone }}
      Username=<username>
      Password=<user_password>
      Database=<DB_name>
      Port=6432
      Pqopt=target_session_attrs=read-write
      ```

   1. Connecting:

      ```bash
      isql -v postgresql
      ```

      Once connected to the DBMS, run `SELECT @@version;`.

- Connecting via SSL {#with-ssl}

   1. Code example:

      `/etc/odbc.ini`

      ```ini
      [postgresql]
      Driver=PostgreSQL Unicode
      Servername=c-<cluster_ID>.rw.{{ dns-zone }}
      Username=<username>
      Password=<user_password>
      Database=<DB_name>
      Port=6432
      Pqopt=target_session_attrs=read-write
      Sslmode=verify-full
      ```

   1. Connecting:

      ```bash
      isql -v postgresql
      ```

      Once connected to the DBMS, run `SELECT @@version;`.

{% endlist %}

### PHP {#php}

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install --yes php php-pgsql
```

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

   1. Code example:

      `connect.php`

      ```php
      <?php
        $conn = pg_connect("
            host=c-<cluster_ID>.rw.{{ dns-zone }}
            port=6432
            sslmode=disable
            dbname=<DB_name>
            user=<username>
            password=<user_password>
            target_session_attrs=read-write
        ");

      $q = pg_query($conn, "SELECT version()");
      $result = pg_fetch_row($q);
      echo $result[0];

      pg_close($conn);
      ?>
      ```

   1. Connecting:

      ```bash
      php connect.php
      ```

- Connecting via SSL {#with-ssl}

   1. Code example:

      `connect.php`

      ```php
      <?php
        $conn = pg_connect("
            host=c-<cluster_ID>.rw.{{ dns-zone }}
            port=6432
            sslmode=verify-full
            dbname=<DB_name>
            user=<username>
            password=<user_password>
            target_session_attrs=read-write
        ");

      $q = pg_query($conn, "SELECT version()");
      $result = pg_fetch_row($q);
      echo $result[0];

      pg_close($conn);
      ?>
      ```

   1. Connecting:

      ```bash
      php connect.php
      ```

{% endlist %}

### PowerShell {#powershell}

Before connecting, install the same version of [{{ PG }} for Windows](https://www.postgresql.org/download/windows/) that is used in the cluster. Select the *Command Line Tools* install only.

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

   1. Set the environment variables for the connection:

      ```powershell
      $Env:PGSSLMODE="disable"; $Env:PGTARGETSESSIONATTRS="read-write"
      ```

   1. Connect to a database:

      ```powershell
      & "C:\Program Files\PostgreSQL\<version>\bin\psql.exe" `
            --host=c-<cluster_ID>.rw.{{ dns-zone }} `
            --port={{ port-mpg }} `
            --username=<username> `
            <DB_name>
      ```

      After running the command, enter the user password to complete the connection process.

   1. To check the connection, run this query:

      ```sql
      SELECT version();
      ```

- Connecting via SSL {#with-ssl}

   1. Set the environment variables for the connection:

      ```powershell
      $Env:PGSSLMODE="verify-full"; $Env:PGTARGETSESSIONATTRS="read-write"
      ```

   1. Connect to a database:

      ```powershell
      & "C:\Program Files\PostgreSQL\<version>\bin\psql.exe" `
        --host=c-<cluster_ID>.rw.{{ dns-zone }} `
        --port={{ port-mpg }} `
        --username<username> `
        <DB_name>
      ```

      After running the command, enter the user password to complete the connection process.

   1. To check the connection, run this query:

      ```sql
      SELECT version();
      ```

{% endlist %}

### Python {#python}

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install -y python3 python3-pip && \
pip3 install psycopg2-binary
```

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

   1. Code example:

      `connect.py`

      ```python
      import psycopg2

      conn = psycopg2.connect("""
          host=c-<cluster_ID>.rw.{{ dns-zone }}
          port=6432
          sslmode=disable
          dbname=<DB_name>
          user=<username>
          password=<user_password>
          target_session_attrs=read-write
      """)

      q = conn.cursor()
      q.execute('SELECT version()')

      print(q.fetchone())

      conn.close()
      ```

   1. Connecting:

      ```bash
      python3 connect.py
      ```

- Connecting via SSL {#with-ssl}

   1. Code example:

      `connect.py`

      ```python
      import psycopg2

      conn = psycopg2.connect("""
          host=c-<cluster_ID>.rw.{{ dns-zone }}
          port=6432
          sslmode=verify-full
          dbname=<DB_name>
          user=<username>
          password=<user_password>
          target_session_attrs=read-write
      """)

      q = conn.cursor()
      q.execute('SELECT version()')

      print(q.fetchone())

      conn.close()
      ```

   1. Connecting:

      ```bash
      python3 connect.py
      ```

{% endlist %}

### R {#r}

Before connecting:

1. Install the dependencies:

   ```bash
   sudo apt update && sudo apt install libpq-dev r-base --yes
   ```

1. Install the [RPostgres](https://rpostgres.r-dbi.org/) library:

   ```bash
   sudo R --interactive
   install.packages("RPostgres")
   quit()
   ```

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

   1. Code example:

      `connect.r`

      ```R
      library(DBI)

      conn <- dbConnect(RPostgres::Postgres(),
          dbname="<DB_name>",
          host="c-<cluster_ID>.rw.{{ dns-zone }}",
          port={{ port-mpg }},
          user="<username>",
          password="<user_password>"
      )

      res <- dbSendQuery(conn, "SELECT VERSION();")
      dbFetch(res)
      dbClearResult(res)

      dbDisconnect(conn)
      ```

   1. Connecting:

      ```bash
      R connect.r
      ```

- Connecting via SSL {#with-ssl}

   1. Code example:

      `connect.r`

      ```R
      library(DBI)

      conn <- dbConnect(RPostgres::Postgres(),
          dbname="<DB_name>",
          host="c-<cluster_ID>.rw.{{ dns-zone }}",
          port={{ port-mpg }},
          sslmode="verify-full",
          user="<username>",
          password="<user_password>"
      )

      res <- dbSendQuery(conn, "SELECT VERSION();")
      dbFetch(res)
      dbClearResult(res)

      dbDisconnect(conn)
      ```

   1. Connecting:

      ```bash
      R connect.r
      ```

{% endlist %}

### Ruby {#ruby}

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install --yes ruby ruby-pg
```

{% list tabs group=connection %}

- Connecting without SSL {#without-ssl}

   1. Code example:

      `connect.rb`

      ```ruby
      require "pg"

      conn = PG.connect("
              host=c-<cluster_ID>.rw.{{ dns-zone }}
              port=6432
              dbname=<DB_name>
              user=<username>
              password=<user_password>
              target_session_attrs=read-write
              sslmode=disable
      ")

      q = conn.exec("SELECT version()")
      puts q.getvalue 0, 0

      conn.close()
      ```

   1. Connecting:

      ```bash
      ruby connect.rb
      ```

- Connecting via SSL {#with-ssl}

   1. Code example:

      `connect.rb`

      ```ruby
      require "pg"

      conn = PG.connect("
              host=c-<cluster_ID>.rw.{{ dns-zone }}
              port=6432
              dbname=<DB_name>
              user=<username>
              password=<user_password>
              target_session_attrs=read-write
              sslmode=verify-full
      ")

      q = conn.exec("SELECT version()")
      puts q.getvalue 0, 0

      conn.close()
      ```

   1. Connecting:

      ```bash
      ruby connect.rb
      ```

{% endlist %}
