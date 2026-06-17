---
title: Настройка группы безопасности для кластера {{ metastore-full-name }}
description: Следуя данной инструкции, вы сможете настроить группы безопасности для кластера {{ metastore-name }}.
---

# Настройка группы безопасности для кластера {{ metastore-name }}

Если в вашей облачной сети используются [группы безопасности](../../../vpc/concepts/security-groups.md), они могут препятствовать работе кластера {{ metastore-name }}. В этом случае настройте группу безопасности, назначенную кластеру {{ metastore-name }}. Для этого [добавьте](../../../vpc/operations/security-group-add-rule.md) в нее следующие правила для входящего трафика:

* Для входящего служебного трафика:

   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `30000-32767`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `TCP`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `Группа безопасности`.
   * **Группа безопасности** — `Текущая`.

* Для входящего трафика от клиентов по протоколу Thrift:

   * **Описание** — `thrift`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `9083`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `TCP`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

* Для входящего трафика от клиентов по протоколу REST:

   * **Описание** — `iceberg rest (4.2+)`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `9001`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `TCP`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

* Для входящего трафика от балансировщика:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`.

Если планируется использовать несколько групп безопасности для кластера, разрешите весь трафик между этими группами.

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

{% endnote %}

{% include [metastore-trademark](../../../_includes/metadata-hub/metastore-trademark.md) %}
