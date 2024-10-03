---
title: Как удалить запись в {{ ydb-full-name }}
description: Следуя данной инструкции, вы сможете удалить запись.
sourcePath: overlay/quickstart/document-api/aws-sdk/delete-item.md
---
# Удаление записи

Чтобы удалить с условием запись в таблице `Series`:

{% list tabs group=programming_language %}

- Java {#java}

  1. Создайте проект `SeriesItemOps06`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
        -DartifactId=SeriesItemOps06
      ```

      В результате выполнения команды в текущем рабочем каталоге будет создан каталог проекта с именем `SeriesItemOps06`, структурой подкаталогов и файлом описания проекта `pom.xml`.
  
  1. Перейдите в каталог проекта:

      ```bash
      cd SeriesItemOps06
      ```

  1. Отредактируйте описание проекта в файле `pom.xml`, например с помощью редактора nano:

      ```bash
      nano pom.xml
      ```

      Пример файла `pom.xml`:

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

      Посмотрите актуальные версии [junit](https://mvnrepository.com/artifact/junit/junit) и [aws-java-sdk-dynamodb](https://mvnrepository.com/artifact/com.amazonaws/aws-java-sdk-dynamodb).

  1. В каталоге `src/main/java/com/mycompany/app/` создайте файл `SeriesItemOps06.java`, например с помощью редактора nano:
  
      ```bash
      nano src/main/java/com/mycompany/app/SeriesItemOps06.java
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

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
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document_API_эндпоинт>", "{{ region-id }}"))
                  .build();

              DynamoDB dynamoDB = new DynamoDB(client);

              Table table = dynamoDB.getTable("Series");

              int series_id = 3;
              String title = "Supernatural";

              DeleteItemSpec deleteItemSpec = new DeleteItemSpec()
                  .withPrimaryKey(new PrimaryKey("series_id", series_id, "title", title)).withConditionExpression("info.rating <= :val")
                  .withValueMap(new ValueMap().withNumber(":val", 5));

              try {
                  System.out.println("Попытка удаления записи...");
                  table.deleteItem(deleteItemSpec);
                  System.out.println("Данные о сериале удалены.");
              }
              catch (Exception e) {
                  System.err.println("Невозможно удалить запись: " + series_id + " " + title);
                  System.err.println(e.getMessage());
              }
    
          }
      }
      ```

      Этот код удалит запись о фильме, если его рейтинг равен или менее 5.

      Вы можете использовать метод `deleteItem` для удаления одной записи, указав ее первичный ключ. Также можно дополнительно указать `ConditionExpression`, чтобы предотвратить удаление элемента, если это условие не выполняется.

  1. Соберите проект:

      ```bash
      mvn package
      ```

      В результате выполнения команды в каталоге `target/release/` будет сгенерирован файл `SeriesItemOps06.jar`.

  1. Запустите приложение:

      ```bash
      java -jar target/release/SeriesItemOps06.jar
      ```

      Результат:

      ```text
      Попытка удаления записи...
      Невозможно удалить запись: 3 Supernatural
      Condition not satisfied (Service: AmazonDynamoDBv2; Status Code: 400; Error Code: ConditionalCheckFailedException; Request ID: null; Proxy: null)
      ```

      Операция завершилась с ошибкой: рейтинг фильма больше 5.

      Измените код, удалив условие в `DeleteItemSpec`:

      ```java
      DeleteItemSpec deleteItemSpec = new DeleteItemSpec()
          .withPrimaryKey(new PrimaryKey("series_id", series_id, "title", title));
      ```

      Повторите сборку проекта и запустите приложение:

      ```bash
      mvn package && java -jar target/release/SeriesItemOps06.jar
      ```

      Теперь операция успешна:

      ```text
      Попытка удаления записи...
      Данные о сериале удалены.
      ```

- Python {#python}

  1. Создайте файл `SeriesItemOps06.py`, например с помощью редактора nano:
  
      ```bash
      nano SeriesItemOps06.py
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      from decimal import Decimal
      from pprint import pprint
      import boto3
      from botocore.exceptions import ClientError

      def delete_underrated_serie(title, series_id, rating):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document_API_эндпоинт>")

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
          print("Попытка удаления записи...")
          delete_response = delete_underrated_serie("Supernatural", 3, 5)
          if delete_response:
              print("Данные о сериале удалены:")
              pprint(delete_response, sort_dicts = False)
      ```

      Приведенный код удаляет запись, если рейтинг сериала меньше или равен 5.

      Для удаления записи используется метод `delete_item`, в котором нужно передать атрибуты первичного ключа нужной записи. При необходимости вы можете задать условие для удаления записи, указав параметр `ConditionExpression`.

  1. Запустите программу:

      ```bash
      python SeriesItemOps06.py
      ```

      Результат:

      ```text
      Попытка удаления записи...
      Condition not satisfied
      ```

      Операция завершилась с ошибкой: рейтинг фильма больше 5.

  1. Измените код, удалив условие:

      ```python
      response = table.delete_item(
          Key = {
              'series_id': series_id,
              'title': title
          }
      )
      ```

  1. Запустите программу еще раз. Теперь операция удаления должна завершиться успешно.

      Результат:

      ```text
      Попытка удаления записи...
      Данные о сериале удалены:
      {'ResponseMetadata': {'HTTPStatusCode': 200,
                            'HTTPHeaders': {'content-type': 'application/x-amz-json-1.0',
                                            'x-amz-crc32': '2745614147',
                                            'x-request-id': '786fed1d-3c71-4fee-9827-f3f28da0493e',
                                            'date': 'Wed, 13 Jan 2021 11:04:13 GMT',
                                            'content-length': '2'},
                            'RetryAttempts': 0}}
      ```

- PHP {#php}

  1. Создайте файл `SeriesItemOps06.php`, например с помощью редактора nano:
  
      ```bash
      nano SeriesItemOps06.php
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```php
      <?php

      require 'vendor/autoload.php';

      date_default_timezone_set('UTC');

      use Aws\DynamoDb\Exception\DynamoDbException;
      use Aws\DynamoDb\Marshaler;

      $sdk = new Aws\Sdk([
          'endpoint' => '<Document_API_эндпоинт>',
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
          echo "Запись удалена.\n";

      } catch (DynamoDbException $e) {
          echo "Невозможно удалить запись:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

      Вы можете использовать метод `deleteItem` для удаления одной записи, указав ее первичный ключ. Также можно дополнительно указать `ConditionExpression`, чтобы предотвратить удаление элемента, если это условие не выполняется.

      Этот код удалит запись о фильме, если его рейтинг равен или менее 5.

  1. Запустите программу:

      ```bash
      php SeriesItemOps06.php
      ```

      Результат:

      ```text
      Невозможно удалить запись:
      ...
      ConditionalCheckFailedException (client): Condition not satisfied
      ...
      ```

      Операция завершилась с ошибкой: рейтинг фильма больше 5.

      Измените код, удалив условие:

      ```php
      $params = [
          'TableName' => $tableName,
          'Key' => $key
      ]; 
      ```

      Запустите программу еще раз. Теперь операция успешна:

      ```text
      Запись удалена.
      ```

- Node.js {#node}

  1. Создайте файл `SeriesItemOps06.js`, например с помощью редактора nano:

      ```bash
      nano SeriesItemOps06.js
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```javascript
      const AWS = require("@aws-sdk/client-dynamodb");
      const { marshall } = require("@aws-sdk/util-dynamodb");

      // Credentials should be defined via environment variables AWS_SECRET_ACCESS_KEY and AWS_ACCESS_KEY_ID
      const dynamodb = new AWS.DynamoDBClient({
          region: "{{ region-id }}",
          endpoint: "<Document_API_эндпоинт>",
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

      console.log("Выполнение удаления с условием...");

      dynamodb.send(new AWS.DeleteItemCommand(params))
          .then(data => {
              console.log("Удаление выполнено:", JSON.stringify(data, null, 2));
          })
          .catch(err => {
              console.error("Не удалось удалить запись. Ошибка JSON:", JSON.stringify(err, null, 2));
              process.exit(1);
          })
      ```

      Удалить одиночную запись, указав ее первичный ключ, можно с помощью команды `DeleteItemCommand`. При необходимости можно указать выражение `ConditionExpression`, чтобы предотвратить удаление элемента, если это условие не выполняется.

  1. Запустите программу:

      ```bash
      node SeriesItemOps06.js
      ```

      Результат:

      ```text
      Выполнение удаления с условием...
      Не удалось удалить запись. Ошибка JSON: {
        "message": "Condition not satisfied",
        "code": "ConditionalCheckFailedException",
        "time": "2021-06-14T20:33:29.115Z",
        "statusCode": 400,
        "retryable": false,
        "retryDelay": 20.94065998018778
      }
      ```

      Операция завершилась с ошибкой: рейтинг фильма меньше 10.

      Измените код, удалив условие:

      ```javascript
      const params = {
          TableName: table,
          Key: marshall({
              "series_id": series_id,
              "title": title
          }),
      };
      ```

      Запустите программу еще раз. Теперь операция успешна:

      ```text
      Выполнение удаления с условием...
      Удаление выполнено: {}
      ```

