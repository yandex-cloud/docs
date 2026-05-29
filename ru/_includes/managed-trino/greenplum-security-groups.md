Для подключения к кластеру {{ GP }} [коннектор](../../managed-trino/concepts/greenplum-connector.md) {{ TR }} использует протокол GPFDIST:

* Координаторы и воркеры {{ TR }} выполняют запросы к мастеру {{ GP }} через TCP-порт `{{ port-mgp }}`.
* Сегменты {{ GP }} передают данные на воркеры {{ TR }} через TCP-порт GPFDIST.

Данные, передающиеся по протоколу GPFDIST между кластерами {{ GP }} и {{ TR }}, не шифруются. Чтобы обеспечить безопасное подключение, настройте группы безопасности [на стороне {{ mgp-name }}](#configuring-security-groups-greenplum) и (опционально) [на стороне {{ mtr-name }}](#configuring-security-groups-trino).

Если {{ GP }} взаимодействует с другими кластерами или другими сущностями внутри пользовательской сети, то для них нужно отдельно настроить правила группы безопасности.

#### Настройка на стороне {{ GP }} {#configuring-security-groups-greenplum}

{% list tabs group=traffic %}

- Входящий трафик {#incoming}

    * Правило для трафика внутри кластера {{ GP }}:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).

    * Правило для подключения из кластера {{ TR }}:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mgp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — укажите группу безопасности кластера {{ TR }}.

- Исходящий трафик {#outgoing}

    * Правило для трафика внутри кластера {{ GP }}:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}` (`Self`).

    * Правило для подключения к кластеру {{ TR }}:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `0-65535`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — укажите группу безопасности кластера {{ TR }}.

{% endlist %}

#### Настройка на стороне {{ mtr-name }} {#configuring-security-groups-trino}

Правила групп безопасности на стороне {{ TR }} настраиваются зеркально правилам на стороне {{ GP }}. Настройка правил для кластера {{ TR }} является опциональной, но позволяет дополнительно обезопасить кластер.

{% list tabs group=traffic %}

- Входящий трафик {#incoming}

  Правило для приема данных от сегментов {{ GP }}:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `0-65535`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — укажите группу безопасности кластера {{ GP }}.

- Исходящий трафик {#outgoing}

  Правило для подключения к мастеру {{ GP }}:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-mgp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — укажите группу безопасности кластера {{ GP }}.

{% endlist %}
