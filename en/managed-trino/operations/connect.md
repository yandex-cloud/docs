---
title: Connecting to a {{ TR }} cluster
description: Follow this guide to connect to a {{ TR }} cluster.
keywords:
  - connecting to a {{ TR }} cluster
---

# Connecting to a {{ TR }} cluster

You can connect to a {{ mtr-name }} cluster:

* Over the internet using an [SSL connection](#get-ssl-cert)

* From {{ yandex-cloud }} VMs located in the same [cloud network](../../vpc/concepts/network.md)

## Getting an SSL certificate {#get-ssl-cert}

To use an encrypted connection, get an SSL certificate:

{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

   ```bash
   mkdir -p ~/.trino && \
   wget "{{ crt-web-path }}" \
        --output-document ~/.trino/root.crt && \
   chmod 0655 ~/.trino/root.crt
   ```

   The certificate will be saved to the `~/.trino/root.crt` file.

- Windows (PowerShell) {#windows}

   ```powershell
   mkdir $HOME\.trino; curl.exe -o $HOME\.trino\root.crt {{ crt-web-path }}
   ```

   The certificate will be saved to the `$HOME\.trino\root.crt` file.

{% endlist %}

{% include [ide-ssl-cert](../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Command line tools {#cli-tools}

### {{ TR }} CLI {#trino-cli}

{% include [trino-cli-connect](../../_includes/managed-trino/trino-cli-connect.md) %}

## Connecting from graphical IDEs {#connection-ide}

Before connecting:

1. Create an [IAM token](../../iam/concepts/authorization/iam-token.md):

   ```bash
   yc iam create-token
   ```

1. Save the token. You will use it as a password for the connection.

{% list tabs group=ide %}

- DataGrip {#datagrip}

  1. Create a data source:
     1. Select **File** → **New** → **Data Source** → **{{ TR }}**.
     1. Enter a name for the data source.
     1. Specify the connection parameters on the **General** tab:
        * **Host**: `c-<cluster_ID>.trino.yandexcloud.net`.
        * **Port**: `443`.
        * **User**: `iam`.
        * **Password**: Previously created IAM token.
     1. On the **SSH/SSL** tab:
         1. Enable the **Use SSL** setting.
         1. In the **CA file** field, specify the path to the file with an [SSL certificate](#get-ssl-cert) for the connection.
  1. Click **Test Connection** to test the connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
  1. Click **OK** to save the data source.

- DBeaver {#dbeaver}

  1. Create a new DB connection:
     1. In the **Database** menu, select **New connection**.
     1. Select **{{ TR }}** from the list.
     1. Click **Next**.
     1. Specify the connection parameters on the **Main** tab:
        * **Host**: `c-<cluster_ID>.trino.yandexcloud.net`.
        * **Port**: `443`.
        * Under **Authentication**, specify:
            * Username: `iam`.
            * Password: Previously created IAM token.
  1. Click **Test Connection ...** to test the connection. If the connection is successful, you will see the connection status and information about the DBMS and driver.
  1. Click **Ready** to save the database connection settings.

{% endlist %}

## WebSQL {#websql}

1. In the [management console]({{ link-console-main }}), open **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
1. Open your {{ mtr-name }} cluster.
1. Navigate to **{{ ui-key.yacloud.mdb.cluster.switch_explore-websql }}**.
1. Click **{{ ui-key.yacloud.mdb.cluster.websql-connections.action_go-to-websql }}**.
1. In the SQL query editor that opens, run the following query:

   ```sql
   SELECT version() AS version;
   ```

   The response will contain {{ TR }} version information.

## Examples of connection strings {#connection-strings}

### Python {#python}

Before connecting:

1. Install the dependencies:

   ```bash
   pip3 install trino
   ```

1. Create an [IAM token](../../iam/concepts/authorization/iam-token.md) and put it to the `TOKEN` environment variable:

   ```bash
   export TOKEN=$(yc iam create-token)
   ```

{% list tabs group=instruction %}

- Connecting via SSL {#with-ssl}

  1. Code example:

      `connect.py`

      ```python
      import os
      from contextlib import closing
      from trino.dbapi import connect
      from trino.auth import BasicAuthentication

      TIMEOUT = 10
      COORDINATOR_URL = '<coordinator_URL>'
      IAM_TOKEN = os.environ['TOKEN']

      def get_version():
          auth = BasicAuthentication(username='iam', password=IAM_TOKEN)
          with closing(connect(host=COORDINATOR_URL, port=443, auth=auth, request_timeout=TIMEOUT)) as conn:
              with closing(conn.cursor()) as cur:
                  cur.execute('SELECT version() as version')
                  rows = cur.fetchall()
                  print(rows[0][0])

      if __name__ == "__main__":
          get_version()
      ```

      You can copy the coordinator URL and paste it to the **{{ ui-key.yacloud.trino.overview.title_resource-coordinator }}** field on the {{ TR }} overview page in the [management console]({{ link-console-main }}).

  1. Connecting:

      ```bash
      python3 connect.py
      ```

{% endlist %}

### Java {#java}

Before connecting:

1. Install the dependencies:

    ```bash
    sudo apt update && sudo apt install --yes openjdk-21-jre maven
    ```

1. Create a folder for the Maven project:

    ```bash
    cd ~/ && mkdir -p project/src/main/java/com/example && cd project/
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
        <version>0.1.0</version>
        <packaging>jar</packaging>
        <properties>
            <maven.compiler.source>21</maven.compiler.source>
            <maven.compiler.target>21</maven.compiler.target>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        </properties>
        <dependencies>
            <dependency>
                <groupId>io.trino</groupId>
                <artifactId>trino-jdbc</artifactId>
                <version>469</version>
            </dependency>
        </dependencies>
        <build>
            <finalName>${project.artifactId}-${project.version}</finalName>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-assembly-plugin</artifactId>
                    <version>3.7.1</version>
                    <executions>
                        <execution>
                            <goals>
                                <goal>single</goal>
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
                    <version>3.4.2</version>
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

1. Create an [IAM token](../../iam/concepts/authorization/iam-token.md) and put it to the `TOKEN` environment variable:

   ```bash
   export TOKEN=$(yc iam create-token)
   ```

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

  1. Code example:

      `src/main/java/com/example/App.java`

      ```java
      package com.example;

      import java.sql.DriverManager;
      import java.util.Properties;

      public class App {
          private static final String COORDINATOR_URL = "c-<cluster_ID>.trino.yandexcloud.net";

          public static void main(String[] args) {
              String url = String.format("jdbc:trino://%s", COORDINATOR_URL);
              String iamToken = System.getenv("TOKEN");
        
              Properties properties = new Properties();
              properties.setProperty("user", "iam");
              properties.setProperty("password", iamToken);
              properties.setProperty("SSL", "true");

              try (var connection = DriverManager.getConnection(url, properties)) {
                  var rs = connection.createStatement().executeQuery("SELECT version() as VERSION");
                  if (rs.next()) {
                      System.out.println(rs.getString(1));
                  }
              } catch (Exception e) {
                  e.printStackTrace();
              }
          }
      }

      ```

      You can get the {{ mtr-name }} cluster ID in the [management console]({{ link-console-main }}) with the list of {{ mtr-name }} clusters in the folder.

  1. Building and connecting:

      ```bash
      mvn clean package && \
      java -jar target/app-0.1.0-jar-with-dependencies.jar
      ```

{% endlist %}

### Node.js {#nodejs}

Before connecting:
1. Install the dependencies:

    ```bash
    sudo apt update && sudo apt install --yes nodejs npm && \
    npm install trino-client
    ```

1. Create an [IAM token](../../iam/concepts/authorization/iam-token.md) and put it to the `TOKEN` environment variable:

   ```bash
   export TOKEN=$(yc iam create-token)
   ```

{% list tabs group=connection %}

- Connecting via SSL {#with-ssl}

    `app.mjs`

    ```javascript
    "use strict";
    import {BasicAuth, Trino} from 'trino-client';

    const COORDINATOR_URL = '<coordinator_URL>'
    let TOKEN = process.env.TOKEN

    async function get_version() {
        const trino = Trino.create({server: COORDINATOR_URL,auth: new BasicAuth('iam', TOKEN)});
        const query = await trino.query('SELECT version() as VERSION');
        const queryResult = await query.next()
        console.log(queryResult.value.data[0][0])
    }

    get_version();
    ```

    You can copy the coordinator URL and paste it to the **{{ ui-key.yacloud.trino.overview.title_resource-coordinator }}** field on the {{ TR }} overview page in the [management console]({{ link-console-main }}).

{% endlist %}

Connecting:

```bash
node app.mjs
```
