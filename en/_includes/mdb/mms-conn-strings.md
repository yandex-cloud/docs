### Bash {#bash}

Before connecting:

1. Install the dependencies:

    ```bash
    sudo apt update && \
    sudo apt install python3-pip python-is-python3 && \
    pip3 install mssql-cli && \
    source ~/.profile
    ```

1. By default, Microsoft collects anonymous data about the use of the `mssql-cli` client utility. For more information, see the [mssql-cli documentation](https://github.com/dbcli/mssql-cli/blob/master/doc/telemetry_guide.md). To disable automatic data collection, run:

    ```bash
    export MSSQL_CLI_TELEMETRY_OPTOUT=True
    ```

{% list tabs %}

- Connecting without using SSL

  1. Connect to a database:

      ```bash
      mssql-cli -U <username> \
                -d <database name> \
                -S <FQDN of the host>,1433
      ```

      After running the command, enter the user password to complete the connection procedure.

  1. To check the connection, run the following query:

      ```bash
      SELECT @@version;
      ```

      The {{ MS }} DBMS version will be displayed.

- Connecting via SSL

  1. Connect to a database:

      {% include [default-connstring](./mms/default-connstring.md) %}

      After running the command, enter the user password to complete the connection procedure.

  1. To check the connection, run the following query:

      ```bash
      SELECT @@version;
      ```

      The {{ MS }} DBMS version will be displayed.

{% endlist %}

### C# {#csharp}

Before connecting, install the dependencies:

```bash
sudo apt update && \
sudo apt install mono-complete nuget && \
sudo nuget update -self && \
nuget install System.Data.SqlClient
```

{% list tabs %}

- Connecting without using SSL

  1. Code example:

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
                  var server = "<host FQDN>";
                  var database = "<database name>";
                  var uid = "<username>";
                  var pwd = "<user password>";
      
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

  1. Building and connecting:

      ```bash
      mcs connect.cs -r:System.Data.dll && \
      mono connect.exe
      ```

      If the connection to the cluster and the test query are successful, the {{ MS }} version is output.

- Connecting via SSL

  1. Code example:

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
                  var server = "<host FQDN>";
                  var database = "<database name>";
                  var uid = "<username>";
                  var pwd = "<user password>";
      
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

  1. Building and connecting:

      ```bash
      mcs connect.cs -r:System.Data.dll && \
      mono connect.exe
      ```

      If the connection to the cluster and the test query are successful, the {{ MS }} version is output.

{% endlist %}

### Go {#go}

Before connecting, install the dependencies:

```bash
go get github.com/denisenkom/go-mssqldb
```

{% list tabs %}

- Connecting without using SSL

  1. Code example:

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
                  server=<FQDN of the host>;
                  port=1433;
                  database=<database name>;
                  user id=<username>;
                  password=<user password>
          `
          conn, err := sql.Open("sqlserver", connStr)
          if err != nil {
            fmt.Printf("Error creating connection: ", err.Error())
          }
          fmt.Printf("Connected!\n")
          conn.Close()
      }
      ```

  1. Connecting:

     ```bash
     go run connect.go
     ```

     If you are connected to the cluster, a message will display saying `Connected!`.

- Connecting via SSL

  1. Code example:

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
                  server=<FQDN of the host>;
                  port=1433;
                  database=<database name>;
                  user id=<username>;
                  password=<user password>;
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

  1. Connecting:

     ```bash
     go run connect.go
     ```

     If you are connected to the cluster, a message will display saying `Connected!`.

{% endlist %}

### Java {#java}

Before connecting:

1. Install the dependencies:

    ```bash
    sudo apt install default-jdk maven
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

- Connecting without using SSL

  1. Code example:

      `src/java/com/example/App.java`

      ```java
      package com.example;
      
      import java.sql.*;
      
      public class App {
      
          public static void main(String[] args) {
              String server = "<FQDN of the host>";
              String database = "<database name>";
              String user = "<username>";
              String password = "<user password>";
      
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

  1. Building and connecting:

      ```bash
      mvn clean package && \
      java -jar target/app-0.1.0-jar-with-dependencies.jar
      ```

      If the connection to the cluster and the test query are successful, the {{ MS }} version is output.

- Connecting via SSL

  1. Code example:

      `src/java/com/example/App.java`

      ```java
      package com.example;
      
      import java.sql.*;
      
      public class App {
      
          public static void main(String[] args) {
              String server = "<FQDN of the host>";
              String database = "<database name>";
              String user = "<username>";
              String password = "<user password>";
      
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

  1. Building and connecting:

      ```bash
      mvn clean package && \
      java -jar target/app-0.1.0-jar-with-dependencies.jar
      ```

      If the connection to the cluster and the test query are successful, the {{ MS }} version is output.

{% endlist %}

{% if audience == "internal" %}

### Python {#python}

  1. Install the dependencies:

      ```bash
      sudo apt install unixodbc unixodbc-dev && \
      pip3 install pyodbc && \
      curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - && \
      curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list && \
      sudo apt update && \
      sudo ACCEPT_EULA=Y apt install msodbcsql17
      ```

  1. Code example:

      `connect.py`

      ```python
      import pyodbc
      
      conn = pyodbc.connect(
          driver='{ODBC Driver 17 for SQL Server}',
          server='<host FQDN>,1433',
          database='<database name>',
          uid='<username>',
          pwd='<user password>',
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

  1. Connecting:

      ```bash
      python3 connect.py
      ```

      If the connection to the cluster and the test query are successful, the {{ MS }} version is output.

### PHP {#php}

  1. Install the dependencies:

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

  1. Code example:

      `connect.php`

      ```php
      
      <?php
        function OpenConnection()
            {
                try
                {
                    $serverName = "<host FQDN>,1433";
                    $connectionInfo = array("UID" => "<username>", "pwd" => "user password", "Database" => "<database name>", "LoginTimeout" => 30, "Encrypt" => 0, "TrustServerCertificate" => 0);
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

  1. Connecting:

      ```bash
      php connect.php
      ```

      If the connection to the cluster and the test query are successful, the {{ MS }} version is output.

### Node.js {#nodejs}

  1. Install the dependencies:

      ```bash
      npm install tedious
      ```

  1. Code example:

      ```javascript
      var Connection = require('tedious').Connection;
      
      var config = {
        server: '<FQDN of the host>',
        authentication: {
            type: 'default',
            options: {
                userName: '<username>',
                password: '<user password>'
            }
        },
        options: {
            encrypt: true,
            database: '<database name>'
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

Before connecting, install the dependencies:

```bash
sudo apt install unixodbc unixodbc-dev && \
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - && \
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list && \
sudo apt update && \
sudo ACCEPT_EULA=Y apt install msodbcsql17
```

The {{ MS }} ODBC driver will be registered automatically in `/etc/odbcinst.ini`.

{% list tabs %}

- Connecting without using SSL

  1. Example `/etc/odbc.ini` connection configuration file:

     `odbc.ini`

     ```ini
     [sqlserver]
     
     Driver={ODBC Driver 17 for SQL Server};
     Server=<FQDN of the host>,1433;
     Database=<database name>;
     Uid=<username>;
     Pwd=<user password>;
     Encrypt=no;
     TrustServerCertificate=no;
     Connection Timeout=30;
     ```

  1. Connecting:

     ```bash
     isql -v postgresql
     ```

     Once connected to the DBMS, run `SELECT @@version;`.

     If the connection to the cluster and the test query are successful, the {{ MS }} version is output.

- Connecting via SSL

  1. Example `/etc/odbc.ini` connection configuration file:

     `odbc.ini`

     ```ini
     [sqlserver]
     
     Driver={ODBC Driver 17 for SQL Server};
     Server=<FQDN of the host>,1433;
     Database=<database name>;
     Uid=<username>;
     Pwd=<user password>;
     Encrypt=yes;
     TrustServerCertificate=no;
     Connection Timeout=30;
     ```

  1. Connecting:

     ```bash
     isql -v postgresql
     ```

     Once connected to the DBMS, run `SELECT @@version;`.

     If the connection to the cluster and the test query are successful, the {{ MS }} version is output.

{% endlist %}

### PowerShell {#powershell}

Before connecting:

1. Install [Python and pip](https://www.python.org/downloads/).
You must specify Python in the PATH environment variable.

1. Run PowerShell as an administrator.

1. Install the dependencies:

    ```powershell
    pip install mssql-cli
    ```

1. By default, Microsoft collects anonymous data about the use of the `mssql-cli` client utility. For more information, see the [mssql-cli documentation](https://github.com/dbcli/mssql-cli/blob/master/doc/telemetry_guide.md). To disable automatic data collection, run:

    ```powershell
    set MSSQL_CLI_TELEMETRY_OPTOUT=True
    ```

{% list tabs %}

- Connecting without using SSL

  1. Connect to a database:

      ```powershell
      mssql-cli -U <username> `
                -d <database name> `
                -S <FQDN of the host>,1433
      ```

      After running the command, enter the user password to complete the connection procedure.

  1. To check the connection, run the following query:

      ```powershell
      SELECT @@version;
      ```

      The {{ MS }} DBMS version will be displayed.

- Connecting via SSL

  1. Connect to a database:

      ```powershell
      mssql-cli -U <username> `
                -d <database name> `
                -S <host FQDN>,1433 `
                -N -C
      ```

      After running the command, enter the user password to complete the connection procedure.

  1. To check the connection, run the following query:

      ```powershell
      SELECT @@version;
      ```

      The {{ MS }} DBMS version will be displayed.

{% endlist %}
