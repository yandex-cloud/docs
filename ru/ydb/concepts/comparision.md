---
sourcePath: overlay/concepts/comparision.md
---
### Сравнение Yandex DB с РСУБД и NoSQL {#comparison-of-yandex-db-with-rsubd-and-nosql}

&nbsp; | Yandex Database | NoSQL | Реляционные
--|---|---|--
Поддержка схемы  | Да  | -  | Да
Auto failover  | Да  | Да  | Настраиваемая
Auto repair  |  Да | Да  | -
Распределенные транзакции  | Да  | -  | -
ACID транзакции  | На уровне БД  | Построчно  | На уровне БД
Консистентность  | Strong  |  Eventual | Strong
Поддержка SQL  | YQL  | -  | Да
Масштабируемость  | Автоматическая горизонтальная  | Горизонтальная  | Вертикальная
Репликация | Автоматическая  | Автоматическая  | Настраиваемая  |

### Prepared statements {#prepared-statements}


**Вопрос**: Как решается проблема с тем, что при использовании prepare statements для формирования вопросов с конструкцией WHERE field1 IN () нужно использовать нехорошие приемы типа генерации строки из N знаков ?
**Ответ**: Не использовать конструкции с WHERE field1 IN () такого вида, где в скобочках содержит большое и разное количество. В других СУБД проблема решается описанными ниже способами

**PostgreSQL**

Рекомендуется использовать join с with [unnest](https://stackoverflow.com/questions/16054925/using-unnest-with-a-join)
На просторах интернета был найден вот такой рецепт еще
```
client.query('SELECT * FROM table WHERE id = ANY($1::int[])', [[id1, id2, id3]])
```

**mySQL**

* find_in_set рекомендуется использовать для этих целей
* различные варианты решения "как сгенерировать в prepare количество символов вопроса равное числу элементов массива". Вопрос "а нужен ли при этом prepare и как эффективно работают bind variables в таком случае" не был встречен в обсуждениях. Подробности по ссылкам

  * [https://phpdelusions.net/pdo#in](https://phpdelusions.net/pdo#in)
  * [https://stackoverflow.com/questions/1586587/pdo-binding-values-for-mysql-in-statement](https://stackoverflow.com/questions/1586587/pdo-binding-values-for-mysql-in-statement)

**Google Spanner**

Тут, судя по тексту, изложенному в [документации](https://cloud.google.com/spanner/docs/arrays), будет работать UNNEST, как и в PostgreSQL

### Alter capabilities {#alter-capabilities}

**Google Spanner**

https://cloud.google.com/spanner/docs/data-definition-language

Что касается смены типа данных у столбца (кроме первичного ключа) и изменения nullable - все возможно. переименовать нельзя.
как при этом с блокировками - неясно, нужно изучать на практике. Отзывы реальных пользователей найдены не были

**Amazon DynamoDB**

Возможности ALTER, которые позволяют менять тип атрибута или какое-либо иное свойство атрибута, не обнаружены.

**Azure CosmosDB**

не удалось найти информацию про возможности изменения структуры таблиц

### Alter & transactions {#alter-and-transactions}

Высказывается предположение, что несколько DDL-утверждений можно обернуть в транзакцию и для нескольких DDL-утверждений поиметь поведение базы, удовлетворяющие требованиями ACID.

Ниже приведены ссылки на руководства разных БД и указано поведение разных популярных систем в контексте вопроса

1. mySQL - DDL вызывает [неявную фиксацию транзакции](https://dev.mysql.com/doc/refman/5.7/en/implicit-commit.html). По ссылке - нюансы, но проще считать, что вызывает
2. spanner - никаких упоминаний о DDL в [описании транзакций](https://cloud.google.com/spanner/docs/reference/rpc/google.spanner.v1#google.spanner.v1.TransactionOptions). В том месте документации, где [пишут про DDL](https://cloud.google.com/spanner/docs/reference/rpc/google.spanner.admin.database.v1#google.spanner.admin.database.v1.DatabaseAdmin.UpdateDatabaseDdl) сказано, что при невозможности исполнить ddl-операцию, весь пакет прекращается и все
3. azure cosmosDB - в виду отсутствия транзакций на несколько таблиц, не стал искать про DDL, считаем, что нет до проведения эксперимента
4. AWS DynamoDB - не нашел подтверждения наличия. так как транзакции реализуются [внешней библиотекой](https://github.com/awslabs/dynamodb-transactions) предлагаю считать, что нет
5. postgreSQL - умеет делать для большей части DDL транзакции. Откатывать их применять атомарно. На странице по ссылке также описано поведение в других популярных СУБД [https://wiki.postgresql.org/wiki/Transactional_DDL_in_PostgreSQL%3a_A_Competitive_Analysis](https://wiki.postgresql.org/wiki/Transactional_DDL_in_PostgreSQL%3a_A_Competitive_Analysis)
6. MS SQL Server - умеет делать транзакции из DDL-выражений, когда работает на уровне изоляции read committed. На уровне snapshot нельзя, например,  alter в транзакции делать
4. Oracle - оборачивает DDL в два commit;
5. DB2 - поддерживает (подробности не читал)
6. Firebird - поддерживает (подробности не читал)

### Autocommit mode {#autocommit-mode}

 **RDBMS** | **AutoCommit**
--- | ---
postgreSQL | ON
mySQL| ON
