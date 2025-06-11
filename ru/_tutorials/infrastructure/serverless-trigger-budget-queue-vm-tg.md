# Создание триггеров, которые вызывают функции {{ sf-name }} для остановки ВМ и отправки уведомлений в Telegram


В этом руководстве вы создадите serverless-инфраструктуру, которая при превышении пороговых значений [бюджета](../../billing/concepts/budget.md) будет останавливать запущенные виртуальные машины и отправлять пользователю уведомления в Telegram.

[Триггер для бюджетов](../../functions/concepts/trigger/budget-trigger.md) будет вызывать [функцию](../../functions/concepts/function.md) {{ sf-name }}, а функция — останавливать [виртуальные машины](../../compute/concepts/vm.md#project) {{ compute-name }} и отправлять сообщение в [очередь](../../message-queue/concepts/queue.md) {{ message-queue-full-name }}. 

[Триггер для {{ message-queue-name }}](../../functions/concepts/trigger/ymq-trigger.md) будет передавать поступившие в очередь сообщения во вторую функцию {{ sf-name }}, которая будет отправлять уведомления в Telegram с помощью специально созданного бота.

Чтобы развернуть проект:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бюджет](#create-budget).
1. [Создайте очередь {{ message-queue-name }}](#create-queue).
1. [Создайте функцию {{ sf-name }}, которую будет вызывать триггер для бюджетов](#create-budget-function).
1. [Создайте триггер для бюджетов](#create-budget-trigger).
1. [Зарегистрируйте Telegram-бота](#register-bot).
1. [Создайте функцию {{ sf-name }}, которую будет вызывать триггер для {{ message-queue-name }}](#create-queue-function).
1. [Создайте триггер для {{ message-queue-name }}](#create-queue-trigger).
1. [Создайте виртуальные машины {{ compute-name }}](#create-vms).
1. [Убедитесь, что по триггеру останавливаются ВМ и отправляются уведомления в Telegram](#test).

Создавайте все указанные ресурсы {{ yandex-cloud }} в одном [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов входят:
* Плата за вычислительные ресурсы ВМ (см. [тарифы {{ compute-name }}](../../compute/pricing.md#prices-instance-resources)).
* Плата за [диски](../../compute/concepts/disk.md) ВМ (см. [тарифы {{ compute-name }}](../../compute/pricing.md#prices-storage)).
* Плата за использование динамического [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md#prices-public-ip)).
* Плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../../functions/pricing.md)).
* Плата за количество запросов к очередям и исходящий трафик (см. [тарифы {{ message-queue-name }}](../../message-queue/pricing.md)).
* Плата за запись и хранение данных в [лог-группе](../../logging/concepts/log-group.md) (см. [тарифы {{ cloud-logging-full-name }}](../../logging/pricing.md)), если вы используете сервис [{{ cloud-logging-name }}](../../logging/).


### Скачайте проект {#download}

Склонируйте репозиторий c проектом:

```bash
git clone https://github.com/yandex-cloud-examples/yc-telegram-bot-with-trigger-for-budget
```


### Создайте сервисный аккаунт и статический ключ доступа {#create-sa}

1. Создайте сервисный аккаунт:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** укажите имя `service-account-for-budget`.
      1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_roles }}** нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `editor`.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

          * `<имя_каталога>` — имя вашего каталога в {{ yandex-cloud }}.
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

      1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
      1. В открывшемся списке выберите сервисный аккаунт `service-account-for-budget`.
      1. На верхней панели нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
      1. При необходимости задайте описание ключа и нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
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

  1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите `my-sample-network`.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** отключите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. На панели слева выберите ![subnets](../../_assets/vpc/subnets.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_name }}** укажите `sample-subnet-{{ region-id }}-b`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_zone }}** выберите зону доступности `{{ region-id }}-b`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_network }}** выберите облачную сеть `my-sample-network`.
  1. В поле **{{ ui-key.yacloud.vpc.subnetworks.create.field_ip }}** укажите `192.168.1.0/24`.
  1. Нажмите кнопку **{{ ui-key.yacloud.vpc.subnetworks.create.button_create }}**.

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

  1. Создайте подсеть `sample-subnet-{{ region-id }}-b` в зоне доступности `{{ region-id }}-b`:

      ```bash
      yc vpc subnet create sample-subnet-{{ region-id }}-b \
        --zone {{ region-id }}-b \
        --network-name my-sample-network \
        --range 192.168.1.0/24
      ```

      Результат:

      ```text
      id: e2l1ejkvq4jv********
      folder_id: b1g9d2k0itu4********
      created_at: "2024-02-23T18:40:26Z"
      name: sample-subnet-ru-{{ region-id }}-b
      network_id: enp2gjcvrd59********
      zone_id: {{ region-id }}-b
      v4_cidr_blocks:
        - 192.168.1.0/24
      ```

      Подробнее о команде `yc vpc subnet create` читайте в [справочнике CLI](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. Чтобы создать сеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md).

  1. Чтобы создать подсеть, воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md).

{% endlist %}


## Создайте бюджет {#create-budget}

{% include [create-budget-for-triggering](../_tutorials_includes/create-budget-for-triggering.md) %}


## Создайте очередь {{ message-queue-name }} {#create-queue}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.ymq.queues.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.ymq.queue.form.section_base }}** укажите:
      * **{{ ui-key.yacloud.common.name }}** — `budget-queue`.  
      * **{{ ui-key.yacloud.ymq.queue.form.switch_fifo-queue }}** — `{{ ui-key.yacloud.ymq.queue.form.type_switch_standard }}`.

      Остальные параметры оставьте без изменений.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. Нажмите на имя созданной очереди `budget-queue` и в открывшемся окне скопируйте значения полей:
      * **{{ ui-key.yacloud.ymq.queue.overview.label_url }}** — URL очереди.
      * **{{ ui-key.yacloud.ymq.queue.overview.label_queue-arn }}** — идентификатор очереди.

      Сохраните эти значения: они пригодятся на следующих шагах.

- AWS CLI {#cli}

  1. [Установите и настройте](../../message-queue/operations/configuring-aws-cli.md) AWS CLI. При настройке используйте созданный ранее статический ключ доступа.

  1. Создайте очередь:

      ```bash
      aws sqs create-queue \
        --queue-name budget-queue \
        --endpoint https://message-queue.{{ api-host }}/
      ```

      Результат:

      ```json
      {
          "QueueUrl": "https://message-queue.{{ api-host }}/b1glti4eser3********/dj600000001c********/budget-queue"
      }
      ```

      Сохраните значение URL очереди `QueueUrl`, оно пригодится на следующих шагах.

  1. Получите идентификатор очереди, указав сохраненный ранее URL в параметре `--queue-url`:

      ```bash
      aws sqs get-queue-attributes \
        --queue-url <URL_очереди> \
        --attribute-names QueueArn \
        --endpoint https://message-queue.{{ api-host }}/
      ```

      Результат:

      ```json
      {
          "Attributes": {
              "QueueArn": "yrn:yc:ymq:{{ region-id }}:b1g9d2k0itu4********:budget-queue"
          }
      }
      ```

      Сохраните идентификатор очереди `QueueArn`, он пригодится на следующих шагах.

{% endlist %}


## Создайте функцию {{ sf-name }}, которую будет вызывать триггер для бюджетов {#create-budget-function}

1. Подготовьте ZIP-архив с кодом функции.

    Перейдите в директорию `yc-telegram-bot-with-trigger-for-budget/steps/4-create-budget-trigger-handler` и добавьте файлы в ZIP-архив `src_bgt.zip`:

    ```bash
    zip src_bgt.zip budget_trigger_handler.go go.mod
    ```

1. Создайте функцию:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
      1. Создайте функцию:
          1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
          1. Введите имя функции `budget-trigger-handler`.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

      1. Создайте версию функции:
          1. Выберите среду выполнения `golang119`, выключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
          1. Укажите способ загрузки **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}** и прикрепите архив `src_bgt.zip`, который создали на предыдущем шаге.
          1. Укажите точку входа `budget_trigger_handler.Handler`.
          1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:
              * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `5`;
              * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `512 {{ ui-key.yacloud.common.units.label_megabyte }}`;
              * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `service-account-for-budget`;
              * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:
                  * `FOLDER_ID` — идентификатор каталога, в котором вы хотите останавливать виртуальные машины.
                  * `TAG` — `target-for-stop`.
                  * `AWS_ACCESS_KEY_ID` — значение идентификатора статического ключа доступа, сохраненное ранее.
                  * `AWS_SECRET_ACCESS_KEY` — значение секретного ключа статического ключа доступа, сохраненное ранее.
                  * `BUDGET_QUEUE_URL` — значение URL очереди `budget-queue`, сохраненное ранее.

          1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

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
          http_invoke_url: https://{{ sf-url }}/d4e4aigfdm0b********
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
            BUDGET_QUEUE_URL: https://message-queue.{{ api-host }}/b1glti4eser3********/dj600000001c********/budget-queue
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

  1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
      * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** укажите имя триггера `trigger-for-budget-from-yc`.
      * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_billing-budget }}`.
      * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_billing-budget }}** выберите ваш платежный аккаунт и бюджет `vm-budget`, который создали ранее.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию `budget-trigger-handler` и укажите сервисный аккаунт `service-account-for-budget`. От его имени будет вызываться функция.

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

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

## Создайте функцию {{ sf-name }}, которую будет вызывать триггер для {{ message-queue-name }} {#create-queue-function}

1. Подготовьте ZIP-архив с кодом функции.

    Перейдите в директорию `yc-telegram-bot-with-trigger-for-budget/steps/7-create-budget-queue-handler` и добавьте файлы в ZIP-архив `src_queue.zip`:

    ```bash
    zip src_queue.zip budget_queue_handler.go utils.go go.mod
    ```

1. Создайте функцию:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог.
      1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
      1. Создайте функцию:
          1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
          1. Введите имя функции `budget-queue-handler`.
          1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

      1. Создайте версию функции:
          1. Выберите среду выполнения `golang119`, выключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
          1. Укажите способ загрузки **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}** и прикрепите архив `src_queue.zip`, который создали на предыдущем шаге.
          1. Укажите точку входа `budget_queue_handler.HandleBudgetQueueMessage`.
          1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:
              * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `5`;
              * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `512 {{ ui-key.yacloud.common.units.label_megabyte }}`;
              * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `service-account-for-budget`;
              * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:
                  * `TELEGRAM_BOT_API_TOKEN` — API-токен Telegram-бота, сохраненный ранее.
                  * `TELEGRAM_BOT_CHAT_ID` — идентификатор `ChatID` пользователя Telegram, сохраненный ранее.

          1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

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
          http_invoke_url: https://{{ sf-url }}/d4e6r2g9trt5********
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


## Создайте триггер для {{ message-queue-name }} {#create-queue-trigger}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:
      * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** укажите имя триггера `budget-queue-trigger`.
      * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_ymq }}`.
      * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_ymq }}** выберите созданные ранее ресурсы:
      * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_queue }}** — `budget-queue`.
      * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_service-account }}** — `service-account-for-budget`.

  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию `budget-queue-handler` и укажите сервисный аккаунт `service-account-for-budget`. От его имени будет вызываться функция.

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

  Чтобы создать триггер для {{ message-queue-name }}, который вызывает функцию `budget-queue-handler`, выполните команду:

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
      queue_id: yrn:yc:ymq:{{ region-id }}:b1g9d2k0itu4********:budget-queue
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

  Чтобы создать триггер для {{ message-queue-name }}, воспользуйтесь методом [create](../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../functions/triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../functions/triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}


