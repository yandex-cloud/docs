# Передача логов кластера Yandex MPP Analytics for PostgreSQL в Yandex Cloud Logging

# Передача логов кластера Yandex MPP Analytics for PostgreSQL в Yandex Cloud Logging

Вы можете настроить регулярный сбор логов о работе кластера Yandex MPP Analytics for PostgreSQL. Логи поставляются в [лог-группу](../concepts/log-group.md) в сервисе Cloud Logging. Можно выбрать лог-группу одного из двух типов:

* [лог-группа, которая используется по умолчанию в каталоге кластера](#default);
* [пользовательская лог-группа](#custom).

## Перед началом работы {#before-you-begin}

[Создайте сервисный аккаунт](../../iam/operations/sa/create.md#create-sa) c [ролью](../security/index.md#logging-writer) `logging.writer`.

## Передача данных в лог-группу по умолчанию {#default}

1. Создайте кластер Yandex MPP Analytics for PostgreSQL с включенными настройками логирования и [созданным ранее](#before-you-begin) сервисным аккаунтом:

   {% list tabs group=instructions %}

   * Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать кластер.
      1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
      1. Нажмите кнопку **Создать кластер**.
      1. Введите имя кластера.
      1. Выберите версию СУБД (Greenplum® или Apache Cloudberry™). Подробнее о [доступных версиях СУБД](../../managed-greenplum/concepts/overview.md).

      1. В блоке **Сетевые настройки** выберите:

         * Облачную сеть.
         * Группу безопасности.
         * Зону доступности и подсеть.

      1. В блоке **Пользователь** укажите реквизиты пользователя-администратора:

         * **Имя пользователя** — может содержать латинские буквы, цифры, дефис и подчеркивание, но не может начинаться с дефиса. Длина от 1 до 32 символов.
         * **Пароль** — длина от 8 до 128 символов.

      1. В блоке **Дополнительные настройки**:

         * Выберите сервисный аккаунт с ролью `logging.writer`.
         * Включите опцию **Запись логов**.
         * Чтобы логи записывались в лог-группу по умолчанию, выберите значение **Каталог** в поле **Назначение**.
         * Выберите каталог, лог-группу которого нужно использовать.
         * Включите опции **Логи Greenplum** и **Логи командного центра**. Уровень логирования можно задать с помощью параметра [Log min messages](../../managed-greenplum/concepts/settings-list.md#setting-log-min-messages) в блоке **Настройки СУБД**.

      1. Нажмите кнопку **Создать**.

   * CLI {#cli}

      ```bash
      yc managed-greenplum cluster create <имя_кластера> \
         --greenplum-version=<версия_СУБД> \
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

      * `--greenplum-version` — версия СУБД (Greenplum® или Apache Cloudberry™). Подробнее о [доступных версиях СУБД](../../managed-greenplum/concepts/overview.md).

      * `--service-account` — идентификатор [созданного ранее](#before-you-begin) сервисного аккаунта.

      * `--log-enabled` — включает механизм передачи логов. Обязателен для работы других флагов, отвечающих за передачу конкретных логов, например `--log-greenplum-enabled`.

      * `--log-greenplum-enabled` — передача логов СУБД.

          Вы можете [задать](../../managed-greenplum/operations/update.md#change-gp-settings) уровень логирования СУБД в [параметре](../../managed-greenplum/concepts/settings-list.md#setting-log-min-messages) `Log min messages`.

      * `--log-command-center-enabled` — передача логов [командного центра](../../managed-greenplum/concepts/command-center.md).

          Логи командного центра передаются полностью, изменить уровень логирования нельзя.

      * `--log-folder-id` — идентификатор каталога, в котором создан кластер Yandex MPP Analytics for PostgreSQL.

   * Terraform {#tf}

      1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
      1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
      1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

      1. В конфигурационном файле с описанием кластера укажите следующие параметры:

          ```hcl
          resource "yandex_mdb_greenplum_cluster" "gp-cluster" {
            name               = "<имя_кластера>"
            environment        = "PRODUCTION"
            network_id         = "<идентификатор_сети>"
            zone               = "<идентификатор_зоны_доступности>"
            subnet_id          = "<идентификатор_подсети_кластера>"
            assign_public_ip   = true
            version            = "<версия_СУБД>"
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

          * `version` — версия СУБД (Greenplum® или Apache Cloudberry™). Подробнее о [доступных версиях СУБД](../../managed-greenplum/concepts/overview.md).

          * `service_account_id` — идентификатор [созданного ранее](#before-you-begin) сервисного аккаунта.

          * `enabled` — управляет механизмом передачи логов. Для работы параметров, отвечающих за передачу конкретных логов, передайте значение `true`.

          * `greenplum_enabled` — передача логов СУБД.

              Вы можете [задать](../../managed-greenplum/operations/update.md#change-gp-settings) уровень логирования СУБД в [параметре](../../managed-greenplum/concepts/settings-list.md#setting-log-min-messages) `Log min messages`.

          * `command_center_enabled` — передача логов [командного центра](../../managed-greenplum/concepts/command-center.md).

              Логи командного центра передаются полностью, изменить уровень логирования нельзя.

          * `folder_id` — идентификатор каталога, лог-группу которого нужно использовать.

      1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

          ```bash
          terraform validate
          ```

          Если в файлах конфигурации есть ошибки, Terraform на них укажет.

      1. Создайте необходимую инфраструктуру:

          1. Выполните команду для просмотра планируемых изменений:
          
             ```bash
             terraform plan
             ```
          
             Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
          
          1. Если вас устраивают планируемые изменения, внесите их:
             1. Выполните команду:
          
                ```bash
                terraform apply
                ```
          
             1. Подтвердите изменение ресурсов.
             1. Дождитесь завершения операции.

   * API {#api}

      В теле запроса на создание кластера ([Cluster.Create](../../managed-greenplum/api-ref/Cluster/create.md) в REST API или [ClusterService.Create](../../managed-greenplum/api-ref/grpc/Cluster/create.md) в gRPC API) укажите следующие параметры:

      ```json
      {
        ...
        "config": {
          "version": "<версия_СУБД>",
          ...
          },
          ...
        },
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

      * `version` — версия СУБД (Greenplum® или Apache Cloudberry™). Подробнее о [доступных версиях СУБД](../../managed-greenplum/concepts/overview.md).

      * `serviceAccountId` — идентификатор [созданного ранее](#before-you-begin) сервисного аккаунта.

      * `enabled` — управляет механизмом передачи логов. Для работы параметров, отвечающих за передачу конкретных логов, передайте значение `true`.

      * `greenplumEnabled` — передача логов СУБД.

          Вы можете [задать](../../managed-greenplum/operations/update.md#change-gp-settings) уровень логирования СУБД в [параметре](../../managed-greenplum/concepts/settings-list.md#setting-log-min-messages) `Log min messages`.

      * `commandCenterEnabled` — передача логов [командного центра](../../managed-greenplum/concepts/command-center.md).

          Логи командного центра передаются полностью, изменить уровень логирования нельзя.

      * `folderId` — идентификатор каталога, лог-группу которого нужно использовать.

   {% endlist %}

1. Проверьте передачу логов кластера в лог-группу:

   {% list tabs group=instructions %}

   * Консоль управления {#console}

      1. В консоли управления перейдите в нужный каталог.
      1. Перейдите в сервис **Cloud Logging**.
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

      Чтобы посмотреть записи в лог-группе, воспользуйтесь вызовом REST API [Cluster.ListLogs](../../managed-greenplum/api-ref/Cluster/listLogs.md) или gRPC API [LogReadingService/Read](../api-ref/grpc/LogReading/read.md).

   {% endlist %}

   Подробнее см. в разделе [Чтение записей](../operations/read-logs.md).

## Передача данных в пользовательскую лог-группу {#custom}

1. [Создайте лог-группу](../operations/create-group.md) `my-log-group`.
1. Создайте кластер Yandex MPP Analytics for PostgreSQL с включенными настройками логирования и [созданным ранее](#before-you-begin) сервисным аккаунтом:

   {% list tabs group=instructions %}

   * Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором нужно создать кластер.
      1. Перейдите в сервис **Yandex MPP Analytics for&nbsp;PostgreSQL**.
      1. Нажмите кнопку **Создать кластер**.
      1. Введите имя кластера.
      1. Выберите версию СУБД (Greenplum® или Apache Cloudberry™). Подробнее о [доступных версиях СУБД](../../managed-greenplum/concepts/overview.md).

      1. В блоке **Сетевые настройки** выберите:

         * Облачную сеть.
         * Группу безопасности.
         * Зону доступности и подсеть.

      1. В блоке **Пользователь** укажите реквизиты пользователя-администратора:

         * **Имя пользователя** — может содержать латинские буквы, цифры, дефис и подчеркивание, но не может начинаться с дефиса. Длина от 1 до 32 символов.
         * **Пароль** — длина от 8 до 128 символов.

      1. В блоке **Дополнительные настройки**:

         * Выберите сервисный аккаунт с ролью `logging.writer`.
         * Включите опцию **Запись логов**.
         * Чтобы логи записывались в пользовательскую лог-группу, выберите значение **Лог-группа** в поле **Назначение**.
         * Выберите лог-группу `my-log-group`.
         * Включите опции **Логи Greenplum** и **Логи командного центра**. Уровень логирования можно задать с помощью параметра [Log min messages](../../managed-greenplum/concepts/settings-list.md#setting-log-min-messages) в блоке **Настройки СУБД**.

      1. Нажмите кнопку **Создать**.

   * CLI {#cli}

      ```bash
      yc managed-greenplum cluster create <имя_кластера> \
         --greenplum-version=<версия_СУБД> \
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

      * `--greenplum-version` — версия СУБД (Greenplum® или Apache Cloudberry™). Подробнее о [доступных версиях СУБД](../../managed-greenplum/concepts/overview.md).

      * `--service-account` — идентификатор [созданного ранее](#before-you-begin) сервисного аккаунта.

      * `--log-enabled` — включает механизм передачи логов. Обязателен для работы других флагов, отвечающих за передачу конкретных логов, например `--log-greenplum-enabled`.

      * `--log-greenplum-enabled` — передача логов СУБД.

          Вы можете [задать](../../managed-greenplum/operations/update.md#change-gp-settings) уровень логирования СУБД в [параметре](../../managed-greenplum/concepts/settings-list.md#setting-log-min-messages) `Log min messages`.

      * `--log-command-center-enabled` — передача логов [командного центра](../../managed-greenplum/concepts/command-center.md).

          Логи командного центра передаются полностью, изменить уровень логирования нельзя.

      * `--log-group-id` — идентификатор лог-группы, в которую будут записываться логи.

   * Terraform {#tf}

      1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
      1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
      1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

      1. В конфигурационном файле с описанием кластера укажите следующие параметры:

          ```hcl
          resource "yandex_mdb_greenplum_cluster" "gp-cluster" {
            name               = "<имя_кластера>"
            environment        = "PRODUCTION"
            network_id         = "<идентификатор_сети>"
            zone               = "<идентификатор_зоны_доступности>"
            subnet_id          = "<идентификатор_подсети_кластера>"
            assign_public_ip   = true
            version            = "<версия_СУБД>"
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

          * `version` — версия СУБД (Greenplum® или Apache Cloudberry™). Подробнее о [доступных версиях СУБД](../../managed-greenplum/concepts/overview.md).

          * `service_account_id` — идентификатор [созданного ранее](#before-you-begin) сервисного аккаунта.

          * `enabled` — управляет механизмом передачи логов. Для работы параметров, отвечающих за передачу конкретных логов, передайте значение `true`.

          * `greenplum_enabled` — передача логов СУБД.

              Вы можете [задать](../../managed-greenplum/operations/update.md#change-gp-settings) уровень логирования СУБД в [параметре](../../managed-greenplum/concepts/settings-list.md#setting-log-min-messages) `Log min messages`.

          * `command_center_enabled` — передача логов [командного центра](../../managed-greenplum/concepts/command-center.md).

              Логи командного центра передаются полностью, изменить уровень логирования нельзя.

          * `log_group_id` — идентификатор лог-группы, в которую будут записываться логи.

      1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

          ```bash
          terraform validate
          ```

          Если в файлах конфигурации есть ошибки, Terraform на них укажет.

      1. Создайте необходимую инфраструктуру:

          1. Выполните команду для просмотра планируемых изменений:
          
             ```bash
             terraform plan
             ```
          
             Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
          
          1. Если вас устраивают планируемые изменения, внесите их:
             1. Выполните команду:
          
                ```bash
                terraform apply
                ```
          
             1. Подтвердите изменение ресурсов.
             1. Дождитесь завершения операции.

   * API {#api}

      В теле запроса на создание кластера ([Cluster.Create](../../managed-greenplum/api-ref/Cluster/create.md) в REST API или [ClusterService.Create](../../managed-greenplum/api-ref/grpc/Cluster/create.md) в gRPC API) укажите следующие параметры:

      ```json
      {
        ...
        "config": {
          "version": "<версия_СУБД>",
          ...
          },
          ...
        },
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

      * `version` — версия СУБД (Greenplum® или Apache Cloudberry™). Подробнее о [доступных версиях СУБД](../../managed-greenplum/concepts/overview.md).

      * `serviceAccountId` — идентификатор [созданного ранее](#before-you-begin) сервисного аккаунта.

      * `enabled` — управляет механизмом передачи логов. Для работы параметров, отвечающих за передачу конкретных логов, передайте значение `true`.

      * `greenplumEnabled` — передача логов СУБД.

          Вы можете [задать](../../managed-greenplum/operations/update.md#change-gp-settings) уровень логирования СУБД в [параметре](../../managed-greenplum/concepts/settings-list.md#setting-log-min-messages) `Log min messages`.

      * `commandCenterEnabled` — передача логов [командного центра](../../managed-greenplum/concepts/command-center.md).

          Логи командного центра передаются полностью, изменить уровень логирования нельзя.

      * `logGroupId` — идентификатор лог-группы.

   {% endlist %}

1. Проверьте передачу логов кластера в лог-группу:

   {% list tabs group=instructions %}

   * Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) перейдите в нужный каталог.
      1. Перейдите в сервис **Cloud Logging**.
      1. Нажмите на строку с лог-группой `my-log-group`.

      На открывшейся странице отобразятся записи.

   * CLI {#cli}

      Чтобы посмотреть записи в формате JSON, выполните команду:

      ```bash
      yc logging read --group-name=my-log-group --format=json
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

      Чтобы посмотреть записи в лог-группе, воспользуйтесь вызовом REST API [Cluster.ListLogs](../../managed-greenplum/api-ref/Cluster/listLogs.md) или gRPC API [LogReadingService/Read](../api-ref/grpc/LogReading/read.md).

   {% endlist %}

   Подробнее см. в разделе [Чтение записей](../operations/read-logs.md).

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._

_Apache® и Apache Cloudberry™ являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._