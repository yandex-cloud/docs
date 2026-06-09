# Обновление {{ k8s }}

{% note info %}

Перед обновлением автоматически выполняется предварительная проверка (_preflight check_) совместимости объектов или конфигураций с новой версией {{ k8s }}. Если в результате выявляются несовместимые объекты или конфигурации, обновление завершится ошибкой с указанием несовместимых ресурсов и описанием.

{% endnote %}

Для {{ managed-k8s-name }} доступно как автоматическое, так и ручное обновление [кластера](../concepts/index.md#kubernetes-cluster) и [группы узлов](../concepts/index.md#node-group). Вы можете в любое время запросить обновление кластера {{ managed-k8s-name }} или его узлов вручную до последней поддерживаемой [версии](../concepts/release-channels-and-updates.md). Ручные обновления обходят любые настроенные окна обслуживания и исключения обслуживания.

При обновлении мажорной версии {{ k8s }} сначала обновите кластер {{ managed-k8s-name }}, потом его группу узлов.

Вы можете изменить политику обновления [кластера {{ managed-k8s-name }}](#cluster-auto-upgrade) или [группы узлов](#node-group-auto-upgrade) в любое время.

Подробнее см. в разделе [{#T}](../concepts/release-channels-and-updates.md).

{% note tip %}

[Политика развертывания](../concepts/node-group/deploy-policy.md) (deploy policy) влияет на поведение группы узлов в [процессе обновления](../concepts/release-channels-and-updates.md#node-group). Перед тем как выполнять обновление, убедитесь, что политика [настроена](node-group/node-group-update.md#configure-deploy-policy) корректно.

{% endnote %}

## Список доступных версий {{ k8s }} {#versions-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы узнать список доступных версий для кластера {{ managed-k8s-name }}:
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
  1. Получите список доступных версий в поле **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}** блока **{{ ui-key.yacloud.k8s.clusters.create.section_main-cluster }}**.

  Чтобы узнать список доступных версий для группы узлов {{ managed-k8s-name }}:

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Выберите нужную группу узлов {{ managed-k8s-name }} в списке и нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
  1. Получите список доступных версий в поле **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список доступных версий, выполните команду:

  ```bash
  yc managed-kubernetes list-versions
  ```

- API {#api}

  Чтобы получить список доступных версий, воспользуйтесь методом REST API [list](../managed-kubernetes/api-ref/Version/list.md) для ресурса [Version](../managed-kubernetes/api-ref/Version/index.md) или вызовом gRPC API [VersionService/List](../managed-kubernetes/api-ref/grpc/Version/list.md).

{% endlist %}

## Обновление кластера {#cluster-upgrade}

### Настройка автоматического обновления при создании или изменении кластера {#cluster-auto-upgrade}

Выберите режим автоматического обновления кластера {{ managed-k8s-name }} и задайте нужный график обновления:

{% list tabs group=instructions %}

- Консоль управления {#console}

  Настройки обновлений можно указать при [создании кластера {{ managed-k8s-name }}](kubernetes-cluster/kubernetes-cluster-create.md) или [изменении его настроек](kubernetes-cluster/kubernetes-cluster-update.md).

  В поле **{{ ui-key.yacloud.k8s.MaintenanceSection.maintenance-window-field-with-none-option_tx5Wn }}** выберите политику обновления кластера {{ managed-k8s-name }}:
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-disabled }}` — выберите эту опцию, чтобы не использовать автоматические обновления.
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-anytime }}` — выберите эту опцию, чтобы {{ managed-k8s-name }} управлял графиком установки обновлений.
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}` — укажите время начала и продолжительность обновления.
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-weekly }}` — укажите день, время начала и продолжительность обновления. При необходимости выберите несколько вариантов с помощью кнопки **{{ ui-key.yacloud.k8s.clusters.create.button_add-day-of-week }}**.

- CLI {#cli}

  Укажите параметры автоматического обновления при [создании](kubernetes-cluster/kubernetes-cluster-create.md) или [изменении](kubernetes-cluster/kubernetes-cluster-update.md) кластера {{ managed-k8s-name }}:

  ```bash
  {{ yc-k8s }} cluster <create_или_update> <имя_или_идентификатор_кластера> \
  ...
    --auto-upgrade <режим_автоматического_обновления> \
    --anytime-maintenance-window \
    --daily-maintenance-window <значение> \
    --weekly-maintenance-window <значение>
  ```

  Где:
  * `--auto-upgrade` — выбор режима автоматического обновления кластера {{ managed-k8s-name }}. Значение по умолчанию — `true` (автоматическое обновление включено).
  * `--anytime-maintenance-window` — выбор произвольного времени обновления кластера {{ managed-k8s-name }}.
  * `--daily-maintenance-window` — режим обновления `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}`.

    Пример ежедневного обновления кластера {{ managed-k8s-name }} в 22:00 UTC длительностью не более 10 часов:

    ```bash
    --daily-maintenance-window 'start=22:00,duration=10h'
    ```

  * `--weekly-maintenance-window` — автоматическое обновление в указанные дни.

    Пример обновления кластера {{ managed-k8s-name }} по понедельникам и вторникам с 22:00 UTC, длительностью не более 10 часов:

    ```bash
    --weekly-maintenance-window 'days=[monday,tuesday],start=22:00,duration=10h'
    ```

    Чтобы указать несколько периодов обслуживания, передайте настройки каждого из них в отдельном аргументе `--weekly-maintenance-window`.

    {% note info %}

    Аргументы `--daily-maintenance-window` и `--weekly-maintenance-window` требуют аргумента `--auto-upgrade` со значением `true`. Расписание обновления не будет создано, если установить `--auto-upgrade=false`.

    {% endnote %}

  Идентификатор и имя кластера {{ managed-k8s-name }} можно получить [со списком кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл с описанием кластера {{ managed-k8s-name }}.

     Как создать такой файл, см. в разделе [{#T}](kubernetes-cluster/kubernetes-cluster-create.md).
  1. Измените параметры автоматического обновления в описании кластера {{ managed-k8s-name }}.

     {% note info %}

     Вы можете выбрать только один из режимов обновления — ежедневный или в выбранные дни. Одновременное использование режимов не допускается.

     {% endnote %}

     * Чтобы включить режим ежедневного обновления:

       ```hcl
       resource "yandex_kubernetes_cluster" "<имя_кластера>" {
         name = "<имя_кластера>"
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             start_time = "<время_начала_обновления>"
             duration   = "<длительность_обновления>"
           }
         }
       }
       ```

       Где:

       * `start_time` — время начала обновления в формате [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).
       * `duration` — длительность обновления (например `4h30m`).

     * Чтобы включить режим обновления в выбранные дни (можно указать несколько периодов):

       ```hcl
       resource "yandex_kubernetes_cluster" "<имя_кластера>" {
         name = "<имя_кластера>"
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             day        = "<день_начала_обновления>"
             start_time = "<время_начала_обновления>"
             duration   = "<длительность_обновления>"
           }
           maintenance_window {
             day        = "<день_начала_обновления>"
             start_time = "<время_начала_обновления>"
             duration   = "<длительность_обновления>"
           }
         }
       }
       ```

       Где:

       * `day` — день недели (например `monday`).
       * `start_time` — время начала обновления в формате [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).
       * `duration` — длительность обновления (например `4h30m`).

     * Чтобы включить режим произвольного времени обновления, не добавляйте блок параметров `maintenance_policy` в описание кластера {{ managed-k8s-name }}. Если в описании кластера {{ managed-k8s-name }} не указаны настройки автоматического обновления, оно будет производиться в произвольное время.
     * Чтобы отключить автоматическое обновление:

       ```hcl
       resource "yandex_kubernetes_cluster" "<имя_кластера>" {
         name = "<имя_кластера>"
         ...
         maintenance_policy {
           auto_upgrade = false
         }
       }
       ```

  1. Проверьте корректность конфигурационных файлов.

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

     {% note warning "Ограничения по времени" %}
     
     Провайдер {{ TF }} ограничивает время на создание и изменение кластера {{ managed-k8s-name }} 30 минутами.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_kubernetes_cluster" "<имя_кластера>" {
       ...
       timeouts {
         create = "60m"
         update = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-cluster }}).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Настройки автоматического обновления задаются в блоке `masterSpec.maintenancePolicy` при [создании кластера {{ managed-k8s-name }}](../managed-kubernetes/api-ref/Cluster/create.md) или [изменении его настроек](../managed-kubernetes/api-ref/Cluster/update.md).

  Воспользуйтесь методом REST API [update](../managed-kubernetes/api-ref/Cluster/update.md) для ресурса [Cluster](../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../managed-kubernetes/api-ref/grpc/Cluster/update.md) и передайте в запросе:
  * Идентификатор кластера {{ managed-k8s-name }} в параметре `clusterId`. Чтобы узнать идентификатор кластера {{ managed-k8s-name }}, [получите список кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md).
  * Настройки автоматического обновления в параметре `masterSpec.maintenancePolicy`.
  * Список изменяемых настроек в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

  Чтобы отключить автоматическое обновление, передайте значение `false` в параметре `masterSpec.maintenancePolicy.autoUpgrade`.

  Для включения и настройки окна обновлений передайте одно из допустимых значений параметра `maintenanceWindow`:
  * Чтобы кластер {{ managed-k8s-name }} обновлялся в произвольное время, передайте значение `"anytime": {}`.
  * Чтобы настроить ежедневные обновления, добавьте блок `dailyMaintenanceWindow`:

    ```json
    "dailyMaintenanceWindow": {
      "startTime": {
        "hours": "<час_начала_обновления>",
        "minutes": "<минута_начала_обновления>",
        "seconds": "<секунда_начала_обновления>",
        "nanos": "<доля_секунды_начала_обновления>"
      },
      "duration": "<длительность_периода_обновления>"
    }
    ```

    Где:

    * `hours` — час начала обновления в формате [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).
    * `nanos` — доля секунды начала обновления, в наносекундах.
    * `duration` — длительность периода обновления, в часах.

  * Чтобы настроить обновление в выбранные дни, добавьте блок `weeklyMaintenanceWindow`:

    ```json
    "weeklyMaintenanceWindow": {
      "daysOfWeek": [
        {
          "days": [
            "<список_дней>"
          ],
          "startTime": {
            "hours": "<час_начала_обновления>",
            "minutes": "<минута_начала_обновления>",
            "seconds": "<секунда_начала_обновления>",
            "nanos": "<доля_секунды_начала_обновления>"
          },
          "duration": "<длительность_периода_обновления>"
        }
      ]
    }
    ```

    Где:

    * `days` — список дней, например: `monday`, `tuesday`.
    * `hours` — час начала обновления в формате [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).
    * `nanos` — доля секунды начала обновления, в наносекундах.
    * `duration` — длительность периода обновления, в часах.

{% endlist %}

{% note info %}

Если вы включили обновление ежедневно или в отдельные дни, оно может начаться позже указанного времени.  

{% endnote %}

### Ручное обновление версии кластера {#cluster-manual-upgrade}

При необходимости обновите версию кластера {{ managed-k8s-name }} вручную. За один этап кластер {{ managed-k8s-name }} можно обновить только до следующей минорной версии относительно текущей. Обновление до более новых версий производится в несколько этапов, например: 1.19 → 1.20 → 1.21.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
  1. В поле **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}** выберите вариант `Обновить до версии <номер_версии>`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Укажите новую версию {{ k8s }} в значении аргумента `--version`:

  ```bash
  {{ yc-k8s }} cluster update <имя_или_идентификатор_кластера> \
    --version <новая_версия>
  ```

  Идентификатор и имя кластера {{ managed-k8s-name }} можно [получить со списком кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл с описанием кластера {{ managed-k8s-name }}.

     О том, как создать такой файл, см. в разделе [{#T}](kubernetes-cluster/kubernetes-cluster-create.md).
  1. Измените версию в описании кластера {{ managed-k8s-name }}:

     ```hcl
     resource "yandex_kubernetes_cluster" "<имя_кластера>" {
       name = "<имя_кластера>"
       ...
       master {
         version = "<новая_версия>"
         ...
       }
     }
     ```

  1. Проверьте корректность конфигурационных файлов.

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

     {% note warning "Ограничения по времени" %}
     
     Провайдер {{ TF }} ограничивает время на создание и изменение кластера {{ managed-k8s-name }} 30 минутами.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_kubernetes_cluster" "<имя_кластера>" {
       ...
       timeouts {
         create = "60m"
         update = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-cluster }}).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Воспользуйтесь методом REST API [update](../managed-kubernetes/api-ref/Cluster/update.md) для ресурса [Cluster](../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../managed-kubernetes/api-ref/grpc/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера {{ managed-k8s-name }} в параметре `clusterId`. Чтобы узнать идентификатор кластера {{ managed-k8s-name }}, [получите список кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md).
  * Нужную версию {{ k8s }} в параметре `masterSpec.version.version`.
  * Список изменяемых настроек в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

{% endlist %}

## Обновление группы узлов {#node-group-upgrade}

{% note warning %}

Начиная с {{ k8s }} версии 1.30 во всех [релизных каналах](../concepts/release-channels-and-updates.md) базовый образ узлов кластера {{ managed-k8s-name }} изменен с Ubuntu 20.04 на Ubuntu 22.04. В существующих кластерах и группах узлов версия операционной системы будет повышена в соответствии с выбранным способом обновления.

Особенности и рекомендации по обновлению ОС приведены в разделе [{#T}](../concepts/node-os-update.md).

{% endnote %}

### Настройка автоматического обновления группы узлов {#node-group-auto-upgrade}

Выберите режим автоматического обновления группы узлов {{ managed-k8s-name }} и задайте нужный график обновления:

{% list tabs group=instructions %}

- Консоль управления {#console}

  Настройки обновлений можно указать при [создании группы узлов {{ managed-k8s-name }}](node-group/node-group-create.md) или [изменении ее настроек](node-group/node-group-update.md).

  В поле **{{ ui-key.yacloud.k8s.node-groups.create.section_deploy }}** укажите настройки масштабирования группы узлов {{ managed-k8s-name }}:
  * **{{ ui-key.yacloud.k8s.node-groups.create.field_max-expansion }}** — задайте максимальное количество узлов, на которое можно превысить размер группы при ее обновлении.

    {% note warning %}
    
    Если в настройках группы узлов разрешено автоматическое расширение размера группы при обновлении, убедитесь, что в вашем облаке достаточно [ресурсов](../concepts/limits.md). При необходимости [увеличьте](../../quota-manager/operations/set-quotas.md) квоты.
    
    {% endnote %}

  * **{{ ui-key.yacloud.k8s.node-groups.create.field_max-unavailable }}** — задайте максимальное количество недоступных узлов группы при ее обновлении.

  В поле **{{ ui-key.yacloud.k8s.MaintenanceSection.maintenance-window-field-with-none-option_tx5Wn }}** выберите политику обновления группы узлов {{ managed-k8s-name }}:
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-disabled }}` — выберите эту опцию, чтобы не использовать автоматические обновления.
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-anytime }}` — выберите эту опцию, чтобы {{ managed-k8s-name }} управлял графиком установки обновлений.
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}` — укажите время начала и продолжительность обновления.
  * `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-weekly }}` — укажите день, время начала и продолжительность обновления. При необходимости выберите несколько вариантов с помощью кнопки **{{ ui-key.yacloud.k8s.clusters.create.button_add-day-of-week }}**.

- CLI {#cli}

  Укажите параметры автоматического обновления при [создании](node-group/node-group-create.md) или [изменении](node-group/node-group-update.md) группы узлов {{ managed-k8s-name }}:

  ```bash
  {{ yc-k8s }} node-group <create_или_update> <имя_или_идентификатор_группы_узлов> \
  ...
    --max-expansion <расширение_размера_группы_при_обновлении> \
    --max-unavailable <количество_недоступных_узлов_при_обновлении> \
    --auto-upgrade <режим_автоматического_обновления> \
    --auto-repair <режим_пересоздания> \
    --anytime-maintenance-window \
    --daily-maintenance-window <значение> \
    --weekly-maintenance-window <значение>
  ```

  Где:

  * `--max-expansion` — максимальное количество узлов, на которое можно увеличить размер группы при ее обновлении.

    {% note warning %}
    
    Если в настройках группы узлов разрешено автоматическое расширение размера группы при обновлении, убедитесь, что в вашем облаке достаточно [ресурсов](../concepts/limits.md). При необходимости [увеличьте](../../quota-manager/operations/set-quotas.md) квоты.
    
    {% endnote %}

  * `--max-unavailable` — максимальное количество недоступных узлов группы при ее обновлении.

    {% note info %}

    Параметры `--max-expansion` и `--max-unavailable` следует использовать совместно.

    {% endnote %}

  * `--auto-upgrade` — выбор режима автоматического обновления группы узлов {{ managed-k8s-name }}. Значение по умолчанию — `true` (автоматическое обновление включено). Возможные значения: `true` или `false`.
  * `--auto-repair` — выбор режима пересоздания сбойных узлов. Возможные значения: `true` или `false`.

    Режим `--auto-repair` находится на стадии [Preview](../../overview/concepts/launch-stages.md).
  * `--anytime-maintenance-window` — выбор произвольного времени обновления группы узлов {{ managed-k8s-name }}.
  * `--daily-maintenance-window` — режим обновления `{{ ui-key.yacloud.k8s.clusters.create.value_maintenance-daily }}`.

    Пример ежедневного обновления группы узлов {{ managed-k8s-name }} в 22:00 UTC длительностью не более 10 часов:

    ```bash
    --daily-maintenance-window 'start=22:00,duration=10h'
    ```

  * `--weekly-maintenance-window` — автоматическое обновление в указанные дни.

    Пример обновления группы узлов {{ managed-k8s-name }} по понедельникам и вторникам с 22:00 UTC, длительностью 10 часов:

    ```bash
    --weekly-maintenance-window 'days=[monday,tuesday],start=22:00,duration=10h'
    ```

    Чтобы указать несколько периодов обслуживания, передайте настройки каждого из них в отдельном аргументе `--weekly-maintenance-window`.

    {% note info %}

    Аргументы `--daily-maintenance-window` и `--weekly-maintenance-window` требуют аргумента `--auto-upgrade` со значением `true`.

    Расписание обновления не будет создано, если установить `--auto-upgrade=false`.

    {% endnote %}

  Идентификатор и имя группы узлов {{ managed-k8s-name }} можно [получить со списком групп в кластере](node-group/node-group-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл с описанием группы узлов {{ managed-k8s-name }}.

     О том, как создать такой файл, см. в разделе [{#T}](node-group/node-group-create.md).
  1. Измените параметры автоматического обновления в описании группы узлов {{ managed-k8s-name }}.

     {% note info %}

     Вы можете выбрать только один из режимов обновления — ежедневный или в выбранные дни. Одновременное использование режимов не допускается.

     {% endnote %}

     * Чтобы включить режим ежедневного обновления:

       ```hcl
       resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
         name = "<имя_группы_узлов>"
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             start_time = "<время_начала_обновления>"
             duration   = "<длительность_обновления>"
           }
         }
       }
       ```

       Где:

       * `start_time` — время начала обновления в формате [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).
       * `duration` — длительность обновления (например `4h30m`).

     * Чтобы включить режим обновления в выбранные дни (можно указать несколько периодов):

       ```hcl
       resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
         name = "<имя_группы_узлов>"
         ...
         maintenance_policy {
           auto_upgrade = true
           maintenance_window {
             day        = "<день_начала_обновления>"
             start_time = "<время_начала_обновления>"
             duration   = "<длительность_обновления>"
           }
           maintenance_window {
             day        = "<день_начала_обновления>"
             start_time = "<время_начала_обновления>"
             duration   = "<длительность_обновления>"
           }
         }
       }
       ```

       Где:

       * `day` — день недели (например `monday`).
       * `start_time` — время начала обновления в формате [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).
       * `duration` — длительность обновления (например `4h30m`).

     * Чтобы включить режим произвольного времени обновления, не добавляйте блок параметров `maintenance_policy` в описание группы узлов {{ managed-k8s-name }}. Если в описании группы узлов {{ managed-k8s-name }} не указаны настройки автоматического обновления, оно будет производиться в произвольное время.
     * Чтобы задать настройки развертывания группы узлов {{ managed-k8s-name }} при обновлении:

       ```hcl
       resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
         name = "<имя_группы_узлов>"
         ...
         deploy_policy {
           max_expansion   = <расширение_размера_группы_при_обновлении>
           max_unavailable = <количество_недоступных_узлов_при_обновлении>
         }
       }
       ```

       Где:
       * `max_expansion` — максимальное количество узлов, на которое можно увеличить размер группы при ее обновлении.

         {% note warning %}
         
         Если в настройках группы узлов разрешено автоматическое расширение размера группы при обновлении, убедитесь, что в вашем облаке достаточно [ресурсов](../concepts/limits.md). При необходимости [увеличьте](../../quota-manager/operations/set-quotas.md) квоты.
         
         {% endnote %}

       * `max_unavailable` — максимальное количество недоступных узлов группы при ее обновлении.

       {% note info %}

       Параметры `max_expansion` и `max_unavailable` следует использовать совместно.

       {% endnote %}

     * Чтобы отключить автоматическое обновление:

       ```hcl
       resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
         name = "<имя_группы_узлов>"
         ...
         maintenance_policy {
           auto_upgrade = false
         }
       }
       ```

  1. Проверьте корректность конфигурационных файлов.

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

     {% note warning "Ограничения по времени" %}
     
     Провайдер {{ TF }} ограничивает время на выполнение операций с группами узлов кластера {{ managed-k8s-name }}:
     
     * создание и изменение — 60 минут;
     * удаление — 20 минут.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию группы узлов кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       ...
       timeouts {
         create = "1h30m"
         update = "1h30m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Настройки автоматического обновления задаются в блоке `maintenancePolicy` при [создании группы узлов {{ managed-k8s-name }}](../managed-kubernetes/api-ref/NodeGroup/create.md) или [изменении ее настроек](../managed-kubernetes/api-ref/NodeGroup/update.md).

  Воспользуйтесь методом REST API [update](../managed-kubernetes/api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Update](../managed-kubernetes/api-ref/grpc/NodeGroup/update.md) и передайте в запросе:
  * Идентификатор группы узлов {{ managed-k8s-name }} в параметре `nodeGroupId`. Чтобы узнать идентификатор группы узлов {{ managed-k8s-name }}, [получите список групп в кластере](node-group/node-group-list.md).
  * Настройки автоматического обновления в параметре `maintenancePolicy`.
  * Список изменяемых настроек в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

  Чтобы отключить автоматическое обновление, передайте значение `false` в параметре `maintenancePolicy.autoUpgrade`.

  Для включения и настройки окна обновлений передайте одно из допустимых значений параметра `maintenanceWindow`:
  * Чтобы группа узлов {{ managed-k8s-name }} обновлялась в произвольное время, передайте значение `"anytime": {}`.
  * Чтобы настроить ежедневные обновления, добавьте блок `dailyMaintenanceWindow`:

    ```json
    "dailyMaintenanceWindow": {
      "startTime": {
        "hours": "<час_начала_обновления>",
        "minutes": "<минута_начала_обновления>",
        "seconds": "<секунда_начала_обновления>",
        "nanos": "<доля_секунды_начала_обновления>"
      },
      "duration": "<длительность_периода_обновления>"
    }
    ```

    Где:

    * `hours` — час начала обновления в формате [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).
    * `nanos` — доля секунды начала обновления, в наносекундах.
    * `duration` — длительность периода обновления, в часах.

  * Чтобы настроить обновление в выбранные дни, добавьте блок `weeklyMaintenanceWindow`:

    ```json
    "weeklyMaintenanceWindow": {
      "daysOfWeek": [
        {
          "days": [
            "<список_дней>"
          ],
          "startTime": {
            "hours": "<час_начала_обновления>",
            "minutes": "<минута_начала_обновления>",
            "seconds": "<секунда_начала_обновления>",
            "nanos": "<доля_секунды_начала_обновления>"
          },
          "duration": "<длительность_периода_обновления>"
        }
      ]
    }
    ```

    Где:

    * `days` — список дней, например: `monday`, `tuesday`.
    * `hours` — час начала обновления в формате [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время).
    * `nanos` — доля секунды начала обновления, в наносекундах.
    * `duration` — длительность периода обновления, в часах.

  Для настройки развертывания группы узлов {{ managed-k8s-name }} при ее обновлении добавьте блок `deployPolicy`:

  ```json
  "deployPolicy": {
    "maxUnavailable": "<количество_недоступных_узлов_при_обновлении>",
    "maxExpansion": "<расширение_размера_группы_при_обновлении>"
  }
  ```

  Где:

  * `maxUnavailable` — максимальное количество недоступных узлов группы при ее обновлении.
  * `maxExpansion` — максимальное количество узлов, на которое можно увеличить размер группы при ее обновлении.

    {% note warning %}
    
    Если в настройках группы узлов разрешено автоматическое расширение размера группы при обновлении, убедитесь, что в вашем облаке достаточно [ресурсов](../concepts/limits.md). При необходимости [увеличьте](../../quota-manager/operations/set-quotas.md) квоты.
    
    {% endnote %}

{% endlist %}

{% note info %}

Если вы включили обновление ежедневно или в отдельные дни, оно может начаться позже указанного времени.  

{% endnote %}

### Ручное обновление версии группы узлов {#node-group-manual-upgrade}

При необходимости обновите версию группы узлов {{ managed-k8s-name }} вручную. Для обновления доступна только следующая минорная версия относительно текущей. Обновление до более новых версий следует производить в несколько этапов, например: 1.19 → 1.20 → 1.21.

{% note warning %}

Обновите версию кластера {{ managed-k8s-name }} перед обновлением группы узлов.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
  1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Выберите нужную группу узлов {{ managed-k8s-name }} в списке.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
  1. В поле **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** выберите вариант `Обновить до версии <номер_версии>`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Укажите параметры автоматического обновления:

  ```bash
  {{ yc-k8s }} node-group update <идентификатор_или_имя_группы_узлов> \
  ...
    --version <новая_версия>
  ```

  Идентификатор и имя группы узлов {{ managed-k8s-name }} можно [получить со списком групп в кластере](node-group/node-group-list.md).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл с описанием группы узлов {{ managed-k8s-name }}.

     О том, как создать такой файл, см. в разделе [{#T}](node-group/node-group-create.md).
  1. Измените версию в описании группы узлов {{ managed-k8s-name }}:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       name = "<имя_группы_узлов>"
       ...
       version = "<новая_версия>"
     }
     ```

  1. Проверьте корректность конфигурационных файлов.

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

     {% note warning "Ограничения по времени" %}
     
     Провайдер {{ TF }} ограничивает время на выполнение операций с группами узлов кластера {{ managed-k8s-name }}:
     
     * создание и изменение — 60 минут;
     * удаление — 20 минут.
     
     Операции, которые длятся дольше указанного времени, прерываются.
     
     {% cut "Как изменить эти ограничения?" %}
     
     Добавьте к описанию группы узлов кластера блок `timeouts`, например:
     
     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       ...
       timeouts {
         create = "1h30m"
         update = "1h30m"
         delete = "60m"
       }
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-k8s-nodegroup }}).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Воспользуйтесь методом REST API [update](../managed-kubernetes/api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Update](../managed-kubernetes/api-ref/grpc/NodeGroup/update.md) и передайте в запросе:
  * Идентификатор группы узлов {{ managed-k8s-name }} в параметре `nodeGroupId`. Чтобы узнать идентификатор группы узлов {{ managed-k8s-name }}, [получите список групп в кластере](node-group/node-group-list.md).
  * Нужную версию {{ k8s }} в параметре `version.version`.
  * Список изменяемых настроек в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

