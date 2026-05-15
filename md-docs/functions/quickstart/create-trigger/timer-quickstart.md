# Создание таймера, который запускает функцию

Создайте [таймер](../../concepts/trigger/timer.md), который будет вызывать [функцию](../../concepts/function.md) Cloud Functions каждую минуту.

## Перед началом работы {#before-you-begin}

1. [Создайте функцию](../../operations/index.md#create-function), которую хотите вызывать по таймеру. Например, можно создать любую функцию из [списка](../create-function/index.md).
1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), от имени которого будет вызываться функция и назначьте ему роль `functions.functionInvoker`.

## Создайте таймер {#timer-create}

{% note info %}

Триггер начинает работать в течение 5 минут после создания.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать таймер.

    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.

    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:

        * Введите имя триггера — `timer`.
        * В поле **Тип** выберите `Таймер`.
        * В поле **Запускаемый ресурс** выберите `Функция`.

    1. В блоке **Настройки таймера** введите `* * ? * * *` или выберите `Каждую минуту`.

    1. В блоке **Настройки функции** выберите свою функцию и укажите:

        * [**Тег версии функции**](../../concepts/function.md#tag) — `$latest`.
        * [**Сервисный аккаунт**](../../../iam/concepts/users/service-accounts.md), который создали ранее.

    1. Нажмите кнопку **Создать триггер**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

- API {#api}

    Создать таймер можно с помощью метода API [create](../../triggers/api-ref/Trigger/create.md).

{% endlist %}

## Проверьте результат {#check-result}

Чтобы проверить, что таймер работает корректно, посмотрите логи функции. В них должно отображаться, что функция вызывается каждую минуту.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится функция.

    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.

    1. Нажмите на функцию, журнал выполнения которой хотите посмотреть.

    1. В открывшемся окне перейдите в раздел **Логи** и укажите период, за который хотите посмотреть логи. По умолчанию задан период 1 час.

- CLI {#cli}

    Чтобы посмотреть логи функции, выполните команду:

    ```bash
    yc serverless function logs <идентификатор_функции>
    ```

    Результат:

    ```text
    2023-03-03 12:44:12  INFO START RequestID: 5906fbf3-7ff5-4fe4-a0b2-b35c******** Version: d4efs25vm37e********
    2023-03-03 12:44:12  INFO END RequestID: 5906fbf3-7ff5-4fe4-a0b2-b35c********
    2023-03-03 12:44:12  INFO REPORT RequestID: 5906fbf3-7ff5-4fe4-a0b2-b35c******** Duration: 8.951 ms Billed Duration: 100 ms Memory Size: 128 MB Max Memory Used: 48 MB Queuing Duration: 0.066 ms Function Init Duration: 5.892 ms
    2023-03-03 12:45:12  INFO START RequestID: e806a5c4-e06a-4a6f-b468-386d******** Version: d4efs25vm37e********
    2023-03-03 12:45:12  INFO END RequestID: e806a5c4-e06a-4a6f-b468-386d********
    2023-03-03 12:45:12  INFO REPORT RequestID: e806a5c4-e06a-4a6f-b468-386d******** Duration: 10.266 ms Billed Duration: 100 ms Memory Size: 128 MB Max Memory Used: 48 MB Queuing Duration: 0.054 ms Function Init Duration: 7.023 ms
    ```

{% endlist %}

## Что дальше {#what-is-next}

* [Ознакомьтесь с концепциями](../../concepts/trigger/index.md).
* [Посмотрите, как создать другие триггеры](../../operations/index.md#trigger-create).