---
title: Создание кластера {{ AF }}
description: Каждый кластер {{ maf-name }} состоит из набора компонентов {{ AF }}, каждый из которых может быть представлен в нескольких экземплярах. Экземпляры могут находиться в разных зонах доступности.
keywords:
  - создание кластера {{ AF }}
  - кластер {{ AF }}
  - '{{ AF }}'
  - Airflow
---

# Создание кластера {{ AF }}

Каждый [кластер](../../glossary/cluster.md) {{ maf-name }} состоит из набора компонентов {{ AF }}, каждый из которых может быть представлен в нескольких экземплярах. Экземпляры могут находиться в разных зонах доступности.

## Роли для создания кластера {#roles}

Для создания кластера {{ maf-name }} вашему аккаунту в {{ yandex-cloud }} нужны роли:

* [{{ roles.maf.editor }}](../security/index.md#managed-airflow-editor) — чтобы создать кластер;
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../../vpc/concepts/network.md#network) кластера;
* [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) — чтобы привязать сервисный аккаунт к кластеру.

Сервисному аккаунту кластера должна быть назначена роль `managed-airflow.integrationProvider`. Это даст кластеру нужные права для работы с пользовательскими ресурсами. Подробнее см. в разделе [Имперсонация](../concepts/impersonation.md).

О назначении ролей читайте в [документации {{ iam-full-name }}](../../iam/operations/roles/grant.md).

## Создать кластер {#create-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

  
  <iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvxzljddzxt6u5z4s6?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

  [Смотреть видео на YouTube](https://www.youtube.com/watch?v=vWCmvbrhDsI).



  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.airflow.button_create-cluster }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        1. Введите имя кластера. Имя должно быть уникальным в рамках каталога.
        1. (Опционально) Введите описание кластера.
        1. (Опционально) Создайте [метки](../../resource-manager/concepts/labels.md):
            1. Нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Введите метку в формате `ключ: значение`.
            1. Нажмите **Enter**.

  1. В блоке **{{ ui-key.yacloud.airflow.section_accesses }}**:

        * Задайте пароль пользователя-администратора. Пароль должен иметь длину не менее 8 символов и содержать как минимум:
            * одну заглавную букву;
            * одну строчную букву;
            * одну цифру;
            * один специальный символ.

           {% note info %}

           Сохраните пароль локально или запомните его. Сервис не показывает пароли после создания.

           {% endnote %}

        * Выберите существующий сервисный аккаунт или создайте новый.

           Сервисному аккаунту должна быть назначена [роль](../../iam/concepts/access-control/roles.md) `{{ roles.maf.integrationProvider }}`.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите:

      * [Зоны доступности](../../overview/concepts/geo-scope.md) для размещения кластера.
      * Облачную сеть.
      * Подсеть в каждой из выбранных зон доступности.

        {% include [choose-subnet](../../_includes/mdb/maf/choose-subnet.md) %}

      * [Группу безопасности](../concepts/network.md#security-groups) для сетевого трафика кластера.

        {% include [sg-ui-access](../../_includes/mdb/maf/note-sg-ui-access.md) %}

  1. Задайте количество экземпляров и [конфигурацию вычислительных ресурсов](../concepts/instance-types.md) для [компонентов](../concepts/index.md#components) {{ maf-name }}:

      * веб-сервера;
      * планировщика;
      * воркеров;

        {% note info %}

        Если очередь задач пуста, количество воркеров будет равно минимальному значению. При появлении задач количество воркеров будет увеличиваться вплоть до максимального значения.

        {% endnote %}

      * dag-процессора;
        
        {% include [dag-processor](../../_includes/mdb/maf/dag-processor.md) %}

      * (опционально) службы Triggerer.

  1. (Опционально) В блоке **{{ ui-key.yacloud.mdb.forms.section_dependencies }}** укажите названия pip- и deb-пакетов, чтобы установить в кластер дополнительные библиотеки и приложения для запуска DAG-файлов.

      Чтобы указать более одного пакета, нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

      При необходимости задайте ограничения на версии устанавливаемых пакетов, например:

      ```text
      pandas==2.0.2
      scikit-learn>=1.0.0
      clickhouse-driver~=0.2.0
      ```

      Формат названия пакета и выбор версии определены командой установки: `pip install` — для pip-пакетов, `apt install` — для deb-пакетов.

      {% note warning %}

      Для установки pip- и deb-пакетов из публичных репозиториев необходимо в блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** указать сеть с настроенным [NAT в интернет](../../vpc/operations/create-nat-gateway.md).

      {% endnote %}

  1. В блоке **{{ ui-key.yacloud.airflow.section_storage }}** выберите существующий бакет или создайте новый. В этом бакете будут храниться DAG-файлы.

      Сервисному аккаунту кластера должно быть [предоставлено разрешение](../../storage/operations/buckets/edit-acl.md) `READ` для этого бакета.

  1. (Опционально) В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}**:
      
      * Выберите время [технического обслуживания](../concepts/maintenance.md) кластера:

        {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}

      * Включите защиту кластера от удаления.

  1. (Опционально) В блоке **{{ ui-key.yacloud.airflow.section_airflow-configuration }}**:
  
      * Задайте [дополнительные свойства {{ AF }}](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html), например: ключ — `api.maximum_page_limit`, значение — `150`.

        Заполните поля вручную или загрузите конфигурацию из файла (см. [пример конфигурационного файла](https://{{ s3-storage-host }}/doc-files/managed-airflow/airflow.cfg)).

      * Включите опцию **{{ ui-key.yacloud.airflow.field_lockbox }}**, чтобы использовать секреты в сервисе [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) для [хранения конфигурационных данных, переменных и параметров подключений](../concepts/impersonation.md#lockbox-integration) {{ AF }}.

        {% include [sa-roles-for-lockbox](../../_includes/managed-airflow/sa-roles-for-lockbox.md) %}

  1. (Опционально) В блоке **Логирование** включите запись логов. Логи, сгенерированные компонентами {{ AF }}, будут отправляться в {{ cloud-logging-full-name }}. Задайте параметры логирования:

      * В поле **Назначение** укажите, куда будут записываться логи:
          * **Каталог** — выберите каталог. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
          * **Лог-группа** — выберите пользовательскую лог-группу или создайте новую.

      * Выберите минимальный уровень логирования: `TRACE`, `DEBUG`, `INFO` (значение по умолчанию), `WARN`, `ERROR` или `FATAL`.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы создать кластер {{ maf-name }}:

    1. Посмотрите описание команды CLI для создания кластера:

        ```bash
        {{ yc-mdb-af }} cluster create --help
        ```

    1. Укажите параметры кластера в команде создания (в примере приведены не все доступные параметры):

        ```bash
        {{ yc-mdb-af }} cluster create \
           --name <имя_кластера> \
           --description <описание_кластера> \
           --labels <список_меток> \
           --admin-password <пароль_администратора> \
           --service-account-id <идентификатор_сервисного_аккаунта> \
           --subnet-ids <идентификаторы_подсетей> \
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
           --dag-processor count=<количество_экземпляров>,`
                      `resource-preset-id=<идентификатор_ресурсов> \         
           --deb-packages <список_deb-пакетов> \
           --pip-packages <список_pip-пакетов> \
           --dags-bucket <имя_бакета> \
           --maintenance-window type=<тип_технического_обслуживания>,`
                                `day=<день_недели>,`
                                `hour=<час_дня> \
           --deletion-protection \                   
           --lockbox-secrets-backend \
           --airflow-config <список_свойств> \
           --log-enabled \
           --log-folder-id <идентификатор_каталога> \
           --log-min-level <уровень_логирования>
        ```

        {% include [CLI cluster parameters description](../../_includes/mdb/maf/cli/cluster-parameters.md) %}

        * `--subnet-ids` — список идентификаторов подсетей.

            {% include [choose-subnet](../../_includes/mdb/maf/choose-subnet.md) %}

        {% include [CLI cluster parameters description](../../_includes/mdb/maf/cli/cluster-parameters-part-2.md) %}


- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    Чтобы создать кластер {{ maf-name }}:

    1. Опишите в конфигурационном файле создаваемые ресурсы:

        * Кластер {{ maf-name }} — описание кластера.

        * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

        * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

        {% include [Terraform cluster parameters description](../../_includes/mdb/maf/terraform/cluster-parameters.md) %}

        * `subnet_ids` — список идентификаторов подсетей.

            {% include [choose-subnet](../../_includes/mdb/maf/choose-subnet.md) %}

        {% include [Terraform cluster parameters description](../../_includes/mdb/maf/terraform/cluster-parameters-part-2.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Создайте кластер {{ maf-name }}.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-maf }}).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "folderId": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { <список_меток> },
          "config": {
            "versionId": "<версия_{{ AF }}>",
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
              "enabled": <использование_секретов>
            },
            "dagProcessor": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resourcePresetId": "<идентификатор_ресурсов>"
              }
            }
          },
          "network": {
            "subnetIds": [ <список_идентификаторов_подсетей> ],
            "securityGroupIds": [ <список_идентификаторов_групп_безопасности> ]
          },
          "codeSync": {
            "s3": {
              "bucket": "<имя_бакета>"
            }
          },
          "maintenanceWindow": {
            "weeklyMaintenanceWindow": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          },
          "deletionProtection": <защита_от_удаления>,
          "serviceAccountId": "<идентификатор_сервисного_аккаунта>",
          "logging": {
            "enabled": <использование_логирования>,
            "minLevel": "<уровень_логирования>",
            "folderId": "<идентификатор_каталога>"
          },
          "adminPassword": "<пароль_администратора>"
        }
        ```

        Где:

        * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `config` — конфигурация кластера:

            * `versionId` — версия {{ AF }}.
            * `airflow.config` — [дополнительные свойства {{ AF }}](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html). Задаются в формате `"<раздел_конфигурации>.<ключ>": "<значение>"`, например:

                ```json
                "airflow": {
                  "config": {
                    "core.load_examples": "False"
                  }
                }
                ```

            * `webserver`, `scheduler`, `triggerer`, `worker`, `dagProcessor` — конфигурация [компонентов](../concepts/index.md#components) {{ maf-name }}:

                * `count` — количество экземпляров в кластере для веб-сервера, планировщика, DAG-процессора и Triggerer.
                * `minCount`, `maxCount` — минимальное и максимальное количество экземпляров в кластере для воркера.
                * `resources.resourcePresetId` — идентификатор вычислительных ресурсов веб-сервера, планировщика, DAG-процессора, воркера и Triggerer. Возможные значения:

                    * `c1-m2` — 1 vCPU, 2 ГБ RAM.
                    * `c1-m4` — 1 vCPU, 4 ГБ RAM.
                    * `c2-m4` — 2 vCPU, 4 ГБ RAM.
                    * `c2-m8` — 2 vCPU, 8 ГБ RAM.
                    * `c4-m8` — 4 vCPU, 8 ГБ RAM.
                    * `c4-m16` — 4 vCPU, 16 ГБ RAM.
                    * `c8-m16` — 8 vCPU, 16 ГБ RAM.
                    * `c8-m32` — 8 vCPU, 32 ГБ RAM.

                {% include notitle [dag-processor](../../_includes/mdb/maf/dag-processor.md) %}

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

        * `network` — сетевые настройки:

            * `subnetIds` — список идентификаторов подсетей.

                {% include [choose-subnet](../../_includes/mdb/maf/choose-subnet.md) %}

            * `securityGroupIds` — список идентификаторов [групп безопасности](../concepts/network.md#security-groups).

        * `codeSync.s3.bucket` — имя бакета, в котором будут храниться DAG-файлы.

        * {% include [maintenance](../../_includes/mdb/maf/maintenance-window-rest.md) %}

        * `deletionProtection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.

            Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

        * `serviceAccountId` — идентификатор сервисного аккаунта.

        * `logging` — параметры логирования:

            * `enabled` — позволяет включить логирование. Логи, сгенерированные компонентами {{ AF }}, будут отправляться в {{ cloud-logging-full-name }}. Возможные значения: `true` или `false`.
            * `minLevel` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`.
            * `folderId` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
            * `logGroupId` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

                Укажите один из двух параметров: `folderId` либо `logGroupId`.

        * `adminPassword` — пароль пользователя-администратора. Пароль должен иметь длину не менее 8 символов и содержать как минимум:

            * одну заглавную букву;
            * одну строчную букву;
            * одну цифру;
            * один специальный символ.

            {% note info %}

            Сохраните пароль локально или запомните его. Сервис не показывает пароли после создания.

            {% endnote %}

    1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --url 'https://airflow.api.cloud.yandex.net/managed-airflow/v1/clusters' \
            --data '@body.json'
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Создайте файл `body.json` и добавьте в него следующее содержимое:

        ```json
        {
          "folder_id": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "description": "<описание_кластера>",
          "labels": { <список_меток> },
          "config": {
            "version_id": "<версия_{{ AF }}>",
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
              "enabled": <использование_секретов>
            },
            "dag_processor": {
              "count": "<количество_экземпляров>",
              "resources": {
                "resource_preset_id": "<идентификатор_ресурсов>"
              }
            }
          },
          "network": {
            "subnet_ids": [ <список_идентификаторов_подсетей> ],
            "security_group_ids": [ <список_идентификаторов_групп_безопасности> ]
          },
          "code_sync": {
            "s3": {
              "bucket": "<имя_бакета>"
            }
          },
          "maintenance_window": {
            "weekly_maintenance_window": {
              "day": "<день_недели>",
              "hour": "<час>"
            }
          },
          "deletion_protection": <защита_от_удаления>,
          "service_account_id": "<идентификатор_сервисного_аккаунта>",
          "logging": {
            "enabled": <использование_логирования>,
            "min_level": "<уровень_логирования>",
            "folder_id": "<идентификатор_каталога>"
          },
          "admin_password": "<пароль_администратора>"
        }
        ```

        Где:

        * `folder_id` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
        * `name` — имя кластера.
        * `description` — описание кластера.
        * `labels` — список меток. Метки задаются в формате `"<ключ>": "<значение>"`.
        * `config` — конфигурация кластера:

            * `version_id` — версия {{ AF }}.
            * `airflow.config` — [дополнительные свойства {{ AF }}](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html). Задаются в формате `"<раздел_конфигурации>.<ключ>": "<значение>"`, например:

                ```json
                "airflow": {
                  "config": {
                    "core.load_examples": "False"
                  }
                }
                ```

            * `webserver`, `scheduler`, `triggerer`, `worker`, `dag_processor` — конфигурация [компонентов](../concepts/index.md#components) {{ maf-name }}:

                * `count` — количество экземпляров в кластере для веб-сервера, планировщика, DAG-процессора и Triggerer.
                * `min_count`, `max_count` — минимальное и максимальное количество экземпляров в кластере для воркера.
                * `resources.resource_preset_id` — идентификатор вычислительных ресурсов веб-сервера, планировщика, DAG-процессора, воркера и Triggerer. Возможные значения:

                    * `c1-m2` — 1 vCPU, 2 ГБ RAM.
                    * `c1-m4` — 1 vCPU, 4 ГБ RAM.
                    * `c2-m4` — 2 vCPU, 4 ГБ RAM.
                    * `c2-m8` — 2 vCPU, 8 ГБ RAM.
                    * `c4-m8` — 4 vCPU, 8 ГБ RAM.
                    * `c4-m16` — 4 vCPU, 16 ГБ RAM.
                    * `c8-m16` — 8 vCPU, 16 ГБ RAM.
                    * `c8-m32` — 8 vCPU, 32 ГБ RAM.
                
                {% include notitle [dag-processor](../../_includes/mdb/maf/dag-processor.md) %}

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

        * `network` — сетевые настройки:

            * `subnet_ids` — список идентификаторов подсетей.

                {% include [choose-subnet](../../_includes/mdb/maf/choose-subnet.md) %}

            * `security_group_ids` — список идентификаторов [групп безопасности](../concepts/network.md#security-groups).

        * `code_sync.s3.bucket` — имя бакета, в котором будут храниться DAG-файлы.

        * {% include [maintenance](../../_includes/mdb/maf/maintenance-window-grpc.md) %}

        * `deletion_protection` — позволяет включить защиту кластера от непреднамеренного удаления. Возможные значения: `true` или `false`.

            Включенная защита от удаления не помешает подключиться к кластеру вручную и удалить его.

        * `service_account_id` — идентификатор сервисного аккаунта.

        * `logging` — параметры логирования:

            * `enabled` — позволяет включить логирование. Логи, сгенерированные компонентами {{ AF }}, будут отправляться в {{ cloud-logging-full-name }}. Возможные значения: `true` или `false`.
            * `min_level` — минимальный уровень логирования. Возможные значения: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`.
            * `folder_id` — идентификатор каталога. Логи будут записываться в [лог-группу](../../logging/concepts/log-group.md) по умолчанию для этого каталога.
            * `log_group_id` — идентификатор пользовательской лог-группы. Логи будут записываться в нее.

                Укажите один из двух параметров: `folder_id` либо `log_group_id`.

        * `admin_password` — пароль пользователя-администратора. Пароль должен иметь длину не менее 8 символов и содержать как минимум:

            * одну заглавную букву;
            * одну строчную букву;
            * одну цифру;
            * один специальный символ.

            {% note info %}

            Сохраните пароль локально или запомните его. Сервис не показывает пароли после создания.

            {% endnote %}

    1. Воспользуйтесь вызовом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/airflow/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d @ \
            {{ api-host-airflow }}:{{ port-https }} \
            yandex.cloud.airflow.v1.ClusterService.Create \
            < body.json
        ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Примеры {#examples}

{% list tabs group=instructions %}

- CLI {#cli}

    Создайте кластер {{ maf-name }} с тестовыми характеристиками:

    * Имя — `myaf`.
    * Версия {{ AF }} — `3.0`.
    * Пароль администратора — `Password*1`.
    * Сервисный аккаунт с идентификатором `aje8r2rp7fkl********`.
    * Подсети с идентификаторами:
      
      * `e9bhbia2scnk********`
      * `e2lfqbm5nt9r********`
      * `fl8beqmjckv8********`

    * Один веб-сервер для размещения экземпляра {{ AF }} с классом хостов `c1-m2`.
    * Один планировщик с классом хостов `c1-m2`.
    * Задачи выполняют воркеры с классом хостов `c1-m2`, количество таких воркеров — от `1` до `4`.
    * Один DAG-процессор с классом хостов `c1-m2`.
    * Бакет с произвольным именем для хранения DAG-файлов.

    Выполните следующую команду:

    ```bash
    {{ yc-mdb-af }} cluster create \
      --name myaf \
      --airflow-version 3.0 \
      --admin-password Password*1 \
      --service-account-id aje8r2rp7fkl******** \
      --subnet-ids e9bhbia2scnk********,e2lfqbm5nt9r********,fl8beqmjckv8******** \
      --security-group-ids enp68jq81uun******** \
      --webserver count=1,resource-preset-id=c1-m2 \
      --scheduler count=1,resource-preset-id=c1-m2 \
      --worker min-count=1,max-count=4,resource-preset-id=c1-m2 \
      --dag-processor count=1,resource-preset-id=c1-m2 \
      --dags-bucket <имя_бакета>
    ```

- {{ TF }} {#tf}

    Создайте кластер {{ maf-name }} с тестовыми характеристиками:

    * Каталог с идентификатором `b1g4unjqq856********`.
    * Имя — `myaf`.
    * Версия {{ AF }} — `3.0`.
    * Пароль администратора — `Password*1`.
    * Новый сервисный аккаунт `af-sa` со следующими ролями:
      
      * `managed-airflow.integrationProvider`
      * `storage.editor`
      * `monitoring.editor`
    
    * Новая сеть `af-net` с подсетями:
      
      * `af-subnet-a` в зоне доступности `ru-central1-a` и с диапазоном адресов `10.1.0.0/24`;
      * `af-subnet-b` в зоне доступности `ru-central1-b` и с диапазоном адресов `10.2.0.0/24`;
      * `af-subnet-d` в зоне доступности `ru-central1-d` и с диапазоном адресов `10.3.0.0/24`.
    
    * Новая группа безопасности `af-sg`, разрешающая весь входящий и исходящий трафик.
    
    * Один веб-сервер для размещения экземпляра {{ AF }} с классом хостов `c1-m2`.
    * Один планировщик с классом хостов `c1-m2`.
    * Задачи выполняют воркеры с классом хостов `c1-m2`, количество таких воркеров — от `1` до `4`.
    * Один DAG-процессор с классом хостов `c1-m2`.
    * Новый бакет с произвольным именем для хранения DAG-файлов.

    Конфигурационный файл для такого кластера выглядит так:

    ```hcl
    locals {
      folder_id = "b1g4unjqq856********"
    }
    
    resource "yandex_airflow_cluster" "myaf" {
      name               = "myaf"
      airflow_version    = "3.0"
      admin_password     = "Password*1"
      service_account_id = yandex_iam_service_account.af-sa.id
      subnet_ids         = [yandex_vpc_subnet.af-subnet-a.id,yandex_vpc_subnet.af-subnet-b.id,yandex_vpc_subnet.af-subnet-d.id]
      security_group_ids = [yandex_vpc_security_group.af-sg.id]

      webserver = {
        count              = 1
        resource_preset_id = "c1-m2"
      }

      scheduler = {
        count              = 1
        resource_preset_id = "c1-m2"
      }

      worker = {
        min_count          = 1
        max_count          = 4
        resource_preset_id = "c1-m2"
      }

      dag_processor = {
        count              = 1
        resource_preset_id = "c1-m2"
      }

      code_sync = {
        s3 = {
          bucket = yandex_storage_bucket.af-bucket.bucket
        }
      }
    }

    resource "yandex_vpc_network" "af-net" {
      name = "af-net"
    }

    resource "yandex_vpc_subnet" "af-subnet-a" {
      name           = "af-subnet-a"
      zone           = "ru-central1-a"
      network_id     = yandex_vpc_network.af-net.id
      v4_cidr_blocks = ["10.1.0.0/24"]
    }

    resource "yandex_vpc_subnet" "af-subnet-b" {
      name           = "af-subnet-b"
      zone           = "ru-central1-b"
      network_id     = yandex_vpc_network.af-net.id
      v4_cidr_blocks = ["10.2.0.0/24"]
    }

    resource "yandex_vpc_subnet" "af-subnet-d" {
      name           = "af-subnet-d"
      zone           = "ru-central1-d"
      network_id     = yandex_vpc_network.af-net.id
      v4_cidr_blocks = ["10.3.0.0/24"]
    }

    resource "yandex_vpc_security_group" "af-sg" {
      name       = "af-sg"
      network_id = yandex_vpc_network.af-net.id
  
      ingress {
        protocol       = "ANY"
        v4_cidr_blocks = ["0.0.0.0/0"]
      }

      egress {
        protocol       = "ANY"
        v4_cidr_blocks = ["0.0.0.0/0"]
      }
    }

    resource "yandex_iam_service_account" "af-sa" {
      name = "af-sa"
    }

    resource "yandex_resourcemanager_folder_iam_member" "sa-role-af" {
      folder_id = local.folder_id
      role      = "managed-airflow.integrationProvider"
      member    = "serviceAccount:${yandex_iam_service_account.af-sa.id}"
    }

    resource "yandex_resourcemanager_folder_iam_member" "sa-role-storage" {
      folder_id = local.folder_id
      role      = "storage.editor"
      member    = "serviceAccount:${yandex_iam_service_account.af-sa.id}"
    }

    resource "yandex_resourcemanager_folder_iam_member" "sa-role-monitoring" {
      folder_id = local.folder_id
      role      = "monitoring.editor"
      member    = "serviceAccount:${yandex_iam_service_account.af-sa.id}"
    }

    resource "yandex_storage_bucket" "af-bucket" {
      bucket    = "<имя_бакета>"
      folder_id = local.folder_id
    }
    ```

{% endlist %}
