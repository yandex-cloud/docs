### Bash {#bash}

Перед подключением:

1. Установите зависимости:

    ```bash
    sudo apt update && \
    sudo apt install python3-pip python-is-python3 && \
    pip3 install mssql-cli && \
    source ~/.profile
    ```

1. По умолчанию Microsoft собирает анонимные данные об использовании клиентской утилиты `mssql-cli`, подробнее см. [документацию утилиты mssql-cli](https://github.com/dbcli/mssql-cli/blob/master/doc/telemetry_guide.md). Чтобы отключить автоматический сбор данных, выполните команду:     

    ```bash
    export MSSQL_CLI_TELEMETRY_OPTOUT=True
    ```

{% list tabs %}

- Подключение без SSL

  1. Подключитесь к базе данных:

      ```bash
      mssql-cli -U <имя пользователя> \
                -d <имя базы данных> \
                -S <FQDN хоста>,1433
      ```

      После выполнения команды введите пароль пользователя для завершения процедуры подключения.

  1. Для проверки успешности подключения выполните запрос:

      ```bash
      SELECT @@version;
      ```

      Будет выведена версия СУБД {{ MS }}.


- Подключение с SSL

  1. Подключитесь к базе данных:

      ```bash
      mssql-cli -U <имя пользователя> \
                -d <имя базы данных> \
                -S <FQDN хоста>,1433 \
                -N
      ```

      После выполнения команды введите пароль пользователя для завершения процедуры подключения.

  1. Для проверки успешности подключения выполните запрос:

      ```bash
      SELECT @@version;
      ```

      Будет выведена версия СУБД {{ MS }}.

{% endlist %}

### C# {#csharp}

Перед подключением установите зависимости:

```bash
sudo apt update && \
sudo apt install mono-complete nuget && \
sudo nuget update -self && \
nuget install System.Data.SqlClient
```

{% list tabs %}

- Подключение без SSL

  1. Пример кода:

      `connect.cs`

      ```csharp
      using System;
      using System.Data.SqlClient;

      namespace ConsoleApp1
      {
          class Program
          {
              static void Main(string[] args)
              {
                  var server = "<FQDN хоста>";
                  var database = "<имя базы данных>";
                  var uid = "<имя пользователя>";
                  var pwd = "<пароль пользователя>";

                  var connectionString = String.Format("Server={0},1433;Database={1};Uid={2};Pwd={3};Trusted_Connection=no;Encrypt=no;", server, database, uid, pwd);
                  SqlConnection connection = new SqlConnection(connectionString);
                  try
                  {
                      SqlCommand command = new SqlCommand("SELECT @@version;", connection);
                      connection.Open();
                      using (SqlDataReader reader = command.ExecuteReader())
                      {
                          while (reader.Read())
                          {
                              Console.WriteLine(reader[0]);
                          }
                      }
                  }
                  catch (Exception e)
                  {
                      Console.WriteLine(e);
                      throw;
                  }
                  finally
                  {
                      connection.Close();
                  }
              }
          }
      }
      ```

  1. Сборка и подключение:

      ```bash
      mcs connect.cs -r:System.Data.dll && \
      mono connect.exe
      ```

      При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MS }}.

- Подключение с SSL

  1. Пример кода:

      `connect.cs`

      ```csharp
      using System;
      using System.Data.SqlClient;

      namespace ConsoleApp1
      {
          class Program
          {
              static void Main(string[] args)
              {
                  var server = "<FQDN хоста>";
                  var database = "<имя базы данных>";
                  var uid = "<имя пользователя>";
                  var pwd = "<пароль пользователя>";

                  var connectionString = String.Format("Server={0},1433;Database={1};Uid={2};Pwd={3};Trusted_Connection=no;Encrypt=yes;", server, database, uid, pwd);
                  SqlConnection connection = new SqlConnection(connectionString);
                  try
                  {
                      SqlCommand command = new SqlCommand("SELECT @@version;", connection);
                      connection.Open();
                      using (SqlDataReader reader = command.ExecuteReader())
                      {
                          while (reader.Read())
                          {
                              Console.WriteLine(reader[0]);
                          }
                      }
                  }
                  catch (Exception e)
                  {
                      Console.WriteLine(e);
                      throw;
                  }
                  finally
                  {
                      connection.Close();
                  }
              }
          }
      }
      ```

  1. Сборка и подключение:

      ```bash
      mcs connect.cs -r:System.Data.dll && \
      mono connect.exe
      ```
      При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MS }}.

{% endlist %}

### Go {#go}

Перед подключением установите зависимости:

```bash
go get github.com/denisenkom/go-mssqldb
```

{% list tabs %}

