---
title: Изменение кластера {{ SPQR }}
description: После создания кластера {{ SPQR }} вы можете изменить его основные и дополнительные настройки.
keywords:
  - изменение кластера {{ SPQR }}
  - кластер {{ SPQR }}
  - '{{ SPQR }}'
---

# Изменение кластера {{ SPQR }}

{% include notitle [preview](../../_includes/note-preview.md) %}

После создания кластера вы можете изменить его основные и дополнительные настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * Измените имя и описание кластера.
        * Удалите или добавьте новые [метки](../../resource-manager/concepts/labels.md).

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите группы безопасности для кластера.

    1. Измените конфигурацию вычислительных ресурсов:

        * Для стандартного шардирования измените в блоке **{{ ui-key.yacloud.spqr.section_infra }}** конфигурацию инфраструктурных хостов.
        * Для расширенного шардирования измените в блоке **{{ ui-key.yacloud.spqr.section_router }}** конфигурацию хостов-роутеров. Если используется координатор, в блоке **{{ ui-key.yacloud.spqr.section_coordinator }}** измените конфигурацию хостов-координаторов.

        Чтобы изменить конфигурацию вычислительных ресурсов:

        1. В поле **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** измените платформу.
        1. Измените **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** виртуальной машины, на которой развернуты хосты.
        1. Измените **{{ ui-key.yacloud.mdb.forms.section_resource }}**.
        1. В блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}** измените тип диска и размер хранилища.

    1. Измените дополнительные настройки кластера:

        {% include [extra-settings](../../_includes/mdb/mspqr/console/extra-settings.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}
