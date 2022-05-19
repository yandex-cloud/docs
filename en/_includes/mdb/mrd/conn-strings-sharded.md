### Bash {#bash}

{% include [Install requirements](./connect/bash/install-requirements.md) %}

{% list tabs %}

- Connecting without using SSL

    Specify the FQDN of the master host in the desired shard:

    ```bash
    redis-cli \
        -c \
        -h <FQDN of master host in desired shard> \
        -a <password>
    ```

- Connecting via SSL

    Specify the FQDN of the master host in the desired shard:

    ```bash
    redis-cli \
        -c \
        -h <FQDN of master host in desired shard> \
        -a <password> \
        -p {{ port-mrd-tls }} \
        --tls \
        --cacert ~/.redis/YandexInternalRootCA.crt \
    ```

{% endlist %}

When you are connected to the cluster, run the commands:

```bash
SET foo bar
GET foo
```

If the `GET` request returns `nil`, it means that the entry for the `foo` key has been moved to another shard. Connect to it and repeat the request: it will return the value `bar`.

### Go {#go}

{% include [Install requirements](./connect/go/install-requirements.md) %}

{% list tabs %}

- Connecting without using SSL

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
    		"<FQDN of master host in shard 1>:{{ port-mrd }}",
    		...
    		"<FQDN of master host in shard N>:{{ port-mrd }}",
    	}
    	options := redis.UniversalOptions{
    		Addrs:       hostports,
    		DB:          0,
    		ReadOnly:    false,
    		DialTimeout: 5 * time.Second,
    		Password:    "<password>",
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

- Connecting via SSL

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
    	caCert, err := ioutil.ReadFile("/home/<home directory>/.redis/YandexInternalRootCA.crt")
    	if err != nil {
    		panic(err)
    	}
    	caCertPool := x509.NewCertPool()
    	caCertPool.AppendCertsFromPEM(caCert)

    	hostports := []string{
    		"<FQDN of master host in shard 1>:{{ port-mrd-tls }}",
    		...
    		"<FQDN of master host in shard N>:{{ port-mrd-tls }}",
    	}
    	options := redis.UniversalOptions{
    		Addrs:        hostports,
    		MaxRedirects: 1,
    		Password:     "<password>",
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

{% include [Connect to cluster](./connect/go/after-connect.md) %}

### Java {#java}

{% include [Install requirements](./connect/java/install-requirements.md) %}

{% list tabs %}

- Connecting without using SSL

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
        jedisClusterNodes.add(new HostAndPort("<FQDN of master host in shard 1>", {{ port-mrd }}));
        ...
        jedisClusterNodes.add(new HostAndPort("<FQDN of master host in shard N>", {{ port-mrd }}));

        DefaultJedisClientConfig jedisClientConfig = DefaultJedisClientConfig.builder().
                password("<password>").
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

- Connecting via SSL

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
        System.setProperty("javax.net.ssl.trustStore", "/home/<home directory>/.redis/YATrustStore");
        System.setProperty("javax.net.ssl.trustStorePassword", "<secure certificate store password>");

        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
        Set<HostAndPort> jedisClusterNodes = new HashSet<HostAndPort>();
        SSLParameters sslParameters = new SSLParameters();
        jedisClusterNodes.add(new HostAndPort("<FQDN of master host in shard 1>", {{ port-mrd-tls }}));
        ...
        jedisClusterNodes.add(new HostAndPort("<FQDN of master host in shard N>", {{ port-mrd-tls }}));

        DefaultJedisClientConfig jedisClientConfig = DefaultJedisClientConfig.builder().
                password("<cluster password>").
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

{% include [Connect to cluster](./connect/java/after-connect.md) %}

### Node.js {#nodejs}

{% include [Install requirements](./connect/nodejs/install-requirements.md) %}

{% list tabs %}

- Connecting without using SSL

    `app.js`

    ```javascript
    "use strict";

    const Redis = require("ioredis");

    const cluster = new Redis.Cluster(
        [
            {
                host: "<FQDN of master host in shard 1>",
                port: {{ port-mrd }}
            },
            ...
            {
                host: "<FQDN of master host in shard N>",
                port: {{ port-mrd }}
            }
        ],
        {
            redisOptions: {
                password: "<password>"
            }
        }
    );

    cluster.on("ready", () => {
        cluster.set("foo", "bar");
        cluster.get("foo", (err, result) => {
            if (err){
                console.error(err);
            } else {
                console.log(result);
            }
        });

        cluster.disconnect();
    });
    ```

- Connecting via SSL

    `app.js`

    ```javascript
    "use strict";

    const Redis = require("ioredis");
    const fs = require("fs");

    const cluster = new Redis.Cluster(
        [
            {
                host: "<FQDN of master host in shard 1>",
                port: {{ port-mrd-tls }}
            },
            ...
            {
                host: "<FQDN of master host in shard N>",
                port: {{ port-mrd-tls }}
            },
        ],
        {
            redisOptions: {
                password: "<password>",
                tls: {
                    ca: [fs.readFileSync("/home/<home directory>/.redis/YandexInternalRootCA.crt")],
                    checkServerIdentity: () => {
                        return null;
                    }
                }
            }
        }
    );

    cluster.set("foo", "bar");
    cluster.get("foo", (err, res) => {
        console.log(res);
    });
    ```

{% endlist %}

{% include [Connect to cluster](./connect/nodejs/after-connect.md) %}

### PHP {#php}

{% include [Install requirements](./connect/php/install-requirements.md) %}

{% list tabs %}

- Connecting without using SSL

    `connect.php`

    ```php
    <?php

    require "Predis/Autoloader.php";
    Predis\Autoloader::register();

    $hosts = [
        "tcp://<FQDN master host in shard 1>:{{ port-mrd }}",
        ...
        "tcp://<FQDN of master host in shard N>:{{ port-mrd }}",
    ];

    $options = [
        "cluster" => "redis",
        "parameters" => [
            "password" => "<password>",
        ],
    ];

    $conn = new Predis\Client($hosts, $options);
    $conn->set("foo", "bar");

    var_dump($conn->get("foo"));

    $conn->disconnect();
    ?>
    ```

- Connecting via SSL

   `connect.php`

   ```php
    <?php

    require "Predis/Autoloader.php";
    Predis\Autoloader::register();

    $hosts = [
        'tls://<FQDN of master host in shard 1>:{{ port-mrd-tls }}?ssl[cafile]=/home/<home directory>/.redis/YandexInternalRootCA.crt',
        ...
        'tls://<FQDN of master host in shard N>:{{ port-mrd-tls }}?ssl[cafile]=/home/<home directory>/.redis/YandexInternalRootCA.crt',
    ];

    $options = [
        'cluster' => 'predis',
        'parameters' => [
            'password' => '<password>',
        ],
    ];

    $conn = new Predis\Client($hosts, $options);
    $conn->set('foo', 'bar');
   
    var_dump($conn->get("foo"));

    $conn->disconnect();
    ?>
   ```

{% endlist %}

{% include [Connect to cluster](./connect/php/after-connect.md) %}

### Python {#python}

**Before connecting, install the dependencies:**

```bash
sudo apt update && sudo apt install -y python3 python3-pip python3-venv && \
    python3 -m venv env && \
    source env/bin/activate && \
    pip install pip -U && \
    pip install pyopenssl redis-py-cluster setuptools_rust
```

{% list tabs %}

- Connecting without using SSL

    `connect.py`

    ```python
    from rediscluster import RedisCluster

    startup_nodes = [
        {"host": "<FQDN of master host in shard 1>", "port": {{ port-mrd }}},
        ...
        {"host": "<FQDN of master host in shard N>", "port": {{ port-mrd }}},
    ]

    rc = RedisCluster(
        startup_nodes=startup_nodes,
        decode_responses=True,
        skip_full_coverage_check=True,
        password="<password>",
    )

    rc.set("foo", "bar")

    print(rc.get("foo"))
    ```

- Connecting via SSL

    `connect.py`

    ```python
    import OpenSSL
    from rediscluster import RedisCluster

    startup_nodes = [
        {"host": "<FQDN of master host in shard 1>", "port": {{ port-mrd-tls }}},
        ...
        {"host": "<FQDN of master host in shard N>", "port": {{ port-mrd-tls }}},
    ]

    rc = RedisCluster(
        startup_nodes=startup_nodes,
        decode_responses=True,
        skip_full_coverage_check=True,
        password="<password>",
        ssl=True,
        ssl_ca_certs="/home/<home directory>/.redis/YandexInternalRootCA.crt",
    )

    rc.set("foo", "bar")

    print(rc.get("foo"))
    ```

{% endlist %}

{% include [Connect to cluster](./connect/python/after-connect.md) %}

### Ruby {#ruby}

{% include [Install requirements](./connect/ruby/install-requirements.md) %}

{% list tabs %}

- Connecting without using SSL

    `connect.rb`

    ```ruby
    # coding: utf-8

    require 'redis'

    nodes = [
      { host: '<FQDN of master host in shard 1>', port: {{ port-mrd }} },
      ...
      { host: '<FQDN of master host in shard N>', port: {{ port-mrd }} }
    ]

    conn = Redis.new(
       cluster: nodes,
       password: '<password>'
    )

    conn.set('foo', 'bar')
    puts conn.get('foo')

    conn.close
    ```

- Connecting via SSL

    `connect.rb`

    ```ruby
    # coding: utf-8

    require 'redis'

    nodes = [
      { host: '<FQDN of master host in shard 1>', port: {{ port-mrd-tls }} },
      ...
      { host: '<FQDN of master host in shard N>', port: {{ port-mrd-tls }} }
    ]

    conn = Redis.new(
      cluster: nodes,
      password: '<password>',
      ssl: true,
      ssl_params: {
        ca_file: '/home/<home directory>/.redis/YandexInternalRootCA.crt',
        verify_hostname: false
      }
    )

    conn.set('foo', 'bar')
    puts conn.get('foo')

    conn.close
    ```

{% endlist %}

{% include [Connect to cluster](./connect/ruby/after-connect.md) %}

