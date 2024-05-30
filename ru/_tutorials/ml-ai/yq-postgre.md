{{ yq-full-name }} — это интерактивный сервис для бессерверного анализа данных. С его помощью можно обрабатывать информацию из различных хранилищ без необходимости создания выделенного кластера. Поддерживается работа с хранилищами данных [{{ objstorage-full-name }}](../../storage/), [{{ mpg-full-name }}](../../managed-postgresql/), [{{ mch-full-name }}](../../managed-clickhouse/).

В этом руководстве вы подключитесь к базе данных {{ mpg-name }} и выполните запросы к ней из ноутбука {{ jlab }}Lab с помощью {{ yq-name }}.

1. [Подготовьте инфраструктуру](#infra).
1. [Начните работу в {{ yq-name }}](#yq-begin).
1. [Создайте кластер {{ mpg-name }}](#create-cluster).
1. [Подключитесь к данным {{ mpg-name }}](#mch-connect).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

Ноутбук с примерами также доступен на [GitHub](https://github.com/yandex-cloud-examples/yc-yq-datasphere-examples).

<a href="{{ link-datasphere-main }}/import-ipynb?path=https://raw.githubusercontent.com/yandex-cloud-examples/yc-yq-datasphere-examples/main/Working%20with%20Yandex%20Query%20in%20DataSphere.ipynb"><img src="https://storage.yandexcloud.net/datasphere-assets/datasphere_badge_v2_ru.svg" 
  alt="Открыть в {{ ml-platform-name }}"/></a>


## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для работы с данными {{ mpg-name }} входит:

* плата за использование [вычислительных ресурсов {{ ml-platform-name }}](../../datasphere/pricing.md);
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

  1. Перейдите в каталог `data-folder`.
  1. На вкладке **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `yq-sa`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту роли:
     * `datasphere.community-project.editor` — для запуска вычислений {{ ml-platform-name }}.
     * `yq.editor` — для отправки запросов {{ yq-name }}.
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

{% include [yq-begin](../../_tutorials/_tutorials_includes/yq-begin.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог `data-folder`.
  1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
  1. Выберите сервисный аккаунт `yq-sa`.
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

## Создайте кластер {{ mpg-name }} {#create-cluster}

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

### Создайте таблицу {#create-table}

На этом шаге вы создадите тестовую таблицу со случайными числами от 0 до 100.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}), откройте страницу кластера `postgresql` и перейдите на вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_explore }}**.
  1. Введите **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** и **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**, указанные при создании кластера.
  1. В окно ввода справа вставьте SQL-запрос:

     ```sql
     CREATE TABLE test (
         id SERIAL PRIMARY KEY,
         number INT
     );
 
     INSERT INTO test (number)
     SELECT random() * 100
     FROM generate_series(1, 100);
     ```

  1. Нажмите **Выполнить**.

{% endlist %}

## Подключитесь к данным в {{ mpg-name }} {#mch-connect}

Чтобы создать подключение [подключение](../../query/concepts/glossary.md#connection) {{ yq-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог `data-folder`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
  1. На панели слева выберите **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
  1. Нажмите кнопку ![info](../../_assets/console-icons/plus.svg)**{{ ui-key.yql.yq-connection-form.action_create-new }}**.
  1. Введите имя соединения, например `postgresql`.
  1. Выберите тип соединения **{{ ui-key.yql.yq-connection.postgersql.select-item }}**.
  1. В блоке **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

     * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}** — выберите ранее созданный кластер `postgresql`.
     * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}** — `yq-sa`.
     * **{{ ui-key.yql.yq-connection-form.database.input-label }}** — `db1`.
     * Введите **{{ ui-key.yql.yq-connection-form.login.input-label }}** и **{{ ui-key.yql.yq-connection-form.password.input-label }}**, указанные при создании кластера.

  1. Нажмите кнопку **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

{% endlist %}

Чтобы проверить подключение, получите данные таблицы из ячейки ноутбука:

```sql
%yq SELECT * FROM postgresql.test
```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [удалите кластер](../../managed-postgresql/operations/cluster-delete.md) базы данных;
* [удалите проект](../../datasphere/operations/projects/delete.md).
