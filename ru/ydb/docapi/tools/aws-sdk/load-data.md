---
title: "Как загрузить данные в таблицу в {{ ydb-full-name }}"
description: "Следуя данной инструкции, вы сможете загрузить данные в таблицу."
sourcePath: overlay/quickstart/document-api/aws-sdk/load-data.md
---
# Загрузка данных в таблицу

В этом примере мы загрузим данные о сериалах из JSON-файла в заранее [созданную таблицу](./create-table.md). Для каждого сериала заданы идентификатор `series_id`, название `title`, а также дополнительная информация `info`. Структура JSON-файла c информацией о сериале:

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

Значения `series_id` и `title` используются в качестве первичного ключа таблицы `Series`.

Чтобы загрузить данные в таблицу `Series`:

{% list tabs %}

- Java

  1. Создайте проект `SeriesLoadData`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
        -DartifactId=SeriesLoadData
      ```

      В результате выполнения команды в текущем рабочем каталоге будет создан каталог проекта с именем `SeriesLoadData`, структурой подкаталогов и файлом описания проекта `pom.xml`.

  1. Перейдите в каталог проекта:

      ```bash
      cd SeriesLoadData
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

      Посмотрите актуальные версии [junit](https://mvnrepository.com/artifact/junit/junit) и [aws-java-sdk-dynamodb](https://mvnrepository.com/artifact/com.amazonaws/aws-java-sdk-dynamodb).

  1. В каталоге `src/main/java/com/mycompany/app/` создайте файл `SeriesLoadData.java`, например с помощью редактора nano:
  
      ```bash
      nano src/main/java/com/mycompany/app/SeriesLoadData.java
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

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
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document_API_эндпоинт>", "{{ region-id }}"))
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
                      System.out.println("Добавлен сериал: " + series_id + " " + title);

                  }
                  catch (Exception e) {
                      System.err.println("Невозможно загрузить данные: " + series_id + " " + title);
                      System.err.println(e.getMessage());
                      break;
                  }
              }
              parser.close();
          }
      }
      ```

      В коде используется библиотека с открытым исходным кодом Jackson для обработки JSON. Jackson включена в AWS SDK для Java.

  1. Соберите проект:

      ```bash
      mvn package
      ```

      В результате выполнения команды в каталоге `target/release/` будет сгенерирован файл `SeriesLoadData.jar`.

  1. {% include [seriesdata](../../../_includes/seriesdata.md) %}

  1. Запустите приложение:

      ```bash
      java -jar target/release/SeriesLoadData.jar
      ```

      Результат:

      ```text
      Добавлен сериал: 1 IT Crowd
      Добавлен сериал: 2 Silicon Valley
      Добавлен сериал: 3 House of Cards
      Добавлен сериал: 3 The Office
      Добавлен сериал: 3 True Detective
      Добавлен сериал: 4 The Big Bang Theory
      Добавлен сериал: 5 Twin Peaks
      ```

- Python

  1. Создайте файл `SeriesLoadData.py`, например с помощью редактора nano:
  
      ```bash
      nano SeriesLoadData.py
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      from decimal import Decimal
      import json
      import boto3

      def load_series(series):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document_API_эндпоинт>")

          table = ydb_docapi_client.Table('Series')
          for serie in series:
              series_id = int(serie['series_id'])
              title = serie['title']
              print("Добавлен сериал:", series_id, title)
              table.put_item(Item = serie)

      if __name__ == '__main__':
          with open("seriesdata.json") as json_file:
              serie_list = json.load(json_file, parse_float = Decimal)
          load_series(serie_list)
      ```

  1. {% include [seriesdata](../../../_includes/seriesdata.md) %}

  1. Запустите программу:

      ```bash
      python SeriesLoadData.py
      ```

      Результат:

      ```text
      Добавлен сериал: 1 IT Crowd
      Добавлен сериал: 2 Silicon Valley
      Добавлен сериал: 3 House of Cards
      Добавлен сериал: 3 The Office
      Добавлен сериал: 3 True Detective
      Добавлен сериал: 4 The Big Bang Theory
      Добавлен сериал: 5 Twin Peaks
      ```

- PHP

  1. Создайте файл `SeriesLoadData.php`, например с помощью редактора nano:
  
      ```bash
      nano SeriesLoadData.php
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
              echo "Добавлен сериал: " . $movie['series_id'] . " " . $movie['title'] . "\n";
          } catch (DynamoDbException $e) {
              echo "Невозможно загрузить данные:\n";
              echo $e->getMessage() . "\n";
              break;
          }

      }

      ?>
      ```

      Класс `Marshaler` включает методы преобразования JSON-документов и PHP-массивов в формат YDB. В этом коде `$marshaler->marshalJson($json)` принимает данные в формате JSON и преобразует их в запись YDB.

  1. {% include [seriesdata](../../../_includes/seriesdata.md) %}

  1. Запустите программу:

      ```bash
      php SeriesLoadData.php
      ```

      Результат:

      ```text
      Добавлен сериал: 1 IT Crowd
      Добавлен сериал: 2 Silicon Valley
      Добавлен сериал: 3 House of Cards
      Добавлен сериал: 3 The Office
      Добавлен сериал: 3 True Detective
      Добавлен сериал: 4 The Big Bang Theory
      Добавлен сериал: 5 Twin Peaks
      ```

- Node.js

  1. Создайте файл `SeriesLoadData.js`, например с помощью редактора nano:
  
      ```bash
      nano SeriesLoadData.js
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```javascript
      const AWS = require("@aws-sdk/client-dynamodb");
      const fs = require("fs")

      // Credentials should be defined via environment variables AWS_SECRET_ACCESS_KEY and AWS_ACCESS_KEY_ID
      const dynamodb = new AWS.DynamoDBClient({
          region: "{{ region-id }}",
          endpoint: "<Document_API_эндпоинт>",
      });

      console.log("Загрузка сериалов в YDB. Пожалуйста, подождите...");

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
                  console.log("Добавлен сериал:", series.title);
              })
              .catch(err => {
                  console.error("Невозможно добавить сериал", series.title, ". Error JSON:", JSON.stringify(err, null, 2));
              })
      });
      ```

  1. {% include [seriesdata](../../../_includes/seriesdata.md) %}

  1. Запустите программу:

      ```bash
      node SeriesLoadData.js
      ```

      Результат:

      ```bash
      Загрузка сериалов в YDB. Пожалуйста, подождите...
      Добавлен сериал: The Office
      Добавлен сериал: IT Crowd
      Добавлен сериал: House of Cards
      Добавлен сериал: The Big Bang Theory
      Добавлен сериал: Twin Peaks
      Добавлен сериал: Silicon Valley
      Добавлен сериал: True Detective
      ```

- Ruby

  1. Создайте файл `SeriesLoadData.rb`, например с помощью редактора nano:
  
      ```bash
      nano SeriesLoadData.rb
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'
      require 'json'
      
      $series_counter = 0
      $total_series = 0
      
      def add_item_to_table(dynamodb_client, table_item)
        dynamodb_client.put_item(table_item)
        $series_counter += 1
        puts "Загрузка сериала #{$series_counter}/#{$total_series}: " \
          "'#{table_item[:item]['title']} " \
          "(#{table_item[:item]['series_id']})'."
      rescue StandardError => e
        puts "Ошибка загрузки сериала '#{table_item[:item]['title']} " \
          "(#{table_item[:item]['series_id']})': #{e.message}"
        puts 'Программа остановлена.'
        exit 1
      end
      
      def run_me
        region = '{{ region-id }}'
        table_name = 'Series'
        data_file = 'seriesdata.json'
      
        Aws.config.update(
          endpoint: '<Document_API_эндпоинт>',
          region: region
        )
      
        dynamodb_client = Aws::DynamoDB::Client.new
        file = File.read(data_file)
        series = JSON.parse(file)
        $total_series = series.count
      
        puts "Будет загружено #{$total_series} сериалов из файла '#{data_file}' " \
          "в таблицу '#{table_name}'..."
      
        series.each do |seria|
          table_item = {
            table_name: table_name,
            item: seria
          }
          add_item_to_table(dynamodb_client, table_item)
        end
      
        puts 'Загрузка успешно выполнена.'
      end
      
      run_me if $PROGRAM_NAME == __FILE__
      ```
  
  1. {% include [seriesdata](../../../_includes/seriesdata.md) %}

  1. Запустите программу:

      ```bash
      ruby SeriesLoadData.rb
      ```

      Результат:

      ```text
      Будет загружено 7 сериалов из файла 'seriesdata.json' в таблицу 'Series'...
      Загрузка сериала 1/7: 'IT Crowd (1)'.
      Загрузка сериала 2/7: 'Silicon Valley (2)'.
      Загрузка сериала 3/7: 'House of Cards (3)'.
      Загрузка сериала 4/7: 'The Office (3)'.
      Загрузка сериала 5/7: 'True Detective (3)'.
      Загрузка сериала 6/7: 'The Big Bang Theory (4)'.
      Загрузка сериала 7/7: 'Twin Peaks (5)'.
      Загрузка успешно выполнена.
      ```

{% endlist %}
