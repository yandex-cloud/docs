# Создать триггер для {{ container-registry-name }}, который вызывает контейнер {{ serverless-containers-name }}

Создайте [триггер для {{ container-registry-name }}](../concepts/trigger/cr-trigger.md), который будет вызывать [контейнер](../concepts/container.md) {{ serverless-containers-name }} при создании и удалении [Docker-образов](../../container-registry/concepts/docker-image.md) {{ container-registry-name }} или их тегов.

## Перед началом работы {#before-begin}

Для создания триггера вам понадобятся:

* Контейнер, который триггер будет вызывать. Если у вас нет контейнера:

    * [Создайте контейнер](create.md).
    * [Создайте ревизию контейнера](manage-revision.md#create).

* (Опционально) Очередь [Dead Letter Queue](../concepts/dlq.md), куда будут перенаправляться сообщения, которые не смог обработать контейнер. Если у вас нет очереди, [создайте ее](../../message-queue/operations/message-queue-new-queue.md).

* [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с правами на вызов контейнера и (опционально) запись в очередь Dead Letter Queue. Вы можете использовать один и тот же сервисный аккаунт или разные. Если у вас нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).

* [Реестр](../../container-registry/concepts/registry.md), при событиях с [Docker-образами](../../container-registry/concepts/docker-image.md) в котором триггер будет запускаться. Если у вас нет реестра, [создайте его](../../container-registry/operations/registry/registry-create.md).

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
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container-registry }}`.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_container-registry }}**:

        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_container-registry }}** выберите реестр, для событий с образами в котором необходимо создать триггер.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** выберите [события](../concepts/trigger/cr-trigger.md#event), после наступления которых триггер будет запускаться.
        * (Опционально) В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_image-name }}** введите имя образа для [фильтрации](../concepts/trigger/cr-trigger.md#filter). Чтобы узнать имя Docker-образа, [получите список Docker-образов в реестре](../../container-registry/operations/docker-image/docker-image-list.md).
        * (Опционально) В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_tag }}** введите тег образа для фильтрации.
    
    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cutoff }}**. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда.
        * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**. Допустимые значения от 1 до 100, значение по умолчанию — 1.

        Триггер группирует события не дольше указанного времени ожидания и отправляет их в контейнер. Число событий при этом не превышает указанный размер группы.

    1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_container }}** выберите его и [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого он будет вызываться.

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-interval }}** укажите время, через которое будет сделан повторный вызов контейнера, если текущий завершился неуспешно. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
        * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-attempts }}** укажите количество повторных вызовов контейнера, которые будут сделаны, прежде чем триггер отправит сообщение в Dead Letter Queue. Допустимые значения — от 1 до 5, значение по умолчанию — 1.

    1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы создать триггер, который вызывает контейнер, выполните команду:

    ```bash
    yc serverless trigger create container-registry \
      --name <имя_триггера> \
      --registry-id <идентификатор_реестра> \
      --events 'create-image','delete-image','create-image-tag','delete-image-tag' \
      --batch-size <размер_группы_событий> \
      --batch-cutoff <максимальное_время_ожидания> \
      --invoke-container-id <идентификатор_контейнера> \
      --invoke-container-service-account-id <идентификатор_сервисного_аккаунта> \
      --retry-attempts <количество_повторных_вызовов> \
      --retry-interval <интервал_между_повторными_вызовами> \
      --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
      --dlq-service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--name` — имя триггера.
    * `--registry-id` — [идентификатор реестра](../../container-registry/operations/registry/registry-list.md).
    * `--events` — [события](../concepts/trigger/cr-trigger.md#event), после наступления которых триггер запускается.

    * `--batch-size` — размер группы событий. Необязательный параметр. Допустимые значения от 1 до 10, значение по умолчанию — 1.
    * `--batch-cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда. Триггер группирует события не дольше `batch-cutoff` и отправляет их в контейнер. Число событий при этом не превышает `batch-size`.

    * `--invoke-container-id` — идентификатор контейнера.
    * `--invoke-container-service-account-id` — идентификатор сервисного аккаунта с правами на вызов контейнера.
    * `--retry-attempts` — количество повторных вызовов, которые будут сделаны, прежде чем триггер отправит сообщение в Dead Letter Queue. Необязательный параметр. Допустимые значения — от 1 до 5, значение по умолчанию — 1.
    * `--retry-interval` — время, через которое будет сделан повторный вызов контейнера, если текущий завершился неуспешно. Необязательный параметр. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.
    * `--dlq-queue-id` — идентификатор очереди Dead Letter Queue. Необязательный параметр.
    * `--dlq-service-account-id` — идентификатор сервисного аккаунта с правами на запись в очередь Dead Letter Queue. Необязательный параметр.

    Результат:

    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: registry-trigger
    rule:
      container_registry:
        event_type:
        - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE
        - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE
        - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG
        - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG
        registry_id: crtlds4tdfg12kil77h2********
        batch_settings:
          size: "3"
          cutoff: 20s
        invoke_container:
          container_id: bba5jb38o8h2********
          service_account_id: aje3932acdh2********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmkh2********:dlq
            service-account-id: aje3932acdh2********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы создать триггер для {{ container-registry-name }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name = "<имя_триггера>"
        container {
          id                 = "<идентификатор_контейнера>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          retry_attempts     = "<количество_повторных_вызовов>"
          retry_interval     = "<интервал_между_повторными_вызовами>"
        }
        container_registry {
          registry_id      = "<идентификатор_реестра>"
          image_name       = "<имя_образа>"
          tag              = "<тег_образа>"
          create_image     = true
          delete_image     = true
          create_image_tag = true
          delete_image_tag = true
          batch_cutoff     = "<максимальное_время_ожидания>"
          batch_size       = "<размер_группы_событий>"
        }
        dlq {
          queue_id           = "<идентификатор_очереди_Dead_Letter_Queue>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
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

        * `retry_attempts` — количество повторных вызовов, которые будут сделаны, прежде чем триггер отправит сообщение в Dead Letter Queue. Необязательный параметр. Допустимые значения — от 1 до 5, значение по умолчанию — 1.
        * `retry_interval` — время, через которое будет сделан повторный вызов контейнера, если текущий завершился неуспешно. Необязательный параметр. Допустимые значения — от 10 до 60 секунд, значение по умолчанию — 10 секунд.

      * `container_registry` — параметры триггера:

        * `registry_id` — [идентификатор реестра](../../container-registry/operations/registry/registry-list.md).
        * `image_name` — имя образа для [фильтрации](../concepts/trigger/cr-trigger.md#filter). Чтобы узнать имя Docker-образа, [получите список Docker-образов в реестре](../../container-registry/operations/docker-image/docker-image-list.md).
        * `tag` — тег образа для фильтрации.
        * [События](../concepts/trigger/cr-trigger.md#event), после наступления которых триггер запускается:

          * `create_image` — триггер вызовет контейнер при создании нового Docker-образа в реестре. Принимает значения `true` или `false`.
          * `delete_image` — триггер вызовет контейнер при удалении Docker-образа в реестре. Принимает значения `true` или `false`.
          * `create_image_tag` — триггер вызовет контейнер при создании нового тега Docker-образа в реестре. Принимает значения `true` или `false`.
          * `delete_image_tag`— триггер вызовет контейнер при удалении тега Docker-образа в реестре. Принимает значения `true` или `false`.

        * `batch_cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда. Триггер группирует события не дольше `batch_cutoff` и отправляет их в контейнер. Число событий при этом не превышает `batch_size`.
        * `batch_size` — размер группы событий. Необязательный параметр. Допустимые значения от 1 до 10, значение по умолчанию — 1.

        * `dlq` — параметры очереди сообщений Dead Letter Queue:
            * `queue_id` — идентификатор очереди Dead Letter Queue.
            * `service_account_id` — идентификатор сервисного аккаунта с правами на запись в очередь Dead Letter Queue.

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

  Чтобы создать триггер для {{ container-registry-name }}, воспользуйтесь методом REST API [create](../triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../triggers/api-ref/grpc/Trigger/create.md).

{% endlist %}

## Проверить результат {#check-result}

Проверьте, что триггер работает корректно. Для этого посмотрите [логи контейнера](../concepts/logs.md), в них отображается информация о вызовах.

## См. также {#see-also}

* [{#T}](../../functions/operations/trigger/cr-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/cr-trigger-create.md)