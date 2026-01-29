## C# {#csharp}

{% include [Install requirements](./connect/csharp/install-requirements.md) %}

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    **Пример кода для подключения с помощью Sentinel**:

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
                    var sentinelOptions = new ConfigurationOptions
                    {
                        EndPoints = {
                            "<FQDN_хоста_1_{{ VLK }}>:{{ port-mrd-sentinel }}",
                            ...
                            "<FQDN_хоста_N_{{ VLK }}>:{{ port-mrd-sentinel }}"
                        },
                        CommandMap = CommandMap.Sentinel
                    };

                    var sentinelConnection = await ConnectionMultiplexer.ConnectAsync(sentinelOptions);

                    var endpoints = sentinelConnection.GetEndPoints();
                    var sentinelServer = sentinelConnection.GetServer(endpoints[0]);
                    var masterEndpoint = await sentinelServer.SentinelGetMasterAddressByNameAsync("mymaster");
                    await sentinelConnection.CloseAsync();

                    var masterOptions = new ConfigurationOptions
                    {
                        EndPoints = { masterEndpoint },
                        User = USERNAME,
                        Password = PASSWORD,
                        Ssl = false
                    };

                    var connection = await ConnectionMultiplexer.ConnectAsync(masterOptions);

                    var db = connection.GetDatabase();

                    bool setResult = await db.StringSetAsync(TEST_KEY, TEST_VALUE);
                    if (!setResult)
                    {
                        Console.WriteLine($"SET failed for key {TEST_KEY}");
                        return 1;
                    }
                    Console.WriteLine($"Successfully set {TEST_KEY} = {TEST_VALUE}");

                    var getResult = await db.StringGetAsync(TEST_KEY);
                    if (!getResult.HasValue)
                    {
                        Console.WriteLine($"GET failed: Key {TEST_KEY} not found");
                        return 1;
                    }

                    string retrievedValue = getResult.ToString();
                    if (retrievedValue != TEST_VALUE)
                    {
                        Console.WriteLine($"GET failed. Expected: '{TEST_VALUE}' Actual: '{retrievedValue}'");
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

    **Пример кода для подключения напрямую к мастеру**:

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
                        EndPoints = { "<FQDN_хоста-мастера_{{ VLK }}>:{{ port-mrd }}" },
                        User = USERNAME,
                        Password = PASSWORD
                    };

                    var connection = await ConnectionMultiplexer.ConnectAsync(masterOptions);

                    var db = connection.GetDatabase();

                    bool setResult = await db.StringSetAsync(TEST_KEY, TEST_VALUE);
                    if (!setResult)
                    {
                        Console.WriteLine($"SET failed for key {TEST_KEY}");
                        return 1;
                    }
                    Console.WriteLine($"Successfully set {TEST_KEY} = {TEST_VALUE}");

                    var getResult = await db.StringGetAsync(TEST_KEY);
                    if (!getResult.HasValue)
                    {
                        Console.WriteLine($"GET failed: Key {TEST_KEY} not found");
                        return 1;
                    }

                    string retrievedValue = getResult.ToString();
                    if (retrievedValue != TEST_VALUE)
                    {
                        Console.WriteLine($"GET failed. Expected: '{TEST_VALUE}' Actual: '{retrievedValue}'");
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
            private const string CERT = "/home/<домашняя_директория>/.redis/{{ crt-local-file }}"

            static async Task<int> Main(string[] args)
            {
                try
                {
                    var masterOptions = new ConfigurationOptions
                    {
                        EndPoints = { "<FQDN_хоста-мастера_{{ VLK }}>:{{ port-mrd-tls }}" },
                        User = USERNAME,
                        Password = PASSWORD,
                        Ssl = true,
                        SslProtocols = SslProtocols.Tls12 | SslProtocols.Tls13
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

{% include [see-fqdn](../../../_includes/mdb/mvk/fqdn-host.md) %}

{% include [Подключение к кластеру](./connect/csharp/after-connect.md) %}

## Go {#go}

{% include [Install requirements](./connect/go/install-requirements.md) %}

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    **Пример кода для подключения с помощью Sentinel**:

    `connect.go`

    ```go
    package main

    import (
    	"fmt"
    	"github.com/go-redis/redis/v7"
    )

    func main() {
    	conn := redis.NewUniversalClient(
    		&redis.UniversalOptions{
    			Addrs: []string{
    				"<FQDN_хоста_1_{{ VLK }}>:{{ port-mrd-sentinel }}",
    				...
    				"<FQDN_хоста_N_{{ VLK }}>:{{ port-mrd-sentinel }}"},
    			MasterName: "<имя_кластера_{{ VLK }}>",
    			Password:   "<пароль>",
    			ReadOnly:   false,
    		},
    	)
    	err := conn.Set("foo", "bar", 0).Err()
    	if err != nil {
    		panic(err)
    	}

    	result, err := conn.Get("foo").Result()
    	if err != nil {
    		panic(err)
    	}
    	fmt.Println(result)

    	conn.Close()
    }
    ```

    **Пример кода для подключения напрямую к мастеру**:

    `connect.go`

    ```go
    package main

    import (
    	"fmt"
    	"github.com/go-redis/redis/v7"
    )

    func main() {
    	conn := redis.NewUniversalClient(
    		&redis.UniversalOptions{
    			Addrs:    []string{"c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mrd }}"},
    			Password: "<пароль>",
    			ReadOnly: false,
    		},
    	)
    	err := conn.Set("foo", "bar", 0).Err()
    	if err != nil {
    		panic(err)
    	}

    	result, err := conn.Get("foo").Result()
    	if err != nil {
    		panic(err)
    	}
    	fmt.Println(result)

    	conn.Close()
    }
    ```

- Подключение с SSL {#with-ssl}

    `connect.go`

    ```go
    package main

    import (
    	"crypto/tls"
    	"crypto/x509"
    	"fmt"
    	"github.com/go-redis/redis/v7"
    	"io/ioutil"
    )

    const (
    	cert = "/home/<домашняя_директория>/.redis/{{ crt-local-file }}"
    )

    func main() {
    	rootCertPool := x509.NewCertPool()
    	pem, err := ioutil.ReadFile(cert)
    	if err != nil {
    		panic(err)
    	}

    	if ok := rootCertPool.AppendCertsFromPEM(pem); !ok {
    		panic("Failed to append PEM.")
    	}

    	conn := redis.NewUniversalClient(
    		&redis.UniversalOptions{
    			Addrs:    []string{"c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mrd-tls }}"},
    			Password: "<пароль>",
    			ReadOnly: false,
    			TLSConfig: &tls.Config{
    				RootCAs:            rootCertPool,
    			},
    		},
    	)
    	err = conn.Set("foo", "bar", 0).Err()
    	if err != nil {
    		panic(err)
    	}

    	result, err := conn.Get("foo").Result()
    	if err != nil {
    		panic(err)
    	}
    	fmt.Println(result)

    	conn.Close()
    }
    ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mvk/fqdn-host.md) %}

{% include [Подключение к кластеру](./connect/go/after-connect.md) %}

## Java {#java}

{% include [Установка зависимостей](./connect/java/install-requirements.md) %}

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    **Пример кода для подключения с помощью Sentinel**:

    `src/java/com/example/App.java`

    ```java
    package com.example;

    import java.util.HashSet;
    import redis.clients.jedis.Jedis;
    import redis.clients.jedis.JedisSentinelPool;

    public class App {
      public static void main(String[] args) {
        String redisName = "<имя_кластера_{{ VLK }}>";
        String redisPass = "<пароль>";

        HashSet sentinels = new HashSet();
        sentinels.add("<FQDN_хоста_1_{{ VLK }}>:{{ port-mrd-sentinel }}");
        ...
        sentinels.add("<FQDN_хоста_N_{{ VLK }}>:{{ port-mrd-sentinel }}");

        try {
          JedisSentinelPool pool = new JedisSentinelPool(redisName, sentinels);
          Jedis conn = pool.getResource();

          conn.auth(redisPass);
          conn.set("foo", "bar");
          System.out.println(conn.get("foo"));

          pool.close();
        } catch (Exception ex) {
          ex.printStackTrace();
        }
      }
    }
    ```

    **Пример кода для подключения напрямую к мастеру**:

    `src/java/com/example/App.java`

    ```java
    package com.example;

    import redis.clients.jedis.Jedis;

    public class App {
      public static void main(String[] args) {
        String redisHost = "c-<идентификатор_кластера>.rw.{{ dns-zone }}";
        String redisPass = "<пароль>";

        try {
          Jedis conn = new Jedis(redisHost);

          conn.auth(redisPass);
          conn.set("foo", "bar");
          System.out.println(conn.get("foo"));

          conn.close();
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
    import redis.clients.jedis.Jedis;

    import javax.net.ssl.SSLParameters;

    public class App {
      public static void main(String[] args) {
        String redisHost = "c-<идентификатор_кластера>.rw.{{ dns-zone }}";
        String redisPass = "<пароль_кластера>";

        System.setProperty("javax.net.ssl.trustStore", "/home/<домашняя_директория>/.redis/YATrustStore");
        System.setProperty("javax.net.ssl.trustStorePassword", "<пароль_защищенного_хранилища_сертификатов>");

        SSLParameters sslParameters = new SSLParameters();
        DefaultJedisClientConfig jedisClientConfig = DefaultJedisClientConfig.builder().
                password(redisPass).
                ssl(true).
                sslParameters(sslParameters).
                build();

        try {
          Jedis conn = new Jedis(new HostAndPort(redisHost, {{ port-mrd-tls }}), jedisClientConfig);

          conn.set("foo", "bar");
          System.out.println(conn.get("foo"));
          conn.close();
        } catch (Exception ex) {
          ex.printStackTrace();
        }
      }
    }
    ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mvk/fqdn-host.md) %}

{% include [Подключение к кластеру](./connect/java/after-connect.md) %}

## Node.js {#nodejs}

{% include [Установка зависимостей](./connect/nodejs/install-requirements.md) %}

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    **Пример кода для подключения с помощью Sentinel**:

    `app.js`

    ```javascript
    "use strict";
    const Redis = require("ioredis");

    const conn = new Redis({
        sentinels: [
            { host: "<FQDN_хоста_1_{{ VLK }}>", port: {{ port-mrd-sentinel }} },
            ...
            { host: "<FQDN_хоста_N_{{ VLK }}>", port: {{ port-mrd-sentinel }} },
        ],
        name: "<имя_кластера_{{ VLK }}>",
        password: "<пароль>"
    });

    conn.set("foo", "bar", function (err) {
        if (err) {
            console.error(err);
            conn.disconnect();
        }
    });

    conn.get("foo", function (err, result) {
        if (err) {
            console.error(err);
        } else {
            console.log(result);
        }

        conn.disconnect();
    });
    ```

    **Пример кода для подключения напрямую к мастеру**:

    `app.js`

    ```js
    "use strict";

    const Redis = require("ioredis");

    const conn = new Redis({
        host: "c-<идентификатор_кластера>.rw.{{ dns-zone }}",
        port: {{ port-mrd }},
        password: "<пароль>"
    });

    conn.set("foo", "bar", function (err) {
        if (err) {
            console.error(err);
            conn.disconnect();
        }
    });

    conn.get("foo", function (err, result) {
        if (err) {
            console.error(err);
        } else {
            console.log(result);
        }

        conn.disconnect();
    });
    ```

- Подключение с SSL {#with-ssl}

    `app.js`

    ```javascript
    "use strict";

    const fs = require("fs");
    const Redis = require("ioredis");

    const conn = new Redis({
        host: "c-<идентификатор_кластера>.rw.{{ dns-zone }}",
        port: {{ port-mrd-tls }},
        password: "<пароль>",
        tls: {
            ca: fs.readFileSync("/home/<домашняя_директория>/.redis/{{ crt-local-file }}"),
        }
    });

    conn.set("foo", "bar", function (err) {
        if (err) {
            console.error(err);
            conn.disconnect();
        }
    });

    conn.get("foo", function (err, result) {
        if (err) {
            console.error(err);
        } else {
            console.log(result);
        }

        conn.disconnect();
    });
    ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mvk/fqdn-host.md) %}

{% include [Подключение к кластеру](./connect/nodejs/after-connect.md) %}

## PHP {#php}

{% include [Установка зависимостей](./connect/php/install-requirements.md) %}

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    **Пример кода для подключения с помощью Sentinel**:

    `connect.php`

    ```php
    <?php
    require "Predis/Autoloader.php";
    Predis\Autoloader::register();

    $sentinels = [
        "<FQDN_хоста_1_{{ VLK }}>:{{ port-mrd-sentinel }}",
        ...
        "<FQDN_хоста_N_{{ VLK }}>:{{ port-mrd-sentinel }}",
    ];
    $options = [
        "replication" => "sentinel",
        "service" => "<имя_кластера_{{ VLK }}>",
        "parameters" => [
            "password" => "<пароль>",
        ],
    ];

    $conn = new Predis\Client($sentinels, $options);

    $conn->set("foo", "bar");
    var_dump($conn->get("foo"));

    $conn->disconnect();
    ?>
    ```

    **Пример кода для подключения напрямую к мастеру**:

    `connect.php`

    ```php
    <?php
    require "Predis/Autoloader.php";
    Predis\Autoloader::register();

    $host = ["c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mrd }}"];
    $options = [
        "parameters" => [
            "password" => "<пароль>",
        ],
    ];

    $conn = new Predis\Client($host, $options);

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

    $host = ["c-<идентификатор_кластера>.rw.{{ dns-zone }}:{{ port-mrd-tls }}"];
    $options = [
        "parameters" => [
            "scheme" => "tls",
            "ssl" => [
                "cafile" => "/home/<домашняя_директория>/.redis/{{ crt-local-file }}",
                "verify_peer" => true,
                "verify_peer_name" => false,
            ],
            "password" => "<пароль>",
        ],
    ];

    $conn = new Predis\Client($host, $options);

    $conn->set("foo", "bar");
    var_dump($conn->get("foo"));

    $conn->disconnect();
    ?>
    ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mvk/fqdn-host.md) %}

{% include [Подключение к кластеру](./connect/php/after-connect.md) %}

## Python {#python}

**Перед подключением установите зависимости**:

```bash
sudo apt update && sudo apt install -y python3 python3-pip && \
pip3 install redis
```

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    **Пример кода для подключения с помощью Sentinel**:

    `connect.py`

    ```python
    from redis.sentinel import Sentinel

    sentinels = [
        "<FQDN_хоста_1_{{ VLK }}>",
        ...
        "<FQDN_хоста_N_{{ VLK }}>"
    ]
    name = "<имя_кластера_{{ VLK }}>"
    pwd = "<пароль>"

    sentinel = Sentinel([(h, {{ port-mrd-sentinel }}) for h in sentinels], socket_timeout=0.1)
    master = sentinel.master_for(name, password=pwd)
    slave = sentinel.slave_for(name, password=pwd)

    master.set("foo", "bar")
    print(slave.get("foo"))
    ```

    **Пример кода для подключения без использования SSL-соединения напрямую к мастеру**:

    `connect.py`

    ```python
    import redis

    r = redis.StrictRedis(
        host="c-<идентификатор_кластера>.rw.{{ dns-zone }}",
        port={{ port-mrd }},
        password="<пароль>",
    )

    r.set("foo", "bar")
    print(r.get("foo"))
    ```

- Подключение с SSL {#with-ssl}

    `connect.py`

    ```python
    import redis

    r = redis.StrictRedis(
        host="c-<идентификатор_кластера>.rw.{{ dns-zone }}",
        port={{ port-mrd-tls }},
        password="<пароль>",
        ssl=True,
        ssl_ca_certs="/home/<домашняя_директория>/.redis/{{ crt-local-file }}",
    )

    r.set("foo", "bar")
    print(r.get("foo"))
    ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mvk/fqdn-host.md) %}

{% include [Подключение к кластеру](./connect/python/after-connect.md) %}

## Ruby {#ruby}

{% include [Установка зависимостей](./connect/ruby/install-requirements.md) %}

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    **Пример кода для подключения с помощью Sentinel**:

    `connect.rb`

    ```ruby
    # coding: utf-8

    require 'redis'

    SENTINELS = [
      { host: '<FQDN_хоста_1_{{ VLK }}>', port: {{ port-mrd-sentinel }} },
      ...
      { host: '<FQDN_хоста_N_{{ VLK }}>', port: {{ port-mrd-sentinel }} }
    ]

    conn = Redis.new(
      host: '<имя_кластера_{{ VLK }}>',
      sentinels: SENTINELS,
      role: 'master',
      password: '<пароль>'
    )

    conn.set('foo', 'bar')
    puts conn.get('foo')

    conn.close
    ```

    **Пример кода для подключения без использования SSL-соединения напрямую к мастеру**:

    `connect.rb`

    ```ruby
    # coding: utf-8

    require 'redis'

    conn = Redis.new(
      host: 'c-<идентификатор_кластера>.rw.{{ dns-zone }}',
      port: {{ port-mrd }},
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

    conn = Redis.new(
      host: 'c-<идентификатор_кластера>.rw.{{ dns-zone }}',
      port: {{ port-mrd-tls }},
      password: '<пароль>',
      ssl: true,
      ssl_params: { ca_file: '/home/<домашняя_директория>/.redis/{{ crt-local-file }}' },
    )

    conn.set('foo', 'bar')
    puts conn.get('foo')

    conn.close
    ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mvk/fqdn-host.md) %}

{% include [Подключение к кластеру](./connect/ruby/after-connect.md) %}
