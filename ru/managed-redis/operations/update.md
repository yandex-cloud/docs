---
title: Инструкция по изменению настроек кластера {{ RD }} в {{ mrd-full-name }}
description: Из статьи вы узнаете, как изменить настройки кластера {{ RD }}.
---

# Изменение настроек кластера {{ RD }}

После создания кластера вы можете:

* [Изменить имя и описание кластера](#change-name-and-description).

* [Настроить использование FQDN вместо IP-адресов](#configure-fqdn-ip-behavior).

* [Изменить класс хостов](#change-resource-preset).


* [Увеличить размер хранилища](#change-disk-size).


* [Настроить серверы](#change-redis-config) {{ RD }} согласно [документации {{ RD }}](https://redis.io/documentation). Список поддерживаемых настроек приведен в разделе [{#T}](../concepts/settings-list.md) и [в справочнике API](../api-ref/Cluster/update.md).

* [Изменить дополнительные настройки кластера](#change-additional-settings).

* [Включить шардирование](#enable-sharding) в нешардированном кластере.

* [Переместить кластер](#move-cluster) в другой каталог.


* [Изменить группы безопасности](#change-sg-set).


Подробнее о других изменениях кластера:

* [{#T}](cluster-version-update.md).

* [Миграция хостов в другую зону доступности](host-migration.md).

## Изменить имя и описание кластера {#change-name-and-description}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Выберите нужный кластер.
  1. В верхней части страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** задайте новые имя и описание кластера.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-rd }} cluster update --help
     ```

  1. Укажите новые имя и описание в команде изменения кластера:

     ```bash
     {{ yc-mdb-rd }} cluster update <имя_или_идентификатор_кластера> \
       --new-name <новое_имя_кластера> \
       --description <новое_описание_кластера>
     ```

- {{ TF }} {#tf}

    {% note alert %}

    Не изменяйте имя кластера с помощью {{ TF }}. Это приведет к удалению существующего кластера и созданию нового.

    {% endnote %}

    Чтобы изменить описание кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

    1. Измените в описании кластера {{ mrd-name }} значение параметра `description`:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<имя_кластера>" {
          name        = "<имя_кластера>"
          description = "<новое_описание_кластера>"
          ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API {#api}

    Чтобы изменить имя и описание кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Новое имя кластера в параметре `name`.
    * Новое описание кластера в параметре `description`.
    * Список полей, которые необходимо изменить (в данном случае — `name` и `description`), в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Настроить использование FQDN вместо IP-адресов {#configure-fqdn-ip-behavior}

Если соответствующая настройка отключена (по умолчанию), то {{ RD }} использует IP-адреса в качестве адресов хостов. Если эта настройка включена, то IP-адрес хоста будет подменяться на его FQDN. Подробнее об этой настройке и сферах ее применения см. в разделе [{#T}](../concepts/network.md#fqdn-ip-setting).

{% include [fqdn-option-compatibility-note](../../_includes/mdb/mrd/connect/fqdn-option-compatibility-note.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы включить или выключить использование FQDN вместо IP-адресов:

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Выберите нужный кластер.
    1. В верхней части страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** включите или выключите опцию **{{ ui-key.yacloud.redis.field_announce-hostnames }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы включить или выключить использование FQDN вместо IP-адресов:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-rd }} cluster update --help
        ```

    1. Укажите нужное значение настройки в команде изменения кластера:

        ```bash
        {{ yc-mdb-rd }} cluster update <имя_или_идентификатор_кластера> \
          --announce-hostnames <использование_FQDN_вместо_IP-адресов>
        ```

        Где `--announce-hostnames` — настройка, определяющая, использовать ли FQDN вместо IP-адресов: `true` или `false`.

        Имя и идентификатор кластера можно [получить со списком кластеров в каталоге](./cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    Чтобы включить или выключить использование FQDN вместо IP-адресов:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

    1. Измените в описании кластера {{ mrd-name }} значение параметра `announce_hostnames`:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<имя_кластера>" {
          name        = "<имя_кластера>"
          ...
          announce_hostnames    = <использование_FQDN_вместо_IP-адресов>
          ...
        }
        ```

        Где `announce_hostnames` — настройка, определяющая, использовать ли FQDN вместо IP-адресов: `true` или `false`.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API {#api}

    Чтобы включить или выключить использование FQDN вместо IP-адресов, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Нужное значение флага `announceHostnames` — `true` или `false`.
    * Список полей, которые необходимо изменить (в данном случае — `announceHostnames`), в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить класс хостов {#change-resource-preset}


При смене класса хостов:

* Кластер из одного хоста будет недоступен несколько минут, соединения с БД будут прерваны.
* В нешардированном кластере из нескольких хостов:
   * Сменится мастер. Каждый хост по очереди будет остановлен и обновлен, остановленный хост будет недоступен несколько минут.
   * Подключение по [особому FQDN](./connect/non-sharded.md#special-fqdns) не гарантирует стабильность соединения с БД: пользовательские сессии могут быть прерваны.
* В шардированном кластере:
   * В каждом шарде из нескольких хостов сменится мастер.
   * Хосты в каждом шарде по очереди будут остановлены и обновлены, остановленный хост-мастер шарда будет недоступен несколько минут.
   * Разрешение имени хоста-мастера может быть недоступно. Если включен публичный доступ к хосту, то подключение будет возможно только по IP-адресу хоста.

Рекомендуется изменять класс хостов только во время отсутствия рабочей нагрузки на кластер.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Выберите нужный кластер.
  1. В верхней части страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}**:
     
	 * В поле **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** выберите платформу.
     * Выберите **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** виртуальной машины, на которой разворачиваются хосты:
        * `high-memory` — с увеличенным объемом RAM на 1 vCPU;
        * `burstable` — с неполной гарантированной долей vCPU. ВМ с гарантированной долей меньше 100% обеспечивают указанный уровень производительности с вероятностью временного повышения вплоть до 100%. Кластеры с такими хостами подходят для задач, которые не требуют постоянной гарантии производительности (например, тестирование).
     * Измените конфигурацию хостов.
	 
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-rd }} cluster update --help
     ```

  1. Запросите список доступных классов хостов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):


     ```bash
     {{ yc-mdb-rd }} resource-preset list
     ```

     Результат:


     ```text
     +-------------+--------------------------------+----------+
     |     ID      |            ZONE IDS            |  MEMORY  |
     +-------------+--------------------------------+----------+
     | b1.nano     | {{ region-id }}-a, {{ region-id }}-b,  | 2.0 GB   |
     |             | {{ region-id }}-d                  |          |
     | b1.small    | {{ region-id }}-a, {{ region-id }}-b,  | 4.0 GB   |
     |             | {{ region-id }}-d                  |          |
     | hm1.nano    | {{ region-id }}-a, {{ region-id }}-b,  | 8.0 GB   |
     |             | {{ region-id }}-d                  |          |
     | hm1.micro   | {{ region-id }}-a, {{ region-id }}-b,  | 12.0 GB  |
     | ...                                                     |
     +-----------+----------------------------------+----------+
     ```




  1. Укажите нужный класс в команде изменения кластера:

     ```bash
     {{ yc-mdb-rd }} cluster update <имя_или_идентификатор_кластера> \
       --resource-preset <идентификатор_класса_хостов>
     ```

     {{ mrd-short-name }} запустит операцию изменения класса хостов для кластера.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

    1. Измените в описании кластера {{ mrd-name }} значение параметра `resource_preset_id` в блоке `resources`:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<имя_кластера>" {
          ...
          resources {
            resource_preset_id = "<класс_хоста>"
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

- API {#api}

    Чтобы изменить класс хостов, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Новый класс хостов в параметре `configSpec.resources.resourcePresetId`.

        Чтобы получить список поддерживаемых значений, воспользуйтесь методом REST API [list](../api-ref/ResourcePreset/list.md) для ресурса [ResourcePreset](../api-ref/ResourcePreset/index.md) или вызовом gRPC API [ResourcePresetService/List](../api-ref/grpc/ResourcePreset/list.md).

    * Список полей, которые необходимо изменить (в данном случае — `configSpec.resources.resourcePresetId`), в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

Кластер {{ mrd-name }} недоступен около пяти — семи минут после изменения класса хостов.

## Увеличить размер хранилища {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы увеличить размер хранилища для кластера:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Выберите нужный кластер.
  1. В верхней части страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Измените настройки в блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы увеличить размер хранилища хостов {{ RD }}:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```bash
     {{ yc-mdb-rd }} cluster update --help
     ```

  1. Укажите нужный размер хранилища в команде изменения кластера. Новый размер должен быть не меньше, чем текущее значение `disk_size` в свойствах кластера.

     ```bash
     {{ yc-mdb-rd }} cluster update <имя_или_идентификатор_кластера> \
       --disk-size <размер_хранилища_ГБ>
     ```

     Если все условия выполнены, {{ mrd-short-name }} запустит операцию по увеличению размера дисков хостов {{ RD }}.

- {{ TF }} {#tf}

  Чтобы увеличить размер хранилища для кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

    1. Измените в описании кластера {{ mrd-name }} значение параметра `disk_size` в блоке `resources`:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<имя_кластера>" {
          ...
          resources {
            disk_size = <размер_хранилища_ГБ>
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

- API {#api}

  Чтобы увеличить размер хранилища для кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
  * Новый размер хранилища в параметре `configSpec.resources.diskSize`.
  * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `configSpec.resources.diskSize`).

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить настройки {{ RD }} {#change-redis-config}

Вы можете изменить настройки СУБД для хостов вашего кластера. Все поддерживаемые настройки описаны в разделе [{#T}](../concepts/settings-list.md) и в [справочнике API](../api-ref/Cluster/update.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить [настройки СУБД](../concepts/settings-list.md) для кластера:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Выберите нужный кластер.
  1. В верхней части страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. В разделе **{{ ui-key.yacloud.mdb.forms.section_settings }}** нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}**.
  1. Настройте доступные параметры в соответствии с [документацией {{ RD }}](https://redis.io/documentation).
  1. Нажмите кнопку **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.

- {{ TF }} {#tf}

    Чтобы изменить [настройки СУБД](../concepts/settings-list.md) для кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

    1. Измените в описании кластера {{ mrd-name }} значения параметров в блоке `config`:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<имя_кластера>" {
          ...
          config {
            password         = "<пароль>"
            timeout          = <время>
            maxmemory_policy = "<политика>"
            ...
          }
        }
        ```

        Где:

        * `timeout` — время в секундах перед отключением неактивных клиентов.
        * `maxmemory_policy` — политика управления памятью при ее дефиците.

        {% include [requirements-to-password](../../_includes/mdb/mrd/requirements-to-password.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API {#api}

    Чтобы изменить настройки {{ RD }}, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Нужные значения настроек {{ RD }} в параметре `configSpec.redisConfig_<версия_{{ RD }}>`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Выберите нужный кластер.
  1. В верхней части страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Измените дополнительные настройки кластера:

     {% include [mrd-extra-settings](../../_includes/mdb/mrd-extra-settings-web-console.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-rd }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:


        ```bash
        {{ yc-mdb-rd }} cluster update <имя_или_идентификатор_кластера> \
            --backup-window-start <время> \
            --maintenance-window type=<тип_технического_обслуживания>,`
                                `day=<день_недели>,`
                                `hour=<час_дня> \
            --websql-access=<true_или_false> \
            --deletion-protection
        ```


    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}
    
    * `--websql-access` — разрешает [выполнять SQL-запросы](web-sql-query.md) к базам данных кластера из консоли управления {{ yandex-cloud }} с помощью сервиса {{ websql-full-name }}. Значение по умолчанию — `false`.

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы изменить дополнительные настройки кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

    * Список полей конфигурации кластера, подлежащих изменению, в параметре `updateMask`.

    {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Включить шардирование {#enable-sharding}

В нешардированном кластере можно включить [шардирование](../concepts/sharding.md), чтобы кластер стал шардированным.

{% note warning %}

Отключить шардирование в кластере, для которого оно включено, невозможно.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы включить шардирование:

    1. Посмотрите описание команды CLI для включения шардирования:

        ```bash
        {{ yc-mdb-rd }} cluster enable-sharding --help
        ```

    1. Выполните команду:

        ```bash
        {{ yc-mdb-rd }} cluster enable-sharding <идентификатор_кластера>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    {% include [enable-sharding-shard-note](../../_includes/mdb/mrd/enable-sharding-shard-note.md) %}

- API {#api}

    Чтобы включить шардирование, воспользуйтесь методом REST API [enableSharding](../api-ref/Cluster/enableSharding.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/EnableSharding](../api-ref/grpc/Cluster/enableSharding.md) и передайте в запросе идентификатор кластера в параметре `clusterId` (`cluster_id` для gRPC).

    Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

    {% include [enable-sharding-shard-note](../../_includes/mdb/mrd/enable-sharding-shard-note.md) %}

{% endlist %}

## Переместить кластер {#move-cluster}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке кластера, который вы хотите переместить.
    1. Выберите пункт **{{ ui-key.yacloud.mdb.clusters.button_action-move }}**.
    1. Выберите каталог, в который вы хотите переместить кластер.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы переместить кластер:

    1. Посмотрите описание команды CLI для перемещения кластера:

        ```bash
        {{ yc-mdb-rd }} cluster move --help
        ```

    1. Укажите каталог назначения в команде перемещения кластера:

        ```bash
        {{ yc-mdb-rd }} cluster move <идентификатор_кластера> \
           --destination-folder-name=<имя_каталога_назначения>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы переместить кластер, воспользуйтесь методом REST API [move](../api-ref/Cluster/move.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Move](../api-ref/grpc/Cluster/move.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Идентификатор каталога назначения в параметре `destinationFolderId`.

{% endlist %}


## Изменить группы безопасности {#change-sg-set}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
    1. Выберите нужный кластер.
    1. В верхней части страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите группы безопасности для сетевого трафика кластера.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-rd }} cluster update --help
        ```

    1. Укажите нужные группы безопасности в команде изменения кластера:

        ```bash
        {{ yc-mdb-rd }} cluster update <имя_или_идентификатор_кластера> \
          --security-group-ids <список_идентификаторов_групп_безопасности>
        ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](./cluster-create.md).

    1. Измените в описании кластера {{ mrd-name }} значение параметра `security_group_ids`:

        ```hcl
        resource "yandex_mdb_redis_cluster" "<имя_кластера>" {
          ...
          security_group_ids = [<список_идентификаторов_групп_безопасности>]
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mrd }}).

    {% include [Terraform timeouts](../../_includes/mdb/mrd/terraform/timeouts.md) %}

- API {#api}

    Чтобы изменить группы безопасности, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Список идентификаторов групп безопасности в параметре `securityGroupIds`.
    * Список настроек, которые необходимо изменить (в данном случае — `securityGroupIds`), в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}

