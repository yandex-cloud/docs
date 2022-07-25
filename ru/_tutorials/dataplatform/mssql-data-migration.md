# Миграция базы данных из стороннего кластера {{ MS }} в {{ mms-full-name }}

Вы можете перенести базу данных из стороннего _кластера-источника_ {{ MS }} в _кластер-приемник_ {{ mms-short-name }} с помощью [логического импорта]({{ ms.docs }}/sql/relational-databases/replication/snapshot-replication) снапшота базы данных или [транзакционной репликации]({{ ms.docs }}/sql/relational-databases/replication/transactional/transactional-replication). Оба способа имеют свои ограничения:

- [Миграция с помощью логического импорта](#snapshot):

    - При создании снапшота используются блокировки таблиц.
    - Процесс импорта снапшота проходит медленно по сравнению с транзакционной репликацией.
    - Данные в кластере-приемнике будут актуальны только на момент создания снапшота и могут устареть.
    - Этот способ не подходит для баз данных с логическими неконсистентностями — например, если в ней удалены зависимости или таблицы, на которые ссылаются представления. Если необходимо мигрировать такую базу данных, создайте [моментальный снимок базы данных]({{ ms.docs }}/sql/relational-databases/databases/create-a-database-snapshot-transact-sql) и направьте его в [службу поддержки]({{ link-console-support }}), чтобы наши специалисты восстановили базу из снапшота вручную.

- [Миграция с помощью транзакционной репликации](#replication):

    - Однонаправленность — изменения в кластере-приемнике не будут реплицироваться в кластер-источник.
    - Во время работы публикации нельзя менять схему в кластере-приемнике.

## Перед началом работы {#before-you-begin}

Создайте необходимые ресурсы:

{% list tabs %}

- Вручную

    [Создайте кластер {{ mms-name }}](../../managed-sqlserver/operations/cluster-create.md) с публичным доступом из интернета.

    - При [миграции с помощью логического импорта](#snapshot) кластер-приемник должен быть создан с тем же значением настройки **SQL Server Collation**, что и в кластере-источнике.

    - При [миграции с помощью транзакционной репликации](#replication):

        - Версия {{ MS }} должна быть не ниже, чем в кластере-источнике.
        - Имена базы данных в кластере-источнике и в кластере-приемнике должны совпадать.
        - [Добавьте](../../managed-sqlserver/operations/cluster-users.md#adduser) в кластер всех пользователей, которые есть в базе-источнике и используют **SQL Server Authentication**, с теми же именами и паролями.

- С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
    1. Скачайте в ту же рабочую директорию файл конфигурации [sqlserver-data-migration.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/sqlserver-data-migration.tf).

        В этом файле описаны:

        - [сеть](../../vpc/concepts/network.md#network);
        - [подсеть](../../vpc/concepts/network.md#subnet);
        - [группа безопасности](../../vpc/concepts/security-groups.md) и правило, разрешающее подключение к кластеру;
        - кластер {{ mms-name }} с публичным доступом из интернета.

    1. Укажите параметры инфраструктуры в файле конфигурации `sqlserver-data-migration.tf` в блоке `locals`:

        - `username` и `password` — имя и пароль пользователя-владельца базы данных.
        - `sql_server_version` — версия {{ MS }}.
        - `db_name` — имя базы данных в кластере-приемнике.

        При [миграции с помощью логического импорта](#snapshot) раскомментируйте и размножьте блок `user`. Укажите учетные данные всех пользователей кластера-источника, использующих **SQL Server Authentication**.

        При [миграции с помощью транзакционной репликации](#replication) версия {{ MS }} должна быть не ниже, чем в кластере-источнике, а имена базы данных в кластере-источнике и кластере-приемнике должны совпадать.

    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдера, указанного в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Миграция с помощью логического импорта {#snapshot}

Перенести данные из кластера {{ MS }} в кластер {{ mms-short-name }} можно с помощью программы [sqlpackage]({{ ms.docs }}/sql/tools/sqlpackage/sqlpackage-download). Она создаст файл снапшота базы {{ MS }} со схемой таблиц и данными, а затем импортирует его в кластер {{ mms-short-name }}.

Чтобы мигрировать базу данных из кластера-источника {{ MS }} в кластер-приемник {{ mms-name }} с помощью логического импорта:

1. [Настройте кластер-источник](#configure-source).
1. [Создайте снапшот базы данных из кластера-источника](#create-snapshot).
1. [Импортируйте снапшот базы данных в кластер-приемник](#import-snapshot).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

### Настройте кластер-источник {#configure-source}

1. Проверьте, что вы можете [подключиться к кластеру-приемнику](../../managed-sqlserver/operations/connect.md#connection-ide) и кластеру-источнику с помощью {{ ssms }}.

1. [Скачайте и установите программу sqlpackage]({{ ms.docs }}/sql/tools/sqlpackage/sqlpackage-download).

1. Удалите в базе-источнике всех пользователей, использующих **Windows Authentication**, оставив только пользователей с **SQL Server Authentication**.

1. Выдайте пользователю `sa` роль `db_owner` в той базе, которую собираетесь переносить, с помощью запроса:

    ```sql
    ALTER AUTHORIZATION ON DATABASE::<имя базы> TO sa;
    ```

1. Включите в базе-источнике компонент **Service Broker** и переключите ее модель восстановления в режим **Full**:
   1. Откройте {{ ssms }}.
   1. Откройте контекстное меню нужной базы данных и выберите пункт **Properties**.
   1. Перейдите на вкладку **Options**.
   1. Поменяйте значение опции **Recovery model** на **Full**.
   1. В блоке **Service Broker** поменяйте значение **Broker Enabled** на **True**.

### Создайте снапшот базы данных {#create-snapshot}

Чтобы экспортировать базу данных в файл .dacpac, запустите PowerShell, перейдите в директорию с программой sqlpackage и выполните команду:

   ```powershell
   .\sqlpackage.exe `
       /a:Extract `
       /ssn:"<адрес кластера-источника {{ MS }}>" `
       /sdn:"<имя базы данных>" `
       /tf:"<локальный путь к файлу .dacpac>" `
       /p:ExtractAllTableData=True `
       /p:ExtractReferencedServerScopedElements=False
   ```

{% note info %}

Чтобы экспортировать только схему таблиц без самих данных, укажите в параметре `/p:ExtractAllTableData` значение `False`. Если нужно экспортировать только определенные таблицы, замените параметр `/p:ExtractAllTableData` на необходимое количество параметров `/p:TableData=<имя таблицы>`.

{% endnote %}

Подробнее см. в [документации {{ MS }}]({{ ms.docs }}/sql/tools/sqlpackage/sqlpackage-extract).

### Импортируйте снапшот базы данных в кластер-приемник {#import-snapshot}

Чтобы импортировать снапшот в кластер {{ mms-name }}, запустите PowerShell, перейдите в директорию с программой sqlpackage и выполните команду:

```powershell
.\sqlpackage.exe `
    /a:Publish `
    /sf:"<локальный путь к файлу .dacpac>" `
    /tsn:"<FQDN хоста-мастера в кластере {{ mms-name }}>,1433" `
    /tdn:"<имя целевой базы данных>" `
    /tec:True `
    /ttsc:True `
    /tu:"<имя пользователя целевой БД с ролью db_owner>" `
    /tp:"<пароль>" `
    /p:AllowIncompatiblePlatform=True `
    /p:IgnoreCryptographicProviderFilePath=True `
    /p:IgnoreExtendedProperties=True `
    /p:IgnoreFileAndLogFilePath=True `
    /p:IgnoreFilegroupPlacement=True `
    /p:IgnoreFileSize=True `
    /p:IgnoreFullTextCatalogFilePath=True `
    /p:IgnoreLoginSids=True `
    /p:ScriptRefreshModule=False
```

Подробнее см. в [документации {{ MS }}]({{ ms.docs }}/sql/tools/sqlpackage/sqlpackage-publish).

## Миграция с помощью транзакционной репликации {#replication}

Перенести данные из кластера {{ MS }} в кластер {{ mms-name }} с минимальным временем простоя можно с помощью [транзакционной репликации (transactional replication)]({{ ms.docs }}/sql/relational-databases/replication/transactional/transactional-replication). Такой тип репликации поддерживается с 2016-й версии {{ MS }} и позволяет мигрировать данные на более поздние версии SQL Server в кластере {{ mms-name }}.

При транзакционной репликации:

* [Агент моментальных снимков]({{ ms.docs }}/sql/relational-databases/replication/agents/replication-agents-overview#snapshot-agent) создает снапшот базы данных со схемой таблиц и файлами данных и копирует его из [издателя (publisher)]({{ ms.docs }}/sql/relational-databases/replication/publish/replication-publishing-model-overview#publisher) в [распространитель (distributor)]({{ ms.docs }}/sql/relational-databases/replication/publish/replication-publishing-model-overview#distributor), который управляет переносом данных.

   {% note info %}
   
   Так как при создании снапшота используются блокировки таблиц, используйте для этого период минимальных нагрузок на базу.
   
   {% endnote %}

* [Агент чтения журнала (Log Reader Agent)]({{ ms.docs }}/sql/relational-databases/replication/agents/replication-agents-overview#log-reader-agent) переносит транзакции из лога транзакций на распространителя.
* Снапшот и транзакции из распространителя переносятся с помощью [агента распространителя (Distribution Agent)]({{ ms.docs }}/sql/relational-databases/replication/agents/replication-agents-overview#distribution-agent) к [подписчику (subscriber)]({{ ms.docs }}/sql/relational-databases/replication/publish/replication-publishing-model-overview#subscribers).

Издатель, распространитель и оба агента располагаются в кластере-источнике, а подписчик — в кластере-приемнике. Возможны и другие варианты распределения ролей, например выделенные сервера для распространителя.

{% note info %}

Выполнение объемных транзакций в кластере-источнике может замедлить репликацию.

{% endnote %}

Чтобы мигрировать базу данных из кластера-источника {{ MS }} в кластер-приемник {{ mms-name }} с помощью транзакционной репликации:

1. [Создайте публикацию в кластере-источнике](#create-publication).
1. [Создайте подписку в кластере-источнике](#create-subscription).
1. [Остановите процесс репликации и перенесите нагрузку](#transfer-load).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

### Создайте публикацию в кластере-источнике {#create-publication}

1. Проверьте, что вы можете [подключиться к кластеру-приемнику](../../managed-sqlserver/operations/connect.md#connection-ide) и кластеру-источнику с помощью {{ ssms }}.
1. Подключитесь к кластеру-источнику из {{ ssms }}.
1. Разверните список объектов сервера в Object Explorer.
1. Откройте контекстное меню для директории **Replication** и выберите **New → Publication**.
1. Пройдите все шаги мастера создания публикации, в том числе:
   1. Укажите, что сам сервер будет выступать в качестве распространителя.
   1. Укажите директорию для снапшота базы данных.
   1. Выберите базу данных, которую необходимо мигрировать.
   1. Выберите тип публикации **Transactional replication**.
   1. Выберите в списке статей для публикации все сущности базы данных, которые требуется реплицировать (таблицы, представления, хранимые процедуры).
   1. Выберите время создания снапшота базы данных.
   
   Подробнее см. в [документации {{ MS }}]({{ ms.docs }}/sql/relational-databases/replication/publish/create-a-publication).

1. Нажмите кнопку **Finish**.

{% note info %}

* При переносе нескольких баз для каждой из них создайте отдельную публикацию.

* Вам потребуются права привилегированного пользователя на все таблицы, выбранные для публикации.

{% endnote %}

### Создайте подписку в кластере-источнике {#create-subscription}

1. Подключитесь к кластеру-источнику из {{ ssms }}.
1. Разверните список объектов сервера в **Object Explorer**.
1. Откройте контекстное меню для директории **Replication** и выберите **New → Subscription**.
1. Пройдите все шаги мастера создания подписки, в том числе:
   1. Для агента-распространителя выберите **Run all agents at the Distributor** (запуск в кластере-источнике).
   1. Добавьте подписчика и укажите [данные для подключения к хосту-мастеру кластера-приемника](../../managed-sqlserver/operations/connect.md#connection-ide).
   1. Выберите для подписчика базу данных кластера-приемника.
   1. В параметрах безопасности **Distribution Agent Security** в блоке **Connect to the Subscriber** укажите имя и пароль учетной записи владельца базы данных в кластере-приемнике.

   Подробнее см. в [документации {{ MS }}]({{ ms.docs }}/sql/relational-databases/replication/create-a-push-subscription).

1. Нажмите кнопку **Finish**.

Запустится процесс репликации. Чтобы следить за его статусом, [запустите монитор]({{ ms.docs }}/sql/relational-databases/replication/monitor/start-the-replication-monitor) и [добавьте подписку для отслеживания]({{ ms.docs }}/sql/relational-databases/replication/monitor/add-and-remove-publishers-from-replication-monitor).

### Остановите процесс репликации и перенесите нагрузку {#transfer-load}

1. Проверьте, что в кластере-приемнике доступны все перенесенные данные с кластера-источника.
1. Переведите кластер-источник в режим <q>только чтение</q>:
   1. Откройте {{ ssms }}.
   1. Откройте контекстное меню для реплицируемой базы данных, затем выберите пункт **Properties**.
   1. Выберите **Database Properties → Options** и в блоке **State** поменяйте значение **Database Read Only** на **True**.
1. [Остановите репликацию]({{ ms.docs }}/sql/relational-databases/replication/agents/start-and-stop-a-replication-agent-sql-server-management-studio) в кластере-источнике.
1. Удалите подписку и публикацию в кластере-источнике. Подтвердите разрешение {{ ssms }} удалить подписчика в кластере-приемнике.
1. Перенесите нагрузку в кластер-приемник.

## Удалите созданные ресурсы {#clear-out}

{% list tabs %}

- Вручную

    Если созданные ресурсы вам больше не нужны, удалите их:

    - [Удалите кластер {{ mms-full-name }}](../../managed-kafka/operations/cluster-delete.md).
    - Если вы зарезервировали публичный статический IP-адрес, освободите и [удалите его](../../vpc/operations/address-delete.md).

- С помощью {{ TF }}

    Чтобы удалить инфраструктуру, созданную с помощью {{ TF }}:

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `sqlserver-data-migration.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `sqlserver-data-migration.tf`, будут удалены.

{% endlist %}
