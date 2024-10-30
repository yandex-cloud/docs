{{ yq-full-name }} — это интерактивный сервис для бессерверного анализа данных. С его помощью можно обрабатывать информацию из различных хранилищ без необходимости создания выделенного кластера. Поддерживается работа с хранилищами данных [{{ objstorage-full-name }}](../../storage/), [{{ mpg-full-name }}](../../managed-postgresql/), [{{ mch-full-name }}](../../managed-clickhouse/).

Данные из этих систем можно обрабатывать как по отдельности, так и в рамках одного общего запроса — такие запросы называются _федеративными_.

В этом руководстве вы создадите три отдельных хранилища данных: покупатели, купленные товары и даты покупок. С помощью федеративного запроса из ячейки ноутбука вы сможете получить данные из всех хранилищ одновременно.

1. [Подготовьте инфраструктуру](#infra).
1. [Начните работу в {{ yq-name }}](#yq-begin).
1. [Подключитесь к данным {{ objstorage-name }}](#storage-connect).
1. [Подключитесь к данным {{ mch-name }}](#ch-connect).
1. [Подключитесь к данным {{ mpg-name }}](#pg-connect).
1. [Выполните федеративный запрос](#federated_query).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Ноутбук с примерами также доступен на [GitHub](https://github.com/yandex-cloud-examples/yc-yq-datasphere-examples).

<a href="{{ link-datasphere-main }}/import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-yq-datasphere-examples/main/Working%20with%20Yandex%20Query%20in%20DataSphere.ipynb"><img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_ru.svg" 
  alt="Открыть в {{ ml-platform-name }}"/></a>


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для реализации федеративных запросов из этого примера входит:

* плата за использование [вычислительных ресурсов {{ ml-platform-name }}](../../datasphere/pricing.md);
* плата за [хранение данных](../../storage/pricing.md#prices-storage) в бакете;
* плата за запущенный [кластер {{ mch-name }}](../../managed-clickhouse/pricing.md);
* плата за запущенный [кластер {{ mpg-name }}](../../managed-postgresql/pricing.md);
* плата за объем считанных данных при исполнении [запросов {{ yq-name }}](../../query/pricing.md).

## Подготовьте инфраструктуру {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Создайте каталог {#create-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Введите имя каталога, например `data-folder`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Создайте сервисный аккаунт для проекта {{ ml-platform-name }} {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `data-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `yq-sa`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту роли:
     * `datasphere.community-project.editor` — для запуска вычислений {{ ml-platform-name }}.
     * `yq.editor` — для отправки запросов {{ yq-name }}.
     * `storage.viewer` — для просмотра содержимого бакета и объектов {{ objstorage-name }}.
     * `managed-clickhouse.viewer` — для просмотра содержимого кластера {{ mch-name }}.
     * `managed-postgresql.viewer` — для просмотра содержимого кластера {{ mpg-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Добавьте сервисный аккаунт в проект {#sa-to-project}

Чтобы сервисный аккаунт мог запускать проект {{ ml-platform-name }}, добавьте его в список участников проекта. 

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. На вкладке **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** нажмите **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
1. Выберите аккаунт `yq-sa` и нажмите **{{ ui-key.yc-ui-datasphere.common.add }}**.

### Создайте авторизованный ключ для сервисного аккаунта {#create-key}

Чтобы сервисный аккаунт мог отправлять запросы {{ yq-name }}, создайте [авторизованный ключ](../../iam/concepts/authorization/key.md).

{% include [disclaimer](../../_includes/iam/authorized-keys-disclaimer.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `data-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. В открывшемся списке выберите сервисный аккаунт `yq-sa`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** на верхней панели и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
  1. Выберите алгоритм шифрования и нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}**.

{% endlist %}

### Создайте секрет {#create-secret}

Чтобы получить авторизованный ключ из ноутбука, создайте [секрет](../../datasphere/concepts/secrets.md) с содержимым файла авторизованного ключа.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![secret](../../_assets/console-icons/shield-check.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.secret.name }}** задайте имя секрета — `yq_access_key`.
1. В поле **{{ ui-key.yc-ui-datasphere.secret.content }}** вставьте полное содержимое скачанного файла с авторизированным ключом.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**.

### Создайте ноутбук {#create-notebook}

Запросы к базе данных {{ mpg-name }} через {{ yq-name }} будут отправляться из ноутбука.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}** и дождитесь окончания загрузки.
1. На верхней панели нажмите **File** и выберите **New** ⟶ **Notebook**.
1. Выберите ядро и нажмите **Select**.

## Начните работу в {{ yq-name }} {#yq-begin}

{% include [yq-begin](../../_tutorials/_tutorials_includes/yq-begin.md) %}

## Подключитесь к данным {{ objstorage-name }} {#storage-connect}

Для работы с данными {{ objstorage-name }} вам понадобится бакет с таблицей, [подключение](../../query/concepts/glossary.md#connection) {{ yq-name }} и [привязка](../../query/concepts/glossary.md#binding) к данным.

### Создайте бакет с данными {#storage-data}

[Бакет](../../storage/concepts/bucket.md) {{ objstorage-name }} будет содержать даты покупок.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `data-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета.
  1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** выберите **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.
  1. Создайте файл `visits.csv` и поместите в него таблицу с датами покупок:

     ```text
     date|persons_id|item_id
     2024-05-14 12:12:00|1|2
     2024-05-15 13:13:00|2|1
     ```

  1. Перейдите в созданный бакет и нажмите **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
  1. В появившемся окне выберите файл `visits.csv` и нажмите кнопку **Открыть**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.button_upload }}**.

{% endlist %}

### Создайте подключение к {{ objstorage-name }} {#yq-storage}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `data-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
  1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
  1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg)**{{ ui-key.yql.yq-connection-form.action_create-new }}**.
  1. Введите имя соединения, например `storage-connection`.
  1. Выберите тип соединения **{{ ui-key.yql.yq-connection.action_object-storage }}** и укажите **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**.
  1. В поле **{{ ui-key.yql.yq-connection-form.bucket-auth.input-label }}** выберите `{{ ui-key.yql.yq-connection-form.private.button-text }}` и задайте параметры:

     * **{{ ui-key.yql.yq-connection-form.cloud.input-label }}** — `data-folder`.
     * **{{ ui-key.yql.yq-connection-form.bucket.input-label }}** — выберите созданный бакет.
     * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** — `yq-sa`.
  
  1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

{% endlist %}

### Создайте привязку к данным {#create-binding}

Привязка к данным содержит информацию о форматах и расположении файлов в бакете, а также о списке полей данных и их типах.

Чтобы создать привязку к данным:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `data-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
  1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
  1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-binding-add.create-binding.button-text }}**.
  1. В блоке **{{ ui-key.yql.yq-binding-form.connection-parameters.title }}**:

     * **{{ ui-key.yql.yq-binding-form.connection-type.title }}** — выберите **{{ ui-key.yql.yq-connection.action_object-storage }}**.
     * **{{ ui-key.yql.yq-binding-form.connection.title }}** — выберите `storage-connection`.

  1. В блоке **{{ ui-key.yql.yq-binding-form.binding-parameters.title }}**:
  
     1. Введите имя привязки, например `visits`.
     1. В поле **{{ ui-key.yql.yq-binding-form.binding-path-pattern.title }}** укажите [путь к таблице](../../query/sources-and-sinks/object-storage.md#path_format) в бакете — `/visits.csv`.
  
  1. В блоке **{{ ui-key.yql.yq-binding-form.binding-format-settings.title }}**:
     
     * **{{ ui-key.yql.yq-binding-form.binding-format.title }}** — выберите `csv_with_names`.
     * **{{ ui-key.yql.yq-binding-form.binding-format-settings-delimiter.title }}** — `|`.

  1. В блоке **{{ ui-key.yql.yq-binding-form.binding-fields.title }}** добавьте три колонки со следующими именами и типами данных:

     * `date` — `DATETIME`.
     * `person_id` — `INT32`.
     * `items_id` — `INT32`.
  
  1. Чтобы проверить корректность указанных данных, нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}**. Внизу должна появиться ваша таблица.
  1. Нажмите кнопку **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.

{% endlist %}

Чтобы проверить подключение, получите данные таблицы из ячейки ноутбука:

```sql
%yq SELECT * FROM visits LIMIT 100;
```

## Подключитесь к данным {{ mch-name }} {#ch-connect}

Для работы с данными {{ mch-name }} вам понадобится кластер с таблицей и подключение {{ yq-name }}.

### Создайте кластер {{ mch-name }} {#cluster-ch}

Для отправки запросов подойдет любой рабочий кластер {{ mch-name }} со включенной опцией **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}**.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `data-folder`.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Введите имя кластера в поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}**, например `clickhouse`.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}**:

      * В поле **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** выберите из выпадающего списка **{{ ui-key.yacloud.common.enabled }}**.
      * Укажите **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** и **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**:

      * Выберите сервисный аккаунт `yq-sa`.
      * Включите опции **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** и **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}**.

  1. Остальные настройки можно оставить по умолчанию.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

### Создайте таблицу {#ch-data}

Таблица {{ mch-name }} будет содержать названия товаров.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}), откройте страницу кластера `clickhouse` и перейдите на вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_explore }}**.
  1. Введите **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** и **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**, указанные при создании кластера.
  1. В окно ввода справа последовательно выполните SQL-запросы:

     ```sql
     CREATE TABLE items(id INT, description VARCHAR) ENGINE=MergeTree ORDER BY id;
     ```
 
     ```sql
     INSERT INTO items(id, description) VALUES(1, 'Refrigerator')
     ```
 
     ```sql
     INSERT INTO items(id, description) VALUES(2, 'TV')
     ```

  1. Нажмите **{{ ui-key.yacloud.clickhouse.cluster.explore.button_execute }}**.

{% endlist %}

### Создайте подключение к {{ mch-name }} {#yq-ch}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог `data-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
  1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
  1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg)**{{ ui-key.yql.yq-connection-form.action_create-new }}**.
  1. Введите имя соединения, например `clickhouse`.
  1. Выберите тип соединения **{{ ui-key.yql.yq-connection.action_clickhouse }}**.
  1. В блоке **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

     * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}** — выберите ранее созданный кластер `clickhouse`.
     * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** — выберите сервисный аккаунт `yq-sa`.
     * Введите **{{ ui-key.yql.yq-connection-form.login.input-label }}** и **{{ ui-key.yql.yq-connection-form.password.input-label }}**, указанные при создании кластера.

  1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

{% endlist %}

Чтобы проверить подключение, выполните запрос в ячейке ноутбука. Например:

```sql
%yq SELECT * FROM clickhouse.items
```

## Подключитесь к данным {{ mpg-name }} {#pg-connect}

Для работы с данными {{ mpg-name }} вам понадобится кластер с таблицей и подключение {{ yq-name }}.

### Создайте кластер {{ mpg-name }} {#cluster-pg}

Для отправки запросов подойдет любой рабочий кластер {{ mpg-name }} со включенной опцией **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}**.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог `data-folder`.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Введите имя кластера в поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}**, например `postgresql`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}**:
     * Укажите **{{ ui-key.yacloud.mdb.forms.database_field_name }}**, например `db1`.
     * Укажите **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** и **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_service-settings }}** включите опции **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** и **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}**.
  1. Остальные настройки можно оставить по умолчанию.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

### Создайте таблицу {#table-pg}

Таблица {{ mpg-name }} будет содержать имена покупателей.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}), откройте страницу кластера `postgresql` и перейдите на вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_explore }}**.
  1. Введите **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** и **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**, указанные при создании кластера.
  1. В окно ввода справа последовательно выполните SQL-запросы:

     ```sql
     CREATE TABLE persons(person_id INT, name VARCHAR);
     ```
 
     ```sql
     INSERT INTO persons(person_id, name) values(1, 'Ivan')
     ```
 
     ```sql
     INSERT INTO persons(person_id, name) values(2, 'Peter')
     ```

