# Обновление Kubernetes

{% note info %}

Перед обновлением автоматически выполняется предварительная проверка (_preflight check_) совместимости объектов или конфигураций с новой версией Kubernetes. Если в результате выявляются несовместимые объекты или конфигурации, обновление завершится ошибкой с указанием несовместимых ресурсов и описанием.

{% endnote %}

Для Managed Service for Kubernetes доступно как автоматическое, так и ручное обновление [кластера](../concepts/index.md#kubernetes-cluster) и [группы узлов](../concepts/index.md#node-group). Вы можете в любое время запросить обновление кластера Managed Service for Kubernetes или его узлов вручную до последней поддерживаемой [версии](../concepts/release-channels-and-updates.md). Ручные обновления обходят любые настроенные окна обслуживания и исключения обслуживания.

При обновлении мажорной версии Kubernetes сначала обновите кластер Managed Service for Kubernetes, потом его группу узлов.

Вы можете изменить политику обновления [кластера Managed Service for Kubernetes](#cluster-auto-upgrade) или [группы узлов](#node-group-auto-upgrade) в любое время.

Подробнее см. в разделе [Релизные каналы](../concepts/release-channels-and-updates.md).

{% note tip %}

[Политика развертывания](../concepts/node-group/deploy-policy.md) (deploy policy) влияет на поведение группы узлов в [процессе обновления](../concepts/release-channels-and-updates.md#node-group). Перед тем как выполнять обновление, убедитесь, что политика [настроена](node-group/node-group-update.md#configure-deploy-policy) корректно.

{% endnote %}

## Список доступных версий Kubernetes {#versions-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы узнать список доступных версий для кластера Managed Service for Kubernetes:
  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера Managed Service for Kubernetes.
  1. Нажмите кнопку **Редактировать** в правом верхнем углу.
  1. Получите список доступных версий в поле **Версия Kubernetes** блока **Конфигурация мастера**.

  Чтобы узнать список доступных версий для группы узлов Managed Service for Kubernetes:

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера Managed Service for Kubernetes и перейдите на вкладку **Управление узлами**.
  1. Выберите нужную группу узлов Managed Service for Kubernetes в списке и нажмите кнопку **Редактировать** в правом верхнем углу.
  1. Получите список доступных версий в поле **Версия Kubernetes**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

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

Выберите режим автоматического обновления кластера Managed Service for Kubernetes и задайте нужный график обновления:

{% list tabs group=instructions %}

- Консоль управления {#console}

  Настройки обновлений можно указать при [создании кластера Managed Service for Kubernetes](kubernetes-cluster/kubernetes-cluster-create.md) или [изменении его настроек](kubernetes-cluster/kubernetes-cluster-update.md).

  В поле **Частота обновлений / Отключение** выберите политику обновления кластера Managed Service for Kubernetes:
  * `Отключено` — выберите эту опцию, чтобы не использовать автоматические обновления.
  * `В любое время` — выберите эту опцию, чтобы Managed Service for Kubernetes управлял графиком установки обновлений.
  * `Ежедневно` — укажите время начала и продолжительность обновления.
  * `В выбранные дни` — укажите день, время начала и продолжительность обновления. При необходимости выберите несколько вариантов с помощью кнопки **Добавить день и время**.

- CLI {#cli}

  Укажите параметры автоматического обновления при [создании](kubernetes-cluster/kubernetes-cluster-create.md) или [изменении](kubernetes-cluster/kubernetes-cluster-update.md) кластера Managed Service for Kubernetes:

  ```bash
  yc managed-kubernetes cluster <create_или_update> <имя_или_идентификатор_кластера> \
  ...
    --auto-upgrade <режим_автоматического_обновления> \
    --anytime-maintenance-window \
    --daily-maintenance-window <значение> \
    --weekly-maintenance-window <значение>
  ```

  Где:
  * `--auto-upgrade` — выбор режима автоматического обновления кластера Managed Service for Kubernetes. Значение по умолчанию — `true` (автоматическое обновление включено).
  * `--anytime-maintenance-window` — выбор произвольного времени обновления кластера Managed Service for Kubernetes.
  * `--daily-maintenance-window` — режим обновления `Ежедневно`.

    Пример ежедневного обновления кластера Managed Service for Kubernetes в 22:00 UTC длительностью не более 10 часов:

    ```bash
    --daily-maintenance-window 'start=22:00,duration=10h'
    ```

  * `--weekly-maintenance-window` — автоматическое обновление в указанные дни.

    Пример обновления кластера Managed Service for Kubernetes по понедельникам и вторникам с 22:00 UTC, длительностью не более 10 часов:

    ```bash
    --weekly-maintenance-window 'days=[monday,tuesday],start=22:00,duration=10h'
    ```

    Чтобы указать несколько периодов обслуживания, передайте настройки каждого из них в отдельном аргументе `--weekly-maintenance-window`.

    {% note info %}

    Аргументы `--daily-maintenance-window` и `--weekly-maintenance-window` требуют аргумента `--auto-upgrade` со значением `true`. Расписание обновления не будет создано, если установить `--auto-upgrade=false`.

    {% endnote %}

  Идентификатор и имя кластера Managed Service for Kubernetes можно получить [со списком кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md).

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл с описанием кластера Managed Service for Kubernetes.

     Как создать такой файл, см. в разделе [Создание кластера Managed Service for Kubernetes](kubernetes-cluster/kubernetes-cluster-create.md).
  1. Измените параметры автоматического обновления в описании кластера Managed Service for Kubernetes.

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

     * Чтобы включить режим произвольного времени обновления, не добавляйте блок параметров `maintenance_policy` в описание кластера Managed Service for Kubernetes. Если в описании кластера Managed Service for Kubernetes не указаны настройки автоматического обновления, оно будет производиться в произвольное время.
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

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

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
     
     Провайдер Terraform ограничивает время на создание и изменение кластера Managed Service for Kubernetes 30 минутами.
     
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

  Подробнее см. в [документации провайдера Terraform](../../terraform/resources/kubernetes_cluster.md).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Настройки автоматического обновления задаются в блоке `masterSpec.maintenancePolicy` при [создании кластера Managed Service for Kubernetes](../managed-kubernetes/api-ref/Cluster/create.md) или [изменении его настроек](../managed-kubernetes/api-ref/Cluster/update.md).

  Воспользуйтесь методом REST API [update](../managed-kubernetes/api-ref/Cluster/update.md) для ресурса [Cluster](../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../managed-kubernetes/api-ref/grpc/Cluster/update.md) и передайте в запросе:
  * Идентификатор кластера Managed Service for Kubernetes в параметре `clusterId`. Чтобы узнать идентификатор кластера Managed Service for Kubernetes, [получите список кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md).
  * Настройки автоматического обновления в параметре `masterSpec.maintenancePolicy`.
  * Список изменяемых настроек в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

  Чтобы отключить автоматическое обновление, передайте значение `false` в параметре `masterSpec.maintenancePolicy.autoUpgrade`.

  Для включения и настройки окна обновлений передайте одно из допустимых значений параметра `maintenanceWindow`:
  * Чтобы кластер Managed Service for Kubernetes обновлялся в произвольное время, передайте значение `"anytime": {}`.
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

При необходимости обновите версию кластера Managed Service for Kubernetes вручную. За один этап кластер Managed Service for Kubernetes можно обновить только до следующей минорной версии относительно текущей. Обновление до более новых версий производится в несколько этапов, например: 1.19 → 1.20 → 1.21.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера Managed Service for Kubernetes.
  1. Нажмите кнопку **Редактировать** в правом верхнем углу.
  1. В поле **Версия Kubernetes** выберите вариант `Обновить до версии <номер_версии>`.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Укажите новую версию Kubernetes в значении аргумента `--version`:

  ```bash
  yc managed-kubernetes cluster update <имя_или_идентификатор_кластера> \
    --version <новая_версия>
  ```

  Идентификатор и имя кластера Managed Service for Kubernetes можно [получить со списком кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md).

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл с описанием кластера Managed Service for Kubernetes.

     О том, как создать такой файл, см. в разделе [Создание кластера Managed Service for Kubernetes](kubernetes-cluster/kubernetes-cluster-create.md).
  1. Измените версию в описании кластера Managed Service for Kubernetes:

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

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

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
     
     Провайдер Terraform ограничивает время на создание и изменение кластера Managed Service for Kubernetes 30 минутами.
     
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

  Подробнее см. в [документации провайдера Terraform](../../terraform/resources/kubernetes_cluster.md).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Воспользуйтесь методом REST API [update](../managed-kubernetes/api-ref/Cluster/update.md) для ресурса [Cluster](../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../managed-kubernetes/api-ref/grpc/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера Managed Service for Kubernetes в параметре `clusterId`. Чтобы узнать идентификатор кластера Managed Service for Kubernetes, [получите список кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md).
  * Нужную версию Kubernetes в параметре `masterSpec.version.version`.
  * Список изменяемых настроек в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

{% endlist %}

## Обновление группы узлов {#node-group-upgrade}

{% note warning %}

Начиная с Kubernetes версии 1.30 во всех [релизных каналах](../concepts/release-channels-and-updates.md) базовый образ узлов кластера Managed Service for Kubernetes изменен с Ubuntu 20.04 на Ubuntu 22.04. В существующих кластерах и группах узлов версия операционной системы будет повышена в соответствии с выбранным способом обновления.

Особенности и рекомендации по обновлению ОС приведены в разделе [Обновление операционной системы в группе узлов](../concepts/node-os-update.md).

{% endnote %}

### Настройка автоматического обновления группы узлов {#node-group-auto-upgrade}

Выберите режим автоматического обновления группы узлов Managed Service for Kubernetes и задайте нужный график обновления:

{% list tabs group=instructions %}

- Консоль управления {#console}

  Настройки обновлений можно указать при [создании группы узлов Managed Service for Kubernetes](node-group/node-group-create.md) или [изменении ее настроек](node-group/node-group-update.md).

  В поле **В процессе создания и обновления разрешено** укажите настройки масштабирования группы узлов Managed Service for Kubernetes:
  * **Расширение размера группы, макс.** — задайте максимальное количество узлов, на которое можно превысить размер группы при ее обновлении.

    {% note warning %}
    
    Если в настройках группы узлов разрешено автоматическое расширение размера группы при обновлении, убедитесь, что в вашем облаке достаточно [ресурсов](../concepts/limits.md). При необходимости [увеличьте](../../quota-manager/operations/set-quotas.md) квоты.
    
    {% endnote %}

  * **Уменьшение размера группы, макс.** — задайте максимальное количество недоступных узлов группы при ее обновлении.

  В поле **Частота обновлений / Отключение** выберите политику обновления группы узлов Managed Service for Kubernetes:
  * `Отключено` — выберите эту опцию, чтобы не использовать автоматические обновления.
  * `В любое время` — выберите эту опцию, чтобы Managed Service for Kubernetes управлял графиком установки обновлений.
  * `Ежедневно` — укажите время начала и продолжительность обновления.
  * `В выбранные дни` — укажите день, время начала и продолжительность обновления. При необходимости выберите несколько вариантов с помощью кнопки **Добавить день и время**.

- CLI {#cli}

  Укажите параметры автоматического обновления при [создании](node-group/node-group-create.md) или [изменении](node-group/node-group-update.md) группы узлов Managed Service for Kubernetes:

  ```bash
  yc managed-kubernetes node-group <create_или_update> <имя_или_идентификатор_группы_узлов> \
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

  * `--auto-upgrade` — выбор режима автоматического обновления группы узлов Managed Service for Kubernetes. Значение по умолчанию — `true` (автоматическое обновление включено). Возможные значения: `true` или `false`.
  * `--auto-repair` — выбор режима пересоздания сбойных узлов. Возможные значения: `true` или `false`.

    Режим `--auto-repair` находится на стадии [Preview](../../overview/concepts/launch-stages.md).
  * `--anytime-maintenance-window` — выбор произвольного времени обновления группы узлов Managed Service for Kubernetes.
  * `--daily-maintenance-window` — режим обновления `Ежедневно`.

    Пример ежедневного обновления группы узлов Managed Service for Kubernetes в 22:00 UTC длительностью не более 10 часов:

    ```bash
    --daily-maintenance-window 'start=22:00,duration=10h'
    ```

  * `--weekly-maintenance-window` — автоматическое обновление в указанные дни.

    Пример обновления группы узлов Managed Service for Kubernetes по понедельникам и вторникам с 22:00 UTC, длительностью 10 часов:

    ```bash
    --weekly-maintenance-window 'days=[monday,tuesday],start=22:00,duration=10h'
    ```

    Чтобы указать несколько периодов обслуживания, передайте настройки каждого из них в отдельном аргументе `--weekly-maintenance-window`.

    {% note info %}

    Аргументы `--daily-maintenance-window` и `--weekly-maintenance-window` требуют аргумента `--auto-upgrade` со значением `true`.

    Расписание обновления не будет создано, если установить `--auto-upgrade=false`.

    {% endnote %}

  Идентификатор и имя группы узлов Managed Service for Kubernetes можно [получить со списком групп в кластере](node-group/node-group-list.md).

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл с описанием группы узлов Managed Service for Kubernetes.

     О том, как создать такой файл, см. в разделе [Создание группы узлов](node-group/node-group-create.md).
  1. Измените параметры автоматического обновления в описании группы узлов Managed Service for Kubernetes.

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

     * Чтобы включить режим произвольного времени обновления, не добавляйте блок параметров `maintenance_policy` в описание группы узлов Managed Service for Kubernetes. Если в описании группы узлов Managed Service for Kubernetes не указаны настройки автоматического обновления, оно будет производиться в произвольное время.
     * Чтобы задать настройки развертывания группы узлов Managed Service for Kubernetes при обновлении:

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

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

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
     
     Провайдер Terraform ограничивает время на выполнение операций с группами узлов кластера Managed Service for Kubernetes:
     
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

  Подробнее см. в [документации провайдера Terraform](../../terraform/resources/kubernetes_node_group.md).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Настройки автоматического обновления задаются в блоке `maintenancePolicy` при [создании группы узлов Managed Service for Kubernetes](../managed-kubernetes/api-ref/NodeGroup/create.md) или [изменении ее настроек](../managed-kubernetes/api-ref/NodeGroup/update.md).

  Воспользуйтесь методом REST API [update](../managed-kubernetes/api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Update](../managed-kubernetes/api-ref/grpc/NodeGroup/update.md) и передайте в запросе:
  * Идентификатор группы узлов Managed Service for Kubernetes в параметре `nodeGroupId`. Чтобы узнать идентификатор группы узлов Managed Service for Kubernetes, [получите список групп в кластере](node-group/node-group-list.md).
  * Настройки автоматического обновления в параметре `maintenancePolicy`.
  * Список изменяемых настроек в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

  Чтобы отключить автоматическое обновление, передайте значение `false` в параметре `maintenancePolicy.autoUpgrade`.

  Для включения и настройки окна обновлений передайте одно из допустимых значений параметра `maintenanceWindow`:
  * Чтобы группа узлов Managed Service for Kubernetes обновлялась в произвольное время, передайте значение `"anytime": {}`.
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

  Для настройки развертывания группы узлов Managed Service for Kubernetes при ее обновлении добавьте блок `deployPolicy`:

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

При необходимости обновите версию группы узлов Managed Service for Kubernetes вручную. Для обновления доступна только следующая минорная версия относительно текущей. Обновление до более новых версий следует производить в несколько этапов, например: 1.19 → 1.20 → 1.21.

{% note warning %}

Обновите версию кластера Managed Service for Kubernetes перед обновлением группы узлов.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера Managed Service for Kubernetes.
  1. Перейдите на вкладку **Управление узлами**.
  1. Выберите нужную группу узлов Managed Service for Kubernetes в списке.
  1. Нажмите кнопку **Редактировать** в правом верхнем углу.
  1. В поле **Версия Kubernetes** выберите вариант `Обновить до версии <номер_версии>`.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Укажите параметры автоматического обновления:

  ```bash
  yc managed-kubernetes node-group update <идентификатор_или_имя_группы_узлов> \
  ...
    --version <новая_версия>
  ```

  Идентификатор и имя группы узлов Managed Service for Kubernetes можно [получить со списком групп в кластере](node-group/node-group-list.md).

- Terraform {#tf}

  1. Откройте актуальный конфигурационный файл с описанием группы узлов Managed Service for Kubernetes.

     О том, как создать такой файл, см. в разделе [Создание группы узлов](node-group/node-group-create.md).
  1. Измените версию в описании группы узлов Managed Service for Kubernetes:

     ```hcl
     resource "yandex_kubernetes_node_group" "<имя_группы_узлов>" {
       name = "<имя_группы_узлов>"
       ...
       version = "<новая_версия>"
     }
     ```

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
     1. Выполните команду:
     
        ```bash
        terraform validate
        ```
     
        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

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
     
     Провайдер Terraform ограничивает время на выполнение операций с группами узлов кластера Managed Service for Kubernetes:
     
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

  Подробнее см. в [документации провайдера Terraform](../../terraform/resources/kubernetes_node_group.md).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Воспользуйтесь методом REST API [update](../managed-kubernetes/api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Update](../managed-kubernetes/api-ref/grpc/NodeGroup/update.md) и передайте в запросе:
  * Идентификатор группы узлов Managed Service for Kubernetes в параметре `nodeGroupId`. Чтобы узнать идентификатор группы узлов Managed Service for Kubernetes, [получите список групп в кластере](node-group/node-group-list.md).
  * Нужную версию Kubernetes в параметре `version.version`.
  * Список изменяемых настроек в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

{% endlist %}

## Обновление компонентов Kubernetes без изменения версии {#latest-revision}

Для кластера Managed Service for Kubernetes и группы узлов доступно обновление в рамках одной версии Kubernetes. При установке обновления мажорная версия Kubernetes не меняется.

При таком обновлении возможны:
* Установка новых пакетов.
* Обновление образа Kubernetes.
* Обновление патч-версии Kubernetes.

Кластер Managed Service for Kubernetes и группы узлов будут обновлены, если в их настройках включен любой из вариантов автоматического обновления.

### Обновление для кластера с отключенным автоматическим обновлением {#cluster-latest-revision}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера Managed Service for Kubernetes.
  1. Нажмите кнопку **Редактировать** в правом верхнем углу.
  1. В поле **Версия Kubernetes** выберите `Получить последние улучшения и исправления для версии...`.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Выполните обновление кластера Managed Service for Kubernetes:

  ```bash
  yc managed-kubernetes cluster update <имя_или_идентификатор_кластера> \
    --latest-revision
  ```

  Идентификатор и имя кластера Managed Service for Kubernetes можно [получить со списком кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md#list).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Воспользуйтесь методом REST API [update](../managed-kubernetes/api-ref/Cluster/update.md) для ресурса [Cluster](../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../managed-kubernetes/api-ref/grpc/Cluster/update.md) и передайте в запросе:
  * Идентификатор кластера Managed Service for Kubernetes в параметре `clusterId`. Чтобы узнать идентификатор кластера Managed Service for Kubernetes, [получите список кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md#list).
  * Значение `true` в параметре `masterSpec.version.version`.
  * Список изменяемых настроек в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

{% endlist %}

### Обновление для группы узлов с отключенным автоматическим обновлением {#node-group-latest-revision}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера Managed Service for Kubernetes.
  1. Перейдите на вкладку **Управление узлами**.
  1. Выберите нужную группу узлов Managed Service for Kubernetes в списке.
  1. Нажмите кнопку **Редактировать** в правом верхнем углу.
  1. В поле **Версия Kubernetes** выберите `Получить последние улучшения и исправления для версии...`.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Выполните обновление группы узлов Managed Service for Kubernetes:

  ```bash
  yc managed-kubernetes node-group update <идентификатор_или_имя_группы_узлов> \
    --latest-revision
  ```

  Идентификатор и имя группы узлов Managed Service for Kubernetes можно [получить со списком групп в кластере](node-group/node-group-list.md).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Воспользуйтесь методом REST API [update](../managed-kubernetes/api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Update](../managed-kubernetes/api-ref/grpc/NodeGroup/update.md) и передайте в запросе:
  * Идентификатор группы узлов Managed Service for Kubernetes в параметре `nodeGroupId`. Чтобы узнать идентификатор группы узлов Managed Service for Kubernetes, [получите список групп в кластере](node-group/node-group-list.md).
  * Значение `true` в параметре `version.latestRevision`.
  * Список изменяемых настроек в параметре `updateMask`.

  {% note warning %}
  
  Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
  
  {% endnote %}

{% endlist %}

## Обязательное обновление {#necessary-update}

Для кластера Managed Service for Kubernetes может быть назначено [обязательное обновление](../concepts/release-channels-and-updates.md#necessary-update).

При таком обновлении возможны:

* Установка новых пакетов.
* Обновление мажорной версии Kubernetes.
* Применение обновлений безопасности Kubernetes.

Если в кластере выбран режим произвольного времени обновления, то обязательное обновление произойдет в порядке, определенном сервисом. В иных случаях по умолчанию обновление устанавливается через 14 дней после оповещения пользователей. Вы можете перенести обязательное обновление на более ранний срок.

### Немедленное обновление {#instant-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера Managed Service for Kubernetes.
  1. В блоке **Обновления** нажмите кнопку **Обновить сейчас**.

{% endlist %}

### Перенос даты обновления {#move-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите на имя нужного кластера Managed Service for Kubernetes.
  1. В блоке **Обновления** нажмите кнопку **Перенести**.
  1. Выберите новую дату обновления и нажмите кнопку **Перенести**.

- CLI {#cli}

  Выполните перенос даты обновления кластера:

  ```bash
  yc managed-kubernetes reschedule-maintenance \
      --id <идентификатор_кластера> \
      --delayed-until <дата_и_время_обновления>
  ```

  Где:

  * `--delayed-until` — новые дата и время обновления в формате `YYYY-MM-DDThh:mm:ssZ`. Например: `2026-01-01T21:00:00Z`. Обязательный параметр.

  Идентификатор кластера Managed Service for Kubernetes можно [получить со списком кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md).

- API {#api}

  {% note info %}
  
  Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
  
  {% endnote %}

  Воспользуйтесь методом REST API [rescheduleMaintenance](../managed-kubernetes/api-ref/Cluster/rescheduleMaintenance.md) для ресурса [Cluster](../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/RescheduleMaintenance](../managed-kubernetes/api-ref/grpc/Cluster/rescheduleMaintenance.md) и передайте в запросе:
  * Идентификатор кластера Managed Service for Kubernetes в параметре `clusterId`. Чтобы узнать идентификатор кластера Managed Service for Kubernetes, [получите список кластеров в каталоге](kubernetes-cluster/kubernetes-cluster-list.md#list).
  * Новые дату и время обновления в формате `YYYY-MM-DDThh:mm:ssZ` в параметре `delayedUntil`. Например: `2026-01-01T21:00:00Z`.

{% endlist %}

{% note info %}

Обновление может начаться позже указанного времени.  

{% endnote %}