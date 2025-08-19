---
title: Изменение кластера {{ SPRK }}
description: После создания кластера {{ SPRK }} вы можете изменить его основные и дополнительные настройки.
keywords:
  - изменение кластера {{ SPRK }}
  - кластер {{ SPRK }}
  - '{{ SPRK }}'
---

# Изменение кластера {{ SPRK }}

{% include notitle [preview](../../_includes/note-preview.md) %}

После создания кластера вы можете изменить его основные и дополнительные настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы изменить настройки кластера:

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spark }}**.

    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:
       * Измените имя и описание кластера.
       * Удалите или добавьте новые [метки](../../resource-manager/concepts/labels.md).
       * Выберите сервисный аккаунт или [создайте новый](../../iam/operations/sa/create.md#create-sa) с ролью  `managed-spark.integrationProvider`. Это даст кластеру нужные права для работы с другими ресурсами.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите [группу безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера.

    1. В блоках **{{ ui-key.yacloud.spark.section_driver }}** и **{{ ui-key.yacloud.spark.section_executor }}** укажите количество экземпляров и [конфигурацию вычислительных ресурсов](../concepts/instance-types.md). Количество экземпляров может быть фиксированным или автомасштабируемым.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}**:

        1. Удалите или добавьте названия pip- и deb-пакетов.

           Формат названия пакета и выбор версии определены командой установки: `pip install` — для pip-пакетов, `apt install` — для deb-пакетов.
        1. В настройке **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** измените время технического обслуживания кластера:

           {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

        1. Выберите кластер [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md) для подключения в качестве хранилища метаданных.
        1. Установите или снимите защиту от удаления кластера.
        1. Включите или выключите **{{ ui-key.yacloud.spark.label_history-server }}**. Опция позволяет использовать сервис для мониторинга приложений [Spark History Server](https://spark.apache.org/docs/latest/monitoring.html).
        1. Включите или выключите **{{ ui-key.yacloud.logging.field_logging }}**. Опция включает логирование Spark-приложений в кластере:
            1. Выберите место записи логов:
                * **{{ ui-key.yacloud.common.folder }}** — выберите каталог из списка.
                * **{{ ui-key.yacloud.logging.label_group }}** — выберите [лог-группу](../../logging/concepts/log-group.md) из списка или создайте новую.
            1. Выберите **{{ ui-key.yacloud.logging.label_minlevel }}** из списка.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- {{ TF }} {#tf}

    Чтобы изменить настройки кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Чтобы изменить настройки кластера, измените значения нужных полей в конфигурационном файле.

        {% note alert %}

        Не изменяйте имя кластера с помощью {{ TF }}. Это приведет к удалению существующего кластера и созданию нового.

        {% endnote %}

        Пример структуры конфигурационного файла:

        ```hcl
        resource "yandex_spark_cluster" "my_spark_cluster" {
          description         = "<описание_кластера>"
          name                = "my-spark-cluster"
          folder_id           = "<идентификатор_каталога>"
          service_account_id  = "<идентификатор_сервисного_аккаунта>"
          deletion_protection = <защитить_кластер_от_удаления>

          labels = {
            <список_меток>
          }

          network = {
            subnet_ids         = ["<список_идентификаторов_подсетей>"]
            security_group_ids = ["<список_идентификаторов_групп_безопасности>"]
          }

          config = {
            resource_pools = {
              driver = {
                resource_preset_id = "<класс_хоста>"
                size               = <фиксированное_количество_экземпляров>
              }
              executor = {
                resource_preset_id = "<класс_хоста>"
                size               = <фиксированное_количество_экземпляров>
              }
            }
            history_server = {
              enabled = <использование_Apache_Spark_History_Server>
            } 
            metastore = {
              cluster_id = "<идентификатор_кластера_Metastore>"
            }
            dependencies = {
              deb_packages = ["<список_deb-пакетов>"]
              pip_packages = ["<список_pip-пакетов>"]
            }
          }

          maintenance_window = {
            type = "<тип_технического_обслуживания>"
            day  = "<день_недели>"
            hour = "<час_дня>"
          }

          logging = {
            enabled      = <включить_логирование>
            folder_id    = "<идентификатор_каталога>"
          }

        }
        ```

        Где:

        * `description` — описание кластера.
        * `service_account_id` — идентификатор сервисного аккаунта.
        * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.
        * `labels` — список меток. Метки задаются в формате `<ключ> = "<значение>"`.
        * `security_group_ids` — список идентификаторов групп безопасности.
        * `driver` — конфигурация хостов для запуска драйверов {{ SPRK }}. В этом блоке укажите:

          * [Класс хостов](../concepts/instance-types.md) в параметре `resource_preset_id`.
          * Количество экземпляров. Укажите фиксированное количество в параметре `size` или минимальное и максимальное количество для автомасштабирования в параметрах `min_size` и `max_size`.

        * `executor` — конфигурация хостов для запуска исполнителей {{ SPRK }}. В этом блоке укажите:

          * [Класс хостов](../concepts/instance-types.md) в параметре `resource_preset_id`.
          * Количество экземпляров. Укажите фиксированное количество в параметре `size` или минимальное и максимальное количество для автомасштабирования в параметрах `min_size` и `max_size`.

        * `maintenance_window` – параметры технического обслуживания (в т. ч. для выключенных кластеров). В этом блоке укажите:

          * Тип технического обслуживания в параметре `type`. Принимает значения:
            * `ANYTIME` — в любое время.
            * `WEEKLY` — по расписанию.
          * День недели для типа обслуживания `WEEKLY` в параметре `day`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
          * Час дня по UTC для типа обслуживания `WEEKLY` в параметре `hour`: от `1` до `24`.

        * `history_server` — подключение сервиса {{ SPRK }} History Server. Для использования сервиса укажите `true` в параметре `enabled`.

        * `metastore` — подключение хранилища метаданных [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md). Укажите идентификатор кластера {{ metastore-name }} в параметре `cluster_id`.

        * `dependencies` — дополнительные deb- и pip-пакеты для запуска заданий {{ SPRK }}. В этом блоке укажите:
          * `deb_packages` — названия deb-пакетов. Их формат определяет команда установки `apt install`.
          * `pip_packages` — названия pip-пакетов. Их формат определяет команда установки `pip install`.

        * `logging` — параметры логирования. Сгенерированные компонентами {{ SPRK }} логи будут отправляться в {{ cloud-logging-full-name }}. Для включения логирования:

          * Установите значение `enabled = true`.
          * Задайте одно из двух мест хранения логов:

             * `folder_id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
             * `log_group_id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-maf }}).

- gRPC API {#grpc-api}

    Чтобы изменить настройки кластера:

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "cluster_id": "<идентификатор_кластера>",
          "update_mask": "<список_изменяемых_параметров>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { <список_меток> },
          "config_spec": {
           "resource_pools": {
             "driver": {
               "resource_preset_id": "<идентификатор_ресурсов_драйвера>",
               "scale_policy": {
                 "fixed_scale": {
                   "size": "<количество_экземпляров_драйвера>"
                 }
               }
             },
             "executor": {
               "resource_preset_id": "<идентификатор_ресурсов_исполнителя>",
               "scale_policy": {
                 "auto_scale": {
                   "min_size": "<минимальное_количество_экземпляров_исполнителя>",
                   "max_size": "<максимальное_количество_экземпляров_исполнителя>"
                 }
               }
             }
           },
           "history_server": {
             "enabled": <использование_Apache_Spark_History_Server>
           },
            "dependencies": {
              "pip_packages": [ <список_pip-пакетов> ],
              "deb_packages": [ <список_deb-пакетов> ]
            },
            "metastore": {
              "cluster_id": "<идентификатор_кластера_Metastore>"
            }
          },
          "network_spec": {
            "security_group_ids": [ <список_идентификаторов_групп_безопасности> ]
          },
          "deletion_protection": <защита_от_удаления>,
          "service_account_id": "<идентификатор_сервисного_аккаунта>",
          "logging": {
            "enabled": <использование_логирования>,
            "log_group_id": "<идентификатор_лог_группы>",
            "folder_id": "<идентификатор_каталога>"
          }
        }
        ```

        Где:

        * `cluster_id` — идентификатор кластера. Его можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            {% cut "Формат перечисления настроек" %}

            ```yaml
            "update_mask": {
                "paths": [
                    "<настройка_1>",
                    "<настройка_2>",
                    ...
                    "<настройка_N>"
                ]
            }
            ```

            {% endcut %}

            {% note warning %}

            Все параметры изменяемого кластера, которые не были явно переданы в запросе, будут переопределены на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

            {% endnote %}

        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `config_spec` — конфигурация кластера:

           * `resource_pools` — конфигурация пулов ресурсов:

               * `driver` — конфигурация хостов для запуска драйверов {{ SPRK }}.

                   * `resource_preset_id` — [класс хостов](../concepts/instance-types.md) драйвера.
                   * `scale_policy` — политика масштабирования групп хостов для драйвера:
                       * `fixed_scale` — фиксированная политика масштабирования.

                          * `size` — количество хостов для драйвера.

                       * `auto_scale` — автоматическая политика масштабирования.

                           * `min_size` — минимальное количество хостов для драйвера.
                           * `max_size` — максимальное количество хостов для драйвера.

                       Укажите один из двух параметров: `fixed_scale` либо `auto_scale`.

               * `executor` — конфигурация хостов для запуска исполнителей {{ SPRK }}.

                   * `resource_preset_id` — [класс хостов](../concepts/instance-types.md) исполнителя.
                   * `scale_policy` — политика масштабирования групп хостов для исполнителя:

                       * `fixed_scale` — фиксированная политика масштабирования.

                           * `size` — количество хостов для исполнителя.

                       * `auto_scale` — автоматическая политика масштабирования.

                           * `min_size` — минимальное количество хостов для исполнителя.
                           * `max_size` — максимальное количество хостов для исполнителя.

                       Укажите один из двух параметров: `fixed_scale` либо `auto_scale`.

               * `history_server` — параметры сервера истории.

                   * `enabled` — флаг включения сервера истории. Позволяет использовать сервис для мониторинга приложений Spark History Server.

               * `dependencies` — списки пакетов, которые позволяют установить в кластер дополнительные библиотеки и приложения.

                   * `pip_packages` — список pip-пакетов.
                   * `deb_packages` — список deb-пакетов.

                   При необходимости задайте ограничения на версии устанавливаемых пакетов, например:

                   ```bash
                   "dependencies": {
                     "pip_packages": [
                       "pandas==2.0.2",
                       "scikit-learn>=1.0.0",
                       "clickhouse-driver~=0.2.0"
                     ]
                   }
                   ```

                   Формат названия пакета и выбор версии определены командой установки: `pip install` — для pip-пакетов, `apt install` — для deb-пакетов.

               * `metastore` — параметры хранилища метаданных кластера.

                   * `cluster_id` — идентификатор кластера [{{ metastore-name }}](../../metadata-hub/concepts/metastore.md).

           * `network` — сетевые настройки:

               * `security_group_ids` — список идентификаторов [групп безопасности](../../vpc/concepts/security-groups.md).

           * `deletion_protection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.

              Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

           * `service_account_id` — идентификатор сервисного аккаунта для доступа к сервисам {{ yandex-cloud }}. Сервисному аккаунту должна быть назначена роль `managed-spark.integrationProvider`.

           * `logging` — параметры логирования:
               * `enabled` — позволяет включить логирование. Возможные значения: `true` или `false`. Логи, сгенерированные компонентами {{ SPRK }}, будут отправляться в {{ cloud-logging-full-name }}. Возможные значения: `true` или `false`.
               * `folder_id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
               * `log_group_id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

               Укажите один из двух параметров: `folder_id` либо `log_group_id`.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/spark/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-spark }}:{{ port-https }} \
            yandex.cloud.spark.v1.ClusterService.Update \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}
