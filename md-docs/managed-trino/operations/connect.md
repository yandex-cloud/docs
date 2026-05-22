# Подключение к кластеру Trino

В этом разделе представлены настройки для подключения к кластеру Managed Service for Trino с помощью [инструментов командной строки](#cli-tools), из [графических IDE](#connection-ide) и [WebSQL](#websql). О подключении из кода вашего приложения см. [Примеры строк подключения](#connection-strings).

Подключаться к кластеру Managed Service for Trino, у которого включен [приватный доступ](../concepts/network.md#private-endpoint), можно только из той сети, в которой расположен кластер.

{% note info %}

Если для подключения требуется указывать порт, используйте порт `443`.

{% endnote %}

## Настройка групп безопасности {#configuring-security-groups}

[Группы безопасности](../../vpc/concepts/security-groups.md) не ограничивают входящий трафик кластера Managed Service for Trino и не влияют на доступность веб-интерфейса Trino. Настраивать правила для входящего трафика не нужно.

Вы можете использовать группы безопасности, чтобы задавать правила для исходящего трафика, например при настройке нового [каталога](../concepts/index.md#catalog).

Чтобы подключаться к кластеру Trino с виртуальной машины в Yandex Cloud, настройте группу безопасности ВМ, с которой будет происходить подключение. Пример правил для ВМ:

* Для входящего трафика:

    * **Диапазон портов** — `22`.
    * **Протокол** — `TCP`.
    * **Источник** — `CIDR`.
    * **CIDR блоки** — `0.0.0.0/0`.

    Это правило позволяет подключаться к ВМ по протоколу [SSH](../../glossary/ssh-keygen.md).

* Для исходящего трафика:

    * **Протокол** — `Любой` (`Any`).
    * **Диапазон портов** — `0-65535`.
    * **Назначение** — `CIDR`.
    * **CIDR блоки** — `0.0.0.0/0`.

    Это правило разрешает любой исходящий трафик, что позволяет не только подключаться к кластеру, но и устанавливать на ВМ необходимые для этого утилиты.

### Группы безопасности для работы с Yandex MPP Analytics for PostgreSQL {#security-groups-for-greenplum}

Для подключения к кластеру Greenplum® коннектор Trino использует протокол GPFDIST:

* Координаторы и воркеры Trino выполняют запросы к мастеру Greenplum® через TCP-порт 6432.
* Сегменты Greenplum® передают данные на воркеры Trino через TCP-порт GPFDIST из диапазона 30078–30085.

Данные, передающиеся по протоколу GPFDIST между кластерами Greenplum® и Trino, не шифруются. Чтобы обеспечить безопасное подключение, настройте группы безопасности [на стороне Yandex MPP Analytics for PostgreSQL](#configuring-security-groups-greenplum) и (опционально) [на стороне Managed Service for Trino](#configuring-security-groups-trino).

#### Настройка на стороне Yandex MPP Analytics for PostgreSQL {#configuring-security-groups-greenplum}

{% list tabs group=traffic %}

- Входящий трафик {#incoming}

    * Правило для трафика внутри кластера Greenplum®:

        * **Диапазон портов** — `0-65535`.
        * **Протокол** — `Любой` (`Any`).
        * **Источник** — `Группа безопасности`.
        * **Группа безопасности** — `Текущая` (`Self`).

    * Правило для подключения из кластера Trino:

        * **Диапазон портов** — `6432`.
        * **Протокол** — `TCP`.
        * **Источник** — `Группа безопасности`.
        * **Группа безопасности** — укажите группу безопасности кластера Trino.

- Исходящий трафик {#outgoing}

    * Правило для трафика внутри кластера Greenplum®:

        * **Диапазон портов** — `0-65535`.
        * **Протокол** — `Любой` (`Any`).
        * **Источник** — `Группа безопасности`.
        * **Группа безопасности** — `Текущая` (`Self`).

    * Правило для подключения к кластеру Trino:

        * **Диапазон портов** — `30078-30085`.
        * **Протокол** — `TCP`.
        * **Источник** — `Группа безопасности`.
        * **Группа безопасности** — укажите группу безопасности кластера Trino.

{% endlist %}

#### Настройка на стороне Managed Service for Trino {#configuring-security-groups-trino}

Правила групп безопасности на стороне Trino настраиваются зеркально правилам на стороне Greenplum®. Настройка правил для кластера Trino является опциональной, но позволяет дополнительно обезопасить кластер.

{% list tabs group=traffic %}

- Входящий трафик {#incoming}

    Правило для приема данных от сегментов Greenplum®:

    * **Диапазон портов** — `30078-30085`.
    * **Протокол** — `TCP`.
    * **Источник** — `Группа безопасности`.
    * **Группа безопасности** — укажите группу безопасности кластера Greenplum®.

- Исходящий трафик {#outgoing}

    Правило для подключения к мастеру Greenplum®:

    * **Диапазон портов** — `6432`.
    * **Протокол** — `TCP`.
    * **Источник** — `Группа безопасности`.
    * **Группа безопасности** — укажите группу безопасности кластера Greenplum®.

{% endlist %}

## Инструменты командной строки {#cli-tools}

### Trino CLI {#trino-cli}

Если у вас еще нет интерфейса командной строки Trino, установите его по [инструкции на официальном сайте Trino](https://trino.io/docs/current/client/cli.html#installation).

Чтобы подключиться к кластеру Managed Service for Trino:

1. Создайте [IAM-токен](../../iam/concepts/authorization/iam-token.md) и поместите его в переменную окружения `TRINO_PASSWORD`:

   ```bash
   export TRINO_PASSWORD=$(yc iam create-token)
   ```

   IAM-токен, хранящийся в переменной `TRINO_PASSWORD`, служит паролем для подключения к кластеру Managed Service for Trino. Чтобы использовать его, укажите при подключении флаг `--password`.

1. Подключитесь к кластеру Managed Service for Trino:

   ```bash
   ./trino c-<идентификатор_кластера>.trino.yandexcloud.net --user iam --password
   ```

   Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

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
     1. Выберите в меню **File** → **New** → **Data Source** → **Trino**.
     1. Введите имя источника данных.
     1. Укажите параметры подключения на вкладке **General**:
        * **Host** — `c-<идентификатор_кластера>.trino.yandexcloud.net`.

            Если вы подключаетесь к кластеру Managed Service for Trino через [сервисное подключение](../concepts/network.md#сервисное-подключение-private-endpoint), то в качестве адреса хоста укажите `c-<идентификатор_кластера>.trino.pe.yandexcloud.net`.

        * **Port** — `443`.
        * **User** — `iam`.
        * **Password** — созданный ранее IAM-токен.
  1. Нажмите ссылку **Test Connection** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **OK**, чтобы сохранить источник данных.

- DBeaver {#dbeaver}

  1. Создайте новое соединение с БД:
     1. Выберите в меню **База данных** пункт **Новое соединение**.
     1. Выберите из списка **Trino**.
     1. Нажмите кнопку **Далее**.
     1. Укажите параметры подключения на вкладке **Главное**:
        * **Хост** — `c-<идентификатор_кластера>.trino.yandexcloud.net`.

            Если вы подключаетесь к кластеру Managed Service for Trino через [сервисное подключение](../concepts/network.md#сервисное-подключение-private-endpoint), то в качестве адреса хоста укажите `c-<идентификатор_кластера>.trino.pe.yandexcloud.net`.

        * **Порт** — `443`.
        * В блоке **Аутентификация** укажите:
            * Имя пользователя — `iam`;
            * Пароль пользователя — созданный ранее IAM-токен.
  1. Нажмите кнопку **Тест соединения ...** для проверки подключения. При успешном подключении будет выведен статус подключения, информация о СУБД и драйвере.
  1. Нажмите кнопку **Готово**, чтобы сохранить настройки соединения с БД.

{% endlist %}

## WebSQL {#websql}

1. Перейдите на [страницу каталога](https://console.yandex.cloud).
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Trino**.
1. Откройте ваш кластер Managed Service for Trino.
1. Перейдите в раздел **WebSQL**.
1. Нажмите кнопку **Перейти в WebSQL**.
1. В открывшемся редакторе SQL-запросов выполните запрос:

   ```sql
   SELECT version() AS version;
   ```

   В ответе на запрос будет информация о версии Trino.

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
          with closing(connect(host=COORDINATOR_URL, port=443, auth=auth, request_timeout=TIMEOUT)) as conn:
              with closing(conn.cursor()) as cur:
                  cur.execute('SELECT version() as version')
                  rows = cur.fetchall()
                  print(rows[0])

      if __name__ == "__main__":
          get_version()
      ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     Если вы подключаетесь к кластеру Managed Service for Trino через [сервисное подключение](../concepts/network.md#сервисное-подключение-private-endpoint), то в качестве адреса хоста укажите `c-<идентификатор_кластера>.trino.pe.yandexcloud.net`.

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

      Если вы подключаетесь к кластеру Managed Service for Trino через [сервисное подключение](../concepts/network.md#сервисное-подключение-private-endpoint), то в качестве адреса хоста укажите `c-<идентификатор_кластера>.trino.pe.yandexcloud.net`.

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

    Если вы подключаетесь к кластеру Managed Service for Trino через [сервисное подключение](../concepts/network.md#сервисное-подключение-private-endpoint), то в качестве адреса хоста укажите `c-<идентификатор_кластера>.trino.pe.yandexcloud.net`.

{% endlist %}

Подключение:

```bash
node app.mjs
```