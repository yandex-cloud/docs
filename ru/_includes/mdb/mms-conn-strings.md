{% list tabs %}

- Bash

  1. Установите зависимости:

      ```bash
      $ sudo apt update && \
      sudo apt install python3-pip python-is-python3 && \
      pip3 install mssql-cli && \
      source ~/.profile
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

  1. Для проверки успешности подключения запросите версию СУБД {{ MS }}:

      ```bash
      SELECT @@version;
      ```

- Bash (SSL)

  1. Установите зависимости:

      ```bash
      $ sudo apt update && \
      sudo apt install python3-pip python-is-python3 && \
      pip3 install mssql-cli && \
      source ~/.profile
      ```

  1. По умолчанию Microsoft собирает анонимные данные об использовании клиентской утилиты `mssql-cli`, подробнее см. [документацию утилиты mssql-cli](https://github.com/dbcli/mssql-cli/blob/master/doc/telemetry_guide.md). Чтобы отключить автоматический сбор данных, выполните команду:

      ```bash
      $ export MSSQL_CLI_TELEMETRY_OPTOUT=True
      ```

  1. Подключитесь к базе данных:

      ```bash
      $ mssql-cli -U <имя пользователя> \
                -d <имя базы данных> \
                -S <FQDN хоста>,1433 \
                -N
      ```

      После выполнения команды введите пароль пользователя для завершения процедуры подключения.

  1. Для проверки успешности подключения запросите версию СУБД {{ MS }}:

      ```bash
      SELECT @@version;
      ```

- C#

  1. Установите зависимости:

      ```bash
      $ sudo apt update && \
      sudo apt install mono-complete nuget && \
      sudo nuget update -self && \
      nuget install System.Data.SqlClient
      ```

  1. Пример кода:

      `connect.cs`

      ```С#
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
      $ mcs connect.cs -r:System.Data.dll && \
      mono connect.exe
      ```

      При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MS }}.

- C# (SSL)

  1. Установите зависимости:

      ```bash
      $ sudo apt update && \
      sudo apt install mono-complete nuget && \
      sudo nuget update -self && \
      nuget install System.Data.SqlClient
      ```

  1. Пример кода:

      `connect.cs`

      ```С#
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
      $ mcs connect.cs -r:System.Data.dll && \
      mono connect.exe
      ```
      При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MS }}.


- Java

  1. Установите зависимости:

      ```bash
      $ sudo apt install default-jdk maven
      ```

  1. Создайте директорию для проекта Maven:

      ```bash
      $ cd ~/ && mkdir -p project/src/java/com/example && cd project/
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
      $ mvn clean package && \
      java -jar target/app-0.1.0-jar-with-dependencies.jar
      ```

      При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MS }}.

- Java (SSL)

  1. Установите зависимости:

      ```bash
      $ sudo apt install default-jdk maven
      ```

  1. Добавьте SSL-сертификат в хранилище доверенных сертификатов Java (Java Key Store), чтобы драйвер {{ MS }} мог использовать этот сертификат при защищенном подключении к хостам кластера. При этом задайте пароль в параметре `-storepass` для дополнительной защиты хранилища:

      ```bash
      $ cd /etc/security && \
      sudo keytool -importcert -alias YandexCA -file /usr/local/share/ca-certificates/Yandex/YandexCA.crt -keystore ssl -storepass <пароль хранилища сертификатов> --noprompt
      ```

  1. Создайте директорию для проекта Maven:

      ```bash
      $ cd ~/ && mkdir -p project/src/java/com/example && cd project/
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
      $ mvn clean package && \
      java -jar target/app-0.1.0-jar-with-dependencies.jar
      ```

      При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ MS }}.


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

- Go (SSL)

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
              password=<пароль пользователя>;
              encrypt=true;
              TrustServerCertificate=false
      `
      conn, err := sql.Open("sqlserver", connStr)
      ```


- ODBC

  1. Установите зависимости:

      ```bash
      $ sudo apt install unixodbc unixodbc-dev && \
      curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - && \
      curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list && \
      sudo apt update && \
      sudo ACCEPT_EULA=Y apt install msodbcsql17
      ```

  1. Пример кода:

      ```
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

- ODBC (SSL)

  1. Установите зависимости:

      ```bash
      $ sudo apt install unixodbc unixodbc-dev && \
      curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - && \
      curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list && \
      sudo apt update && \
      sudo ACCEPT_EULA=Y apt install msodbcsql17
      ```

  1. Пример кода:

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