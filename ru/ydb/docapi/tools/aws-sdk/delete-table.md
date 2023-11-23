---
title: "Как удалить таблицу в {{ ydb-full-name }}"
description: "Следуя данной инструкции, вы сможете удалить таблицу."
sourcePath: overlay/quickstart/document-api/aws-sdk/delete-table.md
---
# Удаление таблицы

Чтобы удалить таблицу `Series`:

{% list tabs %}

- Java

  1. Создайте проект `SeriesDeleteTable`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
        -DartifactId=SeriesDeleteTable
      ```

      В результате выполнения команды в текущем рабочем каталоге будет создан каталог проекта с именем `SeriesDeleteTable`, структурой подкаталогов и файлом описания проекта `pom.xml`.
  
  1. Перейдите в каталог проекта:

      ```bash
      cd SeriesDeleteTable
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

      Посмотрите актуальные версии [junit](https://mvnrepository.com/artifact/junit/junit) и [aws-java-sdk-dynamodb](https://mvnrepository.com/artifact/com.amazonaws/aws-java-sdk-dynamodb).

  1. В каталоге `src/main/java/com/mycompany/app/` создайте файл `SeriesDeleteTable.java`, например с помощью редактора nano:
  
      ```bash
      nano src/main/java/com/mycompany/app/SeriesDeleteTable.java
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
      import com.amazonaws.services.dynamodbv2.document.Table;

      public class SeriesDeleteTable {

          public static void main(String[] args) throws Exception {

              AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document_API_эндпоинт>", "{{ region-id }}"))
                  .build();

              DynamoDB dynamoDB = new DynamoDB(client);

              Table table = dynamoDB.getTable("Series");

              try {
                  System.out.println("Попытка удаления таблицы, подождите...");
                  table.delete();
                  table.waitForDelete();
                  System.out.print("Таблица Series удалена.");

              }
              catch (Exception e) {
                  System.err.println("Невозможно удалить таблицу: ");
                  System.err.println(e.getMessage());
              }

          }
      }
      ```

  1. Соберите проект:

      ```bash
      mvn package
      ```

      В результате выполнения команды в каталоге `target/release/` будет сгенерирован файл `SeriesDeleteTable.jar`.

  1. Запустите приложение:

      ```bash
      java -jar target/release/SeriesDeleteTable.jar
      ```

      Результат:

      ```text
      Попытка удаления таблицы, подождите...
      Таблица Series удалена.
      ```

- Python

  1. Создайте файл `SeriesDeleteTable.py`, например с помощью редактора nano:
  
      ```bash
      nano SeriesDeleteTable.py
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      import boto3

      def delete_serie_table():
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document_API_эндпоинт>")

          table = ydb_docapi_client.Table('Series')
          table.delete()

      if __name__ == '__main__':
          delete_serie_table()
          print("Таблица Series удалена")
      ```

  1. Запустите программу:

      ```bash
      python SeriesDeleteTable.py
      ```

      Результат:

      ```text
      Таблица Series удалена
      ```

- PHP

  1. Создайте файл `SeriesDeleteTable.php`, например с помощью редактора nano:
  
      ```bash
      nano SeriesDeleteTable.php
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

      $sdk = new Aws\Sdk([
          'endpoint' => '<Document_API_эндпоинт>',
          'region'   => '{{ region-id }}',
          'version'  => 'latest'
      ]);

      $dynamodb = $sdk->createDynamoDb();

      $params = [
          'TableName' => 'Series'
      ];

      try {
          $result = $dynamodb->deleteTable($params);
          echo "Таблица удалена.\n";

      } catch (DynamoDbException $e) {
          echo "Невозможно удалить таблицу:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

  1. Запустите программу:

      ```bash
      php SeriesDeleteTable.php
      ```

      Результат:

      ```txt
      Таблица удалена.
      ```

- Node.js

  1. Создайте файл `SeriesDeleteTable.js`, например с помощью редактора nano:
  
      ```bash
      nano SeriesDeleteTable.js
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```javascript
      const AWS = require("@aws-sdk/client-dynamodb");

      // Credentials should be defined via environment variables AWS_SECRET_ACCESS_KEY and AWS_ACCESS_KEY_ID
      const dynamodb = new AWS.DynamoDBClient({
          region: "{{ region-id }}",
          endpoint: "<Document_API_эндпоинт>",
      });

      dynamodb.send(new AWS.DeleteTableCommand({
          TableName: "Series"
      }))
          .then(data => {
              console.error("Не удалось удалить таблицу. Ошибка JSON:", JSON.stringify(err, null, 2));
          })
          .catch(err => {
              console.log("Таблица удалена. Описание таблицы JSON:", JSON.stringify(data, null, 2));
          })
      ```
  
  1. Запустите программу:

      ```bash
      node SeriesDeleteTable.js
      ```

      Результат:

      ```text
      Таблица удалена. Описание таблицы JSON: {
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

  1. Создайте файл `SeriesDeleteTable.rb`, например с помощью редактора nano:
  
      ```bash
      nano SeriesDeleteTable.rb
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'

      def table_deleted?(dynamodb_client, table_name)
        dynamodb_client.delete_table(table_name: table_name)
        true
      rescue StandardError => e
        puts "Ошибка удаления таблицы: #{e.message}"
        false
      end

      def run_me
        region = '{{ region-id }}'
        table_name = 'Series'

        Aws.config.update(
          endpoint: '<Document_API_эндпоинт>',
          region: region
        )

        dynamodb_client = Aws::DynamoDB::Client.new

        puts "Удаление таблицы '#{table_name}'..."

        if table_deleted?(dynamodb_client, table_name)
          puts 'Таблица удалена.'
        else
          puts 'Не удалось удалить таблицу.'
        end
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

  1. Запустите программу:

     ```bash
     ruby SeriesDeleteTable.rb
     ```

     Результат:

     ```text
     Удаление таблицы 'Series'...
     Таблица удалена.
     ```

{% endlist %}
