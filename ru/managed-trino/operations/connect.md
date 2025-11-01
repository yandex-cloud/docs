---
title: Подключение к кластеру {{ TR }}
description: Следуя данной инструкции, вы сможете подключиться к кластеру {{ TR }}.
keywords:
  - подключение к кластеру {{ TR }}
---

# Подключение к кластеру {{ TR }}

В этом разделе представлены настройки для подключения к кластеру {{ mtr-name }} с помощью [инструментов командной строки](#cli-tools), из [графических IDE](#connection-ide) и [WebSQL](#websql). О подключении из кода вашего приложения см. [Примеры строк подключения](#connection-strings).

{% note info %}

Если для подключения требуется указывать порт, используйте порт `{{ port-https }}`.

{% endnote %}

## Инструменты командной строки {#cli-tools}

### {{ TR }} CLI {#trino-cli}

{% include [trino-cli-connect](../../_includes/managed-trino/trino-cli-connect.md) %}

## Подключение из графических IDE {#connection-ide}

Перед подключением:

1. Создайте [IAM-токен](../../iam/concepts/authorization/iam-token.md):

   ```bash
   yc iam create-token
   ```

1. Сохраните полученный токен. Он будет использоваться в качестве пароля при подключении.

{% list tabs group=ide %}

- DataGrip {#datagrip}

  1. Создайте источник данных:
     1. Выберите в меню **File** → **New** → **Data Source** → **{{ TR }}**.
     1. Введите имя источника данных.
     1. Укажите параметры подключения на вкладке **General**:
        * **Host** — `c-<идентификатор_кластера>.trino.yandexcloud.net`;
        * **Port** — `{{ port-https }}`;
        * **User** — `iam`;
        * **Password** — созданный ранее IAM-токен.
  1. Нажмите ссылку **Test Connection** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **OK**, чтобы сохранить источник данных.

- DBeaver {#dbeaver}

  1. Создайте новое соединение с БД:
     1. Выберите в меню **База данных** пункт **Новое соединение**.
     1. Выберите из списка **{{ TR }}**.
     1. Нажмите кнопку **Далее**.
     1. Укажите параметры подключения на вкладке **Главное**:
        * **Хост** — `c-<идентификатор_кластера>.trino.yandexcloud.net`;  
        * **Порт** — `{{ port-https }}`.
        * В блоке **Аутентификация** укажите:
            * Имя пользователя — `iam`;
            * Пароль пользователя — созданный ранее IAM-токен.
  1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

{% endlist %}

## WebSQL {#websql}

1. В [консоли управления]({{ link-console-main }}) откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
1. Откройте ваш кластер {{ mtr-name }}.
1. Перейдите в раздел **{{ ui-key.yacloud.mdb.cluster.switch_explore-websql }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.websql-connections.action_go-to-websql }}**.
1. В открывшемся редакторе SQL-запросов выполните запрос:

   ```sql
   SELECT version() AS version;
   ```

   В ответе на запрос будет информация о версии {{ TR }}.

## Примеры строк подключения {#connection-strings}

### Python {#python}

Перед подключением:

1. Установите зависимости:

   ```bash
   pip3 install trino
   ```

1. Создайте [IAM-токен](../../iam/concepts/authorization/iam-token.md) и поместите его в переменную окружения `TOKEN`:

   ```bash
   export TOKEN=$(yc iam create-token)
   ```

{% list tabs group=instruction %}

- Подключение {#connecting}

  1. Пример кода:

      `connect.py`

      ```python
      import os
      from contextlib import closing
      from trino.dbapi import connect
      from trino.auth import BasicAuthentication

      TIMEOUT = 10
      COORDINATOR_URL = 'c-<идентификатор_кластера>.trino.yandexcloud.net'
      IAM_TOKEN = os.environ['TOKEN']

      def get_version():
          auth = BasicAuthentication(username='iam', password=IAM_TOKEN)
          with closing(connect(host=COORDINATOR_URL, port={{ port-https }}, auth=auth, request_timeout=TIMEOUT)) as conn:
              with closing(conn.cursor()) as cur:
                  cur.execute('SELECT version() as version')
                  rows = cur.fetchall()
                  print(rows[0])

      if __name__ == "__main__":
          get_version()
      ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Подключение:

      ```bash
      python3 connect.py
      ```

{% endlist %}

### Java {#java}

Перед подключением:

1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install --yes openjdk-21-jre maven
    ```

1. Создайте директорию для проекта Maven:

    ```bash
    cd ~/ && mkdir -p project/src/main/java/com/example && cd project/
    ```

1. Создайте конфигурационный файл для Maven:

    {% cut "pom.xml" %}

    ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">

        <modelVersion>4.0.0</modelVersion>
        <groupId>com.example</groupId>
        <artifactId>app</artifactId>
        <version>0.1.0</version>
        <packaging>jar</packaging>
        <properties>
            <maven.compiler.source>21</maven.compiler.source>
            <maven.compiler.target>21</maven.compiler.target>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        </properties>
        <dependencies>
            <dependency>
                <groupId>io.trino</groupId>
                <artifactId>trino-jdbc</artifactId>
                <version>469</version>
            </dependency>
        </dependencies>
        <build>
            <finalName>${project.artifactId}-${project.version}</finalName>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-assembly-plugin</artifactId>
                    <version>3.7.1</version>
                    <executions>
                        <execution>
                            <goals>
                                <goal>single</goal>
                            </goals>
                            <phase>package</phase>
                            <configuration>
                                <descriptorRefs>
                                    <descriptorRef>
                                        jar-with-dependencies</descriptorRef>
                                </descriptorRefs>
                                <archive>
                                    <manifest>
                                        <mainClass>com.example.App</mainClass>
                                    </manifest>
                                </archive>
                            </configuration>
                        </execution>
                    </executions>
                </plugin>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-jar-plugin</artifactId>
                    <version>3.4.2</version>
                    <configuration>
                        <archive>
                            <manifest>
                                <mainClass>com.example.App</mainClass>
                            </manifest>
                        </archive>
                    </configuration>
                </plugin>
            </plugins>
        </build>
    </project>

    ```

    {% endcut %}  

1. Создайте [IAM-токен](../../iam/concepts/authorization/iam-token.md) и поместите его в переменную окружения `TOKEN`:

   ```bash
   export TOKEN=$(yc iam create-token)
   ```

{% list tabs group=connection %}

- Подключение {#connecting}

  1. Пример кода:

      `src/main/java/com/example/App.java`

      ```java
      package com.example;

      import java.sql.DriverManager;
      import java.util.Properties;

      public class App {
          private static final String COORDINATOR_URL = "c-<идентификатор_кластера>.trino.yandexcloud.net";

          public static void main(String[] args) {
              String url = String.format("jdbc:trino://%s", COORDINATOR_URL);
              String iamToken = System.getenv("TOKEN");
        
              Properties properties = new Properties();
              properties.setProperty("user", "iam");
              properties.setProperty("password", iamToken);
              properties.setProperty("SSL", "true");

              try (var connection = DriverManager.getConnection(url, properties)) {
                  var rs = connection.createStatement().executeQuery("SELECT version() as VERSION");
                  if (rs.next()) {
                      System.out.println(rs.getString(1));
                  }
              } catch (Exception e) {
                  e.printStackTrace();
              }
          }
      }

      ```

      Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Сборка и подключение:

      ```bash
      mvn clean package && \
      java -jar target/app-0.1.0-jar-with-dependencies.jar
      ```

{% endlist %}

### Node.js {#nodejs}

Перед подключением:
1. Установите зависимости:

    ```bash
    sudo apt update && sudo apt install --yes nodejs npm && \
    npm install trino-client
    ```

1. Создайте [IAM-токен](../../iam/concepts/authorization/iam-token.md) и поместите его в переменную окружения `TOKEN`:

   ```bash
   export TOKEN=$(yc iam create-token)
   ```

{% list tabs group=connection %}

- Подключение {#connecting}

    `app.mjs`

    ```javascript
    "use strict";
    import {BasicAuth, Trino} from 'trino-client';

    const COORDINATOR_URL = 'c-<идентификатор_кластера>.trino.yandexcloud.net'
    let TOKEN = process.env.TOKEN

    async function get_version() {
        const trino = Trino.create({server: COORDINATOR_URL,auth: new BasicAuth('iam', TOKEN)});
        const query = await trino.query('SELECT version() as VERSION');
        const queryResult = await query.next()
        console.log(queryResult.value.data[0][0])
    }

    get_version();
    ```

    Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

Подключение:

```bash
node app.mjs
```
