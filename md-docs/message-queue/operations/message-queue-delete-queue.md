# Удаление очереди сообщений

Чтобы удалить очередь сообщений:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит очередь.
  1. Перейдите в сервис **Message Queue**.
  1. В строке нужной очереди нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.
  
- AWS CLI {#cli}
  
  1. Получите URL очереди сообщений, которую нужно удалить:
  
     ```bash
     aws sqs list-queues \
       --endpoint <эндпойнт>
     ```

     Где `--endpoint` — эндпоинт в значении `https://message-queue.api.cloud.yandex.net/`.

  2. Удалите очередь сообщений:
  
     ```bash
     aws sqs delete-queue \
       --queue-url <URL_очереди> \
       --endpoint <эндпоинт>
     ```

     Где:
     * `--queue-url` — URL очереди, которую нужно удалить.
     * `--endpoint` — эндпоинт в значении `https://message-queue.api.cloud.yandex.net/`.

- Terraform {#tf}

  Если вы создавали очередь сообщений с помощью Terraform, вы можете удалить ее:
  1. В командной строке перейдите в папку, где расположен конфигурационный файл Terraform.
  1. Удалите ресурсы с помощью команды:

     ```bash
     terraform destroy
     ```

     {% note alert %}

     Terraform удалит все ресурсы, созданные в текущей конфигурации: кластеры, сети, подсети, виртуальные машины и т. д.

     {% endnote %}

  1. Введите слово `yes` и нажмите **Enter**.

{% endlist %}