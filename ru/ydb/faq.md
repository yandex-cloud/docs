# Вопросы и ответы про {{ ydb-short-name }}

{% if audience == "external" %}
## Общие вопросы {#common}
{% include notitle [common](faq/common.md) %}

## YQL {#yql}

{% include notitle [common](faq/yql.md) %}

## Ошибки {#errors}

{% include notitle [errors](faq/errors.md) %}

{% else %}
## Общие вопросы {#common}

### Какое количество строк можно прочитать в результате одного запроса к YDB?

Результаты выполнения запросов на чтения ограничены 1000 строк или 50 мбайт.

### Какие ограничения накладываются на full scan таблицы?

Каждый шард может вернуть не более 50мб, например если есть фильтрация шарды фильтруют по предикату и читать можно больше.

### Как эффективно использовать JOIN?

Эффективно работает только INDEX LOOKUP JOIN.
Чтобы join переписался в INDEX LOOKUP JOIN, должны выполняться следующие требования:

*  необходимо использовать один из типов join: inner, full, left, left semi, left only;
*  правая часть join является таблицей, а не результатом подзапроса;
*  ключ join является префиксом PK правой таблицы;
*  выборка в левой таблице должна быть относительно небольшой;

### Какие запросы можно выполнить над одной таблицей в рамках одной транзакции?

Транзакции "не видят" своих изменений. Поэтому можно делать произвольное количество чтений, за которыми будут UPDATE ON/DELETE ON в любом количестве.

### Как получить количество измененных строк в транзакции?

Можно посчитать количество измененных строк с помощью запроса:

```yql
$data = (
    SELECT
        Id,
        $x_new AS X,
        $rev + 1 AS Rev
    FROM Table
    WHERE Id = $id AND Rev = $rev
);

UPSERT INTO Table
SELECT * FROM $data;

SELECT COUNT(*) FROM $data;
```

### Что делать, если я часто получаю ошибку "Transaction locks invalidated"?

При получении этой ошибки надо повторить выполнение транзакции, т.к. YDB использует оптимистичные блокировки. Если при чтении сканируется большое количество строк и эта ошибка возникает часто, имеет смысл разбить чтения на части.

### Почему возникает ошибка "Exceeded maximum allowed number of active transaction"?

В логике на клиентской стороне надо стараться держать как можно более короткие транзакции.
В рамках сессии разрешено не более 10 активных транзакций. При старте транзакции нужно использовать либо коммит флаг для автокоммита, либо явный коммит/роллбек.

### Когда можно устанавливать уровень изоляции транзакции?

Уровень изоляции устанавливается для всей транзакции.

### Какова вычислительная сложность select count(*)?

Q: Есть таблица с primary_key (puid, photo_id). Быстрый ли будет запрос ```yql select count(*) where puid == my_puid```?

A: O(количество строк с puid == my_puid)

### Что быстрее String::StartsWith или LIKE 'something%'?
Специализированная функция быстрее.

### Копирует ли String::Substring исходную строку?
Нет, не копирует.

### Что лучше?  Мелкие и частые или редкие но длинные транзакции?

Q: Как лучше писать? Мелкие и частые транзакции (upsert 50-100 строк) по 300 мс или длинные но редкие (upsert 1000-3000 по 5 секунд)?  Транзакции не конкурирующие и transaction lock invalidation не вызывается.

A: Предпочтительно использовать маленькие транзакции.

### Примеры YQL-запросов для IN и prepare
https://st.yandex-team.ru/YDBREQUESTS-14

### Как правильно делать миграцию продовой таблички? Если запустить ALTER TABLE ADD COLUMN на табличке с 4к записями это же не сильно повлияет на текущие запросы?

Да, ориентировочно 30 сек, если есть нагрузка.
Точнее сказать так: примерно 30 сек новые транзакции, затрагивающие таблицу будут реджектится.

Во врем альтера


<main>: Error: Execution, code: 1060
    <main>: Error: Transaction rolled back., code: 2007
        <main>: Error: Kikimr cluster or one of its subsystems was unavailable., code: 2005
            <main>: Error: Error executing transaction (ProxyShardNotAvailable): One or more of affected datashards not available, request execution cancelled
                <main>: Error: Data shard errors: [SHARD_IS_BLOCKED] Can't propose tx. Shard is blocked.

### Как запустить YDB локально

https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/tools/ydb_recipe

## FAQ по С++ SDK

### Почему может возникать ошибка "Status: OVERLOADED Error: Pending previous query completion"?

Q: При запуске двух запросов, пытаюсь получить ответ из фьючера от второго из них. Получаю: ```Status: OVERLOADED Why: <main>: Error: Pending previous query completion```

A: Сессия в SDK однопоточная. Если нужно параллельно использовать несколько запросов, нужно создавать несколько сессий.

{% endif %}
