{% list tabs %}

- clickhouse-client

  **Before connecting:**

  1. Add the {{ CH }} [DEB repository](https://{{ ch-domain }}/docs/en/getting-started/install/#install-from-deb-packages):

     ```bash
     sudo apt update && sudo apt install -y apt-transport-https ca-certificates dirmngr && \
     sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E0C56BD4 && \
     echo "deb https://repo.{{ ch-domain }}/deb/stable/ main/" | sudo tee \
     /etc/apt/sources.list.d/clickhouse.list
     ```

  1. Install the dependencies:

     ```bash
     sudo apt update && sudo apt install -y clickhouse-client
     ```

  1. Download the configuration file for `clickhouse-client`:

     ```bash
     mkdir -p ~/.clickhouse-client && wget "https://{{ s3-storage-host }}/mdb/clickhouse-client.conf.example" -O ~/.clickhouse-client/config.xml
     ```

  **Connecting via SSL:**

  ```bash
  clickhouse-client --host <FQDN of any {{ CH }} host> \
                    --secure \
                    --user <username> \
                    --database <database name> \
                    --port 9440 \
                    --ask-password
  ```

  **Connecting without SSL:**

  ```bash
  clickhouse-client --host <FQDN of any {{ CH }} host> \
                    --user <username> \
                    --database <database name> \
                    --port 9000 \
                    --ask-password
  ```

  After running the command, enter the user password to complete the connection procedure.

  After connecting to the DBMS, run the command `SELECT version();`.

- cURL

  **Connecting via SSL:**

  ```bash
  curl --cacert {{ crt-local-dir }}{{ crt-local-file }} \
       -H "X-ClickHouse-User: <DB username>" \
       -H "X-ClickHouse-Key: <DB user password>" \
       'https://<FQDN of any {{ CH }} host>:8443/?database=<DB name>&query=SELECT%20version()'
  ```

  **Connecting without SSL:**

  ```bash
  curl -H "X-ClickHouse-User: <DB username>" \
       -H "X-ClickHouse-Key: <DB user password>" \
       'http://<FQDN of any {{ CH }} host>:8123/?database=<DB name>&query=SELECT%20version()'
  ```

- Python

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y python3 python3-pip && \
  pip3 install requests
  ```

  **Code example for connecting via SSL:**

  `connect.py`

  ```python
  import requests
  
  url = 'https://{host}:8443/?database={db}&query={query}'.format(
          host='<FQDN of any {{ CH }} host>',
          db='<DB name>',
          query='SELECT version()')
  
  auth = {
          'X-ClickHouse-User': '<DB username>',
          'X-ClickHouse-Key': '<DB user password>',
      }
  
  cacert = '{{ crt-local-dir }}{{ crt-local-file }}'
  
  rs = requests.get(url, headers=auth, verify=cacert)
  rs.raise_for_status()
  
  print(rs.text)
  ```

  **Code example for connecting without SSL:**

  `connect.py`

  ```python
  import requests
  
  url = 'http://{host}:8123/?database={db}&query={query}'.format(
          host='<FQDN of any {{ CH }} host>',
          db='<DB name>',
          query='SELECT version()')
  
  auth = {
          'X-ClickHouse-User': '<DB username>',
          'X-ClickHouse-Key': '<DB user password>',
      }
  
  rs = requests.get(url, headers=auth)
  rs.raise_for_status()
  
  print(rs.text)
  ```

  **Connecting:**

  ```bash
  python3 connect.py
  ```

- PHP

  **Before connecting:**

  1. Install the dependencies:

     ```bash
     sudo apt update && sudo apt install -y php
     ```

  1. Make sure that the `allow_url_fopen` parameter is set to `On` in the PHP settings:

     ```bash
     cat /etc/php/7.4/apache2/php.ini | grep "allow_url_fopen"
     ```

     Otherwise, set this value and restart Apache:

     ```bash
     sudo sed -i 's/\(^allow_url_fopen = \).*/\1On/' /etc/php/7.4/apache2/php.ini && \
     sudo systemctl restart apache2
     ```

  **Code example for connecting via SSL:**

  `connect.php`

  ```php
  <?php
    $host = '<FQDN of any {{ CH }} host>';
    $db = '<DB name>';
    $query = 'SELECT version()';
  
    $auth = [
        'X-ClickHouse-User: <DB username>',
        'X-ClickHouse-Key: <DB user password>',
    ];
  
    $ssl = [
        'cafile' => '{{ crt-local-dir }}{{ crt-local-file }}',
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

  **Code example for connecting without SSL:**

  `connect.php`

  ```php
  <?php
    $host = '<FQDN of any {{ CH }} host>';
    $db = '<DB name>';
    $query = 'SELECT version()';
  
    $auth = [
        'X-ClickHouse-User: <DB username>',
        'X-ClickHouse-Key: <DB user password>',
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

  **Connecting:**

  ```bash
  php connect.php
  ```

- Java

  **Before connecting:**

  1. Install the dependencies:

     ```bash
     sudo apt update && sudo apt install -y default-jdk maven
     ```

  1. Create a folder for the Maven project:

     ```bash
     cd ~/ && mkdir -p project/src/java/com/example && cd project/
     ```

  1. Create a configuration file for Maven:

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
           <groupId>com.clickhouse</groupId>
           <artifactId>clickhouse-jdbc</artifactId>
           <version>0.3.2</version>
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

     Up-to-date versions of dependencies for Maven:
     - [clickhouse-jdbc](https://mvnrepository.com/artifact/com.clickhouse/clickhouse-jdbc)
     - [slf4j-simple](https://mvnrepository.com/artifact/org.slf4j/slf4j-simple)

  **Code example for connecting via SSL:**

  `src/java/com/example/App.java`

  ```java
  package com.example;
  
  import java.sql.*;
  
  public class App {
    public static void main(String[] args) {
      String DB_HOST    = "<FQDN of any {{ CH }} host>";
      String DB_NAME    = "<DB name>";
      String DB_USER    = "<DB username>";
      String DB_PASS    = "<DB user password>";
  
      String CACERT     = "{{ crt-local-dir }}{{ crt-local-file }}";
  
      String DB_URL = String.format("jdbc:clickhouse://%s:8443/%s?ssl=1&sslmode=strict&sslrootcert=%s", DB_HOST, DB_NAME, CACERT);
  
      try {
        Class.forName("com.clickhouse.jdbc.ClickHouseDriver");
  
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        ResultSet rs = conn.createStatement().executeQuery("SELECT version()");
        if(rs.next()) {System.out.println(rs.getString(1));}
  
        conn.close();
      }
      catch(Exception ex) {ex.printStackTrace();}
    }
  }  
  ```

  **Code example for connecting without SSL:**

  `src/java/com/example/App.java`

  ```java
  package com.example;
  
  import java.sql.*;
  
  public class App {
    public static void main(String[] args) {
      String DB_HOST    = "<FQDN of any {{ CH }} host>";
      String DB_NAME    = "<DB name>";
      String DB_USER    = "<DB username>";
      String DB_PASS    = "<DB user password>";
  
      String DB_URL = String.format("jdbc:clickhouse://%s:8123/%s", DB_HOST, DB_NAME);
  
      try {
        Class.forName("com.clickhouse.jdbc.ClickHouseDriver");
  
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
        ResultSet rs = conn.createStatement().executeQuery("SELECT version()");
        if(rs.next()) {System.out.println(rs.getString(1));}
  
        conn.close();
      }
      catch(Exception ex) {ex.printStackTrace();}
    }
  }  
  ```

  **Connecting:**

  ```bash
  mvn clean package && \
  java -jar target/app-0.1.0-jar-with-dependencies.jar
  ```

- Node.js

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y nodejs npm && \
  npm install querystring
  ```

  **Code example for connecting via SSL:**

  `app.js`

  ```js
  "use strict"
  const https = require('https');
  const querystring = require('querystring');
  const fs = require('fs');
  
  const DB_HOST = "<FQDN of any {{ CH }} host>";
  const DB_NAME = "<DB name>";
  const DB_USER = "<DB username>";
  const DB_PASS = "<DB user password>";
  
  const CACERT = "{{ crt-local-dir }}{{ crt-local-file }}";
  
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

  **Code example for connecting without SSL:**

  `app.js`

  ```js
  "use strict"
  const http = require('http');
  const querystring = require('querystring');
  const fs = require('fs');
  
  const DB_HOST = "<FQDN of any {{ CH }} host>";
  const DB_NAME = "<DB name>";
  const DB_USER = "<DB username>";
  const DB_PASS = "<DB user password>";
  
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

  **Connecting:**

  ```bash
  node app.js
  ```

- Go

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y golang git
  ```

  **Code example for connecting via SSL:**

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
  
      const DB_HOST = "<FQDN of any {{ CH }} host>"
      const DB_NAME = "<DB name>"
      const DB_USER = "<DB username>"
      const DB_PASS = "<DB user password>"
  
      const CACERT = "{{ crt-local-dir }}{{ crt-local-file }}"
  
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

  **Code example for connecting without SSL:**

  `connect.go`

  ```go
  package main
  
  import (
      "fmt"
      "net/http"
      "io/ioutil"
  )
  
  func main() {
  
      const DB_HOST = "<FQDN of any {{ CH }} host>"
      const DB_NAME = "<DB name>"
      const DB_USER = "<DB username>"
      const DB_PASS = "<DB user password>"
  
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

  **Connecting:**

  ```bash
  go run connect.go
  ```

- Ruby

  **Before connecting, install the dependencies:**

  ```bash
  sudo apt update && sudo apt install -y ruby
  ```

  **Code example for connecting via SSL:**

  `connect.rb`

  ```ruby
  require "net/http"
  require "openssl"
  require "uri"
  
  DB_HOST = "<FQDN of any {{ CH }} host>"
  DB_NAME = "<DB name>"
  DB_USER = "<DB username>"
  DB_PASS = "<DB user password>"
  
  QUERYSTRING = { :database => DB_NAME, :query => "SELECT version()" }
  
  uri = URI("https://" + DB_HOST + "/")
  uri.port = 8443
  uri.query = URI.encode_www_form(QUERYSTRING)
  
  req = Net::HTTP::Get.new(uri)
  req.add_field("X-ClickHouse-User", DB_USER)
  req.add_field("X-ClickHouse-Key", DB_PASS)
  
  conn = Net::HTTP.new(uri.host, uri.port)
  conn.ca_file = "{{ crt-local-dir }}{{ crt-local-file }}"
  conn.use_ssl = true
  conn.verify_mode = OpenSSL::SSL::VERIFY_PEER
  
  rs = conn.request(req)
  puts rs.body
  ```

  **Code example for connecting without SSL:**

  `connect.rb`

  ```ruby
  require "net/http"
  require "uri"
  
  DB_HOST = "<FQDN of any {{ CH }} host>"
  DB_NAME = "<DB name>"
  DB_USER = "<DB username>"
  DB_PASS = "<DB user password>"
  
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

  **Connecting:**

  ```bash
  ruby connect.rb
  ```

- ODBC

  **Before connecting:**

  1. Install the dependencies:

     ```bash
     sudo apt update && sudo apt install -y git unixodbc build-essential cmake \
     libpoco-dev libssl-dev libicu-dev unixodbc-dev && \
     cd ~/ && git clone https://github.com/ClickHouse/clickhouse-odbc.git && \
     cd clickhouse-odbc/ && git submodule update --init
     ```

  1. Build the driver from the source files:

     ```bash
     cd ~/clickhouse-odbc/ && mkdir build && cd build && \
     cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo .. && \
     cmake --build . --config RelWithDebInfo
     ```

  1. After the build process is complete, copy the driver files to the `/usr/local/lib64/` directory:

     ```bash
     sudo mkdir -p /usr/local/lib64 && sudo cp driver/*.so /usr/local/lib64/
     ```

  1. Register the {{ CH }} ODBC driver by adding the following lines to the `odbcinst.ini` file ([sample file](https://github.com/ClickHouse/clickhouse-odbc/blob/master/packaging/odbcinst.ini.sample)):

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

  **Example of settings in the 'odbc.ini' file for connecting via SSL:**

  `/etc/odbc.ini`

  ```ini
  [ClickHouse]
  Driver = ClickHouse ODBC Driver (Unicode)
  Server = <FQDN of any {{ CH }} host>
  Database = <DB name>
  UID = <DB username>
  PWD = <DB user password>
  Port = 8443
  Proto = https
  SSLMode = allow
  CertificateFile = {{ crt-local-dir }}{{ crt-local-file }}
  ```

  **Example of settings in the `odbc.ini` file for connecting without SSL:**

  `/etc/odbc.ini`

  ```ini
  [ClickHouse]
  Driver = ClickHouse ODBC Driver (Unicode)
  Server = <FQDN of any {{ CH }} host>
  Database = <DB name>
  UID = <DB username>
  PWD = <DB user password>
  Port = 8123
  Proto = http
  ```

  **Connecting:**

  ```bash
  isql -v ClickHouse
  ```

  After connecting to the DBMS, run the command `SELECT version();`.

- PowerShell

  **Connecting via SSL:**

  ```powershell
  curl.exe `
    -H "X-ClickHouse-User: <DB username>" `
    -H "X-ClickHouse-Key: <DB user password>" `
    'https://<FQDN of any {{ CH }} host>:8443/?database=<DB name>&query=SELECT+version()'
  ```

  **Connecting without SSL:**

  ```powershell
  curl.exe `
    -H "X-ClickHouse-User: <DB username>" `
    -H "X-ClickHouse-Key: <DB user password>" `
    'http://<FQDN of any {{ CH }} host>:8123/?database=<DB name>&query=SELECT+version()'
  ```

{% endlist %}
