---
title: "Создание кластера {{ OS }}"
description: "Кластер управляемого сервиса {{ OS }} — это группа из нескольких связанных друг с другом хостов {{ OS }}."
keywords:
  - создание кластера OpenSearch
  - кластер OpenSearch
  - OpenSearch
---

# Создание кластера {{ OS }}

[Кластер](../../glossary/cluster.md) {{ mos-name }} — это группа из нескольких связанных друг с другом хостов {{ OS }} и [Dashboards]({{ os.docs }}/dashboards/index/). Кластер обеспечивает высокую производительность поиска путем распределения задач поиска и индексации по всем хостам кластера с ролью `DATA`. Подробнее о ролях в кластере см. в разделе [Роли хостов](../concepts/host-roles.md).

Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

Подробнее см. в разделе [{#T}](../concepts/index.md).

## Создать кластер {#create-cluster}

При создании кластера для каждой [группы хостов](../concepts/host-groups.md) указываются отдельные параметры.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать кластер:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать кластер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

      1. Введите имя кластера. Оно должно быть уникальным в рамках каталога.
      1. (Опционально) Введите описание кластера.
      1. Выберите окружение, в котором нужно создать кластер (после создания кластера окружение изменить невозможно):

          * `PRODUCTION` — для стабильных версий ваших приложений.
          * `PRESTABLE` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.

      1. Выберите версию {{ OS }}.
      1. Выберите [плагины](plugins.md#supported-plugins), которые нужно установить в кластер.

  
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите облачную сеть для размещения кластера и группы безопасности для сетевого трафика кластера. Может потребоваться дополнительная [настройка групп безопасности](connect.md#security-groups) для того, чтобы можно было подключаться к кластеру.


  1. В блоке **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_virtual-node-group }} 1** задайте конфигурацию [группы хостов](../concepts/host-groups.md) `{{ OS }}`:

      1. Выберите тип группы хостов: `{{ OS }}`.

      1. Введите имя группы хостов. Оно должно быть уникальным в кластере.

      1. Выберите [роли хостов](../concepts/host-roles.md) `DATA` и `MANAGER`.

      1. Выберите платформу, тип и класс хостов.

          Класс хостов определяет технические характеристики виртуальных машин, на которых будут развернуты ноды {{ OS }}. Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md).

      1. Выберите [тип диска](../concepts/storage.md) и объем хранилища, который будет использоваться для данных.

          {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

      1. Укажите расположение хостов по зонам доступности и подсетям.

      1. Выберите количество создаваемых хостов.

      
      1. Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если вы хотите, чтобы к хостам можно было [подключаться](connect.md) через интернет.

          {% note tip %}

          Не рекомендуется включать публичный доступ для хостов с ролью `MANAGER`, т. к. это может быть небезопасно.

          {% endnote %}


      {% note warning %}

      Изменить конфигурацию хостов после создания кластера можно только с помощью [API](../../glossary/rest-api.md), однако при необходимости вы сможете создать новую группу хостов с другой конфигурацией.

      {% endnote %}

  1. При необходимости задайте конфигурацию [группы хостов](../concepts/host-groups.md) `Dashboards` в блоке **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_virtual-node-group }} 2**:

      1. Выберите платформу, тип и класс хостов.
      1. Настройте хранилище по аналогии с хостами `{{ OS }}`.
      1. Укажите расположение хостов по зонам доступности и подсетям.
      1. Выберите количество создаваемых хостов.
        
      
      1. Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если вы хотите, чтобы к хостам можно было [подключаться](connect.md) через интернет.

          {% include [mos-tip-public-dashboards](../../_includes/mdb/mos/public-dashboards.md) %}


  1. При необходимости добавьте еще одну или несколько групп хостов, нажав кнопку **{{ ui-key.yacloud.opensearch.cluster.node-groups.action_add-virtual-node-group }}**.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**:

      1. Укажите пароль для пользователя `admin`.

          {% include [Superuser](../../_includes/mdb/mos/superuser.md) %}

      1. При необходимости задайте дополнительные настройки кластера:

          {% include [Дополнительные настройки кластера](../../_includes/mdb/mos/extra-settings.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер:

  1. Посмотрите описание команды CLI для создания кластера:

      ```bash
      {{ yc-mdb-os }} cluster create --help
      ```

  1. Укажите параметры кластера в команде создания (в примере приведены не все доступные параметры):

      ```bash
      {{ yc-mdb-os }} cluster create \
         --name <имя_кластера> \
         --description <описание_кластера> \
         --labels <метки> \
         --environment <окружение:_production_или_prestable> \
         --network-name <имя_сети> \
         --security-group-ids <идентификаторы_групп_безопасности> \
         --service-account-name <имя_сервисного_аккаунта> \
         --delete-protection <защита_от_удаления:_true_или_false> \
         --maintenance schedule=<тип_технического_обслуживания>,`
                      `weekday=<день_недели>,`
                      `hour=<час_дня> \
         --version <версия_{{ OS }}> \
         --read-admin-password \
         --data-transfer-access=<true_или_false> \
         --serverless-access=<true_или_false> \
         --plugins <{{ OS }}_плагины> \
         --advanced-params <дополнительные_параметры> \
         --opensearch-node-group name=<имя_группы_хостов_{{ OS }}>,`
                                `resource-preset-id=<класс_хостов>,`
                                `disk-size=<размер_диска_в_байтах>,`
                                `disk-type-id=<тип_диска>,`
                                `hosts-count=<количество_хостов_в_группе>,`
                                `zone-ids=<зоны_доступности>,`
                                `subnet-names=<имена_подсетей>,`
                                `assign-public-ip=<назначить_публичный_адрес:_true_или_false>,`
                                `roles=<роли_хостов> \
         --dashboards-node-group name=<имя_группы_хостов_Dashboards>,`
                                `resource-preset-id=<класс_хостов>,`
                                `disk-size=<размер_диска_в_байтах>,`
                                `disk-type-id=<тип_диска>,`
                                `hosts-count=<количество_хостов_в_группе>,`
                                `zone-ids=<зоны_доступности>,`
                                `subnet-names=<имена_подсетей>,`
                                `assign-public-ip=<назначить_публичный_адрес:_true_или_false>
      ```

      Где:

      * `--labels` — [метки {{ yandex-cloud }}](../../resource-manager/concepts/labels.md) в формате `<ключ>=<значение>`. Используются для логического разделения ресурсов.
      * `--environment` — окружение:

          * `production` — для стабильных версий ваших приложений.
          * `prestable` — для тестирования. Prestable-окружение аналогично Production-окружению и на него также распространяется SLA, но при этом на нем раньше появляются новые функциональные возможности, улучшения и исправления ошибок. В Prestable-окружении вы можете протестировать совместимость новых версий с вашим приложением.

      * `--service-account-name` — имя сервисного аккаунта для [доступа к {{ objstorage-full-name }}](s3-access.md) в качестве репозитория [снапшотов](../../glossary/snapshot.md) {{ OS }}. Подробнее о сервисных аккаунтах см. в [документации {{ iam-full-name }}](../../iam/concepts/users/service-accounts.md).

      * `--delete-protection` — защита кластера от непреднамеренного удаления пользователем: `true` или `false`. Включенная защита от удаления кластера не помешает подключиться к нему вручную и удалить данные.

      * `--maintenance` — настройки времени технического обслуживания:

          * Чтобы разрешить проведение технического обслуживания в любое время, не указывайте параметр `--maintenance` в команде (конфигурация по умолчанию) либо укажите `--maintenance schedule=anytime`.
          * Чтобы указать предпочтительное время начала обслуживания, укажите в команде параметр `--maintenance schedule=weekly,weekday=<день_недели>,hour=<час_дня_по_UTC>`. Тогда техническое обслуживание будет проходить каждую неделю в обозначенный день и время.

          Операции по обслуживанию проводятся для включенных и выключенных кластеров. Во время обслуживания могут, например, применяться патчи или обновляться СУБД.

      * `--read-admin-password` — пароль пользователя `admin`. Если указать параметр в команде, после ее ввода будет предложено ввести пароль.
      * `--data-transfer-access` — доступ из [{{ data-transfer-full-name }}](../../data-transfer/index.yaml): `true` или `false`.
      * `--serverless-access` — доступ из [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml): `true` или `false`.
      * `--plugins` — [плагины {{ OS }}](../concepts/plugins.md), которые нужно установить в кластер.
      * `--advanced-params` — дополнительные параметры кластера. Возможные значения:

          * `max-clause-count` — максимально допустимое количество булевых выражений (boolean clauses) в запросе. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/query-dsl/compound/bool/).
          * `fielddata-cache-size` — объем кучи JVM, который выделен для структуры данных fielddata. Можно указать абсолютное значение или проценты, например, `512mb` или `50%`. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/install-and-configure/configuring-opensearch/index-settings/#cluster-level-index-settings).
          * `reindex-remote-whitelist` — список удаленных хостов, из индекса которых нужно скопировать документы для переиндексации. Укажите значение параметра в формате `<адрес_хоста>:<порт>`. Если нужно указать несколько хостов, перечислите значения через запятую. Подробнее см. в [документации {{ OS }}]({{ os.docs }}/im-plugin/reindex-data/#reindex-from-a-remote-cluster).

      {% include [cli-for-os-and-dashboards-groups](../../_includes/managed-opensearch/cli-for-os-and-dashboards-groups.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать кластер {{ mos-name }}:

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      * Кластер БД — описание кластера {{ mos-name }} и его хостов.

      * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

      * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

      Пример структуры конфигурационного файла:

      ```hcl
      resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
        name                = "<имя_кластера>"
        environment         = "<окружение>"
        network_id          = "<идентификатор_сети>"
        security_group_ids  = ["<список_идентификаторов_групп_безопасности>"]
        deletion_protection = "<защита_от_удаления>"

        config {

          version        = "<версия_{{ OS }}>"
          admin_password = "<пароль_пользователя-администратора>"

          opensearch {
            node_groups {
              name             = "<имя_группы_виртуальных_хостов>"
              assign_public_ip = <публичный_доступ>
              hosts_count      = <количество_хостов>
              zone_ids         = ["<список_зон_доступности>"]
              subnet_ids       = ["<список_идентификаторов подсетей>"]
              roles            = ["<список_ролей>"]
              resources {
                resource_preset_id = "<класс_хоста>"
                disk_size          = <размер_хранилища_в_байтах>
                disk_type_id       = "<тип_диска>"
              }
            }

            plugins = ["<список_имен_плагинов>"]

          }

          dashboards {
            node_groups {
              name             = "<имя_группы_виртуальных_хостов>"
              assign_public_ip = <публичный_доступ>
              hosts_count      = <количество_хостов>
              zone_ids         = ["<список_зон_доступности>"]
              subnet_ids       = ["<список_идентификаторов подсетей>"]
              resources {
                resource_preset_id = "<класс_хоста>"
                disk_size          = <размер_хранилища_в_байтах>
                disk_type_id       = "<тип_диска>"
              }
            }
          }
        }
      }

      resource "yandex_vpc_network" "<имя_сети>" { 
        name = "<имя_сети>"
      }

      resource "yandex_vpc_subnet" "<имя_подсети>" {
        name           = "<имя_подсети>"
        zone           = "<зона_доступности>"
        network_id     = "<идентификатор_сети>"
        v4_cidr_blocks = ["<диапазон>"]
      }
      ```

      Где:

      * `environment` — окружение: `PRESTABLE` или `PRODUCTION`.
      * `deletion_protection` — защита от удаления: `true` или `false`.
      * `assign_public_ip` — публичный доступ к хосту: `true` или `false`.
      * `roles` — роли хостов: `DATA` и `MANAGER`.

      {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

      {% include [Maintenance window](../../_includes/mdb/mos/terraform/maintenance-window.md) %}

      Полный список доступных для изменения полей конфигурации кластера {{ mos-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mos }}).

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте кластер.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mos/terraform/timeouts.md) %}

- API {#api}

  Чтобы создать кластер, воспользуйтесь методом REST API [create](../api-ref/Cluster/create.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../api-ref/grpc/cluster_service.md#Create) и передайте в запросе:

  * Идентификатор каталога, в котором должен быть размещен кластер, в параметре `folderId`.
  * Имя кластера в параметре `name`.
  * Версию {{ OS }} в параметре `configSpec.version`.
  * Пароль пользователя `admin` в параметре `configSpec.adminPassword`.
  * Конфигурацию одной или нескольких групп хостов с [ролями](../concepts/host-roles.md) `DATA` и `MANAGER` (опционально) в параметре `configSpec.opensearchSpec.nodeGroups`.
  * Конфигурацию одной или нескольких групп хостов с [ролью](../concepts/host-roles.md#dashboards) `DASHBOARDS` в параметре `configSpec.dashboardsSpec.nodeGroups`.
  * Список плагинов в параметре `configSpec.opensearchSpec.plugins`.
  * Настройки доступа из других сервисов в параметре `configSpec.access`.
  * Идентификатор сети в параметре `networkId`.

  
  * Идентификаторы групп безопасности в параметре `securityGroupIds`. Может потребоваться дополнительная [настройка групп безопасности](connect.md#security-groups) для того, чтобы можно было подключаться к кластеру.
  * Идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), используемого для работы с кластером, в параметре `serviceAccountId`.


  * Настройки защиты от удаления кластера в параметре `deletionProtection`.

      {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

  * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.

{% endlist %}

## Импортировать кластер в {{ TF }} {#import-cluster}

С помощью импорта вы можете передать существующие кластеры под управление {{ TF }}.

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. Укажите в конфигурационном файле {{ TF }} кластер, который необходимо импортировать:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {} 
        ```

    1. Выполните команду для импорта кластера:

        ```hcl
        terraform import yandex_mdb_opensearch_cluster.<имя_кластера> <идентификатор_кластера>
        ```

        Подробнее об импорте кластеров см. в [документации провайдера {{ TF }}]({{ tf-provider-mos }}#import).

{% endlist %}

## Примеры {#examples}

{% list tabs group=instructions %}

- CLI {#cli}

    Создайте кластер {{ mos-name }} с тестовыми характеристиками:

    * Имя — `my-os-clstr`.
    * Описание — `My OS cluster`.
    * Метка — `label-key` со значением `label-value`.
    * Окружение — `production`.
    * Имя сети — `{{ network-name }}`.
    * Идентификатор группы безопасности — `{{ security-group }}`.
    * Имя сервисного аккаунта — `os-account`.
    * Защита от удаления кластера — отключена.
    * Время технического обслуживания — каждый понедельник с 13:00 до 14:00.
    * Версия {{ OS }} — `2.8`.
    * Пароль пользователя `admin` — указывается после ввода команды по созданию кластера.
    * Доступ к {{ data-transfer-name }} — включен.
    * Доступ к {{ serverless-containers-name }} — включен.
    * Подключенный плагин {{ OS }} — analysis-icu.
    * Дополнительный параметр {{ OS }} — `fielddata-cache-size=50%`.
    * Конфигурация группы узлов `{{ OS }}`:

        * название группы — `os-group`;
        * класс хостов — `{{ host-class }}`;
        * размер диска — `10737418240` (в байтах);
        * тип диска — `network-ssd`;
        * количество хостов — три;
        * зона доступности — `{{ region-id }}-b`;
        * подсеть — `{{ network-name }}-{{ region-id }}-b`;
        * публичный адрес — выделен;
        * роли группы хостов — `DATA` и `MANAGER`.

    * Конфигурация группы хостов `Dashboards`:

        * название группы — `dashboard-group`;
        * класс хостов — `{{ host-class }}`;
        * размер диска — `10737418240` (в байтах);
        * тип диска — `network-ssd`;
        * количество хостов — один;
        * зона доступности — `{{ region-id }}-b`;
        * подсеть — `{{ network-name }}-{{ region-id }}-b`;
        * публичный адрес — выделен.

    Выполните команду:

    ```bash
    {{ yc-mdb-os }} cluster create \
       --name my-os-clstr \
       --description "My OS cluster" \
       --labels label-key=label-value \
       --environment production \
       --network-name {{ network-name }} \
       --security-group-ids {{ security-group }} \
       --service-account-name os-account \
       --delete-protection=false \
       --maintenance schedule=weekly,`
                    `weekday=mon,`
                    `hour=14 \
       --version 2.8 \
       --read-admin-password \
       --data-transfer-access=true \
       --serverless-access=true \
       --plugins analysis-icu \
       --advanced-params fielddata-cache-size=50% \
       --opensearch-node-group name=os-group,`
                              `resource-preset-id={{ host-class }},`
                              `disk-size=10737418240,`
                              `disk-type-id=network-ssd,`
                              `hosts-count=3,`
                              `zone-ids={{ region-id }}-b,`
                              `subnet-names={{ network-name }}-{{ region-id }}-b,`
                              `assign-public-ip=true,`
                              `roles=data+manager \
       --dashboards-node-group name=dashboard-group,`
                              `resource-preset-id={{ host-class }},`
                              `disk-size=10737418240,`
                              `disk-type-id=network-ssd,`
                              `hosts-count=1,`
                              `zone-ids={{ region-id }}-b,`
                              `subnet-names={{ network-name }}-{{ region-id }}-b,`
                              `assign-public-ip=true
    ```

- {{ TF }} {#tf}

    Создайте кластер {{ mos-name }} с тестовыми характеристиками:

    * Имя — `my-os-clstr`.
    * Окружение — `PRODUCTION`.
    * Версия {{ OS }} — `2.8`.
    * Пароль пользователя `admin` — `osadminpwd`.
    * Имя группы узлов `{{ OS }}` — `os-group`.
    * Класс хостов — `{{ host-class }}`.
    * Размер диска — `10737418240` (в байтах).
    * Тип диска — `{{ disk-type-example }}`.
    * Количество хостов — `1`.
    * Публичный адрес — выделен.
    * Роли группы хостов — `DATA` и `MANAGER`.
    * Имя сети — `mynet`.
    * Имя подсети — `mysubnet`.
    * Зона доступности — `{{ region-id }}-a`.
    * Диапазон адресов — `10.1.0.0/16`.
    * Имя группы безопасности — `os-sg`. Группа безопасности разрешает подключение к хосту кластера из любой сети (в том числе из интернета) по порту `9200`.

    Конфигурационный файл для такого кластера выглядит так:

    ```hcl
    resource "yandex_mdb_opensearch_cluster" "my-os-clstr" {
      name               = "my-os-clstr"
      environment        = "PRODUCTION"
      network_id         = yandex_vpc_network.mynet.id
      security_group_ids = [yandex_vpc_security_group.os-sg.id]

      config {

        version        = "2.8"
        admin_password = "osadminpwd"

        opensearch {
          node_groups {
            name             = "os-group"
            assign_public_ip = true
            hosts_count      = 1
            zone_ids         = ["{{ region-id }}-a"]
            subnet_ids       = [yandex_vpc_subnet.mysubnet.id]
            roles            = ["DATA", "MANAGER"]
            resources {
              resource_preset_id = "{{ host-class }}"
              disk_size          = 10737418240
              disk_type_id       = "{{ disk-type-example }}"
            }
          }
        }
      }
    }

    resource "yandex_vpc_network" "mynet" {
      name = "mynet"
    }

    resource "yandex_vpc_subnet" "mysubnet" {
      name           = "mysubnet"
      zone           = "{{ region-id }}-a"
      network_id     = yandex_vpc_network.mynet.id
      v4_cidr_blocks = ["10.1.0.0/16"]
    }

    resource "yandex_vpc_security_group" "os-sg" {
      name       = "os-sg"
      network_id = yandex_vpc_network.mynet.id

      ingress {
        description    = "Allow connections to the {{ mos-name }} cluster from the Internet"
        protocol       = "TCP"
        port           = 9200
        v4_cidr_blocks = ["0.0.0.0/0"]
      }

      egress {
        description    = "The rule allows all outgoing traffic"
        protocol       = "ANY"
        v4_cidr_blocks = ["0.0.0.0/0"]
        from_port      = 0
        to_port        = 65535
      }
    }
    ```

{% endlist %}
