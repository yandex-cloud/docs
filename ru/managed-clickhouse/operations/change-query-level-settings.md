# Изменение настроек {{ CH }} на уровне пользователя

Вы можете задать [настройки {{ CH }} на уровне пользователя](https://clickhouse.com/docs/en/operations/settings/query-level), чтобы гибко настроить базы данных в кластере {{ mch-name }}. Указать настройки можно несколькими способами:

* С помощью [интерфейсов {{ yandex-cloud }}](#yandex-cloud-interfaces). Так можно задать только [настройки {{ CH }}, доступные в {{ yandex-cloud }}](../concepts/settings-list.md#user-level-settings).
* С помощью SQL-запросов. Так можно задать любые настройки {{ CH }} на уровне пользователя. Способ, как установить настройки, зависит от их типа:

   * [Настройки пользователей](#user). В SQL-запросах `CREATE USER` и `ALTER USER` вы можете передать настройки в условии `SETTINGS`. В результате настройки применятся только к указанному пользователю.

      Чтобы воспользоваться этим способом, при [создании](cluster-create.md) или [изменении](update.md#SQL-management) кластера включите опцию **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}**. После этого нельзя будет управлять пользователями через интерфейсы {{ yandex-cloud }}: управление пользователями через SQL невозможно выключить.

   * [Настройки на уровне профиля](#settings-profile). В {{ CH }} [профиль настроек]({{ ch.docs }}/operations/access-rights#settings-profiles-management) содержит их значения и ограничения, а также список ролей и пользователей, к которым применяется профиль. Настройки {{ CH }} передаются в SQL-запросах `CREATE SETTINGS PROFILE` и `ALTER SETTINGS PROFILE`.

      Чтобы воспользоваться этим способом, при [создании](cluster-create.md) или [изменении](update.md#SQL-management) кластера включите опцию **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}**.

   * [Настройки сессии](#session). Во время сессии можно передать настройки {{ CH }} с помощью SQL-запроса `SET`. Так можно задать настройки в кластере с любой конфигурацией, но они будут действовать только для текущей сессии.

      Способ подходит не для всех SQL-редакторов: в некоторых из них каждый запрос выполняется в отдельной сессии. Проверьте параметры своего SQL-редактора, прежде чем настраивать сессию.

   * [Настройки подключения](#connection). Когда вы подключаетесь к базе данных с помощью утилиты [clickhouse-client](connect/clients.md#clickhouse-client), в команде для подключения можно передать настройки {{ CH }} с помощью флагов. Так можно задать настройки в кластере с любой конфигурацией, но они будут действовать только для установленного подключения.

      Вы можете также указать настройки подключения в различных драйверах для {{ CH }} либо передать настройки в виде URL-параметров при отправке запросов HTTP API {{ CH }}. Подробнее об этих способах см. в [документации {{ CH }}](https://clickhouse.com/docs/en/interfaces/overview).

## Получить список настроек {{ CH }} на уровне пользователя {#get-list}

{% list tabs group=instructions %}

* SQL {#sql}

   1. [Подключитесь](connect/clients.md) к кластеру.
   1. Выполните запрос:

      ```sql
      SELECT name, description, value FROM system.settings;
      ```

      Результат содержит названия, описания и значения настроек {{ CH }} на уровне пользователя. Результат показывает значения для текущей сессии и пользователя, установившего эту сессию.

{% endlist %}

## Задать настройки {{ CH }} через интерфейсы {{ yandex-cloud }} {#yandex-cloud-interfaces}

{% include [change-clickhouse-settings](../../_includes/mdb/mch/change-clickhouse-settings.md) %}

## Задать настройки {{ CH }} в учетной записи пользователя {#user}

Передать настройки {{ CH }} можно при [добавлении нового пользователя](#add-user) или [изменении настроек](#change-user-settings) уже созданного пользователя.

### Добавить нового пользователя с настройками {{ CH }} {#add-user}

{% list tabs group=instructions %}

* SQL {#sql}

   1. [Подключитесь](connect/clients.md) к кластеру под учетной записью `admin`.
   1. Создайте пользователя:

      ```sql
      CREATE USER <имя_пользователя>
         IDENTIFIED WITH sha256_password BY '<пароль_пользователя>'
         SETTINGS <список_настроек_{{ CH }}>;
      ```

      {% include [sql-user-name-and-password-limits](../../_includes/mdb/mch/note-sql-info-user-name-and-pass-limits.md) %}

      В параметре `SETTINGS` помимо значения настройки можно указать ее минимальное и максимальное значение. Пример для настройки [idle_connection_timeout](https://clickhouse.com/docs/en/operations/settings/settings#idle_connection_timeout):

      ```sql
      CREATE USER <имя_пользователя>
         IDENTIFIED WITH sha256_password BY 'password'
         SETTINGS idle_connection_timeout = 60 MIN 5 MAX 120;
      ```

      Подробнее о создании пользователей см. в [документации {{ CH }}]({{ ch.docs }}/sql-reference/statements/create/user/).

{% endlist %}

### Изменить настройки {{ CH }} у пользователя {#change-user-settings}

{% list tabs group=instructions %}

* SQL {#sql}

   1. [Подключитесь](connect/clients.md) к кластеру под учетной записью `admin`.
   1. Измените учетную запись пользователя:

      ```sql
      ALTER USER <имя_пользователя> SETTINGS <список_настроек_{{ CH }}>;
      ```

      Подробнее об изменении учетных записей см. в [документации {{ CH }}]({{ ch.docs }}/sql-reference/statements/alter/user).

{% endlist %}

## Задать настройки {{ CH }} в профиле настроек {#settings-profile}

Передать настройки {{ CH }} можно при [создании](#create-settings-profile) или [изменении профиля настроек](#change-settings-profile).

### Создать профиль с настройками {{ CH }} {#create-settings-profile}

{% list tabs group=instructions %}

* SQL {#sql}

   1. [Подключитесь](connect/clients.md) к кластеру под учетной записью `admin`.
   1. Создайте профиль настроек:

      ```sql
      CREATE SETTINGS PROFILE <название_профиля_настроек>
         SETTINGS <список_настроек_{{ CH }}>;
      ```

      В параметре `SETTINGS` помимо значения настройки можно указать ее минимальное и максимальное значение. Пример для настройки [idle_connection_timeout](https://clickhouse.com/docs/en/operations/settings/settings#idle_connection_timeout):

      ```sql
      CREATE SETTINGS PROFILE <название_профиля_настроек>
         SETTINGS idle_connection_timeout = 60 MIN 5 MAX 120;
      ```

      Профиль настроек можно привязать к пользователю:

      ```sql
      CREATE SETTINGS PROFILE <название_профиля_настроек>
         SETTINGS <список_настроек_{{ CH }}>
         TO <имя_пользователя>;
      ```

      Подробнее о создании профилей настроек см. в [документации {{ CH }}]({{ ch.docs }}/sql-reference/statements/create/settings-profile).

{% endlist %}

### Изменить настройки {{ CH }} в профиле настроек {#change-settings-profile}

{% list tabs group=instructions %}

* SQL {#sql}

   1. [Подключитесь](connect/clients.md) к кластеру под учетной записью `admin`.
   1. Измените профиль настроек:

      ```sql
      ALTER SETTINGS PROFILE <название_профиля_настроек>
         SETTINGS <список_настроек_{{ CH }}>;
      ```

      В этом запросе можно задать граничные значения настроек и привязать профиль к пользователю. Подробнее об изменении профилей настроек см. в [документации {{ CH }}]({{ ch.docs }}/sql-reference/statements/alter/settings-profile).

{% endlist %}

## Задать настройки {{ CH }} в сессии {#session}

{% list tabs group=instructions %}

* SQL {#sql}

   1. [Подключитесь](connect/clients.md) к кластеру.
   1. Выполните запрос:

      ```sql
      SET <имя_пользователя> SETTINGS <список_настроек_{{ CH }}>;
      ```

      Примененные настройки будут действовать только во время открытой сессии.

   1. Убедитесь, что настройки применились:

      ```sql
      SELECT value FROM system.settings;
      ```

      Чтобы посмотреть значение одной настройки, выполните запрос:

      ```sql
      SELECT value FROM system.settings WHERE name='<название_настройки>';
      ```

{% endlist %}

## Задать настройки {{ CH }} при подключении к БД через командную строку {#connection}

{% list tabs group=instructions %}

* SQL {#sql}

   1. [Установите зависимости](connect/clients.md#clickhouse-client), необходимые для подключения к БД.
   1. Посмотрите описание команды для подключения к БД:

      ```bash
      clickhouse-client --help
      ```

      Большинство флагов в выводе команды — это расширенные настройки {{ CH }}.

   1. Выберите флаги с нужными настройками. Для этого соотнесите названия флагов с [названиями настроек {{ CH }}]({{ ch.docs }}/operations/settings/settings).
   1. Укажите выбранные флаги в команде на подключение к БД:

      * Подключение без SSL:

         ```bash
         clickhouse-client --host <FQDN_любого_хоста_{{ CH }}> \
                           --user <имя_пользователя> \
                           --database <имя_БД> \
                           --port 9000 \
                           --ask-password \
                           <флаги_с_настройками_{{ CH }}>
         ```

      
      * Подключение с SSL:

         ```bash
         clickhouse-client --host <FQDN_любого_хоста_{{ CH }}> \
                           --secure \
                           --user <имя_пользователя> \
                           --database <имя_БД> \
                           --port 9440 \
                           --ask-password \
                           <флаги_с_настройками_{{ CH }}>
         ```


      * Пример подключения без SSL с настройкой [idle_connection_timeout](https://clickhouse.com/docs/en/operations/settings/settings#idle_connection_timeout):

         ```bash
         clickhouse-client --host rc1d-***.mdb.yandexcloud.net \
                           --user user1 \
                           --database db1 \
                           --port 9440 \
                           --ask-password \
                           --idle_connection_timeout 60
         ```

   1. Убедитесь, что настройки применились:

      ```sql
      SELECT value FROM system.settings;
      ```

      Чтобы посмотреть значение одной настройки, выполните запрос:

      ```sql
      SELECT value FROM system.settings WHERE name='<название_настройки>';
      ```

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
