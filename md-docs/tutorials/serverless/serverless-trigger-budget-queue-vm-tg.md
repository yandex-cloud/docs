# Создание триггеров, которые вызывают функции Cloud Functions для остановки ВМ и отправки уведомлений в Telegram

# Создание триггеров, которые вызывают функции Cloud Functions для остановки ВМ и отправки уведомлений в Telegram


В этом руководстве вы создадите serverless-инфраструктуру, которая при превышении пороговых значений [бюджета](../../billing/concepts/budget.md) будет останавливать запущенные виртуальные машины и отправлять пользователю уведомления в Telegram.

[Триггер для бюджетов](../../functions/concepts/trigger/budget-trigger.md) будет вызывать [функцию](../../functions/concepts/function.md) Cloud Functions, а функция — останавливать [виртуальные машины](../../compute/concepts/vm.md#project) Compute Cloud и отправлять сообщение в [очередь](../../message-queue/concepts/queue.md) Yandex Message Queue. 

[Триггер для Message Queue](../../functions/concepts/trigger/ymq-trigger.md) будет передавать поступившие в очередь сообщения во вторую функцию Cloud Functions, которая будет отправлять уведомления в Telegram с помощью специально созданного бота.

Чтобы развернуть проект:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бюджет](#create-budget).
1. [Создайте очередь Message Queue](#create-queue).
1. [Создайте функцию Cloud Functions, которую будет вызывать триггер для бюджетов](#create-budget-function).
1. [Создайте триггер для бюджетов](#create-budget-trigger).
1. [Зарегистрируйте Telegram-бота](#register-bot).
1. [Создайте функцию Cloud Functions, которую будет вызывать триггер для Message Queue](#create-queue-function).
1. [Создайте триггер для Message Queue](#create-queue-trigger).
1. [Создайте виртуальные машины Compute Cloud](#create-vms).
1. [Убедитесь, что по триггеру останавливаются ВМ и отправляются уведомления в Telegram](#test).

Создавайте все указанные ресурсы Yandex Cloud в одном [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов входят:
* Плата за вычислительные ресурсы ВМ ([тарифы Compute Cloud](../../compute/pricing.md#prices-instance-resources)).
* Плата за [диски](../../compute/concepts/disk.md) ВМ ([тарифы Compute Cloud](../../compute/pricing.md#prices-storage)).
* Плата за использование динамического [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).
* Плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик ([тарифы Cloud Functions](../../functions/pricing.md)).
* Плата за количество запросов к очередям и исходящий трафик ([тарифы Message Queue](../../message-queue/pricing.md)).
* Плата за запись и хранение данных в [лог-группе](../../logging/concepts/log-group.md) ([тарифы Yandex Cloud Logging](../../logging/pricing.md)), если вы используете сервис [Cloud Logging](../../logging/index.md).


### Скачайте проект {#download}

Склонируйте репозиторий c проектом:

```bash
git clone https://github.com/yandex-cloud-examples/yc-telegram-bot-with-trigger-for-budget
```


### Создайте сервисный аккаунт и статический ключ доступа {#create-sa}

1. Создайте сервисный аккаунт:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите ваш каталог.
      1. Перейдите в сервис **Identity and Access Management**.
      1. Нажмите кнопку **Создать сервисный аккаунт**.
      1. В поле **Имя** укажите имя `service-account-for-budget`.
      1. В поле **Роли в каталоге** нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `editor`.
      1. Нажмите кнопку **Создать**.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      1. Создайте сервисный аккаунт `service-account-for-budget`:

          ```bash
          yc iam service-account create \
            --name service-account-for-budget
          ```

          Результат:

          ```text
          done (1s)
          id: ajed1o6dd581********
          folder_id: b1g9d2k0itu4********
          created_at: "2024-02-23T18:32:38.365175925Z"
          name: service-account-for-budget
          ```

          Сохраните идентификатор (`id`) созданного сервисного аккаунта: он пригодится на следующем шаге.

          Подробнее о команде `yc iam service-account create` читайте в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

      1. Назначьте сервисному аккаунту роль `editor` на ваш каталог:

          ```bash
          yc resource-manager folder add-access-binding <имя_каталога> \
            --role editor \
            --subject serviceAccount:<идентификатор_сервисного_аккаунта>
          ```

          Где:

          * `<имя_каталога>` — имя вашего каталога в Yandex Cloud.
          * `<идентификатор_сервисного_аккаунта>` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта, сохраненный ранее.

          Результат:

          ```text
          done (2s)
          effective_deltas:
            - action: ADD
              access_binding:
                role_id: editor
                subject:
                  id: ajed1o6dd581********
                  type: serviceAccount
          ```

          Подробнее о команде `yc resource-manager folder add-access-binding` читайте в [справочнике CLI](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

    - API {#api}

      Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

      Чтобы назначить сервисному аккаунту роль на каталог, воспользуйтесь методом REST API [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md).

    {% endlist %}

1. Создайте статический ключ доступа:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите ваш каталог.
      1. Перейдите в сервис **Identity and Access Management**.
      1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
      1. В открывшемся списке выберите сервисный аккаунт `service-account-for-budget`.
      1. На верхней панели нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Создать новый ключ** и выберите **Создать статический ключ доступа**.
      1. При необходимости задайте описание ключа и нажмите кнопку **Создать**.
      1. Сохраните идентификатор и секретный ключ.

          {% note alert %}

          После закрытия диалога значение ключа будет недоступно.

          {% endnote %}

    - CLI {#cli}

      Выполните команду:

      ```bash
      yc iam access-key create \
        --service-account-name service-account-for-budget
      ```

      Результат:

      ```text
      access_key:
        id: aje75gg0rp8k********
        service_account_id: ajed1o6dd581********
        created_at: "2024-02-23T18:36:41.061060561Z"
        key_id: YCAJEK_r3Z_EvxRAR********
      secret: YCPQhHFMx6rnWXQC9ID425gk3V9YnUc********
      ```

      Сохраните идентификатор `key_id` и секретный ключ `secret`. Получить значение этого ключа снова будет невозможно.

      Подробнее о команде `yc iam access-key create` читайте в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/access-key/create.md).

    - API {#api}

      Чтобы создать ключ доступа, воспользуйтесь методом REST API [create](../../iam/awscompatibility/api-ref/AccessKey/create.md) для ресурса [AccessKey](../../iam/awscompatibility/api-ref/AccessKey/index.md) или вызовом gRPC API [AccessKeyService/Create](../../iam/awscompatibility/api-ref/grpc/AccessKey/create.md).

    {% endlist %}


### Создайте облачную сеть и подсеть {#create-network}

{% list tabs group=instructions %}

- Консоль управления {#console} 

  1. В [консоли управления](https://console.yandex.cloud) выберите ваш каталог.
  1. Перейдите в сервис **Virtual Private Cloud**.
  1. Справа сверху нажмите кнопку **Создать сеть**.
  1. В поле **Имя** укажите `my-sample-network`.
  1. В поле **Дополнительно** отключите опцию **Создать подсети**.
  1. Нажмите кнопку **Создать сеть**.
  1. На панели слева выберите ![subnets](../../_assets/vpc/subnets.svg) **Подсети**.
  1. Справа сверху нажмите кнопку **Создать**.
  1. В поле **Имя** укажите `sample-subnet-ru-central1-b`.
  1. В поле **Зона доступности** выберите зону доступности `ru-central1-b`.
  1. В поле **Сеть** выберите облачную сеть `my-sample-network`.
  1. В поле **CIDR** укажите `192.168.1.0/24`.
  1. Нажмите кнопку **Создать подсеть**.

- CLI {#cli}

  1. Создайте сеть `my-sample-network`:

      ```bash
      yc vpc network create my-sample-network
      ```

      Результат:

      ```text
      id: enp2gjcvrd59********
      folder_id: b1g9d2k0itu4********
      created_at: "2024-02-23T18:39:17Z"
      name: my-sample-network
      default_security_group_id: enp9uobl2c33********
      ```

      Подробнее о команде `yc vpc network create` читайте в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Создайте подсеть `sample-subnet-ru-central1-b` в зоне доступности `ru-central1-b`:

      ```bash
      yc vpc subnet create sample-subnet-ru-central1-b \
        --zone ru-central1-b \
        --network-name my-sample-network \
        --range 192.168.1.0/24
      ```

      Результат:

      ```text
      id: e2l1ejkvq4jv********
      folder_id: b1g9d2k0itu4********
      created_at: "2024-02-23T18:40:26Z"
      name: sample-subnet-ru-ru-central1-b
      network_id: enp2gjcvrd59********
      zone_id: ru-central1-b
      v4_cidr_blocks:
        - 192.168.1.0/24
      ```

      Подробнее о команде `yc vpc subnet create` читайте в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. Чтобы создать сеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md).

  1. Чтобы создать подсеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}


## Создайте бюджет {#create-budget}

Чтобы создать бюджет, у пользователя должна быть [роль](../../iam/concepts/access-control/roles.md) `editor`. Чтобы получать оповещения, достаточно роли `viewer`.

{% list tabs group=instructions %}

- Интерфейс Yandex Cloud Billing {#billing}

  1. Перейдите в сервис [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts).
  1. Выберите [платежный аккаунт](../../billing/concepts/billing-account.md).
  1. В секции **Общие сведения**, в поле **Идентификатор**, скопируйте идентификатор платежного аккаунта. Он пригодится при создании [триггера](../../functions/concepts/trigger/index.md) для бюджетов.
  1. Перейдите на вкладку **Бюджеты** и нажмите кнопку **Создать бюджет**.
  1. В блоке **Общая информация** укажите:
     * **Имя** — `vm-budget`.
     * **Тип** — `К оплате`.
     * **Сумма** — сумму расходов на потребление, например `10 ₽`.
     * **Период расчета** — `Месячный`.
     * **Дата окончания** — дату окончания действия бюджета.

       Дата окончания устанавливает, когда бюджет перестанет считать потребление и отправлять уведомления. Дата окончания — последнее число месяца. Не может быть позже пяти лет от текущей даты.
     * **Уведомить** — выберите себя.
  1. В блоке **Область действия** выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором ведете работу, и сервис **Compute Cloud**.
  1. В блоке **Пороги** укажите пороговые значения в процентах, при достижении которых:
     * Указанным пользователям будут приходить уведомления.
     * Будет срабатывать триггер для бюджетов.

     Например, можно указать два порога — `50%` и `100%`.
  1. Нажмите кнопку **Создать**.
  1. В открывшемся окне появился новый бюджет `vm-budget`. В поле **Идентификатор** скопируйте идентификатор созданного бюджета. Он пригодится позднее при создании триггера.

- API {#api}

  Чтобы создать бюджет, воспользуйтесь методом [create](../../billing/api-ref/Budget/create.md) для ресурса [Budget](../../billing/api-ref/Budget/index.md) или вызовом gRPC API [BudgetService/Create](../../billing/api-ref/grpc/Budget/create.md).

{% endlist %}


## Создайте очередь Message Queue {#create-queue}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) выберите ваш каталог.
  1. Перейдите в сервис **Message Queue**.
  1. Нажмите кнопку **Создать очередь**.
  1. В блоке **Базовые параметры** укажите:
      * **Имя** — `budget-queue`.  
      * **Тип** — `Стандартная`.

      Остальные параметры оставьте без изменений.

  1. Нажмите кнопку **Создать**.
  1. Нажмите на имя созданной очереди `budget-queue` и в открывшемся окне скопируйте значения полей:
      * **URL** — URL очереди.
      * **ARN** — идентификатор очереди.

      Сохраните эти значения: они пригодятся на следующих шагах.

- AWS CLI {#cli}

  1. [Установите и настройте](../../message-queue/operations/configuring-aws-cli.md) AWS CLI. При настройке используйте созданный ранее статический ключ доступа.

  1. Создайте очередь:

      ```bash
      aws sqs create-queue \
        --queue-name budget-queue \
        --endpoint https://message-queue.api.cloud.yandex.net/
      ```

      Результат:

      ```json
      {
          "QueueUrl": "https://message-queue.api.cloud.yandex.net/b1glti4eser3********/dj600000001c********/budget-queue"
      }
      ```

      Сохраните значение URL очереди `QueueUrl`, оно пригодится на следующих шагах.

  1. Получите идентификатор очереди, указав сохраненный ранее URL в параметре `--queue-url`:

      ```bash
      aws sqs get-queue-attributes \
        --queue-url <URL_очереди> \
        --attribute-names QueueArn \
        --endpoint https://message-queue.api.cloud.yandex.net/
      ```

      Результат:

      ```json
      {
          "Attributes": {
              "QueueArn": "yrn:yc:ymq:ru-central1:b1g9d2k0itu4********:budget-queue"
          }
      }
      ```

      Сохраните идентификатор очереди `QueueArn`, он пригодится на следующих шагах.

{% endlist %}


## Создайте функцию Cloud Functions, которую будет вызывать триггер для бюджетов {#create-budget-function}

1. Подготовьте ZIP-архив с кодом функции.

    Перейдите в директорию `yc-telegram-bot-with-trigger-for-budget/steps/4-create-budget-trigger-handler` и добавьте файлы в ZIP-архив `src_bgt.zip`:

    ```bash
    zip src_bgt.zip budget_trigger_handler.go go.mod
    ```

1. Создайте функцию:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите ваш каталог.
      1. Перейдите в сервис **Cloud Functions**.
      1. Создайте функцию:
          1. Нажмите кнопку **Создать функцию**.
          1. Введите имя функции `budget-trigger-handler`.
          1. Нажмите кнопку **Создать**.

      1. Создайте версию функции:
          1. Выберите среду выполнения `golang119`, выключите опцию **Добавить файлы с примерами кода** и нажмите кнопку **Продолжить**.
          1. Укажите способ загрузки **ZIP-архив** и прикрепите архив `src_bgt.zip`, который создали на предыдущем шаге.
          1. Укажите точку входа `budget_trigger_handler.Handler`.
          1. В блоке **Параметры** укажите:
              * **Таймаут** — `5`;
              * **Память** — `512 МБ`;
              * **Сервисный аккаунт** — `service-account-for-budget`;
              * **Переменные окружения**:
                  * `FOLDER_ID` — идентификатор каталога, в котором вы хотите останавливать виртуальные машины.
                  * `TAG` — `target-for-stop`.
                  * `AWS_ACCESS_KEY_ID` — значение идентификатора статического ключа доступа, сохраненное ранее.
                  * `AWS_SECRET_ACCESS_KEY` — значение секретного ключа статического ключа доступа, сохраненное ранее.
                  * `BUDGET_QUEUE_URL` — значение URL очереди `budget-queue`, сохраненное ранее.

          1. Нажмите кнопку **Сохранить изменения**.

    - CLI {#cli}

      1. Создайте функцию `budget-trigger-handler`:

          ```bash
          yc serverless function create \
            --name budget-trigger-handler
          ```

          Результат:

          ```
          id: d4e4aigfdm0b********
          folder_id: b1g9d2k0itu4********
          created_at: "2024-02-23T20:15:06.456Z"
          name: budget-trigger-handler
          http_invoke_url: https://functions.yandexcloud.net/d4e4aigfdm0b********
          status: ACTIVE
          ```

          Подробнее о команде `yc serverless function create` читайте в [справочнике CLI](../../cli/cli-ref/serverless/cli-ref/function/create.md).

      1. Создайте версию функции `budget-trigger-handler`:

          ```bash
          yc serverless function version create \
            --function-name budget-trigger-handler \
            --memory=512m \
            --execution-timeout=5s \
            --runtime=golang119 \
            --entrypoint=budget_trigger_handler.Handler \
            --service-account-id=<идентификатор_сервисного_аккаунта> \
            --environment FOLDER_ID=<идентификатор_каталога> \
            --environment TAG=target-for-stop \
            --environment AWS_ACCESS_KEY_ID=<идентификатор_статического_ключа> \
            --environment AWS_SECRET_ACCESS_KEY=<значение_секретного_ключа> \
            --environment BUDGET_QUEUE_URL=<URL_очереди> \
            --source-path="./src_bgt.zip"
          ```

          Где:

          * `--service-account-id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта `service-account-for-budget`, сохраненный ранее. Сервисный аккаунт будет использоваться для вызова функции.
          * `--environment` — переменные окружения:
              * `FOLDER_ID` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, в котором вы хотите останавливать виртуальные машины.
              * `AWS_ACCESS_KEY_ID` — значение идентификатора статического ключа доступа, сохраненное ранее.
              * `AWS_SECRET_ACCESS_KEY` — значение секретного ключа статического ключа доступа, сохраненное ранее.
              * `BUDGET_QUEUE_URL` — значение URL очереди `budget-queue`, сохраненное ранее.

          * `--source-path` — путь к ZIP-архиву `src_bgt.zip`.

          Результат:

          ```text
          done (2m32s)
          id: d4em5gaeev2b********
          function_id: d4e4aigfdm0b********
          created_at: "2024-02-23T20:31:18.458Z"
          runtime: golang119
          entrypoint: budget_trigger_handler.Handler
          resources:
            memory: "536870912"
          execution_timeout: 5s
          service_account_id: ajed1o6dd581********
          image_size: "23977984"
          status: ACTIVE
          tags:
            - $latest
          environment:
            AWS_ACCESS_KEY_ID: YCAJEK_r3Z_EvxRAR********
            AWS_SECRET_ACCESS_KEY: YCPQhHFMx6rnWXQC9ID425gk3V9YnUc0********
            BUDGET_QUEUE_URL: https://message-queue.api.cloud.yandex.net/b1glti4eser3********/dj600000001c********/budget-queue
            FOLDER_ID: b1g9d2k0itu4********
            TAG: target-for-stop
          log_options:
            folder_id: b1g9d2k0itu4********
          ```

          Подробнее о команде `yc serverless function version create` читайте в [справочнике CLI](../../cli/cli-ref/serverless/cli-ref/function/version/create.md).

    - API {#api}

      Чтобы создать функцию, воспользуйтесь методом [create](../../functions/functions/api-ref/Function/create.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Create](../../functions/functions/api-ref/grpc/Function/create.md).

      Чтобы создать версию функцию, воспользуйтесь методом [createVersion](../../functions/functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/Function/createVersion.md).

    {% endlist %}


## Создайте триггер для бюджетов {#create-budget-trigger}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите ваш каталог.
  1. Перейдите в сервис **Cloud Functions**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **Триггеры**.
  1. Нажмите кнопку **Создать триггер**.
  1. В блоке **Базовые параметры**:
      * В поле **Имя** укажите имя триггера `trigger-for-budget-from-yc`.
      * В поле **Тип** выберите `Бюджет`.
      * В поле **Запускаемый ресурс** выберите `Функция`.

  1. В блоке **Настройки бюджета** выберите ваш платежный аккаунт и бюджет `vm-budget`, который создали ранее.
  1. В блоке **Настройки функции** выберите функцию `budget-trigger-handler` и укажите сервисный аккаунт `service-account-for-budget`. От его имени будет вызываться функция.

  1. Нажмите кнопку **Создать триггер**.

- CLI {#cli}

  Чтобы создать триггер для бюджетов, который вызывает функцию `budget-trigger-handler`, выполните команду:

  ```bash
  yc serverless trigger create billing-budget \
    --name trigger-for-budget-from-yc \
    --invoke-function-name budget-trigger-handler \
    --invoke-function-service-account-id <идентификатор_сервисного_аккаунта>  \
    --billing-account-id <идентификатор_платежного_аккаунта>  \
    --budget-id <идентификатор_бюджета>
  ```

  Где:

  * `--invoke-function-service-account-id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта `service-account-for-budget`, сохраненный ранее. Сервисный аккаунт будет использоваться для вызова функции.
  * `--billing-account-id` — идентификатор [платежного аккаунта](../../billing/concepts/billing-account.md), сохраненный ранее при создании бюджета.
  * `--budget-id` — идентификатор бюджета `vm-budget`, сохраненный ранее.

  Результат:

  ```text
  id: a1sjrukc64hs********
  folder_id: b1g9d2k0itu4********
  created_at: "2024-02-23T21:20:03.308963151Z"
  name: trigger-for-budget-from-yc
  rule:
    billing_budget:
      billing_account_id: dn276oa9slgm********
      budget_id: dn2jr6qt0q9k********
      invoke_function:
        function_id: d4e4aigfdm0b********
        function_tag: $latest
        service_account_id: ajed1o6dd581********
  status: ACTIVE
  ```

  Подробнее о команде `yc serverless trigger create billing-budget` читайте в [справочнике CLI](../../cli/cli-ref/serverless/cli-ref/trigger/create/billing-budget.md).

- API {#api}

  Чтобы создать триггер для бюджетов, воспользуйтесь методом [create](../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../functions/triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}


## Зарегистрируйте Telegram-бота {#register-bot}

1. Зарегистрируйте бота в Telegram и получите токен:

    1. Для регистрации нового бота запустите в Telegram бота [BotFather](https://t.me/BotFather) и отправьте команду:

        ```
        /newbot
        ```

        Результат:

        ```text
        Alright, a new bot. How are we going to call it? Please choose a name for your bot.
        ```

    1. В следующем сообщении укажите имя создаваемого бота, например `YC VM budget informer`. Это имя увидят пользователи при общении с ботом.

        Результат:

        ```text
        Good. Now let's choose a username for your bot. It must end in `bot`. Like this, for example: TetrisBot or tetris_bot.
        ```

    1. Укажите имя пользователя создаваемого бота, например `YCVMBudgetInformerBot`. По имени пользователя можно будет найти бота в Telegram. Имя пользователя должно оканчиваться на `...Bot` или `..._bot`. В результате вы получите токен для HTTP API.

        Результат:

        ```text
        Done! Congratulations on your new bot. You will find it at t.me/YCVMBudgetInformerBot. You can now add a description, about section and profile picture for your bot, see /help for a list of commands. By the way, when you've finished creating your cool bot, ping our Bot Support if you want a better username for it. Just make sure the bot is fully operational before you do this.

        Use this token to access the HTTP API:
        715063****:AAGuj****-0VrIm7j9i****************
        Keep your token secure and store it safely, it can be used by anyone to control your bot.

        For a description of the Bot API, see this page: https://core.telegram.org/bots/api
        ```

1. Получите идентификатор `ChatID` пользователя, которому бот будет направлять уведомления:

    1. Сохраните полученный на предыдущем шаге API-токен в переменную окружения `TELEGRAM_BOT_API_TOKEN`:

        ```bash
        export TELEGRAM_BOT_API_TOKEN=<Telegram_API-токен>
        ```

    1. Перейдите в директорию `yc-telegram-bot-with-trigger-for-budget/steps/6-register-telegram-bot` и выполните команду:

        ```bash
        go run .
        ```
        
        При необходимости предварительно установите пакеты `Go` и `telegram_bot`.
        
        Команда запустит Telegram-бота, который на любое сообщение будет возвращать идентификатор `ChatID` текущего пользователя.

    1. В Telegram найдите созданного вами бота по имени пользователя (например, `YCVMBudgetInformerBot`) и отправьте ему любое сообщение.

        Результат:

        ```text
        59529*****
        ```
    
        Сохраните полученный идентификатор `ChatID`. Он пригодится вам позднее.

    1. Вернитесь в терминал и завершите работу бота с помощью сочетания клавиш **Ctrl** + **C**.

## Создайте функцию Cloud Functions, которую будет вызывать триггер для Message Queue {#create-queue-function}

1. Подготовьте ZIP-архив с кодом функции.

    Перейдите в директорию `yc-telegram-bot-with-trigger-for-budget/steps/7-create-budget-queue-handler` и добавьте файлы в ZIP-архив `src_queue.zip`:

    ```bash
    zip src_queue.zip budget_queue_handler.go utils.go go.mod
    ```

1. Создайте функцию:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите ваш каталог.
      1. Перейдите в сервис **Cloud Functions**.
      1. Создайте функцию:
          1. Нажмите кнопку **Создать функцию**.
          1. Введите имя функции `budget-queue-handler`.
          1. Нажмите кнопку **Создать**.

      1. Создайте версию функции:
          1. Выберите среду выполнения `golang119`, выключите опцию **Добавить файлы с примерами кода** и нажмите кнопку **Продолжить**.
          1. Укажите способ загрузки **ZIP-архив** и прикрепите архив `src_queue.zip`, который создали на предыдущем шаге.
          1. Укажите точку входа `budget_queue_handler.HandleBudgetQueueMessage`.
          1. В блоке **Параметры** укажите:
              * **Таймаут** — `5`;
              * **Память** — `512 МБ`;
              * **Сервисный аккаунт** — `service-account-for-budget`;
              * **Переменные окружения**:
                  * `TELEGRAM_BOT_API_TOKEN` — API-токен Telegram-бота, сохраненный ранее.
                  * `TELEGRAM_BOT_CHAT_ID` — идентификатор `ChatID` пользователя Telegram, сохраненный ранее.

          1. Нажмите кнопку **Сохранить изменения**.

    - CLI {#cli}

      1. Создайте функцию `budget-queue-handler`:

          ```bash
          yc serverless function create \
            --name budget-queue-handler
          ```

          Результат:

          ```
          id: d4e6r2g9trt5********
          folder_id: b1g9d2k0itu4********
          created_at: "2024-02-24T07:36:04.092Z"
          name: budget-queue-handler
          http_invoke_url: https://functions.yandexcloud.net/d4e6r2g9trt5********
          status: ACTIVE
          ```

      1. Создайте версию функции `budget-queue-handler`:

          ```bash
          yc serverless function version create \
            --function-name budget-queue-handler \
            --memory 512m \
            --execution-timeout 5s \
            --runtime golang119 \
            --entrypoint budget_queue_handler.HandleBudgetQueueMessage \
            --service-account-id <идентификатор_сервисного_аккаунта> \
            --environment TELEGRAM_BOT_API_TOKEN=<API-токен_Telegram-бота> \
            --environment TELEGRAM_BOT_CHAT_ID=<ChatID_пользователя_Telegram> \
            --source-path="./src_queue.zip"
          ```

          Где:

          * `--service-account-id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта `service-account-for-budget`, сохраненный ранее. Сервисный аккаунт будет использоваться для вызова функции.
          * `--environment` — переменные окружения:

              * `TELEGRAM_BOT_API_TOKEN` — API-токен Telegram-бота, сохраненный ранее.
              * `TELEGRAM_BOT_CHAT_ID` — идентификатор `ChatID` пользователя Telegram, сохраненный ранее.

          * `--source-path` — путь к ZIP-архиву `src_queue.zip`.

          Результат:

          ```text
          done (29s)
          id: d4e41l4gj7rk********
          function_id: d4e6r2g9trt5********
          created_at: "2024-02-24T07:43:32.464Z"
          runtime: golang119
          entrypoint: budget_queue_handler.HandleBudgetQueueMessage
          resources:
            memory: "536870912"
          execution_timeout: 5s
          service_account_id: ajed1o6dd581********
          image_size: "5464064"
          status: ACTIVE
          tags:
            - $latest
          environment:
            TELEGRAM_BOT_API_TOKEN: 7150638333:AAGujjyua-0VrIm7j9iG3mOxmz1********
            TELEGRAM_BOT_CHAT_ID: "59529*****"
          log_options:
            folder_id: b1g9d2k0itu4********
          ```

    - API {#api}

      Чтобы создать функцию, воспользуйтесь методом [create](../../functions/functions/api-ref/Function/create.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Create](../../functions/functions/api-ref/grpc/Function/create.md).

      Чтобы создать версию функцию, воспользуйтесь методом [createVersion](../../functions/functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/Function/createVersion.md).

    {% endlist %}


## Создайте триггер для Message Queue {#create-queue-trigger}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите ваш каталог.
  1. Перейдите в сервис **Cloud Functions**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **Триггеры**.
  1. Нажмите кнопку **Создать триггер**.
  1. В блоке **Базовые параметры**:
      * В поле **Имя** укажите имя триггера `budget-queue-trigger`.
      * В поле **Тип** выберите `Message Queue`.
      * В поле **Запускаемый ресурс** выберите `Функция`.

  1. В блоке **Настройки сообщений Message Queue** выберите созданные ранее ресурсы:
      * В поле **Очередь сообщений** — `budget-queue`.
      * В поле **Сервисный аккаунт** — `service-account-for-budget`.

  1. В блоке **Настройки функции** выберите функцию `budget-queue-handler` и укажите сервисный аккаунт `service-account-for-budget`. От его имени будет вызываться функция.

  1. Нажмите кнопку **Создать триггер**.

- CLI {#cli}

  Чтобы создать триггер для Message Queue, который вызывает функцию `budget-queue-handler`, выполните команду:

  ```bash
  yc serverless trigger create message-queue \
    --name budget-queue-trigger \
    --queue <идентификатор_очереди> \
    --queue-service-account-id <идентификатор_сервисного_аккаунта> \
    --invoke-function-name budget-queue-handler \
    --invoke-function-service-account-id <идентификатор_сервисного_аккаунта> \
    --batch-size 1 \
    --batch-cutoff 10s
  ```

  Где:

  * `--queue` — идентификатор очереди `budget-queue`, сохраненный при ее создании.
  * `--queue-service-account-id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта `service-account-for-budget`, сохраненный ранее. Сервисный аккаунт будет использоваться для чтения сообщений из очереди.
  * `--invoke-function-service-account-id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта `service-account-for-budget`, сохраненный ранее. Сервисный аккаунт будет использоваться для вызова функции.

  Результат:

  ```text
  id: a1sqq6341kvh********
  folder_id: b1g9d2k0itu4********
  created_at: "2024-02-24T08:35:39.296084612Z"
  name: budget-queue-trigger
  rule:
    message_queue:
      queue_id: yrn:yc:ymq:ru-central1:b1g9d2k0itu4********:budget-queue
      service_account_id: ajed1o6dd581********
      batch_settings:
        size: "1"
        cutoff: 10s
      invoke_function:
        function_id: d4e6r2g9trt5********
        function_tag: $latest
        service_account_id: ajed1o6dd581********
  status: ACTIVE
  ```

  Подробнее о команде `yc serverless trigger create message-queue` читайте в [справочнике CLI](../../cli/cli-ref/serverless/cli-ref/trigger/create/message-queue.md).

- API {#api}

  Чтобы создать триггер для Message Queue, воспользуйтесь методом [create](../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../functions/triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}


## Создайте виртуальные машины Compute Cloud {#create-vms}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **Виртуальные машины**.
  1. Нажмите кнопку **Создать виртуальную машину**.
  1. В блоке **Образ загрузочного диска** выберите [Ubuntu 22.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-22-04-lts).
  1. В блоке **Расположение** выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-b`.
  1. В блоке **Сетевые настройки**: 

      * В поле **Подсеть** выберите созданную ранее подсеть `sample-subnet-ru-central1-b`.
      * В поле **Публичный IP-адрес** выберите `Автоматически`.

  1. В блоке **Доступ** выберите **SSH-ключ** и укажите данные для доступа к ВМ:

      * В поле **Логин** введите имя пользователя, например, `yc-user`.
      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.

  1. В блоке **Общая информация**:

      * Укажите имя ВМ: `target-instance-1`.
      * В поле **Метки** нажмите кнопку **Добавить метку** и введите `target-for-stop:true`. Нажмите **Enter**, чтобы сохранить метку.

  1. Нажмите кнопку **Создать ВМ**.

- CLI {#cli}

  Создайте виртуальную машину:

  ```bash
  yc compute instance create \
    --name target-instance-1 \
    --labels target-for-stop=true \
    --zone ru-central1-b \
    --network-interface subnet-name=sample-subnet-ru-central1-b,nat-ip-version=ipv4 \
    --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
    --ssh-key ~/.ssh/<имя_ключа>.pub
  ```

  Где `--ssh-key` — путь к публичному SSH-ключу. Для этого ключа на виртуальной машине будет автоматически создан пользователь `yc-user`.

  Результат:

  ```
  done (39s)
  id: epdbhj4gssbp********
  folder_id: b1g9d2k0itu4********
  created_at: "2024-02-24T09:29:16Z"
  name: target-instance-1
  labels:
    target-for-stop: "true"
  zone_id: ru-central1-b
  platform_id: standard-v2
  resources:
    memory: "2147483648"
    cores: "2"
    core_fraction: "100"
  status: RUNNING
  metadata_options:
    gce_http_endpoint: ENABLED
    aws_v1_http_endpoint: ENABLED
    gce_http_token: ENABLED
    aws_v1_http_token: DISABLED
  boot_disk:
    mode: READ_WRITE
    device_name: epd4uuhf52oe********
    auto_delete: true
    disk_id: epd4uuhf52oe********
  network_interfaces:
    - index: "0"
      mac_address: d0:0d:b8:**:**:**
      subnet_id: e2l1ejkvq4jv********
      primary_v4_address:
        address: 192.168.1.9
        one_to_one_nat:
          address: 158.160.**.***
          ip_version: IPV4
  serial_port_settings:
    ssh_authorization: INSTANCE_METADATA
  gpu_settings: {}
  fqdn: epdbhj4gssbp********.auto.internal
  scheduling_policy: {}
  network_settings:
    type: STANDARD
  placement_policy: {}
  ```

  Подробнее о команде `yc compute instance create` читайте в [справочнике CLI](../../cli/cli-ref/compute/cli-ref/instance/create.md).

- API {#api}

  Чтобы создать виртуальную машину, воспользуйтесь методом REST API [create](../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md).

{% endlist %}

Аналогичным способом создайте еще две виртуальные машины — `target-instance-2` и `target-instance-3`. У последней ВМ для метки `target-for-stop` укажите значение `false`.


## Убедитесь, что по триггеру останавливаются ВМ и отправляются уведомления в Telegram {#test}

Дождитесь, когда будут достигнуты пороговые значения, которые вы указали в бюджете. Убедитесь, что при достижении пороговых значений бюджета виртуальные машины `target-instance-1` и `target-instance-2` остановились, а Telegram-бот отправил вам уведомление о срабатывании триггера для бюджета:

```text
Budget trigger was triggered!
```


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../functions/operations/trigger/trigger-delete.md) триггеры Cloud Functions.
1. [Удалите](../../functions/operations/function/function-delete.md) функции Cloud Functions.
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) виртуальные машины.
1. [Удалите](../../message-queue/operations/message-queue-delete-queue.md) очередь Message Queue.
1. [Удалите](../../vpc/operations/subnet-delete.md) подсеть, затем [удалите](../../vpc/operations/network-delete.md) облачную сеть.