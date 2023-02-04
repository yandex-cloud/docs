---
sourcePath: overlay/quickstart/document-api/aws-sdk/create-item.md
---
# Adding a record

To add a new record to the `Series` table:

{% list tabs %}

- Java

   1. Create the `SeriesItemOps01` project:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
        -DartifactId=SeriesItemOps01
      ```

      As a result of running the command, the `SeriesItemOps01` project folder is created in the current working folder with a structure of subfolders and the `pom.xml` project description file.

   1. Go to the project folder:

      ```bash
      cd SeriesItemOps01
      ```

   1. Edit the project description in the `pom.xml` file, for example, using the nano editor:

      ```bash
      nano pom.xml
      ```

      Sample `pom.xml` file:

      ```xml
      <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
        <modelVersion>4.0.0</modelVersion>
        <groupId>com.mycompany.app</groupId>
        <artifactId>SeriesItemOps01</artifactId>
        <packaging>jar</packaging>
        <version>1.0-SNAPSHOT</version>
        <name>SeriesItemOps01</name>
        <url>http://maven.apache.org</url>
        <build>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-jar-plugin</artifactId>
                    <configuration>
                        <archive>
                            <manifest>
                                <addClasspath>true</addClasspath>
                                <classpathPrefix>lib/</classpathPrefix>
                                <mainClass>com.mycompany.app.SeriesItemOps01</mainClass>
                            </manifest>
                            <manifestEntries>
                                <Class-Path>.</Class-Path>
                            </manifestEntries>
                        </archive>
                        <finalName>release/SeriesItemOps01</finalName>
                    </configuration>
                </plugin>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-dependency-plugin</artifactId>
                    <executions>
                        <execution>
                            <id>copy-dependencies</id>
                            <phase>prepare-package</phase>
                            <goals>
                                <goal>copy-dependencies</goal>
                            </goals>
                            <configuration>
                                <outputDirectory>${project.build.directory}/release/lib</outputDirectory>
                                <overWriteReleases>false</overWriteReleases>
                                <overWriteSnapshots>false</overWriteSnapshots>
                                <overWriteIfNewer>true</overWriteIfNewer>
                            </configuration>
                        </execution>
                    </executions>
                </plugin>
            </plugins>
        </build>
        <dependencies>
          <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.13.1</version>
            <scope>test</scope>
          </dependency>
          <dependency>
            <groupId>com.amazonaws</groupId>
            <artifactId>aws-java-sdk-dynamodb</artifactId>
            <version>1.11.1012</version>
          </dependency>
        </dependencies>
        <properties>
          <maven.compiler.source>1.8</maven.compiler.source>
          <maven.compiler.target>1.8</maven.compiler.target>
        </properties>
      </project>
      ```

      Check the current versions of [junit](https://mvnrepository.com/artifact/junit/junit) and [aws-java-sdk-dynamodb](https://mvnrepository.com/artifact/com.amazonaws/aws-java-sdk-dynamodb).

   1. In the folder `src/main/java/com/mycompany/app/`, create the `SeriesItemOps01.java` file, for example, using the nano editor:

      ```bash
      nano src/main/java/com/mycompany/app/SeriesItemOps01.java
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```java
      package com.mycompany.app;

      import java.util.HashMap;
      import java.util.Map;

      import com.amazonaws.client.builder.AwsClientBuilder;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
      import com.amazonaws.services.dynamodbv2.document.DynamoDB;
      import com.amazonaws.services.dynamodbv2.document.Item;
      import com.amazonaws.services.dynamodbv2.document.PutItemOutcome;
      import com.amazonaws.services.dynamodbv2.document.Table;

      public class SeriesItemOps01 {

          public static void main(String[] args) throws Exception {

              AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API endpoint>", "{{ region-id }}"))
                  .build();

              DynamoDB dynamoDB = new DynamoDB(client);

              Table table = dynamoDB.getTable("Series");

              int series_id = 3;
              String title = "Supernatural";

              final Map<String, Object> infoMap = new HashMap<String, Object>();
              infoMap.put("release_date", "2015-09-13");
              infoMap.put("series_info", "Supernatural is an American television series created by Eric Kripke");

              try {
                  System.out.println("Adding new record...");
                  PutItemOutcome outcome = table
                    .putItem(new Item().withPrimaryKey("series_id", series_id, "title", title).withMap("info", infoMap));

                  System.out.println("Series added:\n" + outcome.getPutItemResult());

              }
              catch (Exception e) {
                  System.err.println("Couldn't add the record: " + series_id + " " + title);
                  System.err.println(e.getMessage());
              }

          }
      }
      ```

      This code adds a record with a primary key (`series_id` and `title`) and additional information in the `info` field. The primary key is required.

   1. Build a project:

      ```bash
      mvn package
      ```

      As a result of running the command, the `SeriesItemOps01.jar` file is generated in the folder `target/release/`.

   1. Run the application:

      ```bash
      java -jar target/release/SeriesItemOps01.jar
      ```

      Result:

      ```text
      Adding new record...
      Series added:
      {}
      ```

