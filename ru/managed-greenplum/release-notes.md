# История изменений в {{ mgp-full-name }}

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## 14.03.2022 {#14.03.2022}

* {{ mgp-full-name }} перешел в общий доступ. Теперь для него действует [соглашение об уровне обслуживания]({{ link-sla-greenplum }}) (SLA) и [правила тарификации](pricing/index.md).
* Добавлен [калькулятор](https://cloud.yandex.ru/promo/dwh-calculator/index) для расчета рекомендуемой конфигурации и оценки стоимости кластера.
* Доступна новая версия {{ GP }} 6.19 с исправлением известных ошибок. 
* Добавлена возможность скрывать содержимое внешних таблиц (external tables). 
* Добавлена возможность изменения размера хранилища, в том числе для локальных SSD-дисков.
* Добавлены [конфигурации](concepts/instance-types.md) `io-optimized` с увеличенным соотношением количества гигабайт RAM к количеству vCPU (8:1).

{% include [greenplum-trademark](../_includes/mdb/mgp/trademark.md) %}
