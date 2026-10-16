[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Построение Data Platform](index.md) > Yandex Data Transfer > Миграция данных из стороннего кластера Greenplum® или PostgreSQL в Yandex MPP Analytics for PostgreSQL с помощью Data Transfer

# Миграция данных из стороннего кластера Greenplum® или PostgreSQL в Yandex MPP Analytics for PostgreSQL с помощью Yandex Data Transfer

Вы можете перенести вашу базу данных из стороннего кластера Greenplum® или PostgreSQL в Yandex MPP Analytics for PostgreSQL с помощью сервиса Yandex Data Transfer. Этот способ позволяет:

* перенести базу без остановки обслуживания пользователей;
* мигрировать со старых версий Greenplum® на более новые;
* обойтись без создания промежуточной [виртуальной машины](../../glossary/vm.md) или разрешения доступа к вашему кластеру-приемнику Managed Service for PostgreSQL из интернета.

Подробнее в разделе [Какие задачи решает сервис Yandex Data Transfer](../../data-transfer/concepts/use-cases.md).

{% note info %}

Data Transfer позволяет перенести состояние базы-источника на приемник Yandex MPP Analytics for PostgreSQL без поддержания ее в актуальном состоянии (тип трансфера [_**Копирование**_](../../data-transfer/concepts/transfer-lifecycle.md#copy)). Изменения, произошедшие на источнике после завершения трансфера, перенесены не будут.

{% endnote %}

Чтобы перенести базу данных, нужно непосредственно перенести данные, закрыть старую базу данных на запись и переключить нагрузку на кластер БД в Yandex Cloud.

Чтобы перенести базу данных с использованием сервиса Yandex Data Transfer:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Подготовьте и активируйте трансфер](#data-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

* Кластер Yandex MPP Analytics for PostgreSQL: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Yandex MPP Analytics for PostgreSQL](../../managed-greenplum/pricing/index.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).


## Подготовьте инфраструктуру {#prepare-infrastructure}

1. Подготовьте кластер-источник: [Greenplum®](../../data-transfer/operations/prepare.md#source-gp) или [PostgreSQL](../../data-transfer/operations/prepare.md#source-pg).
1. [Создайте](../../managed-greenplum/operations/cluster-create.md) кластер-приемник Yandex MPP Analytics for PostgreSQL.

    Вычислительная мощность и размер хранилища должны соответствовать среде, в которой развернута мигрируемая база данных.

    Имя базы в кластере-приемнике должно совпадать с именем базы-источника.

1. [Подготовьте](../../data-transfer/operations/prepare.md#target-gp) кластер-приемник.


## Подготовьте и активируйте трансфер {#data-transfer}

1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

    {% list tabs group=data_sources %}

    - PostgreSQL {#postgresql}

      * **Направление** — `Источник`.
      * Укажите имя эндпоинта.
      * **Тип базы данных** — `PostgreSQL`.
      * **Параметры эндпоинта**:

          * **Настройки подключения** — выберите `Пользовательская инсталляция`.
          * **Хост** — укажите IP-адрес или FQDN хоста-мастера кластера-источника.
          * **Порт** — укажите номер порта для подключения к кластеру-источнику.
          * **База данных** — укажите имя БД.
          * **Пользователь** — укажите имя пользователя БД.
          * **Пароль** — укажите пароль пользователя.

    - Greenplum/Yandex MPP Analytics {#greenplum}

      * **Направление** — `Источник`.
      * Укажите имя эндпоинта.
      * **Тип базы данных** — `Greenplum/Yandex MPP Analytics`.
      * **Параметры эндпоинта**:

          * **Настройки подключения** — выберите `Пользовательская инсталляция`.
          * **Хост координатора** — укажите IP-адрес или FQDN первичного хоста-мастера кластера-источника.
          * **Порт координатора** — укажите номер порта для подключения к первичному хосту-мастеру.
          * **База данных** — укажите имя БД.
          * **Пользователь** — укажите имя пользователя БД.
          * **Пароль** — укажите пароль пользователя.

    {% endlist %}

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

    * **Направление** — `Приёмник`.
    * Укажите имя эндпоинта.
    * **Тип базы данных** — `Greenplum/Yandex MPP Analytics`.
    * **Параметры эндпоинта**:

        * **Тип подключения** — выберите `Ручная настройка`.
        * **Тип подключения** — выберите `Кластер`.
        * **Кластер** — выберите кластер-приемник из списка.
        * **База данных** — укажите имя нужной БД.
        * **Пользователь** — укажите имя пользователя БД.
        * **Пароль** — укажите пароль пользователя.

1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа _**Копирование**_, использующий созданные эндпоинты.
1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate).
1. Дождитесь перехода трансфера в статус **Завершен**.

    Подробнее о статусах трансфера в разделе [Жизненный цикл трансфера](../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. Переведите кластер-источник в режим <q>только чтение</q> и переключите нагрузку на кластер-приемник.


## Удалите созданные ресурсы {#clear-out}


Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:


1. [Деактивируйте](../../data-transfer/operations/transfer.md#deactivate) и [удалите](../../data-transfer/operations/transfer.md#delete) трансфер.
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete).
1. Удалите кластеры:

    * [Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-delete.md).
    * [Yandex MPP Analytics for PostgreSQL](../../managed-greenplum/operations/cluster-delete.md).


1. Если для доступа к хостам кластеров использовались статические публичные IP-адреса, освободите и [удалите](../../vpc/operations/address-delete.md) их.