Организовать сценарии регулярных запусков в [{{ ml-platform-full-name }}]({{ link-datasphere-main }}) можно с помощью API, вызывая исполнение ячеек ноутбука в [{{ sf-full-name }}](../../functions/index.yaml).

В этом практическом руководстве вы соберете информацию о наиболее обсуждаемых на [Reddit](https://tradestie.com/api/v1/apps/reddit) акциях, проанализируете тональность обсуждения и настроите регулярное обновление данных.

Сбор и анализ информации об акциях выполняется в {{ ml-platform-name }}, регулярное исполнение ячеек запускается по таймеру, созданному в {{ sf-name }}.

Чтобы настроить регулярный запуск {{ jlab }} Notebook:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте ноутбук](#create-notebook).
1. [Загрузите и обработайте данные](#load-data).
1. [Создайте {{ sf-name }}](#create-function).
1. [Создайте таймер](#create-timer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость реализации регулярных запусков входят:

* плата за использование [вычислительных ресурсов {{ ml-platform-name }}](../../datasphere/pricing.md);
* плата за количество вызовов функции [{{ sf-name }}](../../functions/pricing.md).

## Подготовьте инфраструктуру {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Создайте каталог {#create-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Введите имя каталога, например `data-folder`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Создайте сервисный аккаунт для проекта {{ ml-platform-name }} {#create-sa}

Для доступа к проекту {{ml-platform-name }} из функции {{ sf-name }} вам понадобится сервисный аккаунт с ролями `{{ roles-datasphere-project-editor }}` и `{{ roles-functions-invoker }}`.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите в каталог `data-folder`.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `reddit-user`.
   1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и назначьте сервисному аккаунту роли `{{ roles-datasphere-project-editor }}` и `{{ roles-functions-invoker }}`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Добавьте сервисный аккаунт в проект {#sa-to-project}

Чтобы сервисный аккаунт мог запускать проект {{ ml-platform-name }}, добавьте его в список участников проекта.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
    1. На вкладке **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** нажмите **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
    1. Выберите аккаунт `reddit-user` и нажмите **{{ ui-key.yc-ui-datasphere.common.add }}**.

{% endlist %}

### Настройте проект {#setup-project}

Чтобы сократить расходы на использование сервиса {{ml-platform-name }}, настройте время, через которое освобождается закрепленная за проектом ВМ.

1. {% include [include](../../_includes/datasphere/ui-find-project.md) %}
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.project-page.tab.settings }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.common.general }}** нажмите кнопку ![pencil](../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-datasphere.common.edit }}**
1. Для настройки **{{ ui-key.yc-ui-datasphere.edit-project-page.dedicated-vm-inactivity-timeout }}** выберите `{{ ui-key.yc-ui-datasphere.common.custom }}` и укажите 5 минут.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.save }}**.

## Создайте ноутбук {#create-notebook}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}** и дождитесь окончания загрузки.
1. На верхней панели нажмите **File** и выберите **New** → **Notebook**.
1. Выберите ядро и нажмите **Select**.
1. Нажмите правой кнопкой мыши на ноутбук и выберите **Rename**. Введите название `test_classifier.ipynb`.

## Загрузите и обработайте данные {#load-data}

Чтобы загрузить информацию о наиболее обсуждаемых акциях на Reddit и тональности обсуждения, скопируйте код в ячейки ноутбука `test_classifier.ipynb`. С его помощью вы будете выбирать три наиболее обсуждаемые акции и сохранять их в CSV-файл в хранилище проекта.

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Импортируйте библиотеки:

    ```python
    import pandas as pd
    import requests
    import os.path
    ```

1. Инициализируйте переменные:

    ```python
    REQUEST_URL = "https://tradestie.com/api/v1/apps/reddit"
    FILE_NAME = "/home/jupyter/datasphere/project/stock_sentiments_data.csv"
    TICKERS = ['NVDA', 'TSLA', 'AAPL']
    ```

1. Создайте функцию, которая отправляет запрос к API tradestie и возвращает результат в виде `pandas.DataFrame`:

    ```python
    def load_data():
        response = requests.get(REQUEST_URL)
        stocks = pd.DataFrame(response.json())
        stocks = stocks[stocks['ticker'].isin(TICKERS)]
        stocks.drop('sentiment', inplace=True, axis=1)
        return stocks
    ```

1. Задайте условие, определяющее файл для записи сведений об акциях:

    ```python
    if os.path.isfile(FILE_NAME):
        stocks = pd.read_csv(FILE_NAME)
    else:
        stocks = load_data()
        stocks['count'] = 1
        stocks.to_csv(FILE_NAME, index=False)
    ```

1. Загрузите новые данные об акциях:

    ```python
    stocks_update = load_data()
    ```

1. Сравните новые данные с имеющимися:

    ```python
    stocks = stocks.merge(stocks_update, how='left', on = 'ticker')
    stocks['no_of_comments_y'] = stocks['no_of_comments_y'].fillna(stocks['no_of_comments_x'])
    stocks['sentiment_score_y'] = stocks['sentiment_score_y'].fillna(stocks['sentiment_score_y'])
    ```

1. Обновите средние арифметические количества комментариев и оценки тональности:

    ```python
    stocks['count'] += 1 
    stocks['no_of_comments_x'] += (stocks['no_of_comments_y'] - stocks['no_of_comments_x'])/stocks['count'] 
    stocks['sentiment_score_x'] += (stocks['sentiment_score_y'] - stocks['sentiment_score_x'])/stocks['count']
    stocks = stocks[['no_of_comments_x', 'sentiment_score_x', 'ticker', 'count']]
    stocks.columns = ['no_of_comments', 'sentiment_score', 'ticker', 'count']
    print(stocks)
    ```

1. Сохраните результаты в файл:

    ```python
    stocks.to_csv(FILE_NAME, index=False)
    ```

## Создайте {{ sf-name }} {#create-function}

Чтобы запускать вычисления, не открывая {{ jlab }}Lab, вам понадобится {{ sf-name }}, которая будет инициировать запуск вычислений в ноутбуке по API.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
    1. Введите имя функции, например `my-function`.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-function }}**.

{% endlist %}

### Создайте версию {{ sf-name }} {#create-function-ver}

[Версия](../../functions/concepts/function.md#version) содержит код функции, параметры запуска и все необходимые зависимости.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию, версию которой хотите создать.
    1. В разделе **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}** нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
    1. Выберите среду выполнения `Python`. Не выбирайте опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
    1. Выберите способ **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-editor }}**.
    1. Нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.create-file }}** и введите имя файла, например `index`.
    1. Введите код функции, подставив идентификатор вашего проекта и абсолютный путь к ноутбуку в проекте:

        ```python
        import requests
    
        def handler(event, context):

            url = 'https://datasphere.{{ api-host }}/datasphere/v2/projects/<идентификатор_проекта>:execute'
            body = {"notebookId": "/home/jupyter/datasphere/project/test_classifier.ipynb"}
            headers = {"Content-Type" : "application/json",
                       "Authorization": "Bearer {}".format(context.token['access_token'])}
            resp = requests.post(url, json = body, headers=headers)

            return {
            'body': resp.json(),
            }
        ```

       Где:
       * `<идентификатор_проекта>` — идентификатор проекта {{ ml-platform-name }}, который расположен на странице проекта под названием.
       * `notebookId` — абсолютный путь к ноутбуку в проекте.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** задайте параметры версии:
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `index.handler`.
       * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `reddit-user`.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Создайте таймер {#create-timer}

Для запуска функции каждые 15 минут вам понадобится [таймер](../../functions/concepts/trigger/timer.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать таймер.

    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_timer }}** укажите расписание вызова функции `{{ ui-key.yacloud.common.button_cron-15min }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию и укажите:

       * [{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}](../../functions/concepts/function.md#tag).
       * {{ ui-key.yacloud.serverless-functions.triggers.form.field_function_service-account }} `reddit-user`, от имени которого будет вызываться функция.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}

Теперь файл `stock_sentiments_data.csv` будет обновляться каждые 15 минут. Найти его можно рядом с ноутбуком.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [Удалите](../../functions/operations/function/function-delete) функцию;
* [Удалите](../../functions/operations/trigger/trigger-delete) триггер;
* [Удалите](../../datasphere/operations/projects/delete) проект.
