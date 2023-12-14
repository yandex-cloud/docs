---
title: "How to delete a table in {{ ydb-full-name }}"
description: "Follow this guide to delete a table."
sourcePath: overlay/quickstart/document-api/aws-sdk/delete-table.md
---
# Deleting a table

To delete the `Series` table:

{% list tabs %}

- Java

   1. Create the `SeriesDeleteTable` project:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
        -DartifactId=SeriesDeleteTable
      ```

      As a result of running the command, the `SeriesDeleteTable` project folder is created in the current working folder with a structure of subfolders and the `pom.xml` project description file.

   1. Go to the project folder:

      ```bash
      cd SeriesDeleteTable
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
        <artifactId>SeriesDeleteTable</artifactId>
        <packaging>jar</packaging>
        <version>1.0-SNAPSHOT</version>
        <name>SeriesDeleteTable</name>
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
                                <mainClass>com.mycompany.app.SeriesDeleteTable</mainClass>
                            </manifest>
                            <manifestEntries>
                                <Class-Path>.</Class-Path>
                            </manifestEntries>
                        </archive>
                        <finalName>release/SeriesDeleteTable</finalName>
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

   1. In the folder `src/main/java/com/mycompany/app/`, create the `SeriesDeleteTable.java` file, for example, using the nano editor:

      ```bash
      nano src/main/java/com/mycompany/app/SeriesDeleteTable.java
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```java
      package com.mycompany.app;

      import com.amazonaws.client.builder.AwsClientBuilder;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
      import com.amazonaws.services.dynamodbv2.document.DynamoDB;
      import com.amazonaws.services.dynamodbv2.document.Table;

      public class SeriesDeleteTable {

          public static void main(String[] args) throws Exception {

              AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document_API_endpoint>", "{{ region-id }}"))
                  .build();

              DynamoDB dynamoDB = new DynamoDB(client);

              Table table = dynamoDB.getTable("Series");

              try {
                  System.out.println("Trying to delete the table, wait...");
                  table.delete();
                  table.waitForDelete();
                  System.out.print("Series table deleted.");

              }
              catch (Exception e) {
                  System.err.println("Couldn't delete the table: ");
                  System.err.println(e.getMessage());
              }

          }
      }
      ```

   1. Build a project:

      ```bash
      mvn package
      ```

      As a result of running the command, the `SeriesDeleteTable.jar` file is generated in the folder `target/release/`.

   1. Run the application:

      ```bash
      java -jar target/release/SeriesDeleteTable.jar
      ```

      Result:

      ```text
      Attempting to delete table, wait...
      Table Series deleted.
      ```

- Python

   1. Create the `SeriesDeleteTable.py` file, for example, using the nano editor:

      ```bash
      nano SeriesDeleteTable.py
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```python
      import boto3

      def delete_serie_table():
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document_API_endpoint>")

          table = ydb_docapi_client.Table('Series')
          table.delete()

      if __name__ == '__main__':
          delete_serie_table()
          print("Table Series deleted")
      ```

   1. Run the program:

      ```bash
      python SeriesDeleteTable.py
      ```

      Result:

      ```text
      Table Series deleted.
      ```

- PHP

   1. Create the `SeriesDeleteTable.php` file, for example, using the nano editor:

      ```bash
      nano SeriesDeleteTable.php
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

      $sdk = new Aws\Sdk([
          'endpoint' => '<Document_API_endpoint>',
          'region'   => '{{ region-id }}',
          'version'  => 'latest'
      ]);

      $dynamodb = $sdk->createDynamoDb();

      $params = [
          'TableName' => 'Series'
      ];

      try {
          $result = $dynamodb->deleteTable($params);
          echo "Table deleted.\n";

      } catch (DynamoDbException $e) {
          echo "Couldn't delete table:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

   1. Run the program:

      ```bash
      php SeriesDeleteTable.php
      ```

      Result:

      ```txt
      Table deleted.
      ```

- Node.js

   1. Create the `SeriesDeleteTable.js` file, for example, using the nano editor:

      ```bash
      nano SeriesDeleteTable.js
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```javascript
      const AWS = require("@aws-sdk/client-dynamodb");

      // Credentials should be defined via environment variables AWS_SECRET_ACCESS_KEY and AWS_ACCESS_KEY_ID
      const dynamodb = new AWS.DynamoDBClient({
          region: "{{ region-id }}",
          endpoint: "<Document_API_endpoint>",
      });

      dynamodb.send(new AWS.DeleteTableCommand({
          TableName: "Series"
      }))
          .then(data => {
              console.error("Couldn't delete table. JSON error:", JSON.stringify(err, null, 2));
          })
          .catch(err => {
              console.log("Table deleted. Description of JSON table:", JSON.stringify(data, null, 2));
          })
      ```

   1. Run the program:

      ```bash
      node SeriesDeleteTable.js
      ```

      Result:

      ```text
      Table deleted. Description of JSON table: {
        "TableDescription": {
          "AttributeDefinitions": [
            {
              "AttributeName": "series_id",
              "AttributeType": "N"
            },
            {
              "AttributeName": "title",
              "AttributeType": "S"
            }
          ],
          "TableName": "Series",
          "KeySchema": [
            {
              "AttributeName": "series_id",
              "KeyType": "HASH"
            },
            {
              "AttributeName": "title",
              "KeyType": "RANGE"
            }
          ],
          "TableStatus": "DELETING",
          "CreationDateTime": "2021-06-14T19:34:32.000Z",
          "TableSizeBytes": 6064,
          "ItemCount": 8
        }
      }
      ```

- Ruby

   1. Create the `SeriesDeleteTable.rb` file, for example, using the nano editor:

      ```bash
      nano SeriesDeleteTable.rb
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'

      def table_deleted?(dynamodb_client, table_name)
        dynamodb_client.delete_table(table_name: table_name)
        true
      rescue StandardError => e
        puts "Error deleting table: #{e.message}"
        false
      end

      def run_me
        region = '{{ region-id }}'
        table_name = 'Series'

        Aws.config.update(
          endpoint: '<Document_API_endpoint>',
          region: region
        )

        dynamodb_client = Aws::DynamoDB::Client.new

        puts "Deleting a table '#{table_name}'..."

        if table_deleted?(dynamodb_client, table_name)
          puts 'Table deleted.'
        else
          puts 'Couldn't delete table.'
        end
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

   1. Run the program:

      ```bash
      ruby SeriesDeleteTable.rb
      ```

      Result:

      ```text
      Deleting table 'Series'...
      Table deleted.
      ```

{% endlist %}
