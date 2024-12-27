---
title: Создание кластера {{ OS }}
description: Кластер управляемого сервиса {{ OS }} — это группа из нескольких связанных друг с другом хостов {{ OS }}.
keywords:
  - создание кластера OpenSearch
  - кластер OpenSearch
  - OpenSearch
---

# Создание кластера {{ OS }}


[Кластер](../../glossary/cluster.md) {{ mos-name }} — это группа из нескольких связанных друг с другом хостов {{ OS }} и [Dashboards]({{ os.docs }}/dashboards/index/). Кластер обеспечивает высокую производительность поиска путем распределения задач поиска и индексации по всем хостам кластера с ролью `DATA`. Подробнее о ролях в кластере см. в разделе [Роли хостов](../concepts/host-roles.md).

Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

Подробнее см. в разделе [Взаимосвязь ресурсов сервиса](../concepts/index.md).


## Роли для создания кластера {#roles}

Для создания кластера {{ mos-name }} нужна роль [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) и роль [{{ roles.mos.editor }}](../security/index.md#managed-opensearch-editor) или выше.

Если вы хотите привязать сервисный аккаунт к кластеру (например, для [работы с {{ objstorage-full-name }}](s3-access.md)), вашему аккаунту в {{ yandex-cloud }} нужна роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.

О назначении ролей читайте в [документации {{ iam-full-name }}](../../iam/operations/roles/grant.md).


## Создать кластер {#create-cluster}

При создании кластера для каждой [группы хостов](../concepts/host-roles.md) указываются отдельные параметры.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать кластер {{ mos-name }}:

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


  1. В блоке **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_virtual-node-group }} 1** задайте конфигурацию [группы хостов](../concepts/host-roles.md) `{{ OS }}`:

      1. Выберите тип группы хостов: `{{ OS }}`.

      1. Введите имя группы хостов. Оно должно быть уникальным в кластере.

      1. Выберите [роли хостов](../concepts/host-roles.md) `DATA` и `MANAGER`.

      1. Выберите платформу, тип и класс хостов.

          Класс хостов определяет технические характеристики виртуальных машин, на которых будут развернуты ноды {{ OS }}. Все доступные варианты перечислены в разделе [Классы хостов](../concepts/instance-types.md).

      1. Выберите [тип диска](../concepts/storage.md) и объем хранилища, который будет использоваться для данных.

          {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

      1. (Опционально) В блоке **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}** настройте автоматическое увеличение размера диска:

          {% include [console-autoscaling](../../_includes/mdb/mos/console_autoscaling.md) %}

      1. Укажите расположение хостов по [зонам доступности](../../overview/concepts/geo-scope.md) и подсетям.

      1. Выберите количество создаваемых хостов.


      1. Включите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**, если вы хотите, чтобы к хостам можно было [подключаться](connect.md) через интернет.

          {% note tip %}

          Не рекомендуется включать публичный доступ для хостов с ролью `MANAGER`, т. к. это может быть небезопасно.

          {% endnote %}


      {% note warning %}

      Изменить конфигурацию хостов после создания кластера можно только с помощью [API](../../glossary/rest-api.md), однако при необходимости вы сможете создать новую группу хостов с другой конфигурацией.

      {% endnote %}

  1. При необходимости задайте конфигурацию [группы хостов](../concepts/host-roles.md#dashboards) `Dashboards` в блоке **{{ ui-key.yacloud.opensearch.cluster.node-groups.title_virtual-node-group }} 2**:

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

      1. При необходимости измените дополнительные настройки кластера:

          {% include [Дополнительные настройки кластера](../../_includes/mdb/mos/extra-settings.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер {{ mos-name }}:

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
         --delete-protection \
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
                                `disk-type-id=<network-hdd|network-ssd|network-ssd-io-m3|network-ssd-nonreplicated|local-ssd>,`
                                `hosts-count=<количество_хостов_в_группе>,`
                                `zone-ids=<зоны_доступности>,`
                                `subnet-names=<имена_подсетей>,`
                                `assign-public-ip=<назначить_публичный_адрес:_true_или_false>,`
                                `roles=<роли_хостов> \
         --dashboards-node-group name=<имя_группы_хостов_Dashboards>,`
                                `resource-preset-id=<класс_хостов>,`
                                `disk-size=<размер_диска_в_байтах>,`
                                `disk-type-id=<network-ssd>,`
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

      * `--delete-protection` — защита кластера от непреднамеренного удаления пользователем. Включенная защита от удаления кластера не помешает подключиться к нему вручную и удалить данные.

      * `--maintenance` — настройки времени технического обслуживания:

          * Чтобы разрешить проведение технического обслуживания в любое время, не указывайте параметр `--maintenance` в команде (конфигурация по умолчанию) либо укажите `--maintenance schedule=anytime`.
          * Чтобы указать предпочтительное время начала обслуживания, укажите в команде параметр `--maintenance schedule=weekly,weekday=<день_недели>,hour=<час_дня_по_UTC>`. Тогда техническое обслуживание будет проходить каждую неделю в обозначенный день и время.

          Операции по обслуживанию проводятся для включенных и выключенных кластеров. Во время обслуживания могут, например, применяться патчи или обновляться СУБД.

      * `--read-admin-password` — пароль пользователя `admin`. Если указать параметр в команде, после ее ввода будет предложено ввести пароль.


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
        maintenance_window {
          type = <тип_технического_обслуживания>
          day  = <день_недели>
          hour = <час_дня>
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
      * `maintenance_window` — время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров):
          * `type` — тип технического обслуживания. Принимает значения:
              * `ANYTIME` — в любое время.
              * `WEEKLY` — по расписанию.
          * `day` — день недели для типа `WEEKLY` в формате `DDD`. Например, `MON`.
          * `hour` — час дня по UTC для типа `WEEKLY` в формате `HH`. Например, `21`.

      {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

      Полный список доступных для изменения полей конфигурации кластера {{ mos-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mos }}).

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте кластер.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mos/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Создайте файл `body.json` и добавьте в него следующее содержимое:


      ```json
      {
          "folderId": "<идентификатор_каталога>",
          "name": "<имя_кластера>",
          "environment": "<окружение>",
          "networkId": "<идентификатор_сети>",
          "securityGroupIds": [
              "<идентификатор_группы_безопасности_1>",
              "<идентификатор_группы_безопасности_2>",
              ...
              "<идентификатор_группы_безопасности_N>"
          ],
          "serviceAccountId": "<идентификатор_сервисного_аккаунта>",
          "deletionProtection": <защита_от_удаления:_true_или_false>,
          "configSpec": {
              "version": "<версия_{{ OS }}>",
              "adminPassword": "<пароль_пользователя-администратора>",
              "opensearchSpec": {
                  "plugins": [
                      "<плагин_{{ OS }}_1>",
                      "<плагин_{{ OS }}_2>",
                      ...
                      "<плагин_{{ OS }}_N>"
                  ],
                  "nodeGroups": [
                      {
                          "name": "<название_группы_хостов>",
                          "resources": {
                              "resourcePresetId": "<класс_хостов>",
                              "diskSize": "<размер_хранилища_в_байтах>",
                              "diskTypeId": "<тип_диска>"
                          },
                          "roles": ["<роль_1>","<роль_2>"],
                          "hostsCount": "<число_хостов>",
                          "zoneIds": [
                              "<зона_доступности_1>",
                              "<зона_доступности_2>",
                              "<зона_доступности_3>"
                          ],
                          "subnetIds": [
                              "<идентификатор_подсети_1>",
                              "<идентификатор_подсети_2>",
                              "<идентификатор_подсети_3>"
                          ],
                          "assignPublicIp": <публичный_адрес_хоста:_true_или_false>,
                          "diskSizeAutoscaling": {
                              "plannedUsageThreshold": "<процент_для_планового_увеличения>",
                              "emergencyUsageThreshold": "<процент_для_незамедлительного_увеличения>",
                              "diskSizeLimit": "<максимальный_размер_хранилища_в_байтах>"
                          }
                      },
                      ...
                  ]
              },
              "dashboardsSpec": {
                  "nodeGroups": [
                      {
                          "name": "<название_группы_хостов>",
                          "resources": {
                              "resourcePresetId": "<класс_хостов>",
                              "diskSize": "<размер_хранилища_в_байтах>",
                              "diskTypeId": "<тип_диска>"
                          },
                          "hostsCount": "<число_хостов>",
                          "zoneIds": ["<зона_доступности>"],
                          "subnetIds": ["<идентификатор_подсети>"],
                          "assignPublicIp": <публичный_адрес_хоста:_true_или_false>,
                          "diskSizeAutoscaling": {
                              "plannedUsageThreshold": "<процент_для_планового_увеличения>",
                              "emergencyUsageThreshold": "<процент_для_незамедлительного_увеличения>",
                              "diskSizeLimit": "<максимальный_размер_хранилища_в_байтах>"
                          }
                      }
                  ]
              },
              "access": {
                  "dataTransfer": <доступ_из_Data_Transfer:_true_или_false>,
                  "serverless": <доступ_из_Serverless_Containers:_true_или_false>
              }
          },
          "maintenanceWindow": {
              "weeklyMaintenanceWindow": {
                  "day": "<день_недели>",
                  "hour": "<час>"
              }
          }
      }
      ```


      Где:

      * `folderId` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
      * `name` — имя кластера.
      * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
      * `networkId` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.


      * `securityGroupIds` — идентификаторы [групп безопасности](../concepts/network.md#security-groups).
      * `serviceAccountId` — идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), используемого для работы с кластером.


      * `deletionProtection` — защита от удаления кластера, его баз данных и пользователей.
      * `configSpec` — настройки кластера:

          * `version` — версия {{ OS }}.
          * `adminPassword` — пароль пользователя `admin`.
          * `opensearchSpec` — настройки групп хостов `{{ OS }}`:

              * `plugins` — список [плагинов {{ OS }}](../concepts/plugins.md), которые надо установить в кластер дополнительно.
              * `nodeGroups` — настройки хостов в виде массива элементов. Каждый элемент соответствует отдельной группе хостов и имеет следующую структуру:

                  * `name` — имя группы хостов.
                  * `resources` — ресурсы кластера:

                      * `resourcePresetId` — [класс хостов](../concepts/instance-types.md);
                      * `diskSize` — размер диска в байтах;
                      * `diskTypeId` — [тип диска](../concepts/storage.md).

                  * `roles` — список [ролей хостов](../concepts/host-roles.md). Кластер должен содержать хотя бы по одной группе хостов `DATA` и `MANAGER`. Это может быть одна группа, на которую назначены две роли, или несколько групп с разными ролями.
                  * `hostsCount` — количество хостов в группе. Миниальное число хостов `DATA` — один, хостов `MANAGER` — три.
                  * `zoneIds` — список зон доступности, где размещаются хосты кластера.
                  * `subnetIds` — список идентификаторов подсетей.


                  * `assignPublicIp` — разрешение на [подключение](connect.md) к хосту из интернета.


                  * `diskSizeAutoscaling` — настройки автоматического увеличения размера хранилища:

                      * `plannedUsageThreshold` — процент заполнения хранилища, при котором хранилище будет увеличено в следующее окно обслуживания.

                          Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено).

                          Если вы задали этот параметр, настройте расписание окна технического обслуживания в параметре `maintenanceWindow`.

                      * `emergencyUsageThreshold` — процент заполнения хранилища, при котором хранилище будет увеличено немедленно.

                          Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено). Должно быть не меньше значения `plannedUsageThreshold`.

                      * `diskSizeLimit` — максимальный размер хранилища (в байтах), который может быть установлен при достижении одного из заданных процентов заполнения.

          * `dashboardsSpec` — настройки групп хостов `Dashboards`. Содержат параметр `nodeGroups`, структура которого совпадает со структурой `opensearchSpec.nodeGroups`. Исключение — параметр `roles`: у хостов `Dashboards` есть только одна роль `DASHBOARDS`, поэтому ее не нужно указывать.


          * `access` — настройки доступа кластера к следующим сервисам {{ yandex-cloud }}:

              * `dataTransfer` — [{{ data-transfer-full-name }}](../../data-transfer/index.yaml);
              * `serverless` — [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml).


      * `maintenance_window.weeklyMaintenanceWindow` — расписание окна технического обслуживания:

          * `day` — день недели в формате `DDD`, когда должно проходить обслуживание.
          * `hour` — час в формате `HH`, когда должно проходить обслуживание. Возможные значения: от `1` до `24`. Задается в часовом поясе UTC.

  1. Воспользуйтесь методом [Cluster.Create](../api-ref/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
          --request POST \
          --header "Authorization: Bearer $IAM_TOKEN" \
          --header "Content-Type: application/json" \
          --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters' \
          --data "@body.json"
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
          "environment": "<окружение>",
          "network_id": "<идентификатор_сети>",
          "security_group_ids": [
              "<идентификатор_группы_безопасности_1>",
              "<идентификатор_группы_безопасности_2>",
              ...
              "<идентификатор_группы_безопасности_N>"
          ],
          "service_account_id": "<идентификатор_сервисного_аккаунта>",
          "deletion_protection": <защита_от_удаления:_true_или_false>,
          "config_spec": {
              "version": "<версия_{{ OS }}>",
              "admin_password": "<пароль_пользователя-администратора>",
              "opensearch_spec": {
                  "plugins": [
                      "<плагин_{{ OS }}_1>",
                      "<плагин_{{ OS }}_2>",
                      ...
                      "<плагин_{{ OS }}_N>"
                  ],
                  "node_groups": [
                      {
                          "name": "<название_группы_хостов>",
                          "resources": {
                              "resource_preset_id": "<класс_хостов>",
                              "disk_size": "<размер_хранилища_в_байтах>",
                              "disk_type_id": "<тип_диска>"
                          },
                          "roles": ["<роль_1>","<роль_2>"],
                          "hosts_count": "<число_хостов>",
                          "zone_ids": [
                              "<зона_доступности_1>",
                              "<зона_доступности_2>",
                              "<зона_доступности_3>"
                          ],
                          "subnet_ids": [
                              "<идентификатор_подсети_1>",
                              "<идентификатор_подсети_2>",
                              "<идентификатор_подсети_3>"
                          ],
                          "assign_public_ip": <публичный_адрес_хоста:_true_или_false>,
                          "disk_size_autoscaling": {
                              "planned_usage_threshold": "<процент_для_планового_увеличения>",
                              "emergency_usage_threshold": "<процент_для_незамедлительного_увеличения>",
                              "disk_size_limit": "<максимальный_размер_хранилища_в_байтах>"
                          }
                      },
                      ...
                  ]
              },
              "dashboards_spec": {
                  "node_groups": [
                      {
                          "name": "<название_группы_хостов>",
                          "resources": {
                              "resource_preset_id": "<класс_хостов>",
                              "disk_size": "<размер_хранилища_в_байтах>",
                              "disk_type_id": "<тип_диска>"
                          },
                          "hosts_count": "<число_хостов>",
                          "zone_ids": ["<зона_доступности>"],
                          "subnet_ids": ["<идентификатор_подсети>"],
                          "assign_public_ip": <публичный_адрес_хоста:_true_или_false>,
                          "disk_size_autoscaling": {
                              "planned_usage_threshold": "<процент_для_планового_увеличения>",
                              "emergency_usage_threshold": "<процент_для_незамедлительного_увеличения>",
                              "disk_size_limit": "<максимальный_размер_хранилища_в_байтах>"
                          }
                      }
                  ]
              },
              "access": {
                  "data_transfer": <доступ_из_Data_Transfer:_true_или_false>,
                  "serverless": <доступ_из_Serverless_Containers:_true_или_false>
              }
          },
          "maintenance_window": {
              "weekly_maintenance_window": {
                  "day": "<день_недели>",
                  "hour": "<час>"
              }
          }
      }
      ```


      Где:

      * `folder_id` — идентификатор каталога. Его можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).
      * `name` — имя кластера.
      * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
      * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network), в которой будет размещен кластер.


      * `security_group_ids` — идентификаторы [групп безопасности](../concepts/network.md#security-groups).
      * `service_account_id` — идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), используемого для работы с кластером.


      * `deletion_protection` — защита от удаления кластера, его баз данных и пользователей.
      * `config_spec` — настройки кластера:

          * `version` — версия {{ OS }}.
          * `admin_password` — пароль пользователя `admin`.
          * `opensearch_spec` — настройки групп хостов `{{ OS }}`:

              * `plugins` — список [плагинов {{ OS }}](../concepts/plugins.md), которые надо установить в кластер дополнительно.
              * `node_groups` — настройки хостов в виде массива элементов. Каждый элемент соответствует отдельной группе хостов и имеет следующую структуру:

                  * `name` — имя группы хостов.
                  * `resources` — ресурсы кластера:

                      * `resource_preset_id` — [класс хостов](../concepts/instance-types.md);
                      * `disk_size` — размер диска в байтах;
                      * `disk_type_id` — [тип диска](../concepts/storage.md).

                  * `roles` — список [ролей хостов](../concepts/host-roles.md). Кластер должен содержать хотя бы по одной группе хостов `DATA` и `MANAGER`. Это может быть одна группа, на которую назначены две роли, или несколько групп с разными ролями.
                  * `hosts_count` — количество хостов в группе. Миниальное число хостов `DATA` — один, хостов `MANAGER` — три.
                  * `zone_ids` — список зон доступности, где размещаются хосты кластера.
                  * `subnet_ids` — список идентификаторов подсетей.


                  * `assign_public_ip` — разрешение на [подключение](connect.md) к хосту из интернета.


                  * `disk_size_autoscaling` — настройки автоматического увеличения размера хранилища:

                      * `planned_usage_threshold` — процент заполнения хранилища, при котором хранилище будет увеличено в следующее окно обслуживания.

                          Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено).

                          Если вы задали этот параметр, настройте расписание окна технического обслуживания в параметре `maintenance_window`.

                      * `emergency_usage_threshold` — процент заполнения хранилища, при котором хранилище будет увеличено немедленно.

                          Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено). Должно быть не меньше значения `planned_usage_threshold`.

                      * `disk_size_limit` — максимальный размер хранилища (в байтах), который может быть установлен при достижении одного из заданных процентов заполнения.

          * `dashboards_spec` — настройки групп хостов `Dashboards`. Содержат параметр `node_groups`, структура которого совпадает со структурой `opensearch_spec.node_groups`. Исключение — параметр `roles`: у хостов `Dashboards` есть только одна роль `DASHBOARDS`, поэтому ее не нужно указывать.


          * `access` — настройки доступа кластера к следующим сервисам {{ yandex-cloud }}:

              * `data_transfer` — [{{ data-transfer-full-name }}](../../data-transfer/index.yaml);
              * `serverless` — [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml).


      * `maintenance_window.weekly_maintenance_window` — расписание окна технического обслуживания:

          * `day` — день недели в формате `DDD`, когда должно проходить обслуживание.
          * `hour` — час в формате `HH`, когда должно проходить обслуживание. Возможные значения: от `1` до `24`. Задается в часовом поясе UTC.

  1. Воспользуйтесь вызовом [ClusterService.Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

      ```bash
      grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d @ \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.opensearch.v1.ClusterService.Create \
          < body.json
      ```

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Создать копию кластера {#duplicate}

Вы можете создать кластер {{ OS }}, который будет обладать настройками созданного ранее кластера. Для этого конфигурация исходного кластера {{ OS }} импортируется в {{ TF }}. В результате вы можете либо создать идентичную копию, либо взять за основу импортированную конфигурацию и внести в нее изменения. Использовать импорт удобно, если исходный кластер {{ OS }} обладает множеством настроек и нужно создать похожий на него кластер.

Чтобы создать копию кластера {{ OS }}:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. В той же рабочей директории разместите файл с расширением `.tf` и содержимым:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "old" { }
        ```

    1. Запишите идентификатор первоначального кластера {{ OS }} в переменную окружения:

        ```bash
        export OPENSEARCH_CLUSTER_ID=<идентификатор_кластера>
        ```

        Идентификатор можно запросить вместе со [списком кластеров в каталоге](../../managed-opensearch/operations/cluster-list.md#list-clusters).

    1. Импортируйте настройки первоначального кластера {{ OS }} в конфигурацию {{ TF }}:

        ```bash
        terraform import yandex_mdb_opensearch_cluster.old ${OPENSEARCH_CLUSTER_ID}
        ```

    1. Получите импортированную конфигурацию:

        ```bash
        terraform show
        ```

    1. Скопируйте ее из терминала и вставьте в файл с расширением `.tf`.
    1. Расположите файл в новой директории `imported-cluster`.
    1. Измените скопированную конфигурацию так, чтобы из нее можно было создать новый кластер:

        * Укажите новое имя кластера в строке `resource` и параметре `name`.
        * Удалите параметры `created_at`, `health`, `id` и `status`.
        * В блок `config` добавьте параметр `admin_password`.
        * Если в блоке `maintenance_window` указано значение параметра `type = "ANYTIME"`, удалите параметр `hour`.
        * (Опционально) Внесите дополнительные изменения, если вам нужна не идентичная, а кастомизированная копия.

    1. В директории `imported-cluster` [получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials).

    1. В этой же директории [настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).

    1. Поместите конфигурационный файл в директорию `imported-cluster` и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Проверьте корректность файлов конфигурации {{ TF }}:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% include [Terraform timeouts](../../_includes/mdb/mos/terraform/timeouts.md) %}

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
        * зона доступности — `{{ region-id }}-a`;
        * подсеть — `{{ network-name }}-{{ region-id }}-a`;
        * публичный адрес — выделен;
        * роли группы хостов — `DATA` и `MANAGER`.

    * Конфигурация группы хостов `Dashboards`:

        * название группы — `dashboard-group`;
        * класс хостов — `{{ host-class }}`;
        * размер диска — `10737418240` (в байтах);
        * тип диска — `network-ssd`;
        * количество хостов — один;
        * зона доступности — `{{ region-id }}-a`;
        * подсеть — `{{ network-name }}-{{ region-id }}-a`;
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
       --delete-protection \
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
                              `zone-ids={{ region-id }}-a,`
                              `subnet-names={{ network-name }}-{{ region-id }}-a,`
                              `assign-public-ip=true,`
                              `roles=data+manager \
       --dashboards-node-group name=dashboard-group,`
                              `resource-preset-id={{ host-class }},`
                              `disk-size=10737418240,`
                              `disk-type-id=network-ssd,`
                              `hosts-count=1,`
                              `zone-ids={{ region-id }}-a,`
                              `subnet-names={{ network-name }}-{{ region-id }}-a,`
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
    * Время технического обслуживания — каждый понедельник с 13:00 до 14:00.
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
      maintenance_window {
        type = "WEEKLY"
        day  = "MON"
        hour = 14
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


{% include [connection-manager](../../_includes/mdb/connection-manager.md) %}
