[Документация Yandex Cloud](../../index.md) > [Yandex MPP Analytics for PostgreSQL](../index.md) > [Практические руководства](index.md) > Миграция базы данных в Yandex MPP Analytics for PostgreSQL

# Миграция базы данных в Yandex MPP Analytics for PostgreSQL

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


## Необходимые платные ресурсы {#paid-resources}

* Кластер Yandex MPP Analytics for PostgreSQL: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий ([тарифы Yandex MPP Analytics for PostgreSQL](../pricing/index.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).


## Перед началом работы {#before-you-begin}

[Создайте кластер-приемник Greenplum®](../operations/cluster-create.md), вычислительная мощность и размер хранилища которого соответствуют среде, в которой развернута мигрируемая база данных.

Имя базы в кластере-приемнике должно совпадать с именем базы-источника.

## Перенос данных {#data-transfer}

1. Подготовьте кластер-источник:
    * [Greenplum®](../../data-transfer/operations/prepare.md#source-gp)
    * [PostgreSQL](../../data-transfer/operations/prepare.md#source-pg)
1. [Подготовьте кластер-приемник](../../data-transfer/operations/prepare.md#target-gp).
1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create) со следующими параметрами:

    * **Тип базы данных** — `Greenplum` или `PostgreSQL`.
    * **Параметры эндпоинта** → **Настройки подключения** — `Пользовательская инсталляция`.

        Укажите параметры подключения к кластеру-источнику.

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create) со следующими параметрами:

    * **Тип базы данных** — `Greenplum`.
    * **Параметры эндпоинта** → **Настройки подключения** — `Кластер`.

        Укажите идентификатор кластера-приемника.

1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа _**Копирование**_, использующий созданные эндпоинты.
1. [Активируйте трансфер](../../data-transfer/operations/transfer.md#activate).
1. Дождитесь перехода трансфера в статус **Завершен**.

    Подробнее о статусах трансфера в разделе [Жизненный цикл трансфера](../../data-transfer/concepts/transfer-lifecycle.md#statuses).

1. Переведите кластер-источник в режим <q>только чтение</q> и переключите нагрузку на кластер-приемник.
1. Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:
    1. [Удалите завершившийся трансфер](../../data-transfer/operations/transfer.md#delete).
    1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._