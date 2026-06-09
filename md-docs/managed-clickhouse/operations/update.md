# Изменение настроек кластера {{ CH }}

После создания кластера вы можете:

* [Изменить настройки сервисного аккаунта](#change-service-account).
* [Изменить класс хостов](#change-resource-preset).
* [Изменить тип диска и увеличить размер хранилища](#change-disk-size).
* [Настроить сервис координации](#coordination).
* [Включить управление пользователями и базами данных через SQL](#SQL-management).
* [Изменить дополнительные настройки кластера](#change-additional-settings).
* [Переместить кластер](#move-cluster) в другой каталог.
* [Изменить группы безопасности кластера](#change-sg-set).
* [Изменить настройки гибридного хранилища](#change-hybrid-storage).

Подробнее о других изменениях кластера:

* [Настройка технического обслуживания](cluster-maintenance.md).
* [Перенос кластера в другую зону доступности](host-migration.md).
* [Настройка серверов {{ CH }}](change-server-level-settings.md) согласно [документации {{ CH }}]({{ ch.docs }}{{ lang }}/operations/server-configuration-parameters/settings).
* [Изменение настроек {{ CH }} на уровне запроса](change-query-level-settings.md).


## Изменить настройки сервисного аккаунта {#change-service-account}


Для привязки сервисного аккаунта к кластеру {{ mch-name }} [назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.


{% note warning %}

Если для доступа к объектам из {{ objstorage-name }} в кластере уже используется сервисный аккаунт, то его смена может привести к недоступности этих объектов и нарушению работы кластера. Перед изменением настроек сервисного аккаунта убедитесь, что кластер не использует соответствующие объекты.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы изменить настройки сервисного аккаунта:

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. В разделе **{{ ui-key.yacloud.mdb.forms.section_service-settings }}** выберите нужный сервисный аккаунт из списка или [создайте новый](../../iam/operations/sa/create.md). Подробнее о настройке сервисного аккаунта см. в разделе [{#T}](s3-access.md).

{% endlist %}


## Изменить класс хостов {#change-resource-preset}

{% note info %}

В кластерах с поддержкой {{ CK }} хосты {{ ZK }} не используются. Подробнее в разделе [Сервисы координации](../concepts/coordination-system.md).

{% endnote %}

При смене класса хостов:

* Кластер из одного хоста будет недоступен несколько минут, соединения с БД будут прерваны.
* В кластере из нескольких хостов каждый хост по очереди будет остановлен и обновлен. Остановленный хост будет недоступен несколько минут.
* Кластер с хранилищем на локальных SSD-дисках может быть недоступен длительное время, т. к. может потребоваться миграция данных на другой физический сервер.
* Подключение по [особому FQDN](connect/fqdn.md#auto) не гарантирует стабильность соединения с БД: пользовательские сессии могут быть прерваны.

Рекомендуется изменять класс хостов только во время отсутствия рабочей нагрузки на кластер.

Вы также можете [изменить класс хостов у отдельного шарда](shards.md#shard-update).

Класс хостов влияет на количество оперативной памяти, доступной для использования {{ CH }}. Подробнее см. в разделе [Управление памятью](../concepts/memory-management.md).

Минимальное количество ядер для одного хоста {{ ZK }} зависит от суммарного количества ядер хостов {{ CH }}. Подробнее см. в разделе [Сервисы координации](../concepts/coordination-system.md#zk).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. Чтобы изменить класс хостов {{ CH }}, в блоке **{{ ui-key.yacloud.mdb.forms.new_section_resource }}** выберите платформу, тип виртуальной машины и нужный класс хоста.
  1. Чтобы изменить класс хостов {{ ZK }}, в блоке **{{ ui-key.yacloud.mdb.forms.section_zookeeper-resource }}** выберите платформу, тип виртуальной машины и нужный класс хоста {{ ZK }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-ch }} cluster update --help
     ```

  1. Запросите список доступных классов хостов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     
     ```bash
     {{ yc-mdb-ch }} resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
     |           | {{ region-id }}-d                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```


  1. Укажите нужный класс в команде изменения кластера:

     ```bash
     {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
        --clickhouse-resource-preset=<идентификатор_класса>
     ```

     {{ mch-short-name }} запустит операцию изменения класса хостов для кластера.

  1. Чтобы изменить класс хостов {{ ZK }}, передайте нужное значение в параметре `--zookeeper-resource-preset`.


- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера {{ mch-name }} значение параметра `resource_preset_id` в блоках `clickhouse.resources` и `zookeeper.resources` для хостов {{ CH }} и {{ ZK }} соответственно:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          clickhouse = {
            resources = {
              resource_preset_id = "<класс_хостов_{{ CH }}>"
              ...
            }
          }
          zookeeper = {
            resources = {
              resource_preset_id = "<класс_хостов_{{ ZK }}>"
              ...
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% note warning "Ограничения по времени" %}
    
    Провайдер {{ TF }} ограничивает время на выполнение операций с кластером {{ mch-name }}:
    
    * создание, в т. ч. путем восстановления из резервной копии, — 60 минут;
    * изменение — 90 минут;
    * удаление — 30 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
      ...
      timeouts = {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
        delete = "30m"   # 30 минут
      }
    }
    ```
    
    {% endcut %}
    
    {% endnote %}


- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Запросите список доступных классов хостов:

        1. Воспользуйтесь методом [ResourcePreset.List](../api-ref/ResourcePreset/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

            ```bash
            curl \
                --request GET \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/resourcePresets'
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/ResourcePreset/list.md#responses).

    1. Измените класс хостов на нужный:

        1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

            ```bash
            curl \
                --request PATCH \
                --header "Authorization: Bearer $IAM_TOKEN" \
                --header "Content-Type: application/json" \
                --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
                --data '{
                          "updateMask": "configSpec.clickhouse.resources.resourcePresetId,configSpec.zookeeper.resources.resourcePresetId",
                          "configSpec": {
                            "clickhouse": {
                              "resources": {
                                "resourcePresetId": "<идентификатор_класса_хостов_{{ CH }}>"
                              }
                            },
                            "zookeeper": {
                              "resources": {
                                "resourcePresetId": "<идентификатор_класса_хостов_{{ ZK }}>"
                              }
                            }
                          }
                        }'
            ```

            Где:

            * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

                Укажите нужные параметры:
                * `configSpec.clickhouse.resources.resourcePresetId` — если нужно изменить класс хостов {{ CH }}.
                * `configSpec.zookeeper.resources.resourcePresetId` — если нужно изменить класс хостов {{ ZK }}.

                В примере запроса класс хостов изменяется и для хостов {{ CH }}, и для хостов {{ ZK }}.

            * `configSpec.clickhouse.resources.resourcePresetId` — идентификатор класса хостов {{ CH }}.
            * `configSpec.zookeeper.resources.resourcePresetId` — идентификатор класса хостов {{ ZK }}.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Запросите список доступных классов хостов:

        1. Воспользуйтесь вызовом [ResourcePresetService.List](../api-ref/grpc/ResourcePreset/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/resource_preset_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.clickhouse.v1.ResourcePresetService.List
            ```

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/ResourcePreset/list.md#yandex.cloud.mdb.clickhouse.v1.ListResourcePresetsResponse).

    1. Измените класс хостов на нужный:

        1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
            
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
            
            {% endnote %}

            ```bash
            grpcurl \
                -format json \
                -import-path ~/cloudapi/ \
                -import-path ~/cloudapi/third_party/googleapis/ \
                -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
                -rpc-header "Authorization: Bearer $IAM_TOKEN" \
                -d '{
                      "cluster_id": "<идентификатор_кластера>",
                      "update_mask": {
                        "paths": [
                          "config_spec.clickhouse.resources.resource_preset_id",
                          "config_spec.zookeeper.resources.resource_preset_id"
                        ]
                      },
                      "config_spec": {
                        "clickhouse": {
                          "resources": {
                            "resource_preset_id": "<идентификатор_класса_хостов_{{ CH }}>"
                          }
                        },
                        "zookeeper": {
                          "resources": {
                            "resource_preset_id": "<идентификатор_класса_хостов_{{ ZK }}>"
                          }
                        }
                      }
                    }' \
                {{ api-host-mdb }}:{{ port-https }} \
                yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
            ```

            Где:

            * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

                Укажите нужные параметры:
                * `config_spec.clickhouse.resources.resource_preset_id` — если нужно изменить класс хостов {{ CH }}.
                * `config_spec.zookeeper.resources.resource_preset_id` — если нужно изменить класс хостов {{ ZK }}.

                В примере запроса класс хостов изменяется и для хостов {{ CH }}, и для хостов {{ ZK }}.

            * `config_spec.clickhouse.resources.resource_preset_id` — идентификатор класса хостов {{ CH }}.
            * `config_spec.zookeeper.resources.resource_preset_id` — идентификатор класса хостов {{ ZK }}.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

        1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить тип диска и увеличить размер хранилища {#change-disk-size}

{% note info %}

В кластерах с поддержкой {{ CK }} хосты {{ ZK }} не используются. Подробнее см. в разделе [Сервисы координации](../concepts/coordination-system.md).

{% endnote %}

Проверьте, что в облаке достаточно квот для увеличения хранилища. Откройте страницу [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) для облака и убедитесь, что в секции **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}** в строке **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-mdb.hdd.size }}** или **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-mdb.ssd.size }}** есть квота на объем хранилищ.

{% note warning %}

При изменении типа диска хосты кластера пересоздаются. Данные реплицированных таблиц сохраняются автоматически. Данные нереплицированных таблиц будут потеряны. Если необходимо сохранить данные в нереплицированных таблицах, перед изменением типа диска [преобразуйте их в реплицированные]({{ ch.docs }}{{ lang }}/sql-reference/statements/attach#attach-mergetree-table-as-replicatedmergetree).

{% endnote %}

При изменении типа диска или размера хранилища кластер с хранилищем на локальных SSD-дисках может быть недоступен длительное время, т. к. может потребоваться миграция данных на другой физический сервер.

Вы также можете [изменить тип диска и размер хранилища у отдельного шарда](shards.md#shard-update).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить тип диска и увеличить размер хранилища для кластера:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. Чтобы изменить тип диска и увеличить размер хранилища для хостов {{ CH }}, выберите нужные значения в блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**.
  1. Чтобы изменить тип диска и увеличить размер хранилища для хостов {{ CK }} или {{ ZK }}, выберите нужные значения в блоке **{{ ui-key.yacloud.mdb.forms.section_zookeeper-disk }}** или **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-disk }}** соответственно.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.
  1. Если вы изменили тип диска для хостов {{ CH }}:
      1. В открывшемся окне посмотрите количество нереплицированных таблиц на графике **Non-replicated MergeTree tables** и их размер на графике **Size of non-replicated MergeTree tables**. Данные в нереплицированных таблицах будут утеряны. Если необходимо сохранить их, перед изменением типа диска [преобразуйте]({{ ch.docs }}{{ lang }}/sql-reference/statements/attach#attach-mergetree-table-as-replicatedmergetree) нереплицированные таблицы в реплицированные.
      1. Подтвердите изменение ресурсов.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить тип диска и увеличить размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-ch }} cluster update --help
     ```

  1. Укажите нужный [тип диска](../concepts/storage.md) и размер хранилища в команде изменения кластера:

     ```bash
     {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
       --clickhouse-disk-size <размер_хранилища_ГБ> \
       --clickhouse-disk-type <тип_диска> \
       --allow-host-recreation
     ```

     Параметр `--allow-host-recreation` необходим при изменении типа диска, чтобы разрешить кластеру пересоздать хосты.

          
     Новый размер хранилища должен быть не меньше, чем значение `disk_size` в свойствах кластера.


     Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Чтобы изменить тип диска и увеличить размер хранилища хостов {{ ZK }}, передайте нужные значения в параметрах `--zookeeper-disk-size` и `--zookeeper-disk-type`.


- {{ TF }} {#tf}

  {% note info %}

  С помощью {{ TF }} невозможно изменить тип диска.

  {% endnote %}

  Чтобы увеличить размер хранилища:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера {{ mch-name }} значение параметра `disk_size` в блоке `clickhouse.resources` или `zookeeper.resources` для хостов {{ CH }} и {{ ZK }} соответственно:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          clickhouse = {
            resources = {
              disk_size = <размер_хранилища_ГБ>
              ...
            }
          }
          zookeeper = {
            resources = {
              disk_size = <размер_хранилища_ГБ>
              ...
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% note warning "Ограничения по времени" %}
    
    Провайдер {{ TF }} ограничивает время на выполнение операций с кластером {{ mch-name }}:
    
    * создание, в т. ч. путем восстановления из резервной копии, — 60 минут;
    * изменение — 90 минут;
    * удаление — 30 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
      ...
      timeouts = {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
        delete = "30m"   # 30 минут
      }
    }
    ```
    
    {% endcut %}
    
    {% endnote %}


- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.clickhouse.resources.diskSize,configSpec.clickhouse.resources.diskTypeId,configSpec.zookeeper.resources.diskSize,configSpec.zookeeper.resources.diskTypeId,allowHostRecreation",
                      "configSpec": {
                        "clickhouse": {
                          "resources": {
                            "diskSize": "<размер_хранилища_в_байтах>",
                            "diskTypeId": "<тип_диска>"
                          }
                        },
                        "zookeeper": {
                          "resources": {
                            "diskSize": "<размер_хранилища_в_байтах>",
                            "diskTypeId": "<тип_диска>"
                          }
                        }
                      },
                      "allowHostRecreation": "true"
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:

            * `configSpec.clickhouse.resources.diskSize,configSpec.clickhouse.resources.diskTypeId` — если нужно изменить тип диска и увеличить размер хранилища хостов {{ CH }}.
            * `configSpec.zookeeper.resources.diskSize,configSpec.zookeeper.resources.diskTypeId` — если нужно изменить тип диска и увеличить размер хранилища хостов {{ ZK }}.

            В примере запроса размер хранилища и тип диска изменяются и для хостов {{ CH }}, и для хостов {{ ZK }}.

        * `configSpec.clickhouse.resources.diskSize` — размер хранилища хостов {{ CH }} в байтах.
        * `configSpec.clickhouse.resources.diskTypeId` — [тип диска](../concepts/storage.md) хостов {{ CH }}.
        * `configSpec.zookeeper.resources.diskSize` — размер хранилища хостов {{ ZK }} в байтах.
        * `configSpec.zookeeper.resources.diskTypeId` — тип диска хостов {{ ZK }}.
        * `allowHostRecreation` — разрешить кластеру пересоздать хосты (параметр обязателен при изменении типа диска).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
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
        
        {% endnote %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.clickhouse.resources.disk_size",
                      "config_spec.clickhouse.resources.disk_type_id",
                      "config_spec.zookeeper.resources.disk_size",
                      "config_spec.zookeeper.resources.disk_type_id",
                      "allow_host_recreation"
                    ]
                  },
                  "config_spec": {
                    "clickhouse": {
                      "resources": {
                        "disk_size": "<размер_хранилища_в_байтах>",
                        "disk_type_id": "<тип_диска>"
                      }
                    },
                    "zookeeper": {
                      "resources": {
                        "disk_size": "<размер_хранилища_в_байтах>",
                        "disk_type_id": "<тип_диска>"
                      }
                    }
                  },
                  "allow_host_recreation": "true"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:

            * `config_spec.clickhouse.resources.disk_size` — если нужно увеличить размер хранилища хостов {{ CH }}.
            * `config_spec.clickhouse.resources.disk_type_id` — если нужно изменить тип диска хостов {{ CH }}.
            * `config_spec.zookeeper.resources.disk_size` — если нужно увеличить размер хранилища хостов {{ ZK }}.
            * `config_spec.zookeeper.resources.disk_type_id` — если нужно изменить тип диска хостов {{ ZK }}.

            В примере запроса размер хранилища и тип диска изменяются и для хостов {{ CH }}, и для хостов {{ ZK }}.

        * `config_spec.clickhouse.resources.disk_size` — размер хранилища хостов {{ CH }} в байтах.
        * `config_spec.clickhouse.resources.disk_type_id` — [тип диска](../concepts/storage.md) хостов {{ CH }}.
        * `config_spec.zookeeper.resources.disk_size` — размер хранилища хостов {{ ZK }} в байтах.
        * `config_spec.zookeeper.resources.disk_type_id` — тип диска хостов {{ ZK }}.
        * `allow_host_recreation` — разрешить кластеру пересоздать хосты (параметр обязателен при изменении типа диска).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Настроить сервис координации {#coordination}

Вы можете [включить сервис координации](#enable-coordination) {{ CK }} или {{ ZK }}, если он не был задан. Для включенного сервиса координации можно [изменить его настройки](#change-coordination).

### Включить сервис координации {#enable-coordination}

{% note warning %}

Хосты {{ CK }} и {{ ZK }} учитываются в расчете использованной [квоты ресурсов]({{ link-console-quotas }}) в облаке и в [расчете стоимости](../pricing.md) кластера.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.hosts.button_create-coordinator }}**.
  1. В блоке **{{ ui-key.yacloud.clickhouse.AddCoordinatorHost.title_main-settings_68Grp }}** выберите [сервис координации](../concepts/coordination-system.md).
  1. В зависимости от выбранного сервиса задайте следующие настройки:

      * Для сервиса координации **{{ ui-key.yacloud.clickhouse.cluster.value_coordination-service-zookeeper }}**:

        * В блоке **{{ ui-key.yacloud.mdb.forms.section_zookeeper-resource }}** выберите платформу, тип виртуальной машины и [класс хоста](../concepts/instance-types.md).
        * В блоке **{{ ui-key.yacloud.mdb.forms.section_zookeeper-disk }}** выберите [тип диска](../concepts/storage.md), размер хранилища и при необходимости задайте настройки [автоматического увеличения размера хранилища](../concepts/storage.md#autoscaling) {{ ZK }}.

        * В блоке **{{ ui-key.yacloud.mdb.forms.section_zookeeper-hosts }}**:

          * При необходимости измените настройки автоматически добавленных хостов {{ ZK }}.

            Чтобы изменить настройки хоста, нажмите на значок ![pencil](../../_assets/console-icons/pencil.svg) в строке нужного хоста и укажите:

            * **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_zone }}** — выберите [зону доступности](../../overview/concepts/geo-scope.md).
            * **{{ ui-key.yacloud.mdb.hosts.dialog.field_subnetworks }}** — выберите [подсеть](../../vpc/concepts/network.md#subnet) в выбранной зоне доступности.

          * Чтобы преобразовать нереплицируемые таблицы в [реплицируемые](../concepts/replication.md#replicated-tables), включите настройку **{{ ui-key.yacloud.clickhouse.field_convert_tables_to_replicated }}**.

            Нереплицируемые таблицы на движке семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree) будут автоматически преобразованы в реплицируемые на движке [ReplicatedMergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/replication).

            После включения этой настройки ее нельзя отключить.

      * Для сервиса координации **{{ ui-key.yacloud.clickhouse.cluster.value_coordination-service-separated-clickhouse-keeper }}**:

        * В блоке **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-resource }}** выберите платформу, тип виртуальной машины и [класс хоста](../concepts/instance-types.md).
        * В блоке **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-disk }}** выберите [тип диска](../concepts/storage.md), размер хранилища и при необходимости задайте настройки [автоматического увеличения размера хранилища](../concepts/storage.md#autoscaling) {{ CK }}.
        * В блоке **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-hosts }}**:

          * При необходимости измените настройки автоматически добавленных хостов {{ CK }}.

            Чтобы изменить настройки хоста, нажмите на значок ![pencil](../../_assets/console-icons/pencil.svg) в строке нужного хоста и укажите:

            * **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_zone }}** — выберите [зону доступности](../../overview/concepts/geo-scope.md).
            * **{{ ui-key.yacloud.mdb.hosts.dialog.field_subnetworks }}** — выберите [подсеть](../../vpc/concepts/network.md#subnet) в выбранной зоне доступности.

          * Чтобы преобразовать нереплицируемые таблицы в [реплицируемые](../concepts/replication.md#replicated-tables), включите настройку **{{ ui-key.yacloud.clickhouse.field_convert_tables_to_replicated }}**.

            Нереплицируемые таблицы на движке семейства [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree) будут автоматически преобразованы в реплицируемые на движке [ReplicatedMergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/replication).

            После включения этой настройки ее нельзя отключить.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}

### Изменить настройки включенного сервиса координации {#change-coordination}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. В зависимости от выбранного сервиса координации задайте следующие настройки:

      * Для сервиса координации **{{ ui-key.yacloud.clickhouse.cluster.value_coordination-service-separated-clickhouse-keeper }}**:

        * В блоке **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-resource }}** выберите платформу, тип виртуальной машины и [класс хоста](../concepts/instance-types.md);
        * В блоке **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-disk }}** выберите [тип диска](../concepts/storage.md), размер хранилища и при необходимости задайте [настройки автоматического увеличения размера хранилища](../concepts/storage.md#autoscaling) {{ CK }}.

      * Для сервиса координации **{{ ui-key.yacloud.clickhouse.cluster.value_coordination-service-zookeeper }}**:

        * В блоке **{{ ui-key.yacloud.mdb.forms.section_zookeeper-resource }}** выберите платформу, тип виртуальной машины и [класс хоста](../concepts/instance-types.md);
        * В блоке **{{ ui-key.yacloud.mdb.forms.section_zookeeper-disk }}** выберите [тип диска](../concepts/storage.md), размер хранилища и при необходимости задайте [настройки автоматического увеличения размера хранилища](../concepts/storage.md#autoscaling) {{ ZK }}.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}

## Включить управление пользователями и базами данных через SQL {#SQL-management}

Сервис {{ mch-name }} позволяет управлять [пользователями](../concepts/user-access-rights.md#sql-user-management) и [базами данных](databases.md#sql-database-management) кластера через SQL.

{% note alert %}

Управление пользователями и базами данных через стандартные интерфейсы {{ yandex-cloud }} (консоль управления, CLI, {{ TF }}, API) станет недоступно.

Включенные настройки управления пользователями или базами данных через SQL невозможно выключить.

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. Для [управления пользователями через SQL](../concepts/user-access-rights.md#sql-user-management), в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** включите настройку **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** и укажите пароль пользователя `admin`.
  1. Для [управления базами данных через SQL](databases.md#sql-database-management), в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}** включите настройки **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** и **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}**, укажите пароль пользователя `admin`.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    1. Чтобы включить [управление пользователями через SQL](../concepts/user-access-rights.md#sql-user-management):

        * задайте значение `true` для параметра `--enable-sql-user-management`;
        * задайте пароль для пользователя `admin` в параметре `--admin-password`.

        ```bash
        {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
           ...
           --enable-sql-user-management true \
           --admin-password "<пароль_пользователя_admin>"
        ```

    1. Чтобы включить [управление базами данных через SQL](databases.md#sql-database-management):

        * задайте значение `true` для параметров `--enable-sql-user-management` и `--enable-sql-database-management`;
        * задайте пароль для пользователя `admin` в параметре `--admin-password`.

        ```bash
        {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
           ...
           --enable-sql-user-management true \
           --enable-sql-database-management true \
           --admin-password "<пароль_пользователя_admin>"
        ```


- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Чтобы включить [управление пользователями через SQL](../concepts/user-access-rights.md#sql-user-management), добавьте к описанию кластера поле `sql_user_management` со значением `true` и поле `admin_password` с паролем пользователя `admin`:
       
       ```hcl
       resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
         name                = "<имя_кластера>"
         ...
         admin_password      = "<пароль_пользователя_admin>"
         sql_user_management = true
         ...
       }
       ```

    1. Чтобы включить [управление базами данных через SQL](databases.md#sql-database-management), добавьте к описанию кластера поля `sql_user_management` и `sql_database_management` со значением `true`, а также поле `admin_password` с паролем пользователя `admin`:
       
       ```hcl
       resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
         name                    = "<имя_кластера>"
         ...
         admin_password          = "<пароль_пользователя_admin>"
         sql_database_management = true
         sql_user_management     = true
         ...
       }
       ```

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

    {% note warning "Ограничения по времени" %}
    
    Провайдер {{ TF }} ограничивает время на выполнение операций с кластером {{ mch-name }}:
    
    * создание, в т. ч. путем восстановления из резервной копии, — 60 минут;
    * изменение — 90 минут;
    * удаление — 30 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
      ...
      timeouts = {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
        delete = "30m"   # 30 минут
      }
    }
    ```
    
    {% endcut %}
    
    {% endnote %}


- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.adminPassword,configSpec.sqlUserManagement,configSpec.sqlDatabaseManagement",
                      "configSpec": {
                        "adminPassword": "<пароль_пользователя_admin>",
                        "sqlUserManagement": <управление_пользователями_через_SQL>,
                        "sqlDatabaseManagement": <управление_базами_данных_через_SQL>
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:

            * `configSpec.adminPassword` — пароль пользователя `admin`, с помощью которого осуществляется управление.
            * `configSpec.sqlUserManagement` — если нужно включить управление пользователями через SQL.
            * `configSpec.sqlDatabaseManagement` — если нужно включить управление базами данных через SQL.

            В примере запроса включается и управление пользователями, и управление базами данных черех SQL.

        * `configSpec.adminPassword` — пароль пользователя `admin`.
        * `configSpec.sqlUserManagement` — режим управления пользователями через SQL: `true` или `false`.
        * `configSpec.sqlDatabaseManagement` — режим управления базами данных через SQL: `true` или `false`. Необходимо, чтобы был включен режим управления пользователями через SQL.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
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
        
        {% endnote %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.admin_password",
                      "config_spec.sql_user_management",
                      "config_spec.sql_database_management"
                    ]
                  },
                  "config_spec": {
                    "admin_password": "<пароль_пользователя_admin>",
                    "sql_user_management": <управление_пользователями_через_SQL>,
                    "sql_database_management": <управление_базами_данных_через_SQL>
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:

            * `config_spec.admin_password` — пароль пользователя `admin`, с помощью которого осуществляется управление.
            * `config_spec.sql_user_management` — если нужно включить управление пользователями через SQL.
            * `config_spec.sql_database_management` — если нужно включить управление базами данных через SQL.

            В примере запроса включается и управление пользователями, и управление базами данных черех SQL.

        * `config_spec.admin_password` — пароль пользователя `admin`.
        * `config_spec.sql_user_management` — режим управления пользователями через SQL: `true` или `false`.
        * `config_spec.sql_database_management` — режим управления базами данных через SQL: `true` или `false`. Необходимо, чтобы был включен режим управления пользователями через SQL.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**:

     * (Опционально) Задайте настройки [автоматического увеличения размера хранилища](../concepts/storage.md#autoscaling) {{ CH }}:

       * В поле **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** выберите один или оба порога:
         * **{{ ui-key.yacloud.mdb.cluster.field_plannedUsageThreshold }}** — порог для планового увеличения. При его достижении размер хранилища увеличивается во время ближайшего [окна обслуживания](../concepts/maintenance.md#maintenance-window).
           
           Для планового увеличения необходимо настроить расписание [окна обслуживания](../concepts/maintenance.md#maintenance-window).
       
         * **{{ ui-key.yacloud.mdb.cluster.field_emergencyUsageThreshold }}** — порог для незамедлительного увеличения. При его достижении размер хранилища увеличивается немедленно.
       * Задайте пороговое значение (в процентах от общего размера хранилища). Если выбраны оба порога, значение для незамедлительного увеличения должно быть не меньше, чем для планового.
       * Задайте **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}**.

       Настройки автоматического увеличения размера хранилища, заданные для {{ CH }}, применяются ко всем существующим шардам. При добавлении нового шарда значения настроек берутся с самого старого шарда.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_service-settings }}** измените дополнительные настройки кластера:

     * **{{ ui-key.yacloud.mdb.forms.backup-window-start }}** — промежуток времени, в течение которого начинается резервное копирование кластера. Время указывается по UTC в 24-часовом формате. По умолчанию — `22:00 - 23:00` UTC.
     
     * **{{ ui-key.yacloud.mdb.forms.backup-retain-period }}** — время, в течение которого нужно хранить созданные автоматически резервные копии (в днях). Если для такой копии истекает срок хранения, то она удаляется. Значение по умолчанию — {{ mch-backup-retention }} дней. Подробнее см. в разделе [Резервные копии](../concepts/backup.md#storage).
     
         Изменение срока хранения затрагивает как новые автоматические резервные копии, так и уже существующие. Например, изначальный срок хранения был 7 дней, оставшееся время жизни отдельной автоматической резервной копии — 1 день. При увеличении срока хранения до 9 дней оставшееся время жизни этой резервной копии будет уже 3 дня.
     
     * **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../concepts/maintenance.md):
     
        * Чтобы разрешить проведение технического обслуживания в любое время, выберите пункт **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-anytime }}** (по умолчанию).
        * Чтобы указать предпочтительное время начала обслуживания, выберите пункт **{{ ui-key.yacloud.mdb.forms.value_maintenance-type-weekly }}** и укажите день недели и интервал времени по UTC. Например, можно выбрать время, когда кластер наименее загружен.
        
        Операции по техническому обслуживанию проводятся для включенных и выключенных кластеров. Они могут включать в себя: обновление СУБД, применение патчей и так далее.
     
     
     * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — аккаунт, от имени которого пользовательские программы могут управлять кластером. Подробнее см. в документации [{#T}](../security.md).
     
     * **{{ ui-key.yacloud.mdb.forms.label_disk-encryption }}** — опция включает шифрование диска [пользовательским ключом KMS](../../kms/concepts/key.md). Задайте ключ одним из способов:
     
        * Чтобы [создать](../../kms/operations/key.md#create) новый ключ, нажмите кнопку **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.
     
        * Чтобы использовать созданный ранее ключ, выберите его в поле **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}**.
     
        Подробнее о шифровании дисков см. в разделе [Хранилище](../concepts/storage.md#disk-encryption).
     
     
     * **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}** — опция разрешает анализировать данные из кластера в сервисе [{{ datalens-full-name }}](../../datalens/concepts/index.md).
     
     
     * **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** — опция разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}.
     
     
     
     
     * **{{ ui-key.yacloud.mdb.forms.additional-field-metrika }}** — опция разрешает [импортировать данные из AppMetrica](https://appmetrica.yandex.ru/docs/common/cloud/about.html) в кластер.
     
     * **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}** — включите эту опцию, чтобы разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md). Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).
     
     
     * **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** — включите эту опцию, чтобы разрешить доступ к кластеру из сервиса [{{ yq-full-name }}](../../query/concepts/index.md). Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).
     
     * **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}** — управляет защитой кластера от непреднамеренного удаления.
     
        Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-ch }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        
        ```bash
        {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
           --backup-window-start <время_начала_резервного_копирования> \
           --backup-retain-period-days <срок_хранения_автоматических_резервных_копий> \
           --datalens-access=<true_или_false> \
           --metrika-access=<true_или_false> \
           --serverless-access=<true_или_false> \
           --websql-access=<true_или_false> \
           --yandexquery-access=<true_или_false> \
           --deletion-protection \
           --disk-size-autoscaling clickhouse-disk-size-limit=<максимальный_размер_хранилища_ГБ>,`
                                  `clickhouse-planned-usage-threshold=<порог_для_планового_увеличения_в_процентах>,`
                                  `clickhouse-emergency-usage-threshold=<порог_для_незамедлительного_увеличения_в_процентах>,`
                                  `zookeeper-disk-size-limit=<максимальный_размер_хранилища_ГБ>,`
                                  `zookeeper-planned-usage-threshold=<порог_для_планового_увеличения_в_процентах>,`
                                  `zookeeper-emergency-usage-threshold=<порог_для_незамедлительного_увеличения_в_процентах> \
           --maintenance-window type=<тип_технического_обслуживания>,`
                               `day=<день_недели>,`
                               `hour=<час_дня>
        ```


    Вы можете изменить следующие настройки:

    * `--backup-window-start` — время начала резервного копирования кластера, задается по UTC в формате `HH:MM:SS`. Если время не задано, резервное копирование начнется в 22:00 UTC.

    * `--backup-retain-period-days` – срок хранения автоматических резервных копий (в днях).

    * `--datalens-access` — разрешает доступ из {{ datalens-name }}. Значение по умолчанию — `false`. Подробнее о настройке подключения см. в разделе [Подключение из {{ datalens-name }}](datalens-connect.md).

    
    * `--metrika-access` — разрешает [импорт данных из AppMetrika в кластер](https://appmetrica.yandex.ru/docs/common/cloud/about.html). Значение по умолчанию — `false`.

    * `--serverless-access` — разрешает доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md). Значение по умолчанию — `false`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).


    * `--websql-access` — разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}. Значение по умолчанию — `false`.


    * `--yandexquery-access=true` — разрешает доступ к кластеру из сервиса [{{ yq-full-name }}](../../query/concepts/index.md). Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Значение по умолчанию — `false`.

    * `--deletion-protection` — защита кластера от непреднамеренного удаления: `true` или `false`.

        Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

    * `--disk-size-autoscaling` — настройки автоматического увеличения размера хранилища:
        
        * `clickhouse-disk-size-limit` — максимальный размер хранилища {{ CH }}, в гигабайтах.
        
        * `clickhouse-planned-usage-threshold` — порог заполнения хранилища {{ CH }} в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
        
          Допустимые значения: от `0` до `100`.
        
        * `clickhouse-emergency-usage-threshold` — порог заполнения хранилища {{ CH }} в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
        
          Допустимые значения: от `0` до `100`.
        
        * `zookeeper-disk-size-limit` — максимальный размер хранилища {{ ZK }}, в гигабайтах.
        
        * `zookeeper-planned-usage-threshold` — порог заполнения хранилища {{ ZK }} в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
        
          Допустимые значения: от `0` до `100`.
        
        * `zookeeper-emergency-usage-threshold` — порог заполнения хранилища {{ ZK }} в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
        
          Допустимые значения: от `0` до `100`.
        
        {% note warning %}
        
        * Если заданы оба порога для {{ CH }}, значение `clickhouse-emergency-usage-threshold` должно быть не меньше `clickhouse-planned-usage-threshold`.
        
        * Если заданы оба порога для {{ ZK }}, значение `zookeeper-emergency-usage-threshold` должно быть не меньше `zookeeper-planned-usage-threshold`.
        
        * При использовании параметров `clickhouse-planned-usage-threshold` и `zookeeper-planned-usage-threshold` необходимо настроить [окно технического обслуживания](../concepts/maintenance.md).
        
        {% endnote %}
    
    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        * `anytime` (по умолчанию) — в любое время.
        * `weekly` — по расписанию. Для этого значения дополнительно укажите:
            * `day` — день недели: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
            * `hour` — порядковый номер часового интервала по UTC: от `1` до `24`.
        
              > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).


- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Чтобы изменить время начала резервного копирования, добавьте к описанию кластера {{ mch-name }} блок `backup_window_start`.

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          backup_window_start = {
            hours   = <час_начала_резервного_копирования>
            minutes = <минута_начала_резервного_копирования>
          }
          ...
        }
        ```

    1. Чтобы разрешить доступ к кластеру из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью {{ websql-full-name }}, измените значения соответствующих полей в блоке `access`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          access = {
            data_lens    = <доступ_из_{{ datalens-name }}>
            metrika      = <доступ_из_Метрики_и_AppMetrika>
            serverless   = <доступ_из_Cloud_Functions>
            web_sql      = <выполнение_SQL-запросов_из_консоли_управления>
            yandex_query = <доступ_из_Yandex_Query>
          }
          ...
        }
        ```

        Где:

        * `data_lens` — доступ из {{ datalens-name }}: `true` или `false`.
        * `metrika` — доступ из Метрики и AppMetrika: `true` или `false`.
        * `serverless` — доступ из {{ sf-name }}: `true` или `false`.
        * `yandex_query` — доступ из {{ yq-full-name }}: `true` или `false`.
        * `web_sql` — выполнение SQL-запросов из консоли управления: `true` или `false`.

    1. Чтобы настроить время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), добавьте к описанию кластера блок `maintenance_window`:
       
       ```hcl
       resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
         ...
         maintenance_window {
           type = "<тип_технического_обслуживания>"
           day  = "<день_недели>"
           hour = <час_дня>
         }
         ...
       }
       ```
       
       Где:
       
       * `type` — тип технического обслуживания. Принимает значения:
           * `ANYTIME` — в любое время.
           * `WEEKLY` — по расписанию.
       * `day` — день недели для типа `WEEKLY`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
       * `hour` — порядковый номер часового интервала по UTC для типа `WEEKLY`: от `1` до `24`.
       
         > Например, `1` соответствует интервалу с `00:00` до `01:00`, `5` — с `04:00` до `05:00`.

    1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          deletion_protection = <защита_кластера_от_удаления>
        }
        ```

        Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% note warning "Ограничения по времени" %}
    
    Провайдер {{ TF }} ограничивает время на выполнение операций с кластером {{ mch-name }}:
    
    * создание, в т. ч. путем восстановления из резервной копии, — 60 минут;
    * изменение — 90 минут;
    * удаление — 30 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
      ...
      timeouts = {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
        delete = "30m"   # 30 минут
      }
    }
    ```
    
    {% endcut %}
    
    {% endnote %}


- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            
            ```json
            {
              "updateMask": "<перечень_изменяемых_настроек>",
              "configSpec": {
                "backupWindowStart": {
                  "hours": "<часы>",
                  "minutes": "<минуты>",
                  "seconds": "<секунды>",
                  "nanos": "<наносекунды>"
                },
                "clickhouse": {
                  "diskSizeAutoscaling": {
                    "plannedUsageThreshold": "<порог_для_планового_увеличения_в_процентах>",
                    "emergencyUsageThreshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                    "diskSizeLimit": "<максимальный_размер_хранилища_в_байтах>"
                  }
                },
                "zookeeper": {
                  "diskSizeAutoscaling": {
                    "plannedUsageThreshold": "<порог_для_планового_увеличения_в_процентах>",
                    "emergencyUsageThreshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                    "diskSizeLimit": "<максимальный_размер_хранилища_в_байтах>"
                  }
                },
                "access": {
                  "dataLens": <доступ_из_{{ datalens-name }}>,
                  "webSql": <выполнение_SQL-запросов>,
                  "metrika": <импорт_данных_из_AppMetrica>,
                  "serverless": <доступ_из_{{ sf-full-name }}>,
                  "dataTransfer": <доступ_из_{{ data-transfer-full-name }}>,
                  "yandexQuery": <доступ_из_{{ yq-full-name }}>
                }    
              },
              "maintenanceWindow": {
                "anytime": {},
                "weeklyMaintenanceWindow": {
                  "day": "<день_недели>",
                  "hour": "<час_дня_по_UTC>"
                }
              },
              "deletionProtection": <защита_кластера_от_удаления>
            }
            ```


            Где:

            * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            * `configSpec.backupWindowStart` — время начала резервного копирования (UTC):
              
              * `hours` — часы в 24-часовом формате.
              * `minutes` — минуты.
              * `seconds` — секунды.
              * `nanos` — наносекунды.

            * `configSpec.access` — настройки, которые разрешают доступ к кластеру из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью {{ websql-full-name }}:

                * `dataLens` — разрешить доступ из {{ datalens-name }}: `true` или `false`. Значение по умолчанию — `false`. Подробнее о настройке подключения см. в разделе [Подключение из {{ datalens-name }}](datalens-connect.md).
                
                * `webSql` — разрешить [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}: `true` или `false`. Значение по умолчанию — `false`.
                
                
                * `metrika` — разрешить [импорт данных из AppMetrika в кластер](https://appmetrica.yandex.ru/docs/common/cloud/about.html): `true` или `false`. Значение по умолчанию — `false`.
                
                * `serverless` — разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md): `true` или `false`. Значение по умолчанию — `false`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).
                
                * `dataTransfer` — разрешить доступ к кластеру из сервиса [{{ data-transfer-full-name }}](../../data-transfer/concepts/index.md) в Serverless-режиме: `true` или `false`. Значение по умолчанию — `false`.
                
                    Это позволит через специальную сеть подключаться к {{ data-transfer-full-name }}, запущенному в {{ k8s }}. В результате будут быстрее выполняться, например, запуск и деактивация трансфера.
                
                
                * `yandexQuery` — разрешить доступ к кластеру из сервиса [{{ yq-full-name }}](../../query/concepts/index.md): `true` или `false`. Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Значение по умолчанию — `false`.

            * `configSpec.clickhouse.diskSizeAutoscaling` — настройки автоматического увеличения размера хранилища {{ CH }}:
            
                * `plannedUsageThreshold` — порог заполнения хранилища {{ CH }} в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
                
                  Допустимые значения: от `0` до `100`.
                
                * `emergencyUsageThreshold` — порог заполнения хранилища {{ CH }} в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
                
                  Допустимые значения: от `0` до `100`.
                
                * `diskSizeLimit` — максимальный размер хранилища {{ CH }}, в байтах.
                
                {% note warning %}
                
                * Если заданы оба порога, значение `emergencyUsageThreshold` должно быть не меньше `plannedUsageThreshold`.
                
                * При использовании параметра `plannedUsageThreshold` необходимо настроить [окно технического обслуживания](../concepts/maintenance.md).
                
                {% endnote %}
                
                Настройки автоматического увеличения размера хранилища, заданные для {{ CH }}, применяются ко всем существующим шардам. При добавлении нового шарда значения настройки берутся с самого старого шарда. Эти значения не сохраняются в конфигурации {{ CH }}.
                
                Чтобы посмотреть информацию о конкретном шарде, включая настройки автоматического увеличения размера хранилища, воспользуйтесь методом [Cluster.GetShard](../api-ref/Cluster/getShard.md) и передайте в запросе идентификатор кластера и имя шарда.
                
                Идентификатор кластера можно получить [со списком кластеров](cluster-list.md#list-clusters) в каталоге.
                
                Имя шарда можно получить [со списком шардов](shards.md#list-shards) в кластере.
            
            * `configSpec.zookeeper.diskSizeAutoscaling` — настройки автоматического увеличения размера хранилища {{ ZK }}:
                      
                * `plannedUsageThreshold` — порог заполнения хранилища {{ ZK }} в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
                                      
                  Допустимые значения: от `0` до `100`.
                                      
                * `emergencyUsageThreshold` — порог заполнения хранилища {{ ZK }} в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
                                      
                  Допустимые значения: от `0` до `100`.
                                      
                * `diskSizeLimit` — максимальный размер хранилища {{ ZK }}, в байтах.
                                      
                {% note warning %}
                                      
                * Если заданы оба порога, значение `emergencyUsageThreshold` должно быть не меньше `plannedUsageThreshold`.
                                      
                * При использовании параметра `plannedUsageThreshold` необходимо настроить [окно технического обслуживания](../concepts/maintenance.md).
                                      
                {% endnote %}
            
            * `maintenanceWindow` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Выберите один из вариантов:

                * `anytime` — (по умолчанию) — в любое время.
                * `weeklyMaintenanceWindow` — по расписанию:
                    * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                    * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

            * `deletionProtection` — защита кластера от непреднамеренного удаления: `true` или `false`. Значение по умолчанию — `false`.

                Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

        1. Выполните запрос:

            ```bash
            curl \
              --request PATCH \
              --header "Authorization: Bearer $IAM_TOKEN" \
              --header "Content-Type: application/json" \
              --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
              --data '@body.json'
            ```

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
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
        
        {% endnote %}

        1. Создайте файл `body.json` и добавьте в него следующее содержимое:

            
            ```json
            {
              "cluster_id": "<идентификатор_кластера>",
              "update_mask": {
                "paths": [
                  <перечень_изменяемых_настроек>
                ]
              },
              "config_spec": {
                "backup_window_start": {
                  "hours": "<часы>",
                  "minutes": "<минуты>",
                  "seconds": "<секунды>",
                  "nanos": "<наносекунды>"
                },
                "clickhouse": {
                  "disk_size_autoscaling": {
                    "planned_usage_threshold": "<порог_для_планового_увеличения_в_процентах>",
                    "emergency_usage_threshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                    "disk_size_limit": "<максимальный_размер_хранилища_в_байтах>"
                  }
                },
                "zookeeper": {
                  "disk_size_autoscaling": {
                    "planned_usage_threshold": "<порог_для_планового_увеличения_в_процентах>",
                    "emergency_usage_threshold": "<порог_для_незамедлительного_увеличения_в_процентах>",
                    "disk_size_limit": "<максимальный_размер_хранилища_в_байтах>"
                  }
                },
                "access": {
                  "data_lens": <доступ_из_{{ datalens-name }}>,
                  "web_sql": <выполнение_SQL-запросов>,
                  "metrika": <импорт_данных_из_AppMetrica>,
                  "serverless": <доступ_из_{{ sf-full-name }}>,
                  "data_transfer": <доступ_из_{{ data-transfer-full-name }}>,
                  "yandex_query": <доступ_из_{{ yq-full-name }}>
                }
              },
              "maintenance_window": {
                "anytime": {},
                "weekly_maintenance_window": {
                  "day": "<день_недели>",
                  "hour": "<час_дня_по_UTC>"
                }
              },
              "deletion_protection": <защита_кластера_от_удаления>
            }
            ```


            Где:

            * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            * `config_spec.backup_window_start` — время начала резервного копирования (UTC):
              
              * `hours` — часы в 24-часовом формате.
              * `minutes` — минуты.
              * `seconds` — секунды.
              * `nanos` — наносекунды.

            * `config_spec.access` — настройки, которые разрешают доступ к кластеру из других сервисов и [выполнение SQL-запросов из консоли управления](web-sql-query.md) с помощью {{ websql-full-name }}:

                * `data_lens` — разрешить доступ из {{ datalens-name }}: `true` или `false`. Значение по умолчанию — `false`. Подробнее о настройке подключения см. в разделе [Подключение из {{ datalens-name }}](datalens-connect.md).
                
                * `web_sql` — разрешить [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}: `true` или `false`. Значение по умолчанию — `false`.
                
                
                * `metrika` — разрешить [импорт данных из AppMetrika в кластер](https://appmetrica.yandex.ru/docs/common/cloud/about.html): `true` или `false`. Значение по умолчанию — `false`.
                
                * `serverless` — разрешить доступ к кластеру из сервиса [{{ sf-full-name }}](../../functions/concepts/index.md): `true` или `false`. Значение по умолчанию — `false`. Подробнее о настройке доступа см. в документации [{{ sf-name }}](../../functions/operations/database-connection.md).
                
                * `data_transfer` — разрешить доступ к кластеру из сервиса [{{ data-transfer-full-name }}](../../data-transfer/concepts/index.md) в Serverless-режиме: `true` или `false`. Значение по умолчанию — `false`.
                
                    Это позволит через специальную сеть подключаться к {{ data-transfer-full-name }}, запущенному в {{ k8s }}. В результате будут быстрее выполняться, например, запуск и деактивация трансфера.
                
                
                * `yandex_query` — разрешить доступ к кластеру из сервиса [{{ yq-full-name }}](../../query/concepts/index.md): `true` или `false`. Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Значение по умолчанию — `false`.

            * `config_spec.clickhouse.disk_size_autoscaling` — настройки автоматического увеличения размера хранилища {{ CH }}:
            
                * `planned_usage_threshold` — порог заполнения хранилища {{ CH }} в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
                                      
                  Допустимые значения: от `0` до `100`.
                                      
                * `emergency_usage_threshold` — порог заполнения хранилища {{ CH }} в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
                                      
                  Допустимые значения: от `0` до `100`.
                                      
                * `disk_size_limit` — максимальный размер хранилища {{ CH }}, в байтах.
                                      
                {% note warning %}
                                      
                * Если заданы оба порога, значение `emergency_usage_threshold` должно быть не меньше `planned_usage_threshold`.
                                      
                * При использовании параметра `planned_usage_threshold` необходимо настроить [окно технического обслуживания](../concepts/maintenance.md).
                                      
                {% endnote %}
                                      
                Настройки автоматического увеличения размера хранилища, заданные для {{ CH }}, применяются ко всем существующим шардам. При добавлении нового шарда значения настройки берутся с самого старого шарда. Эти значения не сохраняются в конфигурации {{ CH }}.
                                      
                Чтобы посмотреть информацию о конкретном шарде, включая настройки автоматического увеличения размера хранилища, воспользуйтесь методом [ClusterService.GetShard](../api-ref/grpc/Cluster/getShard.md) и передайте в запросе идентификатор кластера и имя шарда.
                                      
                Идентификатор кластера можно получить [со списком кластеров](cluster-list.md#list-clusters) в каталоге.
                
                Имя шарда можно получить [со списком шардов](shards.md#list-shards) в кластере.

            * `config_spec.zookeeper.disk_size_autoscaling` — настройки автоматического увеличения размера хранилища {{ ZK }}:
                      
                * `planned_usage_threshold` — порог заполнения хранилища {{ ZK }} в процентах, при достижении которого оно будет увеличено в следующее окно обслуживания. По умолчанию — `0` (автоматическое увеличение отключено).
                                      
                  Допустимые значения: от `0` до `100`.
                                      
                * `emergency_usage_threshold` — порог заполнения хранилища {{ ZK }} в процентах, при достижении которого оно будет увеличено незамедлительно. По умолчанию — `0` (автоматическое увеличение отключено).
                                      
                  Допустимые значения: от `0` до `100`.
                                      
                * `disk_size_limit` — максимальный размер хранилища {{ ZK }}, в байтах.
                                      
                {% note warning %}
                                      
                * Если заданы оба порога, значение `emergency_usage_threshold` должно быть не меньше `planned_usage_threshold`.
                                      
                * При использовании параметра `planned_usage_threshold` необходимо настроить [окно технического обслуживания](../concepts/maintenance.md).
                                      
                {% endnote %}

            * `maintenance_window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров). Выберите один из вариантов:

                * `anytime` — (по умолчанию) — в любое время.
                * `weekly_maintenance_window` — по расписанию:
                    * `day` — день недели в формате `DDD`: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT` или `SUN`.
                    * `hour` — час дня по UTC в формате `HH`: от `1` до `24`.

            * `deletion_protection` — защита кластера от непреднамеренного удаления: `true` или `false`. Значение по умолчанию — `false`.

                Включенная защита кластера от удаления не помешает удалить пользователя или базу данных, а также подключиться вручную и удалить содержимое базы данных.

            Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        1. Выполните запрос:

            ```bash
            grpcurl \
              -format json \
              -import-path ~/cloudapi/ \
              -import-path ~/cloudapi/third_party/googleapis/ \
              -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
              -rpc-header "Authorization: Bearer $IAM_TOKEN" \
              -d @ \
              {{ api-host-mdb }}:{{ port-https }} \
              yandex.cloud.mdb.clickhouse.v1.ClusterService.Update \
              < body.json
            ```

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}


### {{ connection-manager-name }} {#conn-man}

Если в кластере не включена интеграция с сервисом {{ connection-manager-name }}, включите опцию **{{ ui-key.yacloud.mdb.forms.additional-field-connman }}**. Она доступна только в [консоли управления]({{ link-console-main }}).

Для каждого пользователя БД будут созданы:

* [Подключение](../../metadata-hub/concepts/connection-manager.md) {{ connection-manager-name }} с информацией о соединении с БД.

* [Секрет {{ lockbox-name }}](../../metadata-hub/concepts/secret.md), в котором хранится пароль пользователя. Хранение паролей в сервисе {{ lockbox-name }} обеспечивает их безопасность.

  Подключение и секрет создаются для каждого нового пользователя БД. Чтобы увидеть все подключения, на странице кластера выберите вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.

  Для просмотра информации о подключении требуется роль `connection-manager.viewer`. Вы можете [настраивать доступ к подключениям в {{ connection-manager-name }}](../../metadata-hub/operations/connection-access.md).

  {% note info %}

  Использование сервиса {{ connection-manager-name }} и секретов, созданных с его помощью, не тарифицируется.

  {% endnote %}


## Переместить кластер {#move-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке кластера, который вы хотите переместить.
    1. Выберите пункт **{{ ui-key.yacloud.common.move }}**.
    1. Выберите каталог, в который вы хотите переместить кластер.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы переместить кластер:

    1. Посмотрите описание команды CLI для перемещения кластера:

        ```bash
        {{ yc-mdb-ch }} cluster move --help
        ```

    1. Укажите каталог назначения в команде перемещения кластера:

        ```bash
        {{ yc-mdb-ch }} cluster move <имя_или_идентификатор_кластера> \
           --destination-folder-name=<имя_каталога_назначения>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените или добавьте в описании кластера {{ mch-name }} значение параметра `folder_id`:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          folder_id = "<идентификатор_каталога_назначения>"
        }
        ```

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mch }}).

    {% note warning "Ограничения по времени" %}
    
    Провайдер {{ TF }} ограничивает время на выполнение операций с кластером {{ mch-name }}:
    
    * создание, в т. ч. путем восстановления из резервной копии, — 60 минут;
    * изменение — 90 минут;
    * удаление — 30 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
      ...
      timeouts = {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
        delete = "30m"   # 30 минут
      }
    }
    ```
    
    {% endcut %}
    
    {% endnote %}


- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Move](../api-ref/Cluster/move.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>:move' \
            --data '{
                      "destinationFolderId": "<идентификатор_каталога_назначения>"
                    }'
        ```

        Где `destinationFolderId` — идентификатор каталога назначения, в который нужно переместить кластер. Этот идентификатор можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/move.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.Move](../api-ref/grpc/Cluster/move.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "destination_folder_id": "<идентификатор_каталога_назначения>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Move
        ```

        Где `destination_folder_id` — идентификатор каталога назначения, в который нужно переместить кластер. Этот идентификатор можно запросить со [списком каталогов в облаке](../../resource-manager/operations/folder/get-id.md).

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/move.md#yandex.cloud.operation.Operation).

{% endlist %}


## Изменить группы безопасности {#change-sg-set}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится кластер.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите группы безопасности для сетевого трафика кластера.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-ch }} cluster update --help
      ```

  1. Укажите нужные группы безопасности в команде изменения кластера:

      ```bash
      {{ yc-mdb-ch }} cluster update <имя_кластера> \
         --security-group-ids <список_идентификаторов_групп_безопасности>
      ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените значение параметра `security_group_ids` в описании кластера:

        ```hcl
        resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
          ...
          security_group_ids = [ <список_идентификаторов_групп_безопасности_кластера> ]
        }
        ```

    1. Проверьте корректность настроек.

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

    {% note warning "Ограничения по времени" %}
    
    Провайдер {{ TF }} ограничивает время на выполнение операций с кластером {{ mch-name }}:
    
    * создание, в т. ч. путем восстановления из резервной копии, — 60 минут;
    * изменение — 90 минут;
    * удаление — 30 минут.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
      ...
      timeouts = {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
        delete = "30m"   # 30 минут
      }
    }
    ```
    
    {% endcut %}
    
    {% endnote %}


- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "securityGroupIds",
                      "securityGroupIds": [
                        <список_идентификаторов_групп_безопасности>
                      ]
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            В данном случае указан только один параметр: `securityGroupIds`.

        * `securityGroupIds` — массив строк. Каждая строка — идентификатор группы безопасности.

            {% note warning %}

            Список назначенных кластеру групп безопасности будет полностью перезаписан списком, переданным в параметре `securityGroupIds`.

            Перед выполнением запроса убедитесь, что вы включили в этот список все нужные идентификаторы групп безопасности, в том числе существующие.

            {% endnote %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
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
        
        {% endnote %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "security_group_ids"
                    ]
                  },
                  "security_group_ids": [
                    <список_идентификаторов_групп_безопасности>
                  ]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            В данном случае указан только один параметр: `security_group_ids`.

        * `security_group_ids` — массив строк. Каждая строка — идентификатор группы безопасности.

            {% note warning %}

            Список назначенных кластеру групп безопасности будет полностью перезаписан списком, переданным в параметре `security_group_ids`.

            Перед выполнением запроса убедитесь, что вы включили в этот список все нужные идентификаторы групп безопасности, в том числе существующие.

            {% endnote %}

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}


## Изменить настройки гибридного хранилища {#change-hybrid-storage}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы изменить [настройки гибридного хранилища](../concepts/storage.md#hybrid-storage-settings):

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-ch }} cluster update --help
      ```

  1. Если гибридное хранилище в кластере выключено, включите его:

      ```bash
      {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
          --cloud-storage=true
      ```

      {% note info %}
      
      Включенное однажды гибридное хранилище нельзя отключить.
      
      {% endnote %}

  1. Передайте список настроек, которые хотите изменить:

      ```bash
      {{ yc-mdb-ch }} cluster update <имя_или_идентификатор_кластера> \
          --cloud-storage-data-cache=<хранение_файлов> \
          --cloud-storage-data-cache-max-size=<объем_памяти_в_байтах> \
          --cloud-storage-move-factor=<доля_свободного_места> \
          --cloud-storage-prefer-not-to-merge=<слияние_кусков_данных>
      ```

      Вы можете изменить следующие настройки:

      * `--cloud-storage-data-cache` — разрешает временное хранение файлов в кластерном хранилище. По умолчанию — `true` (разрешено).
      * `--cloud-storage-data-cache-max-size` — определяет максимальный объем памяти (в байтах), выделяемый в кластерном хранилище для временного хранения файлов. Если значение параметра не задано, максимальный объем памяти по умолчанию равен половине объема кластерного хранилища.
      * `--cloud-storage-move-factor` — устанавливает минимальную долю свободного места в кластерном хранилище. Если доля свободного места меньше этого значения, данные переносятся в {{ objstorage-full-name }}. Минимальное значение — `0`, максимальное — `1`, по умолчанию — `0.01`.
      * `--cloud-storage-prefer-not-to-merge` — отключает [слияние кусков данных]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/custom-partitioning-key) в кластерном и объектном хранилищах. Чтобы отключить слияние, укажите значение `true` или передайте параметр без значения. Чтобы оставить слияние включенным, укажите значение `false` или не передавайте параметр в команде CLI при создании кластера.

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.Update](../api-ref/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "<перечень_изменяемых_настроек>",
                      "configSpec": {
                        "cloudStorage": {
                          "enabled": <использование_гибридного_хранилища>,
                          "moveFactor": "<доля_свободного_места>",
                          "dataCacheEnabled": <временное_хранение_файлов>,
                          "dataCacheMaxSize": "<максимальный_объем_памяти_для_хранения_файлов>",
                          "preferNotToMerge": <отключение_слияния_кусков_данных>
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

        * `configSpec.cloudStorage` — настройки гибридного хранилища:

            * `enabled` — включить гибридное хранилище в кластере, если оно выключено: `true` или `false`. Значение по умолчанию — `false` (выключено).
            
                {% note info %}
                
                Включенное однажды гибридное хранилище нельзя отключить.
                
                {% endnote %}
            
            * `moveFactor` — минимальная доля свободного места в кластерном хранилище. Если доля свободного места меньше этого значения, данные переносятся в {{ objstorage-full-name }}.
            
                Минимальное значение — `0`, максимальное — `1`, по умолчанию — `0.01`.
            
            * `dataCacheEnabled` — разрешить временное хранение файлов в кластерном хранилище: `true` или `false`.
            
                По умолчанию — `true` (разрешено).
            
            * `dataCacheMaxSize` — максимальный объем памяти (в байтах), выделяемый в кластерном хранилище для временного хранения файлов.
                
                Если значение параметра не задано, максимальный объем памяти по умолчанию равен половине объема кластерного хранилища.
            
            * `preferNotToMerge` — отключить [слияние кусков данных]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/custom-partitioning-key) в кластерном и объектном хранилищах: `true` или `false`.
            
                Чтобы отключить слияние, укажите значение `true`. Чтобы оставить слияние включенным, укажите значение `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#yandex.cloud.operation.operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService.Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
        
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
        
        {% endnote %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      <перечень_изменяемых_настроек>
                    ]
                  },
                  "config_spec": {
                    "cloud_storage": {
                      "enabled": <использование_гибридного_хранилища>,
                      "move_factor": "<доля_свободного_места>",
                      "data_cache_enabled": <временное_хранение_файлов>,
                      "data_cache_max_size": "<максимальный_объем_памяти_для_хранения_файлов>",
                      "prefer_not_to_merge": <отключение_слияния_кусков_данных>
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.Update
        ```

        Где:
        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

        * `config_spec.cloud_storage` — настройки гибридного хранилища:

            * `enabled` — включить гибридное хранилище в кластере, если оно выключено: `true` или `false`. Значение по умолчанию — `false` (выключено).
            
                {% note info %}
                
                Включенное однажды гибридное хранилище нельзя отключить.
                
                {% endnote %}
            
            * `move_factor` — минимальная доля свободного места в кластерном хранилище. Если доля свободного места меньше этого значения, данные переносятся в {{ objstorage-full-name }}.
            
                Минимальное значение — `0`, максимальное — `1`, по умолчанию — `0.01`.
            
            * `data_cache_enabled` — разрешить временное хранение файлов в кластерном хранилище: `true` или `false`.
            
                По умолчанию — `true` (разрешено).
            
            * `data_cache_max_size` — максимальный объем памяти (в байтах), выделяемый в кластерном хранилище для временного хранения файлов.
            
                Если значение параметра не задано, максимальный объем памяти по умолчанию равен половине объема кластерного хранилища.
            
            * `prefer_not_to_merge` — отключить [слияние кусков данных]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/custom-partitioning-key) в кластерном и объектном хранилищах: `true` или `false`.
            
                Чтобы отключить слияние, укажите значение `true`. Чтобы оставить слияние включенным, укажите значение `false`.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._