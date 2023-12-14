---
title: "How to upload data to a {{ ydb-full-name }} table"
description: "Follow this guide to upload data to a table."
sourcePath: overlay/quickstart/document-api/aws-sdk/load-data.md
---
# Uploading data to a table

In this example, the data for uploading contains information about series in a JSON file. For each series, the `series_id` identifier, `title`, and additional `info` are set:

The structure of a JSON file with series information:

```json
[{
    "series_id": ...,
    "title": ...,
    "info": {
      ...
    }
  },
  ...
]
```

The `series_id` and `title` values are used as the primary key of the `Series` table.

To upload data to the `Series` table:

{% list tabs %}

- Java

   1. Create the `SeriesLoadData` project:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
        -DartifactId=SeriesLoadData
      ```

      As a result of running the command, the `SeriesLoadTable` project folder is created in the current working folder, with a structure of subfolders and the `pom.xml` project description file.

   1. Go to the project folder:

      ```bash
      cd SeriesLoadData
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
        <artifactId>SeriesLoadData</artifactId>
        <packaging>jar</packaging>
        <version>1.0-SNAPSHOT</version>
        <name>SeriesLoadData</name>
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
                                <mainClass>com.mycompany.app.SeriesLoadData</mainClass>
                            </manifest>
                            <manifestEntries>
                                <Class-Path>.</Class-Path>
                            </manifestEntries>
                        </archive>
                        <finalName>release/SeriesLoadData</finalName>
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
            <version>3.8.1</version>
            <scope>test</scope>
          </dependency>
          <dependency>
            <groupId>com.amazonaws</groupId>
            <artifactId>aws-java-sdk</artifactId>
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

   1. In the folder `src/main/java/com/mycompany/app/`, create the `SeriesLoadData.java` file, for example, using the nano editor:

      ```bash
      nano src/main/java/com/mycompany/app/SeriesLoadData.java
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```java
      package com.mycompany.app;

      import java.io.File;
      import java.util.Iterator;

      import com.amazonaws.client.builder.AwsClientBuilder;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
      import com.amazonaws.services.dynamodbv2.document.DynamoDB;
      import com.amazonaws.services.dynamodbv2.document.Item;
      import com.amazonaws.services.dynamodbv2.document.Table;
      import com.fasterxml.jackson.core.JsonFactory;
      import com.fasterxml.jackson.core.JsonParser;
      import com.fasterxml.jackson.databind.JsonNode;
      import com.fasterxml.jackson.databind.ObjectMapper;
      import com.fasterxml.jackson.databind.node.ObjectNode;

      public class SeriesLoadData {

          public static void main(String[] args) throws Exception {

              AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document_API_endpoint>", "{{ region-id }}"))
                  .build();

              DynamoDB dynamoDB = new DynamoDB(client);

              Table table = dynamoDB.getTable("Series");

              JsonParser parser = new JsonFactory().createParser(new File("seriesdata.json"));

              JsonNode rootNode = new ObjectMapper().readTree(parser);
              Iterator<JsonNode> iter = rootNode.iterator();

              ObjectNode currentNode;

              while (iter.hasNext()) {
                  currentNode = (ObjectNode) iter.next();

                  int series_id = currentNode.path("series_id").asInt();
                  String title = currentNode.path("title").asText();

                  try {
                      table.putItem(new Item().withPrimaryKey("series_id", series_id, "title", title).withJSON("info",
                          currentNode.path("info").toString()));
                      System.out.println("Series added: " + series_id + " " + title);

                  }
                  catch (Exception e) {
                      System.err.println("Couldn't upload data: " + series_id + " " + title);
                      System.err.println(e.getMessage());
                      break;
                  }
              }
              parser.close();
          }
      }
      ```

      The code uses Jackson, the open source JSON processing library. Jackson is included in the AWS SDK for Java.

   1. Build a project:

      ```bash
      mvn package
      ```

      As a result of running the command, the `SeriesLoadData.jar` file is generated in the folder `target/release/`.

   1. {% include [seriesdata](../../../_includes/seriesdata.md) %}

   1. Run the application:

      ```bash
      java -jar target/release/SeriesLoadData.jar
      ```

      Result:

      ```text
      Added series: 1 IT Crowd
      Added series: 2 Silicon Valley
      Added series: 3 House of Cards
      Added series: 3 The Office
      Added series: 3 True Detective
      Added series: 4 The Big Bang Theory
      Added series: 5 Twin Peaks
      ```

- Python

   1. Create the `SeriesLoadData.py` file, for example, using the nano editor:

      ```bash
      nano SeriesLoadData.py
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```python
      from decimal import Decimal
      import json
      import boto3

      def load_series(series):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document_API_endpoint>")

          table = ydb_docapi_client.Table('Series')
          for serie in series:
              series_id = int(serie['series_id'])
              title = serie['title']
              print("Series added:", series_id, title)
              table.put_item(Item = serie)

      if __name__ == '__main__':
          with open("seriesdata.json") as json_file:
              serie_list = json.load(json_file, parse_float = Decimal)
          load_series(serie_list)
      ```

   1. {% include [seriesdata](../../../_includes/seriesdata.md) %}

   1. Run the program:

      ```bash
      python SeriesLoadData.py
      ```

      Result:

      ```text
      Added series: 1 IT Crowd
      Added series: 2 Silicon Valley
      Added series: 3 House of Cards
      Added series: 3 The Office
      Added series: 3 True Detective
      Added series: 4 The Big Bang Theory
      Added series: 5 Twin Peaks
      ```

