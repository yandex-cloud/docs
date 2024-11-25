# Передача логов кластера {{ maf-name }} в {{ cloud-logging-full-name }}

Вы можете настроить регулярный сбор логов о работе кластера {{ maf-name }}. Логи поставляются в [лог-группу](../../logging/concepts/log-group.md) в сервисе {{ cloud-logging-name }}. Можно выбрать лог-группу одного из двух типов:

* лог-группа, которая используется по умолчанию в каталоге кластера;
* пользовательская лог-группа.

## Передача данных в лог-группу по умолчанию {#default}

1. [Убедитесь](../../iam/operations/roles/get-assigned-roles.md), что сервисному аккаунту кластера назначена [роль](../../iam/roles-reference.md#managed-airflow-integrationProvider) `managed-airflow.integrationProvider`.
1. В кластере {{ maf-name }} задайте настройки логирования:

   {% list tabs group=instructions %}

   * Консоль управления {#console}

      1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
      1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
      1. В блоке **{{ ui-key.yacloud.logging.label_title }}** включите опцию **{{ ui-key.yacloud.logging.field_logging }}**.
      1. Чтобы логи записывались в лог-группу по умолчанию, выберите значение **{{ ui-key.yacloud.common.folder }}** в поле **{{ ui-key.yacloud.logging.label_destination }}**.
      1. Укажите каталог, лог-группу которого нужно использовать.
      1. Выберите минимальный уровень логирования.

         В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.

   * CLI {#cli}

      В команде создания кластера укажите параметры логирования:

      ```bash
      yc managed-airflow cluster update \
         ...
         --log-enabled \
         --log-folder-id <идентификатор_каталога> \
         --log-min-level <уровень_логирования>
      ```

      Укажите каталог, лог-группу которого нужно использовать.

      В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.

   * {{ TF }} {#tf}

      В конфигурационном файле с описанием кластера укажите следующие параметры:

      ```hcl
      resource "yandex_airflow_cluster" "<имя_кластера>" {
        ...
        logging = {
          enabled   = true
          folder_id = "<идентификатор_каталога>"
          min_level = "<уровень_логирования>"
        }
      }
      ```

      Укажите каталог, лог-группу которого нужно использовать.

      В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.

   * API {#api}

      В теле запроса на изменение кластера ([Cluster.Update](../api-ref/Cluster/update.md) в REST API или [ClusterService.Update](../api-ref/grpc/Cluster/update.md) в gRPC API) укажите следующие параметры:

      ```json
      {
         ...
         "logging": {
            "enabled": true,
            "minLevel": "<уровень_логирования>",
            "folderId": "<идентификатор_каталога>"
         }
      }
      ```

      Укажите каталог, лог-группу которого нужно использовать.

      В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.

   {% endlist %}

1. Проверьте передачу логов кластера в лог-группу:

   {% list tabs group=instructions %}

   * Консоль управления {#console}

      1. В консоли управления перейдите в нужный каталог.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
      1. Нажмите на строку с лог-группой `default`.

      На открывшейся странице отобразятся записи.

   * CLI {#cli}

      Чтобы посмотреть записи в формате JSON, выполните команду:

      ```bash
      yc logging read --group-name=default --format=json
      ```

      Результат:

      ```text
      [
        {
          "uid": "3:74********",
          "resource": {
            "type": "managed-airflow.cluster",
            "id": "c9qv4tnjqdpa********"
          },
          "timestamp": "2024-10-31T11:14:53.740223Z",
          "ingested_at": "2024-10-31T11:14:55.633Z",
          "saved_at": "2024-10-31T11:14:57.231685Z",
          "level": "INFO",
          "message": "10.253.244.40 - - \"GET /health HTTP/1.1\" 200 283 \"-\" \"kube-probe/1.25\"",
          "json_payload": {
            "file": "/home/airflow/.local/lib/python3.8/site-packages/gunicorn/glogging.py",
            "instance": "airflow-c9qv4tnjqdpa********-webserver-68********-q5***",
            "line": 363,
            "resource_id": "c9qv4tnjqdpa********",
            "stream_name": "webserver",
            "thread": "MainThread"
          },
          "stream_name": "webserver"
        }
      ]
      ```

   * API {#api}

      Чтобы посмотреть записи в лог-группе, воспользуйтесь вызовом gRPC API [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md).

   {% endlist %}

   Подробнее см. в разделе [{#T}](../../logging/operations/read-logs.md).

## Передача данных в пользовательскую лог-группу {#custom}

1. [Создайте лог-группу](../../logging/operations/create-group.md) `airflow-log-group`.
1. [Убедитесь](../../iam/operations/roles/get-assigned-roles.md), что сервисному аккаунту кластера назначена [роль](../../iam/roles-reference.md#managed-airflow-integrationProvider) `managed-airflow.integrationProvider`.
1. В кластере {{ maf-name }} задайте настройки логирования:

   {% list tabs group=instructions %}

   * Консоль управления {#console}

      1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
      1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
      1. В блоке **{{ ui-key.yacloud.logging.label_title }}** включите опцию **{{ ui-key.yacloud.logging.field_logging }}**.
      1. Чтобы логи записывались в пользовательскую лог-группу, выберите значение **{{ ui-key.yacloud.logging.label_loggroup }}** в поле **{{ ui-key.yacloud.logging.label_destination }}**.
      1. Укажите лог-группу `airflow-log-group`.
      1. Выберите минимальный уровень логирования.

         В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.

   * CLI {#cli}

      В команде создания кластера укажите параметры логирования:

      ```bash
      yc managed-airflow cluster create \
         ...
         --log-enabled \
         --log-group-id <идентификатор_лог-группы> \
         --log-min-level <уровень_логирования>
      ```

      В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.

   * {{ TF }} {#tf}

      В конфигурационном файле с описанием кластера укажите следующие параметры:

      ```hcl
      resource "yandex_airflow_cluster" "<имя_кластера>" {
        ...
        logging = {
          enabled      = true
          log_group_id = "<идентификатор_лог-группы>"
          min_level    = "<уровень_логирования>"
        }
      }
      ```

      В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.

   * API {#api}

      В теле запроса на изменение кластера ([Cluster.Update](../api-ref/Cluster/update.md) в REST API или [ClusterService.Update](../api-ref/grpc/Cluster/update.md) в gRPC API) укажите следующие параметры:

      ```json
      {
         ...
         "logging": {
            "enabled": true,
            "minLevel": "<уровень_логирования>",
            "logGroupId": "<идентификатор_лог-группы>"
         }
      }
      ```

      В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.

   {% endlist %}

1. Проверьте передачу логов кластера в лог-группу:

   {% list tabs group=instructions %}

   * Консоль управления {#console}

      1. В консоли управления перейдите в нужный каталог.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
      1. Нажмите на строку с лог-группой `airflow-log-group`.

      На открывшейся странице отобразятся записи.

   * CLI {#cli}

      Чтобы посмотреть записи в формате JSON, выполните команду:

      ```bash
      yc logging read --group-name=airflow-log-group --format=json
      ```

      Результат:

      ```text
      [
        {
          "uid": "3:74********",
          "resource": {
            "type": "managed-airflow.cluster",
            "id": "c9qv4tnjqdpa********"
          },
          "timestamp": "2024-10-31T11:14:53.740223Z",
          "ingested_at": "2024-10-31T11:14:55.633Z",
          "saved_at": "2024-10-31T11:14:57.231685Z",
          "level": "INFO",
          "message": "10.253.244.40 - - \"GET /health HTTP/1.1\" 200 283 \"-\" \"kube-probe/1.25\"",
          "json_payload": {
            "file": "/home/airflow/.local/lib/python3.8/site-packages/gunicorn/glogging.py",
            "instance": "airflow-c9qv4tnjqdpa********-webserver-68********-q5***",
            "line": 363,
            "resource_id": "c9qv4tnjqdpa********",
            "stream_name": "webserver",
            "thread": "MainThread"
          },
          "stream_name": "webserver"
        }
      ]
      ```

   * API {#api}

      Чтобы посмотреть записи в лог-группе, воспользуйтесь вызовом gRPC API [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md).

   {% endlist %}

   Подробнее см. в разделе [{#T}](../../logging/operations/read-logs.md).
