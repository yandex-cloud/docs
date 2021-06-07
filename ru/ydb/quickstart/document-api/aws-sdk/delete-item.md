# Удаление записи

Чтобы удалить с условием запись в таблице `Series`:

{% list tabs %}

- Java

  1. Создайте проект `SeriesItemOps06`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=ru.yandex.cloud.samples \
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
        <groupId>ru.yandex.cloud.samples</groupId>
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
                                <mainClass>ru.yandex.cloud.samples.SeriesItemOps06</mainClass>
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

  1. В каталоге `src/main/java/ru/yandex/cloud/samples/` создайте файл `SeriesItemOps06.java`, например с помощью редактора nano:
  
      ```bash
      nano src/main/java/ru/yandex/cloud/samples/SeriesItemOps06.java
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
      import com.amazonaws.services.dynamodbv2.document.spec.DeleteItemSpec;
      import com.amazonaws.services.dynamodbv2.document.utils.ValueMap;

      public class SeriesItemOps06 {

          public static void main(String[] args) throws Exception {

              AmazonDynamoDB client = AmazonDynamoDBClientBuilder.standard()
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API эндпоинт>", "ru-central1"))
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

      Результат выполнения:

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

- Python

  1. Создайте файл `SeriesItemOps06.py` и скопируйте в него следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      from decimal import Decimal
      from pprint import pprint
      import boto3
      from botocore.exceptions import ClientError

      def delete_underrated_serie(title, series_id, rating):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API эндпоинт>")

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

      Результат выполнения:

      ```text
      Попытка удаления записи...
      Condition not satisfied
      ```

      Операция завершилась с ошибкой: рейтинг фильма больше 5.

  1. Измените программу так, чтобы удалить условие при вызове метода `delete_item`:

      ```python
      response = table.delete_item(
          Key = {
              'series_id': series_id,
              'title': title
          }
      )
      ```

  1. Запустите программу еще раз. Теперь операция удаления должна завершиться успешно.

      Результат выполнения:

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

{% endlist %}
