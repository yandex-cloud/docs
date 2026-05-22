### Создайте задачу {#create-task}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится функция `ffmpeg-api`.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию `ffmpeg-api`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** введите:

     ```json
     {"action":"convert", "src_url":"<ссылка_на_видео>"}
     ```

     Где `<ссылка_на_видео>` — ссылка на сохраненный на [Яндекс Диске](https://disk.yandex.ru) видеофайл в формате [MP4](https://ru.wikipedia.org/wiki/MPEG-4_Part_14).

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** отобразится идентификатор задачи:

     ```json
     { "task_id": "c4269ceb-8d3a-40fe-95f0-84cf********" }
     ```

{% endlist %}

### Посмотрите статистику очереди {#ymq-stat}

После создания задачи число сообщений в очереди увеличивается на один, и срабатывает триггер. Проверьте, что сообщения поступают в очередь и обрабатываются. Для этого посмотрите статистику очереди.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится очередь `converter-queue`.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
  1. Выберите очередь `converter-queue`.
  1. В блоке **{{ ui-key.yacloud.ymq.queue.overview.section_base }}** отображается количество сообщений в очереди и в обработке.
  1. Перейдите в раздел **{{ ui-key.yacloud.common.monitoring }}**. Посмотрите графики **Overall queue stats**.

{% endlist %}

### Посмотрите логи функции {#function-logs}

Триггер должен вызывать функцию-конвертер для каждого сообщения в очереди. Чтобы проверить, что функция вызывается, посмотрите ее логи.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится функция `ffmpeg-converter`.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию `ffmpeg-converter`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_logs }}** и укажите период, за который хотите посмотреть логи.

{% endlist %}

### Получите ссылку на GIF-файл {#get-link}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится функция `ffmpeg-api`.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию `ffmpeg-api`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** введите запрос:

     ```json
     {"action":"get_task_status", "task_id":"<идентификатор_задачи>"}
     ```

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
  1. Если конвертация видео в GIF-файл не завершилась, в поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** отобразится ответ:

     ```json
     {
         "ready": false
     }
     ```

     В противном случае вы получите ссылку на GIF-файл:

     ```json
     {
         "ready": true,
         "gif_url": "https://{{ s3-storage-host }}/<имя_бакета>/1b4db1a6-f2b2-4b1c-b662-37f7********.gif?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=qxLftbbZ91U695ysemyZ%2F202********{{ region-id }}%2Fs3%2Faws4_request&X-Amz-Date=20210831T110351Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=f4a5fe7848274a09be5b221fbf8a9f6f2b385708cfa351861a4e69df********"
     }
     ```

{% endlist %}