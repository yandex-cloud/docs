# Поиск и извлечение данных

Для поиска данных в таблице используется метод `query`, в котором нужно передать атрибуты первичного ключа нужной записи. Если ключ составной, то обязательно указывать только ключ партицирования, а ключ сортировки — опционально.

Первичный ключ таблицы `Series` составной и состоит из следующих атрибутов:

* `series_id` — ключ партицирования (тип поля — число);
* `title` — ключ сортировки (тип поля — строка).

Чтобы найти все сериалы с ключом партицирования, равным 3, нужно передать это значение в методе `query`. Также можно ограничить выбор по названию сериала, указав условие для ключа сортировки. Например, вы можете найти сериалы с ключом партицирования, равным 3, которые имеют название, начинающееся с буквы T.

В дополнение к методу `query` вы можете использовать метод `scan` для извлечения всех табличных данных. Метод `scan` считывает каждую запись и возвращает все данные в таблице. С помощью фильтра можно задать критерии для возвращаемых записей, но фильтр применяется только после сканирования всей таблицы.

## Поиск по ключу партицирования {#part-key-find}

Чтобы извлечь данные методом `query` из таблицы `Series`:

{% list tabs %}

- Java

  1. Создайте проект `SeriesQuery01`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=ru.yandex.cloud.samples \
        -DartifactId=SeriesQuery01
      ```

      В результате выполнения команды в текущем рабочем каталоге будет создан каталог проекта с именем `SeriesQuery01`, структурой подкаталогов и файлом описания проекта `pom.xml`.
  
  1. Перейдите в каталог проекта:

      ```bash
      cd SeriesQuery01
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
                                <mainClass>ru.yandex.cloud.samples.SeriesQuery01</mainClass>
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

      Посмотрите актуальные версии [junit](https://mvnrepository.com/artifact/junit/junit) и [aws-java-sdk-dynamodb](https://mvnrepository.com/artifact/com.amazonaws/aws-java-sdk-dynamodb).

  1. В каталоге `src/main/java/ru/yandex/cloud/samples/` создайте файл `SeriesQuery01.java`, например с помощью редактора nano:
  
      ```bash
      nano src/main/java/ru/yandex/cloud/samples/SeriesQuery01.java
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```java
      package ru.yandex.cloud.samples;

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
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API эндпоинт>", "ru-central1"))
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
                  System.out.println("Сериалы с id, равным 3");
                  items = table.query(querySpec);

                  iterator = items.iterator();
                  while (iterator.hasNext()) {
                      item = iterator.next();
                      System.out.println(item.getNumber("series_id") + ": " + item.getString("title"));
                  }

              }
              catch (Exception e) {
                    System.err.println("Невозможно выполнить поиск");
                    System.err.println(e.getMessage());
              }

          }
      }
      ```

      Этот код извлекает из таблицы `Series` все сериалы с ключом партицирования, равным 3.

      {% note info %}

      `valueMap` используется для подстановки значений. Это необходимо потому, что нельзя использовать литералы непосредственно в выражениях, в том числе и в  `KeyConditionExpression`. В приведенном коде используется `:sd`.

      {% endnote %}

      Сначала вы создаете объект `querySpec`, который описывает параметры запроса, а затем передаете этот объект в метод `query`.

  1. Соберите проект:

      ```bash
      mvn package
      ```

      В результате выполнения команды в каталоге `target/release/` будет сгенерирован файл `SeriesQuery01.jar`.

  1. Запустите приложение:

      ```bash
      java -jar target/release/SeriesQuery01.jar
      ```

      Результат выполнения:

      ```text
      Сериалы с id, равным 3
      3: House of Cards
      3: The Office
      3: True Detective
      ```

- Python

  1. Создайте файл `SeriesQuery01.py` и скопируйте в него следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      import boto3
      from boto3.dynamodb.conditions import Key

      def query_series(series_id):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API эндпоинт>")

          table = ydb_docapi_client.Table('Series')
          response = table.query(
              KeyConditionExpression = Key('series_id').eq(series_id)
          )
          return response['Items']

      if __name__ == '__main__':
          query_id = 3
          print(f"Сериалы с id = {query_id}")
          series = query_series(query_id)
          for serie in series:
              print(serie['series_id'], ":", serie['title'])
      ```

      Этот код извлекает из таблицы `Series` все сериалы с ключом партицирования, равным 3.

      SDK Boto 3 создает параметр `ConditionExpression` за вас, когда вы используете функции `Key` и `Attr`, импортированные из `boto3.dynamodb.conditions`. Вы также можете указать значение параметра `ConditionExpression` в виде строки.

  1. Запустите программу:

      ```bash
      python SeriesQuery01.py
      ```

      Результат выполнения:

      ```text
      Сериалы с id = 3
      3 : House of Cards
      3 : The Office
      3 : True Detective
      ```