{% endlist %}

## Обновление компонентов {{ k8s }} без изменения версии {#latest-revision}

Для кластера {{ managed-k8s-name }} и группы узлов доступно обновление в рамках одной версии {{ k8s }}. При установке обновления мажорная версия {{ k8s }} не меняется.

При таком обновлении возможны:
* Установка новых пакетов.
* Обновление образа {{ k8s }}.
* Обновление патч-версии {{ k8s }}.

Кластер {{ managed-k8s-name }} и группы узлов будут обновлены, если в их настройках включен любой из вариантов автоматического обновления.

### Обновление для кластера с отключенным автоматическим обновлением {#cluster-latest-revision}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
  1. В поле **{{ ui-key.yacloud.k8s.clusters.create.field_master-version }}** выберите `Получить последние улучшения и исправления для версии...`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Выполните обновление кластера {{ managed-k8s-name }}:

  ```bash
  {{ yc-k8s }} cluster update <имя_или_идентификатор_кластера> \
    --latest-revision
  ```

  Идентификатор и имя кластера {{ managed-k8s-name }} можно [получить со списком кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md#list).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Воспользуйтесь методом REST API [update](../managed-kubernetes/api-ref/Cluster/update.md) для ресурса [Cluster](../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../managed-kubernetes/api-ref/grpc/Cluster/update.md) и передайте в запросе:
  * Идентификатор кластера {{ managed-k8s-name }} в параметре `clusterId`. Чтобы узнать идентификатор кластера {{ managed-k8s-name }}, [получите список кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md#list).
  * Значение `true` в параметре `masterSpec.version.version`.
  * Список изменяемых настроек в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

{% endlist %}

### Обновление для группы узлов с отключенным автоматическим обновлением {#node-group-latest-revision}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
  1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Выберите нужную группу узлов {{ managed-k8s-name }} в списке.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.edit }}** в правом верхнем углу.
  1. В поле **{{ ui-key.yacloud.k8s.node-groups.create.field_node-version }}** выберите `Получить последние улучшения и исправления для версии...`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Выполните обновление группы узлов {{ managed-k8s-name }}:

  ```bash
  {{ yc-k8s }} node-group update <идентификатор_или_имя_группы_узлов> \
    --latest-revision
  ```

  Идентификатор и имя группы узлов {{ managed-k8s-name }} можно [получить со списком групп в кластере](node-group/node-group-list.md).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Воспользуйтесь методом REST API [update](../managed-kubernetes/api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Update](../managed-kubernetes/api-ref/grpc/NodeGroup/update.md) и передайте в запросе:
  * Идентификатор группы узлов {{ managed-k8s-name }} в параметре `nodeGroupId`. Чтобы узнать идентификатор группы узлов {{ managed-k8s-name }}, [получите список групп в кластере](node-group/node-group-list.md).
  * Значение `true` в параметре `version.latestRevision`.
  * Список изменяемых настроек в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

