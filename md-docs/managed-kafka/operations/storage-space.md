# Управление дисковым пространством в кластере {{ mkf-name }}

Когда [хранилище](../concepts/storage.md) заполнено на 97% или больше, хост автоматически переходит в режим read-only. Чтобы избежать проблем с операциями записи в топик, воспользуйтесь одним из способов:


* [Настройте алерты в {{ monitoring-full-name }}](#set-alert), чтобы отслеживать степень заполнения хранилища.


* [Увеличьте размер хранилища](#change-disk-size), чтобы снять режим read-only автоматически.
* [Настройте автоматическое увеличение размера хранилища](#disk-size-autoscale), чтобы предотвратить ситуации, когда место на диске заканчивается и хост переходит в режим read-only.


## Настроить алерты в {{ monitoring-full-name }} {#set-alert}

1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. [Создайте канал уведомлений](../../monitoring/operations/alert/create-channel.md).
1. [Создайте алерт](../../monitoring/operations/alert/create-alert.md) со следующими параметрами:

    1. **{{ ui-key.yacloud_monitoring.alert.section_metrics }}** — задайте параметры метрики:

        * Облако.
        * Каталог.
        * Сервис **{{ ui-key.yacloud_monitoring.services.label_managed-kafka }}**.
        * Идентификатор кластера {{ mkf-name }}.

            Идентификатор можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

        * Метка `disk.free_bytes`.

    1. **{{ ui-key.yacloud_monitoring.alert.title_conditions }}** — задайте условие для заполнения свободного дискового пространства, при котором сработает алерт:

        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}` (минимальное значение метрики за период).
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}`.
        * **{{ ui-key.yacloud_monitoring.alert.status_warn }}** — `95` (95% от размера хранилища).
        * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** — `90` (90% от размера хранилища).
        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** — желаемый период, с которым будет обновляться значение метрики.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.time-shift }}** — предпочтительный сдвиг по времени назад в секундах. Позволяет исключить срабатывания алерта, когда в нем указано несколько метрик и они собираются с разным интервалом. Подробнее о задержке вычисления в [документации {{ monitoring-full-name }}](../../monitoring/concepts/alerting/alert.md#evaluation-delay).

    1. **Уведомления** — добавьте созданный ранее канал уведомлений.


## Увеличить размер хранилища {#change-disk-size}

Проверьте, что в облаке достаточно квот для увеличения хранилища. Откройте страницу [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) для облака и убедитесь, что в секции **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}** в строке **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-mdb.hdd.size }}** или **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-mdb.ssd.size }}** есть квота на объем хранилищ.

{% list tabs group=instructions %}

