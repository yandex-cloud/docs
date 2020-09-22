# Поиск с помощью {{ ES }}

{{ ES }} выступает не только как хранилище документов, но также и как инструмент для поиска и анализа данных в документах с помощью:
1. Структурированных запросов (structured queries) по типу SQL-запросов: они позволяют найти документы с набором полей, которые удовлетворяют заданным условиям.
1. Полнотекстовых запросов (full text queries): они позволяют найти заданную строку в документах и отсортировать результаты по степени релевантности. В том числе такие запросы позволяют выполнять поиск с автодополнением, поиск фраз, поиск похожих строк и так далее. Дополнительную информацию о полнотекстовом поиске см. в [документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/analysis-overview.html).
1. Сложносоставных запросов (complex queries), сочетающих в себе предыдущие типы запросов.

В {{ mes-name }} запросы всех этих типов можно выполнять, используя следующие инструменты:
- [URI-запросы](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-your-data.html#run-uri-search), в которых строка запроса в формате Lucene передается в GET-параметре: `?q=<строка запроса>`.
- [JSON-запросы](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-your-data.html#run-request-body-search), написанные с использованием [{{ ES }} QueryDSL](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html).
- [SQL-запросы](https://www.elastic.co/guide/en/elasticsearch/reference/current/sql-overview.html). {{ ES }} полностью поддерживает SQL-запросы, не требуя наличия какого-либо промежуточного посредника между собой и SQL.

Некоторые возможности поиска в {{ ES }}: 
- Поиск может производиться как по конкретному [индексу](indexing.md) в кластере, так и по нескольким индексам.
- Поддерживается [асинхронный поиск](https://www.elastic.co/guide/en/elasticsearch/reference/current/async-search-intro.html) для больших запросов, которые могут выполняться длительное время.

Подробную информацию о возможностях поиска см. [в документации {{ ES }}](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-your-data.html).
