# Удаление очереди сообщений

Чтобы удалить очередь сообщений:

{% list tabs %}

- Консоль управления
  
  1. Откройте раздел **Message Queue**.
  1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) в строке очереди, которую требуется удалить.
  1. В открывшемся меню нажмите кнопку **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.
  
- AWS CLI
  
  Выполните в терминале команду:
  
  ```
  $ aws sqs delete-queue \
              --queue-url https://message-queue.api.cloud.yandex.net/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue \
              --endpoint https://message-queue.api.cloud.yandex.net/      
  ```
  
  
  
{% endlist %}