* Консоль управления {#console}

    Чтобы увеличить размер хранилища для кластера:

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. В строке с нужным кластером нажмите ![image](../../_assets/console-icons/ellipsis.svg), затем выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. Измените настройки в блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**.

        Тип диска для кластера {{ KF }} нельзя изменить после создания.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

* CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы увеличить размер хранилища для хостов:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Чтобы изменить объем хранилища хостов-брокеров, выполните команду:

        ```bash
        {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
           --disk-size <объем_хранилища>
        ```

        Если не указаны единицы размера, то используются гигабайты.

    1. Чтобы изменить объем хранилища хостов {{ ZK }}, выполните команду:

        ```bash
        {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
           --zookeeper-disk-size <размер_диска>
        ```

        Если не указаны единицы размера, то используются гигабайты.

    Тип диска для кластера {{ KF }} нельзя изменить после создания.

* {{ TF }} {#tf}

  Чтобы увеличить размер хранилища для кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        Как создать такой файл, описано в разделе [{#T}](cluster-create.md).

    1. Измените в описании кластера {{ mkf-name }} значение параметра `disk_size` в блоках `kafka.resources` и `zookeeper.resources` для хостов {{ KF }} и {{ ZK }} соответственно:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          kafka {
            resources {
              disk_size = <размер_хранилища_ГБ>
              ...
            }
            ...
          }
          zookeeper {
            resources {
              disk_size = <размер_хранилища_ГБ>
              ...
            }
          }
        }
        ```

        Тип диска для кластера {{ KF }} нельзя изменить после создания.

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

    Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% note warning "Ограничения по времени" %}
    
    Провайдер {{ TF }} ограничивает время на выполнение всех операций с кластером {{ mkf-name }} 60 минутами.
    
    Операции, длящиеся дольше указанного времени, прерываются.
    
    {% cut "Как изменить эти ограничения?" %}
    
    Добавьте к описанию кластера блок `timeouts`, например:
    
    ```hcl
    resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
      ...
      timeouts {
        create = "1h30m" # Полтора часа
        update = "2h"    # 2 часа
        delete = "30m"   # 30 минут
      }
    }
    ```
    
    {% endcut %}
    
    {% endnote %}

* REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.kafka.resources.diskSize,configSpec.zookeeper.resources.diskSize",
                      "configSpec": {
                        "kafka": {
                          "resources": {
                            "diskSize": "<размер_хранилища_байт>"
                          }
                        },
                        "zookeeper": {
                          "resources": {
                            "diskSize": "<размер_хранилища_байт>"
                          }
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:
            * `configSpec.kafka.resources.diskSize` — если нужно изменить размер хранилища хостов-брокеров.
            * `configSpec.zookeeper.resources.diskSize` — если нужно изменить размер хранилища хостов {{ ZK }}. Применяется только для кластеров с версией {{ KF }} 3.5.
        * `configSpec.kafka.resources.diskSize` – размер хранилища хостов-брокеров в байтах.
        * `configSpec.zookeeper.resources.diskSize` — размер хранилища хостов {{ ZK }} в байтах. Применяется только для кластеров с версией {{ KF }} 3.5.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#responses).

* gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.kafka.resources.disk_size",
                      "config_spec.zookeeper.resources.disk_size"
                    ]
                  },
                  "config_spec": {
                    "kafka": {
                      "resources": {
                        "disk_size": "<размер_хранилища_байт>"
                      }
                    },
                    "zookeeper": {
                      "resources": {
                        "disk_size": "<размер_хранилища_байт>"
                      }
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:
            * `config_spec.kafka.resources.disk_size` — если нужно изменить размер хранилища хостов-брокеров.
            * `config_spec.brokers_count` — если нужно изменить размер хранилища хостов {{ ZK }}. Применяется только для кластеров с версией {{ KF }} 3.5.
        * `config_spec.kafka.resources.disk_size` — размер хранилища хостов-брокеров в байтах.
        * `config_spec.zookeeper.resources.disk_size` — размер хранилища хостов {{ ZK }} в байтах. Применяется только для кластеров с версией {{ KF }} 3.5.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Настроить автоматическое увеличение размера хранилища {#disk-size-autoscale}

Чтобы место на диске кластера не заканчивалось и хосты не переходили в режим read-only, настройте [автоматическое увеличение размера хранилища](../concepts/storage.md#auto-rescale).

Проверьте, что в облаке достаточно квот для увеличения хранилища. Откройте страницу [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) для облака и убедитесь, что в секции **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}** в строке **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-mdb.hdd.size }}** или **{{ ui-key.yacloud.iam.cloud.quotas.label_quota-name-mdb.ssd.size }}** есть квота на объем хранилищ.


{% note warning %}

Размер хранилища нельзя уменьшить после автоматического увеличения.

{% endnote %}


{% list tabs group=instructions %}

* Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в нужный каталог.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}** задайте [пороги заполненности](../concepts/storage.md#auto-rescale) хранилища, при достижении которых его размер будет увеличиваться: 
    
        1. В поле **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** выберите один или оба порога:
            * **{{ ui-key.yacloud.mdb.cluster.field_plannedUsageThreshold }}** — порог для планового увеличения. Когда он достигнут, объем хранилища увеличивается во время ближайшего [окна обслуживания](../concepts/maintenance.md#maintenance-window).
            * **{{ ui-key.yacloud.mdb.cluster.field_emergencyUsageThreshold }}** — порог для незамедлительного увеличения. Когда он достигнут, объем хранилища увеличивается немедленно.         
        1. Задайте пороговое значение (в процентах от общего объема хранилища). Если выбраны оба порога, значение для незамедлительного увеличения должно быть выше, чем для планового.
        1. Задайте **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}**.        

* CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы настроить автоматическое увеличение размера хранилища:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Укажите максимальный размер хранилища и условия для его увеличения в команде изменения кластера:

        ```bash
        {{ yc-mdb-kf }} cluster update <идентификатор_или_имя_кластера> \
           --disk-size-autoscaling planned-usage-threshold=<процент_для_планового_увеличения>,`
                                  `emergency-usage-threshold=<процент_для_незамедлительного_увеличения>,`
                                  `disk-size-limit=<максимальный_размер_хранилища_в_байтах>
        ```

        Где:
        
        * `planned-usage-threshold` — процент заполнения хранилища, при котором хранилище будет увеличено в следующее [окно технического обслуживания](../concepts/maintenance.md#maintenance-window).
        
           Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено).
        
           Если вы задали этот параметр, настройте расписание технического обслуживания.
        
        * `emergency-usage-threshold` — процент заполнения хранилища, при котором хранилище будет увеличено немедленно.
        
           Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено). Должно быть не меньше значения `planned-usage-threshold`.
        
        * `disk-size-limit` — максимальный размер хранилища в байтах, который может быть установлен при достижении одного из заданных процентов заполнения.
        
           Если указать значение `0`, автоматическое увеличение размера хранилища будет отключено.

* REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        {% note warning %}
        
        Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
        
        {% endnote %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-kafka/v1/clusters/<идентификатор_кластера>' \
            --data '{
                      "updateMask": "configSpec.diskSizeAutoscaling.plannedUsageThreshold,configSpec.diskSizeAutoscaling.plannedUsageThreshold,configSpec.diskSizeAutoscaling.plannedUsageThreshold",
                      "configSpec": {
                        "diskSizeAutoscaling": {
                          "plannedUsageThreshold": "<процент_для_планового_увеличения>",
                          "emergencyUsageThreshold": "<процент_для_незамедлительного_увеличения>",
                          "diskSizeLimit": "<максимальный_размер_хранилища_в_байтах>"
                        }
                      }
                    }'
        ```

        Где:

        * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

            Укажите нужные параметры:
            * `configSpec.diskSizeAutoscaling.plannedUsageThreshold` — если нужно изменить процент заполнения хранилища для его планового увеличения.
            * `configSpec.diskSizeAutoscaling.emergencyUsageThreshold` — если нужно изменить процент заполнения хранилища для его внепланового увеличения.
            * `configSpec.diskSizeAutoscaling.diskSizeLimit` — если нужно изменить максимальный размер хранилища при его автоматическом расширении.

        * `plannedUsageThreshold` – процент заполнения хранилища, при котором хранилище будет увеличено в следующее [окно обслуживания](../concepts/maintenance.md#maintenance-window).
        
            Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено).
        
            Если вы задали этот параметр, настройте расписание окна технического обслуживания.
        
        * `emergencyUsageThreshold` — процент заполнения хранилища, при котором хранилище будет увеличено немедленно.
        
          Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено). Должно быть не меньше значения `plannedUsageThreshold`.
        
        * `diskSizeLimit` – максимальный размер хранилища (в байтах), который может быть установлен при достижении одного из заданных процентов заполнения.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#responses).

* gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        ```bash
        export IAM_TOKEN="<IAM-токен>"
        ```

    1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
       
       ```bash
       cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
       ```
       
       Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.

    1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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
            -proto ~/cloudapi/yandex/cloud/mdb/kafka/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "update_mask": {
                    "paths": [
                      "config_spec.disk_size_autoscaling.planned_usage_threshold",
                      "config_spec.disk_size_autoscaling.emergency_usage_threshold",
                      "config_spec.disk_size_autoscaling.disk_size_limit"
                    ]
                  },
                  "config_spec": {
                    "disk_size_autoscaling": {
                        "planned_usage_threshold": "<процент_для_планового_увеличения>",
                        "emergency_usage_threshold": "<процент_для_незамедлительного_увеличения>",
                        "disk_size_limit": "<максимальный_размер_хранилища_в_байтах>"
                    }
                  }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.kafka.v1.ClusterService.Update
        ```

        Где:

        * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

            Укажите нужные параметры:
            * `config_spec.disk_size_autoscaling.planned_usage_threshold` — если нужно изменить процент заполнения хранилища для его планового увеличения.
            * `config_spec.disk_size_autoscaling.emergency_usage_threshold` — если нужно изменить процент заполнения хранилища для его внепланового увеличения.
            * `config_spec.disk_size_autoscaling.disk_size_limit` — если нужно изменить максимальный размер хранилища при его автоматическом расширении.

        * `planned_usage_threshold` – процент заполнения хранилища, при котором хранилище будет увеличено в следующее [окно обслуживания](../concepts/maintenance.md#maintenance-window).
        
            Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено).
        
            Если вы задали этот параметр, настройте расписание окна технического обслуживания.
        
        * `emergency_usage_threshold` — процент заполнения хранилища, при котором хранилище будет увеличено немедленно.
        
          Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено). Должно быть не меньше значения `planned_usage_threshold`.
        
        * `disk_size_limit` – максимальный размер хранилища (в байтах), который может быть установлен при достижении одного из заданных процентов заполнения.

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Список доступных классов хостов с их идентификаторами был получен ранее.

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation).

{% endlist %}

Если заданный порог достигнут, размер хранилища увеличивается по-разному в зависимости от типа диска:

* Для сетевых HDD- и SSD-дисков — на большее из двух значений: 20 ГБ или 20% от текущего размера диска.
* Для нереплицируемых SSD-дисков — на 93 ГБ.
* Для локальных SSD-дисков, в кластере на платформе:

    * **Intel Cascade Lake** — на 100 ГБ.
    * **Intel Ice Lake** или **AMD Zen 4** — на {{ local-ssd-v3-step }}.


Если порог срабатывания достигнут повторно, размер хранилища будет автоматически увеличиваться, пока не достигнет заданного максимума. После этого вы можете задать новый максимальный размер хранилища вручную.


{% note warning %}

Размер хранилища нельзя уменьшить после автоматического увеличения.

{% endnote %}