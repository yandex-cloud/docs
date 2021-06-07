# Загрузка данных в таблицу

В этом примере данные для загрузки содержат информацию о сериалах в файле формата JSON. Для каждого сериала заданы идентификатор `series_id`, название `title`, а также дополнительная информация `info`:

Структура JSON-файла c информацией о сериале:

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
        -DgroupId=ru.yandex.cloud.samples \
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
        <groupId>ru.yandex.cloud.samples</groupId>
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
                                <mainClass>ru.yandex.cloud.samples.SeriesLoadData</mainClass>
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

  1. В каталоге `src/main/java/ru/yandex/cloud/samples/` создайте файл `SeriesLoadData.java`, например с помощью редактора nano:
  
      ```bash
      nano src/main/java/ru/yandex/cloud/samples/SeriesLoadData.java
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```java
      package ru.yandex.cloud.samples;

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
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API эндпоинт>", "ru-central1"))
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

  1. Создайте файл `seriesdata.json` с данными для загрузки, например с помощью редактора nano:

      ```bash
      nano seriesdata.json
      ```

      Скопируйте в созданный файл следующий код:

      ```json
      [{
          "series_id": 1,
          "title": "IT Crowd",
          "info": {
            "release_date": "2006-02-03T00:00:00Z",
            "series_info": "The IT Crowd is a British sitcom produced by Channel 4, written by Graham Linehan, produced by Ash Atalla and starring Chris O'Dowd, Richard Ayoade, Katherine Parkinson, and Matt Berry"
          }
        },
        {
          "series_id": 2,
          "title": "Silicon Valley",
          "info": {
            "release_date": "2014-04-06T00:00:00Z",
            "series_info": "Silicon Valley is an American comedy television series created by Mike Judge, John Altschuler and Dave Krinsky. The series focuses on five young men who founded a startup company in Silicon Valley"
          }
        },
        {
          "series_id": 3,
          "title": "House of Cards",
          "info": {
            "release_date": "2013-02-01T00:00:00Z",
            "series_info": "House of Cards is an American political thriller streaming television series created by Beau Willimon. It is an adaptation of the 1990 BBC miniseries of the same name and based on the 1989 novel of the same name by Michael Dobbs"
          }
        },
        {
          "series_id": 3,
          "title": "The Office",
          "info": {
            "release_date": "2005-03-24T00:00:00Z",
            "series_info": "The Office is an American mockumentary sitcom television series that depicts the everyday work lives of office employees in the Scranton, Pennsylvania, branch of the fictional Dunder Mifflin Paper Company"
          }
        },
        {
          "series_id": 3,
          "title": "True Detective",
          "info": {
            "release_date": "2014-01-12T00:00:00Z",
            "series_info": "True Detective is an American anthology crime drama television series created and written by Nic Pizzolatto. The series, broadcast by the premium cable network HBO in the United States, premiered on January 12, 2014"
          }
        },
        {
          "series_id": 4,
          "title": "The Big Bang Theory",
          "info": {
            "release_date": "2007-09-24T00:00:00Z",
            "series_info": "The Big Bang Theory is an American television sitcom created by Chuck Lorre and Bill Prady, both of whom served as executive producers on the series, along with Steven Molaro"
          }
        },
        {
          "series_id": 5,
          "title": "Twin Peaks",
          "info": {
            "release_date": "1990-04-08T00:00:00Z",
            "series_info": "Twin Peaks is an American mystery horror drama television series created by Mark Frost and David Lynch that premiered on April 8, 1990, on ABC until its cancellation after its second season in 1991 before returning as a limited series in 2017 on Showtime"
          }
        }
      ]
      ```

      {% endcut %}

  1. Запустите приложение:

      ```bash
      java -jar target/release/SeriesLoadData.jar
      ```

      Результат выполнения:

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

  1. Создайте файл `seriesdata.json` с данными для загрузки.

      Скопируйте в созданный файл следующий код:

      ```json
      [{
          "series_id": 1,
          "title": "IT Crowd",
          "info": {
            "release_date": "2006-02-03T00:00:00Z",
            "series_info": "The IT Crowd is a British sitcom produced by Channel 4, written by Graham Linehan, produced by Ash Atalla and starring Chris O'Dowd, Richard Ayoade, Katherine Parkinson, and Matt Berry"
          }
        },
        {
          "series_id": 2,
          "title": "Silicon Valley",
          "info": {
            "release_date": "2014-04-06T00:00:00Z",
            "series_info": "Silicon Valley is an American comedy television series created by Mike Judge, John Altschuler and Dave Krinsky. The series focuses on five young men who founded a startup company in Silicon Valley"
          }
        },
        {
          "series_id": 3,
          "title": "House of Cards",
          "info": {
            "release_date": "2013-02-01T00:00:00Z",
            "series_info": "House of Cards is an American political thriller streaming television series created by Beau Willimon. It is an adaptation of the 1990 BBC miniseries of the same name and based on the 1989 novel of the same name by Michael Dobbs"
          }
        },
        {
          "series_id": 3,
          "title": "The Office",
          "info": {
            "release_date": "2005-03-24T00:00:00Z",
            "series_info": "The Office is an American mockumentary sitcom television series that depicts the everyday work lives of office employees in the Scranton, Pennsylvania, branch of the fictional Dunder Mifflin Paper Company"
          }
        },
        {
          "series_id": 3,
          "title": "True Detective",
          "info": {
            "release_date": "2014-01-12T00:00:00Z",
            "series_info": "True Detective is an American anthology crime drama television series created and written by Nic Pizzolatto. The series, broadcast by the premium cable network HBO in the United States, premiered on January 12, 2014"
          }
        },
        {
          "series_id": 4,
          "title": "The Big Bang Theory",
          "info": {
            "release_date": "2007-09-24T00:00:00Z",
            "series_info": "The Big Bang Theory is an American television sitcom created by Chuck Lorre and Bill Prady, both of whom served as executive producers on the series, along with Steven Molaro"
          }
        },
        {
          "series_id": 5,
          "title": "Twin Peaks",
          "info": {
            "release_date": "1990-04-08T00:00:00Z",
            "series_info": "Twin Peaks is an American mystery horror drama television series created by Mark Frost and David Lynch that premiered on April 8, 1990, on ABC until its cancellation after its second season in 1991 before returning as a limited series in 2017 on Showtime"
          }
        }
      ]
      ```

      {% endcut %}

  1. Создайте файл `SeriesLoadData.py` и скопируйте в него следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      from decimal import Decimal
      import json
      import boto3

      def load_series(series):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API эндпоинт>")

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

  1. Запустите программу:

      ```bash
      python SeriesLoadData.py
      ```

      Результат выполнения:

      ```text
      Добавлен сериал: 1 IT Crowd
      Добавлен сериал: 2 Silicon Valley
      Добавлен сериал: 3 House of Cards
      Добавлен сериал: 3 The Office
      Добавлен сериал: 3 True Detective
      Добавлен сериал: 4 The Big Bang Theory
      Добавлен сериал: 5 Twin Peaks
      ```

{% endlist %}
