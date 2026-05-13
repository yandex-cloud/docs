# Диагностика производительности

Для диагностики производительности кластер Greenplum® использует:

* в версиях 6.22 и ниже — выделенную базу данных `gpperfmon`;
* в версиях 6.25 и выше — [командный центр Greenplum®](../concepts/command-center.md).

{% note info %}

Доступ к базе данных `gpperfmon` предоставляется по запросу. Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

В базе данных `gpperfmon` сохраняется статистика запросов и состояний системы. Обращаться к базе `gpperfmon` может:

* пользователь-администратор;
* пользователь с [ролью](../concepts/cluster-users.md#mdb_admin) `mdb_admin`;
* пользователь с привилегиями к базе данных `gpperfmon`.

База данных `gpperfmon` содержит следующие информационные таблицы:

* `database_history` — рабочая нагрузка базы данных Greenplum®.
* `diskspace_history` — использование дискового пространства.
* `dynamic_memory_info` — совокупность всех сегментов и объем используемой динамической памяти для каждого хоста.
* `memory_info` — информация о памяти для каждого хоста из таблиц `system_history` и `segment_history`.
* `network_interface_history` — сетевое взаимодействие по каждому активному интерфейсу базы данных Greenplum®.
* `queries_history` — состояние высокоуровневых запросов.
* `segment_history` — распределение памяти для сегмента базы данных Greenplum®.
* `socket_history` — использование сокетов базы данных Greenplum®.
* `system_history` — использование системы.

Для просмотра таблицы [подключитесь к базе данных](connect/index.md) `gpperfmon` и выполните запрос:

```sql
SELECT * FROM <имя_таблицы>;
```

Подробнее об информационных таблицах базы данных `gpperfmon` в [документации Greenplum®](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/ref_guide-gpperfmon-dbref.html).

_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._