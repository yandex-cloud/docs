## Function-ownership {#function-ownership}

Если параметр `privileges` не указан, правило запрещает выполнение любых действий над функциями.

{% note info %}

Чтобы воспользоваться правом `OWNERSHIP` на функцию, требуется уровень доступа `ALL` к каталогу, в котором находится функция.

{% endnote %}

## Procedures-privileges {#procedures-privileges}

Если параметр `privileges` не указан, правило запрещает выполнение любых действий над процедурами.

## Queries-privileges {#queries-privileges}

Если параметр `privileges` не указан, правило запрещает выполнение любых действий над запросами.

{% note warning %}

Нельзя указать разрешение `EXECUTE`, если в этом же правиле используется параметр `query_owners`.

{% endnote %}

## Tables-privileges {#table-ownership}

Если параметр `privileges` не указан, правило запрещает выполнение любых действий над таблицами.

{% note info %}

Чтобы воспользоваться правом `OWNERSHIP` на таблицу, требуется уровень доступа `ALL` к каталогу, в котором находится таблица.

{% endnote %}