[Документация Yandex Cloud](../../../index.md) > [Yandex MPP Analytics for PostgreSQL](../../index.md) > [Концепции](../overview.md) > Отличия Apache Cloudberry™ от Greenplum® > Почему выбирают Apache Cloudberry™

# Почему выбирают Apache Cloudberry™

Apache Cloudberry™ — форк Greenplum® под управлением Apache Software Foundation. Apache Cloudberry™ версии 2.x построен на актуальном PostgreSQL 14.x, в то время как Greenplum® – на PostgreSQL 9.4, поддержка которого закончилась в феврале 2020. Далее Apache Cloudberry™ будет обновляться на PostgreSQL 16. Обновление выйдет в мажорном релизе Apache Cloudberry™ 3.x.

Переход с Greenplum® на Apache Cloudberry™ не требует переучивания команды и переписывания приложений. Apache Cloudberry™ почти полностью совместим с Greenplum®. Полный список несовместимых изменений (обычно малых и точечных) вынесен в [отдельный документ](breaking-changes.md). Функционально эти изменения затрагивают небольшую часть сценариев.

## Преимущества Apache Cloudberry™

### Быстрее в аналитике

Основной источник ускорений в аналитических движках — формат хранения данных. Apache Cloudberry™ использует гибридный формат хранения данных [PAX (Partition Attributes Across)](https://cloudberry.apache.org/docs/operate-with-data/pax-table-format/). Он объединяет удобство работы со строчными таблицами и колоночную скорость чтения, автоматически пропускает нерелевантные блоки и поддерживает современные кодеки сжатия.

### Оптимизация запросов

В Apache Cloudberry™ есть инструменты оптимизации запросов:

* [RuntimeFilter](https://cloudberry.apache.org/docs/performance/optimize-queries/use-runtimefilter-to-optimize-queries/) — отсечение лишних кортежей перед JOIN с использованием bloom-фильтров.
* [Aggregation Pushdown](https://cloudberry.apache.org/docs/performance/optimize-queries/use-aggre-pushdown-to-speed-up-queries/) — выполнение агрегации ближе к данным, что сокращает объём передаваемых по сети данных.
* [Параллельное выполнение запросов](https://cloudberry.apache.org/docs/performance/optimize-queries/parallel-query-execution/) с динамической регулировкой числа воркеров.
* Новый тип индекса [BRIN](https://cloudberry.apache.org/docs/operate-with-data/operate-with-db-objects/brin-indexes/) с поддержкой опций `multi-minmax` и `bloom`.
* Улучшения оптимизатора запросов из PostgreSQL 14.

### Near-real-time аналитика и интеграция с AI

* [Динамические таблицы](https://cloudberry.apache.org/docs/performance/use-dynamic-tables/) – результаты запросов, актуализируемые по расписанию
* [Инкрементальные материализованные представления](https://cloudberry.apache.org/docs/performance/optimize-queries/use-incremental-materialized-view/) – обновляются только по измененным данным.
* [Автоматические материализованные представления (AQUMV)](https://cloudberry.apache.org/docs/performance/optimize-queries/use-auto-materialized-view-to-answer-queries/) – оптимизатор сам подменяет таблицы на подходящие материализованные представления при построении плана запроса.
* [Directory tables](https://cloudberry.apache.org/docs/advanced-analytics/directory-tables/) – работа с неструктурированными данными в локальном или объектном хранилище непосредственно из SQL.
* [MCP-сервер](https://github.com/apache/cloudberry/tree/main/mcp-server) – управление базой данных с помощью AI-агентов и LLM-инструментов.

### Корпоративная безопасность

* [Политики паролей на основе профилей](https://cloudberry.apache.org/docs/security/set-password-profile) (включая блокировку после неудачных попыток входа).
* [Row-level security](https://cloudberry.apache.org/docs/security/configure-row-level-security-policy/) – доступ к отдельным строкам, без обходных решений через view.
* [SCRAM-SHA-256](https://cloudberry.apache.org/docs/security/protect-passwords/), channel binding, шифрование TCP/IP при GSSAPI, доверенные расширения.

### Вендор-нейтральная модель управления

* Проект разработан в инкубаторе Apache Software Foundation, что гарантирует независимость от вендора.
* Решения о развитии проекта принимаются Project Management Committee (PMC), в который входят разработчики из разных компаний и стран.
* Высокая активность сообщества и скорость разработки.