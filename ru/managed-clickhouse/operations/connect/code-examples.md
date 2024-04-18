---
title: "Примеры кода для подключения к кластеру {{ CH }} в {{ mch-full-name }}"
description: "Следуя этим примерам, вы сможете подключиться к базе данных в кластере {{ CH }} из кода вашего приложения."
---

# Примеры кода для подключения к кластеру {{ CH }}

Вы можете подключаться к хостам кластера {{ CH }} в публичном доступе только с использованием [SSL-сертификатов](index.md#get-ssl-cert). В примерах ниже предполагается, что сертификаты `{{ crt-local-file-root }}` и `{{ crt-local-file-int }}`:

* расположены в директории `{{ crt-local-dir }}` — для Ubuntu;
* импортированы в хранилище доверенных корневых сертификатов — для Windows.

Подключение без использования SSL-сертификатов поддерживается только для хостов, находящихся не в публичном доступе. В этом случае трафик внутри виртуальной сети при подключении к БД шифроваться не будет.

При необходимости перед подключением [настройте группы безопасности](index.md#configure-security-groups) кластера.

При успешном подключении к кластеру и выполнении тестового запроса будет выведена версия {{ CH }}.

{% include [see-fqdn-in-console](../../../_includes/mdb/see-fqdn-in-console.md) %}

Примеры для Linux проверялись в следующем окружении:

* Виртуальная машина в {{ yandex-cloud }} с Ubuntu 20.04 LTS.
* Bash: `5.0.16`.
* Python: `3.8.2`; pip3: `20.0.2`.
* PHP: `7.4.3`.
* OpenJDK: `11.0.8`; Maven: `3.6.3`.
* Node.JS: `10.19.0`, npm: `6.14.4`.
* Go: `1.13.8`.
* Ruby: `2.7.0p0`.
* unixODBC: `2.3.6`.

Примеры для Windows проверялись в следующем окружении:

* Локальная машина с Windows 10 Pro build `19042.1052`.
* PowerShell: `5.1.19041`.

## Go {#go}

**Перед подключением установите зависимости:**

```bash
sudo apt update && sudo apt install --yes golang git
```

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

  `connect.go`

    ```go
    package main

    import (
        "fmt"
        "net/http"
        "io/ioutil"
    )

    func main() {

        const DB_HOST = "<FQDN_любого_хоста_{{ CH }}>"
        const DB_NAME = "<имя_БД>"
        const DB_USER = "<имя_пользователя_БД>"
        const DB_PASS = "<пароль_пользователя_БД>"

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


- Подключение с SSL {#with-ssl}

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

        const DB_HOST = "<FQDN_любого_хоста_{{ CH }}>"
        const DB_NAME = "<имя_БД>"
        const DB_USER = "<имя_пользователя_БД>"
        const DB_PASS = "<пароль_пользователя_БД>"

        const CACERT = "{{ crt-local-dir }}{{ crt-local-file-root }}"

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

{% endlist %}

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

**Подключение:**

```bash
go run connect.go
```

## Java {#java}

**Перед подключением:**

1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install --yes default-jdk maven
    ```

1. Создайте директорию для проекта Maven:

    ```bash
    cd ~/ && mkdir --parents project/src/java/com/example && cd project/
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
          <groupId>com.clickhouse</groupId>
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

   Актуальные версии зависимостей для Maven:

    * [clickhouse-jdbc](https://mvnrepository.com/artifact/com.clickhouse/clickhouse-jdbc)
    * [slf4j-simple](https://mvnrepository.com/artifact/org.slf4j/slf4j-simple)

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

  `src/java/com/example/App.java`

    ```java
    package com.example;

    import java.sql.*;

    public class App {
      public static void main(String[] args) {
        String DB_HOST    = "<FQDN_любого_хоста_{{ CH }}>";
        String DB_NAME    = "<имя_БД>";
        String DB_USER    = "<имя_пользователя_БД>";
        String DB_PASS    = "<пароль_пользователя_БД>";

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


- Подключение с SSL {#with-ssl}

  `src/java/com/example/App.java`

    ```java
    package com.example;

    import java.sql.*;

    public class App {
      public static void main(String[] args) {
        String DB_HOST    = "<FQDN_любого_хоста_{{ CH }}>";
        String DB_NAME    = "<имя_БД>";
        String DB_USER    = "<имя_пользователя_БД>";
        String DB_PASS    = "<пароль_пользователя_БД>";

        String CACERT     = "{{ crt-local-dir }}{{ crt-local-file-root }}";

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

{% endlist %}

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

**Подключение:**

```bash
mvn clean package && \
java -jar target/app-0.1.0-jar-with-dependencies.jar
```

## Node.js {#nodejs}

**Перед подключением установите зависимости:**

```bash
sudo apt update && sudo apt install --yes nodejs npm && \
npm install querystring
```

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

  `app.js`

    ```js
    "use strict"
    const http = require('http');
    const querystring = require('querystring');
    const fs = require('fs');

    const DB_HOST = "<FQDN_любого_хоста_{{ CH }}>";
    const DB_NAME = "<имя_БД>";
    const DB_USER = "<имя_пользователя_БД>";
    const DB_PASS = "<пароль_пользователя_БД>";

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


- Подключение с SSL {#with-ssl}

  `app.js`

    ```js
    "use strict"
    const https = require('https');
    const querystring = require('querystring');
    const fs = require('fs');

    const DB_HOST = "<FQDN_любого_хоста_{{ CH }}>";
    const DB_NAME = "<имя_БД>";
    const DB_USER = "<имя_пользователя_БД>";
    const DB_PASS = "<пароль_пользователя_БД>";

    const CACERT = "{{ crt-local-dir }}{{ crt-local-file-root }}";

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

{% endlist %}

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

**Подключение:**

```bash
node app.js
```

## ODBC {#odbc}

Способ настройки различается для [Linux](#odbc-linux) и [Windows](#odbc-windows).

### Linux {#odbc-linux}

**Перед подключением:**

1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install --yes git unixodbc build-essential cmake \
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
    sudo mkdir --parents /usr/local/lib64 && sudo cp driver/*.so /usr/local/lib64/
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

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

  `/etc/odbc.ini`

    ```ini
    [ClickHouse]
    Driver = ClickHouse ODBC Driver (Unicode)
    Server = <FQDN_любого_хоста_{{ CH }}>
    Database = <имя_БД>
    UID = <имя_пользователя_БД>
    PWD = <пароль_пользователя_БД>
    Port = 8123
    Proto = http
    ```


- Подключение с SSL {#with-ssl}

  `/etc/odbc.ini`

    ```ini
    [ClickHouse]
    Driver = ClickHouse ODBC Driver (Unicode)
    Server = <FQDN_любого_хоста_{{ CH }}>
    Database = <имя_БД>
    UID = <имя_пользователя_БД>
    PWD = <пароль_пользователя_БД>
    Port = 8443
    Proto = https
    SSLMode = allow
    CertificateFile = {{ crt-local-dir }}{{ crt-local-file-root }}
    CALocation = /etc/ssl/certs/ca-certificates.crt
    ```

{% endlist %}

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

**Подключение:**

```bash
isql -v ClickHouse
```

После подключения к СУБД выполните команду `SELECT version();`.

### Windows {#odbc-windows}

1. [Установите драйвер clickhouse-odbc](https://github.com/ClickHouse/clickhouse-odbc#installation) подходящей разрядности. Например, если вы используете 32-разрядное приложение для подключения через ODBC, установите драйвер такой же разрядности.
1. [Запустите приложение <q>Администратор источника данных ODBC</q>](https://learn.microsoft.com/ru-ru/sql/database-engine/configure-windows/open-the-odbc-data-source-administrator).
1. На вкладке **Пользовательские DSN** нажмите кнопку **Добавить...**
1. Выберите драйвер {{ CH }} с подходящей кодировкой и нажмите кнопку **Готово**.
1. Укажите параметры подключения к кластеру {{ CH }}:

   {% list tabs group=connection %}

    - Подключение без SSL {#without-ssl}

        * **Name** — имя подключения.
        * **Host** — [FQDN любого хоста {{ CH }}](fqdn.md).
        * **Port** — `{{ port-mch-http }}`.
        * **Database** — имя БД.
        * **User** — имя пользователя БД.
        * **Password** — пароль пользователя БД.

    - Подключение с SSL {#with-ssl}

        * **Name** — имя подключения.
        * **Host** — [FQDN любого хоста {{ CH }}](fqdn.md).
        * **Port** — `{{ port-mch-http }}`.
        * **Database** — имя БД.
        * **SSLMode** — `allow`.
        * **User** — имя пользователя БД.
        * **Password** — пароль пользователя БД.

   {% endlist %}

1. Нажмите кнопку **Ok**.
1. Подключитесь к кластеру {{ CH }} с помощью ODBC, например через приложение Microsoft Excel.

## PHP {#php}

**Перед подключением:**

1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install --yes php
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

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

  `connect.php`

    ```php
    <?php
        $host = '<FQDN_любого_хоста_{{ CH }}>';
        $db = '<имя_БД>';
        $query = 'SELECT version()';

        $auth = [
            'X-ClickHouse-User: <имя_пользователя_БД>',
            'X-ClickHouse-Key: <пароль_пользователя_БД>',
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


- Подключение с SSL {#with-ssl}

  `connect.php`

    ```php
    <?php
        $host = '<FQDN_любого_хоста_{{ CH }}>';
        $db = '<имя_БД>';
        $query = 'SELECT version()';

        $auth = [
            'X-ClickHouse-User: <имя_пользователя_БД>',
            'X-ClickHouse-Key: <пароль_пользователя_БД>',
        ];

        $ssl = [
            'cafile' => '{{ crt-local-dir }}{{ crt-local-file-root }}',
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

{% endlist %}

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

**Подключение:**

```bash
php connect.php
```

## Python (clickhouse-driver) {#python-clickhouse-driver}

**Перед подключением установите зависимости:**

```bash
sudo apt update && sudo apt install --yes python3 python3-pip && \
pip3 install clickhouse-driver
```

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

  `connect.py`

    ```python
    from clickhouse_driver import Client

    client = Client(host='<FQDN_любого_хоста_{{ CH }}>',
                    user='<имя_пользователя_БД>',
                    password='<пароль_пользователя_БД>',
                    port=9000)

    print(client.execute('SELECT version()'))
    ```


- Подключение с SSL {#with-ssl}

  `connect.py`

    ```python
    from clickhouse_driver import Client

    client = Client(host='<FQDN_любого_хоста_{{ CH }}>',
                    user='<имя_пользователя_БД>',
                    password='<пароль_пользователя_БД>',
                    port=9440,
                    secure=True,
                    verify=True,
                    ca_certs='{{ crt-local-dir }}{{ crt-local-file-root }}')

    print(client.execute('SELECT version()'))
    ```

{% endlist %}

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

**Подключение:**

```bash
python3 connect.py
```

## Python (requests) {#python-requests}

**Перед подключением установите зависимости:**

```bash
sudo apt update && sudo apt install --yes python3 python3-pip && \
pip3 install requests
```

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

  `connect.py`

    ```python
    import requests

    response = requests.get(
        'http://{0}:8123'.format('<FQDN_любого_хоста_{{ CH }}>'),
        params={
            'query': 'SELECT version()',
        },
        headers={
            'X-ClickHouse-User': '<имя_пользователя_БД>',
            'X-ClickHouse-Key': '<пароль_пользователя_БД>',
        })

    response.raise_for_status()
    print(response.text)
    ```


- Подключение с SSL {#with-ssl}

  `connect.py`

    ```python
    import requests

    response = requests.get(
        'https://{0}:8443'.format('<FQDN_любого_хоста_{{ CH }}>'),
        params={
            'query': 'SELECT version()',
        },
        verify='{{ crt-local-dir }}{{ crt-local-file-root }}',
        headers={
            'X-ClickHouse-User': '<имя_пользователя_БД>',
            'X-ClickHouse-Key': '<пароль_пользователя_БД>',
        })

    response.raise_for_status()
    print(response.text)
    ```

{% endlist %}

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

**Подключение:**

```bash
python3 connect.py
```

## Ruby {#ruby}

**Перед подключением установите зависимости:**

```bash
sudo apt update && sudo apt install --yes ruby
```

{% list tabs group=connection %}


- Подключение без SSL {#without-ssl}

  `connect.rb`

    ```ruby
    require "net/http"
    require "uri"

    DB_HOST = "<FQDN_любого_хоста_{{ CH }}>"
    DB_NAME = "<имя_БД>"
    DB_USER = "<имя_пользователя_БД>"
    DB_PASS = "<пароль_пользователя_БД>"

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


- Подключение с SSL {#with-ssl}

  `connect.rb`

    ```ruby
    require "net/http"
    require "openssl"
    require "uri"

    DB_HOST = "<FQDN_любого_хоста_{{ CH }}>"
    DB_NAME = "<имя_БД>"
    DB_USER = "<имя_пользователя_БД>"
    DB_PASS = "<пароль_пользователя_БД>"

    QUERYSTRING = { :database => DB_NAME, :query => "SELECT version()" }

    uri = URI("https://" + DB_HOST + "/")
    uri.port = 8443
    uri.query = URI.encode_www_form(QUERYSTRING)

    req = Net::HTTP::Get.new(uri)
    req.add_field("X-ClickHouse-User", DB_USER)
    req.add_field("X-ClickHouse-Key", DB_PASS)

    conn = Net::HTTP.new(uri.host, uri.port)
    conn.ca_file = "{{ crt-local-dir }}{{ crt-local-file-root }}"
    conn.use_ssl = true
    conn.verify_mode = OpenSSL::SSL::VERIFY_PEER

    rs = conn.request(req)
    puts rs.body
    ```

{% endlist %}

О том, как получить FQDN хоста, см. [инструкцию](fqdn.md).

**Подключение:**

```bash
ruby connect.rb
```

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
