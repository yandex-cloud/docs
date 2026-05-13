# Создание таймера, который вызывает контейнер

Создайте [таймер](../concepts/trigger/timer.md), который будет вызывать [контейнер](../concepts/container.md) Serverless Containers каждую минуту.

## Перед началом работы {#before-you-begin}

1. [Создайте контейнер](../operations/index.md#create-container), который хотите вызывать по таймеру. [Примеры приложений и Dockerfile](container.md#examples).
1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md), от имени которого будет вызываться контейнер, и назначьте ему роль `serverless-containers.containerInvoker`.

## Создайте таймер {#timer-create}

{% note info %}

Триггер начинает работать в течение 5 минут после создания.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать таймер.

    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Serverless Containers**.

    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **Триггеры**.

    1. Нажмите кнопку **Создать триггер**.

    1. В блоке **Базовые параметры**:

        * Введите имя триггера — `timer`.
        * В поле **Тип** выберите `Таймер`.
        * В поле **Запускаемый ресурс** выберите `Контейнер`.

    1. В блоке **Настройки таймера** введите `* * ? * * *` или выберите `Каждую минуту`.

    1. В блоке **Настройки контейнера** выберите его и [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого он будет вызываться.

    1. Нажмите кнопку **Создать триггер**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать триггер, который вызывает контейнер каждую минуту, выполните команду:

    ```bash
    yc serverless trigger create timer \
      --name timer \
      --cron-expression '* * ? * * *' \
      --invoke-container-id <идентификатор_контейнера> \
      --invoke-container-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя таймера.
    * `--cron-expression` — расписание вызова контейнера в формате [cron-выражения](../concepts/trigger/timer.md#cron-expression).
    * `--invoke-container-id` — идентификатор контейнера.
    * `--invoke-container-service-account-id` — идентификатор сервисного аккаунта с правами на вызов контейнера.

    Результат:

    ```text
    id: a1sp9tj1jhar********
    folder_id: b1g4j6o69kqj********
    created_at: "2023-03-16T17:45:23.145213360Z"
    name: timer
    rule:
      timer:
        cron_expression: '* * ? * * *'
        invoke_container_with_retry:
          container_id: bbavvhra8ekc********
          service_account_id: aje1ki4ae68u********
    status: ACTIVE
    ```

- API {#api}

  Создать таймер можно с помощью метода API [create](../triggers/api-ref/Trigger/create.md).

{% endlist %}

## Проверьте результат {#check-result}

Чтобы проверить, что таймер работает корректно, посмотрите логи контейнера. В них должно отображаться, что контейнер вызывается каждую минуту.

1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится контейнер.
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Serverless Containers**.
1. Нажмите на контейнер, журнал вызовов которого хотите посмотреть.
1. В открывшемся окне перейдите в раздел **Логи** и укажите период, за который хотите их посмотреть. По умолчанию задан период 1 час.

## Что дальше {#what-is-next}

* [Ознакомьтесь с концепциями](../concepts/trigger/index.md).
* [Посмотрите, как создать другие триггеры](../operations/index.md#create-trigger).