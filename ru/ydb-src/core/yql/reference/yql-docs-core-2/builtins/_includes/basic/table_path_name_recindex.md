## TablePath {#tablepath}

Доступ к текущему имени таблицы, что бывает востребовано при использовании [CONCAT](../../../syntax/select.md#concat), [RANGE](../../../syntax/select.md#range) и других подобных механизмов.

Аргументов нет. Возвращает строку с полным путём, либо пустую строку и warning при использовании в неподдерживаемом контексте (например, при работе с подзапросом или диапазоном из 1000+ таблиц).

{% note info "Примечание" %}

Функции [TablePath](#tablepath), [TableName](#tablename) и [TableRecordIndex](#tablerecordindex) не работают для временных и анонимных таблиц (возвращают пустую строку или 0 для [TableRecordIndex](#tablerecordindex)).
Данные функции вычисляются в момент [выполнения](../../../syntax/select.md#selectexec) проекции в `SELECT`, и к этому моменту текущая таблица уже может быть временной.
Чтобы избежать такой ситуации, следует поместить вычисление этих функций в подзапрос, как это сделано во втором примере ниже.

{% endnote %}

**Примеры**
``` yql
SELECT TablePath() FROM CONCAT(table_a, table_b);
```

``` yql
SELECT key, tpath_ AS path FROM (SELECT a.*, TablePath() AS tpath_ FROM RANGE(`my_folder`) AS a)
WHERE key IN $subquery;
```

## TableName {#tablename}

Получить имя таблицы из пути к таблице. Путь можно получить через функцию [TablePath](#tablepath), или в виде колонки `Path` при использовании табличной функции [FOLDER](../../../syntax/select.md#folder).

Необязательные аргументы:

* путь к таблице, по умолчанию используется `TablePath()` (также см. его ограничения);
* указание системы ("yt"), по правилам которой выделяется имя таблицы. Указание системы нужно только в том случае, если с помощью [USE](../../../syntax/select.md#use) не указан текущий кластер.

**Примеры**
``` yql
USE hahn;
SELECT TableName() FROM CONCAT(table_a, table_b);
```

``` yql
SELECT TableName(Path, "yt") FROM hahn.FOLDER(folder_name);
```

## TableRecordIndex {#tablerecordindex}

Доступ к текущему порядковому номеру строки в исходной физической таблице, **начиная с 1** (зависит от реализации хранения).

Аргументов нет. При использовании в сочетании с [CONCAT](../../../syntax/select.md#concat), [RANGE](../../../syntax/select.md#range) и другими подобными механизмами нумерация начинается заново для каждой таблицы на входе. В случае использования в некорректном контексте возвращает 0.

**Пример**
``` yql
SELECT TableRecordIndex() FROM my_table;
```
