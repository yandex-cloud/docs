# Доступ к компонентам и возможностям {{ MS }}

Чтобы снизить затраты клиента на администрирование экземпляра {{ MS }}, {{ mms-name }} берет на себя решение административных задач по его обслуживанию. Такое разграничение ответственности подразумевает, что некоторые компоненты СУБД на уровне сервера недоступны пользователю или доступны в ограниченном виде.

## Доступные компоненты {#available}

- [Ядро СУБД]({{ ms.docs }}/sql/database-engine/install-windows/install-sql-server-database-engine) (database engine) — основной компонент {{ MS }} со всей функциональностью, реализуемой на уровне отдельной базы данных.
- [Выполняющиеся в памяти базы данных]({{ ms.docs }}/sql/relational-databases/in-memory-database) (in-memory database) — система управления данными, оптимизированная под использование большого объема памяти.
- [Полнотекстовый поиск]({{ ms.docs }}/sql/relational-databases/search/full-text-search) (full-text search) — компонент для полнотекстовых запросов к символьным данным в таблицах.

## Компоненты с ограниченным доступом {#restricted}

- [Группы доступности Always On]({{ ms.docs }}/sql/database-engine/availability-groups/windows) (availability groups) — доступны в редакции Enterprise Edition. Подробнее об использовании этого компонента см. раздел [Репликация](replication.md). При этом недоступны:
  - [Прослушиватель]({{ ms.docs }}/sql/database-engine/availability-groups/windows/create-or-configure-an-availability-group-listener-sql-server) (listener) — в качестве замены единой точки подключения к кластеру предоставляется [особый FQDN](../operations/connect#fqdn-primary-replica).
  - [Режим асинхронной фиксации]({{ ms.docs }}/sql/database-engine/availability-groups/windows/availability-modes-always-on-availability-groups#asynchronous-commit-availability-mode) (asynchronous-commit mode) — обе вторичные реплики являются синхронными с автоматическим переключением.
  - [Маршрутизация только для чтения]({{ ms.docs }}/sql/database-engine/availability-groups/windows/configure-read-only-routing-for-an-availability-group-sql-server) (read-only routing).
  - [Координатор распределенных транзакций]({{ ms.docs }}/sql/database-engine/availability-groups/windows/configure-availability-group-for-distributed-transactions) (distributed transaction coordinator).
- [Роли и привилегии уровня сервера]({{ ms.docs }}/sql/relational-databases/security/authentication-access/server-level-roles) — доступно только использование хранилища запросов (query store) для [диагностики производительности](../operations/performance-diagnostics#activate-stats-collector) и [управление пользовательскими сеансами](../operations/sessions.md) с помощью встроенных хранимых процедур.
- [Репликация]({{ ms.docs }}/sql/relational-databases/replication) — доступно только использование базы данных в кластере {{ mms-name }} в роли подписчика на [публикацию транзакций](../tutorials/data-migration.md#replication). Для [репликации внутри кластера](replication.md) используются группы доступности Always On.

## Недоступные компоненты {#unavailable}

- [Постоянное шифрование]({{ ms.docs }}/sql/relational-databases/security/encryption/always-encrypted-database-engine) (always encrypted).
- [Службы аналитических данных]({{ ms.docs }}/analysis-services/ssas-overview) (analysis services).
- [Интеграция CLR .NET]({{ ms.docs }}/dotnet/framework/data/adonet/sql/sql-server-common-language-runtime-integration).
- [Электронная почта]({{ ms.docs }}/sql/relational-databases/database-mail) (database mail).
- [Службы повышения качества данных]({{ ms.docs }}/sql/data-quality-services) (data quality services).
- [Контроллер распределенного воспроизведения]({{ ms.docs }}/sql/tools/distributed-replay/sql-server-distributed-replay) (distributed replay controller).
- [Расширенные события]({{ ms.docs }}/sql/relational-databases/extended-events) (extended events).
- [Службы интеграции]({{ ms.docs }}/sql/integration-services) (integration services).
- [Связанные серверы]({{ ms.docs }}/sql/relational-databases/linked-servers) (linked servers).
- [Службы машинного обучения]({{ ms.docs }}/sql/machine-learning/sql-server-machine-learning-services) (machine learning services).
- [Службы основных данных]({{ ms.docs }}/sql/master-data-services/master-data-services-overview-mds) (master data services).
- [Объекты OLE-автоматизации]({{ ms.docs }}/sql/relational-databases/stored-procedures/ole-automation-objects-in-transact-sql) (OLE automation objects).
- [Службы отчетов]({{ ms.docs }}/sql/reporting-services) (reporting services).
- [Агент {{ MS }}]({{ ms.docs }}/sql/ssms/agent) ({{ MS }} agent).
- [Профилировщик {{ MS }}]({{ ms.docs }}/sql/tools/sql-server-profiler) ({{ MS }} profiler).
- [Прозрачное шифрование данных]({{ ms.docs }}/sql/relational-databases/security/encryption/transparent-data-encryption) (transparent data encryption).
- [Проверка подлинности Windows]({{ ms.docs }}/sql/relational-databases/security/choose-an-authentication-mode#connecting-through-windows-authentication) (Windows authentication).

## Недоступные возможности {#unavailable-features}

- Создание именованного экземпляра {{ MS }}.
- Создание баз данных или снимков БД через команды Transact-SQL или графические средства.
- Создание учетных записей через команды Transact-SQL или графические средства.
- Изменение владельца базы данных.
- Ручное переключение первичной реплики.
- Резервное копирование в [общие папки SMB]({{ ms.docs }}/sql/database-engine/install-windows/install-sql-server-with-smb-fileshare-as-a-storage-option).
- Создание и выполнение [планов обслуживания]({{ ms.docs }}/sql/relational-databases/maintenance-plans).
- Использование [реляционных операторов]({{ ms.docs }}/sql/t-sql/language-elements/relational-operators-transact-sql) `OPENROWSET`, `OPENQUERY` и `OPENDATASOURCE`.
- Выполнение [процедуры]({{ ms.docs }}/sql/relational-databases/system-stored-procedures/xp-cmdshell-transact-sql) `xp_cmdshell`.