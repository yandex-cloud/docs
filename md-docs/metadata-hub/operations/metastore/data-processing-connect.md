# Подключение Yandex Data Processing к Apache Hive™ Metastore

{% note info %}

Для использования кластера Apache Hive™ Metastore [кластер Yandex Data Processing](../../../data-proc/concepts/index.md) должен содержать компоненты `SPARK` и `YARN`.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Создайте кластер](cluster-create.md) Apache Hive™ Metastore.
    1. При [создании](../../../data-proc/operations/cluster-create.md) или [изменении](../../../data-proc/operations/cluster-update.md) кластера Yandex Data Processing задайте следующее [свойство](../../../data-proc/concepts/settings-list.md):

        ```text
        spark:spark.hive.metastore.uris : thrift://<IP-адрес_кластера_Apache Hive™ Metastore>:9083
        ```

        Чтобы узнать IP-адрес кластера Apache Hive™ Metastore, в [консоли управления](https://console.yandex.cloud) выберите сервис **Yandex MetaData Hub** и на панели слева выберите ![image](../../../_assets/console-icons/database.svg) **Metastore-сервер**. Для нужного кластера скопируйте значение из колонки **IP-адрес**.

    1. Если кластеры Apache Hive™ Metastore и Yandex Data Processing расположены в разных облачных сетях, настройте маршрутизацию между этими сетями таким образом, чтобы подсеть Apache Hive™ Metastore была доступна из подсети Yandex Data Processing.

        Существует [несколько способов](../../../tutorials/routing/index.md) настройки маршрутизации. Например, можно [создать туннель IPSec](../../../tutorials/routing/ipsec/ipsec-vpn.md).

    1. Если в облачной сети используются [группы безопасности](../../../vpc/concepts/security-groups.md), настройте группу безопасности кластера Yandex Data Processing на работу с Apache Hive™ Metastore. Для этого [добавьте](../../../vpc/operations/security-group-add-rule.md) в нее следующее правило для исходящего трафика:

        * **Диапазон портов** — `9083`.
        * **Протокол** — `Любой` (`Any`).
        * **Источник** — `CIDR`.
        * **CIDR блоки** — `0.0.0.0/0`.

{% endlist %}

Пример использования Yandex Data Processing с подключенным кластером Apache Hive™ Metastore см. в практическом руководстве [Совместная работа с таблицами Yandex Data Processing с использованием Apache Hive™ Metastore](../../tutorials/sharing-tables.md).

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._