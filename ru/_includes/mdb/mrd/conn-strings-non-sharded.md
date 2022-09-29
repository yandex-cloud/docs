### Bash {#bash}

{% list tabs %}

* Подключение без SSL

    {% include [Install requirements](./connect/bash/install-requirements.md) %}

    **Подключение с помощью Sentinel:**

    1. Получите адрес хоста-мастера, используя Sentinel и любой хост {{ RD }}:

        ```bash
        redis-cli \
            -h <FQDN любого хоста {{ RD }}> \
            -p {{ port-mrd-sentinel }} \
            sentinel \
            get-master-addr-by-name <имя кластера {{ RD }}> | head -n 1
        ```

    1. Подключитесь к хосту с этим адресом:

        ```bash
        redis-cli \
            -h <адрес хоста-мастера {{ RD }}> \
            -a <пароль {{ RD }}>
        ```

    **Подключение напрямую к мастеру:**

    ```bash
    redis-cli \
        -h c-<идентификатор кластера>.rw.{{ dns-zone }} \
        -a <пароль>
    ```

* Подключение с SSL

    {% include [Install requirements SSL](./connect/bash/install-requirements-ssl.md) %}

    **Подключение напрямую к мастеру:**

    {% include [default-connstring](default-connstring.md) %}

{% endlist %}

{% include [Подключение к кластеру](./connect/bash/after-connect.md) %}

### Go {#go}

{% include [Install requirements](./connect/go/install-requirements.md) %}

{% list tabs %}

* Подключение без SSL

    **Пример кода для подключения с помощью Sentinel:**

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
    				"<FQDN хоста 1 {{ RD }}>:{{ port-mrd-sentinel }}",
    				...
    				"<FQDN хоста N {{ RD }}>:{{ port-mrd-sentinel }}"},
    			MasterName: "<имя кластера {{ RD }}>",
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

    **Пример кода для подключения напрямую к мастеру:**

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
    			Addrs:    []string{"c-<идентификатор кластера>.rw.{{ dns-zone }}:{{ port-mrd }}"},
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

