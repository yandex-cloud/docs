
Роль `yds.auditor` позволяет просматривать метаданные потоков данных {{ yds-name }}, устанавливать соединения c базами данных {{ ydb-short-name }}, просматривать информацию о БД {{ ydb-short-name }} и назначенных правах доступа к ним, а также о схемных объектах и резервных копиях БД {{ ydb-short-name }}.

Пользователи с этой ролью могут:
* просматривать метаданные [потоков данных](../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }};
* устанавливать соединения c [базами данных {{ ydb-short-name }}](../../ydb/concepts/resources.md#database);
* просматривать список баз данных и информацию о них, а также о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к базам данных {{ ydb-short-name }};
* просматривать информацию о резервных копиях баз данных {{ ydb-short-name }} и назначенных правах доступа к таким резервным копиям;
* просматривать список схемных объектов БД {{ ydb-short-name }} (таблиц, индексов и каталогов) и информацию о них;
* просматривать информацию о [квотах](../../ydb/concepts/limits.md#ydb-quotas) сервиса {{ ydb-name }};
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `ydb.auditor`.