# API в Managed Service for Apache Kafka®

В кластере доступно несколько видов API, позволяющих выполнять различные операции.

## Облачные API {#cloud-api}

Этот набор API предоставляется Yandex Cloud и включает в себя REST API и gRPC API. Любой из этих API может использоваться, чтобы работать со следующими объектами:

* [Кластерами Managed Service for Apache Kafka®](../operations/index.md#clusters) и [логами кластеров](../operations/cluster-logs.md).
* Некоторыми сущностями Apache Kafka®: [топиками](../operations/cluster-topics.md), [пользователями](../operations/cluster-accounts.md) и [коннекторами](../operations/cluster-connector.md).

### Использование {#cloud-api-usage}

Чтобы получить доступ к этим API, не нужно никаких дополнительных действий — они доступны всегда. Для работы с этими API необходимо [пройти аутентификацию](../api-ref/authentication.md) при выполнении запросов к API.

Доступные операции определяются [ролями аккаунта](../security/index.md), от имени которого выполняются запросы к API.

Описания [методов REST API](../api-ref/index.md) и [вызовов gRPC API](../api-ref/grpc/index.md) приведены в справочнике API. Примеры запросов — в [пошаговых инструкциях](../operations/index.md).

### Ограничения {#cloud-api-limits}

С помощью этих API можно управлять только частью сущностей Apache Kafka®. Чтобы получить расширенные возможности по управлению сущностями Apache Kafka®, используйте [Managed Service for Apache Kafka® REST API](#managed-kafka-api) или [Client API](#client-api).

## Managed Service for Apache Kafka® REST API {#managed-kafka-api}

Этот набор REST API предоставляется Yandex Cloud и включает в себя:

* REST API для Managed Schema Registry, совместимый с Confluent Schema Registry API версии 6.1 ([с некоторыми ограничениями](#managed-kafka-api-limits)).

    Этот API позволяет работать с [управляемым реестром схем формата данных](managed-schema-registry.md).

* REST API для Apache Kafka®, совместимый с Confluent REST Proxy API версии 6.1 ([с некоторыми ограничениями](#managed-kafka-api-limits)).

    Этот API позволяет работать с производителями и потребителями, используя схемы формата данных из реестра, а также просматривать информацию о брокерах, топиках и разделах.

В кластерах Managed Service for Apache Kafka® используется продукт с открытым исходным кодом [Karapace](https://www.karapace.io/), который предоставляет эти REST API, а также служит основой для управляемого реестра схем формата данных.

### Использование {#managed-kafka-api-usage}

Чтобы использовать любой из этих API:

1. Получите доступ к API.

    По умолчанию Managed Schema Registry и оба REST API выключены и недоступны. Чтобы воспользоваться ими, укажите соответствующие настройки при [создании](../operations/cluster-create.md) или [изменении](../operations/cluster-update.md) кластера:

    * **Реестр схем данных**. В кластере станут доступны Managed Schema Registry и соответствующий ему REST API.
    * **Kafka Rest API**. В кластере станет доступен REST API для Apache Kafka®.

    Хотя оба REST API предоставляются Karapace, они независимы друг от друга: например, можно использовать только Managed Schema Registry и его REST API, только REST API для Apache Kafka®, или все сразу.

1. [Выполните все шаги по предварительной настройке для подключения к кластеру](../operations/connect/index.md).

1. Пройдите аутентификацию при выполнении запросов к API.

    Используется механизм [HTTP Basic Authentication](https://developer.mozilla.org/ru-RU/docs/Web/HTTP/Authentication#базовая_basic_схема_аутентификации): каждый запрос должен содержать в себе HTTP-заголовок [Authorization](https://developer.mozilla.org/ru-RU/docs/Web/HTTP/Headers/Authorization) с реквизитами [пользователя Apache Kafka®](../operations/cluster-accounts.md), от имени которого выполняется запрос.

Доступные операции определяются [ролями пользователя Apache Kafka®](../operations/cluster-accounts.md), от имени которого выполняются запросы к API:

* REST API для Managed Schema Registry:

    * Роль `ACCESS_ROLE_SCHEMA_READER`: пользователю доступны операции чтения над [субъектами](managed-schema-registry.md#subjects), на которые назначена роль.
    * Роль `ACCESS_ROLE_SCHEMA_WRITER`: пользователю доступны операции чтения и записи над субъектами, на которые назначена роль.
    * Роль `ACCESS_ROLE_CONSUMER`: пользователю доступны операции чтения над субъектами, связанными с топиком, на который назначена роль.
    * Роль `ACCESS_ROLE_PRODUCER`: пользователю доступны любые операции над субъектами, связанными с топиком, на который назначена роль.
    * Роль `ACCESS_ROLE_ADMIN`: пользователю доступны любые операции над субъектами, связанными с любым топиком (эта роль назначается на все топики).
    * Роль `ACCESS_ROLE_TOPIC_ADMIN`: пользователю доступны любые операции над субъектами, связанными с топиком, на который назначена роль.

    Перечень субъектов, с которыми можно работать, также определяется ролью пользователя. Подробнее о ролевой модели Managed Schema Registry в разделе [Управление схемами данных](managed-schema-registry.md).

* REST API для Apache Kafka®:

    * Роль `ACCESS_ROLE_CONSUMER`: пользователь может получать информацию об объектах Apache Kafka®, а также работать с потребителями.
    * Роль `ACCESS_ROLE_ADMIN`, `ACCESS_ROLE_PRODUCER` или `ACCESS_ROLE_TOPIC_ADMIN`: пользователь может работать с объектами Apache Kafka® в полном объеме.

Описания методов [REST API для Managed Schema Registry](https://docs.confluent.io/platform/6.1/schema-registry/develop/api.html) и [REST API для Apache Kafka®](https://docs.confluent.io/platform/6.1/kafka-rest/api.html) приведены в документации Confluent. Пример работы с этими API в разделе [Работа с управляемым реестром схем формата данных с помощью REST API](../tutorials/managed-schema-registry-rest.md).

### Ограничения {#managed-kafka-api-limits}

* REST API для Managed Schema Registry:

    Ограничено использование [методов для управления режимом работы реестра](https://docs.confluent.io/platform/6.1/schema-registry/develop/api.html#mode):

    * Просматривать информацию о режимах работы реестра может только пользователь с правами `ACCESS_ROLE_ADMIN`.
    * Нельзя изменить режим работы реестра.

* REST API для Apache Kafka®:

    * Нельзя управлять кластерами и другими объектами Apache Kafka®, кроме производителей и потребителей.
    * Доступны только методы [Confluent REST Proxy API](https://docs.confluent.io/platform/6.1/kafka-rest/api.html) версии [v2](https://docs.confluent.io/platform/6.1/kafka-rest/api.html#crest-api-v2).

## Client API Apache Kafka® {#client-api}

Client API — общее название для набора нативных API Apache Kafka®:

* [Producer API](https://kafka.apache.org/42/apis/#producer-api) — позволяет работать с производителями.
* [Consumer API](https://kafka.apache.org/42/apis/#consumer-api) — позволяет работать с потребителями.
* [Streams API](https://kafka.apache.org/42/apis/#streams-api) — позволяет работать с потоками данных.
* [Connect API](https://kafka.apache.org/42/apis/#connect-api) — позволяет работать с коннекторами.
* [Admin API](https://kafka.apache.org/42/apis/#admin-api) — позволяет работать с объектами Apache Kafka®.

Эти API позволяют управлять объектами Apache Kafka® ([с некоторыми ограничениями](#client-api-limits)).

### Использование {#client-api-usage}

Чтобы использовать любой из этих API:

1. [Выполните предварительную настройку для подключения к кластеру](../operations/connect/index.md).

1. Встройте нужный API в код [приложения-клиента Apache Kafka®](../operations/connect/code-examples.md).

    Для работы с Client API необходимо вызывать нужные функции из кода приложений-клиентов — эти API не являются REST API.

1. Настройте в коде приложения-клиента нужный механизм аутентификации, чтобы взаимодействовать с API. При аутентификации используются реквизиты [пользователя Apache Kafka®](../operations/cluster-accounts.md).

    Механизмы аутентификации описаны в [документации Confluent для приложений-клиентов](https://docs.confluent.io/kafka-client/overview.html). Примеры настройки в разделе [Примеры кода для подключения к кластеру Apache Kafka®](../operations/connect/code-examples.md).

Доступные операции определяются [ролями пользователя Apache Kafka®](../operations/cluster-accounts.md), от имени которого выполняются запросы к Client API.

Описания Client API приведены в [документации Apache Kafka®](https://kafka.apache.org/42/apis/). Пример работы с Producer API и Consumer API в разделе [Работа с управляемым реестром схем формата данных](../tutorials/managed-schema-registry.md).

### Ограничения {#client-api-limits}

* Нельзя управлять кластерами и пользователями Apache Kafka®.
* Можно управлять топиками с помощью Admin API, но со следующими ограничениями:

    * Для управления топиками используются:
       * пользователь-администратор с ролью `ACCESS_ROLE_ADMIN`, которая действует для всех топиков кластера. Если такого пользователя в кластере нет, [создайте](../operations/cluster-accounts.md) его;
       * пользователь с ролью `ACCESS_ROLE_TOPIC_ADMIN`, которая задается на произвольные топики.
    
       [Подробнее](account-roles.md) о правах, которые предоставляет каждая роль.
    
    * Права доступа пользователей для [производителей и потребителей](producers-consumers.md) настраиваются с помощью стандартных интерфейсов Yandex Cloud, а не Admin API Apache Kafka®.


## Примеры использования {#examples}

* [Работа с управляемым реестром схем формата данных с помощью REST API](../tutorials/managed-schema-registry-rest.md)