---
title: Изменение настроек кластера Elasticsearch
description: 'После создания кластера вы можете изменить настройки класса хостов, увеличить размер хранилища или изменить дополнительные настройки кластера Elasticsearch.'
keywords:
  - настройки Elasticsearch
  - настройки кластера Elasticsearch
  - Elasticsearch
---

# Изменение настроек {{ ES }}-кластера

После создания кластера вы можете:

* [{#T}](#change-service-account).
* [{#T}](#change-resource-preset).
* [{#T}](#change-disk-size).
* [{#T}](#change-elasticsearch-config).
* [{#T}](#change-admin-password).
* [{#T}](#change-additional-settings).

Вы также можете обновить версию и изменить редакцию {{ ES }}. Подробнее см. в разделе [{#T}](./cluster-version-update.md).

## Изменить настройки сервисного аккаунта {#change-service-account}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mes-name }}**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.

    
    1. Выберите нужный сервисный аккаунт из списка или [создайте новый](../../iam/operations/sa/create.md). Подробнее о настройке сервисного аккаунта см. в разделе [{#T}](s3-access.md).


       {% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

{% endlist %}


## Изменить класс хостов {#change-resource-preset}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mes-name }}**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. Чтобы изменить класс хостов {{ ES }} с ролью *Data node*:
     1. Выберите вкладку **Data node**.
     1. В блоке **Класс хоста** выберите нужный класс для хоста.
  1. Чтобы изменить класс хостов {{ ES }} с ролью *Master node*:
     1. Выберите вкладку **Master node**.
     1. В блоке **Класс хоста** выберите нужный класс для хоста.
  1. Нажмите кнопку **Сохранить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-es }} cluster update --help
        ```

    1. Укажите нужный класс для хостов с ролью _Data node_ и _Master node_ в команде изменения кластера:

        ```bash
        {{ yc-mdb-es }} cluster update <имя или идентификатор кластера> \
          --datanode-resource-preset <класс хостов с ролью Data node> \
          --masternode-resource-preset <класс хостов с ролью Master node>
        ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mes-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mes }}).

  1. Измените в описании кластера {{ mes-name }} значение атрибута `resource_preset_id` в блоке `config.data_node.resources` или `config.master_node.resources`:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<имя кластера>" {
        ...
        config {
          data_node {
            resources {
              resource_preset_id = "<класс хоста>"
              ...
            }
          }

          master_node {
            resources {
              resource_preset_id = "<класс хоста>"
              ...
            }
          }
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

  Воспользуйтесь методом [update](../api-ref/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Класс хостов в параметрах:
      * `configSpec.elasticsearchSpec.dataNode.resources.resourcePresetId`  — для хостов с ролью *Data node*.
      * `configSpec.elasticsearchSpec.masterNode.resources.resourcePresetId` — для хостов с ролью *Master node*.

      Список поддерживаемых значений запрашивайте методом [list](../api-ref/ResourcePreset/list.md) для ресурсов `ResourcePreset`.

  * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Увеличить размер хранилища {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Консоль управления

  Чтобы увеличить размер хранилища для кластера:

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mes-name }}**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. Чтобы увеличить размер диска для хостов {{ ES }} с ролью *Data node*:
     1. Выберите вкладку **Data node**.
     1. В блоке **Хранилище** укажите необходимый размер диска.
  1. Чтобы увеличить размер диска для хостов {{ ES }} с ролью *Master node*:
     1. Выберите вкладку **Master node**.
     1. В блоке **Хранилище** укажите необходимый размер диска.
  1. Нажмите кнопку **Сохранить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы увеличить размер хранилища для кластера:

    1. Посмотрите описание команды CLI для изменения конфигурации:

        ```bash
        {{ yc-mdb-es }} cluster update --help
        ```

    1. Укажите новые [параметры хранилища](../concepts/storage.md) для хостов с ролью _Data node_ и _Master node_ в команде изменения кластера:

        ```bash
        {{ yc-mdb-es }} cluster update <имя или идентификатор кластера> \
          --datanode-disk-size <размер хранилища в гигабайтах для хостов с ролью Data node> \
          --masternode-disk-size <размер хранилища в гигабайтах для хостов с ролью Master node>
        ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

  Чтобы увеличить размер хранилища для кластера:

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mes-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mes }}).

  1. Измените в описании кластера {{ mes-name }} значение атрибута `disk_size` в блоке `config.data_node.resources` или `config.master_node.resources`:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<имя кластера>" {
        ...
        config {
          data_node {
            resources {
              disk_size = <объем хранилища, ГБ>
              ...
            }
          }

          master_node {
            resources {
              disk_size = <объем хранилища, ГБ>
              ...
            }
          }
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}


- API

  Чтобы увеличить размер хранилища для кластера, воспользуйтесь методом [update](../api-ref/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Необходимый размер хранилища (в байтах) в параметрах:
    * `configSpec.elasticsearchSpec.dataNode.resources.diskSize`  — для хостов с ролью *Data node*.
    * `configSpec.elasticsearchSpec.masterNode.resources.diskSize` — для хостов с ролью *Master node*.
  * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}


{% endlist %}

## Изменить настройки {{ ES }} {#change-elasticsearch-config}

Вы можете изменить настройки СУБД для хостов вашего кластера.

{% note warning %}

Вы не можете менять настройки {{ ES }} с помощью {{ ES }} API.

{% endnote %}

{% list tabs %}

- Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ mes-name }}**.
    1. Выберите кластер и нажмите кнопку **![Pencil](../../_assets/pencil.svg) Изменить кластер** на панели сверху.
    1. Измените [настройки {{ ES }}](../concepts/settings-list.md), нажав кнопку **Настроить** в блоке **Настройки СУБД**.
    1. Нажмите кнопку **Сохранить**.
    1. Нажмите кнопку **Сохранить изменения**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить [настройки сервера {{ ES }}](../concepts/settings-list.md):

    1. Посмотрите полный список настроек, установленных для кластера:

        ```bash
        {{ yc-mdb-es }} cluster get <идентификатор или имя кластера> --full
        ```

    1. Посмотрите описание команды CLI для изменения конфигурации кластера:

        ```bash
        {{ yc-mdb-es }} cluster update-config --help
        ```

    1. Установите нужные значения параметров:

        ```bash
        {{ yc-mdb-es }} cluster update-config <идентификатор или имя кластера> \
           --set <имя параметра1>=<значение1>,<имя параметра2>=<значение2>,...
        ```

        Все поддерживаемые параметры приведены в разделе [{#T}](../concepts/settings-list.md).

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Его можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).
    * Нужные значения настроек СУБД в параметре `configSpec.elasticsearchSpec.dataNode.elastcsearchConfig_7`.
    * Список настроек, которые необходимо изменить, в параметре `updateMask`. Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.

    Все поддерживаемые настройки описаны в разделе [{#T}](../concepts/settings-list.md) и в [справочнике API](../api-ref/Cluster/update.md).

{% endlist %}

## Изменить пароль пользователя admin {#change-admin-password}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mes-name }}**.
  1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
  1. Укажите новый пароль пользователя `admin` в блоке **Пользователь**.
  1. Нажмите кнопку **Сохранить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить пароль пользователя `admin` для кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-es }} cluster update --help
        ```

    1. Укажите новый пароль в команде изменения кластера одним из возможных способов:

       * Ввод пароля в интерактивном режиме.

         ```bash
         {{ yc-mdb-es }} cluster update <имя кластера> \
           --read-admin-password
         ```

       * Ввод пароля открытым текстом (менее безопасный способ).

         ```bash
         {{ yc-mdb-es }} cluster update <имя кластера> \
           --admin-password <новый пароль>
         ```

       * Автоматическая генерация пароля. Сгенерированный пароль будет выведен в консоль.

         ```bash
         {{ yc-mdb-es }} cluster update <имя кластера> \
           --generate-admin-password
         ```

    {{ mes-short-name }} запустит операцию изменения пароля `admin` для кластера.

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mes-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mes }}).

  1. Измените в описании кластера {{ mes-name }} значение атрибута `admin_password` в блоке `config`:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<имя кластера>" {
        ...
        config {
          admin_password = "<новый пароль пользователя-администратора>"
          ...
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

  Воспользуйтесь методом [update](../api-ref/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Новый пароль в параметре `configSpec.adminPassword`. Длина пароля — до 128 символов.
  * Список настроек, которые необходимо изменить (в данном случае — `configSpec.adminPassword`), в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mes-name }}**.
    1. Выберите кластер и нажмите кнопку **Редактировать** на панели сверху.
    1. Чтобы изменить сервисный аккаунт, используемый для работы с кластером, выберите его из выпадающего списка.
    1. Измените дополнительные настройки кластера:

        {% include [Дополнительные настройки кластера MES](../../_includes/mdb/mes/extra-settings.md) %}

    1. Задайте настройки СУБД:

        Доступна настройка параметра `Fielddata cache size` — процент или абсолютное значение области динамической памяти, которая выделена для кеша `fielddata`, например: 10% или 512 МБ.

    1. Нажмите кнопку **Сохранить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-es }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        {{ yc-mdb-es }} cluster update <идентификатор или имя кластера> \
           --plugins <имя плагина 1>,...,<имя плагина N> \
           --maintenance-window type=<тип технического обслуживания: anytime или weekly>,`
                               `day=<день недели для типа weekly>,`
                               `hour=<час дня для типа weekly> \
           --deletion-protection=<защита от удаления кластера: true или false>
        ```

    Вы можете изменить следующие настройки:

    * `--plugins` — список [плагинов {{ ES }}](cluster-plugins.md#elasticsearch), доступных в кластере. При этом плагины, не упомянутые в списке, будут выключены.

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров):

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mes-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mes }}).

  1. Чтобы изменить сервисный аккаунт, используемый для работы с кластером, укажите в поле `service_account_id` описания кластера идентификатор другого сервисного аккаунта:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<имя кластера>" {
        ...
        service_account_id = <идентификатор другого сервисного аккаунта>
      }
      ```

  1. {% include [Maintenance window](../../_includes/mdb/mes/terraform/maintenance-window.md) %}

  1. Чтобы изменить список [плагинов {{ ES }}](cluster-plugins.md#elasticsearch), измените значение параметра `plugins` в блоке `config` описания кластера:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<имя кластера>" {
        ...
        config {
          plugins = [ "<список имен плагинов>" ]
        }
      }
      ```

      Плагины, не упомянутые в списке, будут выключены.

  1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<имя кластера>" {
        ...
        deletion_protection = <защита от удаления кластера: true или false>
      }
      ```

      {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).

    * Список [плагинов {{ ES }}](cluster-plugins.md#elasticsearch) в параметре `plugins`.

    
    * Идентификатор [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), используемого для работы с кластером, в параметре `serviceAccountId`.


    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.

    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
