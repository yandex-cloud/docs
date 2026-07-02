[Документация Yandex Cloud](../../index.md) > [Yandex Message Queue](../index.md) > [Пошаговые инструкции](index.md) > Создание новой очереди сообщений

# Создание новой очереди сообщений

Очереди сообщений Message Queue позволяют передавать [сообщения](../concepts/message.md) между компонентами распределенных приложений. Передавать сообщения в очереди можно с помощью [API](../api-ref/index.md) или других поддерживаемых [инструментов](../instruments/index.md).

Чтобы создать новую очередь сообщений:

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создана очередь.
  1. Перейдите в сервис **Message Queue**.
  1. Нажмите кнопку **Создать очередь**.
  1. В блоке **Базовые параметры** заполните поля:
      * **Имя** — укажите имя очереди.
  
        Имя может содержать строчные буквы латинского алфавита, цифры, дефисы и подчеркивания. Имя очереди FIFO должно заканчиваться суффиксом `.fifo`. Длина имени не должна превышать 80 символов.
  
      * **Тип** — выберите тип очереди `Стандартная` или `FIFO`.
      * **Стандартный таймаут видимости** — укажите стандартный таймаут видимости, который будет применяться к сообщениям в очереди после чтения получателем.
      * **Срок хранения  сообщений** — укажите максимальный срок хранения сообщений в очереди.
      * **Максимальный размер сообщения** — укажите максимальный размер сообщения.
      * **Задержка доставки** — укажите время, в течение которого новое сообщение нельзя получить из очереди.
      * **Время ожидания  при получении сообщения** — укажите время ожидания при получении сообщения.
  1. Чтобы перенаправлять недоставленные сообщения в [очередь недоставленных сообщений (DLQ)](../concepts/dlq.md), в блоке **Настройки очередей недоставленных сообщений**:
      * Включите опцию **Перенаправлять  недоставленные сообщения**.
      * Укажите **Очередь недоставленных  сообщений**.
      * Задайте **Максимальное количество  попыток чтения**.
  1.  Нажмите кнопку **Создать**.

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
     * `--endpoint` — эндпоинт в значении `https://message-queue.api.cloud.yandex.net/`.
      
     Результат:

     ```json
     {
         "QueueUrl": "https://message-queue.api.cloud.yandex.net/aoeaql9r10cd********/000000000000********/sample-queue"
     }
     ```

- Terraform {#tf}

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

{% endlist %}


При достижении лимита на максимальное количество очередей, возникает ошибка `Cannot create queue: Too many queues`. Для увеличения лимита обратитесь в [техническую поддержку](https://center.yandex.cloud/support).