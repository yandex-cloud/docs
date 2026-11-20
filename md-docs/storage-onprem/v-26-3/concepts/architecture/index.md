[Документация Yandex Cloud](../../../../index.md) > [On-premises Yandex Object Storage](../../../index.md) > Версия 26.3 > [Концепции](../../index.md) > Архитектура продукта > Обзор

# Обзор

On-premises Yandex Object Storage — программная система, реализующая распределенное S3-совместимое хранилище данных.

В этом разделе описаны архитектура продукта, масштабируемость, консистентность, надежность хранения данных, отказоустойчивость и высокая доступность:

* [Общая схема решения](solution-scheme.md)
* Интерфейс S3:
    * [Goose](goose.md)
    * [Работа Goose с PostgreSQL](goose-postgresql.md)
* [Слой хранения MDS2](storage-layer.md)
* [Сетевая топология и балансировка трафика](goose-mds2.md)
* Системные зависимости:
    * [Кластеры PostgreSQL](postgresql.md)
    * [Observability](observability.md)
* [Интеграции с внешними системами](integrations.md)
* [Сводка характеристик системы](system-characteristics.md)
* [Требования к системе](system-requirements.md)
* [Требования к кластеру Kubernetes](kubernetes.md)
* [Схемы подключения](connection-schemes.md)
* [Описание доменов отказа](desc-failure-domains.md)
* Примеры балансировки:
    * [Сравнение BGP- и L2-балансировки](bgp-vs-l2-comparison.md)
    * [Размещение в дата-центрах с L2-балансировщиком](data-center-placement-l2.md)
    * [Размещение в дата-центрах с BGP-балансировкой](data-center-placement-bgp.md)