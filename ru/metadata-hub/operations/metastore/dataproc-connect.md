---
title: Как подключить {{ dataproc-name }} к {{ metastore-name }}
description: Следуя данной инструкции, вы сможете подключить {{ dataproc-name }} к {{ metastore-name }}.
---

# Подключение {{ dataproc-name }} к {{ metastore-name }}

{% note info %}

Для использования кластера {{ metastore-name }} [кластер {{ dataproc-full-name }}](../../../data-proc/concepts/index.md) должен содержать компоненты `SPARK` и `YARN`.

{% endnote %}

{% list tabs group=instructions %}

* Консоль управления {#console}

    1. [Создайте кластер](cluster-create.md) {{ metastore-name }}.
    1. При [создании](../../../data-proc/operations/cluster-create.md) или [изменении](../../../data-proc/operations/cluster-update.md) кластера {{ dataproc-name }} задайте следующее [свойство](../../../data-proc/concepts/settings-list.md):

        ```text
        spark:spark.hive.metastore.uris : thrift://<IP-адрес_кластера_{{ metastore-name }}>:{{ port-metastore }}
        ```

        Чтобы узнать IP-адрес кластера {{ metastore-name }}, в [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}** и на левой панели выберите страницу ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**. IP-адрес кластера указан в блоке **{{ ui-key.yacloud.common.section-base }}**.

    1. Если кластеры {{ metastore-name }} и {{ dataproc-name }} расположены в разных облачных сетях, настройте маршрутизацию между этими сетями таким образом, чтобы подсеть {{ metastore-name }} была доступна из подсети {{ dataproc-name }}.

        Существует [несколько способов](../../../tutorials/routing/index.md) настройки маршрутизации. Например, можно [создать туннель IPSec](../../../tutorials/routing/ipsec/ipsec-vpn.md).

    1. Если в облачной сети используются [группы безопасности](../../../vpc/concepts/security-groups.md), настройте группу безопасности кластера {{ dataproc-name }} на работу с {{ metastore-name }}. Для этого [добавьте](../../../vpc/operations/security-group-add-rule.md) в нее следующее правило для исходящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-metastore }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

{% endlist %}

Пример использования {{ dataproc-name }} с подключенным кластером {{ metastore-name }} см. в практическом руководстве [{#T}](../../tutorials/sharing-tables.md).
