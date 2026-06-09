# Квоты в {{ metadata-hub-full-name }}

Для сервиса {{ metadata-hub-full-name }} действуют следующие ограничения:

* [_Квоты_]({{ link-console-quotas }}) — организационные ограничения, которые можно изменить по запросу в техническую поддержку.

## Квоты {{ connection-manager-name }} {#connection-manager-quota}

#|
|| Квота | Значение ||
|| Общее количество подключений в облаке 
`connection-manager.totalConnections.count` | 1 000 ||
|#

## Квоты {{ metastore-name }} {#metastore-quota}

#|
|| Вид ограничения | Значение ||
|| Количество кластеров в облаке
`managed-metastore.clusters.count` | 5 ||
|#

## Квоты {{ schema-registry-name }} {#schema-registry-quota}

Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

#|
|| Квота | Значение ||
|| Общее количество пространств имен в облаке 
`schema-registry.namespaces.count` | 32 ||
|| Общее количество схем в облаке 
`schema-registry.schemas.count` | 10 240 ||
|#

## Квоты {{ data-catalog-name }} {#data-catalog-quota}

Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

#|
|| Квота | Значение ||
|| Общее количество каталогов метаданных в облаке
`data-catalog.datacatalogs.count` | 5 ||
|| Общее количество наборов метаданных в каталоге 
`data-catalog.assets.count` | 100 000 ||
|| Общее количество классификаций в каталоге
`data-catalog.classifications.count` | 1 000 ||
|| Общее количество глоссариев в каталоге
`data-catalog.glossaries.count` | 1 000 ||
|| Общее количество загрузок в каталоге
`data-catalog.ingestions.count` | 100 ||
|| Общее количество источников загрузок в каталоге
`data-catalog.ingestion_sources.count` | 100 ||
|| Общее количество связей между метаданными в каталоге
`data-catalog.lineages.count` | 100 000 ||
|| Общее количество тегов в каталоге
`data-catalog.tags.count` | 1 000 ||
|| Общее количество доменов в каталоге
`data-catalog.domains.count` | 1 000 ||
|| Общее количество терминов в каталоге
`data-catalog.terms.count` | 1 000 ||

|#

Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:

* [Сформируйте запрос на увеличение]({{ link-console-quotas }}).
* Обратитесь в [техническую поддержку]({{ link-console-support }}) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Чтобы ваш запрос был рассмотрен, у вас должна быть [роль](../../iam/roles-reference.md#quota-manager-requestoperator) `quota-manager.requestOperator` или выше (`editor` или `admin`).

Управлять квотами позволяет сервис [{{ quota-manager-name }}](../../quota-manager/quickstart.md).

_Apache® и [Apache Hive™](https://hive.apache.org/) являются зарегистрированными товарными знаками или товарными знаками Apache Software Foundation в США и/или других странах._