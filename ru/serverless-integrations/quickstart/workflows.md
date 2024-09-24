---
title: "Начало работы с {{ sw-full-name }}"
description: "В этой инструкции вы создадите рабочий процесс и запустите его."
---

# Начало работы с {{ sw-name }}

{% note info %}

{{ sw-name }} находится на стадии [Preview](../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

С помощью этой инструкции вы создадите [рабочий процесс](../concepts/workflows/workflow.md) и запустите его. Во время выполнения рабочего процесса будут вызываться функции [{{ sf-full-name }}](../../functions/).

## Перед началом работы {#before-you-begin}

Чтобы начать работать в {{ yandex-cloud }}:
1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../../resource-manager/operations/folder/create.md).

## Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
    1. В верхней части экрана перейдите на вкладку **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
    1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md): `sa-for-function`.
    1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роль](../../iam/concepts/access-control/roles.md) `{{ roles-functions-invoker }}`.
    1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**. 

{% endlist %}

## Создайте функцию, которая фильтрует данные {#create-filter-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Создайте функцию:
        1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
        1. Введите имя функции: `filter-function`.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. Создайте версию функции:
        1. В открывшемся окне **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите `Node.js 18`.
        1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
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
        1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите в поле:
            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `index.handler`;
            * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `sa-for-function`.
        1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Создайте функцию, которая возвращает электронные адреса {#create-return-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Создайте функцию:
        1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
        1. Введите имя функции: `return-function`.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. Создайте версию функции:
        1. В открывшемся окне **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите `Node.js 18`.
        1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
        1. Создайте файл `index.js` и добавьте в него следующий код:
            ```js
            module.exports.handler = async function (data, context) {
                return {
                    result: "OK",
                    emails: data.loaded_users.map(p => p.email)
                };
            };
            ```
        1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите в поле:
            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `index.handler`;
            * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `sa-for-function`.
        1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Создайте рабочий процесс {#create-workflow}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ si-name }}**.
    1. Перейдите на вкладку **{{ sw-name }}**.
    1. В правом верхнем углу нажмите кнопку **Создать рабочий процесс**.
    1. Введите имя рабочего процесса.
    1. В поле **Сервисный аккаунт** укажите сервисный аккаунт `sa-for-function`.
    1. В поле **YAML-спецификация** добавьте спецификацию, которая приведена ниже. Укажите в поле `functionId`:
        * в шаге `process_user_transform_info` идентификатор функции `filter-function`;
        * в шаге `upload_users` идентификатор функции `return-function`.

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
    1. Нажмите кнопку **Создать**.

{% endlist %}

## Запустите рабочий процесс {#execute-workflow}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Выберите рабочий процесс.
    1. В правом верхнем углу нажмите **Запустить**.
    1. Введите входные данные в формате JSON:
        ```json
        {
          "resource_type": "users"
        }
        ```
    1. Когда статус рабочего процесса изменится с `Выполняется` на `Выполнен`, в блоке **Данные на выходе** появится следующий JSON-объект:
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

* [Посмотрите еще один пример спецификации рабочего процесса](../concepts/workflows/yawl.md#spec-example)
* [Ознакомьтесь с концепциями {{ sw-name }}](../concepts/workflows/workflow.md)
