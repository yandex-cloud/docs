# Terraform

С помощью Terraform можно создавать очереди сообщений в Message Queue.

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы создать очередь сообщений: 
    
  1. Опишите в конфигурационном файле параметры очереди, которую необходимо создать:
            
     Пример конфигурационного файла для стандартной очереди:

     ```hcl
     provider "yandex" {
       folder_id = "<идентификатор_каталога>"
       zone      = "ru-central1-a"
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
       zone      = "ru-central1-a"
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
       zone      = "ru-central1-a"
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

     Более подробная информация о ресурсах, которые вы можете создать с помощью Terraform, приведена в [документации провайдера](../../terraform/index.md).
     
  1. Проверьте корректность конфигурационных файлов.
     
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:
        ```
        terraform plan
        ```
     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. 
        
  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:
        ```
        terraform apply
        ```
     1. Подтвердите создание ресурсов.
     
     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud). Удалить созданные ресурсы можно командой `terraform destroy`.