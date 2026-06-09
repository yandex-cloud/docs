# Вызвать функцию

Чтобы любой пользователь мог вызывать функцию без передачи заголовка авторизации, [сделайте ее публичной](function-public.md). Подробнее о правах читайте в разделе [{#T}](../../security/index.md).

## Вызвать функцию {#invoking-function}

Для примера используется функция, описанная в разделе [{#T}](version-manage.md).

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.

    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. Выберите функцию.

    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.

    1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** укажите версию функции, которую хотите вызвать.

    1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload-template }}** выберите один из вариантов:

        * **{{ ui-key.yacloud.serverless-functions.item.testing.value_empty }}** — произвольный формат данных.
        * **{{ ui-key.yacloud.serverless-functions.item.testing.value_http-request }}** — формат данных для вызова функции, выступающей в качестве обработчика HTTPS-запросов. Подробнее см. в разделе [Концепции](../../concepts/function-invoke.md).
        * **{{ ui-key.yacloud.serverless-functions.item.testing.value_ymq-trigger }}** — формат данных для функции, которая вызывается триггером для обработки сообщений из очереди.
        * **{{ ui-key.yacloud.serverless-functions.item.testing.value_alice-skill }}** — формат данных для вызова функции, принимающей [запрос](https://yandex.ru/dev/dialogs/alice/doc/request.html) от платформы Яндекс Диалоги.

    1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** введите входные данные для тестирования функции.

    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.

    1. В разделе **{{ ui-key.yacloud.serverless-functions.item.testing.label_title-test-result }}** в поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}** будет показан статус тестирования. **Важно**: максимальное время выполнения функции до [таймаута](version-manage.md) (включая начальную инициализацию при первом запуске) — 10 минут.

    1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** появится результат выполнения функции.

- HTTPS {#https}

    {% note info %}
    
    Возможность вызова функции может быть ограничена [политиками авторизации](../../../iam/concepts/access-control/access-policies.md#supported-policies).
    
    {% endnote %}

    Вы можете найти ссылку для вызова функции:
    * в поле **{{ ui-key.yacloud.serverless-functions.item.overview.label_invoke-link }}**. Для этого в [консоли управления]({{ link-console-main }}) Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}** и нажмите на строку с нужной функцией.
    * в параметре `http_invoke_url`. Для этого выполните команду:
        ```
        yc serverless function get <имя_функции>
        ```

    Чтобы узнать имя или уникальный идентификатор функции, [получите](function-list.md) список функций в каталоге.

    Для обеспечения безопасности функцию можно вызвать только по протоколу HTTPS. Вызовите ее как обычный HTTPS-запрос, вставив ссылку в адресную строку браузера. Формат ссылки:

    ```
    https://{{ sf-url }}/<идентификатор_функции>
    ```
    
    Вы можете вызвать определенную версию функции с помощью параметра `tag`. По умолчанию вызывается функция с тегом `$latest`.

    * Пример вызова функции без дополнительных параметров:

        ```
        https://{{ sf-url }}/<идентификатор_функции>
        ```

        На странице появится ответ:

        ```
        Hello, World!
        ```

    * Пример вызова функции с добавлением в URL параметра `name`:

        ```
        https://{{ sf-url }}/<идентификатор_функции>?name=<имя_пользователя>
        ```

        На странице появится ответ:

        ```
        Hello, Username!
        ```
    * Пример вызова определенной версии функции с добавлением в URL параметра `tag`:
      
        ```
        https://{{ sf-url }}/<идентификатор_функции>?tag=<тег_версии>
        ```
            
- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Вы можете вызвать определенную версию функции с помощью параметра `--tag`. По умолчанию вызывается функция с тегом `$latest`.

    Чтобы узнать имя или уникальный идентификатор функции, [получите](function-list.md) список функций в каталоге.

    * Вызовите функцию, указав в параметре имя для приветствия:

        ```
        yc serverless function invoke <идентификатор_функции> -d '{"queryStringParameters": {"name": "Username"}}'
        ```

        Результат:

        ```    
        {"statusCode": 200, "headers": {"Content-Type": "text/plain"}, "isBase64Encoded": false, "body": "Hello, Username!"}
        ```
    * Вызовите определенную версию функции с помощью параметра `--tag`:
    
        ```
        yc serverless function invoke <идентификатор_функции> --tag <тег_версии>
        ```


{% endlist %}

Подробнее о том, какая должна быть структура функции для вызова разными способами (HTTPS, CLI), читайте в разделе [{#T}](../../concepts/function-invoke.md).