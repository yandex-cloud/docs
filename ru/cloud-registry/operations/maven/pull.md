---
title: Скачать Maven-артефакт из реестра {{ cloud-registry-full-name }}
description: Инструкция описывает, как скачать Maven-артефакт из реестра {{ cloud-registry-name }}.
---

# Скачать Maven-артефакт из реестра {{ cloud-registry-name }}

Для скачивания [Maven-артефакта](../../concepts/maven.md) необходима [роль](../../security/index.md#cloud-registry-artifacts-puller) `cloud-registry.artifacts.puller` или выше.

Чтобы работать с Maven-артефактами, [настройте Maven](installation.md).

{% list tabs group=instructions %}

- CLI {#cli}

  1. Выберите необходимый вам Maven-артефакт.
  1. Скачайте Maven-артефакт из [реестра](../../concepts/registry.md):

     * **Через зависимости в `pom.xml`**:

       Добавьте зависимость в файл `pom.xml` вашего проекта:

       ```xml
       <dependencies>
           <dependency>
               <groupId>com.example</groupId>
               <artifactId>my-app</artifactId>
               <version>1.0-SNAPSHOT</version>
           </dependency>
       </dependencies>
       ```
       Выполните команду для загрузки зависимостей:

       ```bash
       mvn dependency:resolve
       ```

       Результат:

       ```text
       [INFO] Downloading from local: {{ cloud-registry }}/maven/<идентификатор_реестра>/com/example/my-app/1.0-SNAPSHOT/my-app-1.0-SNAPSHOT.jar
       [INFO] Downloaded from local: {{ cloud-registry }}/maven/<идентификатор_реестра>/com/example/my-app/1.0-SNAPSHOT/my-app-1.0-SNAPSHOT.jar
       [INFO] BUILD SUCCESS
       ```

     * **Напрямую с помощью команды**:

       ```bash
       mvn dependency:get \
         -DgroupId=com.example \
         -DartifactId=my-app \
         -Dversion=1.0-SNAPSHOT \
         -DremoteRepositories={{ cloud-registry }}/maven/<идентификатор_реестра>
       ```

       Результат:

       ```text
       [INFO] Downloading from local: {{ cloud-registry }}/maven/<идентификатор_реестра>/com/example/my-app/1.0-SNAPSHOT/my-app-1.0-SNAPSHOT.jar
       [INFO] Downloaded from local: {{ cloud-registry }}/maven/<идентификатор_реестра>/com/example/my-app/1.0-SNAPSHOT/my-app-1.0-SNAPSHOT.jar
       [INFO] BUILD SUCCESS
       ```

  1. Проверьте, что артефакт скачан:

     ```bash
     ls -la ~/.m2/repository/com/example/my-app/1.0-SNAPSHOT/
     ```

     Результат:

     ```text
     -rw-r--r-- 1 user user 1234 Dec 10 10:00 my-app-1.0-SNAPSHOT.jar
     -rw-r--r-- 1 user user  567 Dec 10 10:00 my-app-1.0-SNAPSHOT.pom
     ```

{% endlist %}
