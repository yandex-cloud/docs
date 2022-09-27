### Bash {#bash}

{% list tabs %}

* Connecting without using SSL

   {% include [Install requirements](./connect/bash/install-requirements.md) %}

   **Connecting via Sentinel:**

   1. Get the address of the master host by using Sentinel and any {{ RD }} host:

      ```bash
      redis-cli \
          -h <FQDN of any {{ RD }} host> \
          -p {{ port-mrd-sentinel }} \
          sentinel \
          get-master-addr-by-name <{{ RD }} cluster name> | head -n 1
      ```

   1. Connect to the host with this address:

      ```bash
      redis-cli \
          -h <{{ RD }} master host address> \
          -a <{{ RD }} password>
      ```

   **Connecting directly to the master host:**

   ```bash
   redis-cli \
       -h c-<cluster ID>.rw.{{ dns-zone }} \
       -a <password>
   ```

* Connecting via SSL

   {% include [Install requirements SSL](./connect/bash/install-requirements-ssl.md) %}

   **Connecting directly to the master host:**

   {% include [default-connstring](default-connstring.md) %}

{% endlist %}

{% include [after-connect](./connect/bash/after-connect.md) %}

### Go {#go}

{% include [Install requirements](./connect/go/install-requirements.md) %}

{% list tabs %}

* Connecting without using SSL

   **Code example for connecting via Sentinel:**

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
   				"<FQDN of {{ RD }} host 1>:{{ port-mrd-sentinel }}",
   				...
   				"<FQDN of {{ RD }} host N>:{{ port-mrd-sentinel }}"},
   			MasterName: "<{{ RD }} cluster name>",
   			Password:   "<password>",
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

   **Code example for connecting directly to the master:**

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
   			Addrs:    []string{"c-<cluster ID>.rw.{{ dns-zone }}:{{ port-mrd }}"},
   			Password: "<password>",
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

* Connecting via SSL

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
   	cert = "/home/<home directory>/.redis/{{ crt-local-file }}"
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
   			Addrs:    []string{"c-<cluster ID>.rw.{{ dns-zone }}:{{ port-mrd-tls }}"},
   			Password: "<password>",
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

{% include [after-connect](./connect/go/after-connect.md) %}

### Java {#java}

{% include [install-requirements](./connect/java/install-requirements.md) %}

{% list tabs %}

