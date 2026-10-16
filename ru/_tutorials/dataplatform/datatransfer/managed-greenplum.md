# Миграция данных из стороннего кластера {{ GP }} или {{ PG }} в {{ mgp-full-name }} с помощью {{ data-transfer-full-name }}

Вы можете перенести вашу базу данных из стороннего кластера {{ GP }} или {{ PG }} в {{ mgp-name }} с помощью сервиса {{ data-transfer-full-name }}. Этот способ позволяет:

* перенести базу без остановки обслуживания пользователей;
* мигрировать со старых версий {{ GP }} на более новые;
* обойтись без создания промежуточной [виртуальной машины](../../../glossary/vm.md) или разрешения доступа к вашему кластеру-приемнику {{ mpg-name }} из интернета.

Подробнее в разделе [{#T}](../../../data-transfer/concepts/use-cases.md).

{% note info %}

{{ data-transfer-name }} позволяет перенести состояние базы-источника на приемник {{ mgp-name }} без поддержания ее в актуальном состоянии (тип трансфера [_{{ dt-type-copy }}_](../../../data-transfer/concepts/transfer-lifecycle.md#copy)). Изменения, произошедшие на источнике после завершения трансфера, перенесены не будут.

{% endnote %}

Чтобы перенести базу данных, нужно непосредственно перенести данные, закрыть старую базу данных на запись и переключить нагрузку на кластер БД в {{ yandex-cloud }}.

Чтобы перенести базу данных с использованием сервиса {{ data-transfer-full-name }}:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Подготовьте и активируйте трансфер](#data-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mgp-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы {{ mgp-name }}](../../../managed-greenplum/pricing/index.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы {{ vpc-full-name }}](../../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#prepare-infrastructure}

1. Подготовьте кластер-источник: [{{ GP }}](../../../data-transfer/operations/prepare.md#source-gp) или [{{ PG }}](../../../data-transfer/operations/prepare.md#source-pg).
1. [Создайте](../../../managed-greenplum/operations/cluster-create.md) кластер-приемник {{ mgp-name }}.

    Вычислительная мощность и размер хранилища должны соответствовать среде, в которой развернута мигрируемая база данных.

    Имя базы в кластере-приемнике должно совпадать с именем базы-источника.

1. [Подготовьте](../../../data-transfer/operations/prepare.md#target-gp) кластер-приемник.


## Подготовьте и активируйте трансфер {#data-transfer}

1. [Создайте эндпоинт для источника](../../../data-transfer/operations/endpoint/index.md#create):

    {% list tabs group=data_sources %}

    - {{ PG }} {#postgresql}

      * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** — `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
      * Укажите имя эндпоинта.
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `PostgreSQL`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.title }}**:

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresSource.connection.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.on_premise.title }}`.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.host.title }}** — укажите IP-адрес или FQDN хоста-мастера кластера-источника.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.port.title }}** — укажите номер порта для подключения к кластеру-источнику.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}** — укажите имя БД.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}** — укажите имя пользователя БД.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}** — укажите пароль пользователя.

    - Greenplum/Yandex MPP Analytics {#greenplum}

      * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** — `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
      * Укажите имя эндпоинта.
      * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `Greenplum/Yandex MPP Analytics`.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumSource.title }}**:

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumSource.connection.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.on_premise.title }}`.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.primary_host.title }}** — укажите IP-адрес или FQDN первичного хоста-мастера кластера-источника.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.primary_port.title }}** — укажите номер порта для подключения к первичному хосту-мастеру.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}** — укажите имя БД.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}** — укажите имя пользователя БД.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}** — укажите пароль пользователя.

    {% endlist %}

1. [Создайте эндпоинт для приемника](../../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** — `{{ ui-key.yacloud.data-transfer.forms.label_target-type }}`.
    * Укажите имя эндпоинта.
    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `Greenplum/Yandex MPP Analytics`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTarget.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.connection_type.title }}** — выберите `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}** — выберите кластер-приемник из списка.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}** — укажите имя нужной БД.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}** — укажите имя пользователя БД.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}** — укажите пароль пользователя.

1. [Создайте трансфер](../../../data-transfer/operations/transfer.md#create) типа _{{ dt-type-copy }}_, использующий созданные эндпоинты.
1. [Активируйте трансфер](../../../data-transfer/operations/transfer.md#activate).
1. Дождитесь перехода трансфера в статус {{ dt-status-finished }}.

    Подробнее о статусах трансфера в разделе [Жизненный цикл трансфера](../../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. Переведите кластер-источник в режим <q>только чтение</q> и переключите нагрузку на кластер-приемник.


## Удалите созданные ресурсы {#clear-out}


Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:


1. [Деактивируйте](../../../data-transfer/operations/transfer.md#deactivate) и [удалите](../../../data-transfer/operations/transfer.md#delete) трансфер.
1. [Удалите эндпоинты](../../../data-transfer/operations/endpoint/index.md#delete).
1. Удалите кластеры:

    * [{{ mpg-name }}](../../../managed-postgresql/operations/cluster-delete.md).
    * [{{ mgp-name }}](../../../managed-greenplum/operations/cluster-delete.md).


1. Если для доступа к хостам кластеров использовались статические публичные IP-адреса, освободите и [удалите](../../../vpc/operations/address-delete.md) их.

