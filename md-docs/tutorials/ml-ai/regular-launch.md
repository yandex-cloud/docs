[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Машинное обучение и искусственный интеллект](index.md) > Разработка с помощью DataSphere > Запуск вычислений по расписанию в DataSphere

# Запуск вычислений по расписанию в Yandex DataSphere

Организовать сценарии регулярных запусков в [Yandex DataSphere](https://datasphere.yandex.cloud) можно с помощью API, вызывая исполнение ячеек ноутбука в [Yandex Cloud Functions](../../functions/index.md).

В этом практическом руководстве вы соберете информацию о наиболее обсуждаемых на [Reddit](https://tradestie.com/api/v1/apps/reddit) акциях, проанализируете тональность обсуждения и настроите регулярное обновление данных.

Сбор и анализ информации об акциях выполняется в DataSphere, регулярное исполнение ячеек запускается по таймеру, созданному в Cloud Functions.

Чтобы настроить регулярный запуск Jupyter Notebook:

1. [Подготовьте инфраструктуру](#infra).
1. [Создайте ноутбук](#create-notebook).
1. [Загрузите и обработайте данные](#load-data).
1. [Создайте Cloud Functions](#create-function).
1. [Создайте таймер](#create-timer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Перед началом работы нужно зарегистрироваться в Yandex Cloud, настроить [сообщество](../../datasphere/concepts/community.md) и привязать к нему [платежный аккаунт](../../billing/concepts/billing-account.md):
1. [На главной странице DataSphere](https://datasphere.yandex.cloud) нажмите **Попробовать бесплатно** и выберите аккаунт для входа — Яндекс ID или рабочий аккаунт в федерации (SSO).
1. Выберите [организацию Yandex Identity Hub](../../organization/index.md), в которой вы будете работать в Yandex Cloud.
1. [Создайте сообщество](../../datasphere/operations/community/create.md).
1. [Привяжите платежный аккаунт](../../datasphere/operations/community/link-ba.md) к сообществу DataSphere, в котором вы будете работать. Убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, создайте его в интерфейсе DataSphere.

### Необходимые платные ресурсы {#paid-resources}

В стоимость реализации регулярных запусков входят:

* плата за использование [вычислительных ресурсов DataSphere](../../datasphere/pricing.md);
* плата за количество вызовов функции [Cloud Functions](../../functions/pricing.md).

## Подготовьте инфраструктуру {#infra}

Войдите в [консоль управления](https://console.yandex.cloud) Yandex Cloud и выберите организацию, в которой вы работаете с DataSphere. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен платежный аккаунт.

Если у вас есть активный платежный аккаунт, на [странице облака](https://console.yandex.cloud/cloud) вы можете создать или выбрать каталог, в котором будет работать ваша инфраструктура.

{% note info %}

Если вы работаете с Yandex Cloud через [федерацию удостоверений](../../organization/concepts/add-federation.md), вам может быть недоступна платежная информация. В этом случае обратитесь к администратору вашей организации в Yandex Cloud.

{% endnote %}

### Создайте каталог {#create-folder}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите облако и нажмите кнопку ![create](../../_assets/console-icons/plus.svg) **Создать каталог**.
   1. Введите имя каталога, например `data-folder`.
   1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте сервисный аккаунт для проекта DataSphere {#create-sa}

Для доступа к проекту DataSphere из функции Cloud Functions вам понадобится сервисный аккаунт с ролями `datasphere.community-projects.editor` и `functions.functionInvoker`.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите в каталог `data-folder`.
   1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
   1. Нажмите кнопку **Создать сервисный аккаунт**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `reddit-user`.
   1. Нажмите **Добавить роль** и назначьте сервисному аккаунту роли `datasphere.community-projects.editor` и `functions.functionInvoker`.
   1. Нажмите кнопку **Создать**.

{% endlist %}

### Добавьте сервисный аккаунт в проект {#sa-to-project}

Чтобы сервисный аккаунт мог запускать проект DataSphere, добавьте его в список участников проекта.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
    1. На вкладке **Участники** нажмите **Добавить участника**.
    1. Выберите аккаунт `reddit-user` и нажмите **Добавить**.

{% endlist %}

### Настройте проект {#setup-project}

Чтобы сократить расходы на использование сервиса DataSphere, настройте время, через которое освобождается закрепленная за проектом ВМ.

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. Перейдите на вкладку **Настройки**.
1. В блоке **Общие настройки** нажмите кнопку ![pencil](../../_assets/console-icons/pencil-to-line.svg) **Редактировать**
1. Для настройки **Остановить простаивающую ВМ через** выберите `Другое` и укажите 5 минут.
1. Нажмите кнопку **Сохранить**.

## Создайте ноутбук {#create-notebook}

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. Нажмите кнопку **Открыть проект в JupyterLab** и дождитесь окончания загрузки.
1. На верхней панели нажмите **File** и выберите **New** → **Notebook**.
1. Выберите ядро и нажмите **Select**.
1. Нажмите правой кнопкой мыши на ноутбук и выберите **Rename**. Введите название `test_classifier.ipynb`.

## Загрузите и обработайте данные {#load-data}

Чтобы загрузить информацию о наиболее обсуждаемых акциях на Reddit и тональности обсуждения, скопируйте код в ячейки ноутбука `test_classifier.ipynb`. С его помощью вы будете выбирать три наиболее обсуждаемые акции и сохранять их в CSV-файл в хранилище проекта.

1. Откройте проект DataSphere:
   
   1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
   1. Нажмите кнопку **Открыть проект в JupyterLab** и дождитесь окончания загрузки.
   1. Откройте вкладку с ноутбуком.

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

## Создайте Cloud Functions {#create-function}

Чтобы запускать вычисления, не открывая JupyterLab, вам понадобится Cloud Functions, которая будет инициировать запуск вычислений в ноутбуке по API.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать функцию.
    1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
    1. Нажмите кнопку **Создать функцию**.
    1. Введите имя функции, например `my-function`.
    1. Нажмите кнопку **Создать функцию**.

{% endlist %}

### Создайте версию Cloud Functions {#create-function-ver}

[Версия](../../functions/concepts/function.md#version) содержит код функции, параметры запуска и все необходимые зависимости.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится функция.
    1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
    1. Выберите функцию, версию которой хотите создать.
    1. В разделе **Последняя версия** нажмите кнопку **Создать в редакторе**.
    1. Выберите среду выполнения `Python`. Не выбирайте опцию **Добавить файлы с примерами кода**.
    1. Выберите способ **Редактор кода**.
    1. Нажмите **Создать файл** и введите имя файла, например `index`.
    1. Введите код функции, подставив идентификатор вашего проекта и абсолютный путь к ноутбуку в проекте:

        ```python
        import requests
    
        def handler(event, context):

            url = 'https://datasphere.api.cloud.yandex.net/datasphere/v2/projects/<идентификатор_проекта>:execute'
            body = {"notebookId": "/home/jupyter/datasphere/project/test_classifier.ipynb"}
            headers = {"Content-Type" : "application/json",
                       "Authorization": "Bearer {}".format(context.token['access_token'])}
            resp = requests.post(url, json = body, headers=headers)

            return {
            'body': resp.json(),
            }
        ```

       Где:
       * `<идентификатор_проекта>` — идентификатор проекта DataSphere, который расположен на странице проекта под названием.
       * `notebookId` — абсолютный путь к ноутбуку в проекте.

    1. В блоке **Параметры** задайте параметры версии:
       * **Точка входа** — `index.handler`.
       * **Сервисный аккаунт** — `reddit-user`.
    1. Нажмите кнопку **Сохранить изменения**.

{% endlist %}

## Создайте таймер {#create-timer}

Для запуска функции каждые 15 минут вам понадобится [таймер](../../functions/concepts/trigger/timer.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать таймер.

    1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.

    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:

        * Введите имя и описание триггера.
        * В поле **Тип** выберите `Таймер`.
        * В поле **Запускаемый ресурс** выберите `Функция`.

    1. В блоке **Настройки таймера** укажите расписание вызова функции `Каждые 15 минут`.

    1. В блоке **Настройки функции** выберите функцию и укажите:

       * [Тег версии функции](../../functions/concepts/function.md#tag).
       * Сервисный аккаунт `reddit-user`, от имени которого будет вызываться функция.

    1. Нажмите кнопку **Создать триггер**.

{% endlist %}

Теперь файл `stock_sentiments_data.csv` будет обновляться каждые 15 минут. Найти его можно рядом с ноутбуком.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [Удалите](../../functions/operations/function/function-delete.md) функцию;
* [Удалите](../../functions/operations/trigger/trigger-delete.md) триггер;
* [Удалите](../../datasphere/operations/projects/delete.md) проект.