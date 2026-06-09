# Создать триггер для {{ message-queue-name }}, который передает сообщения в контейнер {{ serverless-containers-name }}

Создайте [триггер для очереди сообщений](../concepts/trigger/ymq-trigger.md) сервиса {{ message-queue-short-name }} и обрабатывайте их с помощью [контейнера](../concepts/container.md) {{ serverless-containers-name }}.

{% note warning %}

* Триггер можно создать только для стандартной очереди сообщений.
* Триггер должен находиться в одном облаке с очередью, из которой он читает сообщения.
* Для одной очереди сообщений можно создать только один триггер.

{% endnote %}

## Перед началом работы {#before-begin}

Для создания триггера вам понадобятся:

* Контейнер, который триггер будет вызывать. Если у вас нет контейнера:

    * [Создайте контейнер](create.md).
    * [Создайте ревизию контейнера](manage-revision.md#create).

* [Сервисные аккаунты](../../iam/concepts/users/service-accounts.md) с правами:

    * на вызов контейнера;
    * на чтение из очереди, из которой триггер будет принимать сообщения.

    Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).

* Очередь сообщений, из которой триггер будет принимать сообщения. Если у вас нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).

## Создать триггер {#trigger-create}

{% note info %}

Триггер начинает работать в течение 5 минут после создания.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.

    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Введите имя и описание триггера.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_ymq }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_ymq }}** выберите очередь сообщений и сервисный аккаунт с правами на чтение из нее.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_ymq-cutoff }}**. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд.
        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**. Допустимые значения от 1 до 1000, значение по умолчанию — 1.

        Триггер группирует сообщения не дольше указанного времени ожидания и отправляет их в контейнер. Число сообщений при этом не превышает указанный размер группы.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_container }}** выберите его и [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого он будет вызываться.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать триггер, который вызывает контейнер, выполните команду:

    ```bash
    yc serverless trigger create message-queue \
      --name <имя_триггера> \
      --queue <идентификатор_очереди> \
      --queue-service-account-id <идентификатор_сервисного_аккаунта> \
      --invoke-container-id <идентификатор_контейнера> \
      --invoke-container-service-account-id <идентификатор_сервисного_аккаунта> \
      --batch-size <размер_группы_сообщений> \
      --batch-cutoff <максимальное_время_ожидания>
    ```

    Где:

    * `--name` — имя триггера.
    * `--queue` — идентификатор очереди.

        Чтобы узнать идентификатор очереди:
        
        1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится очередь.
        1. Выберите сервис **{{ message-queue-name }}**.
        1. Выберите очередь.
        1. Идентификатор очереди будет в блоке **{{ ui-key.yacloud.ymq.queue.overview.section_base }}**, в поле **{{ ui-key.yacloud.ymq.queue.overview.label_queue-arn }}**.

    * `--invoke-container-id` — идентификатор контейнера.
    * `--queue-service-account-id` — идентификатор сервисного аккаунта с правами на чтение из очереди сообщений.
    * `--invoke-container-service-account-id` — идентификатор сервисного аккаунта с правами на вызов контейнера.
    * `--batch-size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 до 1000, значение по умолчанию — 1.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в контейнер. Число сообщений при этом не превышает `batch-size`.

    Результат:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: ymq-trigger
    rule:
      message_queue:
        queue_id: yrn:yc:ymq:{{ region-id }}:b1gmit33ngh2********:my-mq
        service_account_id: bfbqqeo6jkh2********
        batch_settings:
          size: "1"
          cutoff: 10s
        invoke_container:
          container_id: bba5jb38o8h2********
          service_account_id: bfbqqeo6jkh2********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы создать триггер для {{ message-queue-name }}:

  1. Опишите в конфигурационном файле параметры триггера:

     ```hcl
     resource "yandex_function_trigger" "my_trigger" {
       name = "<имя_триггера>"
       container {
         id                 = "<идентификатор_контейнера>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
       }
       message_queue {
         queue_id           = "<идентификатор_очереди>"
         service_account_id = "<идентификатор_сервисного_аккаунта>"
         batch_cutoff       = "<максимальное_время_ожидания>"
         batch_size         = "<размер_группы_сообщений>"
       }
     }
     ```

     Где:

     * `name` — имя триггера. Формат имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

     * `container` — параметры контейнера:

         * `id` — идентификатор контейнера.
         * `service_account_id` — идентификатор сервисного аккаунта с правами на вызов контейнера.

     * `message_queue` — параметры триггера:

         * `queue_id` — идентификатор очереди.

             Чтобы узнать идентификатор очереди:
             
             1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится очередь.
             1. Выберите сервис **{{ message-queue-name }}**.
             1. Выберите очередь.
             1. Идентификатор очереди будет в блоке **{{ ui-key.yacloud.ymq.queue.overview.section_base }}**, в поле **{{ ui-key.yacloud.ymq.queue.overview.label_queue-arn }}**.

         * `service_account_id` — идентификатор сервисного аккаунта с правами на чтение из очереди сообщений.

         * `batch_cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 0 до 20 секунд, значение по умолчанию — 10 секунд. Триггер группирует сообщения не дольше `batch-cutoff` и отправляет их в контейнер. Число сообщений при этом не превышает `batch-size`.
         * `batch_size` — размер группы сообщений. Необязательный параметр. Допустимые значения от 1 до 1000, значение по умолчанию — 1.

     Более подробную информацию о параметрах ресурса `yandex_function_trigger` см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

  1. Создайте ресурсы:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc serverless trigger list
     ```

- API {#api}

  Чтобы создать триггер для {{ message-queue-name }}, воспользуйтесь методом REST API [create](../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

{% list tabs %}

- {{ serverless-containers-name }}

    Проверьте, что триггер работает корректно. Для этого посмотрите [логи контейнера](../concepts/logs.md), в них отображается информация о вызовах.

- {{ message-queue-name }}

    Проверьте, что количество сообщений в очереди уменьшается. Для этого посмотрите статистику очереди:

   1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создали триггер.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ymq }}**.
   1. Выберите очередь, для которой создали триггер.
   1. Перейдите в раздел **{{ ui-key.yacloud.common.monitoring }}**. Посмотрите график **{{ ui-key.yacloud.ymq.queue.overview.label_msg-count }}**.

{% endlist %}


## См. также {#see-also}

* [{#T}](../../functions/operations/trigger/ymq-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/ymq-trigger-create.md)