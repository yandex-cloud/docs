[Документация Yandex Cloud](../../../../index.md) > [On-premises Yandex Object Storage](../../../index.md) > Версия 26.3 > [Концепции](../../index.md) > Архитектура продукта > Обзор

# Архитектура продукта

On-premises Yandex Object Storage — программная система, реализующая распределенное, S3-совместимое хранилище данных.

В этом разделе приведен краткий обзор ее архитектуры:

* [Схема решения](solution-scheme.md)
* Слой хранения
    * [Elliptics](elliptics.md)
    * [Mastermind](mastermind.md)

* Интерфейс S3
    * [Goose](goose.md)
    * [Работа Goose с PostgreSQL](goose-postgresql.md)
    * [Топология Goose и Elliptics](goose-elliptics.md)

* Системные зависимости
    * [Кластеры PostgreSQL](postgresql.md)
    * [Observability](observability.md)

* Характеристики системы
    * [Сводка характеристик системы](system-characteristics.md)
    * [Требования к системе](system-requirements.md)
    * [Требования к кластеру Kubernetes](kubernetes.md)

* Подключение системы
    * [Схемы подключения](connection-schemes.md)
    * [Описание доменов отказа](desc-failure-domains.md)
    * Примеры балансировки
        * [Сравнение BGP- и L2-балансировки](bgp-vs-l2-comparison.md)
        * [Размещение в дата-центрах с L2-балансировщиком](data-center-placement-l2.md)
        * [Размещение в дата-центрах с BGP-балансировкой](data-center-placement-bgp.md)