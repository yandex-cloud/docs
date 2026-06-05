---
title: Connecting to a {{ TR }} cluster
description: Follow this guide to connect to a {{ TR }} cluster.
keywords:
  - connecting to a {{ TR }} cluster
---

# Connecting to a {{ TR }} cluster

This section presents settings for connection to the {{ mtr-name }} cluster using [command line tools](#cli-tools), from [graphical IDEs](#connection-ide) and [WebSQL](#websql). To learn how to connect from your application code, see [Connection string examples](#connection-strings).

You can connect to a {{ mtr-name }} cluster with disabled [private access](../concepts/network.md#private-endpoint) only from the network the cluster resides in.

{% note info %}

If the connection requires a port, use port `{{ port-https }}`.

{% endnote %}

## Configuring security groups {#configuring-security-groups}

{% include [trino-security-groups](../../_includes/managed-trino/security-groups.md) %}

To connect to a {{ TR }} cluster from a {{ yandex-cloud }} VM, configure a security group for the VM you will use for connection. VM rule examples:

* For incoming traffic:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-ssh }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

    This rule allows inbound connections to the VM over SSH.

* For outbound traffic:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

    This rule allows all outgoing traffic, which enables you to both connect to the cluster and install any required utilities on your VM.

### Security groups for {{ mgp-full-name }} {#security-groups-for-greenplum}

The connector uses the GPFDIST protocol for connection to the {{ mgp-name }} cluster:

* {{ TR }} coordinators and workers send queries to the {{ mgp-name }} master over TCP port {{ port-mgp }}.
* {{ mgp-name }} segments forward data to {{ TR }} workers over the GPFDIST TCP port in the 30078–30085 range.

Data transmitted between the {{ mgp-name }} and {{ TR }} clusters over the GPFDIST protocol is unencrypted. To secure your connection, configure security groups [in {{ mgp-name }}](#configuring-security-groups-greenplum) and, optionally, [in {{ mtr-name }}](#configuring-security-groups-trino).

#### {{ mgp-name }} side setup {#configuring-security-groups-greenplum}

{% list tabs group=traffic %}

- Incoming traffic {#incoming}

    * Rule for internal {{ mgp-name }} cluster traffic:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.

    * Rule for connections from a {{ TR }} cluster:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mgp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: Specify the {{ TR }} cluster security group.

- Outgoing traffic {#outgoing}

    * Rule for internal {{ mgp-name }} cluster traffic:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.

    * Rule for connections to a {{ TR }} cluster:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `30078-30085`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: Specify the {{ TR }} cluster security group.

{% endlist %}

#### {{ mtr-name }} side setup {#configuring-security-groups-trino}

To configure security group rules in {{ TR }}, invert the {{ mgp-name }} rule settings. Setting up rules for a {{ TR }} cluster is optional, but this provides added security for your cluster.

{% list tabs group=traffic %}

- Incoming traffic {#incoming}

    Rule for receiving data from {{ mgp-name }} segments:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `30078-30085`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: Specify the {{ mgp-name }} cluster security group.

- Outgoing traffic {#outgoing}

    Rule for connections to a {{ mgp-name }} master:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-mgp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: Specify the {{ mgp-name }} cluster security group.

{% endlist %}

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
     1. Specify the connection settings on the **General** tab:
        * **Host**: `c-<cluster_ID>.trino.yandexcloud.net`.

            {% include [private-endpoint](../../_includes/managed-trino/private-endpoint.md) %}

        * **Port**: `{{ port-https }}`.
        * **User**: `iam`.
        * **Password**: Previously created IAM token.
  1. Click **Test Connection**. If the connection is successful, you will see the connection status and information about the DBMS and driver.
  1. Click **OK** to save the data source.

- DBeaver {#dbeaver}

  1. Create a new DB connection:
     1. In the **Database** menu, select **New connection**.
     1. Select **{{ TR }}** from the list.
     1. Click **Next**.
     1. Specify the connection settings on the **Main** tab:
        * **Host**: `c-<cluster_ID>.trino.yandexcloud.net`.

            {% include [private-endpoint](../../_includes/managed-trino/private-endpoint.md) %}

        * **Port**: `{{ port-https }}`.
        * Under **Authentication**, specify:
            * Username: `iam`.
            * Password: Previously created IAM token.
  1. Click **Test Connection ...**. If the connection is successful, you will see the connection status, DBMS information, and driver details.
  1. Click **Done** to save the database connection settings.

{% endlist %}

## WebSQL {#websql}

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
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

- Connection {#connecting}

  1. Code example:

      `connect.py`

      ```python
      import os
      from contextlib import closing
      from trino.dbapi import connect
      from trino.auth import BasicAuthentication

      TIMEOUT = 10
      COORDINATOR_URL = 'c-<cluster_ID>.trino.yandexcloud.net'
      IAM_TOKEN = os.environ['TOKEN']

      def get_version():
          auth = BasicAuthentication(username='iam', password=IAM_TOKEN)
          with closing(connect(host=COORDINATOR_URL, port={{ port-https }}, auth=auth, request_timeout=TIMEOUT)) as conn:
              with closing(conn.cursor()) as cur:
                  cur.execute('SELECT version() as version')
                  rows = cur.fetchall()
                  print(rows[0])

      if __name__ == "__main__":
          get_version()
      ```

     You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

     {% include [private-endpoint](../../_includes/managed-trino/private-endpoint.md) %}

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

1. Create a directory for the Maven project:

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

- Connection {#connecting}

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

      You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

      {% include [private-endpoint](../../_includes/managed-trino/private-endpoint.md) %}

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

- Connection {#connecting}

    `app.mjs`

    ```javascript
    "use strict";
    import {BasicAuth, Trino} from 'trino-client';

    const COORDINATOR_URL = 'c-<cluster_ID>.trino.yandexcloud.net'
    let TOKEN = process.env.TOKEN

    async function get_version() {
        const trino = Trino.create({server: COORDINATOR_URL,auth: new BasicAuth('iam', TOKEN)});
        const query = await trino.query('SELECT version() as VERSION');
        const queryResult = await query.next()
        console.log(queryResult.value.data[0][0])
    }

    get_version();
    ```

    You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    {% include [private-endpoint](../../_includes/managed-trino/private-endpoint.md) %}

{% endlist %}

Connecting:

```bash
node app.mjs
```
