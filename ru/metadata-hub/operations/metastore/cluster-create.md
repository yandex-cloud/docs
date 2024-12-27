---
title: Как создать кластер {{ metastore-full-name }}
description: Следуя данной инструкции, вы сможете создать кластер {{ metastore-full-name }}.
---

# Создание кластера {{ metastore-full-name }}

{% include [Preview](../../../_includes/note-preview.md) %}

Подробнее о кластерах {{ metastore-name }} в сервисе {{ metadata-hub-name }} см. в разделе [{#T}](../../concepts/metastore.md).

## Перед началом работы {#before-you-begin}

1. Для привязки [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) к кластеру {{ metastore-name }} [убедитесь](../../../iam/operations/roles/get-assigned-roles.md), что вашему аккаунту в {{ yandex-cloud }} назначена роль [iam.serviceAccounts.user](../../../iam/security/index.md#iam-serviceAccounts-user) или выше.
1. [Настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) в подсети, к которой будет подключен кластер. Это необходимо, чтобы кластер мог взаимодействовать с сервисами {{ yandex-cloud }}.
1. [Настройте группу безопасности](configure-security-group.md).
1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту](../../../iam/operations/sa/assign-role-for-sa.md) роль `{{ roles.metastore.integrationProvider }}`. Она позволяет кластеру от имени сервисного аккаунта [взаимодействовать с сервисами](../../concepts/metastore-impersonation.md) {{ yandex-cloud }}, например, с {{ cloud-logging-full-name }} и {{ monitoring-full-name }}.

    Вы можете добавить дополнительные роли. Их набор зависит от сценария работы. Сервисные роли приведены в [разделе для {{ metastore-name }}](../../security/metastore-roles.md), все доступные роли — в [справочнике](../../../iam/roles-reference.md).

1. Если вы хотите сохранять логи кластера в пользовательскую лог-группу, [создайте ее](../../../logging/operations/create-group.md).

    Подробнее см. в разделе [Передача логов кластера](logging.md).

## Создайте кластер {#create-cluster}

{% note warning %}

Кластеры {{ metastore-name }} недоступны для редактирования, поэтому после создания кластера нельзя изменить его настройки.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать сервер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. На левой панели выберите страницу ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Введите имя кластера. Оно должно быть уникальным в рамках каталога.
    1. (Опционально) Введите описание кластера.
    1. (Опционально) Добавьте [метки {{ yandex-cloud }}](../../../resource-manager/concepts/labels.md) для разделения ресурсов на логические группы.
    1. Укажите сервисный аккаунт, созданный ранее.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите сеть и подсеть, в которых будет размещен кластер {{ metastore-name }}. Укажите заранее настроенную группу безопасности.
    1. (Опционально) Задайте настройки логирования:

        1. Включите опцию **{{ ui-key.yacloud.logging.field_logging }}**.
        1. Выберите, куда записывать логи кластера:

            * В лог-группу по умолчанию — выберите значение **{{ ui-key.yacloud.common.folder }}** в поле **{{ ui-key.yacloud.logging.label_destination }}** и укажите нужный каталог. Логи будут храниться в лог-группе, которая действует по умолчанию в выбранном каталоге.
            * В пользовательскую лог-группу — выберите значение **{{ ui-key.yacloud.logging.label_loggroup }}** в поле **{{ ui-key.yacloud.logging.label_destination }}** и укажите заранее созданную лог-группу.

        1. Выберите минимальный уровень логирования.

            В журнал выполнения записываются логи указанного уровня и выше. Доступные уровни — `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` и `FATAL`. Уровень по умолчанию — `INFO`.
    1. При необходимости включите защиту кластера от непреднамеренного удаления пользователем.

        {% include [Ограничения защиты от удаления кластера](../../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
