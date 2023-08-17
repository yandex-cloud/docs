---
title: "Визуализация данных из {{ tracker-short-name }}"
description: "Для визуализация данных из {{ tracker-short-name }} необходимо организовать регулярный экспорт данных во внешнее хранилище и средствами {{ datalens-short-name }} визуализировать необходимые метрики и данные."
---

# Визуализация данных из {{ tracker-full-name }}

Визуализация данных из {{ tracker-short-name }} в {{ datalens-full-name }} позволяет построить более сложную аналитику, чем это возможно средствами самого {{ tracker-short-name }}.

Для визуализации данных из {{ tracker-short-name }} в {{ datalens-short-name }} необходимо:
* организовать регулярный экспорт данных во внешнее хранилище;
* визуализировать необходимые метрики и данные с помощью {{ datalens-short-name }}.

Для визуализации данных выполните следующие шаги:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте БД для хранения данных {{ tracker-short-name }}](#database-create).
1. [Создайте OAuth токен для доступа к {{ tracker-short-name }}](#oauth-token).
1. [Создайте функцию {{ sf-name }} для импорта данных](#function-import).
1. [Создайте подключение к {{ datalens-short-name }}](#connection-create).
1. [Создайте дашборд в {{ datalens-short-name }}](#dashboard-create).
1. [Создайте датасет](#dataset-create).
1. [Создайте чарт](#chart-create).
1. [Добавьте чарты на дашборд](#dashboard-create).

## Перед началом работы {#before-you-begin}


{% note info %}

Рекомендуется [создать](../../tracker/enable-tracker.md) отдельную учетную запись {{ tracker-short-name }} для работы с сервисом.

{% endnote %}


{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

* Постоянно запущенный кластер {{ mch-name }} (см. [тарифы {{ mch-name }}](../../managed-clickhouse/pricing.md));
* Использование функции {{ sf-name }} (см. [тарифы {{ sf-name }}](../../functions/pricing.md)).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Создайте БД для хранения данных {{ tracker-short-name }} {#database-create}

1. Перейдите в [консоль управления]({{ link-console-main }}).
1. В левом верхнем углу нажмите кнопку ![](../../_assets/datalens/all-services.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.
1. Выберите **Платформа данных** → **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.clickhouse.button_create-cluster }}**.
1. Укажите параметры кластера:
    * {{ ui-key.yacloud.mdb.forms.section_base }}:
        * **{{ ui-key.yacloud.mdb.forms.base_field_environment }}** — `PRODUCTION`;
        * **{{ ui-key.yacloud.mdb.forms.base_field_version }}** — `22.8 LTS`; 
    * {{ ui-key.yacloud.mdb.forms.new_section_resource }}:
        * **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}** — `{{ ui-key.yacloud.mdb.forms.resource_presets_field_gen_v3 }}`;
        * **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** — `standart`;
        * **{{ ui-key.yacloud.mdb.forms.section_resource }}** — `{{ s3-c2-m8 }}`;
    * {{ ui-key.yacloud.mdb.forms.section_disk }} — `30 {{ ui-key.yacloud.common.units.label_gigabyte }}`;
    * {{ ui-key.yacloud.mdb.forms.section_host }}:
        * **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** — `{{ ui-key.yacloud.common.enabled }}`;
    * {{ ui-key.yacloud.mdb.forms.section_settings }}:
        * **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** — `{{ ui-key.yacloud.common.disabled }}`;
        * **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}** — `{{ ui-key.yacloud.common.disabled }}`;
        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `tracker_data`;
        * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `db1`;
    * {{ ui-key.yacloud.mdb.forms.section_service-settings }}:
        * **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}** — `{{ ui-key.yacloud.common.enabled }}`;
        * **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}** — `{{ ui-key.yacloud.common.enabled }}`.
    Полный список настроек см. в разделе [Настройки {{ mch-name }}](../../managed-clickhouse/concepts/settings-list.md).
1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**. Дождитесь, когда статус созданного кластера сменится на `Alive`. 
1. Скопируйте и сохраните имя хоста для дальнейшей настройки {{ sf-name }}.
![Вкладка Хосты](../../_assets/dl-tracker-host-name.png =680x372)

## Создайте OAuth токен для доступа к {{ tracker-short-name }} {#oauth-token}

1. Перейдите на страницу [Создание приложения](https://oauth.yandex.ru/client/new).
1. Заполните поля:
    * **Название вашего сервиса**;
    * **Платформы** — `Веб-сервисы`;
    * **Redirect URI** — нажмите на строку **Подставить URL для отладки** или впишите адрес `https://oauth.yandex.ru/verification_code`.
1. В разделе **Доступ к данным** укажите:
    * `Чтение из трекера`;
    * `Запись в трекер`.
1. Нажмите кнопку **Создать приложение**.
1. В новом окне введите в адресную строку браузера адрес:

    ```
    https://oauth.yandex.ru/authorize?response_type=token&client_id=ID
    ```

    Где `ID` — идентификатор созданного приложения в поле **ClientID**.

1. Авторизуйтесь с помощью учетной записи {{ tracker-short-name }}, которая будет использоваться для визуализации.
1. Сохраните полученный [OAuth токен](https://cloud.yandex.ru/docs/tracker/concepts/access#section_about_OAauth).

## Создайте функцию {{ sf-name }} для импорта данных {#function-import}

1. Перейдите в [консоль управления]({{ link-console-main }}).
1. В левом верхнем углу нажмите кнопку ![](../../_assets/datalens/all-services.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.
1. Выберите **Бессерверные вычисления** → **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
1. Укажите название функции и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.create.button_create }}**.
1. В открывшемся окне **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** выберите среду выполнения `Python / 3.9`.
1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}**.
1. Прикрепите [тестовый архив](https://github.com/yandex-cloud/yc-architect-solution-library/raw/main/yc-tracker/tracker-data-import/build/tracker-data-import.zip).
1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `tracker_import.handler`.
1. В разделе **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:
    * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `60`;
    * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `1024`;
    * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:
        * `TRACKER_ORG_ID` — ID организации {{ ya-360 }}.
          
          {% note info "Примечание" %}

          Если у вас используется организация {{ org-full-name }} (проверить можно на [странице администрирования](https://tracker.yandex.ru/admin/orgs)), в коде функции `tracker_import.py` замените заголовок `X-Org-ID` на `X-Cloud-Org-Id`.

          {% endnote %}

        * `TRACKER_OAUTH_TOKEN` — [OAuth токен](#oauth-token) учетной записи {{ tracker-short-name }}.
        * `CH_HOST` — имя [хоста](#database-create).
        * `CH_DB` — название [базы данных](#database-create).
        * `CH_USER` — [имя пользователя](#database-create).
        * `CH_PASSWORD` — [пароль](#database-create).
        * `CH_ISSUES_TABLE` — `tracker_issues`.
        * `CH_CHANGELOG_TABLE` — `tracker_changelog`.
        * `TRACKER_INITIAL_HISTORY_DEPTH` — `1d`.
        * `CH_STATUSES_VIEW` — `v_tracker_statuses`.
1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
1. На вкладке **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
1. Результат теста — лог импорта данных:
    ```json
    {
        "statusCode": 200,
        "headers": {
        "Content-Type": "text/plain"
        },
        "isBase64Encoded": false,
        "body": "OK"
    }
    ```
1. Создайте [триггер](../../functions/concepts/trigger/index.md) для регулярного экспорта новых данных в БД:
    1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Нажмите ![trigger](../../_assets/functions/triggers.svg) → **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
    1. Укажите тип триггера — **{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}**.
    1. В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-expression }}** выберите `{{ ui-key.yacloud.common.button_cron-day }}`.
    1. В разделе **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** нажмите кнопку **{{ ui-key.yacloud.component.service-account-select.button_create-account-new }}**.
    1. Укажите имя аккаунта. По умолчанию аккаунту присвоена роль `serverless.functions.invoker` для работы с триггером.
    1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

## Создайте подключение в {{ datalens-short-name }} {#connection-create}

1. Откройте [кластер](#database-create) **{{ mch-name}}**.
1. Откройте вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_datalens }}**.
1. Нажмите **{{ ui-key.yacloud.mdb.datalens.button-action_new-connection }}**.
1. Укажите настройки подключения:
    * **{{ ui-key.datalens.connections.form.field_fill-mode }}** — `Выбрать в каталоге`;
    * **{{ ui-key.datalens.connections.form.field_cluster }}** — кластер, указанный при [создании базы данных](#database-create);
    * **{{ ui-key.datalens.connections.form.field_host-name }}** — хост, указанный при [создании базы данных](#database-create);
    * **{{ ui-key.datalens.connections.form.field_click-house-port }}** — `8443`;
    * **{{ ui-key.datalens.connections.form.field_username }}** — имя пользователя, указанное при [создании базы данных](#database-create);
    * **{{ ui-key.datalens.connections.form.field_password }}** — пароль, указанный при [создании базы данных](#database-create);
    * **{{ ui-key.datalens.connections.form.field_cache-ttl-sec }}** — `{{ ui-key.datalens.connections.form.value_default }}`;
    * **{{ ui-key.datalens.connections.form.field_raw-sql-level }}** — `{{ ui-key.datalens.connections.form.value_raw-sql-level-off }}`;
    * **{{ ui-key.yacloud.common.label_https }}** — `{{ ui-key.yacloud.common.enabled }}`.
    ![Настройки подключения](../../_assets/datalens/connection-settings.png =680x665)
1. Нажмите кнопку **{{ ui-key.datalens.connections.form.button_create-connection }}**.

## Создайте датасет {#dataset-create}

1. Перейдите на [страницу подключений]({{ link-datalens-main }}/connections).
1. Выберите [подключение](#connection-create).
1. В правом верхнем углу нажмите кнопку **{{ ui-key.datalens.connections.form.button_create-dataset }}**.
1. Перенесите на рабочую область одну или несколько таблиц:
    * `db1.v_tracker_issues` — текущий (последний) срез задач; 
    * `db1.v_tracker_changelog` — история изменения параметров задач;
    * `Db1.v_tracker_statuses` – время переходов между статусами на основе истории изменения задач.
1. Нажмите кнопку **{{ ui-key.datalens.dataset.dataset-editor.modify.button_save }}**.

## Создайте чарт {#chart-create}


1. Перейдите на главную страницу [{{ datalens-short-name }}]({{ link-datalens-main }}).
1. Нажмите кнопку **{{ ui-key.datalens.main.landing.view.button_create-widget }}**.
1. В левом верхнем углу нажмите ![image](../../_assets/datalens/datasets.svg) **{{ ui-key.datalens.wizard.button_choose-dataset }}**.
1. В выпадающем списке **{{ ui-key.datalens.wizard.label_datasets }}** выберите [датасет](#dataset-create), созданный на предыдущем шаге.


1. На верхней панели выберите [тип визуализации](../../datalens/visualization-ref/index.md). По умолчанию выбран тип **{{ ui-key.datalens.wizard.label_visualization-column }}**.

## Создайте дашборд {#dashboard-create}

1. На главной странице [{{ datalens-full-name }}]({{ link-datalens-main }}) нажмите **{{ ui-key.datalens.main.landing.view.button_create-dashboards }}**.
1. В открывшемся окне введите название дашборда. Дашборд появится в списке на странице навигации.

Подробнее о настройке дашбордов см. в разделе [Дашборд {{ datalens-full-name }}](../../datalens/concepts/dashboard.md).

## Добавьте чарты на дашборд {#add-charts}

1. В верхней части страницы [дашборда](#dashboard-create) нажмите кнопку **{{ ui-key.datalens.dash.action-panel.view.button_add }}** → **{{ ui-key.datalens.dash.action-panel.view.value_widget }}**.
1. Заполните параметры виджета. Обратите внимание на следующие поля:
    * **{{ ui-key.datalens.dash.widget-dialog.edit.field_title }}**. Задает имя виджета. Отображается на верхней части виджета.
    * **{{ ui-key.datalens.dash.widget-dialog.edit.field_widget }}**. Задает добавляемый виджет.
    * **{{ ui-key.datalens.dash.widget-dialog.edit.field_description }}**. Задает описание виджета. Отображается на нижней части виджета.
    * **{{ ui-key.datalens.dash.widget-dialog.edit.field_autoheight }}**. Задает автоматическую высоту для виджетов типа **{{ ui-key.datalens.wizard.label_visualization-flat-table }}** и **{{ ui-key.datalens.chartkit.menu.export.format_markdown }}**. Если параметр отключен, то высоту виджета на странице можно установить с помощью мыши.
1. Нажмите кнопку **{{ ui-key.datalens.dash.widget-dialog.edit.button_add }}**. Виджет отобразится на дашборде.

{% cut "Пример дашборда на основе данных из таблицы `v_tracker_issues`" %}

![Пример дашборда на основе данных по таблице v_tracker_issues](../../_assets/datalens/dashboard-from-table-issues.png)

{% endcut %}

{% cut "Пример дашборда на основе данных по таблице `db1.v_tracker_statuses`" %}

![Пример дашборда на основе данных по таблице db1.v_tracker_statuses](../../_assets/datalens/dashboard-from-table-statuses.png)

{% endcut %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [Удалите {{ CH }}-кластер](../../managed-clickhouse/operations/cluster-delete.md);
* [Удалите функцию {{ sf-name }}](../../functions/operations/function/function-delete.md).