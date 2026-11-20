---
title: Обзор в {{ objstorage-onprem-name }}
description: Обзор архитектуры и компонентов {{ objstorage-onprem-name }}.
---

# Обзор

{{ objstorage-onprem-name }} — программная система, реализующая распределенное S3-совместимое хранилище данных.

В этом разделе описаны архитектура продукта, масштабируемость, консистентность, надежность хранения данных, отказоустойчивость и высокая доступность:

* [{#T}](solution-scheme.md)
* Интерфейс S3:
    * [{#T}](goose.md)
    * [{#T}](goose-postgresql.md)
* [{#T}](storage-layer.md)
* [{#T}](goose-mds2.md)
* Системные зависимости:
    * [{#T}](postgresql.md)
    * [{#T}](observability.md)
* [{#T}](integrations.md)
* [{#T}](system-characteristics.md)
* [{#T}](system-requirements.md)
* [{#T}](kubernetes.md)
* [{#T}](connection-schemes.md)
* [{#T}](desc-failure-domains.md)
* Примеры балансировки:
    * [{#T}](bgp-vs-l2-comparison.md)
    * [{#T}](data-center-placement-l2.md)
    * [{#T}](data-center-placement-bgp.md)
