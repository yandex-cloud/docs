---
sourcePath: overlay/quickstart/document-api/aws-sdk/query-and-scan.md
---
# Поиск и извлечение данных

Для поиска данных в таблице используется метод `query`, в котором нужно передать атрибуты первичного ключа нужной записи. Если ключ составной, то обязательно указывать только ключ партицирования, а ключ сортировки — опционально.

Первичный ключ таблицы `Series` составной и состоит из следующих атрибутов:

* `series_id` — ключ партицирования (тип поля — число);
* `title` — ключ сортировки (тип поля — строка).

Чтобы найти все сериалы с ключом партицирования, равным 3, нужно передать это значение в методе `query`. Также можно ограничить выбор по названию сериала, указав условие для ключа сортировки. Например, вы можете найти сериалы с ключом партицирования, равным 3, которые имеют название, начинающееся с буквы T.

В дополнение к методу `query` вы можете использовать метод `scan` для извлечения всех табличных данных. Метод `scan` считывает каждую запись и возвращает все данные в таблице. С помощью фильтра можно задать критерии для возвращаемых записей, но фильтр применяется только после сканирования всей таблицы.

## Поиск по ключу партицирования {#part-key-find}

Чтобы извлечь данные методом `query` из таблицы `Series`:

{% list tabs group=programming_language %}

