# Мониторинг процессов в очереди

Вы можете отслеживать процесс работы с сообщениями в очередях с помощью инструментов мониторинга в консоли управления. Эти инструменты предоставляют диагностическую информацию в виде графиков.

Для просмотра информации:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит очередь с сообщениями.
  1. На странице каталога выберите сервис **{{ message-queue-name }}**.
  1. На панели слева выберите ![image](../../_assets/monitoring.svg) **Мониторинг**.

  На странице появятся секции с графиками.

{% endlist %}

## Отправка сообщений {#send}

Секция **Sent messages stats** содержит графики с информацией об отправке сообщений:

* **Sent messages, count** — количество сообщений, отправленных в очередь за единицу времени.

* **Sent messages, size** — общий размер сообщений, отправленных в очередь за единицу времени (в байтах).

* **SendMessage duration** — время выполнения запросов [SendMessage](../api-ref/message/SendMessage.md).

  {% include [ymq-monitoring-query-duration.md](../../_includes/message-queue/ymq-monitoring-query-duration.md) %}

* **SendMessageBatch duration** — время выполнения запросов [SendMessageBatch](../api-ref/message/SendMessageBatch.md).

  {% include [ymq-monitoring-query-duration.md](../../_includes/message-queue/ymq-monitoring-query-duration.md) %}

* **SendMessage errors** — количество ошибок выполнения запросов `SendMessage` и `SendMessageBatch`.

## Прием сообщений {#receive}

Секция **Received messages & processing stats** содержит графики с информацией о приеме и обработке сообщений:

* **Received messages, size** — общий размер сообщений, принятых из очереди за единицу времени (в байтах).

* **Received messages, count** — количество сообщений, принятых из очереди за единицу времени.

* **Messages in flight, count** — количество сообщений, которые приняты получателями, но не удалены из очереди (у которых не истек [таймаут видимости](../concepts/visibility-timeout.md)).

* **ReceiveMessages requests** — общее количество запросов [ReceiveMessage](../api-ref/message/ReceiveMessage) и количество запросов с пустым ответом.

  Пустой ответ на запрос означает, что за указанное время ожидания (атрибут `WaitTimeSeconds`) не появилось сообщений, доступных для чтения.
    
* **ReceiveMessages duration** — время выполнения запросов `ReceiveMessage`.

  {% include [ymq-monitoring-query-duration.md](../../_includes/message-queue/ymq-monitoring-query-duration.md) %}

* **ReceiveMessage errors** — количество ошибок выполнения запросов `ReceiveMessage`.

* **Message processing on client duration** — время обработки сообщений получателем.
      
  {% include [ymq-monitoring-message-duration.md](../../_includes/message-queue/ymq-monitoring-message-duration.md) %}

* **Receive attempts per message, count** — количество зафиксированных попыток получения сообщения.

  Значение увеличивается, если сообщение было принято получателем, но возвращено в очередь по истечении [таймаута видимости](../concepts/visibility-timeout.md). Линии на графике соответствуют количеству попыток получения:
  * 0-1;
  * 2;
  * 3-5;
  * более 5.

## Удаление сообщений {#delete}

Секция **Delete messages stats** содержит графики с информацией об удалении сообщений:
    
* **Deleted messages, count** — количество сообщений, удаленных из очереди за единицу времени с помощью методов [DeleteMessage](../api-ref/message/DeleteMessage) или [DeleteMessageBatch](../api-ref/message/DeleteMessageBatch).
* **DeleteMessage duration** — время выполнения запросов `DeleteMessage`.

  {% include [ymq-monitoring-query-duration.md](../../_includes/message-queue/ymq-monitoring-query-duration.md) %}

* **DeleteMessageBatch duration** — время выполнения запросов `DeleteMessageBatch`.

  {% include [ymq-monitoring-query-duration.md](../../_includes/message-queue/ymq-monitoring-query-duration.md) %}

* **DeleteMessage errors** — количество ошибок выполнения запросов `DeleteMessage` и `DeleteMessageBatch`.

* **Purged messages, count** — количество сообщений, удаленных из очереди за единицу времени с помощью метода очистки очереди [PurgeQueue](../api-ref/queue/PurgeQueue).

## Общие метрики очереди {#queue}

Секция **Overall queue stats** содержит графики с общей информацией о процессах в очереди:

* **Messages in queue, count** — количество сообщений в очереди в текущий момент.

* **Age of oldest message in queue** — время хранения наиболее раннего сообщения в очереди.

* **Message reside duration** — время обработки сообщений в очереди.
      
  {% include [ymq-monitoring-message-duration.md](../../_includes/message-queue/ymq-monitoring-message-duration.md) %}
