# Начало работы с Workflows

{% note info %}

Workflows находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

С помощью этой инструкции вы создадите [рабочий процесс](../concepts/workflows/workflow.md) и запустите его. Во время выполнения рабочего процесса будут вызываться [функции](../../functions/concepts/function.md) [Yandex Cloud Functions](../../functions/index.md).


## Перед началом работы {#before-you-begin}

Чтобы начать работать в Yandex Cloud:
1. Войдите в [консоль управления](https://console.yandex.cloud). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../../resource-manager/operations/folder/create.md).


## Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан [сервисный аккаунт](../../iam/concepts/users/service-accounts.md).
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
    1. Нажмите кнопку **Создать сервисный аккаунт**.
    1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md): `sa-for-function`.
    1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../iam/concepts/access-control/roles.md) `functions.functionInvoker`.
    1. Нажмите кнопку **Создать**. 

{% endlist %}


## Создайте функцию, которая фильтрует данные {#create-filter-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создана функция.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
    1. Создайте функцию:
        1. В правом верхнем углу нажмите кнопку **Создать функцию**.
        1. Введите имя функции: `filter-function`.
        1. Нажмите кнопку **Создать**.
    1. Создайте версию функции:
        1. В открывшемся окне **Редактор** выберите `Node.js 22`.
        1. Отключите опцию **Добавить файлы с примерами кода**.
        1. Нажмите кнопку **Продолжить**.
        1. Создайте файл `index.js` и добавьте в него следующий код:
            ```js
            module.exports.handler = async function (data, context) {
                return {
                    id: data.id,
                    name: data.name,
                    email: data.email,
                };
            };
            ```
        1. В блоке **Параметры** укажите в поле:
            * **Точка входа** — `index.handler`;
            * **Сервисный аккаунт** — `sa-for-function`.
        1. Нажмите кнопку **Сохранить изменения**.

{% endlist %}


## Создайте функцию, которая возвращает электронные адреса {#create-return-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создана функция.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
    1. Создайте функцию:
        1. В правом верхнем углу нажмите кнопку **Создать функцию**.
        1. Введите имя функции: `return-function`.
        1. Нажмите кнопку **Создать**.
    1. Создайте версию функции:
        1. В открывшемся окне **Редактор** выберите `Node.js 22`.
        1. Отключите опцию **Добавить файлы с примерами кода**.
        1. Нажмите кнопку **Продолжить**.
        1. Создайте файл `index.js` и добавьте в него следующий код:
            ```js
            module.exports.handler = async function (data, context) {
                return {
                    result: "OK",
                    emails: data.loaded_users.map(p => p.email)
                };
            };
            ```
        1. В блоке **Параметры** укажите в поле:
            * **Точка входа** — `index.handler`;
            * **Сервисный аккаунт** — `sa-for-function`.
        1. Нажмите кнопку **Сохранить изменения**.

{% endlist %}


## Создайте рабочий процесс {#create-workflow}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создан рабочий процесс.
    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Serverless Integrations**.
    1. На панели слева выберите ![GraphNode](../../_assets/console-icons/graph-node.svg) **Workflows**.
    1. В правом верхнем углу нажмите кнопку **Создать рабочий процесс**.
    1. В поле **YaML-спецификация** добавьте спецификацию, которая приведена ниже. Укажите в поле `functionId`:
        * на 39 строке в шаге `process_user_transform_info` — идентификатор функции `filter-function`;
        * на 44 строке в шаге `upload_users` — идентификатор функции `return-function`.

        ```yaml
        yawl: "0.1"
        start: get_users
        defaultRetryPolicy:
          maxDelay: 10s
          retryCount: 2
          errorList:
            - STEP_QUOTA_EXCEEDED
        steps:
          get_users:
            httpCall:
              url: 'https://jsonplaceholder.typicode.com/\(.resource_type)'
              method: GET
              headers: {}
              query: {}
              output: '\({loaded_users: .})'
              next: process_users
          process_users:
            foreach:
              input: \(.loaded_users)
              output: '\({loaded_users: .})'
              next: upload_users
              do:
                start: process_user_get_info
                steps:
                  process_user_get_info:
                    httpCall:
                      url: https://jsonplaceholder.typicode.com/users/\(.id)
                      method: GET
                      headers: {}
                      query: {}
                      next: process_user_transform_info
                      output: '\({user: .})'
                      retryPolicy:
                        retryCount: 2
                        errorList:
                          - HTTP_CALL_500
                  process_user_transform_info:
                    functionCall:
                      functionId: <идентификатор_функции>
          upload_users:
            functionCall:
              functionId: "<идентификатор_функции>"
              input: '\({loaded_users, resource_type})'
        ```
    1. Разверните блок **Дополнительные параметры**.
    1. В поле **Имя** введите имя рабочего процесса.
    1. В поле **Сервисный аккаунт** выберите сервисный аккаунт `sa-for-function`.
    1. Нажмите кнопку **Создать**.

{% endlist %}


## Запустите рабочий процесс {#execute-workflow}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Выберите рабочий процесс.
    1. В правом верхнем углу нажмите ![triangle-right](../../_assets/console-icons/triangle-right.svg) **Запустить**.
    1. Введите входные данные в формате JSON и нажмите кнопку **Запустить**.

        Входные данные в формате JSON:

        ```json
        {
          "resource_type": "users"
        }
        ```

    1. Когда статус рабочего процесса изменится с `Выполняется` на `Выполнен`, в блоке **Данные на выходе** появится результат в формате JSON:
        ```json
        {
          "result": "OK",
          "emails": [
            "Sincere@april.biz",
            "Shanna@melissa.tv",
            "Nathan@yesenia.net",
            "Julianne.OConner@kory.org",
            "Lucio_Hettinger@annie.ca",
            "Karley_Dach@jasper.info",
            "Telly.Hoeger@billy.biz",
            "Sherwood@rosamond.me",
            "Chaim_McDermott@dana.io",
            "Rey.Padberg@karina.biz"
          ]
        }
        ```

{% endlist %}


## Что дальше {#what-is-next}

* [Посмотрите еще один пример спецификации рабочего процесса](../concepts/workflows/yawl/index.md#spec-example)
* [Ознакомьтесь с концепциями Workflows](../concepts/workflows/workflow.md)