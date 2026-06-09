# Создание новой очереди сообщений

Очереди сообщений {{ message-queue-name }} позволяют передавать [сообщения](../concepts/message.md) между компонентами распределенных приложений. Передавать сообщения в очереди можно с помощью [API](../api-ref/index.md) или других поддерживаемых [инструментов](../instruments/index.md).

Чтобы создать новую очередь сообщений:

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана очередь.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.ymq.queues.button_create }}**.
  1. В блоке **{{ ui-key.yacloud.ymq.queue.form.section_base }}** заполните поля:
      * **{{ ui-key.yacloud.common.name }}** — укажите имя очереди.
  
        Имя может содержать строчные буквы латинского алфавита, цифры, дефисы и подчеркивания. Имя очереди FIFO должно заканчиваться суффиксом `.fifo`. Длина имени не должна превышать 80 символов.
  
      * **{{ ui-key.yacloud.ymq.queue.form.switch_fifo-queue }}** — выберите тип очереди `{{ ui-key.yacloud.ymq.queue.form.type_switch_standard }}` или `{{ ui-key.yacloud.ymq.queue.form.type_switch_fifo }}`.
      * **{{ ui-key.yacloud.ymq.queue.form.field_visibility-timeout }}** — укажите стандартный таймаут видимости, который будет применяться к сообщениям в очереди после чтения получателем.
      * **{{ ui-key.yacloud.ymq.queue.form.field_keeping-time }}** — укажите максимальный срок хранения сообщений в очереди.
      * **{{ ui-key.yacloud.ymq.queue.form.field_max-size }}** — укажите максимальный размер сообщения.
      * **{{ ui-key.yacloud.ymq.queue.form.field_sending-delay }}** — укажите время, в течение которого новое сообщение нельзя получить из очереди.
      * **{{ ui-key.yacloud.ymq.queue.form.field_receiving-delay }}** — укажите время ожидания при получении сообщения.
  1. Чтобы перенаправлять недоставленные сообщения в [очередь недоставленных сообщений (DLQ)](../concepts/dlq.md), в блоке **{{ ui-key.yacloud.ymq.queue.form.section_message-settings }}**:
      * Включите опцию **{{ ui-key.yacloud.ymq.queue.form.switch_redirect-messages }}**.
      * Укажите **{{ ui-key.yacloud.ymq.queue.form.field_messages-queue }}**.
      * Задайте **{{ ui-key.yacloud.ymq.queue.form.field_max-read-tries }}**.
  1.  Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- AWS CLI {#cli}

  1. [Установите и настройте](configuring-aws-cli.md) AWS CLI.

  1. Выполните в терминале команду:
  
     ```bash
     aws sqs create-queue \
       --queue-name <имя_очереди> \
       --endpoint <эндпоинт>
     ```

     Где:

     * `--queue-name` — имя создаваемой очереди, например `sample-queue`.
     * `--endpoint` — эндпоинт в значении `https://message-queue.{{ api-host }}/`.
      
     Результат:

     ```json
     {
         "QueueUrl": "https://message-queue.{{ api-host }}/aoeaql9r10cd********/000000000000********/sample-queue"
     }
     ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).
  
    Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    
    
    Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.
  
    Чтобы создать очередь сообщений: 
      
    1. Опишите в конфигурационном файле параметры очереди, которую необходимо создать:
              
       Пример конфигурационного файла для стандартной очереди:
  
       ```hcl
       provider "yandex" {
         folder_id = "<идентификатор_каталога>"
         zone      = "{{ region-id }}-a"
       }
  
       resource "yandex_message_queue" "example_queue" {
         name                        = "mq-terraform-example"
         visibility_timeout_seconds  = 600
         receive_wait_time_seconds   = 20
         message_retention_seconds   = 1209600
         access_key                  = "<идентификатор_статического_ключа_доступа>"
         secret_key                  = "<секретная_часть_статического_ключа_доступа>"
       }
       ```
  
       Пример конфигурационного файла для очереди FIFO:
  
       ```hcl
       provider "yandex" {
         folder_id = "<идентификатор_каталога>"
         zone      = "{{ region-id }}-a"
       }
  
       resource "yandex_message_queue" "example-fifo-queue" {
         name                        = "mq-terraform-example.fifo"
         visibility_timeout_seconds  = 600
         receive_wait_time_seconds   = 20
         message_retention_seconds   = 1209600
         fifo_queue                  = true
         access_key                  = "<идентификатор_статического_ключа_доступа>"
         secret_key                  = "<секретная_часть_статического_ключа_доступа>"
       }
       ```
  
       Пример конфигурационного файла для очереди с политикой перенаправления недоставленных сообщений в DLQ с именем `mq_terraform_deadletter_example`:
  
       ```hcl
       provider "yandex" {
         folder_id = "<идентификатор_каталога>"
         zone      = "{{ region-id }}-a"
       }
  
       resource "yandex_message_queue" "example_fifo_queue" {
         name                        = "mq-terraform-example"
         visibility_timeout_seconds  = 600
         receive_wait_time_seconds   = 20
         message_retention_seconds   = 1209600
         redrive_policy              = jsonencode({
           deadLetterTargetArn = yandex_message_queue.example_deadletter_queue.arn
           maxReceiveCount     = 3
         })
         access_key                  = "<идентификатор_статического_ключа_доступа>"
         secret_key                  = "<секретная_часть_статического_ключа_доступа>"
       }
  
       resource "yandex_message_queue" "example_deadletter_queue" {
         name                        = "mq_terraform_deadletter_example"
         access_key                  = "<идентификатор_статического_ключа_доступа>"
         secret_key                  = "<секретная_часть_статического_ключа_доступа>"
       }
       ```
  
       Где:
  
       * `name` — имя очереди.
       * `visibility_timeout_seconds` — [таймаут видимости](../concepts/visibility-timeout.md).
       * `receive_wait_time_seconds` — время ожидания поступления сообщений в очередь при использовании [Long Polling](../concepts/long-polling.md). Возможные значения: от 0 до 20 секунд. Значение по умолчанию — 0 секунд.
       * `message_retention_seconds` — срок хранения сообщений в очереди в секундах.
       * `redrive_policy` — политика перенаправления сообщений в очередь [Dead Letter Queue](../concepts/dlq.md).
         * `deadLetterTargetArn` — ARN очереди DLQ, куда будут перенаправляться сообщения.
         * `maxReceiveCount` — количество попыток чтения сообщения из очереди до отправки его в DLQ.
       * `fifo_queue` — указание, что создается [очередь FIFO](../concepts/queue.md#fifo-queues).
       * `content_based_deduplication` — включение [дедупликации по содержимому](../concepts/deduplication.md#content-based-deduplication) в очередях FIFO.
       * `access_key` — идентификатор статического ключа доступа сервисного аккаунта для очереди. Если идентификатор не задан в конфигурации очереди, будет использоваться идентификатор из конфигурации провайдера.
       * `secret_key` — секретная часть статического ключа доступа. Если секретный ключ не задан в конфигурации очереди, будет использоваться ключ из конфигурации провайдера.
  
       Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}).
       
    1. Проверьте корректность конфигурационных файлов.
       
       1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
       1. Выполните проверку с помощью команды:
          ```
          terraform plan
          ```
       Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 
          
    1. Разверните облачные ресурсы.
  
       1. Если в конфигурации нет ошибок, выполните команду:
          ```
          terraform apply
          ```
       1. Подтвердите создание ресурсов.
       
       После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}). Удалить созданные ресурсы можно командой `terraform destroy`.

{% endlist %}


При достижении лимита на максимальное количество очередей, возникает ошибка `Cannot create queue: Too many queues`. Для увеличения лимита обратитесь в [техническую поддержку]({{ link-console-support }}).