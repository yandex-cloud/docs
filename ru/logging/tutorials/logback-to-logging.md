---
title: "Передача логов Java-приложения через Logback в {{ cloud-logging-name }}"
description: "Настойка Java-приложения, использующего Logback, для передачи логов в {{ cloud-logging-name }}. Для передачи используется sidecar, который запускается вместе с приложением и передает логи в формате FluentBit"
---

# Передача логов Java-приложения через Logback в {{ cloud-logging-name }}

Для того, чтобы собирать логи Java-приложений в {{ cloud-logging-name }} можно использовать подход с использованием sidecar - взять Fluent Bit plugin от Yandex, добавить в него минимально необходимую конфигурацию и подключить его к Logback как внешний appender.

Такой подход позволяет запускать COI без дополнительной конфигурации cloud-init, только с docker-compose с минимальной конфигурацией. 

Для того, чтобы это сделать необходимо

1. Настроить доступы для сервисного аккаунта
1. Создать группу логов.
1. Подготовить образ для sidecar (может Яндекс соберёт свой???)
1. Добавить зависимости и конфигурацию appender для Logback
1. Создать сервер с COI и docker-compose описанием процессов

### Доступы для сервисного аккаунта

Необходимо создать сервисный аккаунт (или использовать существующий) со следующими ролями logging.writer, container-registry.images.puller. Он будет использоваться при создании сервера.

### Создать группу логов

Для того, чтобы определить место получения логов используется понятие группы логов. Идентификатор группы будет использоваться при создании sidecar.

### Подготовить образ для sidecar

Код для сборки образа можно взять тут https://github.com/abashev/fluent-bit-plugin-yandex/tree/master/docker

Для сборки используется текущая версия fluent-bit-plugin-yandex и файл с минимально необходимой конфигурацией.

В качестве INPUT используется - `Port 24224`
Для OUTPUT указана группа ${YC_GROUP_ID}, которая будет приходить из environment variables. Авторизация будет через сервисный аккаунт `authorization   instance-service-account`

Собранный image нужно положить в свой Container Registry

### Добавить зависимости и конфигурацию appender для Logback

Для того, чтобы подключить передачу логов в формате FluentBit необходимо к проекту добавить две зависимости

Для Gradle

    ```
	runtimeOnly 'org.komamitsu:fluency:1.8.1'
	runtimeOnly 'com.sndyuk:logback-more-appenders:1.5.0'
    ```

Дальше в конфигурации logback.xml

    ```xml
    <appender name="fluency" class="ch.qos.logback.more.appenders.FluencyLogbackAppender">
        <!-- Имя sidecar контейнера -->
        <remoteHost>fluentbit</remoteHost>
        <port>24224</port>
    </appender>
    ```
И для необходимой категории добавить ссылку на этот appender

    ```xml
    <root level="info">
        <appender-ref ref="fluency" />
    </root>
    ```

### Создать сервер с COI и docker-compose описанием процессов

Дальше в консоли или cli создается сервер со следующей docker-compose конфигурацией

```yaml
version: "3.8"
services:
  hello-logs:
    # Образ приложения с конфигурацией logback
    image: "cr.yandex/crptou31111111111/hello-logs:latest"
    links:
      - fluentbit

  fluentbit:
    # Образ sidecar, который подготовили на третьем шаге
    image: "cr.yandex/crptou31111111111/fluent-bit-plugin-yandex"
    ports:
      - 24224:24224
      - 24224:24224/udp
    restart: always
    environment:
      # Идентификатор группы логов
      YC_GROUP_ID: eeeeeeeeeeeee
```
