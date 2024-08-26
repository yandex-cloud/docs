# Шардирование коллекций {{ MG }}


[Шардирование](../../glossary/sharding.md) кластера {{ mmg-name }} происходит с автоматическим созданием служебных хостов, которые [тарифицируются](../../managed-mongodb/pricing.md) отдельно от основных хостов СУБД:
- либо `MONGOS` и `MONGOCFG`,
- либо `MONGOINFRA`.

{% include [irreversible-sharding-note.md](../../_includes/mdb/irreversible-sharding-note.md) %}

Шардирование коллекций имеет смысл, когда распределение по шардам поможет существенно улучшить производительность СУБД или доступность данных. Для повышения доступности каждый шард рекомендуется составлять из 3 и более хостов БД.

Удобство в работе и фактическое улучшение производительности сильно зависят от выбора ключа шардирования: данные коллекции должны быть логично распределены по шардам, а данные разных шардов не должны быть связаны между собой.

Распределять по шардам стоит:

* Данные значительного объема: задуматься стоит при объеме коллекции от 200 ГБ.
* Коллекции с неоднородным содержанием: например, данные можно четко разделить на часто и редко запрашиваемые.
* Коллекции с высокими требованиями к скорости чтения и записи данных: шардирование поможет распределить нагрузку по хостам, чтобы обойти технические ограничения.

Подробнее о концепции шардирования читайте в разделе [{#T}](../../managed-mongodb/concepts/sharding.md).

## Как включить шардирование коллекций {#enable}

{% note warning %}

Все операции по настройке шардирования с помощью CLI `mongosh` необходимо выполнять от имени пользователя с ролью [mdbShardingManager](../../managed-mongodb/concepts/users-and-roles.md#mdbShardingManager) в базе данных [admin](https://docs.mongodb.com/manual/reference/glossary/#term-admin-database).

{% endnote %}

1. [Включите шардирование](../../managed-mongodb/operations/shards.md#enable) для кластера.
1. [Подключитесь](../../managed-mongodb/operations/connect/index.md) к хосту `MONGOS` или `MONGOINFRA` с помощью CLI `mongosh` и включите шардирование:

   ```text
   sh.enableSharding("<имя_БД>")
   ```

   Тип хоста можно запросить со [списком хостов в кластере](../../managed-mongodb/operations/hosts.md#list-hosts).

1. Задайте индекс в шардированной коллекции:

   ```text
   db.getSiblingDB("<имя_БД>").<имя_коллекции>.createIndex( { "<индекс>": <тип_индекса> } )
   ```

1. Включите шардирование коллекции:

   ```text
   sh.shardCollection( "<имя_БД>.<коллекция>", { "<индекс>": <тип_индекса> } )
   ```

   Подробное описание команды `shardCollection` см. в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/method/sh.shardCollection/#definition).

1. Переключите приложения, которые используют вашу базу данных, на использование **исключительно** хостов `MONGOS` или `MONGOINFRA`.

### Шардирование разнородных данных {#brackets}

Если коллекция состоит из документов с разнородными [типами данных](https://www.mongodb.com/docs/manual/reference/bson-types), шарды лучше формировать по значениям ключа `_id` одинакового типа, пользуясь механизмом [Type Bracketing](https://www.mongodb.com/docs/manual/reference/method/db.collection.find/#std-label-type-bracketing). Тогда распределение по шардам и поиск документов выполняется быстрее, чем с разнотипными значениями `_id`.

### Ссылки по теме {#links}

Документация {{ MG }} рассказывает о решениях проблем шардирования:

* О механизме шардирования в общем: [Sharding](https://docs.mongodb.com/manual/sharding/index.html).
* О выборе ключа шардирования и стратегиях шардирования: [Shard Keys](https://docs.mongodb.com/manual/core/sharding-shard-key/).

## Пример шардирования {#example}

Допустим, у вас уже есть кластер {{ mmg-name }} с шардами и базой данных `billing`. Необходимо включить шардирование для коллекций `payment` и `addresses`. Для примера в качестве ключа шардирования используется хэш индекса для `payment` и значение поля `addresses`.

Последовательность операций:

1. [Подключитесь](../../managed-mongodb/operations/connect/index.md) к базе `billing`. У пользователя, от имени которого вы подключаетесь к базе, должна быть роль [mdbShardingManager](../../managed-mongodb/concepts/users-and-roles.md#mdbShardingManager) в базе данных [admin](https://docs.mongodb.com/manual/reference/glossary/#term-admin-database).
1. Включите шардирование для базы `billing`:

   ```text
   sh.enableSharding("billing")
   ```

1. Определите индекс в шардированной коллекции:

   ```text
   db.payments.ensureIndex( { "_id": "hashed" } )
   ```

1. Создайте необходимое количество шардов в [консоли управления]({{ link-console-main }}).
1. Задайте шардирование для коллекции с учетом ее пространства имен:
   ```text
   sh.shardCollection( "billing.payments", { "_id": "hashed" } )
   ```

После этого шардирование будет включено и настроено. Чтобы убедиться в этом, попробуйте вывести список доступных шардов с помощью команды `sh.status()`.
