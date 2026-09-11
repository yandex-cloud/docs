# Архитектура продукта

{{ objstorage-onprem-name }} — программная система, реализующая распределенное, S3-совместимое хранилище данных.

В этом разделе приведен краткий обзор ее архитектуры:

* [{#T}](solution-scheme.md)
* Слой хранения
    * [{#T}](elliptics.md)
    * [{#T}](mastermind.md)

* Интерфейс S3
    * [{#T}](goose.md)
    * [{#T}](goose-postgresql.md)
    * [{#T}](goose-elliptics.md)

* Системные зависимости
    * [{#T}](postgresql.md)
    * [{#T}](observability.md)

* Характеристики системы
    * [{#T}](system-characteristics.md)
    * [{#T}](system-requirements.md)
    * [{#T}](kubernetes.md)

* Подключение системы
    * [{#T}](connection-schemes.md)
    * [{#T}](desc-failure-domains.md)
    * Примеры балансировки
        * [{#T}](bgp-vs-l2-comparison.md)
        * [{#T}](data-center-placement-l2.md)
        * [{#T}](data-center-placement-bgp.md)