# Обновление версии {{ OS }}

Вы можете обновить кластер {{ mos-name }} до более новой версии {{ OS }}.

Об обновлениях в рамках одной версии и обслуживании хостов см. в разделе [{#T}](../concepts/maintenance.md).

## Узнать доступные версии {#version-list}

{% list tabs %}

- Консоль управления

    В [консоли управления]({{ link-console-main }}) откройте страницу [создания](cluster-create.md) или [изменения кластера](update.md) {{ mos-name }}. Список доступен в поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}**.

{% endlist %}

## Перед обновлением версии {#before-version-update}

Убедитесь, что обновление не нарушит работу ваших приложений:

1. Посмотрите в [истории изменений](https://opensearch.org/docs/latest/version-history/) {{ OS }}, как обновления могут повлиять на работу ваших приложений.
1. Попробуйте обновить версию на тестовом кластере. Тестовый кластер можно развернуть из резервной копии основного кластера.
1. [Создайте резервную копию](cluster-backups.md) основного кластера непосредственно перед обновлением версии.

## Обновить версию {#start-version-update}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ mos-name }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. В поле **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите нужную версию {{ OS }}.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Новую версию {{ OS }} в параметре `configSpec.version`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `configSpec.version`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}
