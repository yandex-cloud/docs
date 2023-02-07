---
sourcePath: overlay/quickstart/document-api/aws-sdk/delete-item.md
---
# Deleting a record

To conditionally delete a record from the `Series` table:

{% list tabs %}

- Java

   1. Create the `SeriesItemOps06` project:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
        -DartifactId=SeriesItemOps06
      ```

      As a result of running the command, the `SeriesItemOps06` project folder is created in the current working folder with a structure of subfolders and the `pom.xml` project description file.

   1. Go to the project folder:

      ```bash
      cd SeriesItemOps06
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
        <artifactId>SeriesItemOps06</artifactId>
        <packaging>jar</packaging>
        <version>1.0-SNAPSHOT</version>
        <name>SeriesItemOps06</name>
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
                                <mainClass>com.mycompany.app.SeriesItemOps06</mainClass>
                            </manifest>
                            <manifestEntries>
                                <Class-Path>.</Class-Path>
                            </manifestEntries>
                        </archive>
                        <finalName>release/SeriesItemOps06</finalName>
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

   1. In the folder `src/main/java/com/mycompany/app/`, create the `SeriesItemOps06.java` file, for example, using the nano editor:

      ```bash
      nano src/main/java/com/mycompany/app/SeriesItemOps06.java
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```java
      package com.mycompany.app;

      import com.amazonaws.client.builder.AwsClientBuilder;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
      import com.amazonaws.services.dynamodbv2.document.DynamoDB;
      import com.amazonaws.services.dynamodbv2.document.PrimaryKey;
      import com.amazonaws.services.dynamodbv2.document.Table;
      import com.amazonaws.services.dynamodbv2.document.spec.DeleteItemSpec;
      import com.amazonaws.services.dynamodbv2.document.utils.ValueMap;

      public class SeriesItemOps06 {

          public static void main(String[] args) throws Exception {

              AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API endpoint>", "{{ region-id }}"))
                  .build();

              DynamoDB dynamoDB = new DynamoDB(client);

              Table table = dynamoDB.getTable("Series");

              int series_id = 3;
              String title = "Supernatural";

              DeleteItemSpec deleteItemSpec = new DeleteItemSpec()
                  .withPrimaryKey(new PrimaryKey("series_id", series_id, "title", title)).withConditionExpression("info.rating <= :val")
                  .withValueMap(new ValueMap().withNumber(":val", 5));

              try {
                  System.out.println("Trying to delete record...");
                  table.deleteItem(deleteItemSpec);
                  System.out.println("Series data deleted.");
              }
              catch (Exception e) {
                  System.err.println("Couldn't delete record: " + series_id + " " + title);
                  System.err.println(e.getMessage());
              }

          }
      }
      ```

      This code deletes a movie record if its rating is 5 or lower.

      You can use the `deleteItem` method to delete a single record by specifying its primary key. You can additionally specify `ConditionExpression` to prevent the element from being deleted if this condition is not satisfied.

   1. Build a project:

      ```bash
      mvn package
      ```

      As a result of running the command, the `SeriesItemOps06.jar` file is generated in the folder `target/release/`.

   1. Run the application:

      ```bash
      java -jar target/release/SeriesItemOps06.jar
      ```

      Result:

      ```text
      Attempting to delete record...
      Couldn't delete record: 3 Supernatural
      Condition not satisfied (Service: AmazonDynamoDBv2; Status Code: 400; Error Code: ConditionalCheckFailedException; Request ID: null; Proxy: null)
      ```

      Error completing operation: film rating is higher than 5.

      Change the code by deleting the condition in `DeleteItemSpec`:

      ```java
      DeleteItemSpec deleteItemSpec = new DeleteItemSpec()
          .withPrimaryKey(new PrimaryKey("series_id", series_id, "title", title));
      ```

      Re-build the project and run the application:

      ```bash
      mvn package && java -jar target/release/SeriesItemOps06.jar
      ```

      Now the operation is successful:

      ```text
      Attempting to delete record...
      Series data deleted.
      ```

- Python

   1. Create the `SeriesItemOps06.py` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps06.py
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```python
      from decimal import Decimal
      from pprint import pprint
      import boto3
      from botocore.exceptions import ClientError

      def delete_underrated_serie(title, series_id, rating):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API endpoint>")

          table = ydb_docapi_client.Table('Series')

          try:
              response = table.delete_item(
                  Key = {
                      'series_id': series_id,
                      'title': title
                  },
                  ConditionExpression = "info.rating <= :val",
                  ExpressionAttributeValues = {
                      ":val": Decimal(rating)
                  }
              )
          except ClientError as e:
              if e.response['Error']['Code'] == "ConditionalCheckFailedException":
                  print(e.response['Error']['Message'])
              else:
                  raise
          else:
              return response

      if __name__ == '__main__':
          print("Trying to delete record...")
          delete_response = delete_underrated_serie("Supernatural", 3, 5)
          if delete_response:
              print("Series data deleted:")
              pprint(delete_response, sort_dicts = False)
      ```

      The above code deletes a record if the series rating is 5 or lower.

      To delete a record, use the `delete_item` method, that passes the primary key of the desired item. If necessary, you can set a condition for deleting a record by specifying the `ConditionExpression` parameter.

   1. Run the program:

      ```bash
      python SeriesItemOps06.py
      ```

      Result:

      ```text
      Attempting to delete record...
      Condition not satisfied
      ```

      Error completing operation: film rating is higher than 5.

   1. Change the code by deleting the condition:

      ```python
      response = table.delete_item(
          Key = {
              'series_id': series_id,
              'title': title
          }
      )
      ```

   1. Run the program again. The delete operation should now be successful.

      Result:

      ```text
      Attempting to delete record...
      Series data deleted:
      {'ResponseMetadata': {'HTTPStatusCode': 200,
                            'HTTPHeaders': {'content-type': 'application/x-amz-json-1.0',
                                            'x-amz-crc32': '2745614147',
                                            'x-request-id': '786fed1d-3c71-4fee-9827-f3f28da0493e',
                                            'date': 'Wed, 13 Jan 2021 11:04:13 GMT',
                                            'content-length': '2'},
                            'RetryAttempts': 0}}
      ```

- PHP

   1. Create the `SeriesItemOps06.php` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps06.php
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

      $key = $marshaler->marshalJson('
          {
              "series_id": ' . $series_id . ',
              "title": "' . $title . '"
          }
      ');

      $eav = $marshaler->marshalJson('
          {
              ":val": 5
          }
      ');

      $params = [
          'TableName' => $tableName,
          'Key' => $key,
          'ConditionExpression' => 'info.rating <= :val',
          'ExpressionAttributeValues'=> $eav
      ];

      try {
          $result = $dynamodb->deleteItem($params);
          echo "Item deleted.\n";

      } catch (DynamoDbException $e) {
          echo "Couldn't delete item:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

      You can use the `deleteItem` method to delete a single record by specifying its primary key. You can additionally specify `ConditionExpression` to prevent the element from being deleted if this condition is not satisfied.

      This code deletes a movie record if its rating is 5 or lower.

   1. Run the program:

      ```bash
      php SeriesItemOps06.php
      ```

      Result:

      ```text
      Couldn't delete item:
      ...
      ConditionalCheckFailedException (client): Condition not satisfied
      ...
      ```

      Error completing operation: film rating is higher than 5.

      Change the code by deleting the condition:

      ```php
      $params = [
          'TableName' => $tableName,
          'Key' => $key
      ];
      ```

      Run the program again. Now the operation is successful:

      ```text
      Item deleted.
      ```

- Node.js

   1. Create the `SeriesItemOps06.js` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps06.js
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
          Key: marshall({
              "series_id": series_id,
              "title": title
          }),
          ConditionExpression: "info.rating >= :val",
          ExpressionAttributeValues: marshall({
              ":val": 10
          })
      };

      console.log("Performing conditional deletion...");

      dynamodb.send(new AWS.DeleteItemCommand(params))
          .then(data => {
              console.log("Successfully deleted:", JSON.stringify(data, null, 2));
          })
          .catch(err => {
              console.error("Couldn't delete item. JSON error:", JSON.stringify(err, null, 2));
              process.exit(1);
          } else {
              console.log("Record deleted:", JSON.stringify(data, null, 2));
          }
      });
      ```

      You can delete a single item by specifying its primary key using the command `DeleteItemCommand`. If necessary, you can specify the `ConditionExpression` to prevent the element from being deleted if this condition is not satisfied.

   1. Run the program:

      ```bash
      node SeriesItemOps06.js
      ```

      Result:

      ```text
      Performing conditional deletion...
      Couldn't delete record. JSON error: {
        "message": "Condition not satisfied",
        "code": "ConditionalCheckFailedException",
        "time": "2021-06-14T20:33:29.115Z",
        "statusCode": 400,
        "retryable": false,
        "retryDelay": 20.94065998018778
      }
      ```

      Error completing operation: film rating is lower than 10.

      Change the code by deleting the condition:

      ```javascript
      const params = {
          TableName: table,
          Key: marshall({
              "series_id": series_id,
              "title": title
          }),
      };
      ```

      Run the program again. Now the operation is successful:

      ```text
      Performing conditional deletion...
      Deletion successful: {}
      ```

