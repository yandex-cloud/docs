---
sourcePath: overlay/quickstart/document-api/aws-sdk/query-and-scan.md
---
# Searching and extracting data

To search for data in the table, use the `query` method that transmits the primary key of the relevant item. For a complex key, only the partition key is required and the sort key is optional.

The primary key of the `Series` table is compound and consists of the following attributes:

* `series_id`: Partition key (field type: number).
* `title`: Sort key (field type: string).

To find all series with the partition key equaling 3, you need to provide this value in the `query` method. You can also limit a selection by series title, specifying a condition for the sort key. For example, you can find series with the partition key 3 whose title starts with a T.

In addition to `query`, you can use the `scan` method to extract all tabular data. The `scan` method reads each record and returns all data in the table. You can use the filter to set criteria for the returned records but the filter is applied only after scanning the entire table.

## Search by partition key {#part-key-find}

To extract data using `query` from the `Series` table:

{% list tabs group=programming_language %}

- Java {#java}

  1. Create the `SeriesQuery01` project:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
        -DartifactId=SeriesQuery01
      ```

      As a result of running the command, the system will create the `SeriesQuery01` project folder in the current working folder, with a subfolder structure and the `pom.xml` project description file.
  
  1. Go to the project folder:

      ```bash
      cd SeriesQuery01
      ```

  1. Edit the project description in the `pom.xml` file, for example, using the `nano` editor:

      ```bash
      nano pom.xml
      ```

      Example of the `pom.xml` file:

      ```xml
      <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
        <modelVersion>4.0.0</modelVersion>
        <groupId>com.mycompany.app</groupId>
        <artifactId>SeriesQuery01</artifactId>
        <packaging>jar</packaging>
        <version>1.0-SNAPSHOT</version>
        <name>SeriesQuery01</name>
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
                                <mainClass>com.mycompany.app.SeriesQuery01</mainClass>
                            </manifest>
                            <manifestEntries>
                                <Class-Path>.</Class-Path>
                            </manifestEntries>
                        </archive>
                        <finalName>release/SeriesQuery01</finalName>
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

  1. In the `src/main/java/com/mycompany/app/` folder, create the `SeriesQuery01.java` file, for example, using the `nano` editor:

      ```bash
      nano src/main/java/com/mycompany/app/SeriesQuery01.java
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the value you [prepared earlier](index.md#before-you-begin).

      {% endnote %}

      ```java
      package com.mycompany.app;

      import java.util.HashMap;
      import java.util.Iterator;

      import com.amazonaws.client.builder.AwsClientBuilder;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
      import com.amazonaws.services.dynamodbv2.document.DynamoDB;
      import com.amazonaws.services.dynamodbv2.document.Item;
      import com.amazonaws.services.dynamodbv2.document.ItemCollection;
      import com.amazonaws.services.dynamodbv2.document.QueryOutcome;
      import com.amazonaws.services.dynamodbv2.document.Table;
      import com.amazonaws.services.dynamodbv2.document.spec.QuerySpec;

      public class SeriesQuery01 {

          public static void main(String[] args) throws Exception {

              AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document_API_endpoint>", "{{ region-id }}"))
                  .build();

              DynamoDB dynamoDB = new DynamoDB(client);

              Table table = dynamoDB.getTable("Series");

              HashMap<String, Object> valueMap = new HashMap<String, Object>();
              valueMap.put(":sd", 3);

              QuerySpec querySpec = new QuerySpec().withKeyConditionExpression("series_id = :sd").withValueMap(valueMap);

              ItemCollection<QueryOutcome> items = null;
              Iterator<Item> iterator = null;
              Item item = null;

              try {
                  System.out.println("Series with id 3");
                  items = table.query(querySpec);

                  iterator = items.iterator();
                  while (iterator.hasNext()) {
                      item = iterator.next();
                      System.out.println(item.getNumber("series_id") + ": " + item.getString("title"));
                  }

              }
              catch (Exception e) {
                    System.err.println("Couldn't perform search");
                    System.err.println(e.getMessage());
              }

          }
      }
      ```

      This code extracts from the `Series` table all series with the partition key 3.

      {% note info %}

      `valueMap` is used for substituting values. This is required since you cannot use literals directly in expressions, including in `KeyConditionExpression`. The above code uses `:sd`.

      {% endnote %}

      First, you create the `querySpec` object, which describes query parameters, and then provide this object to the `query` method.

  1. Build the project:

      ```bash
      mvn package
      ```

      This command will create the `SeriesQuery01.jar` file in the `target/release/` folder.

  1. Run the application:

      ```bash
      java -jar target/release/SeriesQuery01.jar
      ```

      Result:

      ```text
      Series with id 3
      3: House of Cards
      3: The Office
      3: True Detective
      ```

- Python {#python}

  1. Create the `SeriesQuery01.py` file, for example, using the `nano` editor:

      ```bash
      nano SeriesQuery01.py
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the value you [prepared earlier](index.md#before-you-begin).

      {% endnote %}

      ```python
      import boto3
      from boto3.dynamodb.conditions import Key

      def query_series(series_id):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document_API_endpoint>")

          table = ydb_docapi_client.Table('Series')
          response = table.query(
              KeyConditionExpression = Key('series_id').eq(series_id)
          )
          return response['Items']

      if __name__ == '__main__':
          query_id = 3
          print(f"Series with id = {query_id}")
          series = query_series(query_id)
          for serie in series:
              print(serie['series_id'], ":", serie['title'])
      ```

      This code extracts from the `Series` table all series with the partition key 3.

      The Boto 3 SDK creates the `ConditionExpression` parameter for you when you use the `Key` and `Attr` functions imported from `boto3.dynamodb.conditions`. You can also specify the value of `ConditionExpression` as a string.

  1. Run the program:

      ```bash
      python SeriesQuery01.py
      ```

      Result:

      ```text
      Series with id = 3
      3 : House of Cards
      3 : The Office
      3 : True Detective
      ```

- PHP {#php}

  1. Create the `SeriesQuery01.php` file, for example, using the `nano` editor:

      ```bash
      nano SeriesQuery01.php
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the value you [prepared earlier](index.md#before-you-begin).

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

      $eav = $marshaler->marshalJson('
          {
              ":sd": 3
          }
      ');

      $params = [
          'TableName' => $tableName,
          'KeyConditionExpression' => 'series_id = :sd',
          'ExpressionAttributeValues'=> $eav
      ];

      echo "Series with id 3\n";

      try {
          $result = $dynamodb->query($params);

          echo "Search completed.\n";

          foreach ($result['Items'] as $movie) {
              echo $marshaler->unmarshalValue($movie['series_id']) . ': ' .
                  $marshaler->unmarshalValue($movie['title']) . "\n";
          }

      } catch (DynamoDbException $e) {
          echo "Couldn't scan:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

      This code extracts from the `Series` table all series with the partition key 3.

      {% note info %}

      `ExpressionAttributeValues` is used for substituting values. This is required since you cannot use literals directly in expressions, including in `KeyConditionExpression`. The above code uses `:sd`.

      {% endnote %}

  1. Run the program:

      ```bash
      php SeriesQuery01.php
      ```

      Result:

      ```text
      Series with id 3
      Search completed.
      3: House of Cards
      3: The Office
      3: True Detective
      ```

- Node.js {#node}

  1. Create the `SeriesQuery01.js` file, for example, using the `nano` editor:

      ```bash
      nano SeriesQuery01.js
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the value you [prepared earlier](index.md#before-you-begin).

      {% endnote %}

      ```javascript
      const AWS = require("@aws-sdk/client-dynamodb");
      const { marshall } = require("@aws-sdk/util-dynamodb");

      // Credentials should be defined via environment variables AWS_SECRET_ACCESS_KEY and AWS_ACCESS_KEY_ID
      const dynamodb = new AWS.DynamoDBClient({
          region: "{{ region-id }}",
          endpoint: "<Document_API_endpoint>",
      });

      console.log("Searching for movies with partition key 3. 3.");

      const params = {
          TableName : "Series",
          KeyConditionExpression: "series_id = :val",
          ExpressionAttributeValues: marshall({
              ":val": 3
          }),
      };

      dynamodb.send(new AWS.QueryCommand(params))
          .then(data => {
              console.log("Request completed successfully:");
              data.Items.forEach(function(item) {
                  console.log(" -", item.series_id + ": " + item.title);
              });
          })
          .catch(err => {
              console.error("Couldn't complete request. Error:", JSON.stringify(err, null, 2));
          });
      ```

      This code extracts from the `Series` table all series with the partition key 3.

  1. Run the program:

      ```bash
      node SeriesQuery01.js
      ```

      Result:

      ```text
      Searching for movies with partition key 3.
      Query completed successfully:
      - 3: House of Cards
      - 3: The Office
      - 3: True Detective
      ```

- Ruby {#ruby}

  1. Create the `SeriesQuery01.rb` file, for example, using the `nano` editor:

      ```bash
      nano SeriesQuery01.rb
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the value you [prepared earlier](index.md#before-you-begin).

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'

      def query_for_items_from_table(dynamodb_client, query_condition)
        result = dynamodb_client.query(query_condition)
        if result.items.count.zero?
          puts 'No results found.'
        else
          puts "#{result.items.count} records found:"
          result.items.each do |movie|
            puts "#{movie['title']} (#{movie['series_id'].to_i})"
          end
        end
      rescue StandardError => e
        puts "Error getting elements from table: #{e.message}"
      end

      def run_me
        region = '{{ region-id }}'
        table_name = 'Series'
        series_id = 3

        Aws.config.update(
          endpoint: '<Document_API_endpoint>',
          region: region
        )

        dynamodb_client = Aws::DynamoDB::Client.new
        query_condition = {
          table_name: table_name,
          key_condition_expression: 'series_id = :val',
          expression_attribute_values: {
            ':val' => 3
          }
        }

        puts "Searching for movies with partition key '#{series_id}' in table' #{table_name}'..."

        query_for_items_from_table(dynamodb_client, query_condition)
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

      This code extracts from the `Series` table all series with the partition key 3.

  1. Run the program:

      ```bash
      ruby SeriesQuery01.rb
      ```

      Result:

      ```text
      Searching for movies with partition key '3' in table 'Series'...
      3 records found:
      House of Cards (3)
      The Office (3)
      True Detective (3)
      ```

{% endlist %}

## Searching by partition and sort keys {#part-sort-key-find}

To find a series with the partition key 3 and the title starting with a `T` in the `Series` table:

{% list tabs group=programming_language %}

- Java {#java}

  1. Create the `SeriesQuery02` project:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
        -DartifactId=SeriesQuery02
      ```

      As a result of running the command, the system will create the `SeriesQuery02` project folder in the current working folder, with a subfolder structure and the `pom.xml` project description file.

  1. Go to the project folder:

      ```bash
      cd SeriesQuery02
      ```

  1. Edit the project description in the `pom.xml` file, for example, using `nano`:

      ```bash
      nano pom.xml
      ```

      Example of the `pom.xml` file:

      ```xml
      <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
        <modelVersion>4.0.0</modelVersion>
        <groupId>com.mycompany.app</groupId>
        <artifactId>SeriesQuery02</artifactId>
        <packaging>jar</packaging>
        <version>1.0-SNAPSHOT</version>
        <name>SeriesQuery02</name>
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
                                <mainClass>com.mycompany.app.SeriesQuery02</mainClass>
                            </manifest>
                            <manifestEntries>
                                <Class-Path>.</Class-Path>
                            </manifestEntries>
                        </archive>
                        <finalName>release/SeriesQuery02</finalName>
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

  1. In the `src/main/java/com/mycompany/app/` folder, create the `SeriesQuery02.java` file, for example, using the `nano` editor:

      ```bash
      nano src/main/java/com/mycompany/app/SeriesQuery02.java
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the value you [prepared earlier](index.md#before-you-begin).

      {% endnote %}

      ```java
      package com.mycompany.app;

      import java.util.HashMap;
      import java.util.Iterator;

      import com.amazonaws.client.builder.AwsClientBuilder;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
      import com.amazonaws.services.dynamodbv2.document.DynamoDB;
      import com.amazonaws.services.dynamodbv2.document.Item;
      import com.amazonaws.services.dynamodbv2.document.ItemCollection;
      import com.amazonaws.services.dynamodbv2.document.QueryOutcome;
      import com.amazonaws.services.dynamodbv2.document.Table;
      import com.amazonaws.services.dynamodbv2.document.spec.QuerySpec;

      public class SeriesQuery02 {

          public static void main(String[] args) throws Exception {

              AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document_API_endpoint>", "{{ region-id }}"))
                  .build();

              DynamoDB dynamoDB = new DynamoDB(client);

              Table table = dynamoDB.getTable("Series");

              ItemCollection<QueryOutcome> items = null;
              Iterator<Item> iterator = null;
              Item item = null;

              HashMap<String, Object> valueMap = new HashMap<String, Object>();
              valueMap.put(":sd", 3);
              valueMap.put(":letter", "T");

              QuerySpec querySpec = new QuerySpec().withProjectionExpression("series_id, title")
                  .withKeyConditionExpression("series_id = :sd and begins_with(title, :letter)")
                  .withValueMap(valueMap);

              try {
                  System.out.println("Series with id 3 and title starting with T:");
                  items = table.query(querySpec);

                  iterator = items.iterator();
                  while (iterator.hasNext()) {
                      item = iterator.next();
                      System.out.println(item.getNumber("series_id") + ": " + item.getString("title"));
                  }

              }
              catch (Exception e) {
                  System.err.println("Couldn't perform search");
                  System.err.println(e.getMessage());
              }

          }
      }
      ```

  1. Build the project:

      ```bash
      mvn package
      ```

      This command will create the `SeriesQuery02.jar` file in the `target/release/` folder.

  1. Run the application:

      ```bash
      java -jar target/release/SeriesQuery02.jar
      ```

      Result:

      ```text
      Series with id 3 and title starting with T:
      3: The Office
      3: True Detective
      ```

- Python {#python}

  1. Create the `SeriesQuery02.py` file, for example, using the `nano` editor:

      ```bash
      nano SeriesQuery02.py
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the value you [prepared earlier](index.md#before-you-begin).

      {% endnote %}

      ```python
      from pprint import pprint
      import boto3
      from boto3.dynamodb.conditions import Key

      def query_and_project_series(series_id, title_range):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document_API_endpoint>")

          table = ydb_docapi_client.Table('Series')

          response = table.query(
              ProjectionExpression = "series_id, title, info.release_date",
              KeyConditionExpression = Key('series_id').eq(series_id) & Key('title').begins_with(title_range)
          )
          return response['Items']

      if __name__ == '__main__':
          query_id = 3
          query_range = 'T'
          print(f"Series with id {query_id} and title starting with "
                f"{query_range}")
          series = query_and_project_series(query_id, query_range)
          for serie in series:
              print(f"\n{serie['series_id']} : {serie['title']}")
              pprint(serie['info'])
      ```

  1. Run the program:

      ```bash
      python SeriesQuery02.py
      ```

      Result:

      ```text
      Series with id 3 and title starting with T
      3 : The Office
      3 : True Detective
      ```

- PHP {#php}

  1. Create the `SeriesQuery02.php` file, for example, using the `nano` editor:

      ```bash
      nano SeriesQuery02.php
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the value you [prepared earlier](index.md#before-you-begin).

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

      $eav = $marshaler->marshalJson('
          {
              ":sd": 3,
              ":letter": "T"
          }
      ');

      $params = [
          'TableName' => $tableName,
          'ProjectionExpression' => 'series_id, title',
          'KeyConditionExpression' =>
              'series_id = :sd and begins_with(title, :letter)',
          'ExpressionAttributeValues'=> $eav
      ];

      echo "Series with id 3 and title starting with T:\n";

      try {
          $result = $dynamodb->query($params);

          echo "Search completed.\n";

          foreach ($result['Items'] as $i) {
              $movie = $marshaler->unmarshalItem($i);
              print $movie['series_id'] . ': ' . $movie['title'] . "\n";
          }

      } catch (DynamoDbException $e) {
          echo "Couldn't scan:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

  1. Run the program:

      ```bash
      php SeriesQuery02.php
      ```

      Result:

      ```text
      Series with id 3 and title starting with T:
      Search completed.
      3: The Office
      3: True Detective
      ```

- Node.js {#node}

  1. Create the `SeriesQuery02.js` file, for example, using the `nano` editor:

      ```bash
      nano SeriesQuery02.js
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the value you [prepared earlier](index.md#before-you-begin).

      {% endnote %}

      ```javascript
      var AWS = require("aws-sdk");

      AWS.config.update({
        region: "{{ region-id }}",
        endpoint: "<Document_API_endpoint>"
      });

      var docClient = new AWS.DynamoDB.DocumentClient();

      console.log("Series with id 3 and title starting with T:");

      var params = {
          TableName : "Series",
          ProjectionExpression: "#series_id, title",
          KeyConditionExpression: "#series_id = :series_id and begins_with(title,:letter)",
          ExpressionAttributeNames:{
              "#series_id": "series_id",
              "#letter": "letter"
          },
          ExpressionAttributeValues: {
              ":series_id": 3,
              ":letter": 'T'
          }
      };

      docClient.query(params, function(err, data) {
          if (err) {
              console.error("Couldn't complete request. Error:", JSON.stringify(err, null, 2));
          } else {
              console.log("Request completed successfully:");
              data.Items.forEach(function(item) {
                  console.log(" -", item.series_id + ": " + item.title);
              });
          }
      });
      ```

  1. Run the program:

      ```bash
      node SeriesQuery02.js
      ```

      Result:

      ```text
      Series with id 3 and title starting with T:
      Query completed successfully:
      - 3: The Office
      - 3: True Detective
      ```

- Ruby {#ruby}

  1. Create the `SeriesQuery02.rb` file, for example, using the `nano` editor:

      ```bash
      nano SeriesQuery02.rb
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the value you [prepared earlier](index.md#before-you-begin).

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'

      def query_for_items_from_table(dynamodb_client, query_condition)
        result = dynamodb_client.query(query_condition)
        if result.items.count.zero?
          puts 'No results found.'
        else
          puts "#{result.items.count} records found:"
          result.items.each do |movie|
            puts "#{movie['title']} (#{movie['series_id'].to_i}) "
          end
        end
      rescue StandardError => e
        puts "Error getting elements from table: #{e.message}"
      end

      def run_me
        region = '{{ region-id }}'
        table_name = 'Series'
        series_id = 3

        Aws.config.update(
          endpoint: '<Document_API_endpoint>',
          region: region
        )

        dynamodb_client = Aws::DynamoDB::Client.new
        query_condition = {
          table_name: table_name,
          key_condition_expression: 'series_id = :val and begins_with(title,:letter)',
          expression_attribute_values: {
            ':val' => 3,
            ':letter' => 'T'
          }
        }

        puts "Searching in table '#{table_name}' for series with id = '#{series_id}' and title starting with T"

        query_for_items_from_table(dynamodb_client, query_condition)
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

  1. Run the program:

      ```bash
      ruby SeriesQuery02.rb
      ```

      Result:

      ```text
      Searching in table 'Series' for series with id '3' and title starting with T
      2 records found:
      The Office (3)
      True Detective (3)
      ```

{% endlist %}

## Scanning {#scanning}

To extract data using `scan` from the `Series` table:

{% list tabs group=programming_language %}

- Java {#java}

  1. Create the `SeriesScan` project:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
        -DartifactId=SeriesScan
      ```

      As a result of running the command, the system will create the `SeriesScan` project folder in the current working folder, with a subfolder structure and the `pom.xml` project description file.

  1. Go to the project folder:

      ```bash
      cd SeriesScan
      ```

  1. Edit the project description in the `pom.xml` file, for example, using `nano`:

      ```bash
      nano pom.xml
      ```

      Example of the `pom.xml` file:

      ```xml
      <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
        <modelVersion>4.0.0</modelVersion>
        <groupId>com.mycompany.app</groupId>
        <artifactId>SeriesScan</artifactId>
        <packaging>jar</packaging>
        <version>1.0-SNAPSHOT</version>
        <name>SeriesScan</name>
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
                                <mainClass>com.mycompany.app.SeriesScan</mainClass>
                            </manifest>
                            <manifestEntries>
                                <Class-Path>.</Class-Path>
                            </manifestEntries>
                        </archive>
                        <finalName>release/SeriesScan</finalName>
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

  1. In the `src/main/java/com/mycompany/app/` folder, create the `SeriesScan.java` file, for example, using the `nano` editor:

      ```bash
      nano src/main/java/com/mycompany/app/SeriesScan.java
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the value you [prepared earlier](index.md#before-you-begin).

      {% endnote %}

      ```java
      package com.mycompany.app;

      import java.util.Iterator;

      import com.amazonaws.client.builder.AwsClientBuilder;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
      import com.amazonaws.services.dynamodbv2.document.DynamoDB;
      import com.amazonaws.services.dynamodbv2.document.Item;
      import com.amazonaws.services.dynamodbv2.document.ItemCollection;
      import com.amazonaws.services.dynamodbv2.document.ScanOutcome;
      import com.amazonaws.services.dynamodbv2.document.Table;
      import com.amazonaws.services.dynamodbv2.document.spec.ScanSpec;
      import com.amazonaws.services.dynamodbv2.document.utils.NameMap;
      import com.amazonaws.services.dynamodbv2.document.utils.ValueMap;

      public class SeriesScan {

          public static void main(String[] args) throws Exception {

              AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document_API_endpoint>", "{{ region-id }}"))
                  .build();

              DynamoDB dynamoDB = new DynamoDB(client);

              Table table = dynamoDB.getTable("Series");

              ScanSpec scanSpec = new ScanSpec().withProjectionExpression("series_id, title, info.release_date")
                  .withFilterExpression("series_id between :start_sd and :end_sd")
                  .withValueMap(new ValueMap().withNumber(":start_sd", 1).withNumber(":end_sd", 3));

              try {
                  ItemCollection<ScanOutcome> items = table.scan(scanSpec);

                  Iterator<Item> iter = items.iterator();
                  while (iter.hasNext()) {
                      Item item = iter.next();
                      System.out.println(item.toString());
                  }
              }
              catch (Exception e) {
                  System.err.println("Couldn't scan");
                  System.err.println(e.getMessage());
              }

          }
      }
      ```

      The above code scans the `Series` table and outputs series with the `series_id` attribute from 1 to 3. All other elements are discarded.

  1. Build the project:

      ```bash
      mvn package
      ```

      This command will create the `SeriesScan.jar` file in the `target/release/` folder.

  1. Run the application:

      ```bash
      java -jar target/release/SeriesScan.jar
      ```

      Result:

      ```text
      { Item: {title=House of Cards, series_id=3, info={release_date=2013-02-01T00:00:00Z}} }
      { Item: {title=The Office, series_id=3, info={release_date=2005-03-24T00:00:00Z}} }
      { Item: {title=True Detective, series_id=3, info={release_date=2014-01-12T00:00:00Z}} }
      { Item: {title=IT Crowd, series_id=1, info={release_date=2006-02-03T00:00:00Z}} }
      { Item: {title=Silicon Valley, series_id=2, info={release_date=2014-04-06T00:00:00Z}} }
      ```

- Python {#python}

  1. Create the `SeriesScan.py` file, for example, using the `nano` editor:

      ```bash
      nano SeriesScan.py
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the value you [prepared earlier](index.md#before-you-begin).

      {% endnote %}

      ```python
      from pprint import pprint
      import boto3
      from boto3.dynamodb.conditions import Key

      def scan_series(id_range, display_series):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document_API_endpoint>")

          table = ydb_docapi_client.Table('Series')
          scan_kwargs = {
              'FilterExpression': Key('series_id').between(*id_range),
              'ProjectionExpression': "series_id, title, info.release_date"
          }

          done = False
          start_key = None
          while not done:
              if start_key:
                  scan_kwargs['ExclusiveStartKey'] = start_key
              response = table.scan(**scan_kwargs)
              display_series(response.get('Items', []))
              start_key = response.get('LastEvaluatedKey', None)
              done = start_key is None

      if __name__ == '__main__':
          def print_series(series):
              for serie in series:
                  print(f"\n{serie['series_id']} : {serie['title']}")
                  pprint(serie['info'])

          query_range = (1, 3)
          print(f"Searching for series with id from {query_range[0]} to {query_range[1]}...")
          scan_series(query_range, print_series)
      ```

      The above code scans the `Series` table and outputs series with the `series_id` attribute from 1 to 3. All other elements are discarded.

      To filter the found data, you can specify selection conditions in the optional `FilterExpression` parameter.

      With every call, the `scan` method returns a subset of records, or page. Then, the `LastEvaluatedKey` value in the response is provided to the `scan` method through the `ExclusiveStartKey` parameter. When the last page is returned, the `LastEvaluatedKey` value is not included in the response.

  1. Run the program:

      ```bash
      python SeriesScan.py
      ```

      Result:

      ```text
      Searching for series with id from 1 to 3...

      3 : House of Cards
      {'release_date': '2013-02-01'}

      3 : The Office
      {'release_date': '2005-03-24'}

      3 : True Detective
      {'release_date': '2014-01-12'}

      1 : IT Crowd
      {'release_date': '2006-02-03'}

      2 : Silicon Valley
      {'release_date': '2014-04-06'}
      ```

- PHP {#php}

  1. Create the `SeriesScan.php` file, for example, using the `nano` editor:

      ```bash
      nano SeriesScan.php
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the value you [prepared earlier](index.md#before-you-begin).

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

      //Expression attribute values
      $eav = $marshaler->marshalJson('
          {
              ":start_sd": 1,
              ":end_sd": 3
          }
      ');

      $params = [
          'TableName' => 'Series',
          'ProjectionExpression' => 'series_id, title',
          'FilterExpression' => 'series_id between :start_sd and :end_sd',
          'ExpressionAttributeValues'=> $eav
      ];

      echo "Scanning the Series table.\n";

      try {
          while (true) {
              $result = $dynamodb->scan($params);

              foreach ($result['Items'] as $i) {
                  $movie = $marshaler->unmarshalItem($i);
                  echo $movie['series_id'] . ': ' . $movie['title'] . "\n";
              }

              if (isset($result['LastEvaluatedKey'])) {
                  $params['ExclusiveStartKey'] = $result['LastEvaluatedKey'];
              } else {
                  break;
              }
          }

      } catch (DynamoDbException $e) {
          echo "Couldn't scan:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

      The above code scans the `Series` table and outputs series with the `series_id` attribute from 1 to 3. All other elements are discarded.

  1. Run the program:

      ```bash
      php SeriesScan.php
      ```

      Result:

      ```text
      Scanning the Series table.
      3: House of Cards
      3: The Office
      3: True Detective
      1: IT Crowd
      2: Silicon Valley
      ```

- Node.js {#node}

  1. Create the `SeriesScan.js` file, for example, using the `nano` editor:

      ```bash
      nano SeriesScan.js
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the value you [prepared earlier](index.md#before-you-begin).

      {% endnote %}

      ```javascript
      var AWS = require("aws-sdk");

      AWS.config.update({
        region: "{{ region-id }}",
        endpoint: "<Document_API_endpoint>"
      });

      var docClient = new AWS.DynamoDB.DocumentClient();

      var params = {
          TableName: "Series",
          ProjectionExpression: "#sid, title, info.rating",
          FilterExpression: "#sid between :start_id and :end_id",
          ExpressionAttributeNames: {
              "#sid": "series_id",
          },
          ExpressionAttributeValues: {
                ":start_id": 1,
                ":end_id": 3
          }
      };

      console.log("Scanning the Series table");
      docClient.scan(params, onScan);

      function onScan(err, data) {
          if (err) {
              console.error("Couldn't scan table. JSON error:", JSON.stringify(err, null, 2));
          } else {
              console.log("Scan successful.");
              data.Items.forEach(function(series) {
                  console.log(
                      series.series_id + ": ",
                      series.title);
              });

              if (typeof data.LastEvaluatedKey != "undefined") {
                  console.log("Scanning next...");
                  params.ExclusiveStartKey = data.LastEvaluatedKey;
                  docClient.scan(params, onScan);
              }
          }
      }
      ```

      The above code scans the `Series` table and outputs series with the `series_id` attribute from 1 to 3. All other elements are discarded.

  1. Run the program:

      ```bash
      node SeriesScan.js
      ```

      Result:

      ```text
      Scanning the Series table
      Scan successful.
      3:  House of Cards
      3:  The Office
      3:  True Detective
      1:  IT Crowd
      2:  Silicon Valley
      Scanning next...
      Scan successful.
      ```

- Ruby {#ruby}

  1. Create the `SeriesScan.rb` file, for example, using the `nano` editor:

      ```bash
      nano SeriesScan.rb
      ```

      Copy the following code to the created file:

      {% note warning %}

      Instead of `<Document_API_endpoint>`, specify the value you [prepared earlier](index.md#before-you-begin).

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'

      def scan_for_items_from_table(dynamodb_client, scan_condition)
        loop do
          result = dynamodb_client.scan(scan_condition)

          if result.items.count.zero?
            puts 'No suitable series found (yet)...'
          else
            puts "No #{result.items.count} suitable series found (yet):"
            result.items.each do |movie|
              puts "#{movie["title"]} (#{movie["series_id"].to_i}), " \
                "Rating: #{movie["info"]["rating"].to_f}"
            end
          end

          break if result.last_evaluated_key.nil?

          puts "Still searching for series..."
          scan_condition[:exclusive_start_key] = result.last_evaluated_key
        end
        puts 'Search completed.'
      rescue StandardError => e
        puts "Scan error: #{e.message}"
      end

      def run_me
        region = '{{ region-id }}'
        table_name = 'Series'
        start_id = 1
        end_id = 3

        Aws.config.update(
          endpoint: '<Document_API_endpoint>',
          region: region
        )

        dynamodb_client = Aws::DynamoDB::Client.new

        scan_condition = {
          table_name: table_name,
          projection_expression: '#series_id, title, info.rating',
          filter_expression: '#series_id between :start_id and :end_id',
          expression_attribute_names: { '#series_id' => 'series_id' },
          expression_attribute_values: {
            ':start_id' => start_id,
            ':end_id' => end_id
          }
        }

        puts "Searching for series in table '#{table_name}' with id from #{start_id} to #{end_id}..."

        scan_for_items_from_table(dynamodb_client, scan_condition)
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

      The above code scans the `Series` table and outputs series with the `series_id` attribute from 1 to 3. All other elements are discarded.

  1. Run the program:

      ```bash
      ruby SeriesScan.rb
      ```

      Result:

      ```text
      Searching for series in table 'Series' with id from 1 to 3...
      5 suitable series found (so far):
      House of Cards (3), Rating: 0.0
      The Office (3), Rating: 0.0
      True Detective (3), Rating: 0.0
      IT Crowd (1), Rating: 0.0
      Silicon Valley (2), Rating: 0.0
      Still searching for series...
      No suitable series found (yet)...
      Search completed.
      ```

{% endlist %}