- PHP

   1. Create the `SeriesLoadData.php` file, for example, using the nano editor:

      ```bash
      nano SeriesLoadData.php
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```php
      <?php

      require 'vendor/autoload.php';

      date_default_timezone_set('UTC');

      use Aws\DynamoDb\Exception\DynamoDbException;
      use Aws\DynamoDb\Marshaler;

      $sdk = new Aws\Sdk([
          'endpoint' => '<Document_API_endpoint>',
          'region'   => '{{ region-id }}',
          'version'  => 'latest'
      ]);

      $dynamodb = $sdk->createDynamoDb();
      $marshaler = new Marshaler();

      $tableName = 'Series';

      $Series = json_decode(file_get_contents('seriesdata.json'), true);

      foreach ($Series as $movie) {

          $series_id = $movie['series_id'];
          $title = $movie['title'];
          $info = $movie['info'];

          $json = json_encode([
              'series_id' => $series_id,
              'title' => $title,
              'info' => $info
          ]);

          $params = [
              'TableName' => $tableName,
              'Item' => $marshaler->marshalJson($json)
          ];

          try {
              $result = $dynamodb->putItem($params);
              echo "Series added: " . $movie['series_id'] . " " . $movie['title'] . "\n";
          } catch (DynamoDbException $e) {
              echo "Couldn't upload data:\n";
              echo $e->getMessage() . "\n";
              break;
          }

      }

      ?>
      ```

      The `Marshaler` class includes methods for converting JSON documents and PHP arrays into the YDB format. In this code, `$marshaler->marshalJson($json)` accepts JSON data and converts it into a YDB record.

   1. {% include [seriesdata](../../../_includes/seriesdata.md) %}

   1. Run the program:

      ```bash
      php SeriesLoadData.php
      ```

      Result:

      ```text
      Added series: 1 IT Crowd
      Added series: 2 Silicon Valley
      Added series: 3 House of Cards
      Added series: 3 The Office
      Added series: 3 True Detective
      Added series: 4 The Big Bang Theory
      Added series: 5 Twin Peaks
      ```

- Node.js

   1. Create the `SeriesLoadData.js` file, for example, using the nano editor:

      ```bash
      nano SeriesLoadData.js
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```javascript
      const AWS = require("@aws-sdk/client-dynamodb");
      const fs = require("fs")

      // Credentials should be defined via environment variables AWS_SECRET_ACCESS_KEY and AWS_ACCESS_KEY_ID
      const dynamodb = new AWS.DynamoDBClient({
          region: "{{ region-id }}",
          endpoint: "<Document_API_endpoint>",
      });

      console.log("Uploading series to YDB. Please wait...");

      const allSeries = JSON.parse(fs.readFileSync('seriesdata.json', 'utf8'));

      allSeries.forEach(function(series) {
          dynamodb.send(new AWS.PutItemCommand({
              TableName: "Series",
              Item: {
                  "series_id": series.series_id,
                  "title": series.title,
                  "info": series.info
              }
          }))
              .then(() => {
                  console.log("Series added:", series.title);
              })
              .catch(err => {
                  console.error("Couldn't add series", series.title, ". JSON error:", JSON.stringify(err, null, 2));
              })
      });
      ```

   1. {% include [seriesdata](../../../_includes/seriesdata.md) %}

   1. Run the program:

      ```bash
      node SeriesLoadData.js
      ```

      Result:

      ```bash
      Uploading series to YDB. Please wait...
      Added series: The Office
      Added series: IT Crowd
      Added series: House of Cards
      Added series: The Big Bang Theory
      Added series: Twin Peaks
      Added series: Silicon Valley
      Added series: True Detective
      ```

- Ruby

   1. Create the `SeriesLoadData.rb` file, for example, using the nano editor:

      ```bash
      nano SeriesLoadData.rb
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'
      require 'json'

      $series_counter = 0
      $total_series = 0

      def add_item_to_table(dynamodb_client, table_item)
        dynamodb_client.put_item(table_item)
        $series_counter += 1
        puts "Uploading series #{$series_counter}/#{$total_series}: " \
          "'#{table_item[:item]['title']} " \
          "(#{table_item[:item]['series_id']})'."
      rescue StandardError => e
        puts "Error uploading series '#{table_item[:item]['title']} " \
          "(#{table_item[:item]['series_id']})': #{e.message}"
        puts 'Program stopped.'
        exit 1
      end

      def run_me
        region = '{{ region-id }}'
        table_name = 'Series'
        data_file = 'seriesdata.json'

        Aws.config.update(
          endpoint: '<Document_API_endpoint>',
          region: region
        )

        dynamodb_client = Aws::DynamoDB::Client.new
        file = File.read(data_file)
        series = JSON.parse(file)
        $total_series = series.count

        puts "You are going to upload #{$total_series} series from the '#{data_file}' file " \
          "to the table '#{table_name}'..."

        series.each do |seria|
          table_item = {
            table_name: table_name,
            item: seria
          }
          add_item_to_table(dynamodb_client, table_item)
        end

        puts 'Uploading completed successfully.'
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

   1. {% include [seriesdata](../../../_includes/seriesdata.md) %}

   1. Run the program:

      ```bash
      ruby SeriesLoadData.rb
      ```

      Result:

      ```text
      7 series will be uploaded from file 'seriesdata.json' to the table 'Series'...
      Uploading series 1/7: 'IT Crowd (1)'.
      Uploading series 2/7: 'Silicon Valley (2)'.
      Uploading series 3/7: 'House of Cards (3)'.
      Uploading series 4/7: 'The Office (3)'.
      Uploading series 5/7: 'True Detective (3)'.
      Uploading series 6/7: 'The Big Bang Theory (4)'.
      Uploading series 7/7: 'Twin Peaks (5)'.
      Uploading completed successfully.
      ```

{% endlist %}
