# Изменение настроек кластера

После создания кластера вы можете:

- [{#T}](#change-name-and-description).

- [{#T}](#change-resource-preset).

- [{#T}](#change-disk-size) (доступно только для [типа хранилища](../concepts/storage.md) `network-ssd`).

- [Настроить серверы](#change-redis-config) {{ RD }} согласно [документации {{ RD }}](https://redis.io/documentation). Список поддерживаемых настроек приведен в разделе [{#T}](../concepts/settings-list.md) и [в справочнике API](../api-ref/Cluster/update.md).

- [{#T}](#change-additional-settings).

- [{#T}](#change-sg-set).

{% note info %}

О том, как изменить версию {{ RD }} кластера, читайте в разделе [{#T}](cluster-version-update.md).

{% endnote %}

## Изменить имя и описание кластера {#change-name-and-description}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mrd-name }}**.
  1. Выберите кластер и нажмите на кнопку **Изменить кластер** в верхней части страницы.
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
          --cluster-name <новое имя кластера> \
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

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметрах `name` и `description`.

{% endlist %}

## Изменить класс хостов {#change-resource-preset}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mrd-name }}**.
  1. Выберите кластер и нажмите на кнопку **Изменить кластер** в верхней части страницы.
  1. В блоке **Класс хоста** задайте:
     * **Тип** - тип виртуальной машины, на которой разворачиваются хосты:
        * `high-memory` — с увеличенным объемом RAM на 1 vCPU;
        * `burstable` — с неполной гарантированной долей vCPU. ВМ с гарантированной долей меньше 100% обеспечивают указанный уровень производительности с вероятностью временного повышения вплоть до 100%. Кластеры с такими хостами подходят для задач, которые не требуют постоянной гарантии производительности (например, тестирование).
     * **Память** - объем оперативной памяти, доступный {{ RD }} на хосте.
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

     ```text
     +-------------+--------------------------------+----------+
     |     ID      |            ZONE IDS            |  MEMORY  |
     +-------------+--------------------------------+----------+
     | b1.nano     | ru-central1-a, ru-central1-b,  | 2.0 GB   |
     |             | ru-central1-c                  |          |
     | b1.small    | ru-central1-a, ru-central1-b,  | 4.0 GB   |
     |             | ru-central1-c                  |          |
     | hm1.nano    | ru-central1-a, ru-central1-b,  | 8.0 GB   |
     |             | ru-central1-c                  |          |
     | hm1.micro   | ru-central1-a, ru-central1-b,  | 12.0 GB  |
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

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе нужные значения в параметре `configSpec.resources.resourcePresetId`.

  Список поддерживаемых значений запрашивайте методом [list](../api-ref/ResourcePreset/list.md) для ресурсов `ResourcePreset`.

{% endlist %}

## Увеличить размер хранилища {#change-disk-size}

{% include [storage type check](../../_includes/mdb/mrd/note-change-disk-size.md) %}

{% list tabs %}

- Консоль управления

  Чтобы увеличить размер хранилища для кластера:

  1. Перейдите на страницу каталога и выберите сервис **{{ mrd-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В блоке **Размер хранилища** укажите необходимое значение.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы увеличить размер хранилища хостов {{ RD }}:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-rd }} cluster update --help
     ```

  1. Проверьте, что в облаке хватает квоты на увеличение размера хранилища: откройте страницу [Квоты]({{ link-console-quotas }}) для вашего облака и проверьте, что в секции **Managed Databases** не исчерпано место в строке **Объем SSD-хранилищ**.

  1. Укажите нужный объем хранилища в команде изменения кластера. Новый объем должен быть не меньше, чем текущее значение `disk_size` в свойствах кластера.

     ```bash
     {{ yc-mdb-rd }} cluster update <имя или идентификатор кластера> \
          --disk-size <размер хранилища в ГБ>
     ```

     Если все условия выполнены, {{ mrd-short-name }} запустит операцию по увеличению размера дисков хостов {{ RD }}.

- {{ TF }}

  Чтобы увеличить размер хранилища для кластера:

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

- API

  Убедитесь, что в облаке хватает квоты на увеличение хранилища: откройте страницу [Квоты]({{ link-console-quotas }}) для вашего облака и проверьте, что в секции **Managed Databases** не исчерпано место в строке **Объем SSD-хранилищ**.

  Чтобы увеличить размер хранилища для кластера, воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе нужные значения в параметре `configSpec.resources.diskSize`.

{% endlist %}

## Изменить настройки {{ RD }} {#change-redis-config}

Вы можете изменить настройки СУБД для хостов вашего кластера. Все поддерживаемые настройки описаны в разделе [{#T}](../concepts/settings-list.md) и в [справочнике API](../api-ref/Cluster/update.md).

{% list tabs %}

- Консоль управления

  Чтобы изменить настройки СУБД для кластера:

  1. Перейдите на страницу каталога и выберите сервис **{{ mrd-name }}**.
  1. Выберите кластер и нажмите на кнопку **Изменить кластер** в верхней части страницы.
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

- API

  Изменить настройки СУБД для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.redisConfig_5_0`.

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

* Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mrd-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Измените дополнительные настройки кластера:

     {% include [mrd-extra-settings](../../_includes/mdb/mrd-extra-settings-web-console.md) %}

  1. Нажмите кнопку **Сохранить изменения**.

* CLI

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
            --maintenance-window type=<weekly или anytime> \
            --deletion-protection=<защита от удаления кластера: true или fasle>
        ```

    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli-additional-settings/backup-window-start.md) %}

    {% include [maintenance-window](../../_includes/mdb/cli-additional-settings/maintenance-window.md) %}

    {% include [Защита от удаления кластера](../../_includes/mdb/cli-additional-settings/deletion-protection-db.md) %}

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Изменить группы безопасности {#change-sg-set}

{% list tabs %}

- Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ mrd-name }}**.
    1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
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

    1. Измените в описании кластера {{ mrd-name }} значение параметрa `security_group_ids`:

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

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    - Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
    - Список групп в параметре `securityGroupIds`.
    - Список настроек, которые необходимо изменить, в параметре `updateMask`. Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}
