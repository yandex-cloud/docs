---
title: Передача логов кластера {{ metastore-full-name }} в {{ cloud-logging-full-name }}
description: Следуя данной инструкции, вы сможете настроить передачу логов кластера {{ metastore-name }} в {{ cloud-logging-name }}.
---

# Передача логов кластера {{ metastore-name }} в {{ cloud-logging-full-name }}

Вы можете настроить регулярный сбор логов о работе кластера {{ metastore-name }}. Логи поставляются в [лог-группу](../../../logging/concepts/log-group.md) в сервисе {{ cloud-logging-full-name }}. Можно выбрать лог-группу одного из двух типов:

* лог-группа, которая используется по умолчанию в каталоге кластера;
* пользовательская лог-группа.

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) `metastore-logging-sa`.
1. [Назначьте сервисному аккаунту роль](../../../iam/operations/sa/assign-role-for-sa.md) `{{ roles.metastore.integrationProvider }}`.
1. В подсети, к которой будет подключен кластер, [настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md). Это нужно, чтобы кластер мог взаимодействовать с сервисами {{ yandex-cloud }}.
1. [Настройте группу безопасности](configure-security-group.md).

## Передача данных в лог-группу по умолчанию {#default}

1. Создайте кластер {{ metastore-name }}:

   {% list tabs group=instructions %}

   * Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
      1. На левой панели выберите страницу ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
      1. Укажите имя кластера `metastore-cluster`.
      1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** выберите `metastore-logging-sa`.
      1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите сеть и подсеть с настроенным NAT-шлюзом. Укажите настроенную группу безопасности.
      1. В блоке **{{ ui-key.yacloud.logging.label_title }}**:

         1. Включите опцию **{{ ui-key.yacloud.logging.field_logging }}**.
         1. Чтобы логи записывались в лог-группу по умолчанию, выберите значение **{{ ui-key.yacloud.common.folder }}** в поле **{{ ui-key.yacloud.logging.label_destination }}**.
         1. Укажите каталог, лог-группу которого нужно использовать.
         1. Выберите минимальный уровень логирования.

            В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.

      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

   * CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      Выполните команду:

      ```bash
      {{ yc-metastore }} cluster create \
         --name metastore-cluster \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --version <версия> \
         --subnet-ids <идентификаторы_подсетей> \
         --security-group-ids <идентификаторы_групп_безопасности> \
         --resource-preset-id <идентификатор_вычислительных_ресурсов> \
         --log-enabled \
         --log-folder-id <идентификатор_каталога> \
         --log-min-level <уровень_логирования>
      ```

      Где:

      * `--service-account-id` — идентификатор созданного [ранее](#before-you-begin) сервисного аккаунта `metastore-logging-sa`.
      * `--subnet-ids` — идентификатор подсети с настроенным NAT-шлюзом.
      * `--security-group-ids` — идентификатор настроенной [ранее](#before-you-begin) группы безопасности.
      * `--log-folder-id` — идентификатор каталога, лог-группу которого нужно использовать.
      * `--log-min-level` — уровень логирования. В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.

   {% endlist %}

1. Проверьте передачу логов кластера в лог-группу:

   {% list tabs group=instructions %}

   * Консоль управления {#console}

      1. В консоли управления перейдите в нужный каталог.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
      1. Нажмите на строку с лог-группой `default`.

      На открывшейся странице отобразятся записи.

   * CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      Чтобы посмотреть записи в формате JSON, выполните команду:

      ```bash
      yc logging read --group-name=default --format=json
      ```

      Результат:

      ```text
      [
        {
          "uid": "23:6d******:3",
          "resource": {
            "type": "managed-metastore.cluster",
            "id": "c9qcv46p3g3a********"
          },
          "timestamp": "2024-11-18T09:45:23.092484Z",
          "ingested_at": "2024-11-18T09:45:24Z",
          "saved_at": "2024-11-18T09:45:25.559195Z",
          "level": "INFO",
          "message": "ugi=metastore\tip=10.253.89.135\tcmd=Done cleaning up thread local RawStore\t",
          "json_payload": {
            "instance": "metastore-server-5f9c7ff***-*****",
            "logger": "org.apache.hadoop.hive.metastore.HiveMetaStore.audit",
            "resource_id": "c9qcv46p3g3a********",
            "stream_name": "metastore-server",
            "thread": "pool-6-thread-79"
          },
          "stream_name": "metastore-server"
        }
      ]
      ```

   * API {#api}

      Чтобы посмотреть записи в лог-группе, воспользуйтесь вызовом gRPC API [LogReadingService.Read](../../../logging/api-ref/grpc/LogReading/read.md).

   {% endlist %}

   Подробнее см. в разделе [{#T}](../../../logging/operations/read-logs.md).

## Передача данных в пользовательскую лог-группу {#custom}

1. [Создайте лог-группу](../../../logging/operations/create-group.md) `metastore-log-group`.
1. Создайте кластер {{ metastore-name }}:

   {% list tabs group=instructions %}

   * Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
      1. На левой панели выберите страницу ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
      1. Укажите имя кластера `metastore-cluster`.
      1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** выберите `metastore-logging-sa`.
      1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите сеть и подсеть с настроенным NAT-шлюзом. Укажите настроенную группу безопасности.
      1. В блоке **{{ ui-key.yacloud.logging.label_title }}**:

         1. Включите опцию **{{ ui-key.yacloud.logging.field_logging }}**.
         1. Чтобы логи записывались в пользовательскую лог-группу, выберите значение **{{ ui-key.yacloud.logging.label_loggroup }}** в поле **{{ ui-key.yacloud.logging.label_destination }}**.
         1. Укажите лог-группу `metastore-log-group`.
         1. Выберите минимальный уровень логирования.

            В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.

      1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

   * CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      Выполните команду:

      ```bash
      {{ yc-metastore }} cluster create \
         --name metastore-cluster \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --version <версия> \
         --subnet-ids <идентификаторы_подсетей> \
         --security-group-ids <идентификаторы_групп_безопасности> \
         --resource-preset-id <идентификатор_вычислительных_ресурсов> \
         --log-enabled \
         --log-group-id <идентификатор_лог_группы> \
         --log-min-level <уровень_логирования>
      ```

      Где:

      * `--service-account-id` — идентификатор созданного [ранее](#before-you-begin) сервисного аккаунта `metastore-logging-sa`.
      * `--subnet-ids` — идентификатор подсети с настроенным NAT-шлюзом.
      * `--security-group-ids` — идентификатор настроенной [ранее](#before-you-begin) группы безопасности.
      * `--log-group-id` — идентификатор лог-группы `metastore-log-group`.
      * `--log-min-level` — уровень логирования. В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.

   {% endlist %}

1. Проверьте передачу логов кластера в лог-группу:

   {% list tabs group=instructions %}

   * Консоль управления {#console}

      1. В консоли управления перейдите в нужный каталог.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
      1. Нажмите на строку с лог-группой `metastore-log-group`.

      На открывшейся странице отобразятся записи.

   * CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      Чтобы посмотреть записи в формате JSON, выполните команду:

      ```bash
      yc logging read --group-name=metastore-log-group --format=json
      ```

      Результат:

      ```text
      [
        {
          "uid": "23:6d******:3",
          "resource": {
            "type": "managed-metastore.cluster",
            "id": "c9qcv46p3g3a********"
          },
          "timestamp": "2024-11-18T09:45:23.092484Z",
          "ingested_at": "2024-11-18T09:45:24Z",
          "saved_at": "2024-11-18T09:45:25.559195Z",
          "level": "INFO",
          "message": "ugi=metastore\tip=10.253.89.135\tcmd=Done cleaning up thread local RawStore\t",
          "json_payload": {
            "instance": "metastore-server-5f9c7ff***-*****",
            "logger": "org.apache.hadoop.hive.metastore.HiveMetaStore.audit",
            "resource_id": "c9qcv46p3g3a********",
            "stream_name": "metastore-server",
            "thread": "pool-6-thread-79"
          },
          "stream_name": "metastore-server"
        }
      ]
      ```

   * API {#api}

      Чтобы посмотреть записи в лог-группе, воспользуйтесь вызовом gRPC API [LogReadingService.Read](../../../logging/api-ref/grpc/LogReading/read.md).

   {% endlist %}

   Подробнее см. в разделе [{#T}](../../../logging/operations/read-logs.md).
