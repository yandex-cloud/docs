---
sourcePath: overlay/quickstart/document-api/aws-sdk/create-table.md
---
# Создание таблицы в AWS SDK

Чтобы создать таблицу с именем `Series`, ключом партицирования `series_id` и ключом сортировки `title`:

{% list tabs %}

- Java

  1. Создайте проект `SeriesCreateTable`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=ru.yandex.cloud.samples \
        -DartifactId=SeriesCreateTable
      ```

      В результате выполнения команды в текущем рабочем каталоге будет создан каталог проекта с именем `SeriesCreateTable`, структурой подкаталогов и файлом описания проекта `pom.xml`.

  1. Перейдите в каталог проекта:

      ```bash
      cd SeriesCreateTable
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

      Посмотрите актуальные версии [junit](https://mvnrepository.com/artifact/junit/junit) и [aws-java-sdk-dynamodb](https://mvnrepository.com/artifact/com.amazonaws/aws-java-sdk-dynamodb).

  1. В каталоге `src/main/java/ru/yandex/cloud/samples/` создайте файл `SeriesCreateTable.java`, например с помощью редактора nano:
  
      ```bash
      nano src/main/java/ru/yandex/cloud/samples/SeriesCreateTable.java
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

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
                    .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API эндпоинт>", "ru-central1"))
                    .build();

              DynamoDB dynamoDB = new DynamoDB(client);

              String tableName = "Series";

              try {
                  System.out.println("Попытка создания таблицы, подождите...");
                    CreateTableRequest request = new CreateTableRequest();
                    request.setTableName(tableName);
                    request.setKeySchema(
                      Arrays.asList(new KeySchemaElement("series_id", KeyType.HASH), // Ключ партицирования
                          new KeySchemaElement("title", KeyType.RANGE)));
                    request.setAttributeDefinitions(
                      Arrays.asList(new AttributeDefinition("series_id", ScalarAttributeType.N),
                          new AttributeDefinition("title", ScalarAttributeType.S)));
                    Table table = dynamoDB.createTable(request);
                    table.waitForActive();
                    System.out.println("Статус таблицы: " + table.getDescription().getTableStatus());
              }
              catch (Exception e) {
                  System.err.println("Невозможно создать таблицу: ");
                  System.err.println(e.getMessage());
              }

          }
      }
      ```

  1. Соберите проект:

      ```bash
      mvn package
      ```

      В результате выполнения команды в каталоге `target/release/` будет сгенерирован файл `SeriesCreateTable.jar`.

  1. Запустите приложение:

      ```bash
      java -jar target/release/SeriesCreateTable.jar
      ```

      Результат:

      ```text
      Попытка создания таблицы, подождите...
      Статус таблицы: ACTIVE
      ```

- Python

  В коде ниже используется функция `print` из Python 3. Для использования этой функции в версиях Python 2.6 и старше добавьте в начало файла строку `from __future__ import print_function`.

  1. Создайте файл `SeriesCreateTable.py`, например с помощью редактора nano:

      ```bash
      nano SeriesCreateTable.py
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      import boto3

      def create_series_table():
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API эндпоинт>")

          table = ydb_docapi_client.create_table(
              TableName = 'Series', # Series — имя таблицы 
              KeySchema = [
                  {
                      'AttributeName': 'series_id',
                      'KeyType': 'HASH'  # Ключ партицирования
                  },
                  {
                      'AttributeName': 'title',
                      'KeyType': 'RANGE'  # Ключ сортировки
                  }
              ],
              AttributeDefinitions = [
                  {
                      'AttributeName': 'series_id',
                      'AttributeType': 'N'  # Целое число
                  },
                  {
                      'AttributeName': 'title',
                      'AttributeType': 'S'  # Строка
                  },

              ]
          )
          return table

      if __name__ == '__main__':
          series_table = create_series_table()
          print("Статус таблицы:", series_table.table_status)
      ```

  1. Запустите программу:

      ```bash
      python SeriesCreateTable.py
      ```

      Результат:

      ```text
      Статус таблицы: ACTIVE
      ```

- PHP

  1. Создайте файл `SeriesCreateTable.php`, например с помощью редактора nano:

      ```bash
      nano SeriesCreateTable.php
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```php
      <?php

      require 'vendor/autoload.php';

      date_default_timezone_set('UTC');

      use Aws\DynamoDb\Exception\DynamoDbException;

      $sdk = new Aws\Sdk([
          'endpoint' => '<Document API эндпоинт>',
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
          echo 'Статус таблицы: ' . 
              $result['TableDescription']['TableStatus'] ."\n";

      } catch (DynamoDbException $e) {
          echo "Невозможно создать таблицу:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

  1. Запустите программу:

      ```bash
      php SeriesCreateTable.php
      ```

      Результат:

      ```txt
      Статус таблицы: ACTIVE
      ```

- Node.js

  1. Создайте файл `SeriesCreateTable.js`, например с помощью редактора nano:

      ```bash
      nano SeriesCreateTable.js
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```javascript
      var AWS = require("aws-sdk");
      
      AWS.config.update({
        region: "ru-central1",
        endpoint: "<Document API эндпоинт>"
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
              console.error("Не удалось создать таблицу. Ошибка JSON:", JSON.stringify(err, null, 2));
              process.exit(1);
          } else {
              console.log("Таблица создана. Схема таблицы JSON:", JSON.stringify(data, null, 2));
          }
      });
      ```

  1. Запустите программу:

      ```bash
      node SeriesCreateTable.js
      ```

      Результат:

      ```text
      Таблица создана. Схема таблицы JSON: {
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

  1. Создайте файл `SeriesCreateTable.rb`, например с помощью редактора nano:

      ```bash
      nano SeriesCreateTable.rb
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}
  
      ```ruby
      require 'aws-sdk-dynamodb'
      
      def create_table(dynamodb_client, table_definition)
        response = dynamodb_client.create_table(table_definition)
        response.table_description.table_status
      rescue StandardError => e
        puts "Ошибка создания таблицы: #{e.message}"
        'Error'
      end
      
      def run_me
        region = 'ru-central1'
      
        Aws.config.update(
          endpoint: '<Document API эндпоинт>',
          region: region
        )
      
        dynamodb_client = Aws::DynamoDB::Client.new
      
        table_definition = {
          table_name: 'Series',
          key_schema: [
            {
              attribute_name: 'series_id',
              key_type: 'HASH'  # Ключ раздела.
            },
            {
              attribute_name: 'title',
              key_type: 'RANGE' # Ключ сортировки.
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
      
        puts "Создание таблицы 'Series'..."
        create_table_result = create_table(dynamodb_client, table_definition)
      
        if create_table_result == 'Ошибка'
          puts 'Не удалось создать таблицу.'
        else
          puts "Таблица создана. Статус: '#{create_table_result}'."
        end
      end
      
      run_me if $PROGRAM_NAME == __FILE__
      ```
  
  1. Запустите программу:

      ```bash
      ruby SeriesCreateTable.rb
      ```

      Результат:

      ```text
      Создание таблицы 'Series'...
      Таблица создана. Статус: 'ACTIVE'.
      ```

{% endlist %}