* Подключение с SSL

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
    	cert = "/home/<домашняя директория>/.redis/{{ crt-local-file }}"
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
    			Addrs:    []string{"c-<идентификатор кластера>.rw.{{ dns-zone }}:{{ port-mrd-tls }}"},
    			Password: "<пароль>",
    			ReadOnly: false,
    			SSLConfig: &tls.Config{
    				RootCAs:            rootCertPool,
    				InsecureSkipVerify: true,
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

{% include [Подключение к кластеру](./connect/go/after-connect.md) %}

### Java {#java}

{% include [Установка зависимостей](./connect/java/install-requirements.md) %}

{% list tabs %}

* Подключение без SSL

    **Пример кода для подключения с помощью Sentinel:**

    `src/java/com/example/App.java`

    ```java
    package com.example;

    import java.util.HashSet;
    import redis.clients.jedis.Jedis;
    import redis.clients.jedis.JedisSentinelPool;

    public class App {
      public static void main(String[] args) {
        String redisName = "<имя кластера {{ RD }}>";
        String redisPass = "<пароль>";

        HashSet sentinels = new HashSet();
        sentinels.add("<FQDN хоста 1 {{ RD }}>:{{ port-mrd-sentinel }}");
        ...
        sentinels.add("<FQDN хоста N {{ RD }}>:{{ port-mrd-sentinel }}");

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

    **Пример кода для подключения напрямую к мастеру:**

    `src/java/com/example/App.java`

    ```java
    package com.example;

    import redis.clients.jedis.Jedis;

    public class App {
      public static void main(String[] args) {
        String redisHost = "c-<идентификатор кластера>.rw.{{ dns-zone }}";
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

* Подключение с SSL

    `src/java/com/example/App.java`

    ```java
    package com.example;

    import redis.clients.jedis.DefaultJedisClientConfig;
    import redis.clients.jedis.HostAndPort;
    import redis.clients.jedis.Jedis;

    import javax.net.ssl.SSLParameters;

    public class App {
      public static void main(String[] args) {
        String redisHost = "c-<идентификатор кластера>.rw.{{ dns-zone }}";
        String redisPass = "<пароль кластера>";

        System.setProperty("javax.net.ssl.trustStore", "/home/<домашняя директория>/.redis/YATrustStore");
        System.setProperty("javax.net.ssl.trustStorePassword", "<пароль защищенного хранилища сертификатов>");

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

{% include [Подключение к кластеру](./connect/java/after-connect.md) %}

### Node.js {#nodejs}

{% include [Установка зависимостей](./connect/nodejs/install-requirements.md) %}

{% list tabs %}

* Подключение без SSL

    **Пример кода для подключения с помощью Sentinel:**

    `app.js`

    ```javascript
    "use strict";
    const Redis = require("ioredis");

    const conn = new Redis({
        sentinels: [
            { host: "<FQDN хоста 1 {{ RD }}>", port: {{ port-mrd-sentinel }} },
            ...
            { host: "<FQDN хоста N {{ RD }}>", port: {{ port-mrd-sentinel }} },
        ],
        name: "<имя кластера {{ RD }}>",
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

    **Пример кода для подключения напрямую к мастеру:**

    `app.js`

    ```js
    "use strict";

    const Redis = require("ioredis");

    const conn = new Redis({
        host: "c-<идентификатор кластера>.rw.{{ dns-zone }}",
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

* Подключение с SSL

    `app.js`

    ```javascript
    "use strict";

    const fs = require("fs");
    const Redis = require("ioredis");

    const conn = new Redis({
        host: "c-<идентификатор кластера>.rw.{{ dns-zone }}",
        port: {{ port-mrd-tls }},
        password: "<пароль>",
        tls: {
            ca: fs.readFileSync("/home/<домашняя директория>/.redis/{{ crt-local-file }}"),
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

{% include [Подключение к кластеру](./connect/nodejs/after-connect.md) %}

### PHP {#php}

{% include [Установка зависимостей](./connect/php/install-requirements.md) %}

{% list tabs %}

* Подключение без SSL

    **Пример кода для подключения с помощью Sentinel:**

    `connect.php`

    ```php
    <?php
    require "Predis/Autoloader.php";
    Predis\Autoloader::register();

    $sentinels = [
        "<FQDN хоста 1 {{ RD }}>:{{ port-mrd-sentinel }}>",
        ...
        "<FQDN хоста N {{ RD }}>:{{ port-mrd-sentinel }}>",
    ];
    $options = [
        "replication" => "sentinel",
        "service" => "<имя кластера {{ RD }}>",
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

    **Пример кода для подключения напрямую к мастеру:**

    `connect.php`

    ```php
    <?php
    require "Predis/Autoloader.php";
    Predis\Autoloader::register();

    $host = ["c-<идентификатор кластера>.rw.{{ dns-zone }}:{{ port-mrd }}"];
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

* Подключение с SSL

    `connect.php`

    ```php
    <?php
    require "Predis/Autoloader.php";
    Predis\Autoloader::register();

    $host = ["c-<идентификатор кластера>.rw.{{ dns-zone }}:{{ port-mrd-tls }}"];
    $options = [
        "parameters" => [
            "scheme" => "tls",
            "ssl" => [
                "cafile" => "/home/<домашняя директория>/.redis/{{ crt-local-file }}",
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

{% include [Подключение к кластеру](./connect/php/after-connect.md) %}

### Python {#python}

**Перед подключением установите зависимости:**

```bash
sudo apt update && sudo apt install -y python3 python3-pip && \
pip3 install redis
```

{% list tabs %}

- Подключение без SSL

    **Пример кода для подключения с помощью Sentinel:**

    `connect.py`

    ```python
    from redis.sentinel import Sentinel

    sentinels = [
        "<FQDN хоста 1 {{ RD }}>",
        ...
        "<FQDN хоста N {{ RD }}>"
    ]
    name = "<имя кластера {{ RD }}>"
    pwd = "<пароль>"

    sentinel = Sentinel([(h, {{ port-mrd-sentinel }}) for h in sentinels], socket_timeout=0.1)
    master = sentinel.master_for(name, password=pwd)
    slave = sentinel.slave_for(name, password=pwd)

    master.set("foo", "bar")
    print(slave.get("foo"))
    ```

    **Пример кода для подключения без использования SSL-соединения напрямую к мастеру:**

    `connect.py`

    ```python
    import redis

    r = redis.StrictRedis(
        host="c-<идентификатор кластера>.rw.{{ dns-zone }}",
        port={{ port-mrd }},
        password="<пароль>",
    )

    r.set("foo", "bar")
    print(r.get("foo"))
    ```

- Подключение с SSL

    `connect.py`

    ```python
    import redis

    r = redis.StrictRedis(
        host="c-<идентификатор кластера>.rw.{{ dns-zone }}",
        port={{ port-mrd-tls }},
        password="<пароль>",
        ssl=True,
        ssl_ca_certs="/home/<домашняя директория>/.redis/{{ crt-local-file }}",
    )

    r.set("foo", "bar")
    print(r.get("foo"))
    ```

{% endlist %}

{% include [Подключение к кластеру](./connect/python/after-connect.md) %}

### Ruby {#ruby}

{% include [Установка зависимостей](./connect/ruby/install-requirements.md) %}

{% list tabs %}

* Подключение без SSL

    **Пример кода для подключения с помощью Sentinel:**

    `connect.rb`

    ```ruby
    # coding: utf-8

    require 'redis'

    SENTINELS = [
      { host: '<FQDN хоста 1 {{ RD }}>', port: {{ port-mrd-sentinel }} },
      ...
      { host: '<FQDN хоста N {{ RD }}>', port: {{ port-mrd-sentinel }} }
    ]

    conn = Redis.new(
      host: '<имя кластера {{ RD }}>',
      sentinels: SENTINELS,
      role: 'master',
      password: '<пароль>'
    )

    conn.set('foo', 'bar')
    puts conn.get('foo')

    conn.close
    ```

    **Пример кода для подключения без использования SSL-соединения напрямую к мастеру:**

    `connect.rb`

    ```ruby
    # coding: utf-8

    require 'redis'

    conn = Redis.new(
      host: 'c-<идентификатор кластера>.rw.{{ dns-zone }}',
      port: {{ port-mrd }},
      password: '<пароль>'
    )

    conn.set('foo', 'bar')
    puts conn.get('foo')

    conn.close
    ```

* Подключение с SSL

    `connect.rb`

    ```ruby
    # coding: utf-8

    require 'redis'

    conn = Redis.new(
      host: 'c-<идентификатор кластера>.rw.{{ dns-zone }}',
      port: {{ port-mrd-tls }},
      password: '<пароль>',
      ssl: true,
      ssl_params: { ca_file: '/home/<домашняя директория>/.redis/{{ crt-local-file }}' },
    )

    conn.set('foo', 'bar')
    puts conn.get('foo')

    conn.close
    ```

{% endlist %}

{% include [Подключение к кластеру](./connect/ruby/after-connect.md) %}
