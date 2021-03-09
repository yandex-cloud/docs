{% list tabs %}

- clickhouse-client

  **Перед подключением:**
  1. Подключите [DEB-репозиторий](https://clickhouse.tech/docs/ru/getting-started/install/#install-from-deb-packages) {{ CH }}:

     ```bash
     sudo apt update && sudo apt install -y apt-transport-https ca-certificates dirmngr && \
     sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
     echo "deb https://repo.clickhouse.tech/deb/stable/ main/" | sudo tee \
     /etc/apt/sources.list.d/clickhouse.list
     ```

  1. Установите зависимости:

     ```bash
     sudo apt update && sudo apt install -y clickhouse-client
     ```

  1. Загрузите файл конфигурации для `clickhouse-client`:

     ```bash
     mkdir -p ~/.clickhouse-client && wget "https://storage.yandexcloud.net/mdb/clickhouse-client.conf.example" -O ~/.clickhouse-client/config.xml
     ```

  **Подключение с использованием SSL-соединения:**

  ```bash
  clickhouse-client --host <FQDN любого хоста {{ CH }}> \
                    --secure \
                    --user <имя пользователя> \
                    --database <имя БД> \
                    --port 9440 \
                    --ask-password
  ```

  **Подключение без использования SSL-соединения:**

  ```bash
  clickhouse-client --host <FQDN любого хоста {{ CH }}> \
                    --user <имя пользователя> \
                    --database <имя БД> \
                    --port 9000 \
                    --ask-password
  ```

  После выполнения команды введите пароль пользователя для завершения процедуры подключения.

  После подключения к СУБД выполните команду `SELECT version();`.

- cURL

  **Подключение с использованием SSL-соединения:**

  ```bash
  curl --cacert /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt \
       -H "X-ClickHouse-User: <имя пользователя БД>" \
       -H "X-ClickHouse-Key: <пароль пользователя БД>" \
       'https://<FQDN любого хоста {{ CH }}>:8443/?database=<имя БД>&query=SELECT%20version()'
  ```

  **Подключение без использования SSL-соединения:**

  ```bash
  curl -H "X-ClickHouse-User: <имя пользователя БД>" \
       -H "X-ClickHouse-Key: <пароль пользователя БД>" \
       'http://<FQDN любого хоста {{ CH }}>:8123/?database=<имя БД>&query=SELECT%20version()'
  ```

- Python

  **Перед подключением установите зависимости:**

  ```bash
  sudo apt update && sudo apt install -y python3 python3-pip && \
  pip3 install requests
  ```

  **Пример кода для подключения с использованием SSL-соединения:**

  `connect.py`
  ```python
  import requests

  url = 'https://{host}:8443/?database={db}&query={query}'.format(
          host='<FQDN любого хоста {{ CH }}>',
          db='<имя БД>',
          query='SELECT version()')

  auth = {
          'X-ClickHouse-User': '<имя пользователя БД>',
          'X-ClickHouse-Key': '<пароль пользователя БД>',
      }

  cacert = '/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt'

  rs = requests.get(url, headers=auth, verify=cacert)
  rs.raise_for_status()

  print(rs.text)
  ```

  **Пример кода для подключения без использования SSL-соединения:**

  `connect.py`
  ```python
  import requests

  url = 'http://{host}:8123/?database={db}&query={query}'.format(
          host='<FQDN любого хоста {{ CH }}>',
          db='<имя БД>',
          query='SELECT version()')

  auth = {
          'X-ClickHouse-User': '<имя пользователя БД>',
          'X-ClickHouse-Key': '<пароль пользователя БД>',
      }

  rs = requests.get(url, headers=auth)
  rs.raise_for_status()

  print(rs.text)
  ```

  **Подключение:**

  ```bash
  python3 connect.py
  ```

- PHP

  **Перед подключением:**
  1. Установите зависимости:

     ```bash
     sudo apt update && sudo apt install -y php
     ```

  1. Убедитесь, что для параметра `allow_url_fopen` задано значение `On` в настройках PHP:

     ```bash
     cat /etc/php/7.4/apache2/php.ini | grep "allow_url_fopen"
     ```

     Если это не так, то установите нужное значение и перезапустите Apache:

     ```bash
     sudo sed -i 's/\(^allow_url_fopen = \).*/\1On/' /etc/php/7.4/apache2/php.ini && \
     sudo systemctl restart apache2
     ```

  **Пример кода для подключения с использованием SSL-соединения:**

  `connect.php`
  ```php
  <?php
    $host = '<FQDN любого хоста {{ CH }}>';
    $db = '<имя БД>';
    $query = 'SELECT version()';

    $auth = [
        'X-ClickHouse-User: <имя пользователя БД>',
        'X-ClickHouse-Key: <пароль пользователя БД>',
    ];

    $ssl = [
        'cafile' => '/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt',
        'verify_peer' => true,
    ];

    $context = stream_context_create([
        'http' => [
            'method' => 'GET',
            'protocol_version' => 1.1,
            'header' => $auth
        ],
        'ssl' => $ssl
    ]);

    $url = sprintf('https://%s:8443/?database=%s&query=%s', $host, $db, urlencode($query));

    $rs = file_get_contents($url, false, $context);
    print_r($rs);
  ?>
  ```

  **Пример кода для подключения без использования SSL-соединения:**

  `connect.php`
  ```php
  <?php
    $host = '<FQDN любого хоста {{ CH }}>';
    $db = '<имя БД>';
    $query = 'SELECT version()';

    $auth = [
        'X-ClickHouse-User: <имя пользователя БД>',
        'X-ClickHouse-Key: <пароль пользователя БД>',
    ];

    $context = stream_context_create([
        'http' => [
            'method' => 'GET',
            'protocol_version' => 1.1,
            'header' => $auth
        ]
    ]);

    $url = sprintf('http://%s:8123/?database=%s&query=%s', $host, $db, urlencode($query));

    $rs = file_get_contents($url, false, $context);
    print_r($rs);
  ?>
  ```

  **Подключение:**

  ```bash
  php connect.php
  ```

- Java

  **Перед подключением:**
  1. Установите зависимости:

     ```bash
     sudo apt update && sudo apt install -y default-jdk maven
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
			     <groupId>ru.yandex.clickhouse</groupId>
                 <artifactId>clickhouse-jdbc</artifactId>
                 <version>0.2.4</version>
		     </dependency>
             <dependency>
               <groupId>org.slf4j</groupId>
               <artifactId>slf4j-simple</artifactId>
               <version>1.7.30</version>
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

     Актуальные версии зависимостей для Maven:
     - [clickhouse-jdbc](https://mvnrepository.com/artifact/ru.yandex.clickhouse/clickhouse-jdbc).
     - [slf4j-simple](https://mvnrepository.com/artifact/org.slf4j/slf4j-simple).

  **Пример кода для подключения с использованием SSL-соединения:**

  `src/java/com/example/App.java`
  ```java
  package com.example;

  import java.sql.*;

  public class App {
    public static void main(String[] args) {
      String DB_HOST    = "<FQDN любого хоста {{ CH }}>";
      String DB_NAME    = "<имя БД>";
      String DB_USER    = "<имя пользователя БД>";
      String DB_PASS    = "<пароль пользователя БД>";

      String CACERT     = "/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt";

      String DB_URL = String.format("jdbc:clickhouse://%s:8443/%s?ssl=1&sslmode=strict&sslrootcert=%s", DB_HOST, DB_NAME, CACERT);

      try {
        Class.forName("ru.yandex.clickhouse.ClickHouseDriver");

        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        ResultSet rs = conn.createStatement().executeQuery("SELECT version()");
        if(rs.next()) {System.out.println(rs.getString(1));}

        conn.close();
      }
      catch(Exception ex) {ex.printStackTrace();}
    }
  }  
  ```

  **Пример кода для подключения без использования SSL-соединения:**

  `src/java/com/example/App.java`
  ```java
  package com.example;

  import java.sql.*;

  public class App {
    public static void main(String[] args) {
      String DB_HOST    = "<FQDN любого хоста {{ CH }}>";
      String DB_NAME    = "<имя БД>";
      String DB_USER    = "<имя пользователя БД>";
      String DB_PASS    = "<пароль пользователя БД>";

      String DB_URL = String.format("jdbc:clickhouse://%s:8123/%s", DB_HOST, DB_NAME);

      try {
        Class.forName("ru.yandex.clickhouse.ClickHouseDriver");

        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        ResultSet rs = conn.createStatement().executeQuery("SELECT version()");
        if(rs.next()) {System.out.println(rs.getString(1));}

        conn.close();
      }
      catch(Exception ex) {ex.printStackTrace();}
    }
  }  
  ```

  **Подключение:**

  ```bash
  mvn clean package && \
  java -jar target/app-0.1.0-jar-with-dependencies.jar
  ```

- Node.js

  **Перед подключением установите зависимости:**

  ```bash
  sudo apt update && sudo apt install -y nodejs npm && \
  npm install querystring
  ```

  **Пример кода для подключения с использованием SSL-соединения:**

  `app.js`
  ```js
  "use strict"
  const https = require('https');
  const querystring = require('querystring');
  const fs = require('fs');

  const DB_HOST = "<FQDN любого хоста {{ CH }}>";
  const DB_NAME = "<имя БД>";
  const DB_USER = "<имя пользователя БД>";
  const DB_PASS = "<пароль пользователя БД>";

  const CACERT = "/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt";

  const options = {
      'method': 'GET',
      'ca': fs.readFileSync(CACERT),
      'path': '/?' + querystring.stringify({
          'database': DB_NAME,
          'query': 'SELECT version()',
      }),
      'port': 8443,
      'hostname': DB_HOST,
      'headers': {
          'X-ClickHouse-User': DB_USER,
          'X-ClickHouse-Key': DB_PASS,
      },
  };

  const rs = https.request(options, (res) => {
      res.setEncoding('utf8');
      res.on('data', (chunk) => {
          console.log(chunk);
      });
  });

  rs.end();
  ```

  **Пример кода для подключения без использования SSL-соединения:**

  `app.js`
  ```js
  "use strict"
  const http = require('http');
  const querystring = require('querystring');
  const fs = require('fs');

  const DB_HOST = "<FQDN любого хоста {{ CH }}>";
  const DB_NAME = "<имя БД>";
  const DB_USER = "<имя пользователя БД>";
  const DB_PASS = "<пароль пользователя БД>";

  const options = {
      'method': 'GET',
      'path': '/?' + querystring.stringify({
          'database': DB_NAME,
          'query': 'SELECT version()',
      }),
      'port': 8123,
      'hostname': DB_HOST,
      'headers': {
          'X-ClickHouse-User': DB_USER,
          'X-ClickHouse-Key': DB_PASS,
      },
  };

  const rs = http.request(options, (res) => {
      res.setEncoding('utf8');
      res.on('data', (chunk) => {
          console.log(chunk);
      });
  });

  rs.end();
  ```

  **Подключение:**

  ```bash
  node app.js
  ```

- Go

  **Перед подключением установите зависимости:**

  ```bash
  sudo apt update && sudo apt install -y golang git
  ```

  **Пример кода для подключения с использованием SSL-соединения:**

  `connect.go`
  ```go
  package main

  import (
      "fmt"
      "net/http"
      "io/ioutil"
      "crypto/x509"
      "crypto/tls"
  )

  func main() {

      const DB_HOST = "<FQDN любого хоста {{ CH }}>"
      const DB_NAME = "<имя БД>"
      const DB_USER = "<имя пользователя БД>"
      const DB_PASS = "<пароль пользователя БД>"

      const CACERT = "/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt"

      caCert, err := ioutil.ReadFile(CACERT)
      if err != nil {
        panic(err)
      }
      caCertPool := x509.NewCertPool()
      caCertPool.AppendCertsFromPEM(caCert)
      conn := &http.Client{
        Transport: &http.Transport{
          TLSClientConfig: &tls.Config{
            RootCAs: caCertPool,
          },
       },
      }

      req, _ := http.NewRequest("GET", fmt.Sprintf("https://%s:8443/", DB_HOST), nil)
      query := req.URL.Query()
      query.Add("database", DB_NAME)
      query.Add("query", "SELECT version()")

      req.URL.RawQuery = query.Encode()

      req.Header.Add("X-ClickHouse-User", DB_USER)
      req.Header.Add("X-ClickHouse-Key", DB_PASS)

      resp, err := conn.Do(req)
      if err != nil {
        panic(err)
      }

      defer resp.Body.Close()

      data, _ := ioutil.ReadAll(resp.Body)
      fmt.Println(string(data))
  }
  ```

  **Пример кода для подключения без использования SSL-соединения:**

  `connect.go`
  ```go
  package main

  import (
      "fmt"
      "net/http"
      "io/ioutil"
  )

  func main() {

      const DB_HOST = "<FQDN любого хоста {{ CH }}>"
      const DB_NAME = "<имя БД>"
      const DB_USER = "<имя пользователя БД>"
      const DB_PASS = "<пароль пользователя БД>"

      conn := &http.Client{
        Transport: &http.Transport{},
      }

      req, _ := http.NewRequest("GET", fmt.Sprintf("http://%s:8123/", DB_HOST), nil)
      query := req.URL.Query()
      query.Add("database", DB_NAME)
      query.Add("query", "SELECT version()")

      req.URL.RawQuery = query.Encode()

      req.Header.Add("X-ClickHouse-User", DB_USER)
      req.Header.Add("X-ClickHouse-Key", DB_PASS)

      resp, err := conn.Do(req)
      if err != nil {
        panic(err)
      }

      defer resp.Body.Close()

      data, _ := ioutil.ReadAll(resp.Body)
      fmt.Println(string(data))
  }
  ```

  **Подключение:**

  ```bash
  go run connect.go
  ```

- Ruby

  **Перед подключением установите зависимости:**

  ```bash
  sudo apt update && sudo apt install -y ruby
  ```

  **Пример кода для подключения с использованием SSL-соединения:**

  `connect.rb`
  ```ruby
  require "net/http"
  require "openssl"
  require "uri"

  DB_HOST = "<FQDN любого хоста {{ CH }}>"
  DB_NAME = "<имя БД>"
  DB_USER = "<имя пользователя БД>"
  DB_PASS = "<пароль пользователя БД>"

  QUERYSTRING = { :database => DB_NAME, :query => "SELECT version()" }

  uri = URI("https://" + DB_HOST + "/")
  uri.port = 8443
  uri.query = URI.encode_www_form(QUERYSTRING)

  req = Net::HTTP::Get.new(uri)
  req.add_field("X-ClickHouse-User", DB_USER)
  req.add_field("X-ClickHouse-Key", DB_PASS)

  conn = Net::HTTP.new(uri.host, uri.port)
  conn.ca_file = "/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt"
  conn.use_ssl = true
  conn.verify_mode = OpenSSL::SSL::VERIFY_PEER

  rs = conn.request(req)
  puts rs.body
  ```

  **Пример кода для подключения без использования SSL-соединения:**

  `connect.rb`
  ```ruby
  require "net/http"
  require "uri"

  DB_HOST = "<FQDN любого хоста {{ CH }}>"
  DB_NAME = "<имя БД>"
  DB_USER = "<имя пользователя БД>"
  DB_PASS = "<пароль пользователя БД>"

  QUERYSTRING = { :database => DB_NAME, :query => "SELECT version()" }

  uri = URI("http://" + DB_HOST + "/")
  uri.port = 8123
  uri.query = URI.encode_www_form(QUERYSTRING)

  req = Net::HTTP::Get.new(uri)
  req.add_field("X-ClickHouse-User", DB_USER)
  req.add_field("X-ClickHouse-Key", DB_PASS)

  conn = Net::HTTP.new(uri.host, uri.port)

  rs = conn.request(req)
  puts rs.body
  ```

  **Подключение:**

  ```bash
  ruby connect.rb
  ```

- ODBC

  **Перед подключением:**
  1. Установите зависимости:

     ```bash
     sudo apt update && sudo apt install -y git unixodbc build-essential cmake \
     libpoco-dev libssl-dev libicu-dev unixodbc-dev && \
     cd ~/ && git clone https://github.com/ClickHouse/clickhouse-odbc.git && \
     cd clickhouse-odbc/ && git submodule update --init
     ```

  1. Соберите драйвер из исходных файлов:

     ```bash
     cd ~/clickhouse-odbc/ && mkdir build && cd build && \
     cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo .. && \
     cmake --build . --config RelWithDebInfo
     ```

  1. После завершения процесса сборки скопируйте файлы драйвера в директорию `/usr/local/lib64/`:

     ```bash
     sudo mkdir -p /usr/local/lib64 && sudo cp driver/*.so /usr/local/lib64/
     ```

  1. Зарегистрируйте драйвер {{ CH }} ODBC, добавив следующие строки в файл `odbcinst.ini` ([файл-пример](https://github.com/ClickHouse/clickhouse-odbc/blob/master/packaging/odbcinst.ini.sample)):

     {% cut "/etc/odbcinst.ini" %}
     ```ini
     [ODBC Drivers]
     ClickHouse ODBC Driver (ANSI)    = Installed
     ClickHouse ODBC Driver (Unicode) = Installed

     [ClickHouse ODBC Driver (ANSI)]
     Description = ODBC Driver (ANSI) for ClickHouse
     Driver      = /usr/local/lib64/libclickhouseodbc.so
     Setup       = /usr/local/lib64/libclickhouseodbc.so
     UsageCount  = 1

     [ClickHouse ODBC Driver (Unicode)]
     Description = ODBC Driver (Unicode) for ClickHouse
     Driver      = /usr/local/lib64/libclickhouseodbcw.so
     Setup       = /usr/local/lib64/libclickhouseodbcw.so
     UsageCount  = 1
     ```
     {% endcut %}

  **Пример настроек в файле `odbc.ini` для подключения с использованием SSL-соединения:**

  `/etc/odbc.ini`
  ```ini
  [ClickHouse]
  Driver = ClickHouse ODBC Driver (Unicode)
  Server = <FQDN любого хоста {{ CH }}>
  Database = <имя БД>
  UID = <имя пользователя БД>
  PWD = <пароль пользователя БД>
  Port = 8443
  Proto = https
  SSLMode = allow
  CertificateFile = /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
  ```

  **Пример настроек в файле `odbc.ini` для подключения без использования SSL-соединения:**

  `/etc/odbc.ini`
  ```ini
  [ClickHouse]
  Driver = ClickHouse ODBC Driver (Unicode)
  Server = <FQDN любого хоста {{ CH }}>
  Database = <имя БД>
  UID = <имя пользователя БД>
  PWD = <пароль пользователя БД>
  Port = 8123
  Proto = http
  ```

  **Подключение:**

  ```bash
  isql -v ClickHouse
  ```

  После подключения к СУБД выполните команду `SELECT version();`.

{% endlist %}
