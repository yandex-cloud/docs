# Примеры кода для подключения к шардированному кластеру Valkey™

## C# {#csharp}

**Перед подключением:**

1. Установите зависимости:

   ```bash
   sudo apt update && sudo apt install --yes apt-transport-https dotnet-sdk-6.0
   ```

1. Создайте директорию для проекта:

    ```bash
    cd ~/ && mkdir cs-project && cd cs-project
    ```

1. Создайте конфигурационный файл:

    {% cut "RedisClient.csproj" %}

    ```xml
    <Project Sdk="Microsoft.NET.Sdk">
      <PropertyGroup>
        <OutputType>Exe</OutputType>
        <TargetFramework>net6.0</TargetFramework>
      </PropertyGroup>
      <ItemGroup>
        <PackageReference Include="StackExchange.Redis" Version="2.8.58" />
      </ItemGroup>
    </Project>
    ```

    {% endcut %}

1. Для подключения с SSL [получите SSL-сертификат](index.md#get-ssl-cert).

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    `Program.cs`

    ```csharp
    using System;
    using System.Threading.Tasks;
    using StackExchange.Redis;

    namespace RedisClient
    {
        class Program
        {
            // Configuration constants
            private const string TEST_KEY = "test-key";
            private const string TEST_VALUE = "test-value";
            private const string USERNAME = "default";
            private const string PASSWORD = "<пароль>";

            static async Task<int> Main(string[] args)
            {
                try
                {
                    var masterOptions = new ConfigurationOptions
                    {
                        EndPoints = {
                            "<FQDN_хоста-мастера_в_шарде_1>:6379",
                            ...
                            "<FQDN_хоста-мастера_в_шарде_N>:6379"
                        },
                        User = USERNAME,
                        Password = PASSWORD
                    };

                    var connection = await ConnectionMultiplexer.ConnectAsync(masterOptions);

                    var db = connection.GetDatabase();

                    // Send SET command
                    bool setResult = await db.StringSetAsync(TEST_KEY, TEST_VALUE);
                    if (!setResult)
                    {
                        Console.WriteLine($"SET failed for key {TEST_KEY}");
                        return 1;
                    }
                    Console.WriteLine($"Successfully set {TEST_KEY} = {TEST_VALUE}");

                    // Send GET command
                    var getResult = await db.StringGetAsync(TEST_KEY);
                    if (!getResult.HasValue)
                    {
                        Console.WriteLine($"GET failed: Key {TEST_KEY} not found");
                        return 1;
                    }

                    string retrievedValue = getResult.ToString();
                    if (retrievedValue != TEST_VALUE)
                    {
                        Console.WriteLine($"GET failed. Expected: '{TEST_VALUE}', Actual: '{retrievedValue}'");
                        return 1;
                    }
                    Console.WriteLine($"Successfully retrieved {TEST_KEY} = {retrievedValue}");

                return 0;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Operation failed: {ex.Message}");
                return 1;
            }
            }
        }    
    }
    ```

- Подключение с SSL {#with-ssl}

    `Program.cs`

    ```csharp
    using System;
    using System.Threading.Tasks;
    using System.Net.Security;
    using System.Security.Authentication;
    using System.Security.Cryptography.X509Certificates;
    using StackExchange.Redis;

    namespace RedisClient
    {
        class Program
        {
            // Configuration constants
            private const string TEST_KEY = "test-key";
            private const string TEST_VALUE = "test-value";
            private const string USERNAME = "default";
            private const string PASSWORD = "<пароль>";
            private const string CERT = "/home/<домашняя_директория>/.redis/YandexInternalRootCA.crt"            

            static async Task<int> Main(string[] args)
            {
                try
                {
                    var masterOptions = new ConfigurationOptions
                    {
                        EndPoints = {
                            "<FQDN_хоста-мастера_в_шарде_1>:6380",
                            ...
                            "<FQDN_хоста-мастера_в_шарде_N>:6380"
                        },
                        User = USERNAME,
                        Password = PASSWORD,
                        Ssl = true
                    };
                    masterOptions.CertificateValidation += (
                        object sender,
                        X509Certificate? certificate,
                        X509Chain? chain,
                        SslPolicyErrors sslPolicyErrors) =>
                    {
                        if (certificate == null) {
                            return false;       
                        }
                        var ca = new X509Certificate2(CERT);
                        bool verdict = (certificate.Issuer == ca.Subject);
                        if (verdict) {
                            return true;
                        }
                        Console.WriteLine("Certificate error: {0}", sslPolicyErrors);
                        return false;
                    }

                    var connection = await ConnectionMultiplexer.ConnectAsync(masterOptions);

                    var db = connection.GetDatabase();

                    // Send SET command
                    bool setResult = await db.StringSetAsync(TEST_KEY, TEST_VALUE);
                    if (!setResult)
                    {
                        Console.WriteLine($"SET failed for key {TEST_KEY}");
                        return 1;
                    }
                    Console.WriteLine($"Successfully set {TEST_KEY} = {TEST_VALUE}");

                    // Send GET command
                    var getResult = await db.StringGetAsync(TEST_KEY);
                    if (!getResult.HasValue)
                    {
                        Console.WriteLine($"GET failed: Key {TEST_KEY} not found");
                        return 1;
                    }

                    string retrievedValue = getResult.ToString();
                    if (retrievedValue != TEST_VALUE)
                    {
                        Console.WriteLine($"GET failed. Expected: '{TEST_VALUE}', Actual: '{retrievedValue}'");
                        return 1;
                    }
                    Console.WriteLine($"Successfully retrieved {TEST_KEY} = {retrievedValue}");

                return 0;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Operation failed: {ex.Message}");
                return 1;
            }
            }
        }    
    }
    ```

{% endlist %}

О том, как получить FQDN хоста, читайте в [инструкции](fqdn.md).

**Подключение:**

```bash
cd ~/cs-project && \
dotnet build && dotnet run bin/Debug/net6.0/RedisClient
```

При успешном подключении к кластеру и выполнении тестового запроса будут выведены строки:

```text
Successfully set test-key = test-value
Successfully retrieved test-key = test-value
```

## Go {#go}

**Перед подключением установите зависимости**:

```bash
sudo apt update && sudo apt install --yes golang git && \
go mod init github.com/go-redis/redis && \
go get github.com/redis/go-redis/v9
```

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    `connect.go`

    ```go
    package main

    import (
    	"fmt"
    	"github.com/go-redis/redis/v7"
    	"time"
    )

    func main() {
    	hostports := []string{
    		"<FQDN_хоста-мастера_в_шарде_1>:6379",
    		...
    		"<FQDN_хоста-мастера_в_шарде_N>:6379",
    	}
    	options := redis.UniversalOptions{
    		Addrs:       hostports,
    		DB:          0,
    		ReadOnly:    false,
    		DialTimeout: 5 * time.Second,
    		Password:    "<пароль>",
    	}
    	client := redis.NewUniversalClient(&options)

    	err := client.Set("foo", "bar", 0).Err()
    	if err != nil {
    		panic(err)
    	}

    	result, err := client.Get("foo").Result()
    	if err != nil {
    		panic(err)
    	}
    	fmt.Println(result)

    	client.Close()
    }
    ```

- Подключение с SSL {#with-ssl}

    `connect.go`

    ```go
    package main

    import (
        "context"
        "crypto/tls"
        "crypto/x509"
        "fmt"
        "net"
        "os"
        "strings"
        "time"

        "github.com/redis/go-redis/v9"
    )

    func main() {
        caCert, err := os.ReadFile("/home/<домашняя_директория>/.redis/YandexInternalRootCA.crt")
        if err != nil {
            panic(err)
        }
        caCertPool := x509.NewCertPool()
        caCertPool.AppendCertsFromPEM(caCert)

        hostports := []string{
            "<FQDN_хоста-мастера_в_шарде_1>:6380",
            ...
            "<FQDN_хоста-мастера_в_шарде_N>:6380",
        }
        options := redis.UniversalOptions{
            Addrs:        hostports,
            MaxRedirects: 1,
            Password:     "password",
            DB:           0,
            ReadOnly:     false,
            DialTimeout:  5 * time.Second,
            TLSConfig: &tls.Config{
                RootCAs:            caCertPool,
                ServerName: "c-<идентификатор_кластера>.rw.mdb.yandexcloud.net",
                VerifyPeerCertificate: func(rawCerts [][]byte, verifiedChains [][]*x509.Certificate) error {
                    certs := make([]*x509.Certificate, len(rawCerts))
                    for i := 0; i < len(rawCerts); i++ {
                        cert, err := x509.ParseCertificate(rawCerts[i])
                        if err != nil {
                            return fmt.Errorf("error parsing certificate: %+v", err)
                        }
                        certs[i] = cert
                    }

                    opts := x509.VerifyOptions{
                        Roots:         caCertPool,
                        CurrentTime:   time.Now(),
                        DNSName:       "",
                        Intermediates: x509.NewCertPool(),
                    }

                    for i := range certs {
                        if i == 0 {
                            continue
                        }
                        opts.Intermediates.AddCert(certs[i])
                    }
                    _, err := certs[0].Verify(opts)
                    return err
                },
            },
        }
        options.Dialer = func(ctx context.Context, network, addr string) (net.Conn, error) {
            parts := strings.Split(addr, ":")
            newAddr := addr
            if len(parts) > 1 && !strings.HasPrefix(parts[0], "[") {
                newAddr = "[" + strings.Join(parts[:len(parts)-1], ":") + "]:" + parts[len(parts)-1]
            }

            netDialer := &net.Dialer{
                Timeout:   options.DialTimeout,
                KeepAlive: 5 * time.Minute,
            }
            return tls.DialWithDialer(netDialer, network, newAddr, options.TLSConfig)
        }

        ctx := context.Background()

        client := redis.NewUniversalClient(&options)
        err = client.Set(ctx, "foo", "bar", 0).Err()
        if err != nil {
            panic(err)
        }

        get := client.Get(ctx, "foo")
        err = get.Err()
        if err != nil {
            panic(err)
        }
        fmt.Println(get.String())
    }
    ```

{% endlist %}

О том, как получить FQDN хоста, читайте в [инструкции](fqdn.md).

**Подключение:**

```bash
go run connect.go
```

При успешном подключении к кластеру и выполнении тестового запроса будет выведена строка `bar`.

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
          <groupId>redis.clients</groupId>
          <artifactId>jedis</artifactId>
          <version>3.7.0</version>
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

    * [jedis](https://mvnrepository.com/artifact/redis.clients/jedis)
    * [slf4j-simple](https://mvnrepository.com/artifact/org.slf4j/slf4j-simple)

1. Для подключения с SSL:

    1. [Получите SSL-сертификат](index.md#get-ssl-cert).
    1. Создайте защищенное хранилище сертификатов:

        ```bash
        keytool -importcert \
                -alias YARootCrt \
                -file ~/.redis/YandexInternalRootCA.crt \
                -keystore ~/.redis/YATrustStore \
                -storepass <пароль_защищенного_хранилища> \
                --noprompt && chmod 0655 ~/.redis/YATrustStore
        ```

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    `src/java/com/example/App.java`

    ```java
    package com.example;

    import java.util.HashSet;
    import redis.clients.jedis.HostAndPort;
    import redis.clients.jedis.JedisCluster;
    import redis.clients.jedis.JedisPoolConfig;

    public class App {
      public static void main(String[] args) {
        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();

        HashSet<HostAndPort> jedisClusterNodes = new HashSet<HostAndPort>();
        jedisClusterNodes.add(new HostAndPort("<FQDN_хоста-мастера_в_шарде_1>", 6379));
        ...
        jedisClusterNodes.add(new HostAndPort("<FQDN_хоста-мастера_в_шарде_N>", 6379));

        DefaultJedisClientConfig jedisClientConfig = DefaultJedisClientConfig.builder().
                password("<пароль>").
                build();

        try {
          JedisCluster jc = new JedisCluster(jedisClusterNodes, jedisClientConfig, 5, jedisPoolConfig);

          jc.set("foo", "bar");
          System.out.println(jc.get("foo"));
          jc.close();
        } catch (Exception ex) {
          ex.printStackTrace();
        }
      }
    }
    ```

- Подключение с SSL {#with-ssl}

    `src/java/com/example/App.java`

    ```java
    package com.example;

    import redis.clients.jedis.DefaultJedisClientConfig;
    import redis.clients.jedis.HostAndPort;
    import redis.clients.jedis.JedisCluster;
    import redis.clients.jedis.JedisPoolConfig;

    import javax.net.ssl.SSLParameters;
    import java.util.HashSet;
    import java.util.Set;

    public class App {
      public static void main(String[] args) {
        System.setProperty("javax.net.ssl.trustStore", "/home/<домашняя_директория>/.redis/YATrustStore");
        System.setProperty("javax.net.ssl.trustStorePassword", "<пароль_защищенного_хранилища_сертификатов>");

        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
        Set<HostAndPort> jedisClusterNodes = new HashSet<HostAndPort>();
        SSLParameters sslParameters = new SSLParameters();
        jedisClusterNodes.add(new HostAndPort("<FQDN_хоста-мастера_в_шарде_1>", 6380));
        ...
        jedisClusterNodes.add(new HostAndPort("<FQDN_хоста-мастера_в_шарде_N>", 6380));

        DefaultJedisClientConfig jedisClientConfig = DefaultJedisClientConfig.builder().
                password("<пароль_кластера>").
                ssl(true).
                sslParameters(sslParameters).
                build();

        try {
          JedisCluster jc = new JedisCluster(jedisClusterNodes, jedisClientConfig, 5, jedisPoolConfig);

          jc.set("foo", "bar");
          System.out.println(jc.get("foo"));
          jc.close();
        } catch (Exception ex) {
          ex.printStackTrace();
        }
      }
    }
    ```

{% endlist %}

О том, как получить FQDN хоста, читайте в [инструкции](fqdn.md).

**Подключение:**

```bash
mvn clean package && \
java -jar target/app-0.1.0-jar-with-dependencies.jar
```

При успешном подключении к кластеру и выполнении тестового запроса будет выведена строка `bar`.

## Node.js {#nodejs}

**Перед подключением установите зависимости:**

```bash
sudo apt update && sudo apt install --yes nodejs npm && \
npm install ioredis
```

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    `app.js`

    ```javascript
    "use strict";

    const Redis = require("ioredis");

    const cluster = new Redis.Cluster(
        [
            {
                host: "<FQDN_хоста-мастера_в_шарде_1>",
                port: 6379
            },
            ...
            {
                host: "<FQDN_хоста-мастера_в_шарде_N>",
                port: 6379
            }
        ],
        {
            redisOptions: {
                password: "<пароль>"
            }
        }
    );

    cluster.on("ready", () => {
        Promise.all([
            cluster.set("foo", "bar"),
            cluster.get("foo")
        ]).then(
            (result) => {
                console.log(result[1]); // result == ["OK", "bar"]
                cluster.disconnect();
            },
            (reject) => {
                console.log(reject);
                cluster.disconnect();
            }
        );
    });
    ```

- Подключение с SSL {#with-ssl}

    `app.js`

    ```javascript
    "use strict";

    const Redis = require("ioredis");
    const fs = require("fs");

    const cluster = new Redis.Cluster(
        [
            {
                host: "<FQDN_хоста-мастера_в_шарде_1>",
                port: 6380
            },
            ...
            {
                host: "<FQDN_хоста-мастера_в_шарде_N>",
                port: 6380
            },
        ],
        {
            redisOptions: {
                password: "<пароль>",
                tls: {
                    ca: [fs.readFileSync("/home/<домашняя_директория>/.redis/YandexInternalRootCA.crt")],
                    checkServerIdentity: () => {
                        return null;
                    }
                }
            }
        }
    );

    cluster.on("ready", () => {
        Promise.all([
            cluster.set("foo", "bar"),
            cluster.get("foo")
        ]).then(
            (result) => {
                console.log(result[1]); // result == [ "OK", "bar"]
                cluster.disconnect();
            },
            (reject) => {
                 console.log(reject);
                 cluster.disconnect();
            }
        );
    });
    ```

{% endlist %}

О том, как получить FQDN хоста, читайте в [инструкции](fqdn.md).

**Подключение:**

```bash
node app.js
```

При успешном подключении к кластеру и выполнении тестового запроса будет выведена строка `bar`.

## PHP {#php}

**Перед подключением установите зависимости:**

```bash
sudo apt update && sudo apt install --yes php php-dev php-pear && \
sudo pear channel-discover pear.nrk.io && \
sudo pear install nrk/Predis
```

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    `connect.php`

    ```php
    <?php

    require "Predis/Autoloader.php";
    Predis\Autoloader::register();

    $hosts = [
        "tcp://<FQDN_хоста-мастера_в_шарде_1>:6379",
        ...
        "tcp://<FQDN_хоста-мастера_в_шарде_N>:6379",
    ];

    $options = [
        "cluster" => "redis",
        "parameters" => [
            "password" => "<пароль>",
        ],
    ];

    $conn = new Predis\Client($hosts, $options);
    $conn->set("foo", "bar");

    var_dump($conn->get("foo"));

    $conn->disconnect();
    ?>
    ```

- Подключение с SSL {#with-ssl}

   `connect.php`

   ```php
   <?php

   require "Predis/Autoloader.php";
   Predis\Autoloader::register();

   $hosts = [
       'tls://<FQDN_хоста-мастера_в_шарде_1>:6380?ssl[cafile]=/home/<домашняя_директория>/.redis/YandexInternalRootCA.crt',
       ...
       'tls://<FQDN_хоста-мастера_в_шарде_N>:6380?ssl[cafile]=/home/<домашняя_директория>/.redis/YandexInternalRootCA.crt',
   ];

   $options = [
       'cluster' => 'predis',
       'parameters' => [
           'password' => '<пароль>',
       ],
   ];

   $conn = new Predis\Client($hosts, $options);
   $conn->set('foo', 'bar');

   var_dump($conn->get("foo"));

   $conn->disconnect();
   ?>
   ```

{% endlist %}

О том, как получить FQDN хоста, читайте в [инструкции](fqdn.md).

**Подключение:**

```bash
php connect.php
```

При успешном подключении к кластеру и выполнении тестового запроса будет выведена строка `bar`.

## Python {#python}

**Перед подключением установите зависимости**:

```bash
sudo apt update && sudo apt install -y python3 python3-pip python3-venv && \
python3 -m venv env && \
source env/bin/activate && \
pip install pip -U && \
pip install pyopenssl redis-py-cluster setuptools_rust
```

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    `connect.py`

    ```python
    from rediscluster import RedisCluster

    startup_nodes = [
        {"host": "<FQDN_хоста-мастера_в_шарде_1>", "port": 6379},
        ...
        {"host": "<FQDN_хоста-мастера_в_шарде_N>", "port": 6379},
    ]

    rc = RedisCluster(
        startup_nodes=startup_nodes,
        decode_responses=True,
        skip_full_coverage_check=True,
        password="<пароль>",
    )

    rc.set("foo", "bar")

    print(rc.get("foo"))
    ```

- Подключение с SSL {#with-ssl}

    `connect.py`

    ```python
    import OpenSSL
    from rediscluster import RedisCluster

    startup_nodes = [
        {"host": "<FQDN_хоста-мастера_в_шарде_1>", "port": 6380},
        ...
        {"host": "<FQDN_хоста-мастера_в_шарде_N>", "port": 6380},
    ]

    rc = RedisCluster(
        startup_nodes=startup_nodes,
        decode_responses=True,
        skip_full_coverage_check=True,
        password="<пароль>",
        ssl=True,
        ssl_ca_certs="/home/<домашняя_директория>/.redis/YandexInternalRootCA.crt",
    )

    rc.set("foo", "bar")

    print(rc.get("foo"))
    ```

{% endlist %}

О том, как получить FQDN хоста, читайте в [инструкции](fqdn.md).

**Подключение:**

```bash
python3 connect.py
```

При успешном подключении к кластеру и выполнении тестового запроса будет выведена строка `bar`.

## Ruby {#ruby}

**Перед подключением установите зависимости:**

```bash
sudo apt update && sudo apt install --yes ruby && \
sudo gem install redis
```

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    `connect.rb`

    ```ruby
    # coding: utf-8

    require 'redis'

    nodes = [
      { host: '<FQDN_хоста-мастера_в_шарде_1>', port: 6379 },
      ...
      { host: '<FQDN_хоста-мастера_в_шарде_N>', port: 6379 }
    ]

    conn = Redis.new(
       cluster: nodes,
       password: '<пароль>'
    )

    conn.set('foo', 'bar')
    puts conn.get('foo')

    conn.close
    ```

- Подключение с SSL {#with-ssl}

    `connect.rb`

    ```ruby
    # coding: utf-8

    require 'redis'

    nodes = [
      { host: '<FQDN_хоста-мастера_в_шарде_1>', port: 6380 },
      ...
      { host: '<FQDN_хоста-мастера_в_шарде_N>', port: 6380 }
    ]

    conn = Redis.new(
      cluster: nodes,
      password: '<пароль>',
      ssl: true,
      ssl_params: {
        ca_file: '/home/<домашняя_директория>/.redis/YandexInternalRootCA.crt',
        verify_hostname: false
      }
    )

    conn.set('foo', 'bar')
    puts conn.get('foo')

    conn.close
    ```

{% endlist %}

О том, как получить FQDN хоста, читайте в [инструкции](fqdn.md).

**Подключение:**

```bash
ruby connect.rb
```

При успешном подключении к кластеру и выполнении тестового запроса будет выведена строка `bar`.