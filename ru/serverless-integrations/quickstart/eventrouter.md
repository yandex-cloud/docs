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

{% include [event-router-preview-note](../../_includes/serverless-integrations/event-router-preview-note.md) %}

С помощью этой инструкции вы, используя [шину](../concepts/eventrouter/bus.md) {{ er-name }}, перенаправите сообщение из очереди [{{ message-queue-name }}](../../message-queue/) в [рабочий процесс](../concepts/workflows/workflow.md) {{ sw-name }}.

Сообщение, которое поступает в очередь, будет перенаправляться в рабочий процесс, если соответствует фильтру, заданному в правиле внутри шины. Рабочий процесс при этом будет автоматически запускаться. Перед отправкой в него сообщение будет преобразовываться по шаблону, заданному в том же правиле, что и фильтр.

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
    1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роли `serverless.workflows.executor`, [ymq.reader](../../iam/roles-reference.md#ymq-reader) и [ymq.writer](../../iam/roles-reference.md#ymq-writer).
    1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**. 

{% endlist %}

## Создайте очередь {#create-queue}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.ymq.queues.button_create }}**.
    1. Введите имя очереди: `sample-queue`.
    1. Выберите тип `{{ ui-key.yacloud.ymq.queue.form.type_switch_standard }}`. Не изменяйте другие настройки.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. Откройте созданную очередь.
    1. На вкладке **{{ ui-key.yacloud.common.overview }}** в блоке **{{ ui-key.yacloud.ymq.queue.overview.section_base }}** скопируйте URL и ARN очереди, они понадобятся позднее.

{% endlist %}

## Создайте рабочий процесс {#create-workflow}

{% include [workflows-preview-note](../../_includes/serverless-integrations/workflows-preview-note.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
    1. На панели слева выберите ![GraphNode](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
    1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.serverless-workflows.button_create-workflow }}**.
    1. В поле **{{ ui-key.yacloud.serverless-workflows.spec-editor-type_label_text-editor }}** добавьте следующую спецификацию:
        ```
        yawl: "0.1"
        start: noopstep
        steps:
          noopstep:
            noOp:
              output: |-
                \(.)
        ```
    1. Разверните блок **{{ ui-key.yacloud.serverless-workflows.label_additional-parameters }}**.
    1. В поле **{{ ui-key.yacloud.common.name }}** введите имя рабочего процесса: `sample-workflow`.
    1. В поле **{{ ui-key.yacloud.serverless-workflows.label_service-account }}** выберите сервисный аккаунт `sa-for-eventrouter`.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Создайте шину {#create-bus}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
    1. На панели слева выберите ![ObjectAlignCenterVertical](../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
    1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.serverless-event-router.button_create-bus }}**.
    1. Введите имя шины: `sample-bus`.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Создайте коннектор {#create-connector}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Выберите шину `sample-bus`.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-event-router.label_connectors }}**.
    1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.serverless-event-router.button_create-connector }}**.
    1. В поле **{{ ui-key.yacloud.serverless-event-router.label_connector-source }}** выберите `{{ message-queue-full-name }}`.
    1. В поле **Очередь сообщений** укажите ARN очереди.
    1. В поле **Сервисный аккаунт** укажите `sa-for-eventrouter`.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Создайте правило {#create-rule}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Выберите шину `sample-bus`.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-event-router.label_rules }}**.
    1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.serverless-event-router.button_create-rule }}**.
    1. Разверните блок **{{ ui-key.yacloud.serverless-event-router.label_filter }}** и укажите следующее jq-выражение для фильтрации сообщений:
        ```
        .httpMethod == "GET" and (.headers.Host | test("^d5dm"))
        ```
    1. В блоке **{{ ui-key.yacloud.serverless-event-router.label_targets}}** нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
    1. В поле **{{ ui-key.yacloud.serverless-event-router.label_target-type }}** выберите `{{ sw-full-name }}`.
    1. В поле **Рабочий процесс** укажите `sample-workflow`.
    1. В поле **Сервисный аккаунт** укажите `sa-for-eventrouter`.
    1. Разверните блок **{{ ui-key.yacloud.serverless-event-router.label_target-transformer }}** и укажите jq-выражение для преобразования сообщений:
        ```
        {
           "message": "API gateway host is \(.headers.Host)."
        }
        ```
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Отправьте сообщение в очередь {#send-message}

Убедитесь, что сообщения, которые соответствуют созданному правилу, преобразовываются и перенаправляются в рабочий процесс.

{% list tabs group=instructions %}

- AWS CLI {#cli}

    1. [Установите](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) AWS CLI.
    1. [Создайте](../../iam/operations/sa/create-access-key.md) статические ключи доступа для сервисного аккаунта `sa-for-eventrouter`. Надежно сохраните идентификатор и секретный ключ. После того, как вы закроете окно, параметры секретного ключа станут недоступны.
    1. Настройте AWS CLI:

       {% include [configure-aws-cli](../../_includes/message-queue/configure-aws-cli.md) %}

    1. Отправьте первое сообщение в очередь `sample-queue`, используя сохраненный ранее URL очереди:

        ```bash
        aws sqs send-message \
          --message-body '{"httpMethod":"GET","headers":{"Host":"h6ds1lb3s0df********.k7******.apigw.yandexcloud.net"}}' \
          --endpoint {{ ymq-endpoint }} \
          --queue-url <URL_очереди>
        ```

         Результат:
         
        ```json
        {
            "MD5OfMessageBody": "c37859ba35a9958be041467c********",
            "MessageId": "f845****-9260****-7527****-f4b0****",
            "SequenceNumber": "0"
        }
         ```
    1. Убедитесь, что фильтр, который вы указали в правиле, не пропустил сообщение через шину:

        1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
        1. На панели слева выберите ![GraphNode](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
        1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-workflows.label_workflow-executions }}**. На странице не должно быть выполненных запусков.

    1. Отправьте второе сообщение в очередь `sample-queue`, используя сохраненный ранее URL очереди:

        ```bash
        aws sqs send-message \
          --message-body '{"httpMethod":"GET","headers":{"Host":"{{ api-host-apigw }}"}}' \
          --endpoint {{ ymq-endpoint }} \
          --queue-url <URL_очереди>
        ```

         Результат:
         
        ```json
        {
            "MD5OfMessageBody": "c37859ba35a9958be041467c********",
            "MessageId": "f845****-9260****-7527****-f4b0****",
            "SequenceNumber": "0"
        }
         ```
    1. Убедитесь, что фильтр, который вы указали в правиле, пропустил сообщение через шину, оно преобразовалось по шаблону и перенаправилось в рабочий процесс:

        1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
        1. На панели слева выберите ![GraphNode](../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.serverless-workflows.label_service }}**.
        1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-workflows.label_workflow-executions }}**. На странице должен отобразиться выполненный запуск.
        1. Выберите выполненный запуск.
        1. Убедитесь, что в блоке **{{ ui-key.yacloud.serverless-workflows.label_input_data }}** отображается преобразованное сообщение:
            ```
            {
               "message": "API gateway host is {{ api-host-apigw }}."
            }
            ```

{% endlist %}

## Что дальше {#what-is-next}

* [Ознакомьтесь с концепциями {{ er-name }}](../concepts/eventrouter/bus.md)
