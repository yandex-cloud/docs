# Подключение к базе данных в кластере {{ MS }}

К хостам кластера {{ mms-short-name }} можно подключиться:

* Через интернет, если вы настроили публичный доступ для нужного хоста.
* С виртуальных машин {{ yandex-cloud }}, расположенных в той же [виртуальной сети](../../vpc/concepts/network.md).

## Примеры строк подключения {#connection-string}

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% list tabs %}

- Shell

  1. Установите зависимости:
     ```bash
     $ sudo apt update
     $ sudo apt install python3-pip python-is-python3
     $ pip3 install mssql-cli
     $ source ~/.profile
     ```

  1. По умолчанию Microsoft собирает анонимные данные об использовании клиентской утилиты `mssql-cli`, подробнее см. [документацию утилиты mssql-cli](https://github.com/dbcli/mssql-cli/blob/master/doc/telemetry_guide.md). Чтобы отключить автоматический сбор данных, выполните команду:

     ```bash
     $ export MSSQL_CLI_TELEMETRY_OPTOUT=True
     ```

  1. Подключитесь к базе данных:
     ```bash
     $ mssql-cli -U <имя пользователя> \
               -d <имя базы данных> \
               -S <FQDN хоста>,1433
     ```
     После выполнения команды введите пароль пользователя для завершения процедуры подключения.

- C#

  1. Установите зависимости:

     ```bash
     $ nuget install System.Data.SqlClient
     ```

  1. Пример кода:
     ```С#
     using System;
     using System.Data.SqlClient;

     namespace ConsoleApp1
     {
         class Program
         {
             static void Main(string[] args)
             {
                 var connetionString = "Server=<FQDN хоста>,1433;Database=<имя базы данных>;Uid=<имя пользователя>;Pwd=<пароль пользователя>;Trusted_Connection=no;Encrypt=no;";
                 var cnn = new SqlConnection(connetionString);
                 try
                 {
                     cnn.Open();
                     Console.WriteLine("Connected!");
                     cnn.Close();
                 }
                 catch (Exception e)
                 {
                     Console.WriteLine(e);
                     throw;
                 }
             }
         }
     }
     ```

- Python

  1. Установите зависимости:
     ```bash
     $ sudo apt install unixodbc unixodbc-dev
     $ pip3 install pyodbc
     $ sudo su
     $ curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
     $ curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
     $ exit
     $ sudo apt-get update
     $ sudo ACCEPT_EULA=Y apt-get install msodbcsql17
     ```

  1. Пример кода:
     {% cut "connect.py" %}
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
     {% endcut %}

  1. Проверка подключения:
     ```bash
     $ python3 connect.py
     ```
     При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MS }}.

- Java

  1. Добавьте зависимости:
     ```xml
     <dependency>
         <groupId>com.microsoft.sqlserver</groupId>
         <artifactId>mssql-jdbc</artifactId>
         <version>8.4.0.jre11</version>
     </dependency>
     ```

  1. Пример кода:
     ```java
     import java.sql.*;

     public class Main {

         public static void main(String[] args) {
             String connectionString = "jdbc:sqlserver://<FQDN хоста>:1433;" +
                     "database=<имя базы данных>;" +
                     "user=<имя пользователя>;" +
                     "password=<пароль пользователя>;" +
                     "encrypt=true;" +
                     "trustServerCertificate=false;" +
                     "loginTimeout=30;";
             try {
                 Connection connection = DriverManager.getConnection(connectionString);
             } catch (SQLException throwables) {
                 throwables.printStackTrace();
             }

         }
     }
     ```

- PHP

  1. Установите зависимости:
     ```bash
     $ sudo pecl install sqlsrv
     $ sudo pecl install pdo_sqlsrv
     ```

  1. Пример кода:
     ```php
     <?php
     $connectionInfo = array("UID" => "<имя пользователя>", "pwd" => "<пароль пользователя>", "Database" => "<имя базы данных>", "LoginTimeout" => 30, "Encrypt" => 1, "TrustServerCertificate" => 0);
     $serverName = "<FQDN хоста>,1433";
     $conn = sqlsrv_connect($serverName, $connectionInfo);
     ?>
     ```

- Go

  1. Установите зависимости:
     ```bash
     $ go get github.com/denisenkom/go-mssqldb
     ```

  1. Пример кода:
     ```go
     import (
         _ "github.com/denisenkom/go-mssqldb"
         "database/sql"
     )

     connStr := `
             server=<FQDN хоста>;
             port=1433;
             database=<имя базы данных>;
             user id=<имя пользователя>;
             password=<пароль пользователя>
     `
     conn, err := sql.Open("sqlserver", connStr)
     ```

- Node.js

  1. Установите зависимости:
     ```bash
     $ npm install tedious
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

- ODBC

   ```
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

{% endlist %}
