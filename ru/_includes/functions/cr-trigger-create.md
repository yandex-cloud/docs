Создайте [триггер для {{ container-registry-name }}](../../functions/concepts/trigger/cr-trigger.md), который будет вызывать [функцию](../../functions/concepts/function.md) {{ sf-name }} при создании и удалении [Docker-образов](../../container-registry/concepts/docker-image.md) {{ container-registry-name }} или их [тегов](../../container-registry/concepts/docker-image.md#version).

## Перед началом работы {#before-you-begin}

{% include [trigger-before-you-begin](trigger-before-you-begin.md) %}

* [Реестр](../../container-registry/concepts/registry.md), при [событиях](../../functions/concepts/trigger/cr-trigger.md#event) с Docker-образами в котором триггер будет запускаться. Если у вас нет реестра, [создайте его](../../container-registry/operations/registry/registry-create.md).

## Создать триггер {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать триггер.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите ![image](../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

     * Введите имя и описание триггера.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** выберите **{{ ui-key.yacloud.serverless-functions.triggers.form.label_container-registry }}**.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** выберите **{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}**.

  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_container-registry }}**:

     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_container-registry }}** выберите реестр, для событий с образами в котором необходимо создать триггер.
     * В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_event-types }}** выберите [события](../../functions/concepts/trigger/cr-trigger.md#event), после наступления которых триггер будет запускаться.
     * (Опционально) В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_image-name }}** введите имя образа для [фильтрации](../../functions/concepts/trigger/cr-trigger.md#filter). Чтобы узнать имя Docker-образа, [получите список Docker-образов в реестре](../../container-registry/operations/docker-image/docker-image-list.md).
     * (Опционально) В поле **{{ ui-key.yacloud.serverless-functions.triggers.form.field_tag }}** введите [тег образа](../../functions/concepts/trigger/cr-trigger.md#filter) для фильтрации.

  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}** укажите:

     {% include [batch-settings](batch-settings.md) %}

     {% include [batch-events](batch-events.md) %}

  1. В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}** выберите функцию и укажите:

     {% include [function-settings](function-settings.md) %}

  1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

     {% include [repeat-request.md](repeat-request.md) %}

  
  1. (Опционально) В блоке **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}** выберите очередь Dead Letter Queue и сервисный аккаунт с правами на запись в нее.


  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  Чтобы создать триггер, который вызывает функцию, выполните команду:

  
  ```bash
  yc serverless trigger create container-registry \
    --name <имя_триггера> \
    --registry-id <идентификатор_реестра> \
    --events 'create-image', 'delete-image', 'create-image-tag', 'delete-image-tag' \
    --batch-size <размер_группы> \
    --batch-cutoff <максимальное_время_ожидания> \
    --invoke-function-id <идентификатор_функции> \
    --invoke-function-service-account-id <идентификатор_сервисного_аккаунта> \
    --retry-attempts 1 \
    --retry-interval 10s \
    --dlq-queue-id <идентификатор_очереди_Dead_Letter_Queue> \
    --dlq-service-account-id <идентификатор_сервисного_аккаунта>
  ```


  Где:

  * `--name` — имя триггера.
  * `--registry-id` — [идентификатор реестра](../../container-registry/operations/registry/registry-list.md).
  * `--events` — [события](../../functions/concepts/trigger/cr-trigger.md#event), после наступления которых триггер запускается.
  
  {% include [batch-settings-events](batch-settings-events.md) %}

  {% include [trigger-cli-param](trigger-cli-param.md) %}

  Результат:

  ```text
  id: a1s92agr8m**********
  folder_id: b1g88tflru**********
  created_at: "2020-09-08T06:26:22.651656Z"
  name: registry-trigger
  rule:
    container_registry:
      event_type:
      - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE
      - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE
      - CONTAINER_REGISTRY_EVENT_TYPE_CREATE_IMAGE_TAG
      - CONTAINER_REGISTRY_EVENT_TYPE_DELETE_IMAGE_TAG
      registry_id: crtlds4tdfg12kil77**********
      batch_settings:
        size: "3"
        cutoff: 20s
      invoke_function:
        function_id: d4eofc7n0m**********
        function_tag: $latest
        service_account_id: aje3932acd**********
        retry_settings:
          retry_attempts: "1"
          interval: 10s
        dead_letter_queue:
          queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:dlq
          service-account-id: aje3932acd**********
  status: ACTIVE
  ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать триггер для {{ container-registry-name }}:

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```
      resource "yandex_function_trigger" "my_trigger" {
        name = "<имя_триггера>"
        function {
          id                 = "<идентификатор_функции>"
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
          batch_cutoff     = "<время_ожидания>"
          batch_size       = "<размер_группы_событий>"
        }
        dlq {
          queue_id           = "<идентификатор_очереди>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
        }
      }
      ```

      Где:

      {% include [tf-function-params](tf-function-params.md) %}

      * `container_registry` — параметры триггера:

        * `registry_id` — идентификатор реестра.
        * `image_name` — имя Docker-образа.
        * `tag` — тег Docker-образа.
        * Выберите один или несколько типов событий, которые будет обрабатывать триггер:

          * `create_image` — триггер вызовет функцию при создании нового Docker-образа в реестре. Принимает значения `true` или `false`.
          * `delete_image` — триггер вызовет функцию при удалении Docker-образа в реестре. Принимает значения `true` или `false`.
          * `create_image_tag` — триггер вызовет функцию при создании нового тега Docker-образа в реестре. Принимает значения `true` или `false`.
          * `delete_image_tag`— триггер вызовет функцию при удалении тега Docker-образа в реестре. Принимает значения `true` или `false`.

        * `batch_cutoff` — максимальное время ожидания. Необязательный параметр. Допустимые значения от 1 до 60 секунд, значение по умолчанию — 1 секунда. Триггер группирует события не дольше `batch-cutoff` и отправляет их в функцию. Число событий при этом не превышает `batch-size`.
        * `batch_size` — размер группы событий. Необязательный параметр. Допустимые значения от 1 до 10, значение по умолчанию — 1.

      {% include [tf-dlq-params](../serverless-containers/tf-dlq-params.md) %}

      Более подробную информацию о параметрах ресурса `yandex_function_trigger` см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc serverless trigger get <идентификатор триггера>
      ```

- API {#api}

  Чтобы создать триггер для {{ container-registry-name }}, воспользуйтесь методом REST API [create](../../functions/triggers/api-ref/Trigger/create.md) для ресурса [Trigger](../../functions/triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Create](../../functions/triggers/api-ref/grpc/trigger_service.md#Create).

{% endlist %}

## Проверить результат {#check-result}

{% include [check-result](check-result.md) %}

## См. также {#see-also}

* [Триггер для {{ container-registry-name }}, который вызывает контейнер {{ serverless-containers-name }}](../../serverless-containers/operations/cr-trigger-create.md).
