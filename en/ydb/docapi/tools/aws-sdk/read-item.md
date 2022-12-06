---
sourcePath: overlay/quickstart/document-api/aws-sdk/read-item.md
---
# Reading a record

To read a record from the `Series` table:

{% list tabs %}

- Java

   1. Create the `SeriesItemOps02` project:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
        -DartifactId=SeriesItemOps02
      ```

      As a result of running the command, the `SeriesItemOps02` project folder is created in the current working folder with a structure of subfolders and the `pom.xml` project description file.

   1. Go to the project folder:

      ```bash
      cd SeriesItemOps02
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
        <artifactId>SeriesItemOps02</artifactId>
        <packaging>jar</packaging>
        <version>1.0-SNAPSHOT</version>
        <name>SeriesItemOps02</name>
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
                                <mainClass>com.mycompany.app.SeriesItemOps02</mainClass>
                            </manifest>
                            <manifestEntries>
                                <Class-Path>.</Class-Path>
                            </manifestEntries>
                        </archive>
                        <finalName>release/SeriesItemOps02</finalName>
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

   1. In the folder `src/main/java/com/mycompany/app/`, create the `SeriesItemOps02.java` file, for example, using the nano editor:

      ```bash
      nano src/main/java/com/mycompany/app/SeriesItemOps02.java
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
      import com.amazonaws.services.dynamodbv2.document.Item;
      import com.amazonaws.services.dynamodbv2.document.Table;
      import com.amazonaws.services.dynamodbv2.document.spec.GetItemSpec;

      public class SeriesItemOps02 {

          public static void main(String[] args) throws Exception {

              AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API endpoint>", "{{ region-id }}"))
                  .build();

              DynamoDB dynamoDB = new DynamoDB(client);

              Table table = dynamoDB.getTable("Series");

              int series_id = 3;
              String title = "Supernatural";

              GetItemSpec spec = new GetItemSpec().withPrimaryKey("series_id", series_id, "title", title);

              try {
                  System.out.println("Attempting to obtain record...");
                  Item outcome = table.getItem(spec);
                  System.out.println("Record obtained: " + outcome);
              }
              catch (Exception e) {
                  System.err.println("Couldn't obtain record: " + series_id + " " + title);
                  System.err.println(e.getMessage());
              }

          }
      }
      ```

      To read a record by its primary key, the `getItem` method is used.

   1. Build a project:

      ```bash
      mvn package
      ```

      As a result of running the command, the `SeriesItemOps02.jar` file is generated in the folder `target/release/`.

   1. Run the application:

      ```bash
      java -jar target/release/SeriesItemOps02.jar
      ```

      Result:

      ```text
      Attempting to obtain record...
      Record obtained: { Item: {title=Supernatural, series_id=3, info={release_date=2015-09-13, series_info=Supernatural is an American television series created by Eric Kripke}} }
      ```

- Python

   1. Create the `SeriesItemOps02.py` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps02.py
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```python
      from pprint import pprint
      import boto3
      from botocore.exceptions import ClientError

      def get_serie(title, series_id):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API endpoint>")

          table = ydb_docapi_client.Table('Series')

          try:
              response = table.get_item(Key = {'series_id': series_id, 'title': title})
          except ClientError as e:
              print(e.response['Error']['Message'])
          else:
              return response['Item']

      if __name__ == '__main__':
          serie = get_serie("Supernatural", 3,)
          if serie:
              print("Record obtained:")
              pprint(serie, sort_dicts = False)
      ```

      To read a record from the table, use the `get_item` method that passes the primary key of the desired item.

   1. Run the program:

      ```bash
      python SeriesItemOps02.py
      ```

      Result:

      ```text
      Record obtained:
      {'series_id': Decimal('3'),
      'title': ' Supernatural,
      'info': {'release_date': 2015-09-13',
                'series_info': 'Supernatural is an American television series '
                              'created by Eric Kripke'}}
      ```

- PHP

   1. Create the `SeriesItemOps02.php` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps02.php
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

      $params = [
          'TableName' => $tableName,
          'Key' => $key
      ];

      try {
          $result = $dynamodb->getItem($params);
          echo json_encode($result["Item"], JSON_PRETTY_PRINT);

      } catch (DynamoDbException $e) {
          echo "Couldn't obtain record:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

      To read a record by its primary key, the `getItem` method is used.

   1. Run the program:

      ```bash
      php SeriesItemOps02.php
      ```

      Result:

      ```text
      {
          "series_id": {
              "N": ".3e1"
          },
          "title": {
              "S": "Supernatural"
          },
          "info": {
              "M": {
                  "release_date": {
                      "S": "2015-09-13"
                  },
                  "series_info": {
                      "S": "Supernatural is an American television series created by Eric Kripke"
                  }
              }
          }
      }
      ```

- Node.js

   1. Create the `SeriesItemOps02.js` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps02.js
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

      var docClient = new AWS.DynamoDB.DocumentClient();

      var table = "Series";

      var series_id = 3;
      var title = "Supernatural";

      var params = {
          TableName: table,
          Key:{
              "series_id": series_id,
              "title": title
          }
      };

      docClient.get(params, function(err, data) {
          if (err) {
              console.error("Couldn't read record. JSON error:", JSON.stringify(err, null, 2));
              process.exit(1);
          } else {
              console.log("Record read successfully:", JSON.stringify(data, null, 2));
          }
      });
      ```

      To read a record from the table, use the `get` method. By specifying the primary key values (`series_id` and `title`), you can read any record from the `Series` table.

   1. Run the program:

      ```bash
      node SeriesItemOps02.js
      ```

      Result:

      ```text
      Record read successfully: {
        "Item": {
          "series_id": 3,
          "title": "Supernatural",
          "info": {
            "series_info": "Supernatural is an American television series created by Eric Kripke",
            "release_date": "2015-09-13"
          }
        }
      }
      ```

- Ruby

   1. Create the `SeriesItemOps02.rb` file, for example, using the nano editor:

      ```bash
      nano SeriesItemOps02.rb
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document API endpoint>`, specify the [prepared](index.md#before-you-begin) value.

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'

      def get_item_from_table(dynamodb_client, table_item)
        result = dynamodb_client.get_item(table_item)
        puts "#{result.item['title']} (#{result.item['series_id'].to_i}):"
        puts "  Release date: #{result.item['info']['release_date']}"
        puts "  Series info: #{result.item['info']['series_info']}"
      rescue StandardError => e
        puts "Error obtaining series '#{table_item[:key][:title]} " \
              "(#{table_item[:key][:series_id]})': #{e.message}"
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
          }
        }

        puts "Getting information about '#{title} (#{series_id})' " \
          "from table '#{table_name}'..."
        get_item_from_table(dynamodb_client, table_item)
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

      To read a record from a table, use the `get_item` method, in which you can specify the primary key value (`series_id` and `title`) to read any record from the `Series` table.

   1. Run the program:

      ```bash
      ruby SeriesItemOps02.rb
      ```

      Result:

      ```text
      Getting information about 'Supernatural (3)' from table 'Series'...
      Supernatural (3):
        Release date: 2015-09-13
        Series info: Supernatural is an American television series created by Eric Kripke
      ```

{% endlist %}
