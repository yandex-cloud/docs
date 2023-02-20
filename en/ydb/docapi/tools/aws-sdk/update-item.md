---
sourcePath: overlay/quickstart/document-api/aws-sdk/update-item.md
---
# Updating a record

This instruction describes how to make changes to an existing record in the table.

## Unconditional update {#update-item}

In the following example, the value of the existing `release_date` attribute is updated and the new `rating` attribute is added.

To update a movie record in the `Series` table:

{% list tabs %}

- Java

   1. Create the `SeriesItemOps03` project:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
        -DartifactId=SeriesItemOps03
      ```

      As a result of running the command, the `SeriesItemOps03` project folder is created in the current working folder with a structure of subfolders and the `pom.xml` project description file.

   1. Go to the project folder:

      ```bash
      cd SeriesItemOps03
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
        <artifactId>SeriesItemOps03</artifactId>
        <packaging>jar</packaging>
        <version>1.0-SNAPSHOT</version>
        <name>SeriesItemOps03</name>
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
                    <mainClass>com.mycompany.app.SeriesItemOps03</mainClass>
                  </manifest>
                  <manifestEntries>
                    <Class-Path>.</Class-Path>
                  </manifestEntries>
                </archive>
                <finalName>release/SeriesItemOps03</finalName>
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

   1. In the folder `src/main/java/com/mycompany/app/`, create the `SeriesItemOps03.java` file, for example, using the nano editor:

      ```bash
      nano src/main/java/com/mycompany/app/SeriesItemOps03.java
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```java
      package com.mycompany.app;

      import java.util.Arrays;

       import com.amazonaws.client.builder.AwsClientBuilder;
       import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
       import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
       import com.amazonaws.services.dynamodbv2.document.DynamoDB;
       import com.amazonaws.services.dynamodbv2.document.Table;
       import com.amazonaws.services.dynamodbv2.document.UpdateItemOutcome;
       import com.amazonaws.services.dynamodbv2.document.spec.UpdateItemSpec;
       import com.amazonaws.services.dynamodbv2.document.utils.ValueMap;
       import com.amazonaws.services.dynamodbv2.model.ReturnValue;

      public class SeriesItemOps03 {

        public static void main(String[] args) throws Exception {

          AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
            .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API endpoint>", "{{ region-id }}"))
            .build();

          DynamoDB dynamoDB = new DynamoDB(client);

          Table table = dynamoDB.getTable("Series");

          int series_id = 3;
          String title = "Supernatural";

          UpdateItemSpec updateItemSpec = new UpdateItemSpec().withPrimaryKey("series_id", series_id, "title", title)
            .withUpdateExpression("set info.release_date=:d, info.rating=:r")
            .withValueMap(new ValueMap().withString(":d", "2005-09-13").withNumber(":r", 8))
            .withReturnValues(ReturnValue.UPDATED_NEW);

          try {
            System.out.println("Updating the record...");
            UpdateItemOutcome outcome = table.updateItem(updateItemSpec);
            System.out.println("Series data updated:\n" + outcome.getItem().toJSONPretty());

          }
          catch (Exception e) {
            System.err.println("Couldn't update the record: " + series_id + " " + title);
            System.err.println(e.getMessage());
          }
        }
      }
      ```

      You can add, update, or delete attributes for an existing record using the `updateItem` method.

      This code uses `UpdateExpression` to describe the updates that need to be performed for the specified record.

      The `ReturnValues` parameter instructs {{ ydb-short-name }} to return only updated attributes (`UPDATED_NEW`).

   1. Build a project:

      ```bash
      mvn package
      ```

      As a result of running the command, the `SeriesItemOps03.jar` file is generated in the folder `target/release/`.

   1. Run the application:

      ```bash
      java -jar target/release/SeriesItemOps03.jar
      ```

      Result:

      ```text
      Updating record...
      Series data updated:
      {
        "info" : {
          "release_date" : "2005-09-13",
          "rating" : 8,
          "series_info" : "Supernatural is an American television series created by Eric Kripke"
        }
      }
      ```

- Python

   1. Create the `SeriesItemOps03.py` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps03.py
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```python
      from decimal import Decimal
      from pprint import pprint
      import boto3

      def update_serie(title, series_id, release_date, rating):
        ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API endpoint>")

        table = ydb_docapi_client.Table('Series')

        response = table.update_item(
          Key = {
            'series_id': series_id,
            'title': title
          },
          UpdateExpression = "set info.release_date = :d, info.rating = :r ",
          ExpressionAttributeValues = {
            ':d': release_date,
            ':r': Decimal(rating)
          },
          ReturnValues = "UPDATED_NEW"
        )
        return response

      if __name__ == '__main__':
        update_response = update_serie(
          "Supernatural", 3, "2005-09-13", 8)
        print("Series data updated:")
        pprint(update_response, sort_dicts = False)
      ```

      To update a record, use the `update_item` method. You can use it to update attribute values or add or remove attributes.

      In the `UpdateExpression` parameter of the `update_item` method, all updates applied to the specified record are passed. The `ReturnValues` parameter instructs {{ ydb-short-name }} to return only updated attributes (`UPDATED_NEW`).

      In the Boto 3 SDK, the `Decimal` class is used for storing {{ ydb-short-name }} numeric values.

   1. Run the program:

      ```bash
      python SeriesItemOps03.py
      ```

      Result:

      ```text
      Series data updated:
      {'Attributes': {'info': {'release_date': '2005-09-13',
                               'series_info': 'Supernatural is an American '
                                               'television series created by Eric '
                                               'Kripke',
                               'rating': Decimal('8')}},
      'ResponseMetadata': {'HTTPStatusCode': 200,
                             'HTTPHeaders': {'content-type': 'application/x-amz-json-1.0',
                                             'x-amz-crc32': '672222905',
                                             'x-request-id': '43c12c64-178b-4144-8766-95dbcf2421b8',
                                             'date': 'Sun, 27 Dec 2020 13:01:12 GMT',
                                             'content-length': '175'},
                             'RetryAttempts': 0}}
      ```

- PHP

   1. Create the `SeriesItemOps03.php` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps03.php
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
          ":d": "2005-09-13",
          ":r": 8
        }
      ');

      $params = [
        'TableName' => $tableName,
        'Key' => $key,
        'UpdateExpression' =>
          'set info.release_date=:d, info.rating = :r',
        'ExpressionAttributeValues'=> $eav,
        'ReturnValues' => 'UPDATED_NEW'
      ];

      try {
          $result = $dynamodb->updateItem($params);
          echo "Record is updated.\n";
          echo json_encode($result["Attributes"], JSON_PRETTY_PRINT);

      } catch (DynamoDbException $e) {
        echo "Couldn't update the record:\n";
        echo $e->getMessage() . "\n";
      }

      ?>
      ```

      This code uses `UpdateExpression` to describe the updates that need to be performed for the specified record.

      The `ReturnValues` parameter instructs {{ ydb-short-name }} to return only updated attributes (`UPDATED_NEW`).
   1. Run the program:

      ```bash
      php SeriesItemOps03.php
      ```

      Result:

      ```text
      Record updated.
      {
        "info": {
          "M": {
            "rating": {
              "N": "8"
            },
             "release_date": {
               "S": "2005-09-13"
             },
             "series_info": {
               "S": "Supernatural is an American television series created by Eric Kripke"
             }
          }
        }
      }
      ```

