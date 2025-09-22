---
title: Как создать подключение {{ metadata-hub-name }}. Пошаговые инструкции
description: Пошаговые инструкции по работе с {{ connection-manager-name }} в {{ yandex-cloud }}. Из статьи вы узнаете, как создавать подключения.
---

# Создание подключения


Вы можете создать подключения следующих типов:
* [к кластеру с управляемой базой данных](#mdb-connection):
  * [{{ mpg-name }}](#mdb-postgresql)
  * [{{ mch-name }}](#mdb-clickhouse)
  * [{{ mmy-name }}](#mdb-mysql)
  * [{{ mrd-name }}](#mdb-redis)
  * [{{ mos-name }}](#mdb-opensearch)
  * [{{ mmg-name }}](#mdb-mongodb)
  * [{{ mkf-name }}](#mdb-kafka)
  * [{{ mgp-name }}](#mdb-greenplum)
* [к пользовательской инсталляции базы данных](#on-premise-connection):
  * [{{ PG }}](#postgresql-on-premise)
  * [{{ CH }}](#clickhouse-on-premise)
  * [{{ MY }}](#mysql-on-premise)
  * [{{ RD }}](#redis-on-premise)
  * [{{ VLK }}](#valkey-on-premise)
  * [{{ TR }}](#trino-on-premise)
  * [{{ OS }}](#opensearch-on-premise)
  * [{{ MG }}](#mongodb-on-premise)
  * [{{ KF }}](#kafka-on-premise)
  * [{{ GP }}](#greenplum-on-premise)

## Подключение к кластеру с управляемой базой данных {#mdb-connection}

### {{ mpg-name }} {#mdb-postgresql}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Укажите имя подключения.
  1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. В разделе **Подключение к {{ PG }}** выберите **Кластер {{ mpg-short-name }}** в качестве типа подключения и укажите нужный кластер.
  1. В разделе **Аутентификация**:
      1. Укажите **Имя пользователя**, от лица которого будете подключаться к кластеру.
      1. Выберите способ задания пароля:
          * **Ввести вручную** — вы сами задаете пароль.
          * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
  1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. Подключиться можно только к существующим в этом кластере базам данных. У вас должен быть [настроен доступ к ним](../../managed-postgresql/security/index.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к кластеру {{ mpg-name }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create postgresql --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create postgresql \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --managed-cluster-id <идентификатор_кластера> \
        --databases <список_БД>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--managed-cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](../../managed-postgresql/operations/cluster-list.md#list-clusters) в каталоге.
      
      * `--databases` — список баз данных, через запятую. Убедитесь, что у пользователя есть [необходимые права](../../managed-postgresql/security/index.md) на доступ к ним.

- API {#api}

  Чтобы создать подключение к кластеру {{ mpg-name }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md) для ресурса [Connection](../api-ref/grpc/Connection/).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLConnection) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLConnection).

{% endlist %}

### {{ mch-name }} {#mdb-clickhouse}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
    1. Выберите сервис **{{ metadata-hub-full-name }}**.
    1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Укажите имя подключения.
    1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
    1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
    1. В разделе **Подключение к {{ CH }}** выберите **Кластер {{ mch-short-name }}** в качестве типа подключения и укажите нужный кластер.
    1. В разделе **Аутентификация**:
        1. Укажите **Имя пользователя**, от лица которого будете подключаться к кластеру.
        1. Выберите способ задания пароля:
            * **Ввести вручную** — вы сами задаете пароль.
            * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
    1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к кластеру {{ mch-name }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create clickhouse --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create clickhouse \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --managed-cluster-id <идентификатор_кластера> \
        --databases <список_БД>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--managed-cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](../../managed-clickhouse/operations/cluster-list.md#list-clusters) в каталоге.
      
      * `--databases` — список баз данных, через запятую. Убедитесь, что у пользователя есть [необходимые права](../../managed-clickhouse/security.md) на доступ к ним.

- API {#api}

  Чтобы создать подключение к кластеру {{ mch-name }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseConnection) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseConnection).

{% endlist %}

### {{ mmy-name }} {#mdb-mysql}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. Выберите сервис **{{ metadata-hub-full-name }}**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. В разделе **Подключение к {{ MY }}** выберите **Кластер {{ mmy-short-name }}** в качестве типа подключения и укажите нужный кластер.
   1. В разделе **Аутентификация**:
        1. Укажите **Имя пользователя**, от лица которого будете подключаться к кластеру.
        1. Выберите способ задания пароля:
            * **Ввести вручную** — вы сами задаете пароль.
            * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. Подключиться можно только к существующим в этом кластере базам данных. У вас должен быть [настроен доступ к ним](../../managed-mysql/security/index.md).
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к кластеру {{ mmy-name }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create mysql --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create mysql \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --managed-cluster-id <идентификатор_кластера> \
        --databases <список_БД>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--managed-cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](../../managed-mysql/operations/cluster-list.md#list-clusters) в каталоге.
      
      * `--databases` — список баз данных, через запятую. Убедитесь, что у пользователя есть [необходимые права](../../managed-mysql/security/index.md) на доступ к ним.

- API {#api}

  Чтобы создать подключение к кластеру {{ mmy-name }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLConnection) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLConnection).

{% endlist %}

### {{ mrd-name }} {#mdb-redis}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
    1. Выберите сервис **{{ metadata-hub-full-name }}**.
    1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Укажите имя подключения.
    1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
    1. В списке **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **{{ VLK }}**.
    1. В разделе **Подключение к {{ VLK }}** выберите **Кластер {{ mrd-short-name }}** в качестве типа подключения и укажите нужный кластер.
    1. В разделе **Аутентификация** выберите способ задания пароля:
         * **Ввести вручную** — введите значение пароля.
         * **Сгенерировать** — укажите опции для создания автоматически сгенерированного пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md).
    1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к кластеру {{ mrd-name }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create valkey --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create valkey \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --managed-cluster-id <идентификатор_кластера> \
        --databases <список_БД>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--managed-cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](../../managed-redis/operations/cluster-list.md#list-clusters) в каталоге.
      
      * `--databases` — список баз данных, через запятую. Убедитесь, что у пользователя есть [необходимые права](../../managed-redis/security/index.md) на доступ к ним.

- API {#api}

  Чтобы создать подключение к кластеру {{ mrd-name }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyConnection) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyConnection).

{% endlist %}

### {{ mos-name }} {#mdb-opensearch}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. Выберите сервис **{{ metadata-hub-full-name }}**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. В разделе **Подключение к {{ OS }}** выберите **Кластер {{ mos-short-name }}** в качестве типа подключения и укажите нужный кластер.
   1. В разделе **Аутентификация**:
        1. Укажите **Имя пользователя**, от лица которого будете подключаться к кластеру.
        1. Выберите способ задания пароля:
            * **Ввести вручную** — вы сами задаете пароль.
            * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. Подключиться можно только к существующим в этом кластере базам данных. У вас должен быть [настроен доступ к ним](../../managed-opensearch/security/index.md).
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к кластеру {{ mos-name }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create opensearch --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create opensearch \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --managed-cluster-id <идентификатор_кластера>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--managed-cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](../../managed-opensearch/operations/cluster-list.md#list-clusters) в каталоге.

- API {#api}

  Чтобы создать подключение к кластеру {{ mos-name }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchConnection) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchConnection).

{% endlist %}

### {{ mmg-name }} {#mdb-mongodb}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. Выберите сервис **{{ metadata-hub-full-name }}**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. В разделе **Подключение к {{ MG }}** выберите **Кластер {{ mmg-short-name }}** в качестве типа подключения и укажите нужный кластер.
   1. В разделе **Аутентификация**:
        1. Укажите **Имя пользователя**, от лица которого будете подключаться к кластеру.
        1. Выберите способ задания пароля:
            * **Ввести вручную** — вы сами задаете пароль.
            * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. Подключиться можно только к существующим в этом кластере базам данных. У вас должен быть [настроен доступ к ним](../../storedoc/security/index.md).
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к кластеру {{ mmg-name }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create mongodb --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create mongodb \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --managed-cluster-id <идентификатор_кластера> \
        --databases <список_БД>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--managed-cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](../../storedoc/operations/cluster-list.md#list-clusters) в каталоге.
      
      * `--databases` — список баз данных, через запятую. Убедитесь, что у пользователя есть [необходимые права](../../storedoc/security/index.md) на доступ к ним.

- API {#api}

  Чтобы создать подключение к кластеру {{ mmg-name }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBConnection) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBConnection).

{% endlist %}

### {{ mkf-name }} {#mdb-kafka}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. Выберите сервис **{{ metadata-hub-full-name }}**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. В разделе **Подключение к {{ KF }}** выберите **Кластер Managed Service for Kafka** в качестве типа подключения и укажите нужный кластер.
   1. При использовании аутентификации:

       * Укажите **Имя пользователя** для подключения.
       * Задайте пароль одним из способов:
         
         * **Ввести вручную** — пароль вводится в соответствующее поле.
         * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
       
       * (Опционально) В списке **Механизмы аутентификации** выберите нужные опции:
         
         * `PLAIN` — аутентификация с передачей логина и пароля в открытом виде.
         * `SCRAM_SHA256` — аутентификация с хэшированием SHA-256.
         * `SCRAM_SHA512` — аутентификация с хэшированием SHA-512.

                 
         [Подробнее о механизмах и протоколах SASL](../../glossary/sasl.md#mechanisms-and-protocols).
         

   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### {{ mgp-name }} {#mdb-greenplum}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Укажите имя подключения.
  1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. В разделе **Подключение к Greenplum** выберите **Кластер Managed Service for Greenplum** в качестве типа подключения и укажите нужный кластер.
  1. В разделе **Аутентификация**:
      1. Укажите **Имя пользователя** для подключения.
      1. Выберите способ задания пароля:
          * **Ввести вручную** — пароль вводится в соответствующее поле.
          * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
  1. Перечислите базы данных, подключениями к которым вы хотите управлять. Подключиться можно только к существующим в этом кластере базам данных. Убедитесь, что у пользователя есть [необходимые права](../../managed-greenplum/security/index.md) на доступ к ним.
  
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к кластеру {{ mgp-name }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create greenplum --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create greenplum \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --managed-cluster-id <идентификатор_кластера> \
        --databases <список_БД>
      ```

      Где:

      * `--name` — имя подключения.

      * `--description` — описание подключения.

      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.

      * `--user` — имя пользователя для подключения к кластеру.

      * `--password` — пароль пользователя.
      
      * `--managed-cluster-id` — идентификатор кластера.

        Идентификатор кластера можно получить со [списком кластеров](../../managed-postgresql/operations/cluster-list.md#list-clusters) в каталоге.
      
      * `--databases` — список баз данных, через запятую. Убедитесь, что у пользователя есть [необходимые права](../../managed-greenplum/security/index.md) на доступ к ним.

- API {#api}

  Чтобы создать подключение к кластеру {{ mgp-name }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md) для ресурса [Connection](../api-ref/grpc/Connection/).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.GreenplumConnection) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.GreenplumConnection).

{% endlist %}

## Подключение к пользовательской инсталляции базы данных {#on-premise-connection}

### {{ PG }} {#postgresql-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Укажите имя подключения.
  1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. В разделе **Подключение к {{ PG }}** укажите параметры подключения:
      1. В поле **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
      1. В поле **Хосты** укажите адрес хоста c базой данных и номер порта для подключения.

          Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [{{ datalens-full-name }}](../../datalens/concepts/index.md), укажите внешний адрес хоста.

      1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
          Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
          
  1. В разделе **Аутентификация**:
      1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
      1. Выберите способ задания пароля:
          * **Ввести вручную** — вы сами задаете пароль.
          * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
  1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к пользовательской инсталляции {{ PG }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create postgresql --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create postgresql \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --databases <список_БД> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      {% include [Описание параметров](../../_includes/metadata-hub/connection-create-onpremise-cli.md) %}

- API {#api}

  Чтобы создать подключение к пользовательской инсталляции {{ PG }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLCluster) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLCluster).

{% endlist %}

### {{ CH }} {#clickhouse-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
    1. Выберите сервис **{{ metadata-hub-full-name }}**.
    1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Укажите имя подключения.
    1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
    1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
    1. В разделе **Подключение к {{ CH }}** укажите параметры подключения:
        1. В поле **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
        1. В поле **Хосты** укажите [FQDN](../../glossary/fqdn.md) или IP-адреса хостов, входящих в шард, номер HTTP- или TCP-порта для подключения и имя [шарда](../../managed-clickhouse/operations/shards.md#list-shards).

            Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [{{ datalens-full-name }}](../../datalens/concepts/index.md), укажите внешние IP-адреса хостов.

        1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
            Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
    1. В разделе **Аутентификация**:
        1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
        1. Выберите способ задания пароля:
            * **Ввести вручную** — вы сами задаете пароль.
            * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
    1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к пользовательской инсталляции {{ CH }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create clickhouse --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create clickhouse \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --databases <список_БД> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      * `--name` — имя подключения.
      
      * `--description` — описание подключения.
      
      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.
      
      * `--user` — имя пользователя для подключения к кластеру.
      
      * `--password` — пароль пользователя.
      
      * `--hosts` — список хостов в формате `<хост>:<http_порт>:<tcp_порт>:<имя_шарда>`, через запятую.
      
      * `--databases` — список баз данных, через запятую.
      
        Убедитесь, что у пользователя есть необходимые права на доступ к ним.
        
      * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
        
        По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.

- API {#api}

  Чтобы создать подключение к пользовательской инсталляции {{ CH }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseCluster) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseCluster).

{% endlist %}

### {{ MY }} {#mysql-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. Выберите сервис **{{ metadata-hub-full-name }}**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. В разделе **Подключение к {{ MY }}** укажите параметры подключения:
       1. В поле **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
       1. В поле **Хосты** укажите адрес хоста c базой данных и номер порта для подключения.

           Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [{{ datalens-full-name }}](../../datalens/concepts/index.md), укажите внешний адрес хоста.

       1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
           Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
           
   1. В разделе **Аутентификация**:
       1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
       1. Выберите способ задания пароля:
           * **Ввести вручную** — вы сами задаете пароль.
           * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к пользовательской инсталляции {{ MY }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create mysql --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create mysql \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --databases <список_БД> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      {% include [Описание параметров](../../_includes/metadata-hub/connection-create-onpremise-cli.md) %}

- API {#api}

  Чтобы создать подключение к пользовательской инсталляции {{ MY }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLCluster) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLCluster).

{% endlist %}

### {{ RD }} {#redis-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
    1. Выберите сервис **{{ metadata-hub-full-name }}**.
    1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Укажите имя подключения.
    1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
    1. В списке **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **{{ RD }}**.
    1. В разделе **Подключение к {{ RD }}** укажите параметры подключения:
       1. В поле **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
       1. В поле **Хосты** укажите [FQDN](../../glossary/fqdn.md) или IP-адреса хостов, входящих в шард, номер HTTP- или TCP-порта для подключения и имя шарда.
       1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
    1. В разделе **Аутентификация** укажите имя пользователя и выберите способ задания пароля: 
        * **Ввести вручную** — введите значение пароля.
        * **Сгенерировать** — укажите опции для создания автоматически сгенерированного пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md).
    1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к пользовательской инсталляции {{ RD }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create redis --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create redis \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --databases <список_БД> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      * `--name` — имя подключения.
      
      * `--description` — описание подключения.
      
      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.
      
      * `--user` — имя пользователя для подключения к кластеру.
      
      * `--password` — пароль пользователя.
      
      * `--hosts` — список хостов в формате `<хост>:<порт>:<имя_шарда>`, через запятую.
      
      * `--databases` — список баз данных, через запятую.
      
        Убедитесь, что у пользователя есть необходимые права на доступ к ним.
        
      * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
      
        По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.

- API {#api}

  Чтобы создать подключение к пользовательской инсталляции {{ RD }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.RedisCluster) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.RedisCluster).

{% endlist %}

### {{ VLK }} {#valkey-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
    1. Выберите сервис **{{ metadata-hub-full-name }}**.
    1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Укажите имя подключения.
    1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
    1. В списке **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **{{ VLK }}**.
    1. В разделе **Подключение к {{ VLK }}** укажите параметры подключения:
       1. В поле **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
       1. В поле **Хосты** укажите [FQDN](../../glossary/fqdn.md) или IP-адреса хостов, входящих в шард, номер HTTP- или TCP-порта для подключения и имя [шарда](../../managed-redis/operations/connect/sharded.md).

           Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [{{ datalens-full-name }}](../../datalens/concepts/index.md), укажите внешние IP-адреса хостов.

       1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
    1. В разделе **Аутентификация** укажите имя пользователя и выберите способ задания пароля: 
        * **Ввести вручную** — введите значение пароля.
        * **Сгенерировать** — укажите опции для создания автоматически сгенерированного пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md).
    1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к пользовательской инсталляции {{ VLK }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create valkey --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create valkey \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --databases <список_БД> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      {% include [Описание параметров](../../_includes/metadata-hub/connection-create-onpremise-cli.md) %}

- API {#api}

  Чтобы создать подключение к пользовательской инсталляции {{ VLK }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyCluster) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyCluster).

{% endlist %}

### {{ TR }} {#trino-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Укажите имя подключения.
  1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. В разделе **Подключение к {{ TR }}** укажите параметры подключения:
      1. В поле **Координатор** укажите адрес хоста [координатора](https://trino.io/docs/current/overview/concepts.html#coordinator) и номер порта для подключения. 
      1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
          Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
  1. В разделе **Аутентификация**:
      1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
      1. Выберите способ задания пароля:
          * **Ввести вручную** — вы сами задаете пароль.
          * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к пользовательской инсталляции {{ TR }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create trino --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create trino \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --coordinator <параметры_координатора> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      * `--name` — имя подключения.
      
      * `--description` — описание подключения.
      
      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.
      
      * `--user` — имя пользователя для подключения к кластеру.
      
      * `--password` — пароль пользователя.
      
      * `--coordinator` — параметры координатора в формате `<хост>:<порт>`.
      
      * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
      
        По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.

- API {#api}

  Чтобы создать подключение к пользовательской инсталляции {{ TR }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.TrinoCluster) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.TrinoCluster).

{% endlist %}

### {{ OS }} {#opensearch-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. Выберите сервис **{{ metadata-hub-full-name }}**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. В разделе **Подключение к {{ OS }}** укажите параметры подключения:
       1. В поле **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
       1. В поле **Хосты** укажите адрес хоста с базой данных и номер порта для подключения.
       1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
           Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
   1. В разделе **Аутентификация**:
       1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
       1. Выберите способ задания пароля:
           * **Ввести вручную** — вы сами задаете пароль.
           * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к пользовательской инсталляции {{ OS }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create opensearch --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create opensearch \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      * `--name` — имя подключения.
      
      * `--description` — описание подключения.
      
      * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.
      
      * `--user` — имя пользователя для подключения к кластеру.
      
      * `--password` — пароль пользователя.
      
      * `--hosts` — список хостов в формате `<хост>:<порт>`, через запятую.
      
      * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
      
        По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.

- API {#api}

  Чтобы создать подключение к пользовательской инсталляции {{ OS }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchCluster) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchCluster).

{% endlist %}

### {{ MG }} {#mongodb-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. Выберите сервис **{{ metadata-hub-full-name }}**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. В разделе **Подключение к {{ MG }}** укажите параметры подключения:
       1. В поле **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
       1. В поле **Хосты** укажите адрес хоста с базой данных и номер порта для подключения.
       1. (Опционально) Включите использование [TLS](../../glossary/tls.md). 
           Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
   1. В разделе **Аутентификация**:
       1. Укажите **Имя пользователя**, от лица которого будете подключаться к базе данных.
       1. Выберите способ задания пароля:
           * **Ввести вручную** — вы сами задаете пароль.
           * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
   1. (Опционально) Перечислите базы данных, подключениями к которым вы хотите управлять. У вас должен быть настроен доступ к ним.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к пользовательской инсталляции {{ MG }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create mongodb --help
      ```
      
  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create mongodb \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --databases <список_БД> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      {% include [Описание параметров](../../_includes/metadata-hub/connection-create-onpremise-cli.md) %}

- API {#api}

  Чтобы создать подключение к пользовательской инсталляции {{ MG }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBCluster) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBCluste).

{% endlist %}

### {{ KF }} {#kafka-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
   1. Выберите сервис **{{ metadata-hub-full-name }}**.
   1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Укажите имя подключения.
   1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
   1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. В разделе **Подключение к {{ KF }}** укажите параметры подключения:
       
       * В списке **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
       * В поле **Хосты** укажите адрес хоста и порт для подключения.
       * (Опционально) Включите использование [TLS](../../glossary/tls.md).
           
           Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
   
   1. При использовании аутентификации:

       * Укажите **Имя пользователя** для подключения.
       * Задайте пароль одним из способов:
         
         * **Ввести вручную** — пароль вводится в соответствующее поле.
         * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
       
       * (Опционально) В списке **Механизмы аутентификации** выберите нужные опции:
         
         * `PLAIN` — аутентификация с передачей логина и пароля в открытом виде.
         * `SCRAM_SHA256` — аутентификация с хэшированием SHA-256.
         * `SCRAM_SHA512` — аутентификация с хэшированием SHA-512.

                 
         [Подробнее о механизмах и протоколах SASL](../../glossary/sasl.md#mechanisms-and-protocols).
         

   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### {{ GP }} {#greenplum-on-premise}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать подключение.
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Укажите имя подключения.
  1. (Опционально) Добавьте описание подключения и [метку](../../resource-manager/concepts/labels.md).
  1. Выберите **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. В разделе **Подключение к Greenplum** укажите параметры подключения:
      1. В поле **{{ ui-key.yacloud.connection-manager.label_connection-type }}** выберите **Пользовательская инсталляция**.
      1. В поле **Хосты** укажите адрес хоста с базой данных и номер порта для подключения.

          Если вы создаете подключение к пользовательской инсталляции базы данных для использования с [{{ datalens-full-name }}](../../datalens/concepts/index.md), укажите внешний адрес хоста.

      1. (Опционально) Включите использование [TLS](../../glossary/tls.md).
          
          Если в вашей компании есть [центр сертификации (CA)](../../glossary/tls.md#authentication), по умолчанию будет использоваться выпущенный им сертификат. Если в компании нет СА, загрузите TLS-сертификат сервера.
          
  1. В разделе **Аутентификация**:
      1. Укажите **Имя пользователя** для подключения.
      1. Выберите способ задания пароля:
          * **Ввести вручную** — пароль вводится в соответствующее поле.
          * **Сгенерировать** — пароль генерируется автоматически. Вы можете настроить правила генерации пароля [{{ lockbox-short-name }}](../../lockbox/quickstart.md) или оставить правила, заданные по умолчанию.
  1. Перечислите базы данных, подключениями к которым вы хотите управлять. Убедитесь, что у пользователя есть необходимые права на доступ к ним.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать подключение к пользовательской инсталляции {{ GP }}:

  1. Посмотрите описание команды CLI для создания подключения:

      ```bash
      yc connection-manager connection create greenplum --help
      ```

  1. Создайте подключение, выполнив команду:
      
      ```bash
      yc connection-manager connection create greenplum \
        --name <имя_подключения> \
        --description "<описание_подключения>" \
        --labels <список_меток> \
        --user <имя_пользователя> \
        --password <пароль> \
        --hosts <список_хостов> \
        --databases <список_БД> \
        --ca-certificate <путь_к_сертификату>
      ```

      Где:

      {% include [Описание параметров](../../_includes/metadata-hub/connection-create-onpremise-cli.md) %}

- API {#api}

  Чтобы создать подключение к пользовательской инсталляции {{ GP }}, воспользуйтесь методом REST API [Connection.Create](../api-ref/Connection/create.md) или методом gRPC API [ConnectionService.Create](../api-ref/grpc/Connection/create.md).

  Подробнее о доступных параметрах запроса см. в справочнике [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.GreenplumCluster) и [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.GreenplumCluster).

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
