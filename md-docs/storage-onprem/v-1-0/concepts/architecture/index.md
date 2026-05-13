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
    * [Размещение в датацентрах с L2-балансировщиком](data-center-placement-l2.md)