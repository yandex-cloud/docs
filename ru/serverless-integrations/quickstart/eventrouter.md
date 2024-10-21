---
title: Начало работы с {{ er-full-name }}
description: Следуя данной инструкции, вы создадите шину и передадите через нее данные.
keywords:
  - eventrouter
  - event router
  - шина
  - коннектор
  - правило
---

# Начало работы с {{ er-name }}

{% note info %}

{{ er-name }} находится на стадии [Preview](../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

С помощью этой инструкции вы создадите очередь [{{ message-queue-name }}](../../message-queue/) и отправите в нее сообщение, которое через [шину](../concepts/eventrouter/bus.md) будет передано в функцию [{{ sf-name }}](../../functions/).

## Перед началом работы {#before-you-begin}

Чтобы начать работать в {{ yandex-cloud }}:
1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../../resource-manager/operations/folder/create.md).

## Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
    1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md): `sa-for-eventrouter`.
    1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роли](../../iam/concepts/access-control/roles.md) `{{ roles-functions-invoker }}`, `ymq.reader` и `ymq.writer`.
    1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**. 

{% endlist %}

## Создайте очередь {#create-queue}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.ymq.queues.button_create }}**.
   1. Укажите имя очереди: `sample-queue`.
   1. Выберите тип `{{ ui-key.yacloud.ymq.queue.form.type_switch_standard }}`. Не изменяйте другие настройки.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
   1. Откройте созданную очередь.
   1. На вкладке **{{ ui-key.yacloud.common.overview }}** в блоке **{{ ui-key.yacloud.ymq.queue.overview.section_base }}** скопируйте URL и ARN очереди, они понадобятся позднее.

{% endlist %}

## Создайте функцию {#create-filter-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Создайте функцию:
        1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
        1. Введите имя функции: `eventrouter-function`.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. Создайте версию функции:
        1. В открывшемся окне **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите `Node.js 18`.
        1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
        1. Создайте файл `index.js` и добавьте в него следующий код:
            ```js
			module.exports.handler = async function (event, context) {
			    console.log(JSON.stringify(event))
			    return {
			        statusCode: 200,
			        body: "",
			    };
			};
            ```
        1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите в поле:
            * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `index.handler`;
            * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `sa-for-eventrouter`.
        1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Создайте шину {#create-bus}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ si-name }}**.
    1. Перейдите на вкладку **{{ er-name }}**.
    1. В правом верхнем углу нажмите **Создать шину**.
    1. Введите имя шины и нажмите **Создать**.

{% endlist %}

## Создайте коннектор {#create-connector}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Выберите шину.
    1. Перейдите на вкладку **Коннекторы**.
    1. В правом верхнем углу нажмите **Создать коннектор**.
    1. В поле **Источник** выберите `{{ message-queue-full-name }}`.
    1. В поле **Очередь сообщений** укажите ARN очереди.
    1. В поле **Сервисный аккаунт** укажите `sa-for-eventrouter`.
    1. Нажмите кнопку **Создать**.

{% endlist %}

## Создайте правило {#create-rule}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Выберите шину.
    1. Перейдите на вкладку **Правила**.
    1. В правом верхнем углу нажмите **Создать правило**.
    1. В блоке **Приёмники** нажмите кнопку **Добавить**.
    1. В поле **Тип** выберите `{{ sf-full-name }}`.
    1. В поле **Функция** укажите `eventrouter-function`.
    1. В поле **Сервисный аккаунт** укажите `sa-for-eventrouter`.
    1. Нажмите кнопку **Создать**.

{% endlist %}

## Отправьте сообщение в очередь {#send-message}

{% list tabs group=instructions %}

- AWS CLI {#cli}

    1. [Установите](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) AWS CLI.
    1. [Создайте](../../iam/operations/sa/create-access-key.md) статические ключи доступа для сервисного аккаунта `sa-for-eventrouter`. Надежно сохраните идентификатор и секретный ключ. После того, как вы закроете окно, параметры секретного ключа станут недоступны.
    1. Настройте AWS CLI:

       {% include [configure-aws-cli](../../_includes/message-queue/configure-aws-cli.md) %}

    1. Отправьте сообщение в очередь `sample-queue`, используя сохраненный ранее URL очереди:

        ```bash
         aws sqs send-message \
           --message-body "Hello World" \
           --endpoint https://message-queue.api.cloud.yandex.net/ \
           --queue-url <URL_очереди>
         ```

         Результат:
         
         ```json
         {
             "MD5OfMessageBody": "67e63db14341b5a696596634********",
             "MessageId": "765ff4d2-fa4bc83-6cfcc***-*****"
         }
         ```

{% endlist %}

## Убедитесь, что функция вызвалась {#check}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию `eventrouter-function`.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}**. В логах должны отобразиться сообщения, которые вы отправили в очередь.

{% endlist %}

## Что дальше {#what-is-next}

* [Ознакомьтесь с концепциями {{ er-name }}](../concepts/eventrouter/bus.md)
