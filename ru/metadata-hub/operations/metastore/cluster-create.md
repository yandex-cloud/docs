---
title: Как создать кластер {{ metastore-full-name }}
description: Следуя данной инструкции, вы сможете создать кластер {{ metastore-full-name }}.
---

# Создание кластера {{ metastore-full-name }}

{% include [Preview](../../../_includes/note-preview.md) %}

Подробнее о кластерах {{ metastore-name }} в сервисе {{ metadata-hub-name }} см. в разделе [{#T}](../../concepts/metastore.md).

Перед началом работы:

1. [Настройте сеть](#set-up-network).
1. [Настройте группы безопасности](#set-up-security-groups).
1. (Опционально) [Подготовьте статический ключ доступа](#prepare-access-key).

После этого [создайте кластер](#create-cluster).

## Настройте сеть {#set-up-network}

В подсети, к которой будет подключен кластер, [настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md). Это необходимо, чтобы кластер мог взаимодействовать с сервисами {{ yandex-cloud }}.

## Настройте группы безопасности {#set-up-security-groups}

Если в вашей облачной сети используются группы безопасности, они могут препятствовать работе кластера. В этом случае настройте группу безопасности по умолчанию на работу с {{ metastore-name }}. Для этого [добавьте](../../../vpc/operations/security-group-add-rule.md) в нее следующие правила:

* Для входящего трафика от клиентов:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `30000-32767`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

* Для входящего трафика от балансировщика:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `10256`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`.

Если планируется использовать несколько групп безопасности для кластера, разрешите весь трафик между этими группами.

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

{% endnote %}

## (Опционально) Подготовьте статический ключ доступа {#prepare-access-key}

Чтобы кластер {{ metastore-name }} мог взаимодействовать с [{{ objstorage-full-name }}](../../../storage/index.yaml), подготовьте [статический ключ доступа](../../../iam/concepts/authorization/access-key.md):

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту](../../../iam/operations/sa/assign-role-for-sa.md) необходимые роли.

   Набор ролей зависит от сценария работы. Сервисные роли приведены в [разделе для {{ metastore-name }}](../../security/metastore-roles.md), все доступные роли — в [справочнике](../../../iam/roles-reference.md).

1. [Создайте статический ключ доступа](../../../iam/operations/sa/create-access-key.md) для сервисного аккаунта.
1. Сохраните идентификатор и секретный ключ, они доступны только при создании.

## Создайте кластер {#create-cluster}

{% list tabs group=instructions %}

* Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать сервер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. На левой панели выберите страницу ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Введите имя кластера. Оно должно быть уникальным в рамках каталога.
    1. (Опционально) Введите описание кластера.
    1. (Опционально) Добавьте [метки {{ yandex-cloud }}](../../../resource-manager/concepts/labels.md) для разделения ресурсов на логические группы.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** выберите сеть и подсеть, в которых будет размещен кластер {{ metastore-name }}. Укажите заранее настроенную группу безопасности.
    1. (Опционально) В блоке **{{ ui-key.yacloud.metastore.title_s3config }}** укажите **{{ ui-key.yacloud.metastore.field_s3config-access-key-id }}** и **{{ ui-key.yacloud.metastore.field_s3config-secret-access-key }}** статического ключа доступа.
    1. При необходимости включите защиту кластера от непреднамеренного удаления пользователем.

        {% include [Ограничения защиты от удаления кластера](../../../_includes/mdb/deletion-protection-limits-data.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
