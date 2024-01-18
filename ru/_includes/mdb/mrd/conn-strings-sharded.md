### Bash {#bash}

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    {% include [Install requirements](./connect/bash/install-requirements.md) %}

    **Подключение напрямую к мастеру:**

    Укажите FQDN хоста-мастера в нужном шарде:

    ```bash
    redis-cli \
        -c \
        -h <FQDN_хоста-мастера_в_нужном_шарде> \
        -a <пароль>
    ```

- Подключение с SSL {#with-ssl}

    {% include [Install requirements SSL](./connect/bash/install-requirements-ssl.md) %}

    **Подключение напрямую к мастеру:**

    Укажите FQDN хоста-мастера в нужном шарде:

    ```bash
    redis-cli \
        -c \
        -h <FQDN_хоста-мастера_в_нужном_шарде> \
        -a <пароль> \
        -p {{ port-mrd-tls }} \
        --tls \
        --cacert ~/.redis/{{ crt-local-file }} \
    ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mrd/fqdn-host.md) %}

После подключения к кластеру выполните команды:

```bash
SET foo bar
GET foo
```

Если запрос `GET` возвращает значение `nil`, значит, запись для ключа `foo` была перемещена на другой шард. Подключитесь к нему и повторите запрос — он вернет значение `bar`.

### Go {#go}

{% include [Install requirements](./connect/go/install-requirements.md) %}

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
    		"<FQDN_хоста-мастера_в_шарде_1>:{{ port-mrd }}",
    		...
    		"<FQDN_хоста-мастера_в_шарде_N>:{{ port-mrd }}",
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
    	"github.com/go-redis/redis/v7"
    	"io/ioutil"
    	"net"
    	"strings"
    	"time"
    )

    func main() {
    	caCert, err := ioutil.ReadFile("/home/<домашняя_директория>/.redis/{{ crt-local-file }}")
    	if err != nil {
    		panic(err)
    	}
    	caCertPool := x509.NewCertPool()
    	caCertPool.AppendCertsFromPEM(caCert)

    	hostports := []string{
    		"<FQDN_хоста-мастера_в_шарде_1>:{{ port-mrd-tls }}",
    		...
    		"<FQDN_хоста-мастера_в_шарде_N>:{{ port-mrd-tls }}",
    	}
    	options := redis.UniversalOptions{
    		Addrs:        hostports,
    		MaxRedirects: 1,
    		Password:     "<пароль>",
    		DB:           0,
    		ReadOnly:     false,
    		DialTimeout:  5 * time.Second,
    		TLSConfig: &tls.Config{
    			RootCAs:            caCertPool,
    			InsecureSkipVerify: true,
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
    	client := redis.NewUniversalClient(&options)
    	err = client.Set("foo", "bar", 0).Err()
    	if err != nil {
    		panic(err)
    	}

    	get := client.Get("foo")
    	if get.Err() != nil {
    		panic(err)
    	}
    	fmt.Println(get.String())
    }
    ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mrd/fqdn-host.md) %}

{% include [Connect to cluster](./connect/go/after-connect.md) %}

### Java {#java}

{% include [Install requirements](./connect/java/install-requirements.md) %}

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
        jedisClusterNodes.add(new HostAndPort("<FQDN_хоста-мастера_в_шарде_1>", {{ port-mrd }}));
        ...
        jedisClusterNodes.add(new HostAndPort("<FQDN_хоста-мастера_в_шарде_N>", {{ port-mrd }}));

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
        jedisClusterNodes.add(new HostAndPort("<FQDN_хоста-мастера_в_шарде_1>", {{ port-mrd-tls }}));
        ...
        jedisClusterNodes.add(new HostAndPort("<FQDN_хоста-мастера_в_шарде_N>", {{ port-mrd-tls }}));

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

{% include [see-fqdn](../../../_includes/mdb/mrd/fqdn-host.md) %}

{% include [Connect to cluster](./connect/java/after-connect.md) %}

### Node.js {#nodejs}

{% include [Install requirements](./connect/nodejs/install-requirements.md) %}

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
                port: {{ port-mrd }}
            },
            ...
            {
                host: "<FQDN_хоста-мастера_в_шарде_N>",
                port: {{ port-mrd }}
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
                port: {{ port-mrd-tls }}
            },
            ...
            {
                host: "<FQDN_хоста-мастера_в_шарде_N>",
                port: {{ port-mrd-tls }}
            },
        ],
        {
            redisOptions: {
                password: "<пароль>",
                tls: {
                    ca: [fs.readFileSync("/home/<домашняя_директория>/.redis/{{ crt-local-file }}")],
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

{% include [see-fqdn](../../../_includes/mdb/mrd/fqdn-host.md) %}

{% include [Connect to cluster](./connect/nodejs/after-connect.md) %}

### PHP {#php}

{% include [Install requirements](./connect/php/install-requirements.md) %}

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    `connect.php`

    ```php
    <?php

    require "Predis/Autoloader.php";
    Predis\Autoloader::register();

    $hosts = [
        "tcp://<FQDN_хоста-мастера_в_шарде_1>:{{ port-mrd }}",
        ...
        "tcp://<FQDN_хоста-мастера_в_шарде_N>:{{ port-mrd }}",
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
       'tls://<FQDN_хоста-мастера_в_шарде_1>:{{ port-mrd-tls }}?ssl[cafile]=/home/<домашняя_директория>/.redis/{{ crt-local-file }}',
       ...
       'tls://<FQDN_хоста-мастера_в_шарде_N>:{{ port-mrd-tls }}?ssl[cafile]=/home/<домашняя_директория>/.redis/{{ crt-local-file }}',
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

{% include [see-fqdn](../../../_includes/mdb/mrd/fqdn-host.md) %}

{% include [Connect to cluster](./connect/php/after-connect.md) %}

### Python {#python}

**Перед подключением установите зависимости:**

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
        {"host": "<FQDN_хоста-мастера_в_шарде_1>", "port": {{ port-mrd }}},
        ...
        {"host": "<FQDN_хоста-мастера_в_шарде_N>", "port": {{ port-mrd }}},
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
        {"host": "<FQDN_хоста-мастера_в_шарде_1>", "port": {{ port-mrd-tls }}},
        ...
        {"host": "<FQDN_хоста-мастера_в_шарде_N>", "port": {{ port-mrd-tls }}},
    ]

    rc = RedisCluster(
        startup_nodes=startup_nodes,
        decode_responses=True,
        skip_full_coverage_check=True,
        password="<пароль>",
        ssl=True,
        ssl_ca_certs="/home/<домашняя_директория>/.redis/{{ crt-local-file }}",
    )

    rc.set("foo", "bar")

    print(rc.get("foo"))
    ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mrd/fqdn-host.md) %}

