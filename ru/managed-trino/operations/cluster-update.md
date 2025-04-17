---
title: Изменение кластера {{ TR }}
description: После создания кластера {{ TR }} вы можете изменить его основные и дополнительные настройки.
keywords:
  - изменение кластера {{ TR }}
  - кластер {{ TR }}
  - '{{ TR }}'
noIndex: true
---

# Изменение кластера {{ TR }}

{% include [preview](../../_includes/managed-trino/note-preview.md) %}

После создания кластера вы можете изменить его основные и дополнительные настройки.

{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы изменить настройки кластера:

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

        * Измените имя и описание кластера.
        * Удалите или добавьте новые [метки](../../resource-manager/concepts/labels.md).
        * Выберите сервисный аккаунт или [создайте новый](../../iam/operations/sa/create.md#create-sa) с ролями `managed-trino.integrationProvider` и `storage.editor`. Это даст кластеру нужные права для работы с пользовательскими ресурсами.

            Для изменения сервисного аккаунта в кластере {{ mtr-name }} [убедитесь](../../iam/operations/roles/get-assigned-roles.md), что вашему аккаунту в {{ yandex-cloud }} назначена роль [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) или выше.

            {% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите группу безопасности для кластера.
    1. Измените конфигурацию [координатора](../concepts/index.md#coordinator) и [воркеров](../concepts/index.md#workers).
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** установите или снимите защиту от удаления кластера.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_additional }}** включите или выключите запись логов. Если логирование включено, укажите, в какую лог-группу или каталог будут записываться логи и минимальный уровень логирования.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}
