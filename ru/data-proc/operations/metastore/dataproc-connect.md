---
noIndex: true
---

# Подключение {{ dataproc-name }} к {{ metastore-name }}

{% note info %}

Для использования сервера {{ metastore-name }} кластер {{ dataproc-name }} должен включать в себя следующий набор компонентов:

* `SPARK`;
* `YARN`;
* `HIVE`.

{% endnote %}

{% list tabs %}

- Консоль управления

    1. [Создайте сервер](./cluster-create.md) {{ metastore-name }}.
    1. При [создании](../cluster-create.md) или [изменении](../cluster-update.md) кластера {{ dataproc-name }} задайте следующее [свойство](../../concepts/settings-list.md):

        ```text
        spark:spark.hive.metastore.uris=thrift://<IP-адрес {{ metastore-name }}>:{{ port-metastore }}
        ```

        Чтобы узнать IP-адрес {{ metastore-name }}, перейдите на страницу {{ metastore-name }} в консоли управления. IP-адрес указан в блоке **{{ ui-key.yacloud.common.section-base }}**.

    1. Если сервер {{ metastore-name }} и кластер {{ dataproc-name }} расположены в разных облачных сетях, настройте маршрутизацию между этими облачными сетями таким образом, чтобы подсеть {{ metastore-name }} была доступна из подсети {{ dataproc-name }}.

        Существует [несколько способов](../../../tutorials/routing/index.md) настройки маршрутизации. Например, можно [создать туннель IPSec](../../../tutorials/routing/ipsec-vpn.md).

    1. Если в облачной сети используются [группы безопасности](../../../vpc/concepts/security-groups.md), [настройте группу безопасности](../../../vpc/operations/security-group-add-rule.md) кластера {{ dataproc-name }} на работу с {{ metastore-name }}. Для этого добавьте в нее следующее правило для исходящего трафика:

        * Диапазон портов — `{{ port-metastore }}`.
        * Протокол — `Любой` (`Any`).
        * Источник — `CIDR`.
        * CIDR блоки — `0.0.0.0/0`.

{% endlist %}

Пример использования {{ dataproc-name }} с подключенным {{ metastore-name }} см. в практическом руководстве [{#T}](../../tutorials/dataproc-to-dataproc.md).
