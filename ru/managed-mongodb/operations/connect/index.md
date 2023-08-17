# Обзор способов подключения к базе данных

Доступные способы подключения зависят от того, включено ли в кластере [шардирование](../../concepts/sharding.md):

* [Подключение к нешардированному кластеру](./non-sharded.md).
* [Подключение к шардированному кластеру](./sharded.md).

## Доступ к хостам кластера {#connect}

К хостам кластера {{ mmg-short-name }} можно подключиться:

{% include [cluster-connect-note](../../../_includes/mdb/mmg/cluster-connect-note.md) %}

Для подключения к хостам кластера используйте порт:

* `{{ port-mmg }}` — если кластер нешардированный;
* `{{ port-mmg-sharded }}` — если кластер шардированный.

Запросы на запись будут автоматически направлены к первичной реплике кластера.

{% note info %}

Если публичный доступ настроен только для некоторых хостов, [автоматическая смена первичной реплики](../../concepts/replication.md) может привести к тому, что вы не сможете подключиться к кластеру из интернета.

{% endnote %}


## Получение SSL-сертификата {#get-ssl-cert}

Чтобы подключиться к {{ MG }}-хостам с публичным доступом, получите SSL-сертификат:

{% include [install-certificate](../../../_includes/mdb/mmg/install-certificate.md) %}

{% include [ide-ssl-cert](../../../_includes/mdb/mdb-ide-ssl-cert.md) %}


## Настройка групп безопасности {#configuring-security-groups}

{% include [security-groups-note](../../../_includes/vpc/security-groups-note-services.md) %}

{% include [sg-rules](../../../_includes/mdb/sg-rules-connect.md) %}

Настройки правил будут различаться в зависимости от выбранного способа подключения:

{% list tabs %}

- Через интернет

    [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик с любых IP-адресов на порт `{{ port-mmg }}` для нешардированного кластера или на порт `{{ port-mmg-sharded }}` для [шардированного](../shards.md). Для этого создайте следующее правило для входящего трафика:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**:
        * `{{ port-mmg }}` — для нешардированного кластера;
        * `{{ port-mmg-sharded }}` — для шардированного кластера.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

- С ВМ в Облаке

    1. [Настройте все группы безопасности](../../../vpc/operations/security-group-add-rule.md) кластера так, чтобы они разрешали входящий трафик из группы безопасности, в которой находится ВМ, на порт `{{ port-mmg }}` для нешардированного кластера или на порт `{{ port-mmg-sharded }}` для [шардированного](../shards.md). Для этого в этих группах создайте следующее правило для входящего трафика:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**:
            * `{{ port-mmg }}` — для нешардированного кластера;
            * `{{ port-mmg-sharded }}` — для шардированного кластера.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — группа безопасности, в которой находится ВМ. Если она совпадает с настраиваемой группой, то укажите `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).
        
    1. [Настройте группу безопасности](../../../vpc/operations/security-group-add-rule.md), в которой находится ВМ так, чтобы можно было подключаться к ВМ и был разрешен трафик между ВМ и хостами кластера.

        Пример правил для ВМ:

        * Для входящего трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-ssh }}`;
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`;
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`;
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

            Это правило позволяет подключаться к ВМ по протоколу [SSH](../../../glossary/ssh-keygen.md).

        * Для исходящего трафика:

            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`;
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`);
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`;
            * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

            Это правило разрешает любой исходящий трафик, что позволяет не только подключаться к кластеру, но и устанавливать на ВМ необходимые для этого сертификаты и утилиты.

{% endlist %}

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Группы безопасности должны быть корректно настроены для всех подсетей, в которых будут размещены хосты кластера. При неполных или некорректных настройках групп безопасности можно потерять доступ к кластеру, если произойдет [автоматическая смена первичной реплики](../../concepts/replication.md).

{% endnote %}

Подробнее см. в разделе [{#T}](../../concepts/network.md#security-groups).


## Ограничения на количество подключений {#connection-limits}

{% include [mmg-conn-limits](../../../_includes/mdb/mmg/conn-limits.md) %}

Объем оперативной памяти хоста определяется его классом. Все доступные варианты перечислены в разделе [{#T}](../../concepts/instance-types.md).
