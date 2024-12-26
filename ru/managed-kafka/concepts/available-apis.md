# API в {{ mkf-name }}

В кластере доступно несколько видов API, позволяющих выполнять различные операции.

## Облачные API {#cloud-api}

Этот набор API предоставляется {{ yandex-cloud }} и включает в себя REST API и gRPC API. Любой из этих API может использоваться, чтобы работать со следующими объектами:

* [Кластерами {{ mkf-name }}](../operations/index.md#clusters) и [логами кластеров](../operations/cluster-logs.md).
* Некоторыми сущностями {{ KF }}: [топиками](../operations/cluster-topics.md), [пользователями](../operations/cluster-accounts.md) и [коннекторами](../operations/cluster-connector.md).

### Использование {#cloud-api-usage}

Чтобы получить доступ к этим API, не нужно никаких дополнительных действий — они доступны всегда. Для работы с этими API необходимо [пройти аутентификацию](../api-ref/authentication.md) при выполнении запросов к API.

Доступные операции определяются [ролями аккаунта](../security/index.md), от имени которого выполняются запросы к API.

Описания [методов REST API](../api-ref/index.md) и [вызовов gRPC API](../api-ref/grpc/index.md) приведены в справочнике API. Примеры запросов см. в [пошаговых инструкциях](../operations/index.md).

### Ограничения {#cloud-api-limits}

С помощью этих API можно управлять только частью сущностей {{ KF }}. Чтобы получить расширенные возможности по управлению сущностями {{ KF }}, используйте [{{ mkf-short-name }} REST API](#managed-kafka-api) или [Client API](#client-api).

## {{ mkf-short-name }} REST API {#managed-kafka-api}

Этот набор REST API предоставляется {{ yandex-cloud }} и включает в себя:

* REST API для {{ mkf-msr }}, совместимый с Confluent Schema Registry API версии {{ mkf.kp-api-version }} ([с некоторыми ограничениями](#managed-kafka-api-limits)).

    Этот API позволяет работать с [управляемым реестром схем формата данных](./managed-schema-registry.md).

* REST API для {{ KF }}, совместимый с Confluent REST Proxy API версии {{ mkf.kp-api-version }} ([с некоторыми ограничениями](#managed-kafka-api-limits)).

    Этот API позволяет работать с производителями и потребителями, используя схемы формата данных из реестра, а также просматривать информацию о брокерах, топиках и разделах.

В кластерах {{ mkf-name }} используется продукт с открытым исходным кодом [{{ mkf.kp }}](https://www.karapace.io/), который предоставляет эти REST API, а также служит основой для управляемого реестра схем формата данных.

### Использование {#managed-kafka-api-usage}

Чтобы использовать любой из этих API:

1. Получите доступ к API.

    По умолчанию {{ mkf-msr }} и оба REST API выключены и недоступны. Чтобы воспользоваться ими, укажите соответствующие настройки при [создании](../operations/cluster-create.md) или [изменении](../operations/cluster-update.md) кластера:

    * **{{ ui-key.yacloud.kafka.field_schema-registry }}**. В кластере станут доступны {{ mkf-msr }} и соответствующий ему REST API.
    * **{{ ui-key.yacloud.kafka.field_rest-api-config }}**. В кластере станет доступен REST API для {{ KF }}.

    Хотя оба REST API предоставляются {{ mkf.kp }}, они независимы друг от друга: например, можно использовать только {{ mkf-msr }} и его REST API, только REST API для {{ KF }}, или все сразу.

1. [Выполните все шаги по предварительной настройке для подключения к кластеру](../operations/connect/index.md).

1. Пройдите аутентификацию при выполнении запросов к API.

    Используется механизм [HTTP Basic Authentication](https://developer.mozilla.org/ru-RU/docs/Web/HTTP/Authentication#базовая_basic_схема_аутентификации): каждый запрос должен содержать в себе HTTP-заголовок [Authorization](https://developer.mozilla.org/ru-RU/docs/Web/HTTP/Headers/Authorization) с реквизитами [пользователя {{ KF }}](../operations/cluster-accounts.md), от имени которого выполняется запрос.

Доступные операции определяются [ролями пользователя {{ KF }}](../operations/cluster-accounts.md), от имени которого выполняются запросы к API:

* REST API для {{ mkf-msr }}:

    * Роль `ACCESS_ROLE_CONSUMER`: пользователю доступны операции чтения над [субъектами](./managed-schema-registry.md#subjects), связанными с топиком, на который назначена роль.
    * Роль `ACCESS_ROLE_PRODUCER`: пользователю доступны любые операции над субъектами, связанными с топиком, на который назначена роль.
    * Роль `ACCESS_ROLE_ADMIN`: пользователю доступны любые операции над субъектами, связанными с любым топиком (эта роль назначается на все топики).

    Перечень субъектов, с которыми можно работать, также определяется ролью пользователя. Подробнее о ролевой модели {{ mkf-msr }} см. в разделе [{#T}](./managed-schema-registry.md).

* REST API для {{ KF }}:

    * Роль `ACCESS_ROLE_CONSUMER`: пользователь может получать информацию об объектах {{ KF }}, а также работать с потребителями.
    * Роль `ACCESS_ROLE_ADMIN` или `ACCESS_ROLE_PRODUCER`: пользователь может работать с объектами {{ KF }} в полном объеме.

Описания методов [REST API для {{ mkf-msr }}](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/schema-registry/develop/api.html) и [REST API для {{ KF }}](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/kafka-rest/api.html) приведены в документации Confluent. Пример работы с этими API см. в разделе [{#T}](../tutorials/managed-schema-registry-rest.md).

### Ограничения {#managed-kafka-api-limits}

* REST API для {{ mkf-msr }}:

    Ограничено использование [методов для управления режимом работы реестра](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/schema-registry/develop/api.html#mode):

    * Просматривать информацию о режимах работы реестра может только пользователь с правами `ACCESS_ROLE_ADMIN`.
    * Нельзя изменить режим работы реестра.

* REST API для {{ KF }}:

    * Нельзя управлять кластерами и другими объектами {{ KF }}, кроме производителей и потребителей.
    * Доступны только методы [Confluent REST Proxy API](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/kafka-rest/api.html) версии [v2](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/kafka-rest/api.html#crest-api-v2).

## Client API {{ KF }} {#client-api}

Client API — общее название для набора нативных API {{ KF }}:

* [Producer API](https://kafka.apache.org/documentation/#producerapi) — позволяет работать с производителями.
* [Consumer API](https://kafka.apache.org/documentation/#consumerapi) — позволяет работать с потребителями.
* [Streams API](https://kafka.apache.org/documentation/#streamsapi) — позволяет работать с потоками данных.
* [Connect API](https://kafka.apache.org/documentation/#connectapi) — позволяет работать с коннекторами.
* [Admin API](https://kafka.apache.org/documentation/#adminapi) — позволяет работать с объектами {{ KF }}.

Эти API позволяют управлять объектами {{ KF }} ([с некоторыми ограничениями](#client-api-limits)).

### Использование {#client-api-usage}

Чтобы использовать любой из этих API:

1. [Выполните предварительную настройку для подключения к кластеру](../operations/connect/index.md).

1. Встройте нужный API в код [приложения-клиента {{ KF }}](../operations/connect/code-examples.md).

    Для работы с Client API необходимо вызывать нужные функции из кода приложений-клиентов — эти API не являются REST API.

1. Настройте в коде приложения-клиента нужный механизм аутентификации, чтобы взаимодействовать с API. При аутентификации используются реквизиты [пользователя {{ KF }}](../operations/cluster-accounts.md).

    Механизмы аутентификации описаны в [документации Confluent для приложений-клиентов](https://docs.confluent.io/kafka-client/overview.html). Примеры настройки см. в разделе [{#T}](../operations/connect/code-examples.md).

Доступные операции определяются [ролями пользователя {{ KF }}](../operations/cluster-accounts.md), от имени которого выполняются запросы к Client API.

Описания Client API приведены в [документации {{ KF }}](https://kafka.apache.org/documentation/#api). Пример работы с Producer API и Consumer API см. в разделе [{#T}](../tutorials/managed-schema-registry.md).

### Ограничения {#client-api-limits}

* Нельзя управлять кластерами и пользователями {{ KF }}.
* Можно управлять топиками с помощью Admin API, но со следующими ограничениями:

    {% include [admin-api-limits](../../_includes/mdb/mkf/admin-api-limits.md) %}
