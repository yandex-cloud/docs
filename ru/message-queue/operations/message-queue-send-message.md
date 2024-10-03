---
title: "Как отправлять сообщения в {{ message-queue-full-name }}"
description: "Следуя данной инструкции, вы сможете отправлять сообщения." 
---

# Отправка сообщений

Сообщения передаются через [очереди сообщений](../concepts/queue.md) {{ message-queue-name }} и могут содержать в теле обычный текст. Потребители получают сообщения и удаляют их из очереди после получения и обработки.

Чтобы отправить сообщение в очередь:

1. Если у вас еще нет очереди сообщений {{ message-queue-name }}, [создайте](message-queue-new-queue.md) ее.
1. Выполните в терминале команду:

   {% list tabs group=programming_language %}
   
   - AWS CLI {#aws_cli}
   
     ```bash
     aws sqs send-message \
       --message-body "<текст_сообщения>" \
       --endpoint <эндпоинт> \
       --queue-url <URL_очереди>
     ```
   
     Где:
   
     * `--message-body` — текст отправляемого в очередь сообщения, например, `Hello World`.
     * `--endpoint` — эндпоинт в значении `https://message-queue.{{ api-host }}/`.
     * `--queue-url` — URL очереди, в которую будет отправлено сообщение.
     
     Результат:
   
     ```json
     {
         "MD5OfMessageBody": "67e63db14341b5a696596634********", 
         "MessageId": "765ff4d2-fa4bc83-6cfcc***-*****"
     }
     ```
   
   - cURL {#curl}
   
     ```bash
     curl \
       --request POST \
       --header 'Content-Type: application/x-www-form-urlencoded' \
       --data-urlencode 'Action=SendMessage' \
       --data-urlencode 'MessageBody=<текст_сообщения>' \
       --data-urlencode 'QueueUrl=<URL_очереди_сообщений>' \
       --user '<идентификатор_ключа_доступа>:<секретный_ключ>' \
       --aws-sigv4 'aws:amz:{{ region-id }}:sqs' \
       https://message-queue.{{ api-host }}/
     ```
   
     Где:
   
     * `--header` — заголовки HTTP-запроса.
     * `--data-urlencode` — параметры для [формирования запроса к API](../api-ref/index.md).
       * `MessageBody` — текст отправляемого в очередь сообщения.
       * `QueueURL` — URL очереди, в которую будет отправлено сообщение.
     * `--user` — компоненты [статического ключа](../../iam/concepts/authorization/access-key.md): идентификатор и секретный ключ.
     * `--aws-sigv4` — параметр для формирования AWS-совместимых заголовков авторизации.
   
     Результат:
   
     ```text
     <?xml version="1.0" encoding="UTF-8"?>
     <SendMessageResponse><SendMessageResult><MD5OfMessageBody>fa46dfdbe2396ac930bfa896********</MD5OfMessageBody><MessageId>31bebd6e-5b61e482-7aaaa45a***-*****</MessageId></SendMessageResult><ResponseMetadata><RequestId>7c65c427-be26a31a-cf93dee9-dd4989d8-ab97b54614e49d7fe560b779********</RequestId></ResponseMetadata></SendMessageResponse>
     ```
   
   {% endlist %}
