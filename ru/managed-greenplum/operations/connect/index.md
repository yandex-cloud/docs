---
title: Предварительная настройка подключения к кластеру {{ GP }} в {{ mgp-full-name }}
description: Следуя данной инструкции, вы сможете подготовиться к подключению к базе данных в кластере {{ GP }}.
---

# Предварительная настройка для подключения к кластеру {{ GP }}

Благодаря тому, что СУБД {{ GP }} основана на {{ PG }}, для подключения к обеим СУБД используются одни и те же инструменты.

Подключение к кластеру {{ GP }} производится только через [первичный хост-мастер](../../concepts/index.md). Чтобы определить роли хостов, получите [список хостов в кластере](../cluster-list.md#get-hosts).

К кластеру можно подключиться:

{% include [cluster-connect-note-monolithic](../../../_includes/mdb/cluster-connect-note-monolithic.md) %}


## Настройка групп безопасности {#configuring-security-groups}

Кластеру {{ GP }} может быть назначена одна или несколько групп безопасности. Для подключения к кластеру необходимо, чтобы группы безопасности содержали правила, разрешающие входящий трафик на порт {{ port-mgp }} с определенных IP-адресов или из других групп безопасности.

{% note info %}

Группа безопасности, назначенная на кластер, регулирует трафик между кластером и другими ресурсами в облаке или вне его. Взаимодействие хостов кластера между собой регулируется отдельной системной группой безопасности и не требует настройки.

{% endnote %}

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs group=connection_method %}

- Через интернет {#internet}

    {% include [Cluster security group rules](../../../_includes/mdb/mgp/cluster-sg-rules.md) %}

- С ВМ в {{ yandex-cloud }} {#cloud}

    1. Добавьте в группу безопасности кластера следующие правила:

        1. Для входящего трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mgp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — если кластер и ВМ находятся в одной и той же группе безопасности, выберите значение `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). В противном случае укажите группу безопасности ВМ.

         1. Для исходящего трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

            Это правило позволит {{ mgp-name }} работать с внешними источниками данных, например PXF или GPFDIST.

    1. [Настройте группу безопасности](../../../vpc/operations/security-group-add-rule.md), в которой находится ВМ, так, чтобы можно было подключаться к ВМ и был разрешен трафик между ВМ и хостами кластера:

        * Для входящего трафика:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `22`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — диапазон адресов, с которых производится подключение.

            Это правило позволяет подключаться к ВМ по протоколу [SSH](../../../glossary/ssh-keygen.md).

        * Для исходящего трафика:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

            Это правило разрешает любой исходящий трафик, что позволяет не только подключаться к кластеру, но и устанавливать на ВМ необходимые для этого сертификаты и утилиты.

{% endlist %}



## Получение SSL-сертификата {#get-ssl-cert}

Чтобы использовать SSL-соединение, получите сертификат:

{% include [install-certificate](../../../_includes/mdb/mgp/install-certificate.md) %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Что дальше {#whats-next}

* [Получите FQDN хоста](fqdn.md), к которому будете подключаться.
* [Подключитесь](clients.md) к кластеру из графической IDE, {{ pgadmin }} или Docker-контейнера.
* [Интегрируйте](code-examples.md) подключение к кластеру в код вашего приложения.

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