* Connecting without using SSL

   **Code example for connecting via Sentinel:**

   `src/java/com/example/App.java`

   ```java
   package com.example;

   import java.util.HashSet;
   import redis.clients.jedis.Jedis;
   import redis.clients.jedis.JedisSentinelPool;

   public class App {
     public static void main(String[] args) {
       String redisName = "<{{ RD }} cluster name>";
       String redisPass = "<password>";

       HashSet sentinels = new HashSet();
       sentinels.add("<FQDN of {{ RD }} host 1>:{{ port-mrd-sentinel }}");
       ...
       sentinels.add("<FQDN of {{ RD }} host N>:{{ port-mrd-sentinel }}");

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

   **Code example for connecting directly to the master:**

   `src/java/com/example/App.java`

   ```java
   package com.example;

   import redis.clients.jedis.Jedis;

   public class App {
     public static void main(String[] args) {
       String redisHost = "c-<cluster ID>.rw.{{ dns-zone }}";
       String redisPass = "<password>";

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

* Connecting via SSL

   `src/java/com/example/App.java`

   ```java
   package com.example;

   import redis.clients.jedis.DefaultJedisClientConfig;
   import redis.clients.jedis.HostAndPort;
   import redis.clients.jedis.Jedis;

   import javax.net.ssl.SSLParameters;

   public class App {
     public static void main(String[] args) {
       String redisHost = "c-<cluster ID>.rw.{{ dns-zone }}";
       String redisPass = "<cluster password>";

       System.setProperty("javax.net.ssl.trustStore", "/home/<home directory>/.redis/YATrustStore");
       System.setProperty("javax.net.ssl.trustStorePassword", "<password of secure certificate storage>");

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

{% include [after-connect](./connect/java/after-connect.md) %}

### Node.js {#nodejs}

{% include [install-requirements](./connect/nodejs/install-requirements.md) %}

{% list tabs %}

* Connecting without using SSL

   **Code example for connecting via Sentinel:**

   `app.js`

   ```javascript
   "use strict";
   const Redis = require("ioredis");

   const conn = new Redis({
       sentinels: [
           { host: "<FQDN of {{ RD }} host 1>", port: {{ port-mrd-sentinel }} },
           ...
           { host: "<FQDN of {{ RD }} host N>", port: {{ port-mrd-sentinel }} },
       ],
       name: "<{{ RD }} cluster name>",
       password: "<password>"
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

   **Code example for connecting directly to the master:**

   `app.js`

   ```js
   "use strict";

   const Redis = require("ioredis");

   const conn = new Redis({
       host: "c-<cluster ID>.rw.{{ dns-zone }}",
       port: {{ port-mrd }},
       password: "<password>"
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

* Connecting via SSL

   `app.js`

   ```javascript
   "use strict";

   const fs = require("fs");
   const Redis = require("ioredis");

   const conn = new Redis({
       host: "c-<cluster ID>.rw.{{ dns-zone }}",
       port: {{ port-mrd-tls }},
       password: "<password>",
       tls: {
           ca: fs.readFileSync("/home/<home directory>/.redis/{{ crt-local-file }}"),
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

{% include [after-connect](./connect/nodejs/after-connect.md) %}

### PHP {#php}

{% include [install-requirements](./connect/php/install-requirements.md) %}

{% list tabs %}

* Connecting without using SSL

   **Code example for connecting via Sentinel:**

   `connect.php`

   ```php
   <?php
   require "Predis/Autoloader.php";
   Predis\Autoloader::register();

   $sentinels = [
       "<FQDN of {{ RD }} host 1>:{{ port-mrd-sentinel }}>",
       ...
       "<FQDN of {{ RD }} host N>:{{ port-mrd-sentinel }}>",
   ];
   $options = [
       "replication" => "sentinel",
       "service" => "<{{ RD }} cluster name>",
       "parameters" => [
           "password" => "<password>",
       ],
   ];

   $conn = new Predis\Client($sentinels, $options);

   $conn->set("foo", "bar");
   var_dump($conn->get("foo"));

   $conn->disconnect();
   ?>
   ```

   **Code example for connecting directly to the master:**

   `connect.php`

   ```php
   <?php
   require "Predis/Autoloader.php";
   Predis\Autoloader::register();

   $host = ["c-<cluster ID>.rw.{{ dns-zone }}:{{ port-mrd }}"];
   $options = [
       "parameters" => [
           "password" => "<password>",
       ],
   ];

   $conn = new Predis\Client($host, $options);

   $conn->set("foo", "bar");
   var_dump($conn->get("foo"));

   $conn->disconnect();
   ?>
   ```

* Connecting via SSL

   `connect.php`

   ```php
   <?php
   require "Predis/Autoloader.php";
   Predis\Autoloader::register();

   $host = ["c-<cluster ID>.rw.{{ dns-zone }}:{{ port-mrd-tls }}"];
   $options = [
       "parameters" => [
           "scheme" => "tls",
           "ssl" => [
               "cafile" => "/home/<home directory>/.redis/{{ crt-local-file }}",
               "verify_peer" => true,
               "verify_peer_name" => false,
           ],
           "password" => "<password>",
       ],
   ];

   $conn = new Predis\Client($host, $options);

   $conn->set("foo", "bar");
   var_dump($conn->get("foo"));

   $conn->disconnect();
   ?>
   ```

{% endlist %}

{% include [after-connect](./connect/php/after-connect.md) %}

### Python {#python}

**Before connecting, install the dependencies:**

```bash
sudo apt update && sudo apt install -y python3 python3-pip && \
    pip3 install redis
```

{% list tabs %}

- Connecting without using SSL

   **Code example for connecting via Sentinel:**

   `connect.py`

   ```python
   from redis.sentinel import Sentinel

   sentinels = [
       "<FQDN of {{ RD }} host 1>",
       ...
       "<FQDN of {{ RD }} host N>"
   ]
   name = "<{{ RD }} cluster name>"
   pwd = "<password>"

   sentinel = Sentinel([(h, {{ port-mrd-sentinel }}) for h in sentinels], socket_timeout=0.1)
   master = sentinel.master_for(name, password=pwd)
   slave = sentinel.slave_for(name, password=pwd)

   master.set("foo", "bar")
   print(slave.get("foo"))
   ```

   **Sample code for connecting without an SSL connection directly to the master host:**

   `connect.py`

   ```python
   import redis

   r = redis.StrictRedis(
       host="c-<cluster ID>.rw.{{ dns-zone }}",
       port={{ port-mrd }},
       password="<password>",
   )

   r.set("foo", "bar")
   print(r.get("foo"))
   ```

- Connecting via SSL

   `connect.py`

   ```python
   import redis

   r = redis.StrictRedis(
       host="c-<cluster ID>.rw.{{ dns-zone }}",
       port={{ port-mrd-tls }},
       password="<password>",
       ssl=True,
       ssl_ca_certs="/home/<home directory>/.redis/{{ crt-local-file }}",
   )

   r.set("foo", "bar")
   print(r.get("foo"))
   ```

{% endlist %}

{% include [after-connect](./connect/python/after-connect.md) %}

### Ruby {#ruby}

{% include [install-requirements](./connect/ruby/install-requirements.md) %}

{% list tabs %}

* Connecting without using SSL

   **Code example for connecting via Sentinel:**

   `connect.rb`

   ```ruby
   # coding: utf-8

   require 'redis'

   SENTINELS = [
     { host: '<FQDN of {{ RD }} host 1>', port: {{ port-mrd-sentinel }} },
     ...
     { host: '<FQDN of {{ RD }} host N>', port: {{ port-mrd-sentinel }} }
   ]

   conn = Redis.new(
     host: '<{{ RD }} cluster name>',
     sentinels: SENTINELS,
     role: 'master',
     password: '<password>'
   )

   conn.set('foo', 'bar')
   puts conn.get('foo')

   conn.close
   ```

   **Sample code for connecting without an SSL connection directly to the master host:**

   `connect.rb`

   ```ruby
   # coding: utf-8

   require 'redis'

   conn = Redis.new(
     host: 'c-<cluster ID>.rw.{{ dns-zone }}',
     port: {{ port-mrd }},
     password: '<password>'
   )

   conn.set('foo', 'bar')
   puts conn.get('foo')

   conn.close
   ```

* Connecting via SSL

   `connect.rb`

   ```ruby
   # coding: utf-8

   require 'redis'

   conn = Redis.new(
     host: 'c-<cluster ID>.rw.{{ dns-zone }}',
     port: {{ port-mrd-tls }},
     password: '<password>',
     ssl: true,
     ssl_params: { ca_file: '/home/<home directory>/.redis/{{ crt-local-file }}' },
   )

   conn.set('foo', 'bar')
   puts conn.get('foo')

   conn.close
   ```

{% endlist %}

{% include [after-connect](./connect/ruby/after-connect.md) %}
