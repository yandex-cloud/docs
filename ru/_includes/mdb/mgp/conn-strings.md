### Bash {#bash}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

Подключитесь к базе данных:

{% list tabs %}

- Подключение без SSL

  ```bash
  psql "host=c-<идентификатор кластера>.rw.{{ dns-zone }} \
        port={{ port-mgp }} \
        sslmode=disable \
        dbname=postgres \
        user=<имя пользователя> \
        target_session_attrs=read-write"
  ```

- Подключение с SSL

  {% include [default-connstring](default-connstring.md) %}

{% endlist %}

После выполнения команды введите пароль пользователя для завершения процедуры подключения.

Для проверки успешности подключения выполните запрос:

```sql
SELECT version();
```

### C# EF Core {#csharpefcore}

Необходимые пакеты:

* Microsoft.EntityFrameworkCore
* Npgsql.EntityFrameworkCore.PostgreSQL

{% list tabs %}

- Подключение с SSL

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
              var host      = "c-<идентификатор кластера>.rw.{{ dns-zone }}";
              var port      = "{{ port-mgp }}";
              var db        = "postgres";
              var username  = "<имя пользователя>";
              var password  = "<пароль пользователя>";
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

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes golang git && \
go mod init example && go get github.com/jackc/pgx/v4
```

{% list tabs %}

- Подключение без SSL

  1. Пример кода:

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
      	host     = "c-<идентификатор кластера>.rw.{{ dns-zone }}"
      	port     = {{ port-mgp }}
      	user     = "<имя пользователя>"
      	password = "<пароль пользователя>"
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

  1. Подключение:

      ```bash
      go run connect.go
      ```

- Подключение с SSL

  1. Пример кода:

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
      	host     = "c-<идентификатор кластера>.rw.{{ dns-zone }}"
      	port     = {{ port-mgp }}
      	user     = "<имя пользователя>"
      	password = "<пароль пользователя>"
      	dbname   = "postgres"
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

      При этом способе подключения в коде необходимо указывать полный путь к сертификату `root.crt` для {{ PG }} в переменной `ca`.

  1. Подключение:

      ```bash
      go run connect.go
      ```

{% endlist %}

### Java {#java}

Перед подключением:

1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install --yes default-jdk maven
    ```

1. Создайте директорию для проекта Maven:

    ```bash
    cd ~/ && mkdir --parents project/src/java/com/example && cd project/
    ```