{% endlist %}

## Обязательное обновление {#necessary-update}

Для кластера {{ managed-k8s-name }} может быть назначено [обязательное обновление](../concepts/release-channels-and-updates.md#necessary-update).

При таком обновлении возможны:

* Установка новых пакетов.
* Обновление мажорной версии {{ k8s }}.
* Применение обновлений безопасности {{ k8s }}.

Если в кластере выбран режим произвольного времени обновления, то обязательное обновление произойдет в порядке, определенном сервисом. В иных случаях по умолчанию обновление устанавливается через 14 дней после оповещения пользователей. Вы можете перенести обязательное обновление на более ранний срок.

### Немедленное обновление {#instant-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
  1. В блоке **Обновления** нажмите кнопку **Обновить сейчас**.

{% endlist %}

### Перенос даты обновления {#move-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера {{ managed-k8s-name }}.
  1. В блоке **Обновления** нажмите кнопку **Перенести**.
  1. Выберите новую дату обновления и нажмите кнопку **Перенести**.

- CLI {#cli}

  Выполните перенос даты обновления кластера:

  ```bash
  {{ yc-k8s }} reschedule-maintenance \
      --id <идентификатор_кластера> \
      --delayed-until <дата_и_время_обновления>
  ```

  Где:

  * `--delayed-until` — новые дата и время обновления в формате `YYYY-MM-DDThh:mm:ssZ`. Например: `2026-01-01T21:00:00Z`. Обязательный параметр.

  Идентификатор кластера {{ managed-k8s-name }} можно [получить со списком кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Воспользуйтесь методом REST API [rescheduleMaintenance](../managed-kubernetes/api-ref/Cluster/rescheduleMaintenance.md) для ресурса [Cluster](../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/RescheduleMaintenance](../managed-kubernetes/api-ref/grpc/Cluster/rescheduleMaintenance.md) и передайте в запросе:
  * Идентификатор кластера {{ managed-k8s-name }} в параметре `clusterId`. Чтобы узнать идентификатор кластера {{ managed-k8s-name }}, [получите список кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md#list).
  * Новые дату и время обновления в формате `YYYY-MM-DDThh:mm:ssZ` в параметре `delayedUntil`. Например: `2026-01-01T21:00:00Z`.

{% endlist %}

{% note info %}

Обновление может начаться позже указанного времени.  

{% endnote %}