## Создайте виртуальные машины {{ compute-name }} {#create-vms}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана ВМ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** выберите [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-b`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**: 

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите созданную ранее подсеть `sample-subnet-{{ region-id }}-b`.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа к ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, например, `yc-user`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}**:

      * Укажите имя ВМ: `target-instance-1`.
      * В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}** и введите `target-for-stop:true`. Нажмите **Enter**, чтобы сохранить метку.

  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

- CLI {#cli}

  Создайте виртуальную машину:

  ```bash
  yc compute instance create \
    --name target-instance-1 \
    --labels target-for-stop=true \
    --zone {{ region-id }}-b \
    --network-interface subnet-name=sample-subnet-{{ region-id }}-b,nat-ip-version=ipv4 \
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
  zone_id: {{ region-id }}-b
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

  Чтобы создать виртуальную машину, воспользуйтесь методом REST API [create](../../compute/api-ref/Instance/create.md) для ресурса [Instance](../../compute/api-ref/Instance/) или вызовом gRPC API [InstanceService/Create](../../compute/api-ref/grpc/Instance/create.md).

{% endlist %}

Аналогичным способом создайте еще две виртуальные машины — `target-instance-2` и `target-instance-3`. У последней ВМ для метки `target-for-stop` укажите значение `false`.


## Убедитесь, что по триггеру останавливаются ВМ и отправляются уведомления в Telegram {#test}

Дождитесь, когда будут достигнуты пороговые значения, которые вы указали в бюджете. Убедитесь, что при достижении пороговых значений бюджета виртуальные машины `target-instance-1` и `target-instance-2` остановились, а Telegram-бот отправил вам уведомление о срабатывании триггера для бюджета:

```text
Budget trigger was triggered!
```


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../functions/operations/trigger/trigger-delete.md) триггеры {{ sf-name }}.
1. [Удалите](../../functions/operations/function/function-delete.md) функции {{ sf-name }}.
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) виртуальные машины.
1. [Удалите](../../message-queue/operations/message-queue-delete-queue.md) очередь {{ message-queue-name }}.
1. [Удалите](../../vpc/operations/subnet-delete.md) подсеть, затем [удалите](../../vpc/operations/network-delete.md) облачную сеть.