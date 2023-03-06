### Bash {#bash}

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

Connect to a database:

{% list tabs %}

- Connecting without using SSL

   ```bash
   psql "host=c-<cluster ID>.rw.{{ dns-zone }} \
         port={{ port-mgp }} \
         sslmode=disable \
         dbname=postgres \
         user=<username> \
         target_session_attrs=read-write"
   ```

- Connecting via SSL

   {% include [default-connstring](default-connstring.md) %}

{% endlist %}

After running the command, enter the user password to complete the connection procedure.

To check the connection, run the following query:

```sql
SELECT version();
```

### C# EF Core {#csharpefcore}

Required packages:

* Microsoft.EntityFrameworkCore
* Npgsql.EntityFrameworkCore.PostgreSQL

{% list tabs %}

- Connecting via SSL

   ```csharp
   using System;
   using System.Threading.Tasks;
   using Microsoft.EntityFrameworkCore;

   namespace ConsoleApp
   {
       public class VersionString
       {
           public int id { get; set; }
           public string versionString { get; set; }
       }
       public class ApplicationContext : DbContext
       {
           public ApplicationContext()
           {
               Database.EnsureCreated();
           }
           protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
           {
               var host      = "c-<cluster ID>.rw.{{ dns-zone }}";
               var port      = "{{ port-mgp }}";
               var db        = "postgres";
               var username  = "<username>";
               var password  = "<user password>";
               optionsBuilder.UseNpgsql($"Host={host};Port={port};Database={db};Username={username};Password={password};Ssl Mode=Require;Trust Server Certificate=true;");
           }
           public DbSet<VersionString> VersionStrings { get; set; }

       }
       class Program
       {
           static async Task Main(string[] args)
           {
               using (ApplicationContext db = new ApplicationContext())
               {
                   var versionStrings = await db.VersionStrings.FromSqlRaw(@"select 1 as id,version() as versionString;").ToListAsync();
                   Console.WriteLine(versionStrings[0].versionString);
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

{% list tabs %}

- Connecting without using SSL

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
      	host     = "c-<cluster ID>.rw.{{ dns-zone }}"
      	port     = {{ port-mgp }}
      	user     = "<username>"
      	password = "<user password>"
      	dbname   = "postgres"
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

- Connecting via SSL

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
      	host     = "c-<cluster ID>.rw.{{ dns-zone }}"
      	port     = {{ port-mgp }}
      	user     = "<username>"
      	password = "<user password>"
      	dbname   = "postgres"
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

      For this connection method, the code must include the full path to the `root.crt` certificate for {{ PG }} in the `ca` variable.

   1. Connecting:

      ```bash
      go run connect.go
      ```

{% endlist %}

### Java {#java}

Before connecting:

1. Install the dependencies:

   ```bash
   sudo apt update && sudo apt install --yes default-jdk maven
   ```

1. Create a folder for the Maven project:

   ```bash
   cd ~/ && mkdir --parents project/src/java/com/example && cd project/
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

   You can check the current `postgresql` version on the [project page in the Maven repository](https://mvnrepository.com/artifact/org.postgresql/postgresql).

{% list tabs %}

- Connecting without using SSL

   1. Code example:

      `src/java/com/example/App.java`

      ```java
      package com.example;

      import java.sql.*;

      public class App {
        public static void main(String[] args) {
          String DB_URL  = "jdbc:postgresql://c-<cluster ID>.rw.{{ dns-zone }}:{{ port-mgp }}/postgres?targetServerType=master&ssl=false&sslmode=disable";
          String DB_USER = "<username>";
          String DB_PASS = "<user password>";

          try {
            Class.forName("org.postgresql.Driver");

            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            ResultSet q = conn.createStatement().executeQuery("SELECT version()");
            if (q.next()) {
              System.out.println(q.getString(1));
            }

            conn.close();
          } catch (Exception ex) {
            ex.printStackTrace();
          }
        }
      }
      ```

   1. Building and connecting:

      ```bash
      mvn clean package && \
      java -jar target/app-0.1.0-jar-with-dependencies.jar
      ```

- Connecting via SSL

   1. Code example:

      `src/java/com/example/App.java`

      ```java
      package com.example;

      import java.sql.*;

      public class App {
        public static void main(String[] args) {
          String DB_URL  = "jdbc:postgresql://c-<cluster ID>.rw.{{ dns-zone }}:{{ port-mgp }}/postgres?targetServerType=master&ssl=true&sslmode=verify-full";
          String DB_USER = "<username>";
          String DB_PASS = "<user password>";

          try {
            Class.forName("org.postgresql.Driver");

            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            ResultSet q = conn.createStatement().executeQuery("SELECT version()");
            if (q.next()) {
              System.out.println(q.getString(1));
            }

            conn.close();
          } catch (Exception ex) {
            ex.printStackTrace();
          }
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

{% list tabs %}

- Connecting without using SSL

   `app.js`

   ```javascript
   "use strict";
   const pg = require("pg");

   const config = {
       connectionString:
           "postgres://<username>:<user password>@c-<cluster ID>.rw.{{ dns-zone }}:{{ port-mgp }}/postgres"
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

- Connecting via SSL

   `app.js`

   ```javascript
   "use strict";
   const fs = require("fs");
   const pg = require("pg");

   const config = {
       connectionString:
           "postgres://<username>:<user password>@c-<cluster ID>.rw.{{ dns-zone }}:{{ port-mgp }}/postgres",
       ssl: {
           rejectUnauthorized: true,
           ca: fs
               .readFileSync("/home/<home directory>/.postgresql/root.crt")
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

{% list tabs %}

- Connecting without using SSL

   1. Code example:

      `/etc/odbc.ini`

      ```ini
      [postgresql]
      Driver=PostgreSQL Unicode
      Servername=c-<cluster ID>.rw.{{ dns-zone }}
      Username=<username>
      Password=<user password>
      Database=postgres
      Port={{ port-mgp }}
      Pqopt=target_session_attrs=read-write
      ```

   1. Connecting:

      ```bash
      isql -v postgresql
      ```

      Once connected to the DBMS, run `SELECT @@version;`.

- Connecting via SSL

   1. Code example:

      `/etc/odbc.ini`

      ```ini
      [postgresql]
      Driver=PostgreSQL Unicode
      Servername=c-<cluster ID>.rw.{{ dns-zone }}
      Username=<username>
      Password=<user password>
      Database=postgres
      Port={{ port-mgp }}
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

{% list tabs %}

- Connecting without using SSL

   1. Code example:

      `connect.php`

      ```php
      <?php
        $conn = pg_connect("
            host=c-<cluster ID>.rw.{{ dns-zone }}
            port={{ port-mgp }}
            sslmode=disable
            dbname=postgres
            user=<username>
            password=<user password>
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

- Connecting via SSL

   1. Code example:

      `connect.php`

      ```php
      <?php
        $conn = pg_connect("
            host=c-<cluster ID>.rw.{{ dns-zone }}
            port={{ port-mgp }}
            sslmode=verify-full
            dbname=postgres
            user=<username>
            password=<user password>
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

Before connecting, install the current version of [{{ PG }} for Windows](https://www.postgresql.org/download/windows/). Select the *Command Line Tools* install only.

Connect to a database:

{% list tabs %}

- Connecting without using SSL

   ```powershell
   & "C:\Program Files\PostgreSQL\<version>\bin\psql.exe" "`
       host=c-<cluster ID>.rw.{{ dns-zone }} `
       port={{ port-mgp }} `
       sslmode=disable `
       dbname=postgres `
       user=<username>"
   ```

- Connecting with SSL

   ```powershell
   & "C:\Program Files\PostgreSQL\<version>\bin\psql.exe" "`
       host=c-<cluster ID>.rw.{{ dns-zone }} `
       port={{ port-mgp }} `
       sslmode=verify-full `
       dbname=postgres `
       user=<username>"
   ```

{% endlist %}

After running the command, enter the user password to complete the connection procedure.

To check the connection, run the following query:

```sql
SELECT version();
```

### Python {#python}

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install --yes python3 python3-pip && \
pip3 install psycopg2-binary
```

{% list tabs %}

- Connecting without using SSL

   1. Code example:

      `connect.py`

      ```python
      import psycopg2

      conn = psycopg2.connect("""
          host=c-<cluster ID>.rw.{{ dns-zone }}
          port={{ port-mgp }}
          sslmode=disable
          dbname=postgres
          user=<username>
          password=<user password>
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

- Connecting via SSL

   1. Code example:

      `connect.py`

      ```python
      import psycopg2

      conn = psycopg2.connect("""
          host=c-<cluster ID>.rw.{{ dns-zone }}
          port={{ port-mgp }}
          sslmode=verify-full
          dbname=postgres
          user=<username>
          password=<user password>
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

### Ruby {#ruby}

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install --yes ruby ruby-pg
```

{% list tabs %}

- Connecting without using SSL

   1. Code example:

      `connect.rb`

      ```ruby
      require "pg"

      conn = PG.connect("
              host=c-<cluster ID>.rw.{{ dns-zone }}
              port={{ port-mgp }}
              dbname=postgres
              user=<username>
              password=<user password>
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

- Connecting via SSL

   1. Code example:

      `connect.rb`

      ```ruby
      require "pg"

      conn = PG.connect("
              host=c-<cluster ID>.rw.{{ dns-zone }}
              port={{ port-mgp }}
              dbname=postgres
              user=<username>
              password=<user password>
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
