### Bash {#bash}

{% include [Установка зависимостей](./connect/bash/install-requirements.md) %}

{% list tabs %}

* Подключение без SSL

    Укажите FQDN хоста-мастера в нужном шарде:

    ```bash
    redis-cli -c \
              -h <FQDN хоста-мастера в нужном шарде> \
              -a <пароль>
    ```

{% endlist %}

{% include [Подключение к кластеру](./connect/bash/after-connect.md) %}

### Go {go}

{% include [Установка зависимостей](./connect/go/install-requirements.md) %}

{% list tabs %}

* Подключение без SSL

    `connect.go`

    ```go
    package main

    import (
    	"fmt"
    	"github.com/go-redis/redis"
    )

    func main() {
    	client := redis.NewClusterClient(
    		&redis.ClusterOptions{
    			Addrs: []string{
    				"<FQDN хоста-мастера шарда 1>:{{ port-mrd }}",
    				...
    				"<FQDN хоста-мастера шарда N>:{{ port-mrd }}",
    			},
    			Password: "<пароль {{ RD }}>",
    		},
    	)

    	err := client.Set(client.Context(), "foo", "bar", 0).Err()
    	if err != nil {
    		panic(err)
    	}

    	result, err := client.Get(client.Context(), "foo").Result()
    	if err != nil {
    		panic(err)
    	}
    	fmt.Println(result)

    	client.Close()
    }
    ```

{% endlist %}

{% include [Подключение к кластеру](./connect/go/after-connect.md) %}

### Java {#java}

{% include [Установка зависимостей](./connect/java/install-requirements.md) %}

{% list tabs %}

* Подключение без SSL

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
        jedisClusterNodes.add(new HostAndPort("<FQDN хоста мастера в шарде 1>", {{port-mrd}}));
        ...
        jedisClusterNodes.add(new HostAndPort("<FQDN хоста мастера в шарде N>", {{port-mrd}}));

        try {
          JedisCluster jc = new JedisCluster(jedisClusterNodes, 1000, 1000, 5,
                                             "<пароль>", jedisPoolConfig);

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

{% include [Подключение к кластеру](./connect/java/after-connect.md) %}

### Node.js {#nodejs}

{% include [Установка зависимостей](./connect/nodejs/install-requirements.md) %}

{% list tabs %}

* Подключение без SSL

    `connect.js`

    ```javascript
    "use strict";

    const Redis = require("ioredis");

    const conn = new Redis.Cluster(
        [
            {
                host: "<FQDN хоста-мастера шарда 1>",
                port: {{ port-mrd }}
            },
            ...
            {
                host: "<FQDN хоста-мастера шарда N>",
                port: {{ port-mrd }}
            }
        ],
        {
            redisOptions: {
                password: "<пароль>"
            }
        }
    );

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

    `connect.php`

    ```php
    <?php
    require "Predis/Autoloader.php";
    Predis\Autoloader::register();

    $hosts = [
        "tcp://<FQDN хоста-мастера в шарде 1>:{{ port-mrd }}",
        ...
        "tcp://<FQDN хоста-мастера в шарде N>:{{ port-mrd }}",
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

{% endlist %}

{% include [Подключение к кластеру](./connect/php/after-connect.md) %}

### Python {#python}

{% include [Установка зависимостей](./connect/python/install-requirements.md) %}

{% list tabs %}

* Подключение без SSL

    `connect.py`

    ```python
    from rediscluster import RedisCluster

    startup_nodes = [
        {"host": "<FQDN хоста-мастера в шарде 1>", "port": "{{ port-mrd }}"},
        ...
        {"host": "<FQDN хоста-мастера в шарде N>", "port": "{{ port-mrd }}"},
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

{% endlist %}

{% include [Подключение к кластеру](./connect/php/after-connect.md) %}

### Ruby {#ruby}

{% include [Установка зависимостей](./connect/ruby/install-requirements.md) %}

{% list tabs %}

* Подключение без SSL

    `connect.rb`

    ```ruby
    require "redis"

    nodes = [
      {:host => "<FQDN хоста-мастера в шарде 1>", :port => {{ port-mrd }}},
      ...
      {:host => "<FQDN хоста-мастера в шарде N>", :port => {{ port-mrd }}},
    ]

    conn = Redis.new(
       cluster: nodes,
       password: "<пароль>"
    )

    conn.set("foo", "bar")
    puts conn.get("foo")

    conn.close()
    ```

{% endlist %}

{% include [Подключение к кластеру](./connect/ruby/after-connect.md) %}