- Java {#java}

  1. Создайте проект `SeriesQuery01`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
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
        <groupId>com.mycompany.app</groupId>
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
                                <mainClass>com.mycompany.app.SeriesQuery01</mainClass>
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

  1. В каталоге `src/main/java/com/mycompany/app/` создайте файл `SeriesQuery01.java`, например с помощью редактора nano:

      ```bash
      nano src/main/java/com/mycompany/app/SeriesQuery01.java
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```java
      package com.mycompany.app;

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
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document_API_эндпоинт>", "{{ region-id }}"))
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

      `valueMap` используется для подстановки значений. Это необходимо потому, что нельзя использовать литералы непосредственно в выражениях, в том числе и в `KeyConditionExpression`. В приведенном коде используется `:sd`.

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

      Результат:

      ```text
      Сериалы с id, равным 3
      3: House of Cards
      3: The Office
      3: True Detective
      ```

- Python {#python}

  1. Создайте файл `SeriesQuery01.py`, например с помощью редактора nano:

      ```bash
      nano SeriesQuery01.py
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      import boto3
      from boto3.dynamodb.conditions import Key

      def query_series(series_id):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document_API_эндпоинт>")

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

      Результат:

      ```text
      Сериалы с id = 3
      3 : House of Cards
      3 : The Office
      3 : True Detective
      ```

- PHP {#php}

  1. Создайте файл `SeriesQuery01.php`, например с помощью редактора nano:

      ```bash
      nano SeriesQuery01.php
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

      $eav = $marshaler->marshalJson('
          {
              ":sd": 3
          }
      ');

      $params = [
          'TableName' => $tableName,
          'KeyConditionExpression' => 'series_id = :sd',
          'ExpressionAttributeValues'=> $eav
      ];

      echo "Сериалы с id, равным 3\n";

      try {
          $result = $dynamodb->query($params);

          echo "Поиск выполнен.\n";

          foreach ($result['Items'] as $movie) {
              echo $marshaler->unmarshalValue($movie['series_id']) . ': ' .
                  $marshaler->unmarshalValue($movie['title']) . "\n";
          }

      } catch (DynamoDbException $e) {
          echo "Невозможно выполнить поиск:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

      Этот код извлекает из таблицы `Series` все сериалы с ключом партицирования, равным 3.

      {% note info %}

      `ExpressionAttributeValues` используется для подстановки значений. Это необходимо потому, что нельзя использовать литералы непосредственно в выражениях, в том числе и в `KeyConditionExpression`. В приведенном коде используется `:sd`.

      {% endnote %}

  1. Запустите программу:

      ```bash
      php SeriesQuery01.php
      ```

      Результат:

      ```text
      Сериалы с id, равным 3
      Поиск выполнен.
      3: House of Cards
      3: The Office
      3: True Detective
      ```

- Node.js {#node}

  1. Создайте файл `SeriesQuery01.js`, например с помощью редактора nano:

      ```bash
      nano SeriesQuery01.js
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

      console.log("Поиск фильмов с ключом партицирования, равным 3.");

      const params = {
          TableName : "Series",
          KeyConditionExpression: "series_id = :val",
          ExpressionAttributeValues: marshall({
              ":val": 3
          }),
      };

      dynamodb.send(new AWS.QueryCommand(params))
          .then(data => {
              console.log("Запрос успешно выполнен:");
              data.Items.forEach(function(item) {
                  console.log(" -", item.series_id + ": " + item.title);
              });
          })
          .catch(err => {
              console.error("Не удалось выполнить запрос. Ошибка:", JSON.stringify(err, null, 2));
          });
      ```

      Этот код извлекает из таблицы `Series` все сериалы с ключом партицирования, равным 3.

  1. Запустите программу:

      ```bash
      node SeriesQuery01.js
      ```

      Результат:

      ```text
      Поиск фильмов с ключом партицирования, равным 3.
      Запрос успешно выполнен:
      - 3: House of Cards
      - 3: The Office
      - 3: True Detective
      ```

- Ruby {#ruby}

  1. Создайте файл `SeriesQuery01.rb`, например с помощью редактора nano:

      ```bash
      nano SeriesQuery01.rb
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'

      def query_for_items_from_table(dynamodb_client, query_condition)
        result = dynamodb_client.query(query_condition)
        if result.items.count.zero?
          puts 'Результатов не найдено.'
        else
          puts "Найдено #{result.items.count} записей:"
          result.items.each do |movie|
            puts "#{movie['title']} (#{movie['series_id'].to_i})"
          end
        end
      rescue StandardError => e
        puts "Ошибка получения элементов из таблицы: #{e.message}"
      end

      def run_me
        region = '{{ region-id }}'
        table_name = 'Series'
        series_id = 3

        Aws.config.update(
          endpoint: '<Document_API_эндпоинт>',
          region: region
        )

        dynamodb_client = Aws::DynamoDB::Client.new
        query_condition = {
          table_name: table_name,
          key_condition_expression: 'series_id = :val',
          expression_attribute_values: {
            ':val' => 3
          }
        }

        puts "Поиск фильмов с ключом партицирования, равным '#{series_id}' в таблице '#{table_name}'..."

        query_for_items_from_table(dynamodb_client, query_condition)
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

      Этот код извлекает из таблицы `Series` все сериалы с ключом партицирования, равным 3.

  1. Запустите программу:

      ```bash
      ruby SeriesQuery01.rb
      ```

      Результат:

      ```text
      Поиск фильмов с ключом партицирования, равным '3' в таблице 'Series'...
      Найдено 3 записей:
      House of Cards (3)
      The Office (3)
      True Detective (3)
      ```

{% endlist %}

## Поиск по ключам партицирования и сортировки {#part-sort-key-find}

Чтобы найти в таблице `Series` сериалы с ключом партицирования, равным 3, и названием на букву T:

{% list tabs group=programming_language %}

- Java {#java}

  1. Создайте проект `SeriesQuery02`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
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
        <groupId>com.mycompany.app</groupId>
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
                                <mainClass>com.mycompany.app.SeriesQuery02</mainClass>
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

  1. В каталоге `src/main/java/com/mycompany/app/` создайте файл `SeriesQuery02.java`, например с помощью редактора nano:

      ```bash
      nano src/main/java/com/mycompany/app/SeriesQuery02.java
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```java
      package com.mycompany.app;

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
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document_API_эндпоинт>", "{{ region-id }}"))
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

      Результат:

      ```text
      Сериалы с id, равным 3 и названием на букву T:
      3: The Office
      3: True Detective
      ```

- Python {#python}

  1. Создайте файл `SeriesQuery02.py`, например с помощью редактора nano:

      ```bash
      nano SeriesQuery02.py
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      from pprint import pprint
      import boto3
      from boto3.dynamodb.conditions import Key

      def query_and_project_series(series_id, title_range):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document_API_эндпоинт>")

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

      Результат:

      ```text
      Сериалы с id = 3 и названием на букву Т
      3 : The Office
      3 : True Detective
      ```

- PHP {#php}

  1. Создайте файл `SeriesQuery02.php`, например с помощью редактора nano:

      ```bash
      nano SeriesQuery02.php
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

      $eav = $marshaler->marshalJson('
          {
              ":sd": 3,
              ":letter": "T"
          }
      ');

      $params = [
          'TableName' => $tableName,
          'ProjectionExpression' => 'series_id, title',
          'KeyConditionExpression' =>
              'series_id = :sd and begins_with(title, :letter)',
          'ExpressionAttributeValues'=> $eav
      ];

      echo "Сериалы с id, равным 3 и названием на букву T:\n";

      try {
          $result = $dynamodb->query($params);

          echo "Поиск выполнен.\n";

          foreach ($result['Items'] as $i) {
              $movie = $marshaler->unmarshalItem($i);
              print $movie['series_id'] . ': ' . $movie['title'] . "\n";
          }

      } catch (DynamoDbException $e) {
          echo "Невозможно выполнить поиск:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

  1. Запустите программу:

      ```bash
      php SeriesQuery02.php
      ```

      Результат:

      ```text
      Сериалы с id, равным 3 и названием на букву T:
      Поиск выполнен.
      3: The Office
      3: True Detective
      ```

- Node.js {#node}

  1. Создайте файл `SeriesQuery02.js`, например с помощью редактора nano:

      ```bash
      nano SeriesQuery02.js
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```javascript
      var AWS = require("aws-sdk");

      AWS.config.update({
        region: "{{ region-id }}",
        endpoint: "<Document_API_эндпоинт>"
      });

      var docClient = new AWS.DynamoDB.DocumentClient();

      console.log("Сериалы с id = 3 и названием на букву Т:");

      var params = {
          TableName : "Series",
          ProjectionExpression: "#series_id, title",
          KeyConditionExpression: "#series_id = :series_id and begins_with(title,:letter)",
          ExpressionAttributeNames:{
              "#series_id": "series_id",
              "#letter": "letter"
          },
          ExpressionAttributeValues: {
              ":series_id": 3,
              ":letter": 'T'
          }
      };

      docClient.query(params, function(err, data) {
          if (err) {
              console.log("Не удалось выполнить запрос. Ошибка:", JSON.stringify(err, null, 2));
          } else {
              console.log("Запрос успешно выполнен:");
              data.Items.forEach(function(item) {
                  console.log(" -", item.series_id + ": " + item.title);
              });
          }
      });
      ```

  1. Запустите программу:

      ```bash
      node SeriesQuery02.js
      ```

      Результат:

      ```text
      Сериалы с id = 3 и названием на букву Т:
      Запрос успешно выполнен:
      - 3: The Office
      - 3: True Detective
      ```

- Ruby {#ruby}

  1. Создайте файл `SeriesQuery02.rb`, например с помощью редактора nano:

      ```bash
      nano SeriesQuery02.rb
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```ruby
      require 'aws-sdk-dynamodb'

      def query_for_items_from_table(dynamodb_client, query_condition)
        result = dynamodb_client.query(query_condition)
        if result.items.count.zero?
          puts 'Результатов не найдено.'
        else
          puts "Найдено #{result.items.count} записей:"
          result.items.each do |movie|
            puts "#{movie['title']} (#{movie['series_id'].to_i}) "
          end
        end
      rescue StandardError => e
        puts "Ошибка получения элементов из таблицы: #{e.message}"
      end

      def run_me
        region = '{{ region-id }}'
        table_name = 'Series'
        series_id = 3

        Aws.config.update(
          endpoint: '<Document_API_эндпоинт>',
          region: region
        )

        dynamodb_client = Aws::DynamoDB::Client.new
        query_condition = {
          table_name: table_name,
          key_condition_expression: 'series_id = :val and begins_with(title,:letter)',
          expression_attribute_values: {
            ':val' => 3,
            ':letter' => 'T'
          }
        }

        puts "Поиск в таблице '#{table_name}' сериалов с id = '#{series_id}' и названием на букву Т"

        query_for_items_from_table(dynamodb_client, query_condition)
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

  1. Запустите программу:

      ```bash
      ruby SeriesQuery02.rb
      ```

      Результат:

      ```text
      Поиск в таблице 'Series' сериалов с id = '3' и названием на букву Т
      Найдено 2 записей:
      The Office (3) 
      True Detective (3) 
      ```

{% endlist %}

## Сканирование {#scanning}

Чтобы извлечь данные методом `scan` из таблицы `Series`:

{% list tabs group=programming_language %}

- Java {#java}

  1. Создайте проект `SeriesScan`:

      ```bash
      mvn -B archetype:generate \
        -DarchetypeGroupId=org.apache.maven.archetypes \
        -DgroupId=com.mycompany.app \
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
        <groupId>com.mycompany.app</groupId>
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
                                <mainClass>com.mycompany.app.SeriesScan</mainClass>
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

  1. В каталоге `src/main/java/com/mycompany/app/` создайте файл `SeriesScan.java`, например с помощью редактора nano:

      ```bash
      nano src/main/java/com/mycompany/app/SeriesScan.java
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```java
      package com.mycompany.app;

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
                  .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration("<Document_API_эндпоинт>", "{{ region-id }}"))
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

      Результат:

      ```text
      { Item: {title=House of Cards, series_id=3, info={release_date=2013-02-01T00:00:00Z}} }
      { Item: {title=The Office, series_id=3, info={release_date=2005-03-24T00:00:00Z}} }
      { Item: {title=True Detective, series_id=3, info={release_date=2014-01-12T00:00:00Z}} }
      { Item: {title=IT Crowd, series_id=1, info={release_date=2006-02-03T00:00:00Z}} }
      { Item: {title=Silicon Valley, series_id=2, info={release_date=2014-04-06T00:00:00Z}} }
      ```

- Python {#python}

  1. Создайте файл `SeriesScan.py`, например с помощью редактора nano:

      ```bash
      nano SeriesScan.py
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```python
      from pprint import pprint
      import boto3
      from boto3.dynamodb.conditions import Key

      def scan_series(id_range, display_series):
          ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "<Document_API_эндпоинт>")

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

      Результат:

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

- PHP {#php}

  1. Создайте файл `SeriesScan.php`, например с помощью редактора nano:

      ```bash
      nano SeriesScan.php
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

      //Expression attribute values
      $eav = $marshaler->marshalJson('
          {
              ":start_sd": 1,
              ":end_sd": 3
          }
      ');

      $params = [
          'TableName' => 'Series',
          'ProjectionExpression' => 'series_id, title',
          'FilterExpression' => 'series_id between :start_sd and :end_sd',
          'ExpressionAttributeValues'=> $eav
      ];

      echo "Сканирование таблицы Series.\n";

      try {
          while (true) {
              $result = $dynamodb->scan($params);

              foreach ($result['Items'] as $i) {
                  $movie = $marshaler->unmarshalItem($i);
                  echo $movie['series_id'] . ': ' . $movie['title'] . "\n";
              }

              if (isset($result['LastEvaluatedKey'])) {
                  $params['ExclusiveStartKey'] = $result['LastEvaluatedKey'];
              } else {
                  break;
              }
          }

      } catch (DynamoDbException $e) {
          echo "Невозможно выполнить сканирование:\n";
          echo $e->getMessage() . "\n";
      }

      ?>
      ```

      Приведенный код сканирует таблицу `Series` и выводит сериалы с атрибутом `series_id` от 1 до 3. Все остальные элементы отбрасываются.

  1. Запустите программу:

      ```bash
      php SeriesScan.php
      ```

      Результат:

      ```text
      Сканирование таблицы Series.
      3: House of Cards
      3: The Office
      3: True Detective
      1: IT Crowd
      2: Silicon Valley
      ```

- Node.js {#node}

  1. Создайте файл `SeriesScan.js`, например с помощью редактора nano:

      ```bash
      nano SeriesScan.js
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}

      ```javascript
      var AWS = require("aws-sdk");

      AWS.config.update({
        region: "{{ region-id }}",
        endpoint: "<Document_API_эндпоинт>"
      });

      var docClient = new AWS.DynamoDB.DocumentClient();

      var params = {
          TableName: "Series",
          ProjectionExpression: "#sid, title, info.rating",
          FilterExpression: "#sid between :start_id and :end_id",
          ExpressionAttributeNames: {
              "#sid": "series_id",
          },
          ExpressionAttributeValues: {
                ":start_id": 1,
                ":end_id": 3
          }
      };

      console.log("Сканирование таблицы Series");
      docClient.scan(params, onScan);

      function onScan(err, data) {
          if (err) {
              console.error("Не удалось сканировать таблицу. Ошибка JSON:", JSON.stringify(err, null, 2));
          } else {
              console.log("Сканирование успешно.");
              data.Items.forEach(function(series) {
                  console.log(
                      series.series_id + ": ",
                      series.title);
              });

              if (typeof data.LastEvaluatedKey != "undefined") {
                  console.log("Сканирую далее...");
                  params.ExclusiveStartKey = data.LastEvaluatedKey;
                  docClient.scan(params, onScan);
              }
          }
      }
      ```

      Приведенный код сканирует таблицу `Series` и выводит сериалы с атрибутом `series_id` от 1 до 3. Все остальные элементы отбрасываются.

  1. Запустите программу:

      ```bash
      node SeriesScan.js
      ```

      Результат:

      ```text
      Сканирование таблицы Series
      Сканирование успешно.
      3:  House of Cards
      3:  The Office
      3:  True Detective
      1:  IT Crowd
      2:  Silicon Valley
      Сканирую далее...
      Сканирование успешно.
      ```

- Ruby {#ruby}

  1. Создайте файл `SeriesScan.rb`, например с помощью редактора nano:

      ```bash
      nano SeriesScan.rb
      ```

      Скопируйте в созданный файл следующий код:

      {% note warning %}

      Вместо `<Document_API_эндпоинт>` укажите [подготовленное ранее](index.md#before-you-begin) значение.

      {% endnote %}
  
      ```ruby
      require 'aws-sdk-dynamodb'

      def scan_for_items_from_table(dynamodb_client, scan_condition)
        loop do
          result = dynamodb_client.scan(scan_condition)

          if result.items.count.zero?
            puts 'Подходящих сериалов не найдено (пока)...'
          else
            puts "Найдено #{result.items.count} подходящих сериалов (пока):"
            result.items.each do |movie|
              puts "#{movie["title"]} (#{movie["series_id"].to_i}), " \
                "Rating: #{movie["info"]["rating"].to_f}"
            end
          end

          break if result.last_evaluated_key.nil?

          puts "Продолжается поиск сериалов..."
          scan_condition[:exclusive_start_key] = result.last_evaluated_key
        end
        puts 'Поиск завершен.'
      rescue StandardError => e
        puts "Ошибка сканирования: #{e.message}"
      end

      def run_me
        region = '{{ region-id }}'
        table_name = 'Series'
        start_id = 1
        end_id = 3

        Aws.config.update(
          endpoint: '<Document_API_эндпоинт>',
          region: region
        )

        dynamodb_client = Aws::DynamoDB::Client.new

        scan_condition = {
          table_name: table_name,
          projection_expression: '#series_id, title, info.rating',
          filter_expression: '#series_id between :start_id and :end_id',
          expression_attribute_names: { '#series_id' => 'series_id' },
          expression_attribute_values: {
            ':start_id' => start_id,
            ':end_id' => end_id
          }
        }

        puts "Поиск сериалов в таблице '#{table_name}' с id в диапазон от #{start_id} до #{end_id}..."

        scan_for_items_from_table(dynamodb_client, scan_condition)
      end

      run_me if $PROGRAM_NAME == __FILE__
      ```

      Приведенный код сканирует таблицу `Series` и выводит сериалы с атрибутом `series_id` от 1 до 3. Все остальные элементы отбрасываются.

  1. Запустите программу:

      ```bash
      ruby SeriesScan.rb
      ```

      Результат:

      ```text
      Поиск сериалов в таблице 'Series' с id в диапазон от 1 до 3...
      Найдено 5 подходящих сериалов (пока):
      House of Cards (3), Rating: 0.0
      The Office (3), Rating: 0.0
      True Detective (3), Rating: 0.0
      IT Crowd (1), Rating: 0.0
      Silicon Valley (2), Rating: 0.0
      Продолжается поиск сериалов...
      Подходящих сериалов не найдено (пока)...
      Поиск завершен.
      ```

{% endlist %}
