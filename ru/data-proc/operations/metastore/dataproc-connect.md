# Подключение {{ dataproc-name }} к {{ metastore-name }}

{% note info %}

Для использования кластера {{ metastore-name }} кластер {{ dataproc-name }} должен включать в себя следующий набор компонентов:

* `SPARK`;
* `YARN`;
* `HIVE`.

{% endnote %}

{% list tabs %}

- Консоль управления

    1. [Создайте кластер](./cluster-create.md) {{ metastore-name }}.
    1. При [создании](../cluster-create.md) или [изменении](../cluster-update.md) кластера {{ dataproc-name }} задайте следующее [свойство](../../concepts/settings-list.md):

        ```text
        spark:spark.hive.metastore.uris : thrift://<IP-адрес кластера {{ metastore-name }}>:{{ port-metastore }}
        ```

        Чтобы узнать IP-адрес кластера {{ metastore-name }}, в [консоли управления]({{ link-console-main }}) выберите сервис **{{ dataproc-name }}** и на левой панели выберите страницу ![image](../../../_assets/data-proc/metastore.svg) **Metastore-сервер**. IP-адрес кластера указан в блоке **{{ ui-key.yacloud.common.section-base }}**.

    1. Если кластеры {{ metastore-name }} и {{ dataproc-name }} расположены в разных облачных сетях, настройте маршрутизацию между этими сетями таким образом, чтобы подсеть {{ metastore-name }} была доступна из подсети {{ dataproc-name }}.

        Существует [несколько способов](../../../tutorials/routing/index.md) настройки маршрутизации. Например, можно [создать туннель IPSec](../../../tutorials/routing/ipsec/ipsec-vpn.md).

    1. Если в облачной сети используются [группы безопасности](../../../vpc/concepts/security-groups.md), [настройте группу безопасности](../../../vpc/operations/security-group-add-rule.md) кластера {{ dataproc-name }} на работу с {{ metastore-name }}. Для этого добавьте в нее следующее правило для исходящего трафика:

        * Диапазон портов — `{{ port-metastore }}`.
        * Протокол — `Любой` (`Any`).
        * Источник — `CIDR`.
        * CIDR блоки — `0.0.0.0/0`.

{% endlist %}

Пример использования {{ dataproc-name }} с подключенным кластером {{ metastore-name }} см. в практическом руководстве [{#T}](../../tutorials/dataproc-to-dataproc.md).
