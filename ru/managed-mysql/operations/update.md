# Изменение настроек кластера

После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).

* [Увеличить размер хранилища](#change-disk-size) (доступно только для стандартного `network-hdd` и быстрого сетевого `network-ssd` хранилищ).

* [Настроить серверы](#change-mysql-config) {{ MY }}.

    {% note warning %}

    Вы не можете менять настройки серверов {{ MY }} с помощью команд SQL.

    {% endnote %}

* [Изменить дополнительные настройки кластера](#change-additional-settings).

* [{#T}](#change-sg-set).

## Изменить класс хостов {#change-resource-preset}

Выбор класса хостов в кластерах {{ mmy-short-name }} ограничен квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **Managed Databases**.

{% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mmy-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Чтобы изменить класс хостов {{ MY }}, в блоке **Класс хоста** выберите нужный класс.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```
      $ {{ yc-mdb-my }} cluster update --help
      ```

  1. Запросите список доступных классов хостов (в колонке `ZONES` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     {% if audience != "internal" %}

     ```
     $ {{ yc-mdb-my }} resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | ru-central1-a, ru-central1-b,  |     2 | 8.0 GB   |
     |           | ru-central1-c                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```

     {% else %}

     ```
     +------------+---------------+-------+----------+
     |     ID     |   ZONE IDS    | CORES |  MEMORY  |
     +------------+---------------+-------+----------+
     | db1.nano   | man, sas, vla |     1 | 2.0 GB   |
     | db1.micro  | man, sas, vla |     1 | 8.0 GB   |
     | ...                                           |
     +------------+---------------+-------+----------+
     ```

     {% endif %}

  1. Укажите нужный класс в команде изменения кластера:

      ```
      $ {{ yc-mdb-my }} cluster update <имя кластера>
           --resource-preset <ID класса>
      ```

      {{ mmy-short-name }} запустит операцию изменения класса хостов для кластера.

- Terraform

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

  1. Измените в описании кластера {{ mmy-name }} значение параметра `resource_preset_id` в блоке `resources`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

- API

  Изменить [класс хостов](../concepts/instance-types.md) кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужное значение в параметре `configSpec.resources.resourcePresetId`.

  Список поддерживаемых значений запрашивайте методом [list](../api-ref/ResourcePreset/list.md) для ресурсов `ResourcePreset`.

{% endlist %}

## Увеличить размер хранилища {#change-disk-size}

Объем хранилищ в кластерах {{ mmy-short-name }} ограничен квотами на объем HDD- и SSD-хранилищ, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемый объем хранилищ, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **Managed Databases**.

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mmy-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В блоке **Размер хранилища** укажите необходимое значение.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы увеличить размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```
      $ {{ yc-mdb-my }} cluster update --help
      ```

  2. Проверьте, что нужный кластер использует стандартное или быстрое сетевое хранилище. Для этого запросите информацию о кластере и найдите поле `disk_type_id` — его значение должно быть `network-hdd` или `network-ssd`:

      ```
      $ {{ yc-mdb-my }} cluster get <имя кластера>

      id: c7qkvr3u78qiopj3u4k2
      folder_id: b1g0ftj57rrjk9thribv
      ...
      config:
        ...
        resources:
          resource_preset_id: s1.micro
          disk_size: "10737418240"
          disk_type_id: network-ssd
      ...
      ```

      {% note warning %}

      Увеличить размер локального или нереплицируемого сетевого хранилища невозможно.

      {% endnote %}

  3. Укажите нужный объем хранилища в команде изменения кластера (должен быть не меньше, чем значение `disk_size` в свойствах кластера):

      ```
      $ {{ yc-mdb-my }} cluster update <имя кластера>
           --disk-size <размер хранилища в ГБ>
      ```

      Если все условия выполнены, {{ mmy-short-name }} запустит операцию по увеличению объема хранилища.

- Terraform

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

  1. Проверьте, что нужный кластер использует стандартное или быстрое сетевое хранилище. Для этого найдите в конфигурационном файле параметр `disk_type_id` — его значение должно быть `network-hdd` или `network-ssd`.

      {% note warning %}

      Увеличить размер локального или нереплицируемого сетевого хранилища невозможно.

      {% endnote %}

  1. Измените значение параметра `disk_size` в блоке `resources`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
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

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

- API

  Изменить размер хранилища для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.resources.diskSize`.

{% endlist %}

## Изменить настройки {{ MY }} {#change-mysql-config}

{% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}  

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mmy-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Измените [настройки {{ MY }}](../concepts/settings-list.md#dbms-settings), нажав на кнопку **Настроить** в блоке **Настройки СУБД**.
  1. Нажмите кнопку **Сохранить**.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [настройки {{ MY }}](../concepts/settings-list.md#dbms-settings):

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```
      $ {{ yc-mdb-my }} cluster update-config --help
      ```

  1. Установите нужные значения параметров.

     Все поддерживаемые параметры перечислены в [формате запроса для метода update](../api-ref/Cluster/update.md), в поле `mysql_config_5_7`. Чтобы указать имя параметра в вызове CLI, преобразуйте его имя из вида <q>lowerCamelCase</q> в <q>snake_case</q>, например, параметр `logMinDurationStatement` из запроса к API преобразуется в `log_min_duration_statement` для команды CLI:

     ```
     $ {{ yc-mdb-my }} cluster update-config <имя кластера>
          --set log_min_duration_statement=100,<имя параметра>=<значение>,...
     ```

     {{ mmy-short-name }} запустит операцию по изменению настроек кластера.

- Terraform

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

  1. Добавьте или измените в описании кластера {{ mmy-name }} параметры [настроек СУБД](../concepts/settings-list.md) в блоке `mysql_config`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
        ...
        mysql_config = {
          <имя настройки {{ MY }}> = <значение>
          ...
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_cluster#mysql-config).

- API

  Изменить [настройки {{ MY }}](../concepts/settings-list.md#dbms-settings) для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.mysql_config_5_7`.

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

* Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mmy-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Измените дополнительные настройки кластера:

     {% include [mmy-extra-settings](../../_includes/mdb/mmy-extra-settings-web-console.md) %}

* CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-my }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        {{ yc-mdb-my }} cluster update <имя кластера> \
            --backup-window-start <время начала резервного копирования> \
            --datalens-access=<true или false> \
            --maintenance-window type=<weekly или anytime> \
            --websql-access=<true или false>
        ```

    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli-additional-settings/backup-window-start.md) %}

    * `--datalens-access` — разрешает доступ из DataLens. Значение по умолчанию — `false`. Подробнее о настройке подключения см в разделе [{#T}](datalens-connect.md).

    {% include [maintenance-window](../../_includes/mdb/cli-additional-settings/maintenance-window.md) %}

    * `--websql-access` — разрешает [выполнять SQL запросы](web-sql-query.md) из консоли управления. Значение по умолчанию — `false`.

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

* Terraform

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

  1. Чтобы изменить время начала резервного копирования, добавьте к описанию кластера {{ mmy-name }} блок `backup_window_start`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
        ...
        backup_window_start {
          hours   = <Час начала резервного копирования>
          minutes = <Минута начала резервного копирования>
        }
        ...
      }
      ```
  
  1. Чтобы активировать доступ к [SQL-запросам из консоли управления](web-sql-query.md) и доступ из [DataLens](datalens-connect.md), добавьте к описанию кластера {{ mmy-name }} блок `access`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
        ...
        access {
          web_sql   = <true или false>
          data_lens = <true или false>
          ...
        }
        ...
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

* API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметрах `configSpec.access` и `configSpec.backupWindowStart`.

{% endlist %}

## Изменить группы безопасности {#change-sg-set}

{% list tabs %}

* Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ mmy-name }}**.
    1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
    1. В блоке **Сетевые настройки** выберите группы безопасности для сетевого трафика кластера.

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-my }} cluster update --help
        ```

    1. Укажите нужные группы безопасности в команде изменения кластера:

        ```bash
        {{ yc-mdb-my }} cluster update <имя кластера> \
           --security-group-ids <список групп безопасности>
        ```

* Terraform

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

  1. Измените в описании кластера {{ mmy-name }} значение параметра `security_group_ids`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
        ...
        security_group_ids = [<список идентификаторов групп безопасности>]
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

* API

    Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) кластера, воспользуйтесь методом API `update` и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
    * Список групп в параметре `securityGroupIds`.
    * Список настроек, которые необходимо изменить, в параметре `updateMask`. Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect.md#configure-security-groups) для подключения к кластеру.

{% endnote %}
