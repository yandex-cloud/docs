# Создание кластера {{ KF }}


[Кластер {{ mkf-name }}](../concepts/index.md) — один или несколько [хостов-брокеров](../concepts/brokers.md), на которых размещены [топики и соответствующие топикам разделы](../concepts/topics.md). [Производители и потребители](../concepts/producers-consumers.md) могут работать с этими топиками, подключившись к хостам [кластера](../../glossary/cluster.md) {{ mkf-name }}.

{% note info %}

Доступные типы диска [зависят](../concepts/storage.md) от выбранного [класса хостов](../concepts/instance-types.md).

{% endnote %}

## Различия в конфигурации кластеров с {{ ZK }} и протоколом {{ kraft-name }} {#zk-vs-kraft}

{% include [zk-vs-kraft](../../_includes/mdb/mkf/zk-vs-kraft.md) %}


## Перед началом работы {#before-you-begin}

1. Рассчитайте [минимальный размер хранилища](../concepts/storage.md#minimal-storage-size) для топиков.
1. [Назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роли:
   * [{{ roles.mkf.editor }} или выше](../security/index.md#roles-list) — чтобы создать кластер;
   * [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../../vpc/concepts/network.md#network) кластера;
   * [kms.keys.user](../../kms/security/index.md#kms-keys-user) — чтобы управлять [шифрованием диска](../concepts/storage.md#disk-encryption).

Если вы указываете идентификаторы групп безопасности при создании кластера {{ mkf-name }}, для подключения к нему может понадобиться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups).


## Создать кластер с {{ ZK }} {#create-cluster}

{% note warning %}

При создании кластера с {{ ZK }} не указывайте настройки {{ kraft-short-name }}.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать кластер {{ mkf-name }}:

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:
     1. Введите имя кластера {{ mkf-name }} и его описание. Имя кластера {{ mkf-name }} должно быть уникальным в рамках каталога.
     1. {% include notitle [env](../../_includes/mdb/mkf/create-cluster.md#environment) %}
     1. Выберите версию {{ KF }}.
  1. {% include notitle [broker-class](../../_includes/mdb/mkf/create-cluster.md#broker-class) %}
     
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**:
     * Выберите тип диска.

       {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

       {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

       Тип диска для кластера {{ mkf-name }} нельзя изменить после создания.
     * Выберите объем хранилища, который будет использоваться для данных.

  
  1. В блоке **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}** задайте [пороги заполненности](../concepts/storage.md#auto-rescale) хранилища, при достижении которых его размер будет увеличиваться:

     {% include [autoscale-settings](../../_includes/mdb/mkf/autoscale-settings.md) %}

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**:
     1. Выберите одну или несколько зон доступности, в которых нужно разместить хосты-брокеры {{ KF }}.

        {% include notitle [note-warning](../../_includes/mdb/mkf/create-cluster.md#note-warning) %}

     1. Выберите [сеть](../../vpc/concepts/network.md#network).
     1. Выберите [подсети](../../vpc/concepts/network.md#subnet) в каждой зоне доступности для этой сети. Чтобы [создать новую подсеть](../../vpc/operations/subnet-create.md), нажмите на кнопку **{{ ui-key.yacloud.common.create }}** рядом с нужной зоной доступности.

        {% note info %}

        Для кластера {{ KF }}, в котором несколько хостов-брокеров, укажите подсети в каждой зоне доступности, даже если вы планируете разместить хосты-брокеры только в некоторых из них. Эти подсети понадобятся для размещения трех [хостов {{ ZK }}](../concepts/index.md) — по одному в каждой зоне доступности. Подробнее см. в разделе [Взаимосвязь ресурсов сервиса](../concepts/index.md).

        {% endnote %}

     1. Выберите [группы безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера {{ mkf-name }}.
     1. Для доступа к хостам-брокерам из интернета выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**. В этом случае подключаться к ним можно только с использованием SSL-соединения. Подробнее см. в разделе [Подключение к топикам в кластере](connect/clients.md).


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}**:
     1. Укажите количество хостов-брокеров {{ KF }} для размещения в каждой выбранной зоне доступности.

        При выборе количества хостов учтите следующие особенности:
        * Добавление в кластер более одного хоста приведет к автоматическому добавлению трех хостов {{ ZK }}.
        * Репликация возможна при наличии как минимум двух хостов в кластере {{ mkf-name }}.
        * Для высокой доступности кластера {{ mkf-name }} должны выполняться [определенные условия](../concepts/ha-cluster.md).
    
     1. В качестве сервиса координации выберите **{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-zookeeper_pN7ub }}**.

  1. Если вы указали более одного хоста-брокера, то в блоке **{{ ui-key.yacloud.kafka.section_zookeeper-resources }}** укажите характеристики [хостов {{ ZK }}](../concepts/index.md) для размещения в каждой выбранной зоне доступности.
  1. При необходимости задайте дополнительные настройки кластера {{ mkf-name }}:

     {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

  1. При необходимости задайте [настройки {{ KF }}](../concepts/settings-list.md#cluster-settings).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. {% include notitle [env](../../_includes/mdb/mkf/create-cluster.md#status) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер {{ mkf-name }}:

  1. Посмотрите описание команды CLI для создания кластера {{ mkf-name }}:

     ```bash
     {{ yc-mdb-kf }} cluster create --help
     ```

  1. Укажите параметры кластера {{ mkf-name }} в команде создания (в примере приведены не все параметры):

     
     ```bash
     {{ yc-mdb-kf }} cluster create \
        --name <имя_кластера> \
        --environment <окружение> \
        --version <версия> \
        --schema-registry \
        --network-name <имя_сети> \
        --subnet-ids <идентификаторы_подсетей> \
        --zone-ids <зоны_доступности> \
        --brokers-count <количество_хостов-брокеров_в_зоне> \
        --resource-preset <класс_хоста> \
        --disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
        --disk-size <размер_хранилища_ГБ> \
        --assign-public-ip <разрешить_публичный_доступ_к_кластеру> \
        --security-group-ids <список_идентификаторов_групп_безопасности> \
        --deletion-protection \
        --kafka-ui-enabled <true_или_false> \
        --disk-encryption-key-id <идентификатор_ключа_KMS>
     ```


     Где:

     * `--environment` — окружение кластера: `prestable` или `production`.
     * `--version` — версия {{ KF }}: {{ versions.cli.str }}. Дополнительно передайте [конфигурацию хостов {{ ZK }}](../concepts/index.md#zookeeper).
     * `--schema-registry` — управление схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md).

         {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

     * `--zone-ids` и `--brokers-count` — зоны доступности и число хостов-брокеров в каждой зоне.
     * `--resource-preset` — [класс хостов](../concepts/instance-types.md).
     * `--disk-type` — [тип диска](../concepts/storage.md).

        {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

     * {% include [deletion-protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}

     
     * {% include [kafka-ui-enabled](../../_includes/mdb/cli/kafka-ui-enabled.md) %}
     * {% include [disk-encryption-key-id-kafka](../../_includes/mdb/cli/disk-encryption-key-id-kafka.md) %}


     {% note tip %}

     При необходимости здесь же можно задать [настройки {{ KF }}](../concepts/settings-list.md#cluster-settings).

     {% endnote %}

  1. Чтобы использовать {{ ZK }} в кластере, передайте [конфигурацию хостов {{ ZK }}](../concepts/index.md#zookeeper):
       
     ```bash
     {{ yc-mdb-kf }} cluster create \
         ...
         --zookeeper-resource-preset <класс_хоста> \
         --zookeeper-disk-size <размер_хранилища_ГБ> \
         --zookeeper-disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
         ...

     ```

     Где:
     * `--zookeeper-resource-preset` — [класс хостов](../concepts/instance-types.md) {{ ZK }}.
     * `--zookeeper-disk-size` — размер хранилища.
     * `--zookeeper-disk-type` — [тип диска](../concepts/storage.md) {{ ZK }}.
  
  1. {% include notitle [maintenance](../../_includes/mdb/mkf/create-cluster.md#maintenance) %}

  1. {% include notitle [auto-rescale](../../_includes/mdb/mkf/create-cluster.md#auto-rescale) %}


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать кластер {{ mkf-name }}:
  1. Опишите в конфигурационном файле создаваемые ресурсы:
     * Кластер {{ mkf-name }} — описание кластера и его хостов. При необходимости здесь же можно задать [настройки {{ KF }}](../concepts/settings-list.md#cluster-settings).

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Пример структуры конфигурационного файла:

     
     ```hcl
     resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
       environment            = "<окружение>"
       name                   = "<имя_кластера>"
       network_id             = "<идентификатор_сети>"
       subnet_ids             = ["<список_идентификаторов_подсетей>"]
       security_group_ids     = ["<список_идентификаторов_групп_безопасности_кластера>"]
       deletion_protection    = <защитить_кластер_от_удаления>

       config {
         version          = "<версия>"
         zones            = ["<зоны_доступности>"]
         brokers_count    = <количество_хостов-брокеров>
         assign_public_ip = "<разрешить_публичный_доступ_к_кластеру>"
         schema_registry  = "<включить_управление_схемами_данных>"
         kafka_ui {
           enabled = <использовать_веб-интерфейс_Kafka_UI>
         }
         kafka {
           resources {
             disk_size          = <размер_хранилища_ГБ>
             disk_type_id       = "<тип_диска>"
             resource_preset_id = "<класс_хоста>"
           }
           kafka_config {}
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

     * `environment` — окружение кластера: `PRESTABLE` или `PRODUCTION`.
     * `version` — версия {{ KF }}: {{ versions.tf.str }}. Дополнительно передайте [конфигурацию хостов {{ ZK }}](../concepts/index.md#zookeeper).
     * `zones` и `brokers_count` — зоны доступности и число хостов-брокеров в каждой зоне.
     * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

       {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}

     
     * `disk_encryption_key_id` — шифрование диска [пользовательским ключом KMS](../../kms/concepts/key.md). Чтобы зашифровать диск, передайте идентификатор ключа KMS. Подробнее о шифровании дисков см. в разделе [Хранилище](../concepts/storage.md#disk-encryption).
     * `assign_public_ip` — публичный доступ к кластеру: `true` или `false`.


     * `schema_registry` — управление схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md): `true` или `false`. Значение по умолчанию — `false`.

       {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

       

     * `kafka_ui` — использование [веб-интерфейса {{ kafka-ui }} для {{ KF }}](../concepts/kafka-ui.md): `true` или `false`. Значение по умолчанию — `false`.


     Чтобы использовать {{ ZK }} в кластере, добавьте к описанию кластера блок `zookeeper`:

     ```hcl
     resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
       ...
       zookeeper {
         resources {
           resource_preset_id = "<класс_хоста>"
           disk_type_id       = "<тип_диска>"
           disk_size          = <размер_хранилища_ГБ>
         }
       }
     }
     ```

     {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

     
     {% include [disk-encryption-key](../../_includes/mdb/mkf/terraform/disk-encryption-key.md) %}


  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте кластер {{ mkf-name }}.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся [FQDN хостов кластера {{ mkf-name }}](../concepts/network.md#hostname). Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.create](../api-ref/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            {% note info %}

            В примере приведены не все доступные параметры.

            {% endnote %}

            
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
              "configSpec": {
                "version": "<версия_{{ KF }}>",
                "kafka": {
                  "resources": {
                    "resourcePresetId": "<класс_хостов {{ KF }}>",
                    "diskSize": "<размер_хранилища_в_байтах>",
                    "diskTypeId": "<тип_диска>"
                  }
                },
                "zookeeper": {
                  "resources": {
                    "resourcePresetId": "<класс_хостов {{ ZK }}>",
                    "diskSize": "<размер_хранилища_в_байтах>",
                    "diskTypeId": "<тип_диска>"                   
                  }
                },
                "zoneId": [
                  <список_зон_доступности>
                ],
                "brokersCount": "<количество_брокеров_в_зоне>",
                "assignPublicIp": <разрешить_публичный_доступ_к_кластеру>,
                "schemaRegistry": <включить_управление_схемами_данных>,
                "restApiConfig": {
                  "enabled": <включить_отправку_запросов_к_API_{{ KF }}>
                },
                "diskSizeAutoscaling": {
                  <параметры_автоматического_увеличения_размера_хранилища>
                },
                "kafkaUiConfig": {
                  "enabled": <использовать_веб-интерфейс_Kafka_UI>
                }
              },
              "topicSpecs": [
                {
                  "name": "<имя_топика>",
                  "partitions": "<количество_партиций>",
                  "replicationFactor": "<фактор_репликации>"
                },
                { <аналогичный_набор_настроек_для_топика_2> },
                { ... },
                { <аналогичный_набор_настроек_для_топика_N> }
              ],
              "userSpecs": [
                {
                  "name": "<имя_пользователя>",
                  "password": "<пароль_пользователя>",
                  "permissions": [
                    {
                      "topicName": "<имя_топика>",
                      "role": "<роль_пользователя>"
                    }
                  ]
                },
                { <аналогичный_набор_настроек_для_пользователя_2> },
                { ... },
                { <аналогичный_набор_настроек_для_пользователя_N> }
              ],
              "maintenanceWindow": {
                "anytime": {},
                "weeklyMaintenanceWindow": {
                  "day": "<день_недели>",
                  "hour": "<час_дня_по_UTC>"
                }
              },
              "deletionProtection": <защитить_кластер_от_удаления>,
              "diskEncryptionKeyId": "<идентификатор_ключа_KMS>"
            }
            ```


            Где:

            * `name` — имя кластера.
            * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
            * `networkId` — идентификатор [сети](../../vpc/concepts/network.md), в которой будет размещен кластер.

            
            * `securityGroupIds` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md) в виде массива строк. Каждая строка — идентификатор группы безопасности.


            * `configSpec` — конфигурация кластера:

                * `version` — версия {{ KF }}: {{ versions.cli.str }}. Дополнительно передайте [конфигурацию хостов {{ ZK }}](../concepts/index.md#zookeeper).
                * `kafka` — конфигурация {{ KF }}:

                    * `resources.resourcePresetId` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../api-ref/ResourcePreset/list.md).
                    * `resources.diskSize` — размер диска в байтах.
                    * `resources.diskTypeId` — [тип диска](../concepts/storage.md).

                * `zookeeper` — конфигурация {{ ZK }}:

                    * `resources.resourcePresetId` — идентификатор класса хостов. Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../api-ref/ResourcePreset/list.md).
                    * `resources.diskSize` — размер диска в байтах.
                    * `resources.diskTypeId` — тип диска.


                * `zoneId` и `brokersCount` – зоны доступности и число хостов-брокеров в каждой зоне.

                
                * `assignPublicIp` — доступность хостов-брокеров из интернета: `true` или `false`.


                * `schemaRegistry` – управлять схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md): `true` или `false`. Значение по умолчанию — `false`. Эту настройку невозможно изменить после создания кластера {{ mkf-name }}.
                * `restApiConfig` — конфигурация {{ KF }} REST API. Для доступа к отправке запросов к REST API {{ KF }} укажите `enabled: true`.
                * `diskSizeAutoscaling` – [пороги заполненности](../concepts/storage.md#auto-rescale) хранилища (в процентах от общего объема хранилища), при достижении которых его размер будет увеличиваться:

                  {% include [autoscale-settings](../../_includes/mdb/mkf/api/rest-autoscale-settings.md) %}

                
                * `kafkaUiConfig` — использование [веб-интерфейса {{ kafka-ui }}](../concepts/kafka-ui.md). Для доступа к веб-интерфейсу {{ kafka-ui }} укажите `enabled: true`.


            * `topicSpecs` — настройки топиков в виде массива элементов. Каждый элемент соответствует отдельному топику и имеет следующую структуру:

                {% include [rest-topic-specs](../../_includes/mdb/mkf/api/rest-topic-specs.md) %}

            * `userSpecs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

                {% include [rest-user-specs](../../_includes/mdb/mkf/api/rest-user-specs.md) %}

            * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в том числе для выключенных кластеров). Выберите один из вариантов:

                * `anytime` (по умолчанию) — в любое время.
                * `weeklyMaintenanceWindow` — по расписанию:
                    * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                    * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

            * `deletionProtection` — защита кластера от непреднамеренного удаления: `true` или `false`. Значение по умолчанию — `false`.

                {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}
            
            
            * `diskEncryptionKeyId` — идентификатор [пользовательского ключа KMS](../../kms/concepts/key.md). Чтобы зашифровать диски, передайте идентификатор ключа KMS. Подробнее о шифровании дисков см. в разделе [Хранилище](../concepts/storage.md#disk-encryption).

              {% note warning %}
                  
              Включить шифрование дисков можно только при создании кластера.
                  
              {% endnote %}


            
            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Выполните запрос:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters' \
              --data '@body.json'
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/Create](../api-ref/grpc/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            {% note info %}

            В примере приведены не все доступные параметры.

            {% endnote %}

            
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
              "config_spec": {
                "version": "<версия_{{ KF }}>",
                "kafka": {
                  "resources": {
                    "resource_preset_id": "<класс_хостов {{ KF }}>",
                    "disk_size": "<размер_хранилища_в_байтах>",
                    "disk_type_id": "<тип_диска>"
                  }
                },
                "zookeeper": {
                  "resources": {
                    "resource_preset_id": "<класс_хостов {{ ZK }}>",
                    "disk_size": "<размер_хранилища_в_байтах>",
                    "disk_type_id": "<тип_диска>"                   
                  }
                },
                "zone_id": [
                  <список_зон_доступности>
                ],
                "brokers_count": {
                  "value": "<количество_брокеров_в_зоне>"
                },
                "assign_public_ip": <разрешить_публичный_доступ_к_кластеру>,
                "schema_registry": <включить_управление_схемами_данных>,
                "rest_api_config": {
                  "enabled": <включить_отправку_запросов_к_API_{{ KF }}>
                },
                "disk_size_autoscaling": {
                  <параметры_автоматического_увеличения_размера_хранилища>
                },
                "kafka_ui_config": {
                  "enabled": <использовать_веб-интерфейс_Kafka_UI>
                }
              },
              "topic_specs": [
                {
                  "name": "<имя_топика>",
                  "partitions": {
                    "value": "<количество_партиций>"
                  },
                  "replication_factor": {
                    "value": "<фактор_репликации>"
                  }
                },
                { <аналогичный_набор_настроек_для_топика_2> },
                { ... },
                { <аналогичный_набор_настроек_для_топика_N> }
              ],
              "user_specs": [
                {
                  "name": "<имя_пользователя>",
                  "password": "<пароль_пользователя>",
                  "permissions": [
                    {
                      "topic_name": "<имя_топика>",
                      "role": "<роль_пользователя>"
                    }
                  ]
                },
                { <аналогичный_набор_настроек_для_пользователя_2> },
                { ... },
                { <аналогичный_набор_настроек_для_пользователя_N> }
              ],
              "maintenance_window": {
                "anytime": {},
                "weekly_maintenance_window": {
                  "day": "<день_недели>",
                  "hour": "<час_дня_по_UTC>"
                }
              },
              "deletion_protection": <защитить_кластер_от_удаления>,
              "disk_encryption_key_id": "<идентификатор_ключа_KMS>"
            }
            ```


            Где:

            * `name` — имя кластера.
            * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
            * `network_id` — идентификатор [сети](../../vpc/concepts/network.md), в которой будет размещен кластер.

            
            * `security_group_ids` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md) в виде массива строк. Каждая строка — идентификатор группы безопасности.


            * `config_spec` — конфигурация кластера:

                * `version` — версия {{ KF }}: {{ versions.cli.str }}. Дополнительно передайте [конфигурацию хостов {{ ZK }}](../concepts/index.md#zookeeper).
                * `kafka` — конфигурация {{ KF }}:

                    * `resources.resource_preset_id` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью вызова [ResourcePreset.list](../api-ref/grpc/ResourcePreset/list.md).
                    * `resources.disk_size` — размер диска в байтах.
                    * `resources.disk_type_id` — [тип диска](../concepts/storage.md).

                * `zookeeper` — конфигурация {{ ZK }}:

                    * `resources.resource_preset_id` — идентификатор класса хостов. Список доступных классов хостов с их идентификаторами можно запросить с помощью вызова [ResourcePreset.list](../api-ref/grpc/ResourcePreset/list.md).
                    * `resources.disk_size` — размер диска в байтах.
                    * `resources.disk_type_id` — тип диска.


                * `zone_id` и `brokers_count` – зоны доступности и число хостов-брокеров в каждой зоне (число передается в виде объекта с полем `value`).

                
                * `assign_public_ip` — доступность хостов-брокеров из интернета: `true` или `false`.


                * `schema_registry` – управлять схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md): `true` или `false`. Значение по умолчанию — `false`. Эту настройку невозможно изменить после создания кластера {{ mkf-name }}.
                * `rest_api_config` — конфигурация {{ KF }} REST API. Для доступа к отправке запросов к REST API {{ KF }} укажите `enabled: true`.
                * `disk_size_autoscaling` – чтобы в кластере не заканчивалось место на диске, укажите [пороги заполненности](../concepts/storage.md#auto-rescale) хранилища (в процентах от общего объема хранилища), при достижении которых его размер будет увеличиваться:

                  {% include [autoscale-settings](../../_includes/mdb/mkf/api/grpc-autoscale-settings.md) %}

                  

                * `kafka_ui_config` — использование [веб-интерфейса {{ kafka-ui }}](../concepts/kafka-ui.md). Для доступа к веб-интерфейсу {{ kafka-ui }} укажите `enabled: true`.


            * `topic_specs` — настройки топиков в виде массива элементов. Каждый элемент соответствует отдельному топику и имеет следующую структуру:

                {% include [grpc-topic-specs](../../_includes/mdb/mkf/api/grpc-topic-specs.md) %}

            * `user_specs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

                {% include [rest-user-specs](../../_includes/mdb/mkf/api/grpc-user-specs.md) %}

            * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в том числе для выключенных кластеров). Выберите один из вариантов:

                * `anytime` (по умолчанию) — в любое время.
                * `weekly_maintenance_window` — по расписанию:
                    * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                    * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

            * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`. Значение по умолчанию — `false`.

                {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}
            
            
            * `disk_encryption_key_id` — идентификатор [пользовательского ключа KMS](../../kms/concepts/key.md). Чтобы зашифровать диски, передайте идентификатор ключа KMS. Подробнее о шифровании дисков см. в разделе [Хранилище](../concepts/storage.md#disk-encryption).

              {% note warning %}
                  
              Включить шифрование дисков можно только при создании кластера.
                  
              {% endnote %}


            
            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Выполните запрос:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters' \
              --data '@body.json'
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Создать кластер с {{ kraft-short-name }} {#create-cluster-kraft}

{% note warning %}

При создании кластера с {{ kraft-short-name }} не указывайте настройки {{ ZK }}.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы создать кластер {{ mkf-name }}:

  1. В [консоли управления]({{ link-console-main }}) перейдите в нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:
     1. Введите имя кластера {{ mkf-name }} и его описание. Имя кластера {{ mkf-name }} должно быть уникальным в рамках каталога.
     1. {% include notitle [env](../../_includes/mdb/mkf/create-cluster.md#environment) %}

     1. Выберите версию {{ KF }} 3.6 и выше.
  1. {% include notitle [broker-class](../../_includes/mdb/mkf/create-cluster.md#broker-class) %}

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**:
     * Выберите тип диска.

       {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

       {% include [storages-step-settings](../../_includes/mdb/settings-storages-no-broadwell.md) %}

       Тип диска для кластера {{ mkf-name }} нельзя изменить после создания.
     * Выберите объем хранилища, который будет использоваться для данных.

  
  1. В блоке **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}** задайте [пороги заполненности](../concepts/storage.md#auto-rescale) хранилища, при достижении которых его размер будет увеличиваться:

     {% include [autoscale-settings](../../_includes/mdb/mkf/autoscale-settings.md) %}

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**:
     1. Выберите одну или несколько зон доступности, в которых нужно разместить хосты-брокеры {{ KF }}.
        
        {% include notitle [note-warning](../../_includes/mdb/mkf/create-cluster.md#note-warning) %}

     1. Выберите [сеть](../../vpc/concepts/network.md#network).
     1. Выберите [подсети](../../vpc/concepts/network.md#subnet) в каждой зоне доступности для этой сети. Чтобы [создать новую подсеть](../../vpc/operations/subnet-create.md), нажмите на кнопку **{{ ui-key.yacloud.common.create }}** рядом с нужной зоной доступности.

        {% note info %}

        Для кластера {{ KF }}, в котором несколько хостов-брокеров, укажите подсети в каждой зоне доступности, даже если вы планируете разместить хосты-брокеры только в некоторых из них. Эти подсети понадобятся для размещения трех [хостов {{ kraft-short-name }}](../concepts/index.md) — по одному в каждой зоне доступности. Подробнее см. в разделе [Взаимосвязь ресурсов сервиса](../concepts/index.md).

        {% endnote %}

     1. Выберите [группы безопасности](../../vpc/concepts/security-groups.md) для сетевого трафика кластера {{ mkf-name }}.
     1. Для доступа к хостам-брокерам из интернета выберите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**. В этом случае подключаться к ним можно только с использованием SSL-соединения. Подробнее см. в разделе [Подключение к топикам в кластере](connect/clients.md).


  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}**:

     1. Укажите количество хостов-брокеров {{ KF }} для размещения в каждой выбранной зоне доступности.

        При выборе количества хостов учтите следующие особенности:
        * Если в качестве сервиса координации выбран [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}](../concepts/kraft.md#cluster-topology) — задать количество хостов-брокеров вручную нельзя.
        * Если в качестве сервиса координации выбран [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-split-mode_sbrDd }}](../concepts/kraft.md#cluster-topology) — количество брокеров задается вручную. При создании кластера с несколькими хостами в него будут добавлены три выделенных хоста {{ kraft-short-name }}.
        * Репликация возможна при наличии как минимум двух хостов в кластере {{ mkf-name }}.
        * Для высокой доступности кластера {{ mkf-name }} должны выполняться [определенные условия](../concepts/ha-cluster.md).
      
     1. В поле **{{ ui-key.yacloud.kafka.FormSections.field_coordination-service-type_sdoRj }}** выберите один из вариантов:
        * **{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-split-mode_sbrDd }}** — брокер и контроллер метаданных {{ kraft-short-name }} размещаются на отдельных хостах.
        
        * **{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}** — на одном хосте {{ KF }} одновременно размещаются брокер и контроллер метаданных {{ kraft-short-name }}.

          Можно создать кластер только в одной или в трех [зонах доступности](../../overview/concepts/geo-scope.md):
            * Одна зона доступности — три хоста-брокера.
            * Три зоны доступности — один хост-брокер в каждой зоне доступности.

          Задать количество хостов-брокеров вручную нельзя.

  1. Если вы указали более одного хоста-брокера, то в блоке **{{ ui-key.yacloud.kafka.section_kraft-resources }}** укажите характеристики [хостов {{ kraft-short-name }}](../concepts/index.md) для размещения в каждой выбранной зоне доступности.
  1. При необходимости задайте дополнительные настройки кластера {{ mkf-name }}:

     {% include [extra-settings](../../_includes/mdb/mkf/extra-settings.md) %}

  1. При необходимости задайте [настройки {{ KF }}](../concepts/settings-list.md#cluster-settings).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. {% include notitle [env](../../_includes/mdb/mkf/create-cluster.md#status) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать кластер {{ mkf-name }}:

  1. Посмотрите описание команды CLI для создания кластера {{ mkf-name }}:

     ```bash
     {{ yc-mdb-kf }} cluster create --help
     ```

  1. Укажите параметры кластера {{ mkf-name }} в команде создания (в примере приведены не все параметры):

     
     ```bash
     {{ yc-mdb-kf }} cluster create \
        --name <имя_кластера> \
        --environment <окружение> \
        --version <версия> \
        --schema-registry \
        --network-name <имя_сети> \
        --subnet-ids <идентификаторы_подсетей> \
        --resource-preset <класс_хоста> \
        --disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
        --disk-size <размер_хранилища_ГБ> \
        --assign-public-ip <разрешить_публичный_доступ_к_кластеру> \
        --security-group-ids <список_идентификаторов_групп_безопасности> \
        --deletion-protection \
        --kafka-ui-enabled <true_или_false> \
        --disk-encryption-key-id <идентификатор_ключа_KMS>
     ```


     Где:

     * `--environment` — окружение кластера: `prestable` или `production`.
     * `--version` — версия {{ KF }}. Указывайте версию 3.6 и выше.
     * `--schema-registry` — управление схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md).

         {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}
    
     * `--zone-ids` и `--brokers-count` — зоны доступности и число хостов-брокеров в каждой зоне. 
     
       Если вы создаете кластер с [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}](../concepts/kraft.md#cluster-topology), укажите одну из доступных конфигураций:

       * `--zone-ids={{ region-id }}-a,{{ region-id }}-b,{{ region-id }}-d --brokers-count=1` — три зоны доступности, один хост-брокер в каждой зоне;
       * `--zone-ids=<одна_зона_доступности> --brokers-count=3` — одна зона доступности, три хоста-брокера.

     * `--resource-preset` — [класс хостов](../concepts/instance-types.md).
     * `--disk-type` — [тип диска](../concepts/storage.md).

        {% include [storages-type-no-change](../../_includes/mdb/storages-type-no-change.md) %}

     * {% include [deletion-protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}

     
     * {% include [kafka-ui-enabled](../../_includes/mdb/cli/kafka-ui-enabled.md) %}
     * {% include [disk-encryption-key-id-kafka](../../_includes/mdb/cli/disk-encryption-key-id-kafka.md) %}


     {% note tip %}

     При необходимости здесь же можно задать [настройки {{ KF }}](../concepts/settings-list.md#cluster-settings).

     {% endnote %}
  
  1. Чтобы использовать [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-split-mode_sbrDd }}](../concepts/kraft.md#cluster-topology) передайте конфигурацию хостов {{ kraft-short-name }}.
       
     ```bash
     {{ yc-mdb-kf }} cluster create \
         ...
         --controller-resource-preset <класс_хоста> \
         --controller-disk-size <размер_хранилища_ГБ> \
         --controller-disk-type <network-hdd|network-ssd|network-ssd-nonreplicated|local-ssd> \
         ...

     ```

     Где:
     * `--controller-resource-preset` — [класс хостов](../concepts/instance-types.md) {{ kraft-short-name }}.
     * `--controller-disk-size` — размер хранилища.
     * `--controller-disk-type` — [тип диска](../concepts/storage.md) {{ kraft-short-name }}.

  1. {% include notitle [maintenance](../../_includes/mdb/mkf/create-cluster.md#maintenance) %}

  1. {% include notitle [auto-rescale](../../_includes/mdb/mkf/create-cluster.md#auto-rescale) %}


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать кластер {{ mkf-name }}:
  1. Опишите в конфигурационном файле создаваемые ресурсы:
     * Кластер {{ mkf-name }} — описание кластера и его хостов. При необходимости здесь же можно задать [настройки {{ KF }}](../concepts/settings-list.md#cluster-settings).

     * {% include [Terraform network description](../../_includes/mdb/terraform/network.md) %}

     * {% include [Terraform subnet description](../../_includes/mdb/terraform/subnet.md) %}

     Пример структуры конфигурационного файла:

     
     ```hcl
     resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
       environment         = "<окружение>"
       name                = "<имя_кластера>"
       network_id          = "<идентификатор_сети>"
       subnet_ids          = ["<список_идентификаторов_подсетей>"]
       security_group_ids  = ["<список_идентификаторов_групп_безопасности_кластера>"]
       deletion_protection = <защитить_кластер_от_удаления>

       config {
         version          = "<версия>"
         zones            = ["<зоны_доступности>"]
         brokers_count    = <количество_хостов-брокеров>
         assign_public_ip = "<разрешить_публичный_доступ_к_кластеру>"
         schema_registry  = "<включить_управление_схемами_данных>"
         kafka_ui {
           enabled = <использовать_веб-интерфейс_Kafka_UI>
         }
         kafka {
           resources {
             disk_size          = <размер_хранилища_ГБ>
             disk_type_id       = "<тип_диска>"
             resource_preset_id = "<класс_хоста>"
           }
           kafka_config {}
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

     * `environment` — окружение кластера: `PRESTABLE` или `PRODUCTION`.
     * `version` — версия {{ KF }}. Указывайте версию 3.6 и выше.
     * `zones` и `brokers_count` — зоны доступности и число хостов-брокеров в каждой зоне.

       Если вы создаете кластер с [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}](../concepts/kraft.md#cluster-topology), укажите одну из доступных конфигураций:

       * `zones = ["{{ region-id }}-a","{{ region-id }}-b","{{ region-id }}-d"] brokers_count = 1` — три зоны доступности, один хост-брокер в каждой зоне;
       * `zones = ["<одна_зона_доступности>"] brokers_count = 3` — одна зона доступности, три хоста-брокера.

     * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

       {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}

     
     * `assign_public_ip` — публичный доступ к кластеру: `true` или `false`.


     * `schema_registry` — управление схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md): `true` или `false`. Значение по умолчанию — `false`.

       {% include [mkf-schema-registry-alert](../../_includes/mdb/mkf/schema-registry-alert.md) %}

       

     * `kafka_ui` — использование [веб-интерфейса {{ kafka-ui }} для {{ KF }}](../concepts/kafka-ui.md): `true` или `false`. Значение по умолчанию — `false`.


     Чтобы использовать [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-split-mode_sbrDd }}](../concepts/kraft.md#cluster-topology), добавьте к описанию кластера блок `kraft`:

     ```hcl
     resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
       ...
       kraft {
         resources {
           resource_preset_id = "<класс_хоста>"
           disk_type_id       = "<тип_диска>"
           disk_size          = <размер_хранилища_ГБ>
         }
       }
     }
     ```

     {% include [Maintenance window](../../_includes/mdb/mkf/terraform/maintenance-window.md) %}

     
     {% include [disk-encryption-key](../../_includes/mdb/mkf/terraform/disk-encryption-key.md) %}


  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Создайте кластер {{ mkf-name }}.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся [FQDN хостов кластера {{ mkf-name }}](../concepts/network.md#hostname). Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.create](../api-ref/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            {% note info %}

            В примере приведены не все доступные параметры.

            {% endnote %}

            
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
              "configSpec": {
                "version": "<версия_{{ KF }}>",
                "kafka": {
                  "resources": {
                    "resourcePresetId": "<класс_хостов {{ KF }}>",
                    "diskSize": "<размер_хранилища_в_байтах>",
                    "diskTypeId": "<тип_диска>"
                  }
                },
                "kraft": {
                  "resources": {
                    "resourcePresetId": "<класс_хостов {{ kraft-short-name }}>",
                    "diskSize": "<размер_хранилища_в_байтах>",
                    "diskTypeId": "<тип_диска>"                   
                  }
                },
                "zoneId": [
                  <список_зон_доступности>
                ],
                "brokersCount": "<количество_брокеров_в_зоне>",
                "assignPublicIp": <разрешить_публичный_доступ_к_кластеру>,
                "schemaRegistry": <включить_управление_схемами_данных>,
                "restApiConfig": {
                  "enabled": <включить_отправку_запросов_к_API_{{ KF }}>
                },
                "diskSizeAutoscaling": {
                  <параметры_автоматического_увеличения_размера_хранилища>
                },
                "kafkaUiConfig": {
                  "enabled": <использовать_веб-интерфейс_Kafka_UI>
                }
              },
              "topicSpecs": [
                {
                  "name": "<имя_топика>",
                  "partitions": "<количество_партиций>",
                  "replicationFactor": "<фактор_репликации>"
                },
                { <аналогичный_набор_настроек_для_топика_2> },
                { ... },
                { <аналогичный_набор_настроек_для_топика_N> }
              ],
              "userSpecs": [
                {
                  "name": "<имя_пользователя>",
                  "password": "<пароль_пользователя>",
                  "permissions": [
                    {
                      "topicName": "<имя_топика>",
                      "role": "<роль_пользователя>"
                    }
                  ]
                },
                { <аналогичный_набор_настроек_для_пользователя_2> },
                { ... },
                { <аналогичный_набор_настроек_для_пользователя_N> }
              ],
              "maintenanceWindow": {
                "anytime": {},
                "weeklyMaintenanceWindow": {
                  "day": "<день_недели>",
                  "hour": "<час_дня_по_UTC>"
                }
              },
              "deletionProtection": <защитить_кластер_от_удаления>,
              "diskEncryptionKeyId": "<идентификатор_ключа_KMS>"
            }
            ```


            Где:

            * `name` — имя кластера.
            * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
            * `networkId` — идентификатор [сети](../../vpc/concepts/network.md), в которой будет размещен кластер.

            
            * `securityGroupIds` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md) в виде массива строк. Каждая строка — идентификатор группы безопасности.


            * `configSpec` — конфигурация кластера:

                * `version` — версия {{ KF }}. Указывайте версию 3.6 и выше.
                * `kafka` — конфигурация {{ KF }}:

                    * `resources.resourcePresetId` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../api-ref/ResourcePreset/list.md).
                    * `resources.diskSize` — размер диска в байтах.
                    * `resources.diskTypeId` — [тип диска](../concepts/storage.md).

                * `kraft` — конфигурация [{{ kraft-short-name }}](../concepts/kraft.md):

                    * `resources.resourcePresetId` — идентификатор класса хостов. Список доступных классов хостов с их идентификаторами можно запросить с помощью метода [ResourcePreset.list](../api-ref/ResourcePreset/list.md).
                    * `resources.diskSize` — размер диска в байтах.
                    * `resources.diskTypeId` — тип диска.

                    {% include notitle [note-warning-combined-mode](../../_includes/mdb/mkf/create-cluster.md#note-warning-combined-mode) %}


                * `zoneId` и `brokersCount` – зоны доступности и число хостов-брокеров в каждой зоне.

                  Если вы создаете кластер с [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}](../concepts/kraft.md#cluster-topology), укажите одну из доступных конфигураций:

                  * `"zoneId": ["{{ region-id }}-a","{{ region-id }}-b","{{ region-id }}-d"], "brokersCount": "1"` — три зоны доступности, один хост-брокер в каждой зоне;
                  * `"zoneId": ["<одна_зона_доступности>"], "brokersCount": "3"` — одна зона доступности, три хоста-брокера.

                
                * `assignPublicIp` — доступность хостов-брокеров из интернета: `true` или `false`.


                * `schemaRegistry` – управлять схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md): `true` или `false`. Значение по умолчанию — `false`. Эту настройку невозможно изменить после создания кластера {{ mkf-name }}.
                * `restApiConfig` – конфигурация {{ KF }} REST API. Для доступа к отправке запросов к REST API {{ KF }} укажите `enabled: true`.
                * `diskSizeAutoscaling` – [пороги заполненности](../concepts/storage.md#auto-rescale) хранилища (в процентах от общего объема хранилища), при достижении которых его размер будет увеличиваться:

                  {% include [autoscale-settings](../../_includes/mdb/mkf/api/rest-autoscale-settings.md) %}

                  

                * `kafkaUiConfig` — использование [веб-интерфейса {{ kafka-ui }}](../concepts/kafka-ui.md). Для доступа к веб-интерфейсу {{ kafka-ui }} укажите `enabled: true`.


            * `topicSpecs` — настройки топиков в виде массива элементов. Каждый элемент соответствует отдельному топику и имеет следующую структуру:

                {% include [rest-topic-specs](../../_includes/mdb/mkf/api/rest-topic-specs.md) %}

            * `userSpecs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

                {% include [rest-user-specs](../../_includes/mdb/mkf/api/rest-user-specs.md) %}

            * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Выберите один из вариантов:

                * `anytime` — (по умолчанию) — в любое время.
                * `weeklyMaintenanceWindow` — по расписанию:
                    * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                    * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

            * `deletionProtection` — защита кластера от непреднамеренного удаления: `true` или `false`. Значение по умолчанию — `false`.

                {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}
            
            
            * `diskEncryptionKeyId` — идентификатор [пользовательского ключа KMS](../../kms/concepts/key.md). Чтобы зашифровать диски, передайте идентификатор ключа KMS. Подробнее о шифровании дисков см. в разделе [Хранилище](../concepts/storage.md#disk-encryption).

              {% note warning %}
                  
              Включить шифрование дисков можно только при создании кластера.
                  
              {% endnote %}


            
            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Выполните запрос:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters' \
              --data '@body.json'
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService/Сreate](../api-ref/grpc/Cluster/create.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            {% note info %}

            В примере приведены не все доступные параметры.

            {% endnote %}

            
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
              "config_spec": {
                "version": "<версия_{{ KF }}>",
                "kafka": {
                  "resources": {
                    "resource_preset_id": "<класс_хостов {{ KF }}>",
                    "disk_size": "<размер_хранилища_в_байтах>",
                    "disk_type_id": "<тип_диска>"
                  }
                },
                "kraft": {
                  "resources": {
                    "resource_preset_id": "<класс_хостов {{ kraft-short-name }}>",
                    "disk_size": "<размер_хранилища_в_байтах>",
                    "disk_type_id": "<тип_диска>"                   
                  }
                },
                "zone_id": [
                  <список_зон_доступности>
                ],
                "brokers_count": {
                  "value": "<количество_брокеров_в_зоне>"
                },
                "assign_public_ip": <разрешить_публичный_доступ_к_кластеру>,
                "schema_registry": <включить_управление_схемами_данных>,
                "rest_api_config": {
                  "enabled": <включить_отправку_запросов_к_API_{{ KF }}>
                },
                "disk_size_autoscaling": {
                  <параметры_автоматического_увеличения_размера_хранилища>
                },
                "kafka_ui_config": {
                  "enabled": <использовать_веб-интерфейс_Kafka_UI>
                }
              },
              "topic_specs": [
                {
                  "name": "<имя_топика>",
                  "partitions": {
                    "value": "<количество_партиций>"
                  },
                  "replication_factor": {
                    "value": "<фактор_репликации>"
                  }
                },
                { <аналогичный_набор_настроек_для_топика_2> },
                { ... },
                { <аналогичный_набор_настроек_для_топика_N> }
              ],
              "user_specs": [
                {
                  "name": "<имя_пользователя>",
                  "password": "<пароль_пользователя>",
                  "permissions": [
                    {
                      "topic_name": "<имя_топика>",
                      "role": "<роль_пользователя>"
                    }
                  ]
                },
                { <аналогичный_набор_настроек_для_пользователя_2> },
                { ... },
                { <аналогичный_набор_настроек_для_пользователя_N> }
              ],
              "maintenance_window": {
                "anytime": {},
                "weekly_maintenance_window": {
                  "day": "<день_недели>",
                  "hour": "<час_дня_по_UTC>"
                }
              },
              "deletion_protection": <защитить_кластер_от_удаления>,
              "disk_encryption_key_id": "<идентификатор_ключа_KMS>"
            }
            ```


            Где:

            * `name` — имя кластера.
            * `environment` — окружение кластера: `PRODUCTION` или `PRESTABLE`.
            * `network_id` — идентификатор [сети](../../vpc/concepts/network.md), в которой будет размещен кластер.

            
            * `security_group_ids` — идентификаторы [групп безопасности](../../vpc/concepts/security-groups.md) в виде массива строк. Каждая строка — идентификатор группы безопасности.


            * `config_spec` — конфигурация кластера:

                * `version` — версия {{ KF }}. Указывайте версию 3.6 и выше.
                * `kafka` — конфигурация {{ KF }}:

                    * `resources.resource_preset_id` — идентификатор [класса хостов](../concepts/instance-types.md). Список доступных классов хостов с их идентификаторами можно запросить с помощью вызова [ResourcePreset.list](../api-ref/grpc/ResourcePreset/list.md).
                    * `resources.disk_size` — размер диска в байтах.
                    * `resources.disk_type_id` — [тип диска](../concepts/storage.md).

                * `kraft` — конфигурация [{{ kraft-short-name }}](../concepts/kraft.md):

                    * `resources.resource_preset_id` — идентификатор класса хостов. Список доступных классов хостов с их идентификаторами можно запросить с помощью вызова [ResourcePreset.list](../api-ref/grpc/ResourcePreset/list.md).
                    * `resources.disk_size` — размер диска в байтах.
                    * `resources.disk_type_id` — тип диска.
                    
                    {% include notitle [note-warning-combined-mode](../../_includes/mdb/mkf/create-cluster.md#note-warning-combined-mode) %}


                * `zone_id` и `brokers_count` – зоны доступности и число хостов-брокеров в каждой зоне (число передается в виде объекта с полем `value`).

                  Если вы создаете кластер с [{{ ui-key.yacloud.kafka.FormSections.value_coordination-service-type-kraft-combined-mode_c1zke }}](../concepts/kraft.md#cluster-topology), укажите одну из доступных конфигураций:

                  * `"zone_id": ["{{ region-id }}-a","{{ region-id }}-b","{{ region-id }}-d"], "brokers_count": {"value":"1"}` — три зоны доступности, один хост-брокер в каждой зоне;
                  * `"zone_id": ["<одна_зона_доступности>"], "brokers_count": {"value":"3"}` — одна зона доступности, три хоста-брокера.

                
                * `assign_public_ip` — доступность хостов-брокеров из интернета: `true` или `false`.


                * `schema_registry` – управлять схемами данных с помощью [{{ mkf-msr }}](../concepts/managed-schema-registry.md): `true` или `false`. Значение по умолчанию — `false`. Эту настройку невозможно изменить после создания кластера {{ mkf-name }}.
                * `rest_api_config` – конфигурация {{ KF }} REST API. Для доступа к отправке запросов к REST API {{ KF }} укажите `enabled: true`.
                * `disk_size_autoscaling` – чтобы в кластере не заканчивалось место на диске, укажите [пороги заполненности](../concepts/storage.md#auto-rescale) хранилища (в процентах от общего объема хранилища), при достижении которых его размер будет увеличиваться:

                  {% include [autoscale-settings](../../_includes/mdb/mkf/api/grpc-autoscale-settings.md) %}

                  

                * `kafka_ui_config` — использование [веб-интерфейса {{ kafka-ui }}](../concepts/kafka-ui.md). Для доступа к веб-интерфейсу {{ kafka-ui }} укажите `enabled: true`.


            * `topic_specs` — настройки топиков в виде массива элементов. Каждый элемент соответствует отдельному топику и имеет следующую структуру:

                {% include [grpc-topic-specs](../../_includes/mdb/mkf/api/grpc-topic-specs.md) %}

            * `user_specs` — настройки пользователей в виде массива элементов. Каждый элемент соответствует отдельному пользователю и имеет следующую структуру:

                {% include [rest-user-specs](../../_includes/mdb/mkf/api/grpc-user-specs.md) %}

            * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Выберите один из вариантов:

                * `anytime` — (по умолчанию) — в любое время.
                * `weekly_maintenance_window` — по расписанию:
                    * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                    * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

            * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`. Значение по умолчанию — `false`.

                {% include notitle [deletion-protection](../../_includes/mdb/mkf/create-cluster.md#protect-from-deletion) %}
            
            
            * `disk_encryption_key_id` — идентификатор [пользовательского ключа KMS](../../kms/concepts/key.md). Чтобы зашифровать диски, передайте идентификатор ключа KMS. Подробнее о шифровании дисков см. в разделе [Хранилище](../concepts/storage.md#disk-encryption).

              {% note warning %}
                  
              Включить шифрование дисков можно только при создании кластера.
                  
              {% endnote %}


            
            Идентификатор каталога можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).


        1. Выполните запрос:

            ```bash
            curl \
              --request POST \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters' \
              --data '@body.json'
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Создать копию кластера {#duplicate}

Вы можете создать кластер {{ KF }}, который будет обладать настройками созданного ранее кластера. Для этого конфигурация исходного кластера {{ KF }} импортируется в {{ TF }}. В результате вы можете либо создать идентичную копию, либо взять за основу импортированную конфигурацию и внести в нее изменения. Использовать импорт удобно, если исходный кластер {{ KF }} обладает множеством настроек и нужно создать похожий на него кластер.

Чтобы создать копию кластера {{ KF }}:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. В той же рабочей директории разместите файл с расширением `.tf` и содержимым:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "old" { }
        ```

    1. Запишите идентификатор первоначального кластера {{ KF }} в переменную окружения:

        ```bash
        export KAFKA_CLUSTER_ID=<идентификатор_кластера>
        ```

        Идентификатор можно запросить вместе со [списком кластеров в каталоге](../../managed-kafka/operations/cluster-list.md#list-clusters).

    1. Импортируйте настройки первоначального кластера {{ KF }} в конфигурацию {{ TF }}:

        ```bash
        terraform import yandex_mdb_kafka_cluster.old ${KAFKA_CLUSTER_ID}
        ```

    1. Получите импортированную конфигурацию:

        ```bash
        terraform show
        ```

    1. Скопируйте ее из терминала и вставьте в файл с расширением `.tf`.
    1. Расположите файл в новой директории `imported-cluster`.
    1. Измените скопированную конфигурацию так, чтобы из нее можно было создать новый кластер:

        * Укажите новое имя кластера в строке `resource` и параметре `name`.
        * Удалите параметры `created_at`, `health`, `host`, `id` и `status`.
        * Добавьте параметр `subnet_ids` и укажите в нем список идентификаторов подсетей для каждой зоны доступности.
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

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

{% endlist %}

## Примеры {#examples}

### Создание кластера с одним хостом {#creating-a-single-host-cluster}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер {{ mkf-name }} с тестовыми характеристиками:

  
  * С именем `mykf`.
  * В окружении `production`.
  * С {{ KF }} версии 3.9.
  * В сети `{{ network-name }}`.
  * В подсети с идентификатором `{{ subnet-id }}`.
  * В группе безопасности `{{ security-group }}`.
  * С одним хостом-брокером класса `{{ host-class }}`, в зоне доступности `{{ region-id }}-a`.
  * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 10 ГБ.
  * С публичным доступом.
  * С защитой от непреднамеренного удаления.


  Выполните следующую команду:

  
  ```bash
  {{ yc-mdb-kf }} cluster create \
     --name mykf \
     --environment production \
     --version 3.9 \
     --network-name {{ network-name }} \
     --subnet-ids {{ subnet-id }} \
     --zone-ids {{ region-id }}-a \
     --brokers-count 1 \
     --resource-preset {{ host-class }} \
     --disk-size 10 \
     --disk-type {{ disk-type-example }} \
     --assign-public-ip \
     --security-group-ids {{ security-group }} \
     --deletion-protection
  ```



- {{ TF }} {#tf}

  Создайте кластер {{ mkf-name }} с тестовыми характеристиками:
  * В облаке с идентификатором `{{ tf-cloud-id }}`.
  * В каталоге с идентификатором `{{ tf-folder-id }}`.
  * С именем `mykf`.
  * В окружении `PRODUCTION`.
  * С {{ KF }} версии 3.9.
  * В новой сети `mynet` и подсети `mysubnet` с диапазоном адресов `10.5.0.0/24`.
  * В новой группе безопасности `mykf-sg`, разрешающей подключение к кластеру {{ mkf-name }} из интернета по порту `9091`.
  * С одним хостом-брокером класса `{{ host-class }}`, в зоне доступности `{{ region-id }}-a`.
  * С хранилищем на сетевых SSD-дисках (`{{ disk-type-example }}`) объемом 10 ГБ.

  
  * С публичным доступом.


  * С защитой от непреднамеренного удаления.

  Конфигурационный файл для такого кластера {{ mkf-name }} выглядит так:

  ```hcl
  resource "yandex_mdb_kafka_cluster" "mykf" {
    environment         = "PRODUCTION"
    name                = "mykf"
    network_id          = yandex_vpc_network.mynet.id
    subnet_ids          = [ yandex_vpc_subnet.mysubnet.id ]
    security_group_ids  = [ yandex_vpc_security_group.mykf-sg.id ]
    deletion_protection = true

    config {
      assign_public_ip = true
      brokers_count    = 1
      version          = "3.9"
      kafka {
        resources {
          disk_size          = 10
          disk_type_id       = "{{ disk-type-example }}"
          resource_preset_id = "{{ host-class }}"
        }
        kafka_config {}
      }

      zones = [
        "{{ region-id }}-a"
      ]
    }
  }

  resource "yandex_vpc_network" "mynet" {
    name = "mynet"
  }

  resource "yandex_vpc_subnet" "mysubnet" {
    name           = "mysubnet"
    zone           = "{{ region-id }}-a"
    network_id     = yandex_vpc_network.mynet.id
    v4_cidr_blocks = ["10.5.0.0/24"]
  }

  resource "yandex_vpc_security_group" "mykf-sg" {
    name       = "mykf-sg"
    network_id = yandex_vpc_network.mynet.id

    ingress {
      description    = "Kafka"
      port           = 9091
      protocol       = "TCP"
      v4_cidr_blocks = [ "0.0.0.0/0" ]
    }
  }
  ```


{% endlist %}

### Создание кластера с {{ kraft-short-name }} в комбинированном режиме {#kafka-kraft}

В примере используется [конфигурация](../concepts/kraft.md#cluster-topology) с тремя зонами доступности и одним брокером в каждой зоне.

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер {{ mkf-name }} с тестовыми характеристиками:

  * С именем `kafka-kraft`.
  * В окружении `production`.
  * С {{ KF }} версии `3.9`.
  
  
  * В сети с идентификатором `enpc6eqfhmj2********`.
  * В подсетях с идентификаторами:
    
    * `e9bhbia2scnk********`
    * `e2lfqbm5nt9r********`
    * `fl8beqmjckv8********`
  

  * С одним хостом-брокером в каждой зоне доступности:

      
    * `ru-central1-a`
    * `ru-central1-b`
    * `ru-central1-d`
  

  * С [классом хостов](../concepts/instance-types.md) `s2.micro`.
  * С хранилищем на сетевых HDD-дисках (`network-hdd`) объемом `10` ГБ.

  
  * С публичным доступом.
  * В группе безопасности `enp68jq81uun********`.


  Выполните следующую команду:

  
  ```bash
  yc managed-kafka cluster create \
    --name kafka-kraft \
    --environment production \
    --version 3.9 \
    --network-id enpc6eqfhmj2******** \
    --subnet-ids e9bhbia2scnk********,e2lfqbm5nt9r********,fl8beqmjckv8******** \
    --zone-ids ru-central1-a,ru-central1-b,ru-central1-d \
    --brokers-count 1 \
    --resource-preset s2.micro \
    --disk-size 10 \
    --disk-type network-hdd \
    --assign-public-ip \
    --security-group-ids enp68jq81uun********
  ```



- {{ TF }} {#tf}

  Создайте кластер {{ mkf-name }} с тестовыми характеристиками:

  * С именем `kafka-kraft`.
  * В окружении `production`.
  * С {{ KF }} версии `3.9`.
  * В новой сети `kafka-net` и подсетях для каждой зоны доступности:
    
    * `kafka-subnet-a` с диапазоном адресов `10.1.0.0/24`;
    * `kafka-subnet-b` с диапазоном адресов `10.2.0.0/24`;
    * `kafka-subnet-d` с диапазоном адресов `10.3.0.0/24`.

  * С одним хостом-брокером в каждой зоне доступности:
    
    * `ru-central1-a`
    * `ru-central1-b`
    * `ru-central1-d`
  
  * С [классом хостов](../concepts/instance-types.md) `s2.micro`.
  * С хранилищем на сетевых HDD-дисках (`network-hdd`) объемом `10` ГБ.
  * С публичным доступом.
  * В группе безопасности `kafka-sg`, разрешающей весь входящий и исходящий трафик.

  Конфигурационный файл для такого кластера {{ mkf-name }} выглядит так:

  ```hcl
  resource "yandex_mdb_kafka_cluster" "kafka-kraft" {
    name                = "kafka-kraft"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.kafka-net.id
    subnet_ids          = [yandex_vpc_subnet.kafka-subnet-a.id, yandex_vpc_subnet.kafka-subnet-b.id, yandex_vpc_subnet.kafka-subnet-d.id]
    security_group_ids  = [yandex_vpc_security_group.kafka-sg.id]

    config {
      version          = "3.9"
      brokers_count    = 1
      zones            = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
      assign_public_ip = true
      
      kafka {
        resources {
          disk_size          = 10
          disk_type_id       = "network-hdd"
          resource_preset_id = "s2.micro"
        }

        kafka_config {}
      }
    }
  }

  resource "yandex_vpc_network" "kafka-net" {
    name = "kafka-net"
  }

  resource "yandex_vpc_subnet" "kafka-subnet-a" {
    name           = "kafka-subnet-a"
    zone           = "ru-central1-a"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.1.0.0/24"]
  }

  resource "yandex_vpc_subnet" "kafka-subnet-b" {
    name           = "kafka-subnet-b"
    zone           = "ru-central1-b"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.2.0.0/24"]
  }

  resource "yandex_vpc_subnet" "kafka-subnet-d" {
    name           = "kafka-subnet-d"
    zone           = "ru-central1-d"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.3.0.0/24"]
  }

  resource "yandex_vpc_security_group" "kafka-sg" {
    name       = "kafka-sg"
    network_id = yandex_vpc_network.kafka-net.id
  
    ingress {
      protocol       = "ANY"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      protocol       = "ANY"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ```


{% endlist %}  

### Создание кластера с {{ kraft-short-name }} на отдельных хостах (многохостовый кластер) {#kafka-kraft-mh}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер {{ mkf-name }} с тестовыми характеристиками:

  * С именем `kafka-kraft-mh`.
  * В окружении `production`.
  * С {{ KF }} версии `3.9`.
  
  
  * В сети с идентификатором `enpc6eqfhmj2********`.
  * В подсетях с идентификаторами:
    
    * `e9bhbia2scnk********`
    * `e2lfqbm5nt9r********`
    * `fl8beqmjckv8********`
  

  * С двумя хостами-брокерами в зоне доступности `ru-central1-a`.
  * С [классом хостов](../concepts/instance-types.md) `s2.micro`.
  * С хранилищем на сетевых HDD-дисках (`network-hdd`) объемом `10` ГБ.
  * С [классом хостов](../concepts/instance-types.md) контроллера [{{ kraft-short-name }}](../concepts/kraft.md) `s2.micro`.
  * С хранилищем контроллера [{{ kraft-short-name }}](../concepts/kraft.md) на сетевых SSD-дисках (`network-ssd`) объемом `10` ГБ.

  
  * С публичным доступом.
  * В группе безопасности `enp68jq81uun********`.


  Выполните следующую команду:

  
  ```bash
  yc managed-kafka cluster create \
    --name kafka-kraft-mh \
    --environment production \
    --version 3.9 \
    --network-id enpc6eqfhmj2******** \
    --subnet-ids e9bhbia2scnk********,e2lfqbm5nt9r********,fl8beqmjckv8******** \
    --zone-ids ru-central1-a \
    --brokers-count 2 \
    --resource-preset s2.micro \
    --disk-size 10 \
    --disk-type network-hdd \
    --controller-resource-preset s2.micro \
    --controller-disk-size 10 \
    --controller-disk-type network-ssd \
    --assign-public-ip \
    --security-group-ids enp68jq81uun********
  ```



- {{ TF }} {#tf}

  Создайте кластер {{ mkf-name }} с тестовыми характеристиками:

  * С именем `kafka-kraft-mh`.
  * В окружении `production`.
  * С {{ KF }} версии `3.9`.
  * В новой сети `kafka-net` и подсетях для каждой зоны доступности:
    
    * `kafka-subnet-a` с диапазоном адресов `10.1.0.0/24`;
    * `kafka-subnet-b` с диапазоном адресов `10.2.0.0/24`;
    * `kafka-subnet-d` с диапазоном адресов `10.3.0.0/24`.
  
  * С двумя хостами-брокерами в зоне доступности `ru-central1-a`.
  * С [классом хостов](../concepts/instance-types.md) `s2.micro`.
  * С хранилищем на сетевых HDD-дисках (`network-hdd`) объемом `10` ГБ.
  * С [классом хостов](../concepts/instance-types.md) контроллера [{{ kraft-short-name }}](../concepts/kraft.md) `s2.micro`.
  * С хранилищем контроллера [{{ kraft-short-name }}](../concepts/kraft.md) на сетевых SSD-дисках (`network-ssd`) объемом `10` ГБ.
  * С публичным доступом.
  * В группе безопасности `kafka-sg`, разрешающей весь входящий и исходящий трафик.

  Конфигурационный файл для такого кластера {{ mkf-name }} выглядит так:

  ```hcl
  resource "yandex_mdb_kafka_cluster" "kafka-kraft-mh" {
    name                = "kafka-kraft-mh"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.kafka-net.id
    subnet_ids          = [yandex_vpc_subnet.kafka-subnet-a.id,yandex_vpc_subnet.kafka-subnet-b.id,yandex_vpc_subnet.kafka-subnet-d.id]
    security_group_ids  = [yandex_vpc_security_group.kafka-sg.id]

    config {
      version          = "3.9"
      brokers_count    = 2
      zones            = ["ru-central1-a"]
      assign_public_ip = true
      
      kafka {
        resources {
          disk_size          = 10
          disk_type_id       = "network-hdd"
          resource_preset_id = "s2.micro"
        }

        kafka_config {}
      }

      kraft {
        resources {
          resource_preset_id = "s2.micro"
          disk_type_id       = "network-ssd"
          disk_size          = 10
        }
      }
    }
  }

  resource "yandex_vpc_network" "kafka-net" {
    name = "kafka-net"
  }

  resource "yandex_vpc_subnet" "kafka-subnet-a" {
    name           = "kafka-subnet-a"
    zone           = "ru-central1-a"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.1.0.0/24"]
  }

  resource "yandex_vpc_subnet" "kafka-subnet-b" {
    name           = "kafka-subnet-b"
    zone           = "ru-central1-b"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.2.0.0/24"]
  }

  resource "yandex_vpc_subnet" "kafka-subnet-d" {
    name           = "kafka-subnet-d"
    zone           = "ru-central1-d"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.3.0.0/24"]
  }

  resource "yandex_vpc_security_group" "kafka-sg" {
    name       = "kafka-sg"
    network_id = yandex_vpc_network.kafka-net.id
  
    ingress {
      protocol       = "ANY"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      protocol       = "ANY"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ```


{% endlist %}

### Создание кластера с {{ ZK }} на отдельных хостах (многохостовый кластер) {#kafka-zk-mh}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте кластер {{ mkf-name }} с тестовыми характеристиками:

  * С именем `kafka-zk-mh`.
  * В окружении `production`.
  * С {{ KF }} версии `3.9`.
  
  
  * В сети с идентификатором `enpc6eqfhmj2********`.
  * В подсетях с идентификаторами:
    
    * `e9bhbia2scnk********`
    * `e2lfqbm5nt9r********`
    * `fl8beqmjckv8********`
  

  * С двумя хостами-брокерами в зоне доступности `ru-central1-a`.
  * С [классом хостов](../concepts/instance-types.md) `s2.micro`.
  * С хранилищем на сетевых HDD-дисках (`network-hdd`) объемом `10` ГБ.
  * С [классом хостов](../concepts/instance-types.md) {{ ZK }} `s2.micro`.
  * С хранилищем [{{ ZK }}](../concepts/index.md#zookeeper) на сетевых SSD-дисках (`network-ssd`) объемом `10` ГБ.
  
  
  * С публичным доступом.
  * В группе безопасности `enp68jq81uun********`.


  Выполните следующую команду:

  
  ```bash
  yc managed-kafka cluster create \
    --name kafka-zk-mh \
    --environment production \
    --version 3.9 \
    --network-id enpc6eqfhmj2******** \
    --subnet-ids e9bhbia2scnk********,e2lfqbm5nt9r********,fl8beqmjckv8******** \
    --zone-ids ru-central1-a \
    --brokers-count 2 \
    --resource-preset s2.micro \
    --disk-size 10 \
    --disk-type network-hdd \
    --zookeeper-resource-preset s2.micro \
    --zookeeper-disk-size 10 \
    --zookeeper-disk-type network-ssd \
    --assign-public-ip \
    --security-group-ids enp68jq81uun********
  ```  



- {{ TF }} {#tf}

  Создайте кластер {{ mkf-name }} с тестовыми характеристиками:

  * С именем `kafka-zk-mh`.
  * В окружении `production`.
  * С {{ KF }} версии `3.9`.
  * В новой сети `kafka-net` и подсетях для каждой зоны доступности:
    
    * `kafka-subnet-a` с диапазоном адресов `10.1.0.0/24`;
    * `kafka-subnet-b` с диапазоном адресов `10.2.0.0/24`;
    * `kafka-subnet-d` с диапазоном адресов `10.3.0.0/24`.
  
  * С двумя хостами-брокерами в зоне доступности `ru-central1-a`.
  * С [классом хостов](../concepts/instance-types.md) `s2.micro`.
  * С хранилищем на сетевых HDD-дисках (`network-hdd`) объемом `10` ГБ.
  * С [классом хостов](../concepts/instance-types.md) {{ ZK }} `s2.micro`.
  * С хранилищем [{{ ZK }}](../concepts/index.md#zookeeper) на сетевых SSD-дисках (`network-ssd`) объемом `10` ГБ.
  * С публичным доступом.
  * В группе безопасности `kafka-sg`, разрешающей весь входящий и исходящий трафик.

  Конфигурационный файл для такого кластера {{ mkf-name }} выглядит так:

  ```hcl
  resource "yandex_mdb_kafka_cluster" "kafka-zk-mh" {
    name                = "kafka-zk-mh"
    environment         = "PRODUCTION"
    network_id          = yandex_vpc_network.kafka-net.id
    subnet_ids          = [yandex_vpc_subnet.kafka-subnet-a.id,yandex_vpc_subnet.kafka-subnet-b.id,yandex_vpc_subnet.kafka-subnet-d.id]
    security_group_ids  = [yandex_vpc_security_group.kafka-sg.id]

    config {
      version          = "3.9"
      brokers_count    = 2
      zones            = ["ru-central1-a"]
      assign_public_ip = true
      
      kafka {
        resources {
          disk_size          = 10
          disk_type_id       = "network-hdd"
          resource_preset_id = "s2.micro"
        }

        kafka_config {}
      }

      zookeeper {
        resources {
          resource_preset_id = "s2.micro"
          disk_type_id       = "network-ssd"
          disk_size          = 10
        }
      }
    }
  }

  resource "yandex_vpc_network" "kafka-net" {
    name = "kafka-net"
  }

  resource "yandex_vpc_subnet" "kafka-subnet-a" {
    name           = "kafka-subnet-a"
    zone           = "ru-central1-a"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.1.0.0/24"]
  }

  resource "yandex_vpc_subnet" "kafka-subnet-b" {
    name           = "kafka-subnet-b"
    zone           = "ru-central1-b"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.2.0.0/24"]
  }

  resource "yandex_vpc_subnet" "kafka-subnet-d" {
    name           = "kafka-subnet-d"
    zone           = "ru-central1-d"
    network_id     = yandex_vpc_network.kafka-net.id
    v4_cidr_blocks = ["10.3.0.0/24"]
  }

  resource "yandex_vpc_security_group" "kafka-sg" {
    name       = "kafka-sg"
    network_id = yandex_vpc_network.kafka-net.id
  
    ingress {
      protocol       = "ANY"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
      protocol       = "ANY"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  }
  ```


{% endlist %}  