## Введение {#introduction}
[JDBC](https://en.wikipedia.org/wiki/Java_Database_Connectivity) — широко распространенный интерфейс для взаимодействия с базами данных из Java, который поддерживается во многих opensource- и проприетарных инструментах.
YQL JDBC Driver — библиотека, реализующая интерфейс JDBC, с помощью которой можно подключить некоторые из этих инструментов к YQL.

## Как воспользоваться из готового инструмента? {#how-to-use-a-ready-made-tool}
Инструкция по подключению YQL JDBC-драйвера в любом инструменте, поддерживающем обращение к базам данных через интерфейс JDBC.

1. [Скачать jar](http://artifactory.yandex.net/artifactory/yandex_infra/ru/yandex/yql/yql-jdbc/1.0.11/yql-jdbc-1.0.11-jar-with-dependencies.jar).
2. Найти в инструменте меню по добавлению нового JDBC-драйвера.
3. Заполнить поля (могут находиться как все рядом, так и быть разбиты на несколько меню, например отдельно для driver и connection):

  * Имя драйвера: `ru.yandex.yql.YqlDriver`.
  * JDBC URL: `jdbc:yql://yql.yandex.net:443/`, доступные дополнительные настройки описаны [ниже](#jdbc-url).
  * В username указываем свой логин, а в поле password — [YQL token](https://yql.yandex-team.ru/?settings_mode=token).
  * В поле с зависимостями (dependencies) указываем локальный путь к скачанному jar (см. первый пункт этой инструкции).

### На примере Apache Zeppelin {#using-the-apache-zeppelin-example}

#### Скачиваем, разархивируем, запускаем и открываем в браузере сам Apache Zeppelin. {#download-unzip-launch-and-open-apache-zeppelin-itself-in-the-browser}

* Должна быть установлена свежая версия Java: <https://www.java.com/en/download/> (если уже есть — можно пропустить).
* Скачать Zeppelin: <http://zeppelin.apache.org/download.html>.
* Установка: `$ tar xvvf zeppelin-*.tgz`.
* Запуск: `$ zeppelin*/bin/zeppelin-daemon.sh start`.
* Открываем в браузере <http://localhost:8080>, если Zeppelin был запущен локально, либо <http://myhostname:8080>.

#### Открываем настройки Interpeter. {#open-the-interpreter-settings}
![](https://jing.yandex-team.ru/files/blinkov/Screen%20Shot%202016-11-21%20at%2015.21.53.png)

#### Создаем новый интерпретатор YQL. {#creating-a-new-yql-interpreter}
![](https://jing.yandex-team.ru/files/blinkov/Screen%20Shot%202016-11-21%20at%2015.27.38.png)
Далее:
![](https://jing.yandex-team.ru/files/blinkov/Screen%20Shot%202016-11-21%20at%2015.28.47.png)
<blockquote>Нужные значения, чтобы было удобнее копировать:

* default.driver: `ru.yandex.yql.YqlDriver`;
* default.url:  `jdbc:yql://yql.yandex.net:443/`.</blockquote>

...и ниже:
![](https://jing.yandex-team.ru/files/blinkov/Screen%20Shot%202016-11-21%20at%2015.30.36.png)

#### Создаем Notebook с поддержкой YQL. {#creating-notebook-with-sql-support}

![](https://jing.yandex-team.ru/files/blinkov/Screen%20Shot%202016-11-21%20at%2015.31.17.png)

![](https://jing.yandex-team.ru/files/blinkov/Screen%20Shot%202016-11-21%20at%2015.32.22.png)

![](https://jing.yandex-team.ru/files/blinkov/Screen%20Shot%202016-11-21%20at%2015.33.05.png)

![](https://jing.yandex-team.ru/files/blinkov/Screen%20Shot%202016-11-21%20at%2015.34.54.png)


#### Запускаем YQL-запросы. {#run-sql-queries}
![](https://jing.yandex-team.ru/files/blinkov/Screen%20Shot%202016-11-19%20at%2000.04.48.png)


## Как использовать YQL JDBC Driver из кода? {#how-to-use-yql-jdbc-driver-from-code}
См. [программы-примеры](https://a.yandex-team.ru/arc/trunk/arcadia/yql/library/jdbc/examples).

Ниже описаны различные способы подключить к своей программе библиотеку, реализующую YQL JDBC Driver.

### В Аркадии {#in-arcadia}
Если ваш Java-проект живет в Аркадии, то чтобы подключить YQL JDBC Driver достаточно создать `PEERDIR`'а на `yql/library/jdbc`.
### JAR {#jar}
[Cкачать jar](http://artifactory.yandex.net/artifactory/yandex_infra/ru/yandex/yql/yql-jdbc/1.0.11/yql-jdbc-1.0.11-jar-with-dependencies.jar) и добавить его в `$CLASSPATH` или `java -cp`.

### Maven {#maven}
Секции для pom.xml:
``` xml
    <dependencies>
        <dependency>
            <groupId>ru.yandex.yql</groupId>
            <artifactId>yql-jdbc</artifactId>
            <version>1.0.11</version>
        </dependency>
    </dependencies>

    <repositories>
        <repository>
            <snapshots>
                <enabled>true</enabled>
                <updatePolicy>always</updatePolicy>
            </snapshots>
            <id>yandex-artifactory-snapshot</id>
            <url>http://artifactory.yandex.net/artifactory/public/</url>
        </repository>
    </repositories>
```
[Пример pom.xml целиком.](https://a.yandex-team.ru/arc/trunk/arcadia/yql/library/jdbc/examples/basic/pom.xml)

### deb-пакет {#deb-package}
Пока отсутствует, если вы бы им пользовались — напишите нам на [yql@](https://ml.yandex-team.ru/lists/yql), сделаем.

## JDBC URL {#jdbc-url}

* Общая схема: `jdbc:yql://host:port/cluster/table/path/prefix`.
* Минимальный пример: `jdbc:yql://yql.yandex.net:443/`.
* Максимальный пример: `jdbc:yql://yql.yandex.net:443/hahn/home/yql/tutorial`. Первый компонент пути указывает на имя кластера.
* Имя кластера и путь внутри к таблице в распределенной файловой системе кластера можно указать с помощью `USE cluster;` и `PRAGMA TablePathPrefix = "table/path/prefix";` соответственно. Если в указанном JDBC URL путь не пуст (как в предыдущем примере), то JDBC-драйвер автоматически добавляет к запросу названные `USE/PRAGMA`.

## Особенности реализации и ограничения {#implementation-features-and-limitations}

* В результате запроса, который возвращается в клиент (ResultSet), поддерживаются только [простые типы](../types/primitive.md) и их optional/nullable версии. Если в запросе выполняется только модификация данных (`INSERT INTO [path/to/table] SELECT ...`), то данные остаются на кластере и могут иметь любые типы, но и работать с ними на клиенте никак нельзя, кроме как через запуск следующего запроса с использованием `[path/to/table]` (с названными выше ограничениями на тип данных).
* С точки зрения пользователя запросы выполняются синхронно, но при получении ответа с большим числом строк, их скачивание на клиент происходет по мере обращения снаружи к соответствующим методам JDBC интерфейса.
* CallableStatement не поддерживаются.
* YQL JDBC-драйвер умеет возвращать схемы таблиц и список таблиц внутри `table/path/prefix` (**не** рекурсивно). Многие функции JDBC-интерфейса, актуальные для реляционных баз данных, для YQL/YT особого смысла не имеют, поэтому вместо них возвращаются заглушки.
* Стандарт **JDBC** реализован далеко не полностью. Если Вы столкнулись с исключением `SQLFeatureNotSupportedException()` при обращении к нужной вам функциональности JDBC-интерфейса, пишите на yql@, поможем.
* Для работы с беззнаковыми числами активно используются функции из Java 8. В более ранних версиях Java нет поддержки беззнаковых числовых типов, поэтому библиотека не будет работать корректно.

Если что-то из вышеперечисленного мешает вам воспользоваться данной библиотекой или у вас есть идеи для любого рода улучшений, — дайте нам, пожалуйста, знать на [yql@](mailto:yql@yandex-team.ru) или сразу в <https://st.yandex-team.ru/YQL.>
