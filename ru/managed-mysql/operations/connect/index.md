---
title: Предварительная настройка подключения к кластеру {{ MY }} в {{ mmy-full-name }}
description: Следуя данной инструкции, вы сможете подготовиться к подключению к базе данных в кластере {{ MY }}.
---

# Предварительная настройка для подключения к кластеру {{ MY }}

К хостам кластера {{ mmy-short-name }} можно подключиться:

{% include [cluster-connect-note](../../../_includes/mdb/mmy/cluster-connect-note.md) %}

{% note warning %}

Если публичный доступ в кластере настроен только для некоторых хостов, [автоматическая смена мастера](../../concepts/replication.md#master-failover) может привести к невозможности подключиться к мастеру из интернета.

{% endnote %}

Максимальное количество подключений определяется настройкой [Max connections](../../concepts/settings-list.md#setting-max-connections), которая [зависит от класса хостов](../../concepts/settings-list.md#settings-instance-dependent).

Подробнее см. в разделе [{#T}](../../concepts/network.md).


## Настройка групп безопасности {#configure-security-groups}

{% include [sg-rules](../../../_includes/mdb/sg-rules-connect.md) %}

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs group=connection_method %}

- Через интернет {#internet}

    [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порт {{ port-mmy }}. Для этого создайте следующее правило для входящего трафика:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mmy }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

- С ВМ в {{ yandex-cloud }} {#cloud}

    1. [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порт {{ port-mmy }}. Для этого в этих группах создайте следующее правило для входящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mmy }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
        * Группа безопасности — если кластер и ВМ находятся в одной и той же группе безопасности, выберите значение `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`). В противном случае укажите группу безопасности ВМ.

    1. [Настройте группу безопасности](../../../vpc/operations/security-group-add-rule.md), в которой находится ВМ так, чтобы можно было подключаться к ВМ и был разрешен трафик между ВМ и хостами кластера.

        Пример правил для ВМ:

        * Для входящего трафика:
           * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`.
           * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
           * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
           * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

            Это правило позволяет [подключаться](../../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу [SSH](../../../glossary/ssh-keygen.md).

        * Для исходящего трафика:
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

            Это правило разрешает любой исходящий трафик, что позволяет не только подключаться к кластеру, но и устанавливать на ВМ необходимые для этого сертификаты и утилиты.

{% endlist %}

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера. При неполных или некорректных настройках групп безопасности можно потерять доступ к кластеру.

{% endnote %}

Подробнее о группах безопасности см. в разделе [{#T}](../../concepts/network.md#security-groups).


## Получение SSL-сертификата {#get-ssl-cert}

{{ MY }}-хосты с публичным доступом поддерживают только шифрованные соединения. Чтобы использовать их, получите SSL-сертификат:

{% include [install-certificate](../../../_includes/mdb/mmy/install-certificate.md) %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}

## Что дальше {#whats-next}

* [Получите FQDN хоста](fqdn.md), к которому будете подключаться.
* [Подключитесь](clients.md) к кластеру из графической IDE, Docker-контейнера или интерфейса командной строки.
* [Интегрируйте](code-examples.md) подключение к кластеру в код вашего приложения.