1. Создайте конфигурационный файл для Maven:

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

    Актуальную версию `postgresql` уточняйте на [странице проекта в репозитории Maven](https://mvnrepository.com/artifact/org.postgresql/postgresql).

{% list tabs %}

- Подключение без SSL

  1. Пример кода:

      `src/java/com/example/App.java`

      ```java
      package com.example;
      
      import java.sql.*;
      
      public class App {
        public static void main(String[] args) {
          String DB_URL  = "jdbc:postgresql://c-<идентификатор кластера>.rw.{{ dns-zone }}:{{ port-mgp }}/postgres?targetServerType=master&ssl=false";
          String DB_USER = "<имя пользователя>";
          String DB_PASS = "<пароль пользователя>";
      
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

  1. Сборка и подключение:

      ```bash
      mvn clean package && \
      java -jar target/app-0.1.0-jar-with-dependencies.jar
      ```

- Подключение с SSL

  1. Пример кода:

      `src/java/com/example/App.java`

      ```java
      package com.example;

      import java.sql.*;

      public class App {
        public static void main(String[] args) {
          String DB_URL  = "jdbc:postgresql://c-<идентификатор кластера>.rw.{{ dns-zone }}:{{ port-mgp }}/postgres?targetServerType=master&ssl=true&sslmode=verify-full";
          String DB_USER = "<имя пользователя>";
          String DB_PASS = "<пароль пользователя>";

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

  1. Сборка и подключение:

      ```bash
      mvn clean package && \
      java -jar target/app-0.1.0-jar-with-dependencies.jar
      ```

{% endlist %}

### Node.js {#nodejs}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes nodejs npm && \
npm install pg
```

{% list tabs %}

- Подключение без SSL

    `app.js`

    ```javascript
    "use strict";
    const pg = require("pg");

    const config = {
        connectionString:
            "postgres://<имя пользователя>:<пароль пользователя>@c-<идентификатор кластера>.rw.{{ dns-zone }}:{{ port-mgp }}/postgres"
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

- Подключение с SSL

    `app.js`

    ```javascript
    "use strict";
    const fs = require("fs");
    const pg = require("pg");

    const config = {
        connectionString:
            "postgres://<имя пользователя>:<пароль пользователя>@c-<идентификатор кластера>.rw.{{ dns-zone }}:{{ port-mgp }}/postgres",
        ssl: {
            rejectUnauthorized: true,
            ca: fs
                .readFileSync("/home/<домашняя директория>/.postgresql/root.crt")
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

    При этом способе подключения в коде необходимо указывать полный путь к сертификату `root.crt` для {{ PG }} в переменной `ca`.

{% endlist %}

Подключение:

```bash
node app.js
```

### ODBC {#odbc}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes unixodbc odbc-postgresql
```

Драйвер {{ PG }} ODBC будет автоматически зарегистрирован в файле `/etc/odbcinst.ini`.

{% list tabs %}

- Подключение без SSL

  1. Пример кода:

      `/etc/odbc.ini`

      ```ini
      [postgresql]
      Driver=PostgreSQL Unicode
      Servername=c-<идентификатор кластера>.rw.{{ dns-zone }}
      Username=<имя пользователя>
      Password=<пароль пользователя>
      Database=postgres
      Port={{ port-mgp }}
      Pqopt=target_session_attrs=read-write
      ```

  1. Подключение:

      ```bash
      isql -v postgresql
      ```

      После подключения к СУБД выполните команду `SELECT version();`.

- Подключение с SSL

  1. Пример кода:

      `/etc/odbc.ini`

      ```ini
      [postgresql]
      Driver=PostgreSQL Unicode
      Servername=c-<идентификатор кластера>.rw.{{ dns-zone }}
      Username=<имя пользователя>
      Password=<пароль пользователя>
      Database=postgres
      Port={{ port-mgp }}
      Pqopt=target_session_attrs=read-write
      Sslmode=verify-full
      ```

  1. Подключение:

      ```bash
      isql -v postgresql
      ```

      После подключения к СУБД выполните команду `SELECT version();`.

{% endlist %}

### PHP {#php}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes php php-pgsql
```

{% list tabs %}

- Подключение без SSL

  1. Пример кода:

      `connect.php`

      ```php
      <?php
        $conn = pg_connect("
            host=c-<идентификатор кластера>.rw.{{ dns-zone }}
            port={{ port-mgp }}
            sslmode=disable
            dbname=postgres
            user=<имя пользователя>
            password=<пароль пользователя>
            target_session_attrs=read-write
        ");

      $q = pg_query($conn, "SELECT version()");
      $result = pg_fetch_row($q);
      echo $result[0];

      pg_close($conn);
      ?>
      ```

  1. Подключение:

      ```bash
      php connect.php
      ```

- Подключение с SSL

  1. Пример кода:

      `connect.php`

      ``` php
      <?php
        $conn = pg_connect("
            host=c-<идентификатор кластера>.rw.{{ dns-zone }}
            port={{ port-mgp }}
            sslmode=verify-full
            dbname=postgres
            user=<имя пользователя>
            password=<пароль пользователя>
            target_session_attrs=read-write
        ");

      $q = pg_query($conn, "SELECT version()");
      $result = pg_fetch_row($q);
      echo $result[0];

      pg_close($conn);
      ?>
      ```

  1. Подключение:

      ```bash
      php connect.php
      ```

{% endlist %}

### PowerShell {#powershell}

Перед подключением установите [{{ PG }} для Windows](https://www.postgresql.org/download/windows/) актуальной версии. Выберите только установку *Command Line Tools*.

Подключитесь к базе данных:

{% list tabs %}

- Подключение без SSL

  ```powershell
  & "C:\Program Files\PostgreSQL\<версия>\bin\psql.exe" "`
      host=c-<идентификатор кластера>.rw.{{ dns-zone }} `
      port={{ port-mgp }} `
      sslmode=disable `
      dbname=postgres `
      user=<имя пользователя>"
  ```

- Подключение c SSL

  ```powershell
  & "C:\Program Files\PostgreSQL\<версия>\bin\psql.exe" "`
      host=c-<идентификатор кластера>.rw.{{ dns-zone }} `
      port={{ port-mgp }} `
      sslmode=verify-full `
      dbname=postgres `
      user=<имя пользователя>"
  ```

{% endlist %}

После выполнения команды введите пароль пользователя для завершения процедуры подключения.

Для проверки успешности подключения выполните запрос:

```sql
SELECT version();
```

### Python {#python}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes python3 python3-pip && \
pip3 install psycopg2-binary
```

{% list tabs %}

- Подключение без SSL

  1. Пример кода:

      `connect.py`

      ```python
      import psycopg2

      conn = psycopg2.connect("""
          host=c-<идентификатор кластера>.rw.{{ dns-zone }}
          port={{ port-mgp }}
          sslmode=disable
          dbname=postgres
          user=<имя пользователя>
          password=<пароль пользователя>
          target_session_attrs=read-write
      """)

      q = conn.cursor()
      q.execute('SELECT version()')

      print(q.fetchone())

      conn.close()
      ```

  1. Подключение:

      ```bash
      python3 connect.py
      ```

- Подключение с SSL

  1. Пример кода:

      `connect.py`

      ```python
      import psycopg2

      conn = psycopg2.connect("""
          host=c-<идентификатор кластера>.rw.{{ dns-zone }}
          port={{ port-mgp }}
          sslmode=verify-full
          dbname=postgres
          user=<имя пользователя>
          password=<пароль пользователя>
          target_session_attrs=read-write
      """)

      q = conn.cursor()
      q.execute('SELECT version()')

      print(q.fetchone())

      conn.close()
      ```

  1. Подключение:

      ```bash
      python3 connect.py
      ```

{% endlist %}

### Ruby {#ruby}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes ruby ruby-pg
```

{% list tabs %}

- Подключение без SSL

  1. Пример кода:

      `connect.rb`

      ```ruby
      require "pg"

      conn = PG.connect("
              host=c-<идентификатор кластера>.rw.{{ dns-zone }}
              port={{ port-mgp }}
              dbname=postgres
              user=<имя пользователя>
              password=<пароль пользователя>
              target_session_attrs=read-write
              sslmode=disable
      ")

      q = conn.exec("SELECT version()")
      puts q.getvalue 0, 0

      conn.close()
      ```

  1. Подключение:

      ```bash
      ruby connect.rb
      ```

- Подключение с SSL

  1. Пример кода:

      `connect.rb`

      ```ruby
      require "pg"

      conn = PG.connect("
              host=c-<идентификатор кластера>.rw.{{ dns-zone }}
              port={{ port-mgp }}
              dbname=postgres
              user=<имя пользователя>
              password=<пароль пользователя>
              target_session_attrs=read-write
              sslmode=verify-full
      ")

      q = conn.exec("SELECT version()")
      puts q.getvalue 0, 0

      conn.close()
      ```

  1. Подключение:

      ```bash
      ruby connect.rb
      ```

{% endlist %}