- Ruby

   1. Create the `SeriesItemOps06.rb` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps06.rb
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'

      def table_item_deleted?(dynamodb_client, table_item)
        dynamodb_client.delete_item(table_item)
        true
      rescue StandardError => e
        puts "Error deleting item: #{e.message}"
        false
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

        table_item = {
          table_name: table_name,
          key: {
            series_id: series_id,
            title: title
          },
          condition_expression: 'info.rating > :val',
            expression_attribute_values: {
              ':val' => 9
            }
        }

        puts "Deleting series '#{title} (#{series_id})' from the table '#{table_name}' if the specified condition is not satisfied."

        if table_item_deleted?(dynamodb_client, table_item)
          puts 'Record deleted.'
        else
          puts 'Couldn't delete record.'
        end
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

      You can delete a single record by specifying its primary key using the `delete` method. If necessary, you can specify the `ConditionExpression` to prevent the element from being deleted if this condition is not satisfied.

   1. Run the program:

      ```bash
      ruby SeriesItemOps06.rb
      ```

      Result:

      ```text
      Deleting series 'Supernatural (3)' from 'Series' table if the specified condition is satisfied.
      Error deleting record: condition not satisfied
      Couldn't delete record.
      ```

      Operation failed: film rating is 9.

      Change the code by deleting the condition:

      ```ruby
      table_item = {
        table_name: table_name,
        key: {
          series_id: series_id,
          title: title
        }
      }
      ```

      Run the program again. Now the operation is successful:

      ```text
      Deleting series 'Supernatural (3)' from 'Series' table if the specified condition is satisfied.
      Record deleted.
      ```

{% endlist %}
