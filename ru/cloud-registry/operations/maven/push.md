---
title: Загрузить Maven-артефакт в реестр {{ cloud-registry-full-name }}
description: Инструкция описывает, как создать, собрать и загрузить Maven-артефакт в реестр {{ cloud-registry-name }}.
---

# Загрузить Maven-артефакт в реестр {{ cloud-registry-name }}

Инструкция описывает, как создать, собрать и загрузить [Maven-артефакт](../../concepts/maven.md) в реестр.

{% note info %}

Чтобы загрузить артефакт, необходимо [настроить Maven](installation.md) и [аутентифицироваться](authentication.md) в реестре.

{% endnote %}

Для загрузки Maven-артефакта в реестр необходима [роль](../../security/index.md#cloud-registry-artifacts-pusher) `cloud-registry.artifacts.pusher` или выше.

{% list tabs group=instructions %}

- CLI {#cli}

  1. (Опционально) Если у вас еще нет Maven-проекта, создайте его с помощью архетипа:

     ```bash
     mvn archetype:generate \
       -DgroupId=com.example \
       -DartifactId=my-app \
       -DarchetypeArtifactId=maven-archetype-quickstart \
       -DinteractiveMode=false
     ```

     Результат:

     ```text
     [INFO] Project created from Archetype in dir: <путь>/my-app
     ```

     Перейдите в директорию проекта:

     ```bash
     cd my-app
     ```

  1. (Опционально) Если артефакт еще не собран, соберите Maven-артефакт:

     ```bash
     mvn clean package
     ```

     Результат:

     ```text
     [INFO] Building jar: <путь>/my-app/target/my-app-1.0-SNAPSHOT.jar
     [INFO] BUILD SUCCESS
     ```

     После выполнения команды будет создан JAR-файл в директории `target/`.

  1. (Опционально) Посмотрите список собранных артефактов в директории `target/`:

     ```bash
     ls -la target/*.jar
     ```

     Результат:

     ```text
     -rw-r--r-- 1 user user 1234 Dec 10 10:00 target/my-app-1.0-SNAPSHOT.jar
     ```

  1. Убедитесь, что в файле `pom.xml` указаны корректные `groupId`, `artifactId` и `version`:

     ```xml
     <groupId>com.example</groupId>
     <artifactId>my-app</artifactId>
     <version>1.0-SNAPSHOT</version>
     ```

  1. Настройте реестр для деплоя в файле `pom.xml`, добавив секцию `distributionManagement`:

     ```xml
     <distributionManagement>
         <repository>
             <id>local</id>
             <url>{{ cloud-registry }}/maven/<идентификатор_реестра></url>
         </repository>
     </distributionManagement>
     ```

     Где `id` должен совпадать с `id` сервера в файле `~/.m2/settings.xml`.

  1. Загрузите артефакт в реестр:

     ```bash
     mvn deploy
     ```

     Результат:

     ```text
     [INFO] Uploading to local: {{ cloud-registry }}/maven/<идентификатор_реестра>/com/example/my-app/1.0-SNAPSHOT/my-app-1.0-SNAPSHOT.jar
     [INFO] Uploaded to local: {{ cloud-registry }}/maven/<идентификатор_реестра>/com/example/my-app/1.0-SNAPSHOT/my-app-1.0-SNAPSHOT.jar
     [INFO] BUILD SUCCESS
     ```

{% endlist %}
