### Bash

Перед подключением установите утилиту `mysql`:

```bash
sudo apt update && sudo apt install --yes mysql-client
```

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

  {% include [default-connstring](default-connstring.md) %}

- Подключение без SSL {#without-ssl}

  ```bash
  mysql --host=<FQDN_любого_хоста_{{ MY }}> \
        --port={{ port-mmy }} \
        --ssl-mode=DISABLED \
        --user=<имя_пользователя> \
        --password \
        <имя_БД>
  ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

При выполнении любой из команд введите пароль пользователя БД.

После подключения к СУБД выполните команду `SELECT version();`.

{% include [Successful connection](successful-connect.md) %}


### Go

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes golang git && \
go get github.com/go-sql-driver/mysql
```

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

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
    host     = "<FQDN_любого_хоста_{{ MY }}>"
    port     = {{ port-mmy }}
    user     = "<имя_пользователя>"
    password = "<пароль_пользователя>"
    dbname   = "<имя_БД>"
  )

  func main() {
    rootCertPool := x509.NewCertPool()
    pem, err := ioutil.ReadFile("/home/<домашняя_директория>/.mysql/root.crt")
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

  При этом способе подключения в коде необходимо указывать полный путь к сертификату `root.crt` для {{ MY }} в переменной `ca`.

- Подключение без SSL {#without-ssl}

  `connect.go`

  ```go
  package main

  import (
    "database/sql"
    "fmt"
    _ "github.com/go-sql-driver/mysql"
  )

  const (
    host     = "<FQDN_любого_хоста_{{ MY }}>"
    port     = {{ port-mmy }}
    user     = "<имя_пользователя>"
    password = "<пароль_пользователя>"
    dbname   = "<имя_БД>"
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

Подключение:

```bash
go run connect.go
```

{% include [Successful connection](successful-connect.md) %}

### Java

Перед подключением:

1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install --yes default-jdk maven
    ```

1. Добавьте SSL-сертификат в хранилище доверенных сертификатов Java (Java Key Store), чтобы драйвер {{ MY }} мог использовать этот сертификат при защищенном подключении к хостам кластера. При этом задайте пароль в параметре `-storepass` для защиты хранилища:

    ```bash
    cd ~/.mysql && \
    sudo keytool -importcert \
                 -alias {{ crt-alias }} \
                 -file root.crt \
                 -keystore YATrustStore \
                 -storepass <пароль_хранилища_сертификатов> \
                 --noprompt
    ```

    Где `storepass` — пароль хранилища сертификатов, не короче 6 символов.

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

    Актуальную версию `mysql-connector-java` уточняйте на [странице проекта в репозитории Maven](https://mvnrepository.com/artifact/mysql/mysql-connector-java).

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

  `src/java/com/example/App.java`

  ```java
  package com.example;

  import java.sql.*;

  public class App {
    public static void main(String[] args) {
      String DB_URL     = "jdbc:mysql://<FQDN_любого_хоста_{{ MY }}>:{{ port-mmy }}/<имя_БД>?useSSL=true";
      String DB_USER    = "<имя_пользователя>";
      String DB_PASS    = "<пароль_пользователя>";

      System.setProperty("javax.net.ssl.trustStore", "/home/<домашняя_директория>/.mysql/YATrustStore");
      System.setProperty("javax.net.ssl.trustStorePassword", "<пароль_хранилища_сертификатов>");

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

  В этом коде необходимо указывать полный путь к хранилищу сертификатов `YATrustStore` для драйвера {{ MY }} в свойстве `javax.net.ssl.trustStore`.

- Подключение без SSL {#without-ssl}

  `src/java/com/example/App.java`

  ```java
  package com.example;

  import java.sql.*;

  public class App {
    public static void main(String[] args) {
      String DB_URL     = "jdbc:mysql://<FQDN_любого_хоста_{{ MY }}>:{{ port-mmy }}/<имя_БД>?useSSL=false";
      String DB_USER    = "<имя_пользователя>";
      String DB_PASS    = "<пароль_пользователя>";

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

Подключение:

```bash
mvn clean package && \
java -jar target/app-0.1.0-jar-with-dependencies.jar
```

{% include [Successful connection](successful-connect.md) %}

### Node.js

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes nodejs npm && \
npm install mysql2
```

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}
  
  `app.js`

  ```js
  "use strict"
  const fs = require('fs');
  const mysql = require('mysql2');
  
  const config = {
    host     : '<FQDN_любого_хоста_{{ MY }}>',
    port     : {{ port-mmy }},
    user     : '<имя_пользователя>',
    password : '<пароль_пользователя>',
    database : '<имя_БД>',
    ssl: {
      rejectUnauthorized: true,
      ca: fs.readFileSync('/home/<домашняя_директория>/.mysql/root.crt').toString(),
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

  При этом способе подключения в коде необходимо указывать полный путь к сертификату `root.crt` для {{ MY }} в переменной `ca`.

- Подключение без SSL {#without-ssl}

  `app.js`

  ```js
  "use strict"
  const mysql = require('mysql2');
  
  const config = {
    host     : '<FQDN_любого_хоста_{{ MY }}>',
    port     : {{ port-mmy }},
    user     : '<имя_пользователя>',
    password : '<пароль_пользователя>',
    database : '<имя_БД>',
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

Подключение:

```bash
node app.js
```

{% include [Successful connection](successful-connect.md) %}

### ODBC

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes unixodbc && \
wget https://dev.mysql.com/get/Downloads/Connector-ODBC/8.0/mysql-connector-odbc_8.0.21-1ubuntu20.04_amd64.deb && \
sudo dpkg -i mysql-connector-odbc_8.0.21-1ubuntu20.04_amd64.deb
```

Драйвер {{ MY }} Connector/ODBC будет автоматически зарегистрирован в файле `/etc/odbcinst.ini`. Актуальная версия драйвера: [mysql-connector-odbc](https://dev.mysql.com/downloads/connector/odbc/).

Настройки подключения необходимо задать в файле `/etc/odbc.ini`.

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

  `odbc.ini`

  ```ini
  [mysql]
  Driver=MySQL ODBC 8.0 Unicode Driver
  SERVER=<FQDN_любого_хоста_{{ MY }}>
  UID=<имя_пользователя>
  PWD=<пароль_пользователя>
  DATABASE=<имя_БД>
  PORT={{ port-mmy }}
  SSLCA=/home/<домашняя_директория>/.mysql/root.crt
  SSLVERIFY=1
  ```

  При этом способе подключения в файле `/etc/odbc.ini` необходимо указывать полный путь к сертификату `root.crt` для {{ MY }} в параметре `SSLCA`.

- Подключение без SSL {#without-ssl}

  `odbc.ini`

  ```ini
  [mysql]
  Driver=MySQL ODBC 8.0 Unicode Driver
  SERVER=<FQDN_любого_хоста_{{ MY }}>
  UID=<имя_пользователя>
  PWD=<пароль_пользователя>
  DATABASE=<имя_БД>
  PORT={{ port-mmy }}
  ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

Подключение:

```bash
isql -v mysql
```

После подключения к СУБД выполните команду `SELECT version();`.

{% include [Successful connection](successful-connect.md) %}

### PHP

Перед подключением установите зависимости:

```bash
sudo apt update && apt install --yes php php-mysql
```

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

  `connect.php`

  ```php
  <?php
      $conn = mysqli_init();

      $conn->options(MYSQLI_OPT_SSL_VERIFY_SERVER_CERT, true);
      $conn->ssl_set(NULL, NULL, '/home/<домашняя_директория>/.mysql/root.crt', NULL, NULL);
      $conn->real_connect('<FQDN_любого_хоста_{{ MY }}>', '<имя_пользователя>', '<пароль_пользователя>', '<имя_БД>', {{ port-mmy }}, NULL, MYSQLI_CLIENT_SSL);

      $q = $conn->query('SELECT version()');
      $result = $q->fetch_row();
      echo($result[0]);

      $q->close();
      $conn->close();
  ?>
  ```

  При этом способе подключения в коде необходимо указывать полный путь к сертификату `root.crt` для {{ MY }} в методе `ssl_set`.

- Подключение без SSL {#without-ssl}

  `connect.php`

  ```php
  <?php
      $conn = mysqli_init();

      $conn->options(MYSQLI_OPT_SSL_VERIFY_SERVER_CERT, false);
      $conn->real_connect('<FQDN_любого_хоста_{{ MY }}>', '<имя_пользователя>', '<пароль_пользователя>', '<имя_БД>', {{ port-mmy }}, NULL, NULL);

      $q = $conn->query('SELECT version()');
      $result = $q->fetch_row();
      echo($result[0]);

      $q->close();
      $conn->close();
  ?>
  ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

Подключение:

```bash
php connect.php
```

{% include [Successful connection](successful-connect.md) %}

### PowerShell

Перед подключением [скачайте](https://dev.mysql.com/downloads/shell/) и установите утилиту `MySQL Shell`.

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

  ```PowerShell
  mysqlsh --host=<FQDN_любого_хоста_{{ MY }}> `
          --port={{ port-mmy }} `
          --ssl-ca=<абсолютный_путь_к_файлу_сертификата> `
          --ssl-mode=VERIFY_IDENTITY `
          --user=<имя_пользователя> `
          --password `
          --database=<имя_БД> `
          --sql
  ```

- Подключение без SSL {#without-ssl}

  ```PowerShell
  mysqlsh --host=<FQDN_любого_хоста_{{ MY }}> `
          --port={{ port-mmy }} `
          --ssl-mode=DISABLED `
          --user=<имя_пользователя> `
          --password `
          --database=<имя_БД>
  ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

При выполнении любой из команд введите пароль пользователя БД.

После подключения к СУБД выполните команду `SELECT version();`.

{% include [Successful connection](successful-connect.md) %}

### Python

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes python3 python3-pip libmysqlclient-dev && \
pip3 install mysqlclient
```

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

  `connect.py`

  ```python
  import MySQLdb
  
  conn = MySQLdb.connect(
        host="<FQDN_любого_хоста_{{ MY }}>",
        port={{ port-mmy }},
        db="<имя_БД>",
        user="<имя_пользователя>",
        passwd="<пароль_пользователя>",
        ssl={'ca': '~/.mysql/root.crt'})
  
  cur = conn.cursor()
  cur.execute('SELECT version()')
  
  print(cur.fetchone()[0])

  conn.close()
  ```

- Подключение без SSL {#without-ssl}

  `connect.py`

  ```python
  import MySQLdb
  
  conn = MySQLdb.connect(
        host="<FQDN_любого_хоста_{{ MY }}>",
        port={{ port-mmy }},
        db="<имя_БД>",
        user="<имя_пользователя>",
        passwd="<пароль_пользователя>")
  
  cur = conn.cursor()
  cur.execute('SELECT version()')
  
  print(cur.fetchone()[0])

  conn.close()
  ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

Подключение:

```bash
python3 connect.py
```

{% include [Successful connection](successful-connect.md) %}

### Ruby

Перед подключением установите зависимости:

```bash
sudo apt update && sudo apt install --yes ruby ruby-mysql2
```

{% list tabs group=connection %}

- Подключение с SSL {#with-ssl}

  `connect.rb`

  ```ruby
  require "mysql2"

  conn = Mysql2::Client.new(
          :host => "<FQDN_любого_хоста_{{ MY }}>",
          :port => {{ port-mmy }},
          :database => "<имя_БД>",
          :username => "<имя_пользователя>",
          :password => "<пароль_пользователя>",
          :ssl_mode => "verify_identity",
          :sslca => "~/.mysql/root.crt")

  q = conn.query("SELECT version()")

  q.each do |result|
    puts result["version()"]
  end

  conn.close()
  ```

- Подключение без SSL {#without-ssl}

  `connect.rb`

  ```ruby
  require "mysql2"

  conn = Mysql2::Client.new(
          :host => "<FQDN_любого_хоста_{{ MY }}>",
          :port => {{ port-mmy }},
          :database => "<имя_БД>",
          :username => "<имя_пользователя>",
          :password => "<пароль_пользователя>")

  q = conn.query("SELECT version()")

  q.each do |result|
    puts result["version()"]
  end

  conn.close()
  ```

{% endlist %}

{% include [see-fqdn](fqdn-host.md) %}

Подключение:

```bash
ruby connect.rb
```

{% include [Successful connection](successful-connect.md) %}
