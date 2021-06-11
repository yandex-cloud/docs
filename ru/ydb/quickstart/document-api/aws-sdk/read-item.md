# Чтение записи

Чтобы прочитать запись из таблицы `Series`:

{% list tabs %}

- Java

  1. Создайте проект `SeriesItemOps02`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=ru.yandex.cloud.samples \
        -DartifactId=SeriesItemOps02
      ```

      В результате выполнения команды в текущем рабочем каталоге будет создан каталог проекта с именем `SeriesItemOps02`, структурой подкаталогов и файлом описания проекта `pom.xml`.
  
  1. Перейдите в каталог проекта:

      ```bash
      cd SeriesItemOps02
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
                                <mainClass>ru.yandex.cloud.samples.SeriesItemOps02</mainClass>
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

      Посмотрите актуальные версии [junit](https://mvnrepository.com/artifact/junit/junit) и [aws-java-sdk-dynamodb](https://mvnrepository.com/artifact/com.amazonaws/aws-java-sdk-dynamodb).

  1. В каталоге `src/main/java/ru/yandex/cloud/samples/` создайте файл `SeriesItemOps02.java`, например с помощью редактора nano:
  
      ```bash
      nano src/main/java/ru/yandex/cloud/samples/SeriesItemOps02.java
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
      import com.amazonaws.services.dynamodbv2.document.Item;
      import com.amazonaws.services.dynamodbv2.document.Table;
      import com.amazonaws.services.dynamodbv2.document.spec.GetItemSpec;

      public class SeriesItemOps02 {

          public static void main(String[] args) throws Exception {

              AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API эндпоинт>", "ru-central1"))
                  .build();

              DynamoDB dynamoDB = new DynamoDB(client);

              Table table = dynamoDB.getTable("Series");

              int series_id = 3;
              String title = "Supernatural";

              GetItemSpec spec = new GetItemSpec().withPrimaryKey("series_id", series_id, "title", title);

              try {
                  System.out.println("Попытка получить запись...");
                  Item outcome = table.getItem(spec);
                  System.out.println("Получена запись: " + outcome);
              }
              catch (Exception e) {
                  System.err.println("Невозможно получить запись: " + series_id + " " + title);
                  System.err.println(e.getMessage());
              }

          }
      }
      ```

      Для чтения записи по ее первичному ключу используется метод `getItem`.

  1. Соберите проект:

      ```bash
      mvn package
      ```

      В результате выполнения команды в каталоге `target/release/` будет сгенерирован файл `SeriesItemOps02.jar`.

  1. Запустите приложение:

      ```bash
      java -jar target/release/SeriesItemOps02.jar
      ```

      Результат выполнения:

      ```text
      Попытка получить запись...
      Получена запись: { Item: {title=Supernatural, series_id=3, info={release_date=2015-09-13, series_info=Supernatural is an American television series created by Eric Kripke}} }
      ```

- Python

  1. Создайте файл `SeriesItemOps02.py`, например с помощью редактора nano:

      ```bash
      nano SeriesItemOps02.py
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      from pprint import pprint
      import boto3
      from botocore.exceptions import ClientError

      def get_serie(title, series_id):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API эндпоинт>")

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
              print("Получена запись:")
              pprint(serie, sort_dicts = False)
      ```

      Для чтения записи из таблицы используется метод `get_item`, в котором нужно передать атрибуты первичного ключа нужной записи.

  1. Запустите программу:

      ```bash
      python SeriesItemOps02.py
      ```

      Результат выполнения:

      ```text
      Получена запись:
      {'series_id': Decimal('3'),
      'title': ' Supernatural,
      'info': {'release_date': 2015-09-13',
                'series_info': 'Supernatural is an American television series '
                              'created by Eric Kripke'}}
      ```

- PHP

  1. Создайте файл `SeriesItemOps02.php`, например с помощью редактора nano:

      ```bash
      nano SeriesItemOps02.php
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

      $params = [
          'TableName' => $tableName,
          'Key' => $key
      ];

      try {
          $result = $dynamodb->getItem($params);
          echo json_encode($result["Item"], JSON_PRETTY_PRINT);

      } catch (DynamoDbException $e) {
          echo "Невозможно получить запись:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

      Для чтения записи по ее первичному ключу используется метод `getItem`.

  1. Запустите программу:

      ```bash
      php SeriesItemOps02.php
      ```

      Результат выполнения:

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

{% endlist %}