- Python

   1. Create the `SeriesItemOps01.py` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps01.py
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```python
      from pprint import pprint
      import boto3

      def put_serie(series_id, title, release_date, series_info):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API endpoint>")

          table = ydb_docapi_client.Table('Series')
          response = table.put_item(
            Item = {
                  'series_id': series_id,
                  'title': title,
                  'info': {
                      'release_date': release_date,
                      'series_info': series_info
                  }
              }
          )
          return response

      if __name__ == '__main__':
          serie_resp = put_serie(3, "Supernatural", "2015-09-13",
                                "Supernatural is an American television series created by Eric Kripke")
          print("Series added:")
          pprint(serie_resp, sort_dicts = False)
      ```

      This code adds a record with a primary key (`series_id` and `title`) and additional information in the `info` field. The primary key is required.

   1. Run the program:

      ```bash
      python SeriesItemOps01.py
      ```

      Result:

      ```text
      Series added:
      {'ResponseMetadata': {'HTTPStatusCode': 200,
                            'HTTPHeaders': {'content-type': 'application/x-amz-json-1.0',
                                            'x-amz-crc32': '2745614147',
                                            'x-request-id': '92a5fafe-169c-48e8-8071-4f8c8cca7004',
                                            'date': 'Sat, 26 Dec 2020 17:21:01 GMT',
                                            'content-length': '2'},
                            'RetryAttempts': 0}}
      ```

- PHP

   1. Create the `SeriesItemOps01.php` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps01.php
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```php
      <?php

      require 'vendor/autoload.php';

      date_default_timezone_set('UTC');

      use Aws\DynamoDb\Exception\DynamoDbException;
      use Aws\DynamoDb\Marshaler;

      $sdk = new Aws\Sdk([
          'endpoint' => '<Document API endpoint>',
          'region'   => '{{ region-id }}',
          'version'  => 'latest'
      ]);

      $dynamodb = $sdk->createDynamoDb();
      $marshaler = new Marshaler();

      $tableName = 'Series';

      $series_id = 3;
      $title = 'Supernatural';

      $item = $marshaler->marshalJson('
          {
              "series_id": ' . $series_id . ',
              "title": "' . $title . '",
              "info": {
                  "release_date": "2015-09-13",
                  "series_info": "Supernatural is an American television series created by Eric Kripke"
              }
          }
      ');

      $params = [
          'TableName' => 'Series',
          'Item' => $item
      ];


      try {
          $result = $dynamodb->putItem($params);
          echo "Series added: $series_id - $title\n";

      } catch (DynamoDbException $e) {
          echo "Couldn't add the record:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

      This code adds a record with a primary key (`series_id` and `title`) and the `info` attribute. The `info` attribute contains a JSON record with additional information about the movie. The primary key is required.

   1. Run the program:

      ```bash
      php SeriesItemOps01.php
      ```

      Result:

      ```text
      Series added: 3 - Supernatural
      ```

- Node.js

   1. Create the `SeriesItemOps01.js` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps01.js
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```javascript
      const AWS = require("@aws-sdk/client-dynamodb");
      const { marshall } = require("@aws-sdk/util-dynamodb");

      // Credentials should be defined via environment variables AWS_SECRET_ACCESS_KEY and AWS_ACCESS_KEY_ID
      const dynamodb = new AWS.DynamoDBClient({
          region: "{{ region-id }}",
          endpoint: "<Document API endpoint>",
      });

      const table = "Series";
      const series_id = 3;
      const title = "Supernatural";

      const params = {
          TableName: table,
          Item: marshall({
              "series_id": series_id,
              "title": title,
              "info":{
                  "release_date": "2015-09-13",
                  "series_info": "Supernatural is an American television series created by Eric Kripke"
              }
          })
      };

      console.log("Adding new record...");
      docClient.put(params, function(err, data) {
          if (err) {
              console.error("Couldn't add the record. JSON error:", JSON.stringify(err, null, 2));
              process.exit(1);
          } else {
              console.log("Series added:", JSON.stringify(data, null, 2));
          })
          .catch(err => {
              console.error("Couldn't add item. JSON error:", JSON.stringify(err, null, 2));
          })
      ```

      The primary key is required. This code adds a record that has a primary key (`series_id` and `title`) and attributes inside `info`. The `info` block stores JSON that provides additional information about the series.

   1. Run the program:

      ```bash
      node SeriesItemOps01.js
      ```

      Result:

      ```bash
      Adding new record...
      Series added: {}
      ```

- Ruby

   1. Create the `SeriesItemOps01.rb` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps01.rb
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'

      def add_item_to_table(dynamodb_client, table_item)
        dynamodb_client.put_item(table_item)
        puts "Uploaded '#{table_item[:item][:title]} " \
          "(#{table_item[:item][:series_id]})'."
      rescue StandardError => e
        puts "Error uploading series '#{table_item[:item][:title]} " \
          "(#{table_item[:item][:series_id]})': #{e.message}"
      end

      def run_me
        region = '{{ region-id }}'
        table_name = 'Series'
        title = 'Supernatural'
        series_id = 3

        Aws.config.update(
          endpoint: '<Document API endpoint>',
          region: region
        )

        dynamodb_client = Aws::DynamoDB::Client.new

        item = {
          series_id: series_id,
          title: title,
          info: {
            release_date: '2015-09-13',
            series_info: "Supernatural is an American television series created by Eric Kripke"
          }
        }

        table_item = {
          table_name: table_name,
          item: item
        }

        puts "Uploading the series '#{item[:title]} (#{item[:series_id]})' " \
          "to the table '#{table_name}'..."
        add_item_to_table(dynamodb_client, table_item)
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

   1. Run the program:

      ```bash
      ruby SeriesItemOps01.rb
      ```

      Result:

      ```text
      Uploading series 'Supernatural (3)' to the table 'Series'...
      'Supernatural (3)' uploaded.
      ```

{% endlist %}
