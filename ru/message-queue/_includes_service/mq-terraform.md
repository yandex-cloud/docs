  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы создать очередь сообщений: 
    
  1. Опишите в конфигурационном файле параметры очереди, которую необходимо создать:
            
     Пример конфигурационного файла для стандартной очереди:

     ```
     provider "yandex" {
         token     = "<OAuth_или_статический_ключ_сервисного_аккаунта>"
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

     ```
     provider "yandex" {
         token     = "<OAuth_или_статический_ключ_сервисного_аккаунта>"
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

     ```
     provider "yandex" {
         token     = "<OAuth_или_статический_ключ_сервисного_аккаунта>"
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

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).
     
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