- Ruby {#ruby}

  1. Создайте файл `SeriesItemOps06.rb`, например с помощью редактора nano:

      ```bash
      nano SeriesItemOps06.rb
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'

      def table_item_deleted?(dynamodb_client, table_item)
        dynamodb_client.delete_item(table_item)
        true
      rescue StandardError => e
        puts "Ошибка удаления записи: #{e.message}"
        false
      end

      def run_me
        region = '{{ region-id }}'
        table_name = 'Series'
        title = 'Supernatural'
        series_id = 3

        Aws.config.update(
          endpoint: '<Document_API_эндпоинт>',
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

        puts "Удаление сериала '#{title} (#{series_id})' из таблицы '#{table_name}', при выполнении заданного условия."

        if table_item_deleted?(dynamodb_client, table_item)
          puts 'Запись удалена.'
        else
          puts 'Не удалось удалить запись.'
        end
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

      Удалить одиночную запись, указав ее первичный ключ, можно с помощью метода `delete`. При необходимости можно указать выражение `ConditionExpression`, чтобы предотвратить удаление элемента, если это условие не выполняется.

  1. Запустите программу:

      ```bash
      ruby SeriesItemOps06.rb
      ```

      Результат:

      ```text
      Удаление сериала 'Supernatural (3)' из таблицы 'Series', при выполнении заданного условия.
      Ошибка удаления записи: Condition not satisfied
      Не удалось удалить запись.
      ```

      Операция завершилась с ошибкой: рейтинг фильма равен 9.

      Измените код, удалив условие:

      ```ruby
      table_item = {
        table_name: table_name,
        key: {
          series_id: series_id,
          title: title
        }
      }
      ```

      Запустите программу еще раз. Теперь операция успешна:

      ```text
      Удаление сериала 'Supernatural (3)' из таблицы 'Series', при выполнении заданного условия.
      Запись удалена.
      ```

{% endlist %}
