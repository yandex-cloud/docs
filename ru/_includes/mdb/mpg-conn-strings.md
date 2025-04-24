### 1C:Предприятие {#1c}

Если кластер использует версию {{ PG }}, оптимизированную для работы с системой <q>1С:Предприятие</q>, укажите в настройках:

* **Защищенное соединение** — отключено.
* **Тип СУБД** — `PostgreSQL`.
* **Сервер баз данных** — `с-<идентификатор_кластера>.rw.{{ dns-zone }} port={{ port-mpg }}`.
* **Имя базы данных** — `<имя_БД>`.
* **Пользователь базы данных** — `<имя_пользователя>`.
* **Пароль пользователя** — `<пароль>`.
* **Создать базу данных в случае ее отсутствия** — отключено.

### Bash {#bash}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes postgresql-client
```

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  1. Подключитесь к базе данных:

      ```bash
      psql "host=c-<идентификатор_кластера>.rw.{{ dns-zone }} \
            port=6432 \
            sslmode=disable \
            dbname=<имя_БД> \
            user=<имя_пользователя> \
            target_session_attrs=read-write"
      ```

      После выполнения команды введите пароль пользователя для завершения процедуры подключения.

  1. Для проверки успешности подключения выполните запрос:

      ```bash
      SELECT version();
      ```

- Подключение с SSL {#with-ssl}

  1. Подключитесь к базе данных:

      {% include [default-connstring](./mpg/default-connstring.md) %}

      После выполнения команды введите пароль пользователя для завершения процедуры подключения.

  1. Для проверки успешности подключения выполните запрос:

      ```bash
      SELECT version();
      ```

{% endlist %}


### C++ (фреймворк userver) {#cpp-userver}

Асинхронный фреймворк [userver](https://userver.tech/) предоставляет богатый набор абстракций для создания утилит, сервисов и микросервисов на языке C++. В том числе фреймворк предоставляет возможности для взаимодействия с {{ PG }}.

Перед подключением получите доступ к фреймворку одним из способов:

* [Создайте виртуальную машину](../../compute/operations/images-with-pre-installed-software/create.md) {{ compute-full-name }} из [образа userver](https://yandex.cloud/ru/marketplace/products/yc/userver). Этот образ уже содержит фреймворк и все необходимые зависимости.
* [Вручную установите фреймворк и все необходимые зависимости](https://userver.tech/docs/v2.0/d3/da9/md_en_2userver_2tutorial_2build.html).

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    1. Создайте проект на основе [шаблона для сервиса](https://github.com/userver-framework/pg_service_template).

    1. Измените конфигурационный файл `configs/config_vars.yaml`. В качестве значения переменной `dbconnection` укажите строку подключения к кластеру {{ PG }}:

        ```url
        postgres://<имя_пользователя>:<пароль_пользователя>@c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mpg }}/<имя_БД>
        ```

    1. Соберите проект и запустите сервис:

        ```bash
        make build-debug && \
        ./build_debug/pg_service_template -c configs/static_config.yaml --config_vars configs/config_vars.yaml
        ```

- Подключение с SSL {#with-ssl}

    1. Создайте проект на основе [шаблона для сервиса](https://github.com/userver-framework/pg_service_template).

    1. Измените конфигурационный файл `configs/config_vars.yaml`. В качестве значения переменной `dbconnection` укажите строку подключения к кластеру {{ PG }}:

        ```url
        postgres://<имя_пользователя>:<пароль_пользователя>@c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mpg }}/<имя_БД>?ssl=true&sslmode=verify-full
        ```

    1. Соберите проект и запустите сервис:

        ```bash
        make build-debug && \
        ./build_debug/pg_service_template -c configs/static_config.yaml --config_vars configs/config_vars.yaml
        ```

{% endlist %}

После запуска сервис будет ожидать поступления POST-запроса от пользователя. В ходе ожидания запроса сервис будет периодически проверять доступность кластера {{ PG }}, выполняя запрос `SELECT 1 as ping`. Информация об этом содержится в логах работы сервиса.

{% cut "Пример содержимого логов при успешном подключении к кластеру" %}

```text
tskv ... level=INFO      module=MakeQuerySpan ( userver/postgresql/src/storages/postgres/detail/connection_impl.cpp:647 )
...
db_statement=SELECT 1 AS ping
db_type=postgres
db_instance=********
peer_address=c-********.rw.{{ dns-zone }}:{{ port-mpg }}
...
```

{% endcut %}

### C# EF Core {#csharpefcore}

Для подключения к кластеру необходим пакет [Npgsql](https://www.nuget.org/packages/Npgsql/).

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

  ```csharp
  using Npgsql;

  namespace ConsoleApp
  {
      class Program
      {
          static async Task Main(string[] args)
          {
              var host       = "c-<идентификатор_кластера>.rw.{{ dns-zone }}";
              var port       = "{{ port-mpg }}";
              var db         = "<имя_БД>";
              var username   = "<имя_пользователя>";
              var password   = "<пароль_пользователя>";
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

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes golang git && \
go mod init example && go get github.com/jackc/pgx/v4
```

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

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
        host     = "c-<идентификатор_кластера>.rw.{{ dns-zone }}"
        port     = 6432
        user     = "<имя_пользователя>"
        password = "<пароль_пользователя>"
        dbname   = "<имя_БД>"
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

- Подключение с SSL {#with-ssl}

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
        host     = "c-<идентификатор_кластера>.rw.{{ dns-zone }}"
        port     = 6432
        user     = "<имя_пользователя>"
        password = "<пароль_пользователя>"
        dbname   = "<имя_БД>"
        ca       = "/home/<домашняя_директория>/.postgresql/root.crt"
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
              ServerName: "c-<идентификатор_кластера>.rw.{{ dns-zone }}",
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
    cd ~/ && mkdir -p project/src/java/com/example && cd project/
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

    Актуальная версия зависимости для Maven: [postgresql](https://mvnrepository.com/artifact/org.postgresql/postgresql).

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  1. Пример кода:

      `src/java/com/example/App.java`

      ```java
      package com.example;

      import java.sql.*;

      public class App {
        public static void main(String[] args) {
          String DB_URL     = "jdbc:postgresql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:6432/<имя_БД>?targetServerType=master&ssl=false&sslmode=disable";
          String DB_USER    = "<имя_пользователя>";
          String DB_PASS    = "<пароль_пользователя>";

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

  1. Сборка и подключение:

      ```bash
      mvn clean package && \
      java -jar target/app-0.1.0-jar-with-dependencies.jar
      ```

- Подключение с SSL {#with-ssl}

  1. Пример кода:

      `src/java/com/example/App.java`

      ```java
      package com.example;

      import java.sql.*;

      public class App {
        public static void main(String[] args) {
          String DB_URL     = "jdbc:postgresql://c-<идентификатор_кластера>.rw.{{ dns-zone }}:6432/<имя_БД>?targetServerType=master&ssl=true&sslmode=verify-full";
          String DB_USER    = "<имя_пользователя>";
          String DB_PASS    = "<пароль_пользователя>";

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

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    `app.js`

    ```javascript
    "use strict";
    const pg = require("pg");

    const config = {
        connectionString:
            "postgres://<имя_пользователя>:<пароль_пользователя>@c-<идентификатор_кластера>.rw.{{ dns-zone }}:6432/<имя_БД>"
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

- Подключение с SSL {#with-ssl}

    `app.js`

    ```javascript
    "use strict";
    const fs = require("fs");
    const pg = require("pg");

    const config = {
        connectionString:
            "postgres://<имя_пользователя>:<пароль_пользователя>@c-<идентификатор_кластера>.rw.{{ dns-zone }}:6432/<имя_БД>",
        ssl: {
            rejectUnauthorized: true,
            ca: fs
                .readFileSync("/home/<домашняя_директория>/.postgresql/root.crt")
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

Идентификатор кластера можно получить со [списком кластеров](../../managed-postgresql/operations/cluster-list.md#list-clusters).

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

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  1. Пример кода:

      `/etc/odbc.ini`

      ```ini
      [postgresql]
      Driver=PostgreSQL Unicode
      Servername=c-<идентификатор_кластера>.rw.{{ dns-zone }}
      Username=<имя_пользователя>
      Password=<пароль_пользователя>
      Database=<имя_БД>
      Port=6432
      Pqopt=target_session_attrs=read-write
      ```

  1. Подключение:

      ```bash
      isql -v postgresql
      ```

      После подключения к СУБД выполните команду `SELECT version();`.

- Подключение с SSL {#with-ssl}

  1. Пример кода:

      `/etc/odbc.ini`

      ```ini
      [postgresql]
      Driver=PostgreSQL Unicode
      Servername=c-<идентификатор_кластера>.rw.{{ dns-zone }}
      Username=<имя_пользователя>
      Password=<пароль_пользователя>
      Database=<имя_БД>
      Port=6432
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

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  1. Пример кода:

      `connect.php`

      ```php
      <?php
        $conn = pg_connect("
            host=c-<идентификатор_кластера>.rw.{{ dns-zone }}
            port=6432
            sslmode=disable
            dbname=<имя_БД>
            user=<имя_пользователя>
            password=<пароль_пользователя>
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

- Подключение с SSL {#with-ssl}

  1. Пример кода:

      `connect.php`

      ``` php
      <?php
        $conn = pg_connect("
            host=c-<идентификатор_кластера>.rw.{{ dns-zone }}
            port=6432
            sslmode=verify-full
            dbname=<имя_БД>
            user=<имя_пользователя>
            password=<пароль_пользователя>
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

Перед подключением установите [{{ PG }} для Windows](https://www.postgresql.org/download/windows/) той же версии, которая используется в кластере. Выберите только установку *Command Line Tools*.

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  1. Установите переменные окружения для подключения:

     ```powershell
     $Env:PGSSLMODE="disable"; $Env:PGTARGETSESSIONATTRS="read-write"
     ```

  1. Подключитесь к базе данных:

     ```powershell
     & "C:\Program Files\PostgreSQL\<версия>\bin\psql.exe" `
           --host=c-<идентификатор_кластера>.rw.{{ dns-zone }} `
           --port={{ port-mpg }} `
           --username=<имя_пользователя> `
           <имя_БД>
     ```

     После выполнения команды введите пароль пользователя для завершения процедуры подключения.

  1. Для проверки успешности подключения выполните запрос:

     ```sql
     SELECT version();
     ```

- Подключение с SSL {#with-ssl}

  1. Установите переменные окружения для подключения:

      ```powershell
      $Env:PGSSLMODE="verify-full"; $Env:PGTARGETSESSIONATTRS="read-write"
      ```

  1. Подключитесь к базе данных:

      ```powershell
      & "C:\Program Files\PostgreSQL\<версия>\bin\psql.exe" `
        --host=c-<идентификатор_кластера>.rw.{{ dns-zone }} `
        --port={{ port-mpg }} `
        --username<имя_пользователя> `
        <имя_БД>
      ```

      После выполнения команды введите пароль пользователя для завершения процедуры подключения.

  1. Для проверки успешности подключения выполните запрос:

     ```sql
     SELECT version();
     ```

{% endlist %}

### Python {#python}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install -y python3 python3-pip && \
pip3 install psycopg2-binary
```

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  1. Пример кода:

      `connect.py`

      ```python
      import psycopg2

      conn = psycopg2.connect("""
          host=c-<идентификатор_кластера>.rw.{{ dns-zone }}
          port=6432
          sslmode=disable
          dbname=<имя_БД>
          user=<имя_пользователя>
          password=<пароль_пользователя>
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

- Подключение с SSL {#with-ssl}

  1. Пример кода:

      `connect.py`

      ```python
      import psycopg2

      conn = psycopg2.connect("""
          host=c-<идентификатор_кластера>.rw.{{ dns-zone }}
          port=6432
          sslmode=verify-full
          dbname=<имя_БД>
          user=<имя_пользователя>
          password=<пароль_пользователя>
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

### R {#r}

Перед подключением:

1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install libpq-dev r-base --yes
    ```

1. Установите библиотеку [RPostgres](https://rpostgres.r-dbi.org/):

    ```bash
    sudo R --interactive
    install.packages("RPostgres")
    quit()
    ```

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    1. Пример кода:

        `connect.r`

        ```R
        library(DBI)

        conn <- dbConnect(RPostgres::Postgres(),
            dbname="<имя_БД>",
            host="c-<идентификатор_кластера>.rw.{{ dns-zone }}",
            port={{ port-mpg }},
            user="<имя_пользователя>",
            password="<пароль_пользователя>"
        )

        res <- dbSendQuery(conn, "SELECT VERSION();")
        dbFetch(res)
        dbClearResult(res)

        dbDisconnect(conn)
        ```

    1. Подключение:

        ```bash
        R connect.r
        ```

- Подключение с SSL {#with-ssl}

    1. Пример кода:

        `connect.r`

        ```R
        library(DBI)

        conn <- dbConnect(RPostgres::Postgres(),
            dbname="<имя_БД>",
            host="c-<идентификатор_кластера>.rw.{{ dns-zone }}",
            port={{ port-mpg }},
            sslmode="verify-full",
            user="<имя_пользователя>",
            password="<пароль_пользователя>"
        )

        res <- dbSendQuery(conn, "SELECT VERSION();")
        dbFetch(res)
        dbClearResult(res)

        dbDisconnect(conn)
        ```

    1. Подключение:

        ```bash
        R connect.r
        ```

{% endlist %}

### Ruby {#ruby}

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes ruby ruby-pg
```

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

  1. Пример кода:

      `connect.rb`

      ```ruby
      require "pg"

      conn = PG.connect("
              host=c-<идентификатор_кластера>.rw.{{ dns-zone }}
              port=6432
              dbname=<имя_БД>
              user=<имя_пользователя>
              password=<пароль_пользователя>
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

- Подключение с SSL {#with-ssl}

  1. Пример кода:

      `connect.rb`

      ```ruby
      require "pg"

      conn = PG.connect("
              host=c-<идентификатор_кластера>.rw.{{ dns-zone }}
              port=6432
              dbname=<имя_БД>
              user=<имя_пользователя>
              password=<пароль_пользователя>
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