{% endlist %}

### Создайте подключение к {{ mpg-name }} {#yq-pg}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог `data-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
  1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
  1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg)**{{ ui-key.yql.yq-connection-form.action_create-new }}**.
  1. Введите имя соединения, например `postgresql`.
  1. Выберите тип соединения **{{ ui-key.yql.yq-connection.action_postgersql }}**.
  1. В блоке **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

     * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}** — выберите ранее созданный кластер `postgresql`.
     * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** — `yq-sa`.
     * **{{ ui-key.yql.yq-connection-form.database.input-label }}** — `db1`.
     * Введите **{{ ui-key.yql.yq-connection-form.login.input-label }}** и **{{ ui-key.yql.yq-connection-form.password.input-label }}**, указанные при создании кластера.

  1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

{% endlist %}

Чтобы проверить подключение, выполните запрос в ячейке ноутбука. Например:

```sql
%yq SELECT * FROM postgresql.persons
```

## Выполните федеративный запрос {#federate-query}

Работа с федеративными источниками данных (межсервисная аналитика) ничем не отличается от работы с обычными источниками данных. К внешним источникам данных, таким как таблицы в БД и данные в {{ objstorage-name }}, можно одновременно обращаться из запроса и выполнять над ними любые допустимые языком YQL операции.

Чтобы совместить и получить данные из всех трех таблиц, выполните федеративный запрос в ячейке ноутбука:

```sql
%%yq SELECT 
    v.person_id, 
    date, 
    p.name,
    c.description 
FROM visits AS v 
    INNER JOIN postgresql.persons AS p ON 
        v.person_id = p.person_id 
    INNER JOIN clickhouse.items AS c ON
        v.item_id = c.id
```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [удалите бакет](../../storage/operations/buckets/delete.md);
* [удалите кластер](../../managed-clickhouse/operations/cluster-delete.md) {{ mch-name }};
* [удалите кластер](../../managed-postgresql/operations/cluster-delete.md) {{ mpg-name }};
* [удалите проект](../../datasphere/operations/projects/delete.md).

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}