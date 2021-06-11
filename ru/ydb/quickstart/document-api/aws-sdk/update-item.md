# Обновление записи

В этой инструкции описано, как внести изменения в уже существующую в таблице запись.

## Безусловное обновление {#update-item}

В следующем примере будет обновлено значение существующего атрибута `release_date` и добавлен новый атрибут `rating`.

Чтобы обновить запись о фильме в таблице `Series`:

{% list tabs %}

- Java

  1. Создайте проект `SeriesItemOps03`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=ru.yandex.cloud.samples \
        -DartifactId=SeriesItemOps03
      ```

      В результате выполнения команды в текущем рабочем каталоге будет создан каталог проекта с именем `SeriesItemOps03`, структурой подкаталогов и файлом описания проекта `pom.xml`.
  
  1. Перейдите в каталог проекта:

      ```bash
      cd SeriesItemOps03
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
                                <mainClass>ru.yandex.cloud.samples.SeriesItemOps03</mainClass>
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

      Посмотрите актуальные версии [junit](https://mvnrepository.com/artifact/junit/junit) и [aws-java-sdk-dynamodb](https://mvnrepository.com/artifact/com.amazonaws/aws-java-sdk-dynamodb).

  1. В каталоге `src/main/java/ru/yandex/cloud/samples/` создайте файл `SeriesItemOps03.java`, например с помощью редактора nano:
  
      ```bash
      nano src/main/java/ru/yandex/cloud/samples/SeriesItemOps03.java
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
      import com.amazonaws.services.dynamodbv2.document.UpdateItemOutcome;
      import com.amazonaws.services.dynamodbv2.document.spec.UpdateItemSpec;
      import com.amazonaws.services.dynamodbv2.document.utils.ValueMap;
      import com.amazonaws.services.dynamodbv2.model.ReturnValue;

      public class SeriesItemOps03 {

          public static void main(String[] args) throws Exception {

              AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API эндпоинт>", "ru-central1"))
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
                  System.out.println("Обновление записи...");
                  UpdateItemOutcome outcome = table.updateItem(updateItemSpec);
                  System.out.println("Данные о сериале обновлены:\n" + outcome.getItem().toJSONPretty());

              }
              catch (Exception e) {
                  System.err.println("Невозможно обновить запись: " + series_id + " " + title);
                  System.err.println(e.getMessage());
              }
          }
      }
      ```

      Добавить, обновить или удалить атрибуты для существующей записи можно методом `updateItem`.

      Этот код использует `UpdateExpression` для описания обновлений, которые нужно выполнить для указанной записи.

      Параметр `ReturnValues` предписывает {{ ydb-short-name }} возвращать только обновленные атрибуты (`UPDATED_NEW`).

  1. Соберите проект:

      ```bash
      mvn package
      ```

      В результате выполнения команды в каталоге `target/release/` будет сгенерирован файл `SeriesItemOps03.jar`.

  1. Запустите приложение:

      ```bash
      java -jar target/release/SeriesItemOps03.jar
      ```

      Результат выполнения:

      ```text
      Обновление записи...
      Данные о сериале обновлены:
      {
        "info" : {
          "release_date" : "2005-09-13",
          "rating" : 8,
          "series_info" : "Supernatural is an American television series created by Eric Kripke"
        }
      }
      ```

- Python

  1. Создайте файл `SeriesItemOps03.py`, например с помощью редактора nano:
  
      ```bash
      nano SeriesItemOps03.py
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      from decimal import Decimal
      from pprint import pprint
      import boto3

      def update_serie(title, series_id, release_date,  rating):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API эндпоинт>")

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
          print("Данные о сериале обновлены:")
          pprint(update_response, sort_dicts = False)
      ```

      Для обновления записи используется метод `update_item`. С помощью него можно обновить значения атрибутов, добавить или удалить атрибуты.

      В параметре `UpdateExpression` метода `update_item` передаются все обновления, которые применяются к указанной записи. Параметр `ReturnValues` указывает {{ ydb-short-name }} возвращать только обновленные атрибуты (`UPDATED_NEW`).

      В SDK Boto 3 для хранения числовых значений {{ ydb-short-name }} используется класс `Decimal`.

  1. Запустите программу:

      ```bash
      python SeriesItemOps03.py
      ```

      Результат выполнения:

      ```text
      Данные о сериале обновлены:
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

  1. Создайте файл `SeriesItemOps03.php`, например с помощью редактора nano:
  
      ```bash
      nano SeriesItemOps03.php
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
          echo "Запись обновлена.\n";
          echo json_encode($result["Attributes"], JSON_PRETTY_PRINT);

      } catch (DynamoDbException $e) {
          echo "Невозможно обновить запись:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

      Этот код использует `UpdateExpression` для описания обновлений, которые нужно выполнить для указанной записи.

      Параметр `ReturnValues` предписывает {{ ydb-short-name }} возвращать только обновленные атрибуты (`UPDATED_NEW`).

  1. Запустите программу:

      ```bash
      php SeriesItemOps03.php
      ```

      Результат выполнения:

      ```text
      Запись обновлена.
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

{% endlist %}

## Увеличение атомарного счетчика {#increment-ac}

{{ ydb-short-name }} поддерживает атомарные счетчики.

Чтобы увеличить атомарный счетчик `rating` для сериала:

{% list tabs %}

- Java

  1. Создайте проект `SeriesItemOps04`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=ru.yandex.cloud.samples \
        -DartifactId=SeriesItemOps04
      ```

      В результате выполнения команды в текущем рабочем каталоге будет создан каталог проекта с именем `SeriesItemOps04`, структурой подкаталогов и файлом описания проекта `pom.xml`.
  
  1. Перейдите в каталог проекта:

      ```bash
      cd SeriesItemOps04
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
                                <mainClass>ru.yandex.cloud.samples.SeriesItemOps04</mainClass>
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

      Посмотрите актуальные версии [junit](https://mvnrepository.com/artifact/junit/junit) и [aws-java-sdk-dynamodb](https://mvnrepository.com/artifact/com.amazonaws/aws-java-sdk-dynamodb).

  1. В каталоге `src/main/java/ru/yandex/cloud/samples/` создайте файл `SeriesItemOps04.java`, например с помощью редактора nano:
  
      ```bash
      nano src/main/java/ru/yandex/cloud/samples/SeriesItemOps04.java
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```java
      package ru.yandex.cloud.samples;

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
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API эндпоинт>", "ru-central1"))
                  .build();

              DynamoDB dynamoDB = new DynamoDB(client);

              Table table = dynamoDB.getTable("Series");

              int series_id = 3;
              String title = "Supernatural";

              UpdateItemSpec updateItemSpec = new UpdateItemSpec().withPrimaryKey("series_id", series_id, "title", title)
                  .withUpdateExpression("set info.rating = info.rating + :val")
                  .withValueMap(new ValueMap().withNumber(":val", 1)).withReturnValues(ReturnValue.UPDATED_NEW);

              try {
                  System.out.println("Увеличение атомарного счетчика...");
                  UpdateItemOutcome outcome = table.updateItem(updateItemSpec);
                  System.out.println("Данные о сериале обновлены:\n" + outcome.getItem().toJSONPretty());

              }
              catch (Exception e) {
                  System.err.println("Невозможно обновить запись: " + series_id + " " + title);
                  System.err.println(e.getMessage());
              }

          }
      }
      ```

      Используйте метод `updateItem` для увеличения или уменьшения значения существующего атрибута независимо от других запросов на запись (все запросы на запись применяются в том порядке, в котором они получены).

  1. Соберите проект:

      ```bash
      mvn package
      ```

      В результате выполнения команды в каталоге `target/release/` будет сгенерирован файл `SeriesItemOps04.jar`.

  1. Запустите приложение:

      ```bash
      java -jar target/release/SeriesItemOps04.jar
      ```

      Результат выполнения:

      ```text
      Увеличение атомарного счетчика...
      Данные о сериале обновлены:
      {
        "info" : {
          "release_date" : "2005-09-13",
          "rating" : 9,
          "series_info" : "Supernatural is an American television series created by Eric Kripke"
        }
      }
      ```

- Python

  1. Создайте файл `SeriesItemOps04.py`, например с помощью редактора nano:
  
      ```bash
      nano SeriesItemOps04.py
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      from decimal import Decimal
      from pprint import pprint
      import boto3

      def increase_rating(title, series_id, rating_increase):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API эндпоинт>")

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
          print("Данные о сериале обновлены:")
          pprint(update_response, sort_dicts = False)
      ```

      Используйте метод `update_item` для увеличения или уменьшения значения существующего атрибута. При этом все запросы на запись применяются в том порядке, в котором они пришли.

      При каждом запуске программы значение атрибута `rating` увеличивается на единицу.

  1. Запустите программу:

      ```bash
      python SeriesItemOps04.py
      ```

      Результат выполнения:

      ```bash
      Данные о сериале обновлены:
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

  1. Создайте файл `SeriesItemOps04.php`, например с помощью редактора nano:
  
      ```bash
      nano SeriesItemOps04.php
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
          echo "Запись обновлена:\n";
          echo json_encode($result["Attributes"], JSON_PRETTY_PRINT);

      } catch (DynamoDbException $e) {
          echo "Невозможно обновить запись:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

      При каждом запуске приведенного кода значение `rating` будет увеличиваться на единицу.

  1. Запустите программу:

      ```bash
      php SeriesItemOps04.php
      ```

      Результат выполнения:

      ```text
      Запись обновлена:
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

{% endlist %}

## Условное обновление {#update-with-cond}

Чтобы обновить запись в таблице `Series` при выполнении условия:

{% list tabs %}

- Java

  1. Создайте проект `SeriesItemOps05`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=ru.yandex.cloud.samples \
        -DartifactId=SeriesItemOps05
      ```

      В результате выполнения команды в текущем рабочем каталоге будет создан каталог проекта с именем `SeriesItemOps05`, структурой подкаталогов и файлом описания проекта `pom.xml`.
  
  1. Перейдите в каталог проекта:

      ```bash
      cd SeriesItemOps05
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
                                <mainClass>ru.yandex.cloud.samples.SeriesItemOps05</mainClass>
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

      Посмотрите актуальные версии [junit](https://mvnrepository.com/artifact/junit/junit) и [aws-java-sdk-dynamodb](https://mvnrepository.com/artifact/com.amazonaws/aws-java-sdk-dynamodb).

  1. В каталоге `src/main/java/ru/yandex/cloud/samples/` создайте файл `SeriesItemOps05.java`, например с помощью редактора nano:
  
      ```bash
      nano src/main/java/ru/yandex/cloud/samples/SeriesItemOps05.java
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```java
      package ru.yandex.cloud.samples;

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
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API эндпоинт>", "ru-central1"))
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
                  System.out.println("Попытка условного обновления...");
                  UpdateItemOutcome outcome = table.updateItem(updateItemSpec);
                  System.out.println("Данные о сериале обновлены:\n" + outcome.getItem().toJSONPretty());
              }
              catch (Exception e) {
                  System.err.println("Невозможно обновить запись: " + series_id + " " + title);
                  System.err.println(e.getMessage());
              }

          }
      }
      ```

      Этот код показывает пример использования условия `UpdateItem`. Если условие принимает значение `true`, обновление завершается успешно; в противном случае обновление не выполняется.

      В данном случае к записи добавляется рекомендация о просмотре при рейтинге более 9.

  1. Соберите проект:

      ```bash
      mvn package
      ```

      В результате выполнения команды в каталоге `target/release/` будет сгенерирован файл `SeriesItemOps05.jar`.

  1. Запустите приложение:

      ```bash
      java -jar target/release/SeriesItemOps05.jar
      ```

      Результат выполнения:

      ```text
      Попытка условного обновления...
      Невозможно обновить запись: 3 Supernatural
      Condition not satisfied (Service: AmazonDynamoDBv2; Status Code: 400; Error Code: ConditionalCheckFailedException; Request ID: null; Proxy: null)
      ```

      Операция завершилась с ошибкой: рейтинг фильма 9, но условие проверяет рейтинг более 9.

      Измените код так, чтобы условие стало больше или равно 9:

      ```java
      .withConditionExpression("info.rating >= :num")
      ```

      Повторите сборку проекта и запустите приложение:

      ```bash
      mvn package && java -jar target/release/SeriesItemOps05.jar
      ```

      Теперь операция успешна:

      ```text
      Попытка условного обновления...
      Данные о сериале обновлены:
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

  1. Создайте файл `SeriesItemOps05.py`, например с помощью редактора nano:
  
      ```bash
      nano SeriesItemOps05.py
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      from pprint import pprint
      import boto3
      from botocore.exceptions import ClientError

      def add_recommend(title, series_id, rating_val):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API эндпоинт>")

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
          print("Попытка условного обновления...")
          update_response = add_recommend("Supernatural", 3, 9)
          if update_response:
              print("Данные о сериале обновлены:")
              pprint(update_response, sort_dicts = False)
      ```

      Этот код показывает пример использования условия `update_item`. Если условие принимает значение `true`, обновление завершается успешно; в противном случае обновление не выполняется.

      В данном случае к записи добавляется рекомендация о просмотре при рейтинге более 9.

  1. Запустите программу:

      ```bash
      python SeriesItemOps05.py
      ```

      Результат выполнения:

      ```bash
      Попытка условного обновления записи...
      Condition not satisfied
      ```

      Обновление не удалось, потому что рейтинг сериала равен 9, а условием для обновления является значение рейтинга выше 9.

  1. Измените код так, чтобы условием для обновления был рейтинг 9 и выше. При этом параметр `ConditionExpression` будет выглядеть следующим образом:

      ```python
      ConditionExpression = "info.rating >= :num" 
      ```

  1. Запустите программу еще раз. Теперь операция обновления должна завершиться успешно.

      Результат выполнения:

      ```bash
      Попытка условного обновления записи...
      Данные о сериале обновлены:
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

  1. Создайте файл `SeriesItemOps05.php`, например с помощью редактора nano:
  
      ```bash
      nano SeriesItemOps05.php
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
          echo "Запись обновлена:\n";
          echo json_encode($result["Attributes"], JSON_PRETTY_PRINT);

      } catch (DynamoDbException $e) {
          echo "Невозможно обновить запись:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

      Этот код показывает пример использования условия `UpdateItem`. Если условие принимает значение `true`, обновление завершается успешно; в противном случае обновление не выполняется.

      В данном случае к записи добавляется рекомендация о просмотре при рейтинге более 9.

  1. Запустите программу:

      ```bash
      php SeriesItemOps05.php
      ```

      Результат выполнения:

      ```text
      Невозможно обновить запись:
      Error executing "UpdateItem" on "<Document API эндпоинт>"; AWS HTTP error: Client error: `POST <Document API эндпоинт>` resulted in a `400 Bad Request` response:
      {"__type":"ru.yandex.docapi.v20120810#ConditionalCheckFailedException","message":"Condition not satisfied"}
      ConditionalCheckFailedException (client): Condition not satisfied - {"__type":"ru.yandex.docapi.v20120810#ConditionalCheckFailedException","message":"Condition not satisfied"}
      ```

      Операция завершилась с ошибкой: рейтинг фильма 9, но условие проверяет рейтинг более 9.

      Измените код так, чтобы условие стало больше или равно 9:

      ```php
      'ConditionExpression' => 'info.rating >= :num',
      ```

      Запустите программу еще раз. Теперь операция успешна:

      ```text
      Запись обновлена:
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

{% endlist %}