{% endlist %}

## Поиск по ключам партицирования и сортировки {#part-sort-key-find}

Чтобы найти в таблице `Series` сериалы с ключом партицирования, равным 3, и названием на букву T:

{% list tabs %}

- Java

  1. Создайте проект `SeriesQuery02`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=ru.yandex.cloud.samples \
        -DartifactId=SeriesQuery02
      ```

      В результате выполнения команды в текущем рабочем каталоге будет создан каталог проекта с именем `SeriesQuery02`, структурой подкаталогов и файлом описания проекта `pom.xml`.
  
  1. Перейдите в каталог проекта:

      ```bash
      cd SeriesQuery02
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
                                <mainClass>ru.yandex.cloud.samples.SeriesQuery02</mainClass>
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

      Посмотрите актуальные версии [junit](https://mvnrepository.com/artifact/junit/junit) и [aws-java-sdk-dynamodb](https://mvnrepository.com/artifact/com.amazonaws/aws-java-sdk-dynamodb).

  1. В каталоге `src/main/java/ru/yandex/cloud/samples/` создайте файл `SeriesQuery02.java`, например с помощью редактора nano:
  
      ```bash
      nano src/main/java/ru/yandex/cloud/samples/SeriesQuery02.java
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```java
      package ru.yandex.cloud.samples;

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
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API эндпоинт>", "ru-central1"))
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
                  System.out.println("Сериалы с id, равным 3 и названием на букву T:");
                  items = table.query(querySpec);

                  iterator = items.iterator();
                  while (iterator.hasNext()) {
                      item = iterator.next();
                      System.out.println(item.getNumber("series_id") + ": " + item.getString("title"));
                  }

              }
              catch (Exception e) {
                  System.err.println("Невозможно выполнить поиск");
                  System.err.println(e.getMessage());
              }

          }
      }
      ```

  1. Соберите проект:

      ```bash
      mvn package
      ```

      В результате выполнения команды в каталоге `target/release/` будет сгенерирован файл `SeriesQuery02.jar`.

  1. Запустите приложение:

      ```bash
      java -jar target/release/SeriesQuery02.jar
      ```

      Результат выполнения:

      ```text
      Сериалы с id, равным 3 и названием на букву T:
      3: The Office
      3: True Detective
      ```

- Python

  1. Создайте файл `SeriesQuery02.py` и скопируйте в него следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      from pprint import pprint
      import boto3
      from boto3.dynamodb.conditions import Key

      def query_and_project_series(series_id, title_range):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API эндпоинт>")

          table = ydb_docapi_client.Table('Series')
          
          response = table.query(
              ProjectionExpression = "series_id, title, info.release_date",
              KeyConditionExpression = Key('series_id').eq(series_id) & Key('title').begins_with(title_range)
          )
          return response['Items']

      if __name__ == '__main__':
          query_id = 3
          query_range = 'T'
          print(f"Сериалы с id = {query_id} и названием на букву "
                f"{query_range}")
          series = query_and_project_series(query_id, query_range)
          for serie in series:
              print(f"\n{serie['series_id']} : {serie['title']}")
              pprint(serie['info'])
      ```

  1. Запустите программу:

      ```bash
      python SeriesQuery02.py
      ```

      Результат выполнения:

      ```text
      Сериалы с id = 3 и названием на букву Т
      3 : The Office
      3 : True Detective
      ```