{% include [Connect to cluster](./connect/python/after-connect.md) %}

### Ruby {#ruby}

{% include [Install requirements](./connect/ruby/install-requirements.md) %}

{% list tabs group=connection %}

- Подключение без SSL {#without-ssl}

    `connect.rb`

    ```ruby
    # coding: utf-8

    require 'redis'

    nodes = [
      { host: '<FQDN_хоста-мастера_в_шарде_1>', port: {{ port-mrd }} },
      ...
      { host: '<FQDN_хоста-мастера_в_шарде_N>', port: {{ port-mrd }} }
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
      { host: '<FQDN_хоста-мастера_в_шарде_1>', port: {{ port-mrd-tls }} },
      ...
      { host: '<FQDN_хоста-мастера_в_шарде_N>', port: {{ port-mrd-tls }} }
    ]

    conn = Redis.new(
      cluster: nodes,
      password: '<пароль>',
      ssl: true,
      ssl_params: {
        ca_file: '/home/<домашняя_директория>/.redis/{{ crt-local-file }}',
        verify_hostname: false
      }
    )

    conn.set('foo', 'bar')
    puts conn.get('foo')

    conn.close
    ```

{% endlist %}

{% include [see-fqdn](../../../_includes/mdb/mrd/fqdn-host.md) %}

{% include [Connect to cluster](./connect/ruby/after-connect.md) %}
