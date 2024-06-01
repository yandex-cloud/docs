# Обновление версии {{ OS }}

Вы можете обновить кластер {{ mos-name }} до более новой версии {{ OS }}.

Об обновлениях в рамках одной версии и обслуживании хостов см. в разделе [Техническое обслуживание](../concepts/maintenance.md).

## Узнать доступные версии {#version-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    В [консоли управления]({{ link-console-main }}) откройте страницу [создания](cluster-create.md) или [изменения кластера](update.md) {{ mos-name }}. Список доступен в поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}**.

{% endlist %}

## Перед обновлением версии {#before-version-update}

Убедитесь, что обновление не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://opensearch.org/docs/latest/version-history/) {{ OS }}, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию на тестовом кластере. Его можно развернуть из резервной копии основного кластера.
1. [Создайте резервную копию](cluster-backups.md) основного кластера непосредственно перед обновлением версии.

## Обновить версию {#start-version-update}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите нужную версию {{ OS }}.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. Получите имя и идентификатор нужного кластера вместе со списком всех кластеров {{ OS }}:

        ```bash
        {{ yc-mdb-os }} cluster list
        ```

    1. Получите информацию о нужном кластере и проверьте версию в параметре `config.version`:

        ```bash
        {{ yc-mdb-os }} cluster get <имя_или_идентификатор_кластера>
        ```

    1. Обновите версию {{ OS }}:

        ```bash
        {{ yc-mdb-os }} cluster update <имя_или_идентификатор_кластера> \
           --version <версия_{{ OS }}>
        ```

- {{ TF }} {#tf}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mos-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mos }}).

    1. Измените в описании кластера значение параметра `version` в блоке `config`. Если такого параметра нет, добавьте его.

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<имя_кластера>" {
          ...
          config {
            version = "<версия_{{ OS }}>"
            ...
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mos/terraform/timeouts.md) %}

- API {#api}

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Новую версию {{ OS }} в параметре `configSpec.version`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `configSpec.version`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
