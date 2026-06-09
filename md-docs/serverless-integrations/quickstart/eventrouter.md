# Начало работы с EventRouter

{% note info %}

EventRouter находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

С помощью этой инструкции вы, используя [шину](../concepts/eventrouter/bus.md) EventRouter, перенаправите сообщение из очереди [Message Queue](../../message-queue/index.md) в [рабочий процесс](../concepts/workflows/workflow.md) Workflows.

Сообщение, которое поступает в очередь, будет перенаправляться в рабочий процесс, если соответствует фильтру, заданному в правиле внутри шины. Рабочий процесс при этом будет автоматически запускаться. Перед отправкой в него сообщение будет преобразовываться по шаблону, заданному в том же правиле, что и фильтр.

## Перед началом работы {#before-you-begin}

Чтобы начать работать в Yandex Cloud:
1. Войдите в [консоль управления](https://console.yandex.cloud). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../../resource-manager/operations/folder/create.md).

## Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
    1. Перейдите в сервис **Identity and Access Management**.
    1. Нажмите кнопку **Создать сервисный аккаунт**.
    1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md): `sa-for-eventrouter`.
    1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роли `serverless.workflows.executor`, [ymq.reader](../../iam/roles-reference.md#ymq-reader) и [ymq.writer](../../iam/roles-reference.md#ymq-writer).
    1. Нажмите кнопку **Создать**. 

{% endlist %}

## Создайте очередь {#create-queue}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Откройте [консоль управления](https://console.yandex.cloud) и Перейдите в сервис **Message Queue**.
    1. Нажмите кнопку **Создать очередь**.
    1. Введите имя очереди: `sample-queue`.
    1. Выберите тип `Стандартная`. Не изменяйте другие настройки.
    1. Нажмите кнопку **Создать**.
    1. Откройте созданную очередь.
    1. На вкладке **Обзор** в блоке **Общая информация** скопируйте URL очереди, он понадобится позднее.

{% endlist %}

## Создайте рабочий процесс {#create-workflow}

{% note info %}

Workflows находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Откройте [консоль управления](https://console.yandex.cloud) и Перейдите в сервис **Serverless Integrations**.
    1. На панели слева выберите ![GraphNode](../../_assets/console-icons/graph-node.svg) **Workflows**.
    1. В правом верхнем углу нажмите кнопку **Создать рабочий процесс**.
    1. В поле **YaML-спецификация** добавьте следующую спецификацию:
        ```
        yawl: "0.1"
        start: noopstep
        steps:
          noopstep:
            noOp:
              output: |-
                \(.)
        ```
    1. Разверните блок **Дополнительные параметры**.
    1. В поле **Имя** введите имя рабочего процесса: `sample-workflow`.
    1. В поле **Сервисный аккаунт** выберите сервисный аккаунт `sa-for-eventrouter`.
    1. Нажмите кнопку **Создать**.

{% endlist %}

## Создайте шину {#create-bus}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Откройте [консоль управления](https://console.yandex.cloud) и Перейдите в сервис **Serverless Integrations**.
    1. На панели слева выберите ![ObjectAlignCenterVertical](../../_assets/console-icons/object-align-center-vertical.svg) **EventRouter**.
    1. В правом верхнем углу нажмите кнопку **Создать шину**.
    1. Введите имя шины: `sample-bus`.
    1. Нажмите кнопку **Создать**.

{% endlist %}

## Создайте коннектор {#create-connector}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Выберите шину `sample-bus`.
    1. Перейдите на вкладку **Коннекторы**.
    1. В правом верхнем углу нажмите кнопку **Создать коннектор**.
    1. В поле **Источник** выберите `Yandex Message Queue`.
    1. В поле **Очередь сообщений** укажите очередь `sample-queue`.
    1. В поле **Сервисный аккаунт** укажите `sa-for-eventrouter`.
    1. Нажмите кнопку **Создать**.

{% endlist %}

## Создайте правило {#create-rule}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Выберите шину `sample-bus`.
    1. Перейдите на вкладку **Правила**.
    1. В правом верхнем углу нажмите кнопку **Создать правило**.
    1. Разверните блок **Фильтр** и укажите следующий jq-шаблон для фильтрации сообщений:
        ```
        .httpMethod == "GET" and (.headers.Host | test("^d5dm"))
        ```
    1. В блоке **Приёмники** нажмите кнопку **Добавить**.
    1. В поле **Тип** выберите `Yandex Workflows`.
    1. В поле **Рабочий процесс** укажите `sample-workflow`.
    1. В поле **Сервисный аккаунт** укажите `sa-for-eventrouter`.
    1. Разверните блок **Шаблон** и укажите jq-шаблон для преобразования сообщений:
        ```
        {
           "message": "API gateway host is \(.headers.Host)."
        }
        ```
    1. Нажмите кнопку **Создать**.

{% endlist %}

## Отправьте сообщение в очередь {#send-message}

Убедитесь, что сообщения, которые соответствуют созданному правилу, преобразовываются и перенаправляются в рабочий процесс.

{% list tabs group=instructions %}

- AWS CLI {#cli}

    1. [Установите](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) AWS CLI.
    1. [Создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статические ключи доступа для сервисного аккаунта `sa-for-eventrouter`. Надежно сохраните идентификатор и секретный ключ. После того, как вы закроете окно, параметры секретного ключа станут недоступны.
    1. Настройте AWS CLI:

       1. Запустите интерактивную настройку профиля:
       
          ```bash
          aws configure
          ```
       
       1. Укажите полученный ранее идентификатор ключа сервисного аккаунта:
       
          ```bash
          AWS Access Key ID [****************ver_]: <идентификатор_ключа_сервисного_аккаунта>
          ```
       
       1. Укажите полученный ранее секретный ключ сервисного аккаунта:
       
          ```bash
          AWS Secret Access Key [****************w5lb]: <секретный_ключ_сервисного_аккаунта>
          ```
       
       1. Укажите имя региона по умолчанию `ru-central1`:
       
          ```bash
          Default region name [ru-central1]: ru-central1
          ```
       
       1. Укажите формат выходных данных по умолчанию `json`:
       
          ```bash
          Default output format [None]: json
          ```
       
       1. Чтобы посмотреть текущие настройки профиля, выполните команду:
       
          ```bash
          aws configure list
          ```
       
          Результат:
       
          ```text
                Name                    Value             Type    Location
                ----                    -----             ----    --------
             profile                <not set>             None    None
          access_key     ****************aBc1 shared-credentials-file
          secret_key     ****************DeF2 shared-credentials-file
              region              ru-central1      config-file    ~/.aws/config
          ```

    1. Отправьте первое сообщение в очередь `sample-queue`, используя сохраненный ранее URL очереди:

        ```bash
        aws sqs send-message \
          --message-body '{"httpMethod":"GET","headers":{"Host":"h6ds1lb3s0df********.k7******.apigw.yandexcloud.net"}}' \
          --endpoint https://message-queue.api.cloud.yandex.net/ \
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

        1. Откройте [консоль управления](https://console.yandex.cloud) и Перейдите в сервис **Serverless Integrations**.
        1. На панели слева выберите ![GraphNode](../../_assets/console-icons/graph-node.svg) **Workflows**.
        1. Перейдите на вкладку **Запуски**. На странице не должно быть выполненных запусков.

    1. Отправьте второе сообщение в очередь `sample-queue`, используя сохраненный ранее URL очереди:

        ```bash
        aws sqs send-message \
          --message-body '{"httpMethod":"GET","headers":{"Host":"d5dm1lba80md********.i9******.apigw.yandexcloud.net"}}' \
          --endpoint https://message-queue.api.cloud.yandex.net/ \
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

        1. Откройте [консоль управления](https://console.yandex.cloud) и Перейдите в сервис **Serverless Integrations**.
        1. На панели слева выберите ![GraphNode](../../_assets/console-icons/graph-node.svg) **Workflows**.
        1. Перейдите на вкладку **Запуски**. На странице должен отобразиться выполненный запуск.
        1. Выберите выполненный запуск.
        1. Убедитесь, что в блоке **Данные на входе** отображается преобразованное сообщение:
            ```
            {
               "message": "API gateway host is d5dm1lba80md********.i9******.apigw.yandexcloud.net."
            }
            ```

{% endlist %}

## Что дальше {#what-is-next}

* [Ознакомьтесь с концепциями EventRouter](../concepts/eventrouter/bus.md)