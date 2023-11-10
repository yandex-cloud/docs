### Bash

Before connecting, install the `mysql` utility:

```bash
sudo apt update && sudo apt install --yes mysql-client
```

{% list tabs %}

- Connecting via SSL

   {% include [default-connstring](default-connstring.md) %}

- Connecting without using SSL

   ```bash
   mysql --host=<FQDN of any {{ MY }} host> \
         --port={{ port-mmy }} \
         --ssl-mode=DISABLED \
         --user=<username> \
         --password \
         <DB name>
   ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

When running any command, enter the DB user password.

Once connected to the DBMS, run `SELECT @@version;`.

{% include [Successful connection](successful-connect.md) %}

### Go

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install --yes golang git && \
go get github.com/go-sql-driver/mysql
```

{% list tabs %}

- Connecting via SSL

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
     host     = "<FQDN of any {{ MY }} host>"
     port     = {{ port-mmy }}
     user     = "<username>"
     password = "<user password>"
     dbname   = "<DB name>"
   )

   func main() {
     rootCertPool := x509.NewCertPool()
     pem, err := ioutil.ReadFile("/home/<home directory>/.mysql/root.crt")
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

- Connecting without using SSL

   `connect.go`

   ```go
   package main

   import (
     "database/sql"
     "fmt"
     _ "github.com/go-sql-driver/mysql"
   )

   const (
     host     = "<FQDN of any {{ MY }} host>"
     port     = {{ port-mmy }}
     user     = "<username>"
     password = "<user password>"
     dbname   = "<DB name>"
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

1. Add the SSL certificate to the Java trusted certificate store (Java Key Store) so that the {{ MY }} driver can use this certificate for secure connections to the cluster hosts. Make sure to set the password for additional storage security using the `-storepass` parameter:

   ```bash
   cd ~/.mysql && \
   sudo keytool -importcert \
                -alias {{ crt-alias }} \
                -file root.crt \
                -keystore YATrustStore \
                -storepass <certificate store password, at least 6 characters> \
                --noprompt
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

{% list tabs %}

- Connecting via SSL

   `src/java/com/example/App.java`

   ```java
   package com.example;

   import java.sql.*;

   public class App {
     public static void main(String[] args) {
       String DB_URL     = "jdbc:mysql://<FQDN of any {{ MY }} host>:{{ port-mmy }}/<DB name>?useSSL=true";
       String DB_USER    = "<username>";
       String DB_PASS    = "<user password>";

       System.setProperty("javax.net.ssl.trustStore", "/home/<home directory>/.mysql/YATrustStore");
       System.setProperty("javax.net.ssl.trustStorePassword", "<certificate storage password>");

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

   This code must specify the full path to the `YATrustStore` certificate store for the {{ MY }} driver in the `javax.net.ssl.trustStore` property.

- Connecting without using SSL

   `src/java/com/example/App.java`

   ```java
   package com.example;

   import java.sql.*;

   public class App {
     public static void main(String[] args) {
       String DB_URL     = "jdbc:mysql://<FQDN of any {{ MY }} host>:{{ port-mmy }}/<DB name>?useSSL=false";
       String DB_USER    = "<username>";
       String DB_PASS    = "<user password>";

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

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install --yes nodejs npm && \
npm install mysql2
```

{% list tabs %}

- Connecting via SSL

   `app.js`

   ```js
   "use strict"
   const fs = require('fs');
   const mysql = require('mysql2');

   const config = {
     host     : '<FQDN of any {{ MY }} host>',
     port     : {{ port-mmy }},
     user     : '<username>',
     password : '<user password>',
     database : '<DB name>',
     ssl: {
       rejectUnauthorized: true,
       ca: fs.readFileSync('/home/<home directory>/.mysql/root.crt').toString(),
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

- Connecting without using SSL

   `app.js`

   ```js
   "use strict"
   const mysql = require('mysql2');

   const config = {
     host     : '<FQDN of any {{ MY }} host>',
     port     : {{ port-mmy }},
     user     : '<username>',
     password : '<user password>',
     database : '<DB name>',
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

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install --yes unixodbc && \
wget https://dev.mysql.com/get/Downloads/Connector-ODBC/8.0/mysql-connector-odbc_8.0.21-1ubuntu20.04_amd64.deb && \
sudo dpkg -i mysql-connector-odbc_8.0.21-1ubuntu20.04_amd64.deb
```

The {{ MY }} Connector/ODBC driver will be registered automatically in `/etc/odbcinst.ini`. Current version of the driver: [mysql-connector-odbc](https://dev.mysql.com/downloads/connector/odbc/).

Set the connection parameters in the `/etc/odbc.ini` file.

{% list tabs %}

- Connecting via SSL

   `odbc.ini`

   ```ini
   [mysql]
   Driver=MySQL ODBC 8.0 Unicode Driver
   SERVER=<FQDN of any {{ MY }} host>
   UID=<username>
   PWD=<user password>
   DATABASE=<DB name>
   PORT={{ port-mmy }}
   SSLCA=/home/<home directory>/.mysql/root.crt
   SSLVERIFY=1
   ```

   For this connection method, the `/etc/odbc.ini` file must include the full path to the `root.crt` certificate for {{ MY }} in the `SSLCA` parameter.

- Connecting without using SSL

   `odbc.ini`

   ```ini
   [mysql]
   Driver=MySQL ODBC 8.0 Unicode Driver
   SERVER=<FQDN of any {{ MY }} host>
   UID=<username>
   PWD=<user password>
   DATABASE=<DB name>
   PORT={{ port-mmy }}
   ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

Connecting:

```bash
isql -v mysql
```

Once connected to the DBMS, run `SELECT @@version;`.

{% include [Successful connection](successful-connect.md) %}

### PHP

Before connecting, install the dependencies:

```bash
sudo apt update && apt install --yes php php-mysql
```

{% list tabs %}

- Connecting via SSL

   `connect.php`

   ```php
   <?php
       $conn = mysqli_init();

       $conn->options(MYSQLI_OPT_SSL_VERIFY_SERVER_CERT, true);
       $conn->ssl_set(NULL, NULL, '/home/<home directory>/.mysql/root.crt', NULL, NULL);
       $conn->real_connect('<FQDN of any {{ MY }} host>', '<username>', '<user password>', '<DB name>', {{ port-mmy }}, NULL, MYSQLI_CLIENT_SSL);

       $q = $conn->query('SELECT version()');
       $result = $q->fetch_row();
       echo($result[0]);

       $q->close();
       $conn->close();
   ?>
   ```

   For this connection method, the code must include the full path to the `root.crt` certificate for {{ MY }} in the `ssl_set` method.

- Connecting without using SSL

   `connect.php`

   ```php
   <?php
       $conn = mysqli_init();

       $conn->options(MYSQLI_OPT_SSL_VERIFY_SERVER_CERT, false);
       $conn->real_connect('<FQDN of any {{ MY }} host>', '<username>', '<user password>', '<DB name>', {{ port-mmy }}, NULL, NULL);

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

Before connecting, [download](https://dev.mysql.com/downloads/shell/) and install the `MySQL Shell` utility.

{% list tabs %}

- Connecting via SSL

   ```PowerShell
   mysqlsh --host=<FQDN of any {{ MY }} host> `
           --port={{ port-mmy }} `
           --ssl-ca=<absolute path to certificate file> `
           --ssl-mode=VERIFY_IDENTITY `
           --user=<username> `
           --password `
           --database=<DB name> `
           --sql
   ```

- Connecting without using SSL

   ```PowerShell
   mysqlsh --host=<FQDN of any {{ MY }} host> `
           --port={{ port-mmy }} `
           --ssl-mode=DISABLED `
           --user=<username> `
           --password `
           --database=<DB name>
   ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

When running any command, enter the DB user password.

Once connected to the DBMS, run `SELECT @@version;`.

{% include [Successful connection](successful-connect.md) %}

### Python

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install --yes python3 python3-pip libmysqlclient-dev && \
pip3 install mysqlclient
```

{% list tabs %}

- Connecting via SSL

   `connect.py`

   ```python
   import MySQLdb

   conn = MySQLdb.connect(
         host="<FQDN of any {{ MY }} host>",
         port={{ port-mmy }},
         db="<DB name>",
         user="<username>",
         passwd="<user password>",
         ssl={'ca': '~/.mysql/root.crt'})

   cur = conn.cursor()
   cur.execute('SELECT version()')

   print(cur.fetchone()[0])

   conn.close()
   ```

- Connecting without using SSL

   `connect.py`

   ```python
   import MySQLdb

   conn = MySQLdb.connect(
         host="<FQDN of any {{ MY }} host>",
         port={{ port-mmy }},
         db="<DB name>",
         user="<username>",
         passwd="<user password>")

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

Before connecting, install the dependencies:

```bash
sudo apt update && sudo apt install --yes ruby ruby-mysql2
```

{% list tabs %}

- Connecting via SSL

   `connect.rb`

   ```ruby
   require "mysql2"

   conn = Mysql2::Client.new(
           :host => "<FQDN of any {{ MY }} host>",
           :port => {{ port-mmy }},
           :database => "<DB name>",
           :username => "<username>",
           :password => "<user password>",
           :ssl_mode => "verify_identity",
           :sslca => "~/.mysql/root.crt")

   q = conn.query("SELECT version()")

   q.each do |result|
     puts result["version()"]
   end

   conn.close()
   ```

- Connecting without using SSL

   `connect.rb`

   ```ruby
   require "mysql2"

   conn = Mysql2::Client.new(
           :host => "<FQDN of any {{ MY }} host>",
           :port => {{ port-mmy }},
           :database => "<DB name>",
           :username => "<username>",
           :password => "<user password>")

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
