# Добавление записи

Чтобы добавить новую запись в таблицу `Series`:  

{% list tabs %}

- Java
  
  1. Создайте проект `SeriesItemOps01`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=ru.yandex.cloud.samples \
        -DartifactId=SeriesItemOps01
      ```

      В результате выполнения команды в текущем рабочем каталоге будет создан каталог проекта с именем `SeriesItemOps01`, структурой подкаталогов и файлом описания проекта `pom.xml`.
  
  1. Перейдите в каталог проекта:

      ```bash
      cd SeriesItemOps01
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
        <artifactId>SeriesItemOps01</artifactId>
        <packaging>jar</packaging>
        <version>1.0-SNAPSHOT</version>
        <name>SeriesItemOps01</name>
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
                                <mainClass>ru.yandex.cloud.samples.SeriesItemOps01</mainClass>
                            </manifest>
                            <manifestEntries>
                                <Class-Path>.</Class-Path>
                            </manifestEntries>
                        </archive>
                        <finalName>release/SeriesItemOps01</finalName>
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

  1. В каталоге `src/main/java/ru/yandex/cloud/samples/` создайте файл `SeriesItemOps01.java`, например с помощью редактора nano:
  
      ```bash
      nano src/main/java/ru/yandex/cloud/samples/SeriesItemOps01.java
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```java
      package ru.yandex.cloud.samples;

      import java.util.HashMap;
      import java.util.Map;

      import com.amazonaws.client.builder.AwsClientBuilder;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
      import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
      import com.amazonaws.services.dynamodbv2.document.DynamoDB;
      import com.amazonaws.services.dynamodbv2.document.Item;
      import com.amazonaws.services.dynamodbv2.document.PutItemOutcome;
      import com.amazonaws.services.dynamodbv2.document.Table;

      public class SeriesItemOps01 {

          public static void main(String[] args) throws Exception {

              AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API эндпоинт>", "ru-central1"))
                  .build();

              DynamoDB dynamoDB = new DynamoDB(client);

              Table table = dynamoDB.getTable("Series");

              int series_id = 3;
              String title = "Supernatural";

              final Map<String, Object> infoMap = new HashMap<String, Object>();
              infoMap.put("release_date", "2015-09-13");
              infoMap.put("series_info", "Supernatural is an American television series created by Eric Kripke");

              try {
                  System.out.println("Добавление новой записи...");
                  PutItemOutcome outcome = table
                    .putItem(new Item().withPrimaryKey("series_id", series_id, "title", title).withMap("info", infoMap));

                  System.out.println("Сериал успешно добавлен:\n" + outcome.getPutItemResult());

              }
              catch (Exception e) {
                  System.err.println("Невозможно добавить запись: " + series_id + " " + title);
                  System.err.println(e.getMessage());
              }

          }
      }
      ```

      Этот код добавляет запись с первичным ключом (`series_id`, `title`) и дополнительной информацией в поле `info`. Первичный ключ обязателен.

  1. Соберите проект:

      ```bash
      mvn package
      ```

      В результате выполнения команды в каталоге `target/release/` будет сгенерирован файл `SeriesItemOps01.jar`.

  1. Запустите приложение:

      ```bash
      java -jar target/release/SeriesItemOps01.jar
      ```

      Результат выполнения:

      ```text
      Добавление новой записи...
      Сериал успешно добавлен:
      {}
      ```

- Python

  1. Создайте файл `SeriesItemOps01.py`, например с помощью редактора nano:
  
      ```bash
      nano SeriesItemOps01.py
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      from pprint import pprint
      import boto3

      def put_serie(series_id, title, release_date, series_info):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API эндпоинт>")

          table = ydb_docapi_client.Table('Series')
          response = table.put_item(
            Item = {
                  'series_id': series_id,
                  'title': title,
                  'info': {
                      'release_date': release_date,
                      'series_info': series_info
                  }
              }
          )
          return response

      if __name__ == '__main__':
          serie_resp = put_serie(3, "Supernatural", "2015-09-13",
                                "Supernatural is an American television series created by Eric Kripke")
          print("Сериал успешно добавлен:")
          pprint(serie_resp, sort_dicts = False)
      ```

      Этот код добавляет запись с первичным ключом (`series_id`, `title`) и дополнительной информацией в поле `info`. Первичный ключ обязателен.

  1. Запустите программу:

      ```bash
      python SeriesItemOps01.py
      ```

      Результат выполнения:

      ```text
      Сериал успешно добавлен:
      {'ResponseMetadata': {'HTTPStatusCode': 200,
                            'HTTPHeaders': {'content-type': 'application/x-amz-json-1.0',
                                            'x-amz-crc32': '2745614147',
                                            'x-request-id': '92a5fafe-169c-48e8-8071-4f8c8cca7004',
                                            'date': 'Sat, 26 Dec 2020 17:21:01 GMT',
                                            'content-length': '2'},
                            'RetryAttempts': 0}}
      ```

- PHP

  1. Создайте файл `SeriesItemOps01.php`, например с помощью редактора nano:
  
      ```bash
      nano SeriesItemOps01.php
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
      use Aws\DynamoDb\Marshaler;

      $sdk = new Aws\Sdk([
          'endpoint' => '<Document API эндпоинт>',
          'region'   => 'ru-central1',
          'version'  => 'latest'
      ]);

      $dynamodb = $sdk->createDynamoDb();
      $marshaler = new Marshaler();

      $tableName = 'Series';

      $series_id = 3;
      $title = 'Supernatural';

      $item = $marshaler->marshalJson('
          {
              "series_id": ' . $series_id . ',
              "title": "' . $title . '",
              "info": {
                  "release_date": "2015-09-13",
                  "series_info": "Supernatural is an American television series created by Eric Kripke"
              }
          }
      ');

      $params = [
          'TableName' => 'Series',
          'Item' => $item
      ];


      try {
          $result = $dynamodb->putItem($params);
          echo "Сериал успешно добавлен: $series_id - $title\n";

      } catch (DynamoDbException $e) {
          echo "Невозможно добавить запись:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

      Этот код добавляет запись с первичным ключом (`series_id`, `title`) и атрибутом `info`. Атрибут `info` содержит запись JSON с дополнительной информацию о фильме. Первичный ключ обязателен.

  1. Запустите программу:

      ```bash
      php SeriesItemOps01.php
      ```

      Результат выполнения:

      ```text
      Сериал успешно добавлен: 3 - Supernatural
      ```

{% endlist %}
