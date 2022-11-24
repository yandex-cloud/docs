# Изменение настроек {{ RD }}-кластера

После создания кластера вы можете:

* [{#T}](#change-name-and-description).

* [{#T}](#change-resource-preset).

* [{#T}](#change-disk-size).

* [Настроить серверы](#change-redis-config) {{ RD }} согласно [документации {{ RD }}](https://redis.io/documentation). Список поддерживаемых настроек приведен в разделе [{#T}](../concepts/settings-list.md) и [в справочнике API](../api-ref/Cluster/update.md).

* [{#T}](#change-additional-settings).

* [Переместить кластер](#move-cluster) в другой каталог.

{% if audience != "internal" %}

* [{#T}](#change-sg-set).

{% endif %}

{% note info %}

О том, как изменить версию {{ RD }} кластера, читайте в разделе [{#T}](cluster-version-update.md).

{% endnote %}

## Изменить имя и описание кластера {#change-name-and-description}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ mrd-name }}**.
  1. Выберите нужный кластер.
  1. В верхней части страницы нажмите кнопку **Изменить кластер**.
  1. В блоке **Базовые параметры** задайте новые имя и описание кластера.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-rd }} cluster update --help
     ```

  1. Укажите новые имя и описание в команде изменения кластера:

     ```bash
     {{ yc-mdb-rd }} cluster update <идентификатор или имя кластера> \
       --new-name <новое имя кластера> \
       --description <новое описание кластера>
     ```

- {{ TF }}

    {% note alert %}

    Не изменяйте имя кластера с помощью {{ TF }}. Это приведет к удалению существующего кластера и созданию нового.

    {% endnote %}

    Чтобы изменить описание кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

    1. Измените в описании кластера {{ mrd-name }} значение параметра `description`:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<имя кластера>" {
          name        = "<имя кластера>"
          description = "<новое описание кластера>"
          ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Новое имя кластера в параметре `name`.
    * Новое описание кластера в параметре `description`.
    * Список полей, которые необходимо изменить (в данном случае — `name` и `description`), в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить класс хостов {#change-resource-preset}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ mrd-name }}**.
  1. Выберите нужный кластер.
  1. В верхней части страницы нажмите кнопку **Изменить кластер**.
  1. В блоке **Класс хоста**:
     
	 * Выберите **Платформу**.
     * Выберите **Тип** виртуальной машины, на которой разворачиваются хосты:
        * `high-memory` — с увеличенным объемом RAM на 1 vCPU;
        * `burstable` — с неполной гарантированной долей vCPU. ВМ с гарантированной долей меньше 100% обеспечивают указанный уровень производительности с вероятностью временного повышения вплоть до 100%. Кластеры с такими хостами подходят для задач, которые не требуют постоянной гарантии производительности (например, тестирование).
     * Измените конфигурацию хостов.
	 
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-rd }} cluster update --help
     ```

  1. Запросите список доступных классов хостов (в колонке `ZONES` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     {% if audience != "internal" %}

     ```bash
     {{ yc-mdb-rd }} resource-preset list
     ```
	 
     Результат:

     ```text
     +-------------+--------------------------------+----------+
     |     ID      |            ZONE IDS            |  MEMORY  |
     +-------------+--------------------------------+----------+
     | b1.nano     | {{ region-id }}-a, {{ region-id }}-b,  | 2.0 GB   |
     |             | {{ region-id }}-c                  |          |
     | b1.small    | {{ region-id }}-a, {{ region-id }}-b,  | 4.0 GB   |
     |             | {{ region-id }}-c                  |          |
     | hm1.nano    | {{ region-id }}-a, {{ region-id }}-b,  | 8.0 GB   |
     |             | {{ region-id }}-c                  |          |
     | hm1.micro   | {{ region-id }}-a, {{ region-id }}-b,  | 12.0 GB  |
     | ...                                                     |
     +-----------+----------------------------------+----------+
     ```

     {% else %}

     ```bash
     {{ yc-mdb-rd }} resource-preset list
     ```

     {% endif %}

  1. Укажите нужный класс в команде изменения кластера:

     ```bash
     {{ yc-mdb-rd }} cluster update <идентификатор или имя кластера> \
       --resource-preset <идентификатор класса хостов>
     ```

     {{ mrd-short-name }} запустит операцию изменения класса хостов для кластера.

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

    1. Измените в описании кластера {{ mrd-name }} значение параметра `resource_preset_id` в блоке `resources`:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<имя кластера>" {
          ...
          resources {
            resource_preset_id = "<класс хоста>"
            ...
            }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Новый класс хостов в параметре `configSpec.resources.resourcePresetId`.

        Список поддерживаемых значений запрашивайте методом [list](../api-ref/ResourcePreset/list.md) для ресурсов `ResourcePreset`.

    * Список полей, которые необходимо изменить (в данном случае — `configSpec.resources.resourcePresetId`), в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## {% if audience != "internal" %}Увеличить{% else %}Изменить{% endif %} размер хранилища {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Консоль управления

  Чтобы {% if audience != "internal" %}увеличить{% else %}изменить{% endif %} размер хранилища для кластера:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ mrd-name }}**.
  1. Выберите нужный кластер.
  1. В верхней части страницы нажмите кнопку **Изменить кластер**.
  1. Измените настройки в блоке **Хранилище**.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы {% if audience != "internal" %}увеличить{% else %}изменить{% endif %} размер хранилища хостов {{ RD }}:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-rd }} cluster update --help
     ```

  1. Укажите нужный размер хранилища в команде изменения кластера.{% if audience != "internal" %} Новый размер должен быть не меньше, чем текущее значение `disk_size` в свойствах кластера.{% endif %}

     ```bash
     {{ yc-mdb-rd }} cluster update <имя или идентификатор кластера> \
       --disk-size <размер хранилища в ГБ>
     ```

     Если все условия выполнены, {{ mrd-short-name }} запустит операцию по увеличению размера дисков хостов {{ RD }}.

- {{ TF }}

  Чтобы {% if audience != "internal" %}увеличить{% else %}изменить{% endif %} размер хранилища для кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

    1. Измените в описании кластера {{ mrd-name }} значение параметра `disk_size` в блоке `resources`:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<имя кластера>" {
          ...
          resources {
            disk_size = <размер хранилища в гигабайтах>
            ...
            }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

  Чтобы {% if audience != "internal" %}увеличить{% else %}изменить{% endif %} размер хранилища для кластера, воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
  * Новый размер хранилища в параметре `configSpec.resources.diskSize`.
  * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `configSpec.resources.diskSize`).

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить настройки {{ RD }} {#change-redis-config}

Вы можете изменить настройки СУБД для хостов вашего кластера. Все поддерживаемые настройки описаны в разделе [{#T}](../concepts/settings-list.md) и в [справочнике API](../api-ref/Cluster/update.md).

{% list tabs %}

- Консоль управления

  Чтобы изменить настройки СУБД для кластера:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ mrd-name }}**.
  1. Выберите нужный кластер.
  1. В верхней части страницы нажмите кнопку **Изменить кластер**.
  1. В разделе **Настройки СУБД** нажмите кнопку **Настроить**.
  1. Настройте доступные параметры в соответствии с [документацией {{ RD }}](https://redis.io/documentation).
  1. Нажмите кнопку **Сохранить**.

- {{ TF }}

    Чтобы изменить [настройки СУБД](../concepts/settings-list.md) для кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

    1. Измените в описании кластера {{ mrd-name }} значения параметров в блоке `config`:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<имя кластера>" {
          ...
          config {
            password         = "<пароль>"
            timeout          = <время в секундах перед отключением неактивных клиентов>
            maxmemory_policy = "<политика управления памятью при ее дефиците>"
            ...
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

    Чтобы изменить настройки {{ RD }}, воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Нужные значения настроек {{ RD }} в параметре `configSpec.redisConfig_<версия {{ RD }}>`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ mrd-name }}**.
  1. Выберите нужный кластер.
  1. В верхней части страницы нажмите кнопку **Изменить кластер**.
  1. Измените дополнительные настройки кластера:

     {% include [mrd-extra-settings](../../_includes/mdb/mrd-extra-settings-web-console.md) %}

  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-rd }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        {{ yc-mdb-rd }} cluster update <идентификатор или имя кластера> \
            --backup-window-start <время начала резервного копирования> \
            --maintenance-window type=<тип технического обслуживания: anytime или weekly>,`
                                `day=<день недели для типа weekly>,`
                                `hour=<час дня для типа weekly> \
            --deletion-protection=<защита от удаления кластера: true или false>
        ```

    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров):

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

    * Список полей конфигурации кластера, подлежащих изменению, в параметре `updateMask`.

    {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Переместить кластер {#move-cluster}

{% list tabs %}

- Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ mrd-name }}**.
    1. Нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) справа в строке кластера, который вы хотите переместить.
    1. Выберите пункт **Переместить**.
    1. Выберите каталог, в который вы хотите переместить кластер.
    1. Нажмите кнопку **Переместить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы переместить кластер:

    1. Посмотрите описание команды CLI для перемещения кластера:

        ```bash
        {{ yc-mdb-rd }} cluster move --help
        ```

    1. Укажите каталог назначения в команде перемещения кластера:

        ```bash
        {{ yc-mdb-rd }} cluster move <идентификатор кластера> \
           --destination-folder-name=<имя каталога назначения>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Воспользуйтесь методом API [move](../api-ref/Cluster/move.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Идентификатор каталога назначения в параметре `destinationFolderId`.

{% endlist %}

{% if audience != "internal" %}

## Изменить группы безопасности {#change-sg-set}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
    1. Выберите сервис **{{ mrd-name }}**.
    1. Выберите нужный кластер.
    1. В верхней части страницы нажмите кнопку **Изменить кластер**.
    1. В блоке **Сетевые настройки** выберите группы безопасности для сетевого трафика кластера.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-rd }} cluster update --help
        ```

    1. Укажите нужные группы безопасности в команде изменения кластера:

        ```bash
        {{ yc-mdb-rd }} cluster update <идентификатор или имя кластера> \
          --security-group-ids <список групп безопасности>
        ```

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

    1. Измените в описании кластера {{ mrd-name }} значение параметра `security_group_ids`:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<имя кластера>" {
          ...
          security_group_ids = [<список идентификаторов групп безопасности>]
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Список идентификаторов групп безопасности в параметре `securityGroupIds`.
    * Список настроек, которые необходимо изменить (в данном случае — `securityGroupIds`), в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}

{% endif %}
