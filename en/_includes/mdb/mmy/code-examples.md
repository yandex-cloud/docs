### Bash

Before connecting, install the `mysql` utility:

```bash
sudo apt update && sudo apt install --yes mysql-client
```

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

  {% include [default-connstring](default-connstring.md) %}

- Connecting without SSL {#without-ssl}

  ```bash
  mysql --host=<FQDN_of_any_{{ MY }}_host> \
        --port={{ port-mmy }} \
        --ssl-mode=DISABLED \
        --user=<username> \
        --password \
        <DB_name>
  ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

When running any command, enter the DB user password.

After connecting to the DBMS, run the `SELECT version();` command.

{% include [Successful connection](successful-connect.md) %}

### Go

Before connecting, install the following dependencies:

```bash
sudo apt update && sudo apt install --yes golang git && \
go get github.com/go-sql-driver/mysql
```

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

  `connect.go`

  ```go
  package main

  import (
    "io/ioutil"
    "crypto/tls"
    "crypto/x509"
    "database/sql"
    "fmt"
    "github.com/go-sql-driver/mysql"
  )

  const (
    host     = "<FQDN_of_any_{{ MY }}_host>"
    port     = {{ port-mmy }}
    user     = "<username>"
    password = "<user_password>"
    dbname   = "<DB_name>"
  )

  func main() {
    rootCertPool := x509.NewCertPool()
    pem, err := ioutil.ReadFile("/home/<home_directory>/.mysql/root.crt")
    if err != nil {
      panic(err)
    }
    if ok := rootCertPool.AppendCertsFromPEM(pem); !ok {
      panic("Failed to append PEM.")
    }

    mysql.RegisterTLSConfig("custom", &tls.Config{
      RootCAs: rootCertPool,
    })

    mysqlInfo := fmt.Sprintf("%s:%s@tcp(%s:%d)/%s?tls=custom",
      user, password, host, port, dbname)
    conn, err := sql.Open("mysql", mysqlInfo)
    if err != nil {
      panic(err)
    }

    defer conn.Close()

    q, err := conn.Query("SELECT version()")
    if err != nil {
      panic(err)
    }

    var result string

    for q.Next() {
     q.Scan(&result)
     fmt.Println(result)
    }
  }
  ```

  For this connection method, the code must include the full path to the `root.crt` certificate for {{ MY }} in the `ca` variable.

- Connecting without SSL {#without-ssl}

  `connect.go`

  ```go
  package main

  import (
    "database/sql"
    "fmt"
    _ "github.com/go-sql-driver/mysql"
  )

  const (
    host     = "<FQDN_of_any_{{ MY }}_host>"
    port     = {{ port-mmy }}
    user     = "<username>"
    password = "<user_password>"
    dbname   = "<DB_name>"
  )

  func main() {
    mysqlInfo := fmt.Sprintf("%s:%s@tcp(%s:%d)/%s",
      user, password, host, port, dbname)
    conn, err := sql.Open("mysql", mysqlInfo)
    if err != nil {
      panic(err)
    }

    defer conn.Close()

    q, err := conn.Query("SELECT version()")
    if err != nil {
      panic(err)
    }

    var result string

    for q.Next() {
     q.Scan(&result)
     fmt.Println(result)
    }
  }
  ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

Connecting:

```bash
go run connect.go
```

{% include [Successful connection](successful-connect.md) %}

### Java

Before connecting:

1. Install the dependencies:

    ```bash
    sudo apt update && sudo apt install --yes default-jdk maven
    ```

1. Add the SSL certificate to the Java trusted certificate store (Java Key Store) so that the {{ MY }} driver can use this certificate for secure connections to the cluster hosts. Set a password in the `-storepass` parameter for storage protection:

    ```bash
    cd ~/.mysql && \
    sudo keytool -importcert \
                 -alias {{ crt-alias }} \
                 -file root.crt \
                 -keystore YATrustStore \
                 -storepass <certificate_store_password> \
                 --noprompt
    ```

    Where `storepass` is your certificate store password, a minimum of 6 characters.

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
                <groupId>mysql</groupId>
                <artifactId>mysql-connector-java</artifactId>
                <version>8.0.21</version>
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

    You can check the current `mysql-connector-java` version on the [project page in the Maven repository](https://mvnrepository.com/artifact/mysql/mysql-connector-java).

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

  `src/java/com/example/App.java`

  ```java
  package com.example;

  import java.sql.*;

  public class App {
    public static void main(String[] args) {
      String DB_URL     = "jdbc:mysql://<FQDN_of_any_{{ MY }}_host>:{{ port-mmy }}/<DB_name>?useSSL=true";
      String DB_USER    = "<username>";
      String DB_PASS    = "<user_password>";

      System.setProperty("javax.net.ssl.trustStore", "/home/<home_directory>/.mysql/YATrustStore");
      System.setProperty("javax.net.ssl.trustStorePassword", "<certificate_store_password>");

      try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        ResultSet q = conn.createStatement().executeQuery("SELECT version()");
        if(q.next()) {System.out.println(q.getString(1));}
  
        conn.close();
      }
      catch(Exception ex) {ex.printStackTrace();}
    }
  }
  ```

  In this code, the `javax.net.ssl.trustStore` property must specify the full path to the `YATrustStore` certificate store for the {{ MY }} driver.

- Connecting without SSL {#without-ssl}

  `src/java/com/example/App.java`

  ```java
  package com.example;

  import java.sql.*;

  public class App {
    public static void main(String[] args) {
      String DB_URL     = "jdbc:mysql://<FQDN_of_any_{{ MY }}_host>:{{ port-mmy }}/<DB_name>?useSSL=false";
      String DB_USER    = "<username>";
      String DB_PASS    = "<user_password>";

      try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        ResultSet q = conn.createStatement().executeQuery("SELECT version()");
        if(q.next()) {System.out.println(q.getString(1));}

        conn.close();
      }
      catch(Exception ex) {ex.printStackTrace();}
    }
  }
  ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

Connecting:

```bash
mvn clean package && \
java -jar target/app-0.1.0-jar-with-dependencies.jar
```

{% include [Successful connection](successful-connect.md) %}

### Node.js

Before connecting, install the following dependencies:

```bash
sudo apt update && sudo apt install --yes nodejs npm && \
npm install mysql2
```

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

  `app.js`

  ```js
  "use strict"
  const fs = require('fs');
  const mysql = require('mysql2');

  const config = {
    host     : '<FQDN_of_any_{{ MY }}_host>',
    port     : {{ port-mmy }},
    user     : '<username>',
    password : '<user_password>',
    database : '<DB_name>',
    ssl: {
      rejectUnauthorized: true,
      ca: fs.readFileSync('/home/<home_directory>/.mysql/root.crt').toString(),
    },
  }

  const conn = mysql.createConnection(config)
  conn.connect(err => {if (err) throw err})
    conn.query('SELECT version()', (err, result, fields) => {
      if (err) throw err
      console.log(result[0])
      conn.end()
    })
  ```

  For this connection method, the code must include the full path to the `root.crt` certificate for {{ MY }} in the `ca` variable.

- Connecting without SSL {#without-ssl}

  `app.js`

  ```js
  "use strict"
  const mysql = require('mysql2');

  const config = {
    host     : '<FQDN_of_any_{{ MY }}_host>',
    port     : {{ port-mmy }},
    user     : '<username>',
    password : '<user_password>',
    database : '<DB_name>',
  }

  const conn = mysql.createConnection(config)
  conn.connect(err => {if (err) throw err})
    conn.query('SELECT version()', (err, result, fields) => {
      if (err) throw err
      console.log(result[0])
      conn.end()
    })
  ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

Connecting:

```bash
node app.js
```

{% include [Successful connection](successful-connect.md) %}

### ODBC

Before connecting, install the following dependencies:

```bash
sudo apt update && sudo apt install --yes unixodbc && \
wget https://dev.mysql.com/get/Downloads/Connector-ODBC/8.0/mysql-connector-odbc_8.0.21-1ubuntu20.04_amd64.deb && \
sudo dpkg -i mysql-connector-odbc_8.0.21-1ubuntu20.04_amd64.deb
```

The {{ MY }} Connector/ODBC driver will be registered automatically in `/etc/odbcinst.ini`. Current version of the driver: [mysql-connector-odbc](https://dev.mysql.com/downloads/connector/odbc/).

Set the connection parameters in `/etc/odbc.ini`.

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

  `odbc.ini`

  ```ini
  [mysql]
  Driver=MySQL ODBC 8.0 Unicode Driver
  SERVER=<FQDN_of_any_{{ MY }}_host>
  UID=<username>
  PWD=<user_password>
  DATABASE=<DB_name>
  PORT={{ port-mmy }}
  SSLCA=/home/<home_directory>/.mysql/root.crt
  SSLVERIFY=1
  ```

  For this connection method, the `SSLCA` parameter in `/etc/odbc.ini` must specify the full path to the `root.crt` certificate for {{ MY }}.

- Connecting without SSL {#without-ssl}

  `odbc.ini`

  ```ini
  [mysql]
  Driver=MySQL ODBC 8.0 Unicode Driver
  SERVER=<FQDN_of_any_{{ MY }}_host>
  UID=<username>
  PWD=<user_password>
  DATABASE=<DB_name>
  PORT={{ port-mmy }}
  ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

Connecting:

```bash
isql -v mysql
```

After connecting to the DBMS, run the `SELECT version();` command.

{% include [Successful connection](successful-connect.md) %}

### PHP

Before connecting, install the following dependencies:

```bash
sudo apt update && apt install --yes php php-mysql
```

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

  `connect.php`

  ```php
  <?php
      $conn = mysqli_init();

      $conn->options(MYSQLI_OPT_SSL_VERIFY_SERVER_CERT, true);
      $conn->ssl_set(NULL, NULL, '/home/<home_directory>/.mysql/root.crt', NULL, NULL);
      $conn->real_connect('<FQDN_of_any_{{ MY }}_host>', '<username>', '<user_password>', '<database_name>', {{ port-mmy }}, NULL, MYSQLI_CLIENT_SSL);

      $q = $conn->query('SELECT version()');
      $result = $q->fetch_row();
      echo($result[0]);

      $q->close();
      $conn->close();
  ?>
  ```

  For this connection method, the code must include the full path to the `root.crt` certificate for {{ MY }} in the `ssl_set` method.

- Connecting without SSL {#without-ssl}

  `connect.php`

  ```php
  <?php
      $conn = mysqli_init();

      $conn->options(MYSQLI_OPT_SSL_VERIFY_SERVER_CERT, false);
      $conn->real_connect('<FQDN_of_any_{{ MY }}_host>', '<username>', '<user_password>', '<database_name>', {{ port-mmy }}, NULL, NULL);

      $q = $conn->query('SELECT version()');
      $result = $q->fetch_row();
      echo($result[0]);

      $q->close();
      $conn->close();
  ?>
  ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

Connecting:

```bash
php connect.php
```

{% include [Successful connection](successful-connect.md) %}

### PowerShell

Before connecting, [download](https://dev.mysql.com/downloads/shell/) and install `MySQL Shell`.

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

  ```PowerShell
  mysqlsh --host=<FQDN_of_any_{{ MY }}_host> `
          --port={{ port-mmy }} `
          --ssl-ca=<absolute_path_to_certificate_file> `
          --ssl-mode=VERIFY_IDENTITY `
          --user=<username> `
          --password `
          --database=<DB_name> `
          --sql
  ```

- Connecting without SSL {#without-ssl}

  ```PowerShell
  mysqlsh --host=<FQDN_of_any_{{ MY }}_host> `
          --port={{ port-mmy }} `
          --ssl-mode=DISABLED `
          --user=<username> `
          --password `
          --database=<DB_name>
  ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

When running any command, enter the DB user password.

After connecting to the DBMS, run the `SELECT version();` command.

{% include [Successful connection](successful-connect.md) %}

### Python

Before connecting, install the following dependencies:

```bash
sudo apt update && sudo apt install --yes python3 python3-pip libmysqlclient-dev && \
pip3 install mysqlclient
```

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

  `connect.py`

  ```python
  import MySQLdb

  conn = MySQLdb.connect(
        host="<FQDN_of_any_{{ MY }}_host>",
        port={{ port-mmy }},
        db="<DB_name>",
        user="<username>",
        passwd="<user_password>",
        ssl={'ca': '~/.mysql/root.crt'})

  cur = conn.cursor()
  cur.execute('SELECT version()')

  print(cur.fetchone()[0])

  conn.close()
  ```

- Connecting without SSL {#without-ssl}

  `connect.py`

  ```python
  import MySQLdb

  conn = MySQLdb.connect(
        host="<FQDN_of_any_{{ MY }}_host>",
        port={{ port-mmy }},
        db="<DB_name>",
        user="<username>",
        passwd="<user_password>")

  cur = conn.cursor()
  cur.execute('SELECT version()')

  print(cur.fetchone()[0])

  conn.close()
  ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

Connecting:

```bash
python3 connect.py
```

{% include [Successful connection](successful-connect.md) %}

### Ruby

Before connecting, install the following dependencies:

```bash
sudo apt update && sudo apt install --yes ruby ruby-mysql2
```

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

  `connect.rb`

  ```ruby
  require "mysql2"

  conn = Mysql2::Client.new(
          :host => "<FQDN_of_any_{{ MY }}_host>",
          :port => {{ port-mmy }},
          :database => "<DB_name>",
          :username => "<username>",
          :password => "<user_password>",
          :ssl_mode => "verify_identity",
          :sslca => "~/.mysql/root.crt")

  q = conn.query("SELECT version()")

  q.each do |result|
    puts result["version()"]
  end

  conn.close()
  ```

- Connecting without SSL {#without-ssl}

  `connect.rb`

  ```ruby
  require "mysql2"

  conn = Mysql2::Client.new(
          :host => "<FQDN_of_any_{{ MY }}_host>",
          :port => {{ port-mmy }},
          :database => "<DB_name>",
          :username => "<username>",
          :password => "<user_password>")

  q = conn.query("SELECT version()")

  q.each do |result|
    puts result["version()"]
  end

  conn.close()
  ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

Connecting:

```bash
ruby connect.rb
```

{% include [Successful connection](successful-connect.md) %}