{% endlist %}

## Сканирование {#scanning}

Чтобы извлечь данные методом `scan` из таблицы `Series`:

{% list tabs %}

- Java

  1. Создайте проект `SeriesScan`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=ru.yandex.cloud.samples \
        -DartifactId=SeriesScan
      ```

      В результате выполнения команды в текущем рабочем каталоге будет создан каталог проекта с именем `SeriesScan`, структурой подкаталогов и файлом описания проекта `pom.xml`.
  
  1. Перейдите в каталог проекта:

      ```bash
      cd SeriesScan
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
                                <mainClass>ru.yandex.cloud.samples.SeriesScan</mainClass>
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

      Посмотрите актуальные версии [junit](https://mvnrepository.com/artifact/junit/junit) и [aws-java-sdk-dynamodb](https://mvnrepository.com/artifact/com.amazonaws/aws-java-sdk-dynamodb).

  1. В каталоге `src/main/java/ru/yandex/cloud/samples/` создайте файл `SeriesScan.java`, например с помощью редактора nano:
  
      ```bash
      nano src/main/java/ru/yandex/cloud/samples/SeriesScan.java
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```java
      package ru.yandex.cloud.samples;

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
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document API эндпоинт>", "ru-central1"))
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
                  System.err.println("Невозможно выполнить сканирование");
                  System.err.println(e.getMessage());
              }

          }
      }
      ```

      Приведенный код сканирует таблицу `Series` и выводит сериалы с атрибутом `series_id` от 1 до 3. Все остальные элементы отбрасываются.

  1. Соберите проект:

      ```bash
      mvn package
      ```

      В результате выполнения команды в каталоге `target/release/` будет сгенерирован файл `SeriesScan.jar`.

  1. Запустите приложение:

      ```bash
      java -jar target/release/SeriesScan.jar
      ```

      Результат выполнения:

      ```text
      { Item: {title=House of Cards, series_id=3, info={release_date=2013-02-01T00:00:00Z}} }
      { Item: {title=The Office, series_id=3, info={release_date=2005-03-24T00:00:00Z}} }
      { Item: {title=True Detective, series_id=3, info={release_date=2014-01-12T00:00:00Z}} }
      { Item: {title=IT Crowd, series_id=1, info={release_date=2006-02-03T00:00:00Z}} }
      { Item: {title=Silicon Valley, series_id=2, info={release_date=2014-04-06T00:00:00Z}} }
      ```

- Python

  1. Создайте файл `SeriesScan.py` и скопируйте в него следующий код:

      {% note warning %}

      Вместо `<Document API эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      from pprint import pprint
      import boto3
      from boto3.dynamodb.conditions import Key

      def scan_series(id_range, display_series):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document API эндпоинт>")

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
          print(f"Поиск сериалов с id, равным от {query_range[0]} до {query_range[1]}...")
          scan_series(query_range, print_series)
      ```

      Приведенный код сканирует таблицу `Series` и выводит сериалы с атрибутом `series_id` от 1 до 3. Все остальные элементы отбрасываются.

      Для фильтрации найденных данных вы можете указать необязательный параметр `FilterExpression`, в котором указать условия отбора.

      Метод `scan` при каждом вызове возвращает подмножество записей, называемое страницей. Затем значение `LastEvaluatedKey` в ответе передается методу `scan` через параметр `ExclusiveStartKey`. Когда возвращается последняя страница, значение `LastEvaluatedKey` не включается в ответ.

  1. Запустите программу:

      ```bash
      python SeriesScan.py
      ```

      Результат выполнения:

      ```text
      Поиск сериалов с id, равным от 1 до 3...

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

  Вы также можете использовать метода `scan` для работы с любыми вторичными индексами, созданными в таблице.

{% endlist %}