- Подключение без SSL

  1. Пример кода:

      `connect.go`

      ```go
      package main

      import (
          _ "github.com/denisenkom/go-mssqldb"
          "database/sql"
          "fmt"
      )

      func main() {
          connStr := `
                  server=<FQDN хоста>;
                  port=1433;
                  database=<имя базы данных>;
                  user id=<имя пользователя>;
                  password=<пароль пользователя>
          `
          conn, err := sql.Open("sqlserver", connStr)
          if err != nil {
            fmt.Printf("Error creating connection: ", err.Error())
          }
          fmt.Printf("Connected!\n")
          conn.Close()
      }
      ```

  1. Подключение:

     ```bash
     go run connect.go
     ```

     При успешном подключении к кластеру будет напечатано сообщение `Connected!`.

- Подключение без SSL

  1. Пример кода:

      `connect.go`

      ```go
      package main

      import (
          _ "github.com/denisenkom/go-mssqldb"
          "database/sql"
          "fmt"
      )

      func main() {
          connStr := `
                  server=<FQDN хоста>;
                  port=1433;
                  database=<имя базы данных>;
                  user id=<имя пользователя>;
                  password=<пароль пользователя>;
                  encrypt=true;
                  TrustServerCertificate=false
          `
          conn, err := sql.Open("sqlserver", connStr)
          if err != nil {
            fmt.Printf("Error creating connection: ", err.Error())
          }
          fmt.Printf("Connected!\n")
          conn.Close()
      }
      ```

  1. Подключение:

     ```bash
     go run connect.go
     ```

     При успешном подключении к кластеру будет напечатано сообщение `Connected!`.

{% endlist %}

### Java {#java}

Перед подключением:

