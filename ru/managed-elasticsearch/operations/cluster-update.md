---
title: Изменение настроек кластера Elasticsearch
description: После создания кластера вы можете изменить настройки класса хостов, увеличить размер хранилища или изменить дополнительные настройки кластера Elasticsearch.
keywords:
  - настройки Elasticsearch
  - настройки кластера Elasticsearch
  - Elasticsearch
---

# Изменение настроек кластера {{ ES }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

После создания кластера вы можете:


* [Изменить настройки сервисного аккаунта](#change-service-account).


* [{#T}](#change-resource-preset).
* [{#T}](#change-disk-size).
* [Настроить серверы](#change-elasticsearch-config) {{ ES }} согласно [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/snapshot-restore.html).
* [{#T}](#change-admin-password).
* [{#T}](#change-additional-settings).

Подробнее о других изменениях кластера:

* [{#T}](cluster-version-update.md).

* [Миграция хостов кластера в другую зону доступности](host-migration.md).


## Изменить настройки сервисного аккаунта {#change-service-account}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
    1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. Выберите нужный сервисный аккаунт из списка или [создайте новый](../../iam/operations/sa/create.md). Подробнее о настройке сервисного аккаунта см. в разделе [Настройка доступа к {{ objstorage-name }} из кластера](s3-access.md).

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить настройки сервисного аккаунта, используемого для работы с кластером:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-es }} cluster update --help
        ```

    1. Укажите идентификатор сервисного аккаунта в команде изменения кластера:

        ```bash
        {{ yc-mdb-es }} cluster update <имя_или_идентификатор_кластера> \
          --service-account-id <идентификатор_сервисного_аккаунта>
        ```

        Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    {{ mes-short-name }} запустит операцию изменения сервисного аккаунта для кластера.

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

       О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Укажите в поле описания кластера `service_account_id` идентификатор сервисного аккаунта:

        ```hcl
        resource "yandex_mdb_elasticsearch_cluster" "<имя_кластера>" {
          ...
          service_account_id = <идентификатор_сервисного_аккаунта>
        }
        ```

    1. Проверьте корректность настроек.

       {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

       {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

    Чтобы изменить настройки сервисного аккаунта, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

    * Идентификатор сервисного аккаунта, используемого для работы с кластером, в параметре `serviceAccountId`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}


## Изменить класс хостов {#change-resource-preset}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. Чтобы изменить класс хостов {{ ES }} с ролью *Data node*:
     1. Выберите вкладку **Data node**.
     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите нужный класс для хоста.
  1. Чтобы изменить класс хостов {{ ES }} с ролью *Master node*:
     1. Выберите вкладку **Master node**.
     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите нужный класс для хоста.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-es }} cluster update --help
        ```

    1. Укажите нужный класс для хостов с ролью _Data node_ и _Master node_ в команде изменения кластера:

        ```bash
        {{ yc-mdb-es }} cluster update <имя_или_идентификатор_кластера> \
          --datanode-resource-preset <класс_хостов_с_ролью_Data_node> \
          --masternode-resource-preset <класс_хостов_с_ролью_Master_node>
        ```

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mes-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mes }}).

  1. Измените в описании кластера {{ mes-name }} значение атрибута `resource_preset_id` в блоке `config.data_node.resources` или `config.master_node.resources`:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<имя_кластера>" {
        ...
        config {
          data_node {
            resources {
              resource_preset_id = "<класс_хоста>"
              ...
            }
          }

          master_node {
            resources {
              resource_preset_id = "<класс_хоста>"
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

- API {#api}

  Чтобы изменить класс хостов, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

  * Класс хостов в параметрах:
      * `configSpec.elasticsearchSpec.dataNode.resources.resourcePresetId`  — для хостов с ролью *Data node*.
      * `configSpec.elasticsearchSpec.masterNode.resources.resourcePresetId` — для хостов с ролью *Master node*.

      Список поддерживаемых значений запрашивайте методом [list](../api-ref/ResourcePreset/list.md) для ресурсов `ResourcePreset`.

  * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Увеличить размер хранилища {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы увеличить размер хранилища для кластера:

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. Чтобы увеличить размер диска для хостов {{ ES }} с ролью *Data node*:
     1. Выберите вкладку **Data node**.
     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}** укажите необходимый размер диска.
  1. Чтобы увеличить размер диска для хостов {{ ES }} с ролью *Master node*:
     1. Выберите вкладку **Master node**.
     1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}** укажите необходимый размер диска.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы увеличить размер хранилища для кластера:

    1. Посмотрите описание команды CLI для изменения конфигурации:

        ```bash
        {{ yc-mdb-es }} cluster update --help
        ```

    1. Укажите новые [параметры хранилища](../concepts/storage.md) для хостов с ролью _Data node_ и _Master node_ в команде изменения кластера:

        ```bash
        {{ yc-mdb-es }} cluster update <имя_или_идентификатор_кластера> \
          --datanode-disk-size <размер_хранилища_ГБ_Data_node> \
          --masternode-disk-size <размер_хранилища_ГБ_Master_node>
        ```

        Где:

        * `--datanode-disk-size` — размер хранилища в гигабайтах для хостов с ролью Data node.
        * `--masternode-disk-size` — размер хранилища в гигабайтах для хостов с ролью Master node.

    Имя и идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  Чтобы увеличить размер хранилища для кластера:

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mes-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mes }}).

  1. Измените в описании кластера {{ mes-name }} значение атрибута `disk_size` в блоке `config.data_node.resources` или `config.master_node.resources`:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<имя_кластера>" {
        ...
        config {
          data_node {
            resources {
              disk_size = <размер_хранилища_ГБ>
              ...
            }
          }

          master_node {
            resources {
              disk_size = <размер_хранилища_ГБ>
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


- API {#api}

  Чтобы увеличить размер хранилища для кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

  * Необходимый размер хранилища (в байтах) в параметрах:
    * `configSpec.elasticsearchSpec.dataNode.resources.diskSize` — для хостов с ролью *Data node*.
    * `configSpec.elasticsearchSpec.masterNode.resources.diskSize` — для хостов с ролью *Master node*.
  * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}


{% endlist %}

## Изменить настройки {{ ES }} {#change-elasticsearch-config}

Вы можете изменить настройки СУБД для хостов вашего кластера.

{% note warning %}

Вы не можете менять настройки {{ ES }} с помощью {{ ES }} API.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
    1. Выберите кластер и нажмите кнопку ![Pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. Измените [настройки {{ ES }}](../concepts/settings-list.md), нажав кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить [настройки сервера {{ ES }}](../concepts/settings-list.md):

    1. Посмотрите полный список настроек, установленных для кластера:

        ```bash
        {{ yc-mdb-es }} cluster get <имя_или_идентификатор_кластера> --full
        ```

    1. Посмотрите описание команды CLI для изменения конфигурации кластера:

        ```bash
        {{ yc-mdb-es }} cluster update-config --help
        ```

    1. Установите нужные значения параметров:

        ```bash
        {{ yc-mdb-es }} cluster update-config <имя_или_идентификатор_кластера> \
           --set <имя_параметра_1>=<значение_1>,<имя_параметра_2>=<значение_2>,...
        ```

        Все поддерживаемые параметры приведены в разделе [{#T}](../concepts/settings-list.md).

- API {#api}

    Чтобы изменить настройки {{ ES }}, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.

      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

    * Нужные значения настроек СУБД в параметре `configSpec.elasticsearchSpec.dataNode.elastcsearchConfig_7`.
    * Список настроек, которые необходимо изменить, в параметре `updateMask`. Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.

    Все поддерживаемые настройки описаны в разделе [{#T}](../concepts/settings-list.md) и в [справочнике API](../api-ref/Cluster/update.md).

{% endlist %}

## Изменить пароль пользователя admin {#change-admin-password}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. Укажите новый пароль пользователя `admin` в блоке **{{ ui-key.yacloud.mdb.forms.section_user }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

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
         {{ yc-mdb-es }} cluster update <имя_кластера> \
           --read-admin-password
         ```

       * Ввод пароля открытым текстом (менее безопасный способ).

         ```bash
         {{ yc-mdb-es }} cluster update <имя_кластера> \
           --admin-password <новый_пароль>
         ```

       * Автоматическая генерация пароля. Сгенерированный пароль будет выведен в консоль.

         ```bash
         {{ yc-mdb-es }} cluster update <имя_кластера> \
           --generate-admin-password
         ```

    {{ mes-short-name }} запустит операцию изменения пароля `admin` для кластера.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mes-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mes }}).

  1. Измените в описании кластера {{ mes-name }} значение атрибута `admin_password` в блоке `config`:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<имя_кластера>" {
        ...
        config {
          admin_password = "<новый_пароль_пользователя-администратора>"
          ...
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

  Чтобы изменить пароль пользователя `admin`, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`.

    {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

  * Новый пароль в параметре `configSpec.adminPassword`. Длина пароля — до 128 символов.
  * Список настроек, которые необходимо изменить (в данном случае — `configSpec.adminPassword`), в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
    1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. Измените дополнительные настройки кластера:

        {% include [Дополнительные настройки кластера MES](../../_includes/mdb/mes/extra-settings.md) %}

    1. Задайте настройки СУБД:

        Доступна настройка параметра `Fielddata cache size` — процент или абсолютное значение области динамической памяти, которая выделена для кеша `fielddata`, например: 10% или 512 МБ.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-es }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        {{ yc-mdb-es }} cluster update <имя_или_идентификатор_кластера> \
           --plugins <имя_плагина_1>,...,<имя_плагина_N> \
           --maintenance-window type=<тип_технического_обслуживания>,`
                               `day=<день_недели>,`
                               `hour=<час_дня> \
           --deletion-protection=<защита_от_удаления>
        ```

    Вы можете изменить следующие настройки:

    * `--plugins` — список [плагинов {{ ES }}](cluster-plugins.md#elasticsearch), доступных в кластере. При этом плагины, не упомянутые в списке, будут выключены.

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mes-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mes }}).

  1. {% include [Maintenance window](../../_includes/mdb/mes/terraform/maintenance-window.md) %}

  1. Чтобы изменить список [плагинов {{ ES }}](cluster-plugins.md#elasticsearch), измените значение параметра `plugins` в блоке `config` описания кластера:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<имя_кластера>" {
        ...
        config {
          plugins = [ "<список_имен_плагинов>" ]
        }
      }
      ```

      Плагины, не упомянутые в списке, будут выключены.

  1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

      ```hcl
      resource "yandex_mdb_elasticsearch_cluster" "<имя_кластера>" {
        ...
        deletion_protection = <защита_от_удаления>
      }
      ```

      Где `deletion_protection` — защита от удаления кластера: `true` или `false`.

      {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mes/terraform/timeouts.md) %}

- API {#api}

    Чтобы изменить дополнительные настройки кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`.
    
      {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

    * Список [плагинов {{ ES }}](cluster-plugins.md#elasticsearch) в параметре `plugins`.

    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.

    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-data.md) %}

    * Настройки доступа из [{{ data-transfer-full-name }}](../../data-transfer/index.yaml) в параметре `configSpec.access.dataTransfer`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
