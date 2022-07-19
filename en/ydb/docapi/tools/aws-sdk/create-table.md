---
sourcePath: overlay/quickstart/document-api/aws-sdk/create-table.md
---
# Creating a table

To create a table named `Series` with the `series_id` partition key and the `title` sort key:

{% list tabs %}

- Java

   1. Create the `SeriesCreateTable` project:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=ru.yandex.cloud.samples \
        -DartifactId=SeriesCreateTable
      ```

      As a result of running the command, the `SeriesCreateTable` project folder is created in the current working folder with a structure of subfolders and the `pom.xml` project description file.

   1. Go to the project folder:

      ```bash
      cd SeriesCreateTable
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
        <groupId>ru.yandex.cloud.samples</groupId>
        <artifactId>SeriesCreateTable</artifactId>
        <packaging>jar</packaging>
        <version>1.0-SNAPSHOT</version>
        <name>SeriesCreateTable</name>
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
                                <mainClass>ru.yandex.cloud.samples.SeriesCreateTable</mainClass>
                            </manifest>
                            <manifestEntries>
                                <Class-Path>.</Class-Path>
                            </manifestEntries>
                        </archive>
                        <finalName>release/SeriesCreateTable</finalName>
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

   1. In the folder `src/main/java/en/yandex/cloud/samples/`, create the `SeriesCreateTable.java` file, for example, using the nano editor:

      ```bash
      nano src/main/java/en/yandex/cloud/samples/SeriesCreateTable.java
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```java
      package ru.yandex.cloud.samples;

      import java.util.Arrays;

      import com.amazonaws.client.builder.AwsClientBuilder;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
      import com.amazonaws.services.dynamodbv2.document.DynamoDB;
      import com.amazonaws.services.dynamodbv2.document.Table;
      import com.amazonaws.services.dynamodbv2.model.AttributeDefinition;
      import com.amazonaws.services.dynamodbv2.model.KeySchemaElement;
      import com.amazonaws.services.dynamodbv2.model.KeyType;
      import com.amazonaws.services.dynamodbv2.model.CreateTableRequest;
      import com.amazonaws.services.dynamodbv2.model.ScalarAttributeType;

      public class SeriesCreateTable {

          public static void main(String[] args) throws Exception {

              AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
                    .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API endpoint>", "ru-central1"))
                    .build();

              DynamoDB dynamoDB = new DynamoDB(client);

              String tableName = "Series";

              try {
                  System.out.println("Attempting to create table, wait...");
                    CreateTableRequest request = new CreateTableRequest();
                    request.setTableName(tableName);
                    request.setKeySchema(
                      Arrays.asList(new KeySchemaElement("series_id", KeyType.HASH), // Partition key
                          new KeySchemaElement("title", KeyType.RANGE)));
                    request.setAttributeDefinitions(
                      Arrays.asList(new AttributeDefinition("series_id", ScalarAttributeType.N),
                          new AttributeDefinition("title", ScalarAttributeType.S)));
                    Table table = dynamoDB.createTable(request);
                    table.waitForActive();
                    System.out.println("Table status: " + table.getDescription().getTableStatus());
              }
              catch (Exception e) {
                  System.err.println("Couldn't create table: ");
                  System.err.println(e.getMessage());
              }

          }
      }
      ```

   1. Build a project:

      ```bash
      mvn package
      ```

      As a result of running the command, the `SeriesCreateTable.jar` file is generated in the folder `target/release/`.

   1. Run the application:

      ```bash
      java -jar target/release/SeriesCreateTable.jar
      ```

      Result:

      ```text
      Attempting to create table, wait...
      Table status: ACTIVE
      ```

- Python

   The code below uses the `print` function from Python 3. To use this function in Python 2.6 or higher, add the `from __future__ import print_function` line at the beginning of the file.

   1. Create the `SeriesCreateTable.py` file, for example, using the nano editor:

      ```bash
      nano SeriesCreateTable.py
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```python
      import boto3

      def create_series_table():
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API endpoint>")

          table = ydb_docapi_client.create_table(
              TableName = 'Series', # Series is the table name 
              KeySchema = [
                  {
                      'AttributeName': 'series_id',
                      'KeyType': 'HASH'  # Partition key
                  },
                  {
                      'AttributeName': 'title',
                      'KeyType': 'RANGE'  # Sort key
                  }
              ],
              AttributeDefinitions = [
                  {
                      'AttributeName': 'series_id',
                      'AttributeType': 'N'  # Integer
                  },
                  {
                      'AttributeName': 'title',
                      'AttributeType': 'S'  # String
                  },

              ]
          )
          return table

      if __name__ == '__main__':
          series_table = create_series_table()
          print("Table status:", series_table.table_status)
      ```

   1. Run the program:

      ```bash
      python SeriesCreateTable.py
      ```

      Result:

      ```text
      Table status: ACTIVE
      ```

