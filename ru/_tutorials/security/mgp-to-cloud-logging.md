# Передача логов кластера {{ mgp-name }} в {{ cloud-logging-full-name }}

Вы можете настроить регулярный сбор логов о работе кластера {{ mgp-name }}. Логи поставляются в [лог-группу](../../logging/concepts/log-group.md) в сервисе {{ cloud-logging-name }}. Можно выбрать лог-группу одного из двух типов:

* [лог-группа, которая используется по умолчанию в каталоге кластера](#default);
* [пользовательская лог-группа](#custom).

## Перед началом работы {#before-you-begin}

[Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) c [ролью](../../logging/security/index.md#logging-writer) `logging.writer`.

## Передача данных в лог-группу по умолчанию {#default}

1. Создайте кластер {{ mgp-name }} с включенными настройками логирования и [созданным ранее](#before-you-begin) сервисным аккаунтом:

   {% list tabs group=instructions %}

   * CLI {#cli}

      ```bash
      yc managed-greenplum cluster create <имя_кластера> \
         --greenplum-version=6.25 \
         --environment=PRODUCTION \
         --network-name=<имя_сети_кластера> \
         --user-name=<имя_пользователя_кластера> \
         --user-password=<пароль_пользователя_кластера> \
         --master-config resource-id=s3-c8-m32,`
                        `disk-size=10,`
                        `disk-type=network-hdd \
         --segment-config resource-id=s3-c8-m32,`
                        `disk-size=93,`
                        `disk-type=network-ssd-nonreplicated \
         --zone-id=<идентификатор_зоны_доступности> \
         --subnet-id=<идентификатор_подсети_кластера> \
         --assign-public-ip=true \
         --security-group-ids=<идентификаторы_групп_безопасности_кластера> \
         --service-account <идентификатор_сервисного_аккаунта_кластера> \
         --log-enabled \
         --log-greenplum-enabled \
         --log-command-center-enabled \
         --log-folder-id <идентификатор_каталога>
      ```

      Где:

      * `--service-account` — идентификатор [созданного ранее](#before-you-begin) сервисного аккаунта.

      * `--log-greenplum-enabled` — передача логов {{ GP }}.

          {% include [Greenplum Logs Level](../../_includes/managed-greenplum/greenplum-logs-level.md) %}

      * `--log-command-center-enabled` — передача логов [командного центра](../../managed-greenplum/concepts/command-center.md).

          {% include [Command Center Logs Level](../../_includes/managed-greenplum/command-center-logs-level.md) %}

      * `--log-folder-id` — идентификатор каталога, в котором создан кластер {{ mgp-name }}.

   * {{ TF }} {#tf}

      1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

      1. В конфигурационном файле с описанием кластера укажите следующие параметры:

          ```hcl
          resource "yandex_mdb_greenplum_cluster" "gp-cluster" {
            name               = "<имя_кластера>"
            environment        = "PRODUCTION"
            network_id         = "<идентификатор_сети>"
            zone               = "<идентификатор_зоны_доступности>"
            subnet_id          = "<идентификатор_подсети_кластера>"
            assign_public_ip   = true
            version            = "6.25"
            master_host_count  = 2
            segment_host_count = 2
            segment_in_host    = 2
            service_account_id = "<идентификатор_сервисного_аккаунта>"

            master_subcluster {
              resources {
                resource_preset_id = "s3-c8-m32" # 8 vCPU, 32 GB RAM
                disk_size          = 10          # GB
                disk_type_id       = "network-hdd"
              }
            }

            segment_subcluster {
              resources {
                resource_preset_id = "s3-c8-m32" # 8 vCPU, 32 GB RAM
                disk_size          = 93          # GB
                disk_type_id       = "network-ssd-nonreplicated"
              }
            }

            user_name          = "<имя_пользователя_кластера>"
            user_password      = "<пароль_пользователя_кластера>"
            security_group_ids = ["<идентификаторы_групп_безопасности_кластера>"]

            logging {
              enabled = true
              greenplum_enabled  = true
              command_center_enabled = true
              folder_id = <идентификатор_каталога>
            }
          }
          ```

          Где:

          * `service_account_id` — идентификатор [созданного ранее](#before-you-begin) сервисного аккаунта.

          * `greenplum-enabled` — передача логов {{ GP }}.

              {% include [Greenplum Logs Level](../../_includes/managed-greenplum/greenplum-logs-level.md) %}

          * `command-center-enabled` — передача логов [командного центра](../../managed-greenplum/concepts/command-center.md).

              {% include [Command Center Logs Level](../../_includes/managed-greenplum/command-center-logs-level.md) %}

          * `folder-id` — идентификатор каталога, лог-группу которого нужно использовать.

      1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

          ```bash
          terraform validate
          ```

          Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

      1. Создайте необходимую инфраструктуру:

          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   * API {#api}

      В теле запроса на создание кластера ([Cluster.Create](../../managed-greenplum/api-ref/Cluster/create.md) в REST API или [ClusterService.Create](../../managed-greenplum/api-ref/grpc/Cluster/create.md) в gRPC API) укажите следующие параметры:

      ```json
      {
        ...
        "serviceAccountId": "<идентификатор_сервисного_аккаунта>",
        "logging": {
          "enabled": "true",          
          "greenplumEnabled": "true",
          "commandCenterEnabled": "true",
          "folderId": "<идентификатор_каталога>"
        }
        ...
      }
      ```

      Где:

      * `serviceAccountId` — идентификатор [созданного ранее](#before-you-begin) сервисного аккаунта.

      * `greenplumEnabled` — передача логов {{ GP }}.

          {% include [Greenplum Logs Level](../../_includes/managed-greenplum/greenplum-logs-level.md) %}

      * `commandCenterEnabled` — передача логов [командного центра](../../managed-greenplum/concepts/command-center.md).

          {% include [Command Center Logs Level](../../_includes/managed-greenplum/command-center-logs-level.md) %}

      * `folderId` — идентификатор каталога, лог-группу которого нужно использовать.

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
          "uid": "22:********:15",
          "resource": {
            "type": "mdb.greenplum.cluster",
            "id": "c9qao2tkhbdt********"
          },
          "timestamp": "2025-04-25T07:50:21.871157Z",
          "ingested_at": "2025-04-25T07:50:24.553Z",
          "saved_at": "2025-04-25T07:50:26.125189Z",
          "level": "INFO",
          "message": "2025-04-25 10:50:20.209664 MSK,\"monitor\",\"postgres\",p29034,th1258748352,\"localhost\",\"47384\",2025-04-25 07:38:20 MSK,0,con40,cmd20190,seg-1,,,,sx1,\"LOG\",\"00000\",\"statement: \n\t\treset log_min_messages\n\t\",,,,,,,0,,\"postgres.c\",1664,",
          "json_payload": {
            "cid": "c9qao2tkhbdt********",
            "gp_host_type": "master",
            "gp_preferred_role": "primary",
            "hostname": "rc1d-jds7okr4********.mdb.yandexcloud.net",
            "segment_id": "-1",
            "username": "monitor"
          },
          "stream_name": "greenplum-logs-master-primary"
        }
      ]
      ```

   * API {#api}

      Чтобы посмотреть записи в лог-группе, воспользуйтесь вызовом REST API [Cluster.ListLogs](../../managed-greenplum/api-ref/Cluster/listLogs.md) или gRPC API [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md).

   {% endlist %}

   Подробнее см. в разделе [Чтение записей](../../logging/operations/read-logs.md).

## Передача данных в пользовательскую лог-группу {#custom}

1. [Создайте лог-группу](../../logging/operations/create-group.md) `greenplum-log-group`.
1. Создайте кластер {{ mgp-name }} с включенными настройками логирования и [созданным ранее](#before-you-begin) сервисным аккаунтом:

   {% list tabs group=instructions %}

   * CLI {#cli}

      ```bash
      yc managed-greenplum cluster create <имя_кластера> \
         --greenplum-version=6.25 \
         --environment=PRODUCTION \
         --network-name=<имя_сети_кластера> \
         --user-name=<имя_пользователя_кластера> \
         --user-password=<пароль_пользователя_кластера> \
         --master-config resource-id=s3-c8-m32,`
                        `disk-size=10,`
                        `disk-type=network-hdd \
         --segment-config resource-id=s3-c8-m32,`
                        `disk-size=93,`
                        `disk-type=network-ssd-nonreplicated \
         --zone-id=<идентификатор_зоны_доступности> \
         --subnet-id=<идентификатор_подсети_кластера> \
         --assign-public-ip=true \
         --security-group-ids=<идентификаторы_групп_безопасности_кластера> \
         --service-account <идентификатор_сервисного_аккаунта_кластера> \
         --log-enabled \
         --log-greenplum-enabled \
         --log-command-center-enabled \
         --log-group-id <идентификатор_лог-группы>
      ```

      Где:

      * `--service-account` — идентификатор [созданного ранее](#before-you-begin) сервисного аккаунта.

      * `--log-greenplum-enabled` — передача логов {{ GP }}.

          {% include [Greenplum Logs Level](../../_includes/managed-greenplum/greenplum-logs-level.md) %}

      * `--log-command-center-enabled` — передача логов [командного центра](../../managed-greenplum/concepts/command-center.md).

          {% include [Command Center Logs Level](../../_includes/managed-greenplum/command-center-logs-level.md) %}

      * `--log-group-id` — идентификатор лог-группы, в которую будут записываться логи.

   * {{ TF }} {#tf}

      1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

      1. В конфигурационном файле с описанием кластера укажите следующие параметры:

          ```hcl
          resource "yandex_mdb_greenplum_cluster" "gp-cluster" {
            name               = "<имя_кластера>"
            environment        = "PRODUCTION"
            network_id         = "<идентификатор_сети>"
            zone               = "<идентификатор_зоны_доступности>"
            subnet_id          = "<идентификатор_подсети_кластера>"
            assign_public_ip   = true
            version            = "6.25"
            master_host_count  = 2
            segment_host_count = 2
            segment_in_host    = 2
            service_account_id = "<идентификатор_сервисного_аккаунта>"

            master_subcluster {
              resources {
                resource_preset_id = "s3-c8-m32" # 8 vCPU, 32 GB RAM
                disk_size          = 10          # GB
                disk_type_id       = "network-hdd"
              }
            }

            segment_subcluster {
              resources {
                resource_preset_id = "s3-c8-m32" # 8 vCPU, 32 GB RAM
                disk_size          = 93          # GB
                disk_type_id       = "network-ssd-nonreplicated"
              }
            }

            user_name          = "<имя_пользователя_кластера>"
            user_password      = "<пароль_пользователя_кластера>"
            security_group_ids = ["<идентификаторы_групп_безопасности_кластера>"]

            logging {
              enabled = true
              greenplum_enabled  = true
              command_center_enabled = true
              log_group_id = <идентификатор_лог-группы>
            }
          }
          ```

          Где:

          * `service_account_id` — идентификатор [созданного ранее](#before-you-begin) сервисного аккаунта.

          * `greenplum-enabled` — передача логов {{ GP }}.

              {% include [Greenplum Logs Level](../../_includes/managed-greenplum/greenplum-logs-level.md) %}

          * `command-center-enabled` — передача логов [командного центра](../../managed-greenplum/concepts/command-center.md).

              {% include [Command Center Logs Level](../../_includes/managed-greenplum/command-center-logs-level.md) %}

          * `log_group_id` — идентификатор лог-группы, в которую будут записываться логи.

      1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

          ```bash
          terraform validate
          ```

          Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

      1. Создайте необходимую инфраструктуру:

          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   * API {#api}

      В теле запроса на создание кластера ([Cluster.Create](../../managed-greenplum/api-ref/Cluster/create.md) в REST API или [ClusterService.Create](../../managed-greenplum/api-ref/grpc/Cluster/create.md) в gRPC API) укажите следующие параметры:

      ```json
      {
        ...
        "serviceAccountId": "<идентификатор_сервисного_аккаунта>",
        "logging": {
          "enabled": "true",          
          "greenplumEnabled": "true",
          "commandCenterEnabled": "true",          
          "logGroupId": "<идентификатор_лог-группы>"
        }
        ...
      }
      ```

      Где:

      * `serviceAccountId` — идентификатор [созданного ранее](#before-you-begin) сервисного аккаунта.

      * `greenplumEnabled` — передача логов {{ GP }}.

          {% include [Greenplum Logs Level](../../_includes/managed-greenplum/greenplum-logs-level.md) %}

      * `commandCenterEnabled` — передача логов [командного центра](../../managed-greenplum/concepts/command-center.md).

          {% include [Command Center Logs Level](../../_includes/managed-greenplum/command-center-logs-level.md) %}

      * `logGroupId` — идентификатор лог-группы.

   {% endlist %}

1. Проверьте передачу логов кластера в лог-группу:

   {% list tabs group=instructions %}

   * Консоль управления {#console}

      1. В консоли управления перейдите в нужный каталог.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
      1. Нажмите на строку с лог-группой `greenplum-log-group`.

      На открывшейся странице отобразятся записи.

   * CLI {#cli}

      Чтобы посмотреть записи в формате JSON, выполните команду:

      ```bash
      yc logging read --group-name=greenplum-log-group --format=json
      ```

      Результат:

      ```text
      [
        {
          "uid": "22:********:15",
          "resource": {
            "type": "mdb.greenplum.cluster",
            "id": "c9qao2tkhbdt********"
          },
          "timestamp": "2025-04-25T07:50:21.871157Z",
          "ingested_at": "2025-04-25T07:50:24.553Z",
          "saved_at": "2025-04-25T07:50:26.125189Z",
          "level": "INFO",
          "message": "2025-04-25 10:50:20.209664 MSK,\"monitor\",\"postgres\",p29034,th1258748352,\"localhost\",\"47384\",2025-04-25 07:38:20 MSK,0,con40,cmd20190,seg-1,,,,sx1,\"LOG\",\"00000\",\"statement: \n\t\treset log_min_messages\n\t\",,,,,,,0,,\"postgres.c\",1664,",
          "json_payload": {
            "cid": "c9qao2tkhbdt********",
            "gp_host_type": "master",
            "gp_preferred_role": "primary",
            "hostname": "rc1d-jds7okr4********.mdb.yandexcloud.net",
            "segment_id": "-1",
            "username": "monitor"
          },
          "stream_name": "greenplum-logs-master-primary"
        }
      ]
      ```

   * API {#api}

      Чтобы посмотреть записи в лог-группе, воспользуйтесь вызовом REST API [Cluster.ListLogs](../../managed-greenplum/api-ref/Cluster/listLogs.md) или gRPC API [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md).

   {% endlist %}

   Подробнее см. в разделе [Чтение записей](../../logging/operations/read-logs.md).
