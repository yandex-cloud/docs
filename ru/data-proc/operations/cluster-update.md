---
title: Изменение кластера {{ dataproc-name }}
description: После создания кластера {{ dataproc-name }} вы можете изменить его основные и дополнительные настройки.
---

# Изменение кластера {{ dataproc-name }}

После создания кластера вы можете изменить его основные и дополнительные настройки.


Вы можете выключить передачу логов кластера в сервис {{ cloud-logging-full-name }}. Подробнее см. в разделе [Работа с логами](logging.md#disable-logs).


Кластер {{ dataproc-name }} также можно переместить в другую зону доступности. Процесс зависит от типа кластера:

* [Миграция легковесного кластера в другую зону доступности](migration-to-an-availability-zone.md).
* [Миграция кластера с файловой системой HDFS в другую зону доступности](../tutorials/hdfs-cluster-migration.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы изменить настройки кластера {{ dataproc-name }}:

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. Измените имя и описание кластера в полях **{{ ui-key.yacloud.mdb.forms.base_field_name }}** и **{{ ui-key.yacloud.mdb.forms.base_field_description }}**.
    1. Добавьте или удалите [метки](../../resource-manager/concepts/labels.md) кластера в поле **{{ ui-key.yacloud.component.label-set.label_labels }}**.
    1. Измените настройки кластера:

        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** — [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которому нужно разрешить доступ к кластеру {{ dataproc-full-name }}.

            Выберите существующий сервисный аккаунт или [создайте новый](../../iam/operations/sa/create.md).

            Для изменения сервисного аккаунта в кластере {{ dataproc-name }} [убедитесь](../../iam/operations/roles/get-assigned-roles.md), что вашему аккаунту в {{ yandex-cloud }} назначена роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.

            {% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

        * **{{ ui-key.yacloud.mdb.forms.config_field_properties }}** — [свойства компонентов](../concepts/settings-list.md) кластера.

            Добавьте, измените или удалите нужные свойства.

            {% note tip %}

            Если нужно, чтобы свойство было помещено в файл конфигурации, который [относится к определенному компоненту](../concepts/settings-list.md#available-properties), укажите [префикс](../concepts/settings-list.md) для ключа.

            {% endnote %}

        * **{{ ui-key.yacloud.mdb.forms.config_field_form-bucket-type }}** — формат, в котором будет указано имя [бакета](../../storage/concepts/bucket.md): **{{ ui-key.yacloud.forms.label_form-list }}** или **{{ ui-key.yacloud.forms.label_form-id }}**.

        * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}** — имя бакета, который будет использоваться кластером.

            В зависимости от выбранного формата либо выберите из списка бакет с нужным именем, либо укажите имя бакета вручную. Имя бакета можно запросить со [списком бакетов в каталоге](../../storage/operations/buckets/get-info.md#get-information).

        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}** — [группы безопасности](../concepts/network.md#security-groups), которые будут использоваться кластером.

            Выберите одну или несколько групп безопасности. Если нужной группы безопасности нет в списке — [создайте ее](../../vpc/operations/security-group-create.md).

            {% note warning %}

            Некорректные настройки групп безопасности могут препятствовать работе кластера {{ dataproc-full-name }}. Подробнее о настройке групп безопасности см. в разделе [Подключение к кластеру](./connect.md#configuring-security-groups).

            {% endnote %}

        * **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}** — опция, управляющая доступом к [веб-интерфейсам компонентов](../concepts/interfaces.md) через [UI Proxy](./connect-interfaces.md#ui-proxy).

            {% include [ui-proxy-sg-warning](../../_includes/data-processing/ui-proxy-sg-warning.md) %}

        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_log-group }}** — [лог-группа](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}, в которую кластер будет отправлять логи.

            Выберите лог-группу по умолчанию или другую существующую лог-группу. Если нужной лог-группы нет в списке — [создайте ее](../../logging/operations/create-group.md).

            Чтобы кластер мог отправлять логи, [назначьте](../../iam/operations/roles/grant.md) сервисному аккаунту кластера роль `logging.writer`. Подробнее см. в [документации {{ cloud-logging-full-name }}](../../logging/security/index.md).

    1. В дополнительных настройках кластера выберите нужное значение опции **{{ ui-key.yacloud.mdb.forms.label_deletion-protection }}**.

        Эта опция управляет защитой кластера от непреднамеренного удаления пользователем.

        Включенная защита не помешает подключиться к кластеру вручную и удалить данные.

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить настройки кластера {{ dataproc-name }}:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-dp }} cluster update --help
        ```

    
    1. Чтобы изменить [лог-группу](../../logging/concepts/log-group.md), в которую отправляются логи кластера, передайте идентификатор нужной лог-группы в параметре `--log-group-id`:

        ```bash
        {{ yc-dp }} cluster update <имя_или_идентификатор_кластера> \
           --log-group-id=<идентификатор_лог-группы>
        ```

        Идентификатор лог-группы можно получить со [списком лог-групп в каталоге](../../logging/operations/list.md).


    1. Чтобы защитить кластер от непреднамеренного удаления пользователем вашего облака, добавьте параметр `--deletion-protection`:

        ```bash
        {{ yc-dp }} cluster update <имя_или_идентификатор_кластера> \
           --deletion-protection
        ```

        Включенная защита не помешает подключиться к кластеру вручную и удалить данные.

    1. Чтобы изменить [свойства компонентов](../concepts/settings-list.md), передайте необходимые свойства в параметре `--property`:

        ```bash
        {{ yc-dp }} cluster update <имя_или_идентификатор_кластера> \
           --property "<префикс_ключа_1>:<ключ_1>=<значение>", "<префикс_ключа_2>:<ключ_2>=<значение>", ...
        ```

        {% note warning %}

        Использование параметра `--property` переопределит все свойства компонентов, которые не были явно переданы в параметре, на значения по умолчанию. Чтобы сохранить измененные ранее свойства, перечислите их в запросе наряду со свойствами, которые хотите изменить.

        {% endnote %}

    Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list).

- {{ TF }} {#tf}

    Чтобы изменить настройки кластера {{ dataproc-name }}:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Чтобы включить защиту от удаления кластера и доступ к [веб-интерфейсам компонентов](../concepts/interfaces.md) {{ dataproc-name }}, измените значения соответствующих полей в описании кластера {{ dataproc-name }}:

        ```hcl
        resource "yandex_dataproc_cluster" "data_cluster" {
          ...
          deletion_protection = true
          ui_proxy            = true
          ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/dataproc_cluster).

{% endlist %}