- PHP

   1. Create the `SeriesCreateTable.php` file, for example, using the nano editor:

      ```bash
      nano SeriesCreateTable.php
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

      $sdk = new Aws\Sdk([
          'endpoint' => '<Document API endpoint>',
          'region'   => 'ru-central1',
          'version'  => 'latest'
      ]);

      $dynamodb = $sdk->createDynamoDb();

      $params = [
          'TableName' => 'Series',
          'KeySchema' => [
              [
                  'AttributeName' => 'series_id',
                  'KeyType' => 'HASH'
              ],
              [
                  'AttributeName' => 'title',
                  'KeyType' => 'RANGE'
              ]
          ],
          'AttributeDefinitions' => [
              [
                  'AttributeName' => 'series_id',
                  'AttributeType' => 'N'
              ],
              [
                  'AttributeName' => 'title',
                  'AttributeType' => 'S'
              ],
          ]
      ];

      try {
          $result = $dynamodb->createTable($params);
          echo 'Table status: '.
              $result['TableDescription']['TableStatus'] ."\n";

      } catch (DynamoDbException $e) {
          echo "Couldn't create table:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

   1. Run the program:

      ```bash
      php SeriesCreateTable.php
      ```

      Result:

      ```txt
      Table status: ACTIVE
      ```

- Node.js

   1. Create the `SeriesCreateTable.js` file, for example, using the nano editor:

      ```bash
      nano SeriesCreateTable.js
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```javascript
      var AWS = require("aws-sdk");

      AWS.config.update({
        region: "ru-central1",
        endpoint: "<Document API endpoint>"
      });

      var dynamodb = new AWS.DynamoDB();

      var params = {
          TableName : "Series",
          KeySchema: [       
              { AttributeName: "series_id", KeyType: "HASH"},
              { AttributeName: "title", KeyType: "RANGE" }
          ],
          AttributeDefinitions: [       
              { AttributeName: "series_id", AttributeType: "N" },
              { AttributeName: "title", AttributeType: "S" }
          ]};

      dynamodb.createTable(params, function(err, data) {
          if (err) {
              console.error("Couldn't create table. JSON error:", JSON.stringify(err, null, 2));
              process.exit(1);
          } else {
              console.log("Table created. JSON table schema:", JSON.stringify(data, null, 2));
          }
      });
      ```

   1. Run the program:

      ```bash
      node SeriesCreateTable.js
      ```

      Result:

      ```text
      Table created. JSON table schema: {
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
          "TableStatus": "ACTIVE",
          "CreationDateTime": "2021-06-14T19:34:32.000Z",
          "TableSizeBytes": 0,
          "ItemCount": 0
        }
      }
      ```

- Ruby

   1. Create the `SeriesCreateTable.rb` file, for example, using the nano editor:

      ```bash
      nano SeriesCreateTable.rb
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'

      def create_table(dynamodb_client, table_definition)
        response = dynamodb_client.create_table(table_definition)
        response.table_description.table_status
      rescue StandardError => e
        puts "Error creating table: #{e.message}"
        'Error'
      end

      def run_me
        region = 'ru-central1'

        Aws.config.update(
          endpoint: '<Document API endpoint>',
          region: region
        )

        dynamodb_client = Aws::DynamoDB::Client.new

        table_definition = {
          table_name: 'Series',
          key_schema: [
            {
              attribute_name: 'series_id',
              key_type: 'HASH' # Partition key.
            },
            {
              attribute_name: 'title',
              key_type: 'RANGE' # Sort key.
            }
          ],
          attribute_definitions: [
            {
              attribute_name: 'series_id',
              attribute_type: 'N'
            },
            {
              attribute_name: 'title',
              attribute_type: 'S'
            }
          ]
        }

        puts "Creating a table 'Series'..."
        create_table_result = create_table(dynamodb_client, table_definition)

        if create_table_result == 'Error'
          puts 'Couldn't create table.'
        else
          puts "Table created. Status: '#{create_table_result}'."
        end
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

   1. Run the program:

      ```bash
      ruby SeriesCreateTable.rb
      ```

      Result:

      ```text
      Creating table 'Series'...
      Table created. Status: 'ACTIVE'.
      ```

{% endlist %}
