[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for OpenSearch](../index.md) > [Концепции](index.md) > Поиск с помощью OpenSearch

# Поиск с помощью OpenSearch

OpenSearch выступает как инструмент для поиска и [анализа данных](../../glossary/data-analytics.md) в документах с помощью:

* Структурированных запросов (structured queries) по типу SQL-запросов: они позволяют найти документы с набором полей, которые удовлетворяют заданным условиям.
* Полнотекстовых запросов (full text queries): они позволяют найти заданную строку в документах и отсортировать результаты по степени релевантности. В том числе такие запросы позволяют выполнять поиск с автодополнением, поиск фраз, поиск похожих строк и так далее. Дополнительную информацию о полнотекстовом поиске в [документации OpenSearch](https://opensearch.org/docs/latest/search-plugins/sql/full-text/).
* Сложносоставных запросов (complex queries), сочетающих в себе предыдущие типы запросов.

В Managed Service for OpenSearch запросы всех этих типов можно выполнять, используя предустановленные поисковые плагины: [Querqy](https://opensearch.org/docs/latest/search-plugins/querqy/index/), [SQL and PPL](https://opensearch.org/docs/latest/search-plugins/sql/index/) или другие.

Некоторые возможности поиска в OpenSearch:

* Поиск может производиться как по конкретному [индексу](indexing.md) в кластере, так и по нескольким индексам.
* Поддерживается [асинхронный поиск](https://opensearch.org/docs/latest/search-plugins/async/index/) для больших запросов, которые могут выполняться длительное время.

Подробная информация о возможностях поиска в [документации OpenSearch](https://opensearch.org/docs/latest/opensearch/search/index/).

## Примеры использования {#examples}

* [Поставка данных из Yandex Managed Service for Apache Kafka® с помощью Yandex Data Transfer](../tutorials/migration-from-mkf.md)
* [Миграция данных из стороннего кластера OpenSearch с помощью Yandex Data Transfer](../tutorials/migration-from-standalone.md)
* [Миграция данных из Elasticsearch](../tutorials/migration-to-opensearch.md)
* [Использование плагина yandex-lemmer в Managed Service for OpenSearch](../tutorials/opensearch-yandex-lemmer.md)