1. Установите зависимости:

    ```bash
    sudo apt install default-jdk maven
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
                <groupId>com.microsoft.sqlserver</groupId>
                <artifactId>mssql-jdbc</artifactId>
                <version>8.4.0.jre11</version>
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

{% list tabs %}

- Подключение без SSL

  1. Пример кода:

      `src/java/com/example/App.java`

      ```java
      package com.example;

      import java.sql.*;

      public class App {

          public static void main(String[] args) {
              String server = "<FQDN хоста>";
              String database = "<имя базы данных>";
              String user = "<имя пользователя>";
              String password = "<пароль пользователя>";

              String connectionString = String.format(
                      "jdbc:sqlserver://%s:1433;" +
                      "database=%s;" +
                      "user=%s;" +
                      "password=%s;" +
                      "encrypt=false;" +
                      "trustServerCertificate=false;" +
                      "loginTimeout=30;",
                      server, database, user, password);
              try {
                  Connection connection = DriverManager.getConnection(connectionString);
                  ResultSet q = connection.createStatement().executeQuery("SELECT @@version;");
                  if(q.next()) {System.out.println(q.getString(1));}
                  connection.close();
              } catch (SQLException throwables) {
                  throwables.printStackTrace();
              }
          }
      }
      ```

  1. Сборка и подключение:

      ```bash
      mvn clean package && \
      java -jar target/app-0.1.0-jar-with-dependencies.jar
      ```

      При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MS }}.

- Подключение с SSL

  1. Пример кода:

      `src/java/com/example/App.java`

      ```java
      package com.example;

      import java.sql.*;

      public class App {

          public static void main(String[] args) {
              String server = "<FQDN хоста>";
              String database = "<имя базы данных>";
              String user = "<имя пользователя>";
              String password = "<пароль пользователя>";

              String connectionString = String.format(
                      "jdbc:sqlserver://%s:1433;" +
                      "database=%s;" +
                      "user=%s;" +
                      "password=%s;" +
                      "encrypt=true;" +
                      "trustServerCertificate=false;" +
                      "loginTimeout=30;",
                      server, database, user, password);
              try {
                  Connection connection = DriverManager.getConnection(connectionString);
                  ResultSet q = connection.createStatement().executeQuery("SELECT @@version;");
                  if(q.next()) {System.out.println(q.getString(1));}
                  connection.close();
              } catch (SQLException throwables) {
                  throwables.printStackTrace();
              }
          }
      }
      ```

  1. Сборка и подключение:

      ```bash
      mvn clean package && \
      java -jar target/app-0.1.0-jar-with-dependencies.jar
      ```

      При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MS }}.

{% endlist %}

{% if audience == "internal" %}

### Python {#python}

  1. Установите зависимости:

      ```bash
      sudo apt install unixodbc unixodbc-dev && \
      pip3 install pyodbc && \
      curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - && \
      curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list && \
      sudo apt update && \
      sudo ACCEPT_EULA=Y apt install msodbcsql17
      ```

  1. Пример кода:

      `connect.py`

      ```python
      import pyodbc

      conn = pyodbc.connect(
          driver='{ODBC Driver 17 for SQL Server}',
          server='<FQDN хоста>,1433',
          database='<имя базы данных>',
          uid='<имя пользователя>',
          pwd='<пароль пользователя>',
          encrypt='yes',
          trust_server_certificate='no')

      cursor = conn.cursor()
      cursor.execute("SELECT @@version;")

      row = cursor.fetchone()
      while row:
          print(row[0])
          row = cursor.fetchone()

      conn.close()
      ```

  1. Подключение:

      ```bash
      python3 connect.py
      ```

      При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MS }}.

### PHP {#php}

  1. Установите зависимости:

     ```bash
     sudo apt update && \
     sudo apt install php php-dev unixodbc unixodbc-dev && \
     sudo pecl channel-update pecl.php.net && \
     sudo pecl install pdo_sqlsrv sqlsrv && \
     echo -e "; priority=20\nextension=sqlsrv.so\n" | sudo tee /etc/php/7.4/mods-available/sqlsrv.ini && \
     echo -e "; priority=30\nextension=pdo_sqlsrv.so\n" | sudo tee /etc/php/7.4/mods-available/pdo_sqlsrv.ini && \
     sudo phpenmod -v 7.4 sqlsrv pdo_sqlsrv && \
     curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - && \
     curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | sudo tee -a /etc/apt/sources.list.d/mssql-release.list > /dev/null && \
     sudo apt update && \
     sudo ACCEPT_EULA=Y apt install msodbcsql17
     ```

  1. Пример кода:

      `connect.php`

      ```php

      <?php
        function OpenConnection()
            {
                try
                {
                    $serverName = "<FQDN хоста>,1433";
                    $connectionInfo = array("UID" => "<имя пользователя>", "pwd" => "пароль пользователя", "Database" => "<имя базы данных>", "LoginTimeout" => 30, "Encrypt" => 0, "TrustServerCertificate" => 0);
                    $conn = sqlsrv_connect($serverName, $connectionInfo);
                    if($conn == false)
                        echo print_r(sqlsrv_errors(), true);
                    else
                        return $conn;
                }
                catch(Exception $e)
                {
                    echo("Error!\n");
                }
            }

        try
        {
            $conn = OpenConnection();
            $tsql = "SELECT @@version;";
            $result = sqlsrv_query($conn, $tsql);
            while($row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC))
            {
                print_r($row);
            }
            sqlsrv_free_stmt($result);
            sqlsrv_close($conn);
        }
        catch(Exception $e)
        {
            echo("Error!\n");
        }
      ?>
      ```

  1. Подключение:

      ```bash
      php connect.php
      ```

      При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MS }}.

### Node.js {#nodejs}

  1. Установите зависимости:

      ```bash
      npm install tedious
      ```

  1. Пример кода:

      ```javascript
      var Connection = require('tedious').Connection;

      var config = {
        server: '<FQDN хоста>',
        authentication: {
            type: 'default',
            options: {
                userName: '<имя пользователя>',
                password: '<пароль пользователя>'
            }
        },
        options: {
            encrypt: true,
            database: '<имя базы данных>'
        }
      }
      var connection = new Connection(config);

      connection.on('connect', function(err) {
        if (err) {
          console.log(err);
        } else {
          console.log('Connected');
        }
      });
      ```

{% endif %}

### ODBC {#odbc}

Перед подключением установите зависимости:

```bash
sudo apt install unixodbc unixodbc-dev && \
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - && \
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list && \
sudo apt update && \
sudo ACCEPT_EULA=Y apt install msodbcsql17
```

Драйвер {{ MS }} ODBC будет автоматически зарегистрирован в файле `/etc/odbcinst.ini`.

{% list tabs %}

- Подключение без SSL

  1. Пример настроек в файле `/etc/odbc.ini` для подключения:

     `odbc.ini`

     ```ini
     [sqlserver]

     Driver={ODBC Driver 17 for SQL Server};
     Server=<FQDN хоста>,1433;
     Database=<имя базы данных>;
     Uid=<имя пользователя>;
     Pwd=<пароль пользователя>;
     Encrypt=no;
     TrustServerCertificate=no;
     Connection Timeout=30;
     ```

  1. Подключение:

     ```bash
     isql -v postgresql
     ```

     После подключения к СУБД выполните команду `SELECT @@version;`.

     При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MS }}.

- Подключение с SSL

  1. Пример настроек в файле `/etc/odbc.ini` для подключения:

     `odbc.ini`

     ```ini
     [sqlserver]

     Driver={ODBC Driver 17 for SQL Server};
     Server=<FQDN хоста>,1433;
     Database=<имя базы данных>;
     Uid=<имя пользователя>;
     Pwd=<пароль пользователя>;
     Encrypt=yes;
     TrustServerCertificate=no;
     Connection Timeout=30;
     ```

  1. Подключение:

     ```bash
     isql -v postgresql
     ```

     После подключения к СУБД выполните команду `SELECT @@version;`.

     При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MS }}.

{% endlist %}
