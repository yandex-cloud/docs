# Создание таймера, который запускает функцию

Создайте [таймер](../../concepts/trigger/timer.md), который будет вызывать [функцию](../../concepts/function.md) {{ sf-name }} каждую минуту.

## Перед началом работы {#before-you-begin}

1. [Создайте функцию](../../operations/index.md#create-function), которую хотите вызывать по таймеру. Например, можно создать любую функцию из [списка](../../quickstart/create-function/index.md).
1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), от имени которого будет вызываться функция и назначьте ему роль `{{ roles-functions-invoker }}`.

## Создайте таймер {#timer-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать таймер.

    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. На панели слева выберите ![image](../../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя триггера — `timer`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_timer }}** введите `* * ? * * *` или выберите `{{ ui-key.yacloud.common.button_cron-1min }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите свою функцию и укажите:

        * [**{{ ui-key.yacloud.serverless-functions.triggers.form.field_function-tag }}**](../../concepts/function.md#tag) — `$latest`.
        * [**{{ ui-key.yacloud.serverless-functions.triggers.form.field_service-account }}**](../../../iam/concepts/users/service-accounts.md), который создали ранее.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать таймер, который вызывает функцию каждую минуту, выполните команду:

    ```bash
    yc serverless trigger create timer \
      --name timer \
      --cron-expression '* * ? * * *' \
      --invoke-function-id <идентификатор_функции> \
      --invoke-function-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя таймера.
    * `--cron-expression` — расписание вызова функции в формате [cron-выражения](../../concepts/trigger/timer.md#cron-expression).
    * `--invoke-function-id` — идентификатор функции.
    * `--invoke-function-service-account-id` — идентификатор сервисного аккаунта.

    Результат:

    ```text
    id: a1s2aanidtep********
    folder_id: b1gtmgn9gbvm********
    created_at: "2023-03-03T12:18:15.707328472Z"
    name: timer
    rule:
      timer:
        cron_expression: '* * ? * * *'
        invoke_function_with_retry:
          function_id: d4eaic3se926********
          function_tag: $latest
          service_account_id: ajek1us5r79c********
    status: ACTIVE
    ```

- API

    Создать таймер можно с помощью метода API [create](../../triggers/api-ref/Trigger/create.md).

{% endlist %}

## Проверьте результат {#check-result}

Чтобы проверить, что таймер работает корректно, посмотрите логи функции. В них должно отображаться, что функция вызывается каждую минуту.

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.

    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. Нажмите на функцию, журнал выполнения которой хотите посмотреть.

    1. В открывшемся окне перейдите в раздел **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** и укажите период, за который хотите посмотреть логи. По умолчанию задан период 1 час.

- CLI

    Чтобы посмотреть логи функции, выполните команду:

    ```bash
    yc serverless function logs <идентификатор_функции>
    ```

    Результат:

    ```text
    2023-03-03 12:44:12  INFO START RequestID: 5906fbf3-7ff5-4fe4-a0b2-b35ca126ac9d Version: d4efs25vm37e********
    2023-03-03 12:44:12  INFO END RequestID: 5906fbf3-7ff5-4fe4-a0b2-b35ca126ac9d
    2023-03-03 12:44:12  INFO REPORT RequestID: 5906fbf3-7ff5-4fe4-a0b2-b35ca126ac9d Duration: 8.951 ms Billed Duration: 100 ms Memory Size: 128 MB Max Memory Used: 48 MB Queuing Duration: 0.066 ms Function Init Duration: 5.892 ms
    2023-03-03 12:45:12  INFO START RequestID: e806a5c4-e06a-4a6f-b468-386d91189bc5 Version: d4efs25vm37e********
    2023-03-03 12:45:12  INFO END RequestID: e806a5c4-e06a-4a6f-b468-386d91189bc5
    2023-03-03 12:45:12  INFO REPORT RequestID: e806a5c4-e06a-4a6f-b468-386d91189bc5 Duration: 10.266 ms Billed Duration: 100 ms Memory Size: 128 MB Max Memory Used: 48 MB Queuing Duration: 0.054 ms Function Init Duration: 7.023 ms
    ```

{% endlist %}

## Что дальше {#what-is-next}

* [Ознакомьтесь с концепциями](../../concepts/trigger/index.md).
* [Посмотрите, как создать другие триггеры](../../operations/index.md#trigger-create).
