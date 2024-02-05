### Bash {#bash}

Before connecting, install the [MongoDB Shell utility]({{ shell-link }}).

{% list tabs group=connection %}

- Connecting via SSL for {{ MG }} 4.2 and higher {#with-ssl}

   ```bash
   mongosh --norc \
           --tls \
           --tlsCAFile /home/<home_directory>/.mongodb/root.crt \
           --host '<FQDN_of_MONGOINFRA_or_MONGOS_host_1>:27017,...,<FQDN_of_MONGOINFRA_or_MONGOS_host_N>:27017' \
           --username <DB_username> \
           --password <DB_user_password> \
           <DB_name>
   ```

- Connecting via SSL for {{ MG }} 4.0 {#with-ssl-4}

   ```bash
   mongosh --norc \
           --ssl \
           --sslCAFile /home/<home_directory>/.mongodb/root.crt \
           --host '<FQDN_of_MONGOINFRA_or_MONGOS_host_1>:27017,...,<FQDN_of_MONGOINFRA_or_MONGOS_host_N>:27017' \
           --username <DB_username> \
           --password <DB_user_password> \
           <DB_name>
   ```

- Connecting without SSL {#without-ssl}

   ```bash
   mongosh --norc \
           --host '<FQDN_of_MONGOINFRA_or_MONGOS_host_1>:27017,...,<FQDN_of_MONGOINFRA_or_MONGOS_host_N>:27017' \
           --username <DB_username> \
           --password <DB_user_password> \
           <DB_name>
   ```

{% endlist %}

{% include [see-fqdn-host](fqdn-host.md) %}

After connecting, run the `db` command.

### Go {#go}

**Before connecting, install the dependencies:**

```bash
sudo apt update && sudo apt install --yes golang git && \
go get go.mongodb.org/mongo-driver/mongo
```

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

   `connect.go`

   ```go
   package main

   import (
         "fmt"
         "strings"
         "context"
         "go.mongodb.org/mongo-driver/mongo"
         "go.mongodb.org/mongo-driver/mongo/options"
   )

   func main() {

         const DB_NAME = "<DB_name>"
         DB_HOSTS := []string {"<FQDN_of_MONGOINFRA_or_MONGOS_host_1>:27017",
                               ...,
                               "<FQDN_of_MONGOINFRA_or_MONGOS_host_N>:27017"}
         const DB_USER = "<DB_username>"
         const DB_PASS = "<DB_user_password>"

         const CACERT = "/home/<home_directory>/.mongodb/root.crt"

         url := fmt.Sprintf("mongodb://%s:%s@%s/%s?tls=true&tlsCaFile=%s",
                 DB_USER,
                 DB_PASS,
                 strings.Join(DB_HOSTS, ","),
                 DB_NAME,
                 CACERT)

         conn, err := mongo.Connect(context.Background(), options.Client().ApplyURI(url))
         if err != nil {
                 panic(err)
         }

         defer conn.Disconnect(context.Background())

         fmt.Println(conn.Database(DB_NAME).Name())
   }
   ```

- Connecting without SSL {#without-ssl}

   `connect.go`

   ```go
   package main

   import (
         "fmt"
         "strings"
         "context"
         "go.mongodb.org/mongo-driver/mongo"
         "go.mongodb.org/mongo-driver/mongo/options"
   )

   func main() {

         const DB_NAME = "<DB_name>"
         DB_HOSTS := []string {"<FQDN_of_MONGOINFRA_or_MONGOS_host_1>:27017",
                               ...,
                               "<FQDN_of_MONGOINFRA_or_MONGOS_host_N>:27017"}
         const DB_USER = "<DB_username>"
         const DB_PASS = "<DB_user_password>"

         url := fmt.Sprintf("mongodb://%s:%s@%s/%s?tls=false",
                 DB_USER,
                 DB_PASS,
                 strings.Join(DB_HOSTS, ","),
                 DB_NAME)

         conn, err := mongo.Connect(context.Background(), options.Client().ApplyURI(url))
         if err != nil {
                 panic(err)
         }

         defer conn.Disconnect(context.Background())

         fmt.Println(conn.Database(DB_NAME).Name())
   }
   ```

{% endlist %}

{% include [see-fqdn-host](fqdn-host.md) %}

**Connecting:**

```bash
go run connect.go
```

### Java {#java}

**Before connecting:**

1. Install the dependencies:

   ```bash
   sudo apt update && sudo apt install --yes default-jdk maven
   ```

1. Add the SSL certificate to the Java trusted certificate store (Java Key Store) so that the {{ MG }} driver can use this certificate for secure connections to the cluster hosts. Make sure to set the password using the `-storepass` parameter for additional storage protection:

   ```bash
   cd ~/.mongodb && \
   sudo keytool -importcert \
                -alias {{ crt-alias }} -file root.crt \
                -keystore ssl -storepass <password> \
                --noprompt
   ```

   Where `storepass` is the certificate store password, at least 6 characters long.

1. Create a folder for the Maven project:

   ```bash
   cd ~/ && \
   mkdir --parents project/src/java/com/example && \
   cd ~/project
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
         <groupId>org.mongodb</groupId>
         <artifactId>mongodb-driver-sync</artifactId>
         <version>4.1.0</version>
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

   * [mongodb-driver-sync](https://mvnrepository.com/artifact/org.mongodb/mongodb-driver-sync)
   * [slf4j-simple](https://mvnrepository.com/artifact/org.slf4j/slf4j-simple)

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

   `src/java/com/example/App.java`

   ```java
   package com.example;

   import java.util.*;
   import com.mongodb.*;
   import com.mongodb.client.*;

   public class App {
     public static void main(String[] args) {

       System.setProperty("javax.net.ssl.trustStore", "/home/<home_directory>/.mongodb/YATrustStore");
       System.setProperty("javax.net.ssl.trustStorePassword", "<certificate_store_password>");

       final Integer DB_PORT = 27017;

       List DB_HOSTS = new ArrayList<ServerAddress>();
       DB_HOSTS.add(new ServerAddress("<FQDN_of_MONGOINFRA_or_MONGOS_host_1>", DB_PORT));
       ...
       DB_HOSTS.add(new ServerAddress("<FQDN_of_MONGOINFRA_or_MONGOS_host_N>", DB_PORT));

       final String DB_NAME = "<DB_name>";
       final String DB_USER = "<DB_username>";
       final String DB_PASS = "<DB_user_password>";

       MongoClient conn = MongoClients.create(
           MongoClientSettings.builder()
                 .applyToClusterSettings(builder -> builder.hosts(DB_HOSTS))
                 .applyToSslSettings(builder -> builder.enabled(true))
                 .credential(MongoCredential.createCredential(DB_USER, DB_NAME, DB_PASS.toCharArray()))
                 .build());

       System.out.println(conn.getDatabase(DB_NAME).getName());

       conn.close();
     }
   }
   ```

- Connecting without SSL {#without-ssl}

   `src/java/com/example/App.java`

   ```java
   package com.example;

   import java.util.*;
   import com.mongodb.*;
   import com.mongodb.client.*;

   public class App {
     public static void main(String[] args) {

       final Integer DB_PORT = 27017;

       List DB_HOSTS = new ArrayList<ServerAddress>();
       DB_HOSTS.add(new ServerAddress("<FQDN_of_MONGOINFRA_or_MONGOS_host_1>", DB_PORT));
       ...
       DB_HOSTS.add(new ServerAddress("<FQDN_of_MONGOINFRA_or_MONGOS_host_N>", DB_PORT));

       final String DB_NAME = "<DB_name>";
       final String DB_USER = "<DB_username>";
       final String DB_PASS = "<DB_user_password>";

       MongoClient conn = MongoClients.create(
           MongoClientSettings.builder()
                 .applyToClusterSettings(builder -> builder.hosts(DB_HOSTS))
                 .credential(MongoCredential.createCredential(DB_USER, DB_NAME, DB_PASS.toCharArray()))
                 .build());

       System.out.println(conn.getDatabase(DB_NAME).getName());

       conn.close();
     }
   }
   ```

{% endlist %}

{% include [see-fqdn-host](fqdn-host.md) %}

**Connecting:**

```bash
mvn clean package && \
    java -jar target/app-0.1.0-jar-with-dependencies.jar
```

### Node.js {#nodejs}

**Before connecting, install the dependencies**:

```bash
sudo apt update && sudo apt install --yes nodejs npm && \
npm install mongodb
```

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

   `app.js`

   ```js
   const util = require('util');
   const MongoClient = require('mongodb').MongoClient;

   const DB_NAME = '<DB_name>'
   const DB_HOSTS = ['<FQDN_of_MONGOINFRA_or_MONGOS_host_1>:27017',
                     ...,
                     '<FQDN_of_MONGOINFRA_or_MONGOS_host_N>:27017']
   const DB_USER  = '<DB_username>'
   const DB_PASS  = '<DB_user_password>'
   const CACERT   = '/home/<home_directory>/.mongodb/root.crt'

   const url = util.format('mongodb://%s:%s@%s/', DB_USER, DB_PASS, DB_HOSTS.join(','))

   const options = {
     useNewUrlParser: true,
     useUnifiedTopology: true,
     tls: true,
     tlsCAFile: CACERT,
     authSource: DB_NAME
   }

   MongoClient.connect(url, options, function(err, conn) {
     if (conn.isConnected()) {
       const db = conn.db(DB_NAME)
       console.log(db.databaseName)
     }

     conn.close()
   })
   ```

- Connecting without SSL {#without-ssl}

   `app.js`

   ```js
   const util = require('util');
   const MongoClient = require('mongodb').MongoClient;

   const DB_NAME = '<DB_name>'
   const DB_HOSTS = ['<FQDN_of_MONGOINFRA_or_MONGOS_host_1>:27018',
                     ...,
                     '<FQDN_of_MONGOINFRA_or_MONGOS_host_N>:27018']
   const DB_USER  = '<DB_username>'
   const DB_PASS  = '<DB_user_password>'

   const url = util.format('mongodb://%s:%s@%s/', DB_USER, DB_PASS, DB_HOSTS.join(','))

   const options = {
     useNewUrlParser: true,
     useUnifiedTopology: true,
     authSource: DB_NAME
   }

   MongoClient.connect(url, options, function(err, conn) {
     if (conn.isConnected()) {
       const db = conn.db(DB_NAME)
       console.log(db.databaseName)
     }

     conn.close()
   })
   ```

{% endlist %}

{% include [see-fqdn-host](fqdn-host.md) %}

**Connecting:**

```bash
node app.js
```

### PHP {#php}

**Before connecting, install the dependencies:**

```bash
sudo apt update && sudo apt install --yes php php-mongodb
```

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

   `connect.php`

   ```php
   <?php
     $DB_NAME  = '<DB_name>';
     $DB_HOSTS = '<FQDN_of_MONGOINFRA_or_MONGOS_host_1>:27017,...,<FQDN_of_MONGOINFRA_or_MONGOS_host_N>:27017';
     $DB_USER  = '<DB_username>';
     $DB_PASS  = '<DB_user_password>';
     $CACERT   = '/home/<home_directory>/.mongodb/root.crt';

     $uri = sprintf(
         'mongodb://%s:%s@%s/%s',
         $DB_USER,
         $DB_PASS,
         $DB_HOSTS,
         $DB_NAME
     );

     $conn = new \MongoDB\Driver\Manager($uri, ["tls" => "true", "tlsCAFile" => $CACERT], []);
     $command = new MongoDB\Driver\Command(array("ping" => 1));

     try {
         $cursor = $conn->executeCommand($DB_NAME, $command);
           $response = $cursor->toArray()[0];
     } catch(MongoDB\Driver\Exception $ex) {
         echo "$ex->getMessage()";
         exit;
     }

     var_dump($response);
   ?>
   ```

- Connecting without SSL {#without-ssl}

   `connect.php`

   ```php
   <?php
     $DB_NAME  = '<DB_name>';
     $DB_HOSTS = '<FQDN_of_MONGOINFRA_or_MONGOS_host_1>:27017,...,<FQDN_of_MONGOINFRA_or_MONGOS_host_N>:27017';
     $DB_USER  = '<DB_username>';
     $DB_PASS  = '<DB_user_password>';

     $uri = sprintf(
         'mongodb://%s:%s@%s/%s',
         $DB_USER,
         $DB_PASS,
         $DB_HOSTS,
         $DB_NAME
     );

     $conn = new \MongoDB\Driver\Manager($uri);
     $command = new MongoDB\Driver\Command(array("ping" => 1));

     try {
         $cursor = $conn->executeCommand($DB_NAME, $command);
         $response = $cursor->toArray()[0];
     } catch(MongoDB\Driver\Exception $ex) {
         echo "$ex->getMessage()";
         exit;
     }

     var_dump($response);
   ?>
   ```

{% endlist %}

{% include [see-fqdn-host](fqdn-host.md) %}

**Connecting:**

```bash
php connect.php
```

### PowerShell {#powershell}

Before connecting, install the [MongoDB Shell utility](https://www.mongodb.com/try/download/shell).

{% list tabs group=connection %}

- Connecting via SSL for {{ MG }} 4.2 and higher {#with-ssl}

   ```powershell
   mongosh.exe --norc `
               --host '<FQDN_of_MONGOINFRA_or_MONGOS_host_1>:{{ port-mmg-sharded }},...,<FQDN_of_MONGOINFRA_or_MONGOS_host_N>:{{ port-mmg-sharded }}' `
               --tls `
               --tlsCAFile $HOME\.mongodb\root.crt `
               --username <DB_username> `
               --password <DB_user_password> `
               <DB_name>
   ```

- Connecting without SSL {#without-ssl}

   ```powershell
   mongosh.exe --norc `
               --host '<FQDN_of_MONGOINFRA_or_MONGOS_host_1>:{{ port-mmg-sharded }},...,<FQDN_of_MONGOINFRA_or_MONGOS_host_N>:{{ port-mmg-sharded }}' `
               --username <DB_username> `
               --password <DB_user_password> `
               <DB_name>
   ```

{% endlist %}

{% include [see-fqdn-host](fqdn-host.md) %}

After connecting, run the `db` command.

### Python {#python}

**Before connecting, install the dependencies:**

```bash
sudo apt update && sudo apt install --yes python3 python3-pip && \
pip3 install pyMongo
```

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

   `connect.py`

   ```python
   import ssl
   import pymongo
   from urllib.parse import quote_plus as quote

   CACERT = '/home/<home_directory>/.mongodb/root.crt'
   DB_NAME = '<DB_name>'
   DB_HOSTS =','.join([
         '<FQDN_of_MONGOINFRA_or_MONGOS_host_1>:27017',
         ...,
         '<FQDN_of_MONGOINFRA_or_MONGOS_host_N>:27017'
       ])
   DB_USER = '<DB_username>'
   DB_PASS = '<DB_user_password>'

   url = 'mongodb://{user}:{pw}@{hosts}/?authSource={auth_src}'.format(
             user=quote(DB_USER),
             pw=quote(DB_PASS),
             hosts=DB_HOSTS,
             auth_src=DB_NAME)

   conn = pymongo.MongoClient(
       url,
       tls=True,
       tlsCAFile=CACERT)

   db = conn[DB_NAME]
   print(db.name)

   conn.close()
   ```

- Connecting without SSL {#without-ssl}

   `connect.py`

   ```python
   import ssl
   import pymongo
   from urllib.parse import quote_plus as quote

   DB_NAME = '<DB_name>'
   DB_HOSTS =','.join([
         '<FQDN_of_MONGOINFRA_or_MONGOS_host_1>:27017',
         ...,
         '<FQDN_of_MONGOINFRA_or_MONGOS_host_N>:27017'
       ])
   DB_USER = '<DB_username>'
   DB_PASS = '<DB_user_password>'

   url = 'mongodb://{user}:{pw}@{hosts}/?authSource={auth_src}'.format(
             user=quote(DB_USER),
             pw=quote(DB_PASS),
             hosts=DB_HOSTS,
             auth_src=DB_NAME)

   conn = pymongo.MongoClient(url)

   db = conn[DB_NAME]
   print(db.name)

   conn.close()
   ```

{% endlist %}

{% include [see-fqdn-host](fqdn-host.md) %}

**Connecting:**

```bash
python3 connect.py
```