- Node.js

   1. Create the `SeriesItemOps03.js` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps03.js
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

      console.log("Updating record...");

      dynamodb.send(new AWS.UpdateItemCommand({
        TableName:table,
        Key: marshall({
          "series_id": series_id,
          "title": title
        },
        UpdateExpression: "set info.release_date = :d, info.rating = :r",
        ExpressionAttributeValues: marshall({
          ":d": "2005-09-13",
          ":r": 8
        },
        ReturnValues:"UPDATED_NEW"
        }))
          .then(data => {
              console.log("Update successful:", JSON.stringify(data, null, 2));
          })
          .catch(err => {
              console.error("Couldn't update record. JSON error:", JSON.stringify(err, null, 2));
          });
      ```

      To update the attributes of an existing record, use the command `UpdateItemCommand`. The `UpdateExpression` expression describes all the updates you want to perform for the specified element.

      The `ReturnValues` parameter indicates to {{ ydb-short-name }} to return only updated attributes `UPDATED_NEW`.

   1. Run the program:

      ```bash
      node SeriesItemOps03.js
      ```

      Result:

      ```text
      Updating record...
      Update successful: {
        "Attributes": {
          "info": {
            "rating": 8,
            "release_date": "2005-09-13",
            "series_info": "Supernatural is an American television series created by Eric Kripke"
          }
        }
      }
      ```

- Ruby

   1. Create the `SeriesItemOps03.rb` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps03.rb
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'

      def table_item_updated?(dynamodb_client, table_item)
        response = dynamodb_client.update_item(table_item)
        puts "Record updated with 'info' attributes:"
        response.attributes['info'].each do |key, value|
          if key == 'rating'
            puts "#{key}: #{value.to_f}"
          else
            puts "#{key}: #{value}"
          end
        end
        true
      rescue StandardError => e
        puts "Error updating record: #{e.message}"
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
          update_expression: 'SET info.release_date = :d, info.rating = :r',
          expression_attribute_values: {
            ':d': '2005-09-13',
            ':r': 8
          },
          return_values: 'UPDATED_NEW'
        }
        puts "Updating the table '#{table_name}' with information about " \
          "'#{title} (#{series_id})'..."

        if table_item_updated?(dynamodb_client, table_item)
          puts 'Table updated.'
        else
          puts 'Couldn’t update table.'
        end
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

      This program uses the `update_expression` expression to describe all the updates that you want to perform for the specified element.

      The `return_values` parameter indicates to {{ ydb-short-name }} to return only updated attributes `UPDATED_NEW`.

   1. Run the program:

      ```bash
      ruby SeriesItemOps03.rb
      ```

      Result:

      ```text
      Updating table 'Series' with information about 'Supernatural (3)'...
      Record updated with 'info' attributes:
      series_info: Supernatural is an American television series created by Eric Kripke
      rating: 8.0
      release_date: 2005-09-13
      Table updated.
      ```

{% endlist %}

## Increasing an atomic counter {#increment-ac}

{{ ydb-short-name }} supports atomic counters.

To increase the `rating` atomic counter for a series:

{% list tabs %}

- Java

   1. Create the `SeriesItemOps04` project:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
        -DartifactId=SeriesItemOps03
      ```

      As a result of running the command, the `SeriesItemOps04` project folder is created in the current working folder with a structure of subfolders and the `pom.xml` project description file.
   1. Go to the project folder:

      ```bash
      cd SeriesItemOps04
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
        <artifactId>SeriesItemOps04</artifactId>
        <packaging>jar</packaging>
        <version>1.0-SNAPSHOT</version>
        <name>SeriesItemOps04</name>
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
                    <mainClass>com.mycompany.app.SeriesItemOps04</mainClass>
                  </manifest>
                  <manifestEntries>
                    <Class-Path>.</Class-Path>
                  </manifestEntries>
                </archive>
                <finalName>release/SeriesItemOps04</finalName>
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

   1. In the folder `src/main/java/com/mycompany/app/`, create the `SeriesItemOps04.java` file, for example, using the nano editor:

      ```bash
      nano src/main/java/com/mycompany/app/SeriesItemOps04.java
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
      import com.amazonaws.services.dynamodbv2.document.Table;
      import com.amazonaws.services.dynamodbv2.document.UpdateItemOutcome;
      import com.amazonaws.services.dynamodbv2.document.spec.UpdateItemSpec;
      import com.amazonaws.services.dynamodbv2.document.utils.ValueMap;
      import com.amazonaws.services.dynamodbv2.model.ReturnValue;

      public class SeriesItemOps04 {

        public static void main(String[] args) throws Exception {

          AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
            .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API endpoint>", "{{ region-id }}"))
            .build();

          DynamoDB dynamoDB = new DynamoDB(client);

          Table table = dynamoDB.getTable("Series");

          int series_id = 3;
          String title = "Supernatural";

          UpdateItemSpec updateItemSpec = new UpdateItemSpec().withPrimaryKey("series_id", series_id, "title", title)
            .withUpdateExpression("set info.rating = info.rating + :val")
            .withValueMap(new ValueMap().withNumber(":val", 1)).withReturnValues(ReturnValue.UPDATED_NEW);

          try {
            System.out.println("Increasing an atomic counter...");
            UpdateItemOutcome outcome = table.updateItem(updateItemSpec);
            System.out.println("Series data updated:\n" + outcome.getItem().toJSONPretty());

          }
          catch (Exception e) {
            System.err.println("Couldn't update record: " + series_id + " " + title);
            System.err.println(e.getMessage());
          }

        }
      }
      ```

      Use the `updateItem` method to increase or decrease the value of an existing attribute independently of other write requests (all write requests are applied in the order they are received).

   1. Build a project:

      ```bash
      mvn package
      ```

      As a result of running the command, the `SeriesItemOps04.jar` file is generated in the folder `target/release/`.

   1. Run the application:

      ```bash
      java -jar target/release/SeriesItemOps04.jar
      ```

      Result:

      ```text
      Increasing atomic counter...
      Series data updated:
      {
        "info" : {
          "release_date" : "2005-09-13",
          "rating" : 9,
          "series_info" : "Supernatural is an American television series created by Eric Kripke"
        }
      }
      ```

- Python

   1. Create the `SeriesItemOps04.py` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps04.py
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```python
      from decimal import Decimal
      from pprint import pprint
      import boto3

      def increase_rating(title, series_id, rating_increase):
        ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API endpoint>")

        table = ydb_docapi_client.Table('Series')

        response = table.update_item(
          Key = {
            'series_id': series_id,
            'title': title
          },
          UpdateExpression = "set info.rating = info.rating + :val",
          ExpressionAttributeValues = {
            ':val': Decimal(rating_increase)
          },
          ReturnValues = "UPDATED_NEW"
        )
        return response

      if __name__ == '__main__':
        update_response = increase_rating("Supernatural", 3, 1)
        print("Data about the series has been updated:")
        pprint(update_response, sort_dicts = False)
      ```

      Use the `update_item` method to increase or decrease the value of an existing attribute. In this case, all write requests are applied in the order they arrive.

      Each time the program is started, the value of the `rating` attribute increases by one.

   1. Run the program:

      ```bash
      python SeriesItemOps04.py
      ```

      Result:

      ```bash
      Series data updated:
      {'Attributes': {'info': {'rating': Decimal('9'),
                               'release_date': '2005-09-13',
                               'series_info': 'Supernatural is an American '
                                               'television series created by Eric '
                                               'Kripke'}},
      'ResponseMetadata': {'HTTPStatusCode': 200,
                             'HTTPHeaders': {'content-type': 'application/x-amz-json-1.0',
                                             'x-amz-crc32': '1351796704',
                                             'x-request-id': 'd5fcf336-c3b1-4d07-aaed-bb59f2a609ed',
                                             'date': 'Sun, 27 Dec 2020 13:35:10 GMT',
                                             'content-length': '175'},
                             'RetryAttempts': 0}}
      ```

- PHP

   1. Create the `SeriesItemOps04.php` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps04.php
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
          ":val": 1
        }
      ');

      $params = [
        'TableName' => $tableName,
        'Key' => $key,
        'UpdateExpression' => 'set info.rating = info.rating + :val',
        'ExpressionAttributeValues'=> $eav,
        'ReturnValues' => 'UPDATED_NEW'
      ];

      try {
        $result = $dynamodb->updateItem($params);
        echo "Record updated:\n";
        echo json_encode($result["Attributes"], JSON_PRETTY_PRINT);

      } catch (DynamoDbException $e) {
        echo "Couldn't update the record:\n";
        echo $e->getMessage() . "\n";
      }

      ?>
      ```

      Each time the above code is run, the value of `rating` increases by one.

   1. Run the program:

      ```bash
      php SeriesItemOps04.php
      ```

      Result:

      ```text
      Record updated:
      {
        "info": {
          "M": {
            "rating": {
              "N": "9"
            },
            "release_date": {
              "S": "2005-09-13"
            },
            "series_info": {
              "S": "Supernatural is an American television series created by Eric Kripke"
            }
          }
        }
      }
      ```

- Node.js

   1. Create the `SeriesItemOps04.js` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps04.js
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```javascript
      var AWS = require("aws-sdk");

      AWS.config.update({
        region: "{{ region-id }}",
        endpoint: "<Document API endpoint>"
      });

      var docClient = new AWS.DynamoDB.DocumentClient()

      var table = "Series";

      var series_id = 3;
      var title = "Supernatural";

      var params = {
        TableName:table,
        Key:{
          "series_id": series_id,
          "title": title
        },
        UpdateExpression: "set info.rating = info.rating + :val",
        ExpressionAttributeValues:{
          ":val": 1
        },
        ReturnValues:"UPDATED_NEW"
      };

      console.log("Updating the record...");
      docClient.update(params, function(err, data) {
        if (err) {
          console.error("Couldn't update the record. JSON error:", JSON.stringify(err, null, 2));
              process.exit(1);
          } else {
              console.log("Update successful:", JSON.stringify(data, null, 2));
          }
      });
      ```

      Each time the above code is run, the value of `rating` increases by one.

   1. Run the program:

      ```bash
      node SeriesItemOps04.js
      ```

      Result:

      ```bash
      Updating record...
      Update successful: {
        "Attributes": {
          "info": {
            "rating": 9,
            "release_date": "2005-09-13",
            "series_info": "Supernatural is an American television series created by Eric Kripke"
          }
        }
      }
      ```

- Ruby

   1. Create the `SeriesItemOps04.rb` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps04.rb
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'

      def table_item_updated?(dynamodb_client, table_item)
        result = dynamodb_client.update_item(table_item)
        puts "Record updated with 'info' attributes:"
        result.attributes['info'].each do |key, value|
          if key == 'rating'
            puts "#{key}: #{value.to_f}"
          else
            puts "#{key}: #{value}"
          end
        end
        true
      rescue StandardError => e
        puts "Error updating record: #{e.message}"
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
          update_expression: 'SET info.rating = info.rating + :val',
          expression_attribute_values: {
            ':val': 1
          },
          return_values: 'UPDATED_NEW'
        }

        puts "Updating '#{table_name}' with information about " \
          "'#{title} (#{series_id})'..."

        if table_item_updated?(dynamodb_client, table_item)
          puts 'Table updated.'
        else
          puts 'Couldn’t update table.'
        end
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

      Each time the above code is run, the value of `rating` increases by one.

   1. Run the program:

      ```bash
      ruby SeriesItemOps04.rb
      ```

      Result:

      ```text
      Updating 'Series' with information about 'Supernatural (3)'...
      Record updated with 'info' attributes:
      rating: 9.0
      release_date: 2005-09-13
      series_info: Supernatural is an American television series created by Eric Kripke
      Table updated.
      ```

{% endlist %}

## Conditional update {#update-with-cond}

To update a record in the `Series` table when the condition is satisfied:

{% list tabs %}

- Java

   1. Create the `SeriesItemOps05` project:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
        -DartifactId=SeriesItemOps05
      ```

      As a result of running the command, the `SeriesItemOps05` project folder is created in the current working folder with a structure of subfolders and the `pom.xml` project description file.

   1. Go to the project folder:

      ```bash
      cd SeriesItemOps05
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
        <artifactId>SeriesItemOps05</artifactId>
        <packaging>jar</packaging>
        <version>1.0-SNAPSHOT</version>
        <name>SeriesItemOps05</name>
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
                    <mainClass>com.mycompany.app.SeriesItemOps05</mainClass>
                  </manifest>
                  <manifestEntries>
                    <Class-Path>.</Class-Path>
                  </manifestEntries>
                </archive>
                <finalName>release/SeriesItemOps05</finalName>
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

   1. In the folder `src/main/java/com/mycompany/app/`, create the `SeriesItemOps04.java` file, for example, using the nano editor:

      ```bash
      nano src/main/java/com/mycompany/app/SeriesItemOps05.java
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
      import com.amazonaws.services.dynamodbv2.document.UpdateItemOutcome;
      import com.amazonaws.services.dynamodbv2.document.spec.UpdateItemSpec;
      import com.amazonaws.services.dynamodbv2.document.utils.ValueMap;
      import com.amazonaws.services.dynamodbv2.model.ReturnValue;

      public class SeriesItemOps05 {

        public static void main(String[] args) throws Exception {

          AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
            .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API endpoint>", "{{ region-id }}"))
            .build();

          DynamoDB dynamoDB = new DynamoDB(client);

          Table table = dynamoDB.getTable("Series");

          int series_id = 3;
          String title = "Supernatural";

          UpdateItemSpec updateItemSpec = new UpdateItemSpec()
            .withPrimaryKey(new PrimaryKey("series_id", series_id, "title", title))
            .withUpdateExpression("set info.recommend=:d").withValueMap(new ValueMap().withString(":d", "Recommended for viewing"))
            .withConditionExpression("info.rating > :num").withValueMap(new ValueMap().withString(":d", "Recommended for viewing").withNumber(":num", 9))
            .withReturnValues(ReturnValue.UPDATED_NEW);

              try {
                  System.out.println("Trying a conditional update...");
                  UpdateItemOutcome outcome = table.updateItem(updateItemSpec);
                  System.out.println("Series data updated:\n" + outcome.getItem().toJSONPretty());
              }
              catch (Exception e) {
                  System.err.println("Couldn't update record: " + series_id + " " + title);
                  System.err.println(e.getMessage());
              }

        }
      }
      ```

      This code shows an example of using the `UpdateItem` condition. If the condition is `true`, the update is successful; otherwise, the update is not performed.

      In this case, a recommendation about viewing with a rating of more than 9 is added to the record.

   1. Build a project:

      ```bash
      mvn package
      ```

      As a result of running the command, the `SeriesItemOps05.jar` file is generated in the folder `target/release/`.

   1. Run the application:

      ```bash
      java -jar target/release/SeriesItemOps05.jar
      ```

      Result:

      ```text
      Attempting to perform conditional update...
      Couldn't update record: 3 Supernatural
      Condition not satisfied (Service: AmazonDynamoDBv2; Status Code: 400; Error Code: ConditionalCheckFailedException; Request ID: null; Proxy: null)
      ```

      Error completing the operation: the movie's rating is 9 and the condition checks the rating higher than 9.

      Modify the code so that the condition is 9 or higher:

      ```java
      .withConditionExpression("info.rating >= :num")
      ```

      Re-build the project and run the application:

      ```bash
      mvn package && java -jar target/release/SeriesItemOps05.jar
      ```

      Now the operation is successful:

      ```text
      Attempting to perform conditional update...
      Series data updated:
      {
        "info" : {
          "release_date" : "2005-09-13",
          "rating" : 9,
          "recommend" : "Recommended for viewing",
          "series_info" : "Supernatural is an American television series created by Eric Kripke"
        }
      }
      ```

- Python

   1. Create the `SeriesItemOps05.py` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps05.py
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```python
      from pprint import pprint
      import boto3
      from botocore.exceptions import ClientError

      def add_recommend(title, series_id, rating_val):
        ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API endpoint>")

        table = ydb_docapi_client.Table('Series')
        rec = "Recommended for viewing"

        try:
          response = table.update_item(
            Key = {
              'series_id': series_id,
              'title': title
            },
            UpdateExpression = "set info.recommend = :d ",
            ConditionExpression = "info.rating > :num",
            ExpressionAttributeValues = {
              ':num': rating_val,
              ':d': rec
            },
            ReturnValues = "UPDATED_NEW"
          )
          except ClientError as e:
            if e.response['Error']['Code'] == "ConditionalCheckFailedException":
              print(e.response['Error']['Message'])
            else:
              raise
          else:
            return response

      if __name__ == '__main__':
        print("Trying a conditional update...")
        update_response = add_recommend("Supernatural", 3, 9)
        if update_response:
          print("Series data updated:")
          pprint(update_response, sort_dicts = False)
      ```

      This code shows an example of using the `update_item` condition. If the condition is `true`, the update is successful; otherwise, the update is not performed.

      In this case, a recommendation about viewing with a rating of more than 9 is added to the record.

   1. Run the program:

      ```bash
      python SeriesItemOps05.py
      ```

      Result:

      ```bash
      Attempting to perform conditional update...
      Condition not satisfied
      ```

      The update failed because the series rating is 9 and the update condition requires the rating to be higher than 9.

   1. Modify the code so that the condition for the update is a rating of 9 or higher. In this case, the `ConditionExpression` parameter looks as follows:

      ```python
      ConditionExpression = "info.rating >= :num",
      ```

   1. Run the program again. The update operation should now be successful.

      Result:

      ```bash
      Attempting to perform conditional update...
      Series data updated:
      {'Attributes': {'info': {'release_date': '2005-09-13',
                               'series_info': 'Supernatural is an American '
                                               'television series created by Eric '
                                               'Kripke',
                               'recommend': 'Recommended for viewing',
                               'rating': Decimal('9')}},
      'ResponseMetadata': {'HTTPStatusCode': 200,
                             'HTTPHeaders': {'content-type': 'application/x-amz-json-1.0',
                                             'x-amz-crc32': '1812512314',
                                             'x-request-id': 'dcf97598-51f3-419a-b7ba-0b3ad0f5067e',
                                             'date': 'Wed, 13 Jan 2021 10:26:53 GMT',
                                             'content-length': '219'},
                             'RetryAttempts': 0}}
      ```

- PHP

   1. Create the `SeriesItemOps05.php` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps05.php
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
          ":d": "Recommended for viewing",
          ":num": 9
        }
      ');

      $params = [
        'TableName' => $tableName,
        'Key' => $key,
        'UpdateExpression' => 'set info.recommend=:d',
        'ConditionExpression' => 'info.rating > :num',
        'ExpressionAttributeValues'=> $eav,
        'ReturnValues' => 'UPDATED_NEW'
      ];

      try {
        $result = $dynamodb->updateItem($params);
        echo "Record updated:\n";
        echo json_encode($result["Attributes"], JSON_PRETTY_PRINT);

      } catch (DynamoDbException $e) {
        echo "Couldn't update the record:\n";
        echo $e->getMessage() . "\n";
      }

      ?>
      ```

      This code shows an example of using the `UpdateItem` condition. If the condition is `true`, the update is successful; otherwise, the update is not performed.

      In this case, a recommendation about viewing with a rating of more than 9 is added to the record.
   1. Run the program:

      ```bash
      php SeriesItemOps05.php
      ```

      Result:

      ```text
      Couldn't update record:
      ...
      ConditionalCheckFailedException (client): Condition not satisfied
      ...
      ```

      Error completing the operation: the movie's rating is 9 and the condition checks the rating higher than 9.

      Modify the code so that the condition is 9 or higher:

      ```php
      'ConditionExpression' => 'info.rating >= :num',
      ```

      Run the program again. Now the operation is successful:

      ```text
      Record updated:
      {
        "info": {
          "M": {
            "series_info": {
              "S": "Supernatural is an American television series created by Eric Kripke"
            },
            "recommend": {
              "S": "Recommended for viewing"
            },
            "rating": {
              "N": "9"
            },
            "release_date": {
              "S": "2005-09-13"
            }
          }
        }
      }
      ```

- Node.js

   1. Create the `SeriesItemOps05.js` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps05.js
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```javascript
      var AWS = require("aws-sdk");

      AWS.config.update({
        region: "{{ region-id }}",
        endpoint: "<Document API endpoint>"
      });

      var docClient = new AWS.DynamoDB.DocumentClient()

      var table = "Series";

      var series_id = 3;
      var title = "Supernatural";

      var params = {
        TableName:table,
        Key:{
          "series_id": series_id,
          "title": title
        },
        UpdateExpression: "set info.recommend = :d",
        ConditionExpression: "info.rating > :num",
        ExpressionAttributeValues:{
          ":num": 9,
          ":d": "Recommended for viewing"
        },
        ReturnValues:"UPDATED_NEW"
      };

      console.log("Updating records with specified condition...");
      docClient.update(params, function(err, data) {
        if (err) {
          console.error("Couldn't update record. JSON error:", JSON.stringify(err, null, 2));
              process.exit(1);
          } else {
              console.log("Update successful:", JSON.stringify(data, null, 2));
          }
      });
      ```

      This code shows an example of using the `UpdateItem` condition. If the condition is `true`, the update is successful; otherwise, the update is not performed.

      In this case, a recommendation for viewing is added to a record if the rating exceeds 9.

   1. Run the program:

      ```bash
      node SeriesItemOps05.js
      ```

      Result:

      ```text
      Updating records with specified condition...
      Couldn't update record. JSON error: {
        "message": "Condition not satisfied",
        "code": "ConditionalCheckFailedException",
        "time": "2021-06-14T20:12:19.032Z",
        "statusCode": 400,
        "retryable": false,
        "retryDelay": 38.20325040644864
      }
      ```

      Error completing the operation: the movie's rating is 9 and the condition checks the rating higher than 9.

      Modify the code so that the condition is 9 or higher:

      ```javascript
      ConditionExpression: "info.rating >= :num",
      ```

      Run the program again. Now the operation is successful:

      ```text
      Updating records with specified condition...
      Update successful: {
        "Attributes": {
          "info": {
            "rating": 9,
            "release_date": "2005-09-13",
            "series_info": "Supernatural is an American television series created by Eric Kripke",
            "recommend": "Recommended for viewing"
          }
        }
      }
      ```

- Ruby

   1. Create the `SeriesItemOps05.rb` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps05.rb
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'

      def table_item_updated?(dynamodb_client, table_item)
        result = dynamodb_client.update_item(table_item)
        puts "Record updated with 'info' attributes:"
        result.attributes['info'].each do |key, value|
          if key == 'rating'
            puts "#{key}: #{value.to_f}"
          else
            puts "#{key}: #{value}"
          end
        end
        true
      rescue StandardError => e
        puts "Error updating record: #{e.message}"
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
          update_expression: 'set info.recommend = :d',
          condition_expression: 'info.rating > :num',
          expression_attribute_values: {
            ':num': 9,
            ':d': 'Recommended for viewing'
          },
          return_values: 'UPDATED_NEW'
        }

        puts "Updating table '#{table_name}' with information about " \
          "'#{title} (#{series_id})'..."

        if table_item_updated?(dynamodb_client, table_item)
          puts 'Table updated.'
        else
          puts 'Couldn't update table.'
        end
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

      This code shows an example of using the `update_item` condition. If the condition is `true`, the update is successful; otherwise, the update is not performed.

      In this case, a recommendation about viewing with a rating of more than 9 is added to the record.
   1. Run the program:

      ```bash
      ruby SeriesItemOps05.rb
      ```

      Result:

      ```text
      Updating table 'Series' with information about 'Supernatural (3)'...
      Error updating record: Condition not satisfied
      Couldn't update table.
      ```

      Error completing the operation: the movie's rating is 9 and the condition checks the rating higher than 9.

      Modify the code so that the condition is 9 or higher:

      ```ruby
      condition_expression: 'info.rating >= :num',
      ```

      Run the program again. Now the operation is successful:

      ```text
      Updating table 'Series' with information about 'Supernatural (3)'...
      Record updated with 'info' attributes:
      rating: 9.0
      release_date: 2005-09-13
      series_info: Supernatural is an American television series created by Eric Kripke
      recommend: Recommended for viewing
      Table updated.
      ```

{% endlist %}