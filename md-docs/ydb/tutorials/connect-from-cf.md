# Подключение к базе данных {{ ydb-name }} из функции {{ sf-full-name }} на Python

Создайте [функцию](../../functions/concepts/function.md) с приложением на [Python](https://python.org/), которое выполняет простой запрос к базе данных [{{ ydb-full-name }}](../index.md).

Функция с привязанным [сервисным аккаунтом](../../iam/concepts/users/service-accounts.md) авторизуется в {{ ydb-short-name }} через сервис метаданных.

Приложение создает драйвер подключения к БД {{ ydb-short-name }}, сессию, транзакцию и выполняет запрос, используя библиотеку `ydb`. Эта библиотека устанавливается как [зависимость](../../functions/lang/python/dependencies.md) при создании версии функции. Параметры подключения к БД передаются в приложение через переменные окружения.

Чтобы создать функцию и подключиться к БД:
1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте БД {{ ydb-short-name }}](#create-database).
1. [Создайте функцию](#create-function).
1. [Протестируйте функцию](#test-function).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для этого сценария входит:
* Плата за использование функции (см. [тарифы {{ sf-full-name }}](../../functions/pricing.md)).
* Плата за выполнение запросов к БД (см. [тарифы {{ ydb-name }}](../pricing/serverless.md)).

## Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать сервисный аккаунт.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта, например `sa-function`. Требования к имени:

     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите `{{ roles-editor }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

## Создайте БД {{ ydb-short-name }} {#create-database}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать БД.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. Введите имя БД. Требования к имени:

     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. В блоке **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}** выберите опцию `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

     Дождитесь запуска БД. В процессе создания БД будет иметь статус `Provisioning`. Когда БД станет готова к использованию, статус сменится на `Running`.
  1. Нажмите на имя созданной БД.
  1. В блоке **{{ ui-key.yacloud.ydb.overview.section_connection }}** найдите поле **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** и сохраните его значение. Оно понадобится на следующем шаге.

{% endlist %}

## Создайте функцию {#create-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать функцию.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Введите имя и описание функции. Требования к имени:

     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите среду выполнения `Python`, отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}** создайте файл `index.py` и вставьте в него следующий код:

     ```python
     import os
     import ydb
     import ydb.iam

     # Create driver in global space.
     driver = ydb.Driver(
       endpoint=os.getenv('YDB_ENDPOINT'),
       database=os.getenv('YDB_DATABASE'),
       credentials=ydb.iam.MetadataUrlCredentials(),
     )

     # Wait for the driver to become active for requests.

     driver.wait(fail_fast=True, timeout=5)

     # Create the session pool instance to manage YDB sessions.
     pool = ydb.SessionPool(driver)

     def execute_query(session):
       # Create the transaction and execute query.
       return session.transaction().execute(
         'select 1 as cnt;',
         commit_tx=True,
         settings=ydb.BaseRequestSettings().with_timeout(3).with_operation_timeout(2)
       )

     def handler(event, context):
       # Execute query with the retry_operation helper.
       result = pool.retry_operation_sync(execute_query)
       return {
         'statusCode': 200,
         'body': str(result[0].rows[0].cnt == 1),
       }
     ```

  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}** создайте файл `requirements.txt` и вставьте в него следующий текст:

     ```txt
     ydb
     ```

  1. В качестве точки входа укажите `index.handler`.
  1. Выберите сервисный аккаунт, например `sa-function`.
  1. Настройте переменные окружения:
     * `YDB_ENDPOINT` — введите первую часть сохраненного ранее поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** (часть до вхождения `/?database=`). Например, `{{ ydb.ep-serverless }}`.
     * `YDB_DATABASE` — введите вторую часть сохраненного ранее поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** (часть после вхождения `/?database=`). Например, `/{{ region-id }}/r1gra875baom********/g5n22e7ejfr1********`.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Протестируйте функцию {#test-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}** и посмотрите результат тестирования.

     При успешном подключении к БД и выполнении запроса состояние функции изменится на `Выполнена`, а ответ функции будет содержать следующий текст:

     ```json
     {
       "statusCode": 200,
       "body": "True"
     }
     ```

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите БД](../operations/manage-databases.md#delete-db).
1. [Удалите функцию](../../functions/operations/function/function-delete.md).