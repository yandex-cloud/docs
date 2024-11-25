---
title: Изменение кластера {{ AF }}
description: После создания кластера вы можете изменить его основные и дополнительные настройки.
keywords:
  - изменение кластера {{ AF }}
  - кластер {{ AF }}
  - '{{ AF }}'
  - Airflow
---

# Изменение кластера {{ AF }}

После создания кластера вы можете изменить его основные и дополнительные настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.

    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** измените имя и описание кластера, удалите или добавьте новые метки.

    1. В блоке **{{ ui-key.yacloud.airflow.section_accesses }}** выберите сервисный аккаунт или [создайте новый](../../iam/operations/sa/create.md#create-sa) с ролью  `managed-airflow.integrationProvider`. Это даст кластеру нужные права для работы с пользовательскими ресурсами. Подробнее см. в разделе [Имперсонация](../concepts/impersonation.md).
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите [группу безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера или создайте ее.

       {% include [sg-ui-access](../../_includes/mdb/maf/note-sg-ui-access.md) %}

    1. В блоках для настройки [компонентов](../concepts/index.md#components) {{ maf-name }} — **{{ ui-key.yacloud.airflow.section_webserver }}**, **{{ ui-key.yacloud.airflow.section_scheduler }}**, **{{ ui-key.yacloud.airflow.section_workers }}** — укажите количество экземпляров и ресурсов.

    1. В блоке **{{ ui-key.yacloud.airflow.section_triggerer }}** включите или выключите службу Triggerer. Если служба включена, укажите количество экземпляров и ресурсов.

    1. В блоке **{{ ui-key.yacloud.airflow.section_dependencies }}** удалите или добавьте названия pip- и deb-пакетов.

    1. В блоке **{{ ui-key.yacloud.airflow.section_storage }}** выберите существующий бакет для хранения DAG-файлов или создайте новый. Сервисному аккаунту кластера должно быть [предоставлено разрешение](../../storage/operations/buckets/edit-acl.md) `READ` для этого бакета.

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** установите или снимите защиту от удаления.

    1. В блоке **{{ ui-key.yacloud.airflow.section_airflow-configuration }}**:

        * Добавьте, измените или удалите [дополнительные свойства {{ AF }}](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html), например: ключ — `api.maximum_page_limit`, значение — `150`.

            Заполните поля вручную или загрузите конфигурацию из файла (см. [пример конфигурационного файла](https://{{ s3-storage-host }}/doc-files/managed-airflow/airflow.cfg)).

        * Включите или выключите опцию **{{ ui-key.yacloud.airflow.field_lockbox }}**, которая позволяет использовать секреты в сервисе [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../concepts/impersonation.md#lockbox-integration) {{ AF }}.

            {% include [sa-roles-for-lockbox](../../_includes/managed-airflow/sa-roles-for-lockbox.md) %}

    1. В блоке **Логирование** включите или выключите запись логов. Если логирование включено, укажите, в какую лог-группу будут записываться логи и минимальный уровень логирования. Логи, сгенерированные компонентами {{ AF }}, будут отправляться в {{ cloud-logging-full-name }}.

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-af }} cluster update --help
        ```

    1. Передайте список настроек, которые хотите изменить, в команде изменения кластера:

        ```bash
        {{ yc-mdb-af }} managed-airflow cluster update <имя_или_идентификатор_кластера> \
           --new-name <новое_имя_кластера> \
           --description <описание_кластера> \
           --labels <список_меток> \
           --service-account-id <идентификатор_сервисного_аккаунта> \
           --security-group-ids <идентификаторы_групп_безопасности> \
           --webserver count=<количество_экземпляров>,`
                      `resource-preset-id=<идентификатор_ресурсов> \
           --scheduler count=<количество_экземпляров>,`
                      `resource-preset-id=<идентификатор_ресурсов> \
           --worker min-count=<минимальное_количество_экземпляров>,`
                   `max-count=<максимальное_количество_экземпляров>,`
                   `resource-preset-id=<идентификатор_ресурсов> \
           --triggerer count=<количество_экземпляров>,`
                      `resource-preset-id=<идентификатор_ресурсов> \
           --deb-packages <список_deb-пакетов> \
           --pip-packages <список_pip-пакетов> \
           --dags-bucket <имя-бакета> \
           --deletion-protection \
           --lockbox-secrets-backend \
           --log-enabled \
           --log-folder-id <идентификатор_каталога> \
           --log-min-level <уровень_логирования>
        ```

        {% include [CLI cluster parameters description](../../_includes/mdb/maf/cli/cluster-parameters.md) %}

        Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](../operations/cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Чтобы изменить настройки кластера, измените значения нужных полей в конфигурационном файле.

        {% note alert %}

        Не изменяйте имя кластера и пароль с помощью {{ TF }}. Это приведет к удалению существующего кластера и созданию нового.

        {% endnote %}

        {% include [Terraform cluster parameters description](../../_includes/mdb/maf/terraform/cluster-parameters.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-maf }}).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "updateMask": "<список_изменяемых_параметров>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { <список_меток> },
          "configSpec": {
            "airflow": {
              "config": { <список_свойств> }
            },
            "webserver": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resourcePresetId": "<идентификатор_ресурсов>"
              }
            },
            "scheduler": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resourcePresetId": "<идентификатор_ресурсов>"
              }
            },
            "triggerer": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resourcePresetId": "<идентификатор_ресурсов>"
              }
            },
            "worker": {
              "minCount": "<минимальное_количество_экземпляров>",
              "maxCount": "<максимальное_количество_экземпляров>",
              "resources": {
                "resourcePresetId": "<идентификатор_ресурсов>"
              }
            },
            "dependencies": {
              "pipPackages": [ <список_pip-пакетов> ],
              "debPackages": [ <список_deb-пакетов> ]
            },
            "lockbox": {
              "enabled": <использование_логирования>
            }
          },
          "codeSync": {
            "s3": {
              "bucket": "<имя_бакета>"
            }
          },
          "networkSpec": {
            "securityGroupIds": [ <список_идентификаторов_групп_безопасности> ]
          },
          "deletionProtection": <защита_от_удаления>,
          "serviceAccountId": "<идентификатор_сервисного_аккаунта>",
          "logging": {
            "enabled": <использование_логирования>,
            "minLevel": "<уровень_логирования>",
            "folderId": "<идентификатор_каталога>"
          }
        }
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            {% note warning %}

            При изменении кластера будут переопределены все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask`.

            {% endnote %}

        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `config` — конфигурация кластера:

            * `airflow.config` — [дополнительные свойства {{ AF }}](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html). Задаются в формате `"<раздел_конфигурации>.<ключ>": "<значение>"`, например:

                ```bash
                "airflow": {
                  "config": {
                    "core.load_examples": "False"
                  }
                }
                ```

            * `webserver`, `scheduler`, `triggerer`, `worker` — конфигурация [компонентов](../concepts/index.md#components) {{ maf-name }}:

                * `count` — количество экземпляров в кластере для веб-сервера, планировщика и триггера.
                * `minCount`, `maxCount` — минимальное и максимальное количество экземпляров в кластере для воркера.
                * `resources.resourcePresetId` — идентификатор вычислительных ресурсов веб-сервера, планировщика, воркера и триггера. Возможные значения:

                    * `c1-m4` — 1 vCPU, 4 ГБ RAM.
                    * `c2-m8` — 2 vCPU, 8 ГБ RAM.
                    * `c4-m16` — 4 vCPU, 16 ГБ RAM.
                    * `c8-m32` — 8 vCPU, 32 ГБ RAM.

            * `dependencies` — списки пакетов, которые позволяют установить в кластер дополнительные библиотеки и приложения для запуска DAG-файлов:

                * `pipPackages` — список pip-пакетов.
                * `debPackages` — список deb-пакетов.

                При необходимости задайте ограничения на версии устанавливаемых пакетов, например:

                ```bash
                "dependencies": {
                  "pipPackages": [
                    "pandas==2.0.2",
                    "scikit-learn>=1.0.0",
                    "clickhouse-driver~=0.2.0"
                  ]
                }
                ```

                Формат названия пакета и выбор версии определены командой установки: `pip install` — для pip-пакетов, `apt install` — для deb-пакетов.

            * `lockbox.enabled` — позволяет использовать секреты в сервисе [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../concepts/impersonation.md#lockbox-integration) {{ AF }}. Возможные значения: `true` или `false`.

        * `network.securityGroupIds` — список идентификаторов групп безопасности.

        * `codeSync.s3.bucket` — имя бакета, в котором будут храниться DAG-файлы.
        * `deletionProtection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.

            Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

        * `serviceAccountId` — идентификатор сервисного аккаунта, [созданного ранее](#before-creating).
        * `logging` — параметры логирования:

            * `enabled` — позволяет включить логирование. Логи, сгенерированные компонентами {{ AF }}, будут отправляться в {{ cloud-logging-full-name }}. Возможные значения: `true` или `false`.
            * `minLevel` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`.
            * `folderId` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
            * `logGroupId` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

                Укажите один из двух параметров: `folderId` либо `logGroupId`.

    1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters/<идентификатор_кластера>'
            --data '@body.json'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

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
            "airflow": {
              "config": { <список_свойств> }
            },
            "webserver": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resource_preset_id": "<идентификатор_ресурсов>"
              }
            },
            "scheduler": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resource_preset_id": "<идентификатор_ресурсов>"
              }
            },
            "triggerer": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resource_preset_id": "<идентификатор_ресурсов>"
              }
            },
            "worker": {
              "min_count": "<минимальное_количество_экземпляров>",
              "max_count": "<максимальное_количество_экземпляров>",
              "resources": {
                "resource_preset_id": "<идентификатор_ресурсов>"
              }
            },
            "dependencies": {
              "pip_packages": [ <список_pip-пакетов> ],
              "deb_packages": [ <список_deb-пакетов> ]
            },
            "lockbox": {
              "enabled": <использование_логирования>
            }
          },
          "code_sync": {
            "s3": {
              "bucket": "<имя_бакета>"
            }
          },
          "network_spec": {
            "security_group_ids": [ <список_идентификаторов_групп_безопасности> ]
          },
          "deletion_protection": <защита_от_удаления>,
          "service_account_id": "<идентификатор_сервисного_аккаунта>",
          "logging": {
            "enabled": <использование_логирования>,
            "min_level": "<уровень_логирования>",
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

            При изменении кластера будут переопределены все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask`.

            {% endnote %}

        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `config_spec` — конфигурация кластера:

            * `airflow.config` — [дополнительные свойства {{ AF }}](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html). Задаются в формате `"<раздел_конфигурации>.<ключ>": "<значение>"`, например:

                ```bash
                "airflow": {
                  "config": {
                    "core.load_examples": "False"
                  }
                }
                ```

            * `webserver`, `scheduler`, `triggerer`, `worker` — конфигурация [компонентов](../concepts/index.md#components) {{ maf-name }}:

                * `count` — количество экземпляров в кластере для веб-сервера, планировщика и триггера.
                * `min_count`, `max_count` — минимальное и максимальное количество экземпляров в кластере для воркера.
                * `resources.resource_preset_id` — идентификатор вычислительных ресурсов веб-сервера, планировщика, воркера и триггера. Возможные значения:

                    * `c1-m4` — 1 vCPU, 4 ГБ RAM.
                    * `c2-m8` — 2 vCPU, 8 ГБ RAM.
                    * `c4-m16` — 4 vCPU, 16 ГБ RAM.
                    * `c8-m32` — 8 vCPU, 32 ГБ RAM.

            * `dependencies` — списки пакетов, которые позволяют установить в кластер дополнительные библиотеки и приложения для запуска DAG-файлов:

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

            * `lockbox.enabled` — позволяет использовать секреты в сервисе [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../concepts/impersonation.md#lockbox-integration) {{ AF }}. Возможные значения: `true` или `false`.

        * `network_spec.security_group_ids` — список идентификаторов групп безопасности.

        * `code_sync.s3.bucket` — имя бакета, в котором будут храниться DAG-файлы.
        * `deletion_protection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.

            Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

        * `service_account_id` — идентификатор сервисного аккаунта, [созданного ранее](#before-creating).
        * `logging` — параметры логирования:

            * `enabled` — позволяет включить логирование. Логи, сгенерированные компонентами {{ AF }}, будут отправляться в {{ cloud-logging-full-name }}. Возможные значения: `true` или `false`.
            * `min_level` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`.
            * `folder_id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
            * `log_group_id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

                Укажите один из двух параметров: `folder_id` либо `log_group_id`.

    1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-airflow }}:{{ port-https }} \
            yandex.cloud.airflow.v1.ClusterService.Update \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}
