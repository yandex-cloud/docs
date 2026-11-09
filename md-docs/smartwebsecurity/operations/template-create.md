[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Шаблоны ответов > Создать шаблон

# Создать шаблон страницы ответа

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать шаблон.
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![square-article](../../_assets/console-icons/square-article.svg) **Шаблоны ответов** и нажмите **Создать шаблон**.
  1. Введите **Имя страницы** — имя шаблона.

      Имя должно содержать от 1 до 50 символов: строчные и заглавные латинские буквы, цифры, дефисы, нижние подчеркивания и точки. Первый символ — буква или цифра.

  1. (Опционально) Введите описание шаблона.
  1. Выберите **Код ответа** — [HTTP-код](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml), который будет возвращаться клиенту при использовании шаблона.
  1. Выберите **Формат ответа**: `HTML`, `JSON`, `XML` или `Custom`.

      Форматам `HTML`, `JSON` и `XML` соответствуют значения HTTP-заголовка [Content-Type](https://www.rfc-editor.org/rfc/rfc9110.html#name-content-type): `text/html`, `application/json` и `application/xml`. Чтобы указать другое значение, выберите `Custom`.

  1. Для формата `Custom` введите **Content-Type**. Например, `text/plain`.
  1. (Опционально) Чтобы добавить к ответу HTTP-заголовок, нажмите **Добавить заголовок ответа** и укажите параметры:

      * **Ключ** — название HTTP-заголовка, например `Cache-Control`.
      * **Значение** — значение заголовка, например `no-store`, чтобы запретить кеширование ответа.

      Можно добавить не более десяти заголовков. Не добавляйте заголовки `Content-Type` и `Content-Length`: значение `Content-Type` задается при выборе формата ответа.

  1. Введите **Тело ответа** — содержимое страницы, которое будет возвращено клиенту. Размер тела ответа не должен превышать 2 КБ.

      Содержимое ответа должно соответствовать выбранному формату ответа, например:
      
      * `HTML`
      
          ```html
          <!doctype html>
          <html lang="ru">
          <head><meta charset="utf-8"><title>403 Forbidden</title></head>
          <body><h1>403 Forbidden</h1><p>Доступ ограничен.</p></body>
          </html>
          ```
      
      * `JSON`
      
          ```json
          {
          "error": {
              "code": 403,
              "message": "Доступ ограничен.",
              "details": "Недостаточно прав для выполнения операции."
          }
          }
          ```
      
      * `XML`
      
          ```xml
          <?xml version="1.0" encoding="UTF-8"?>
          <error>
          <code>403</code>
          <message>Доступ ограничен.</message>
          <details>Недостаточно прав для выполнения операции.</details>
          </error>
          ```

  1. (Опционально) Добавьте в тело ответа дополнительные параметры, выбрав нужный пресет: **ID запроса**, **IP-адрес**, **Время запроса**.

      Эти данные могут быть полезны, например, при обращении клиента в поддержку.

      Пример страницы с дополнительными параметрами:
      
      ```html
      <!doctype html>
      <html lang="ru">
      <head><meta charset="utf-8"><title>403 Forbidden</title></head>
      <body>
      <h1>403 Forbidden</h1>
      <p>Доступ ограничен. Если вы считаете блокировку ошибочной, передайте в поддержку следующие данные:</p>
      <p>Идентификатор запроса: %unique_key%</p>
      <p>IP-адрес: %client_ip%</p>
      <p>Время запроса: %request_time%</p>
      <p>Контакты: security@example.com</p>
      </body>
      </html>
      ```

  1. Нажмите **Создать**.

  Чтобы посмотреть предварительный вид страницы ответа, на странице шаблона нажмите ![eye](../../_assets/console-icons/eye.svg) **Просмотр**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды создания шаблона:

     ```bash
     yc smartwebsecurity custom-page custom-page create --help
     ```

  1. Создайте шаблон. Например, чтобы возвращать HTML-страницу с кодом `403 Forbidden`, выполните команду:

     ```bash
     yc smartwebsecurity custom-page custom-page create \
       --folder-id <идентификатор_каталога> \
       --name error.html \
       --content '<!doctype html>
     <html lang="ru">
     <head><meta charset="utf-8"><title>403 Forbidden</title></head>
     <body><h1>Доступ ограничен.</h1></body>
     </html>' \
       --content-type text/html \
       --status-code forbidden
     ```

     Где:

     * `--folder-id` — идентификатор каталога, в котором будет создан шаблон. Можно не указывать, если каталог задан в профиле CLI.
     * `--name` — имя шаблона.
     * `--content` — тело ответа размером не более 2 КБ. Содержимое должно соответствовать формату, указанному в `--content-type`.
     * `--content-type` — значение HTTP-заголовка `Content-Type`, например `text/html`, `application/json` или `text/plain`.
     * `--status-code` — один из стандартных [HTTP-кодов ответов](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml). Укажите его имя в формате CLI: например, `forbidden` для `403` или `too-many-requests` для `429`. Полный список допустимых значений приведен в описании параметра `--status-code` в [справочнике команды](../../cli/cli-ref/smartwebsecurity/cli-ref/custom-page/custom-page/create.md).

     Дополнительно можно указать описание в `--description`, метки ресурса в `--labels` и не более десяти HTTP-заголовков ответа в `--headers`. Например, `--headers Cache-Control=no-store` запрещает кеширование ответа. Заголовок `Content-Type` задавайте через `--content-type`, а `Content-Length` не добавляйте.

     В теле ответа можно использовать [динамические параметры](../concepts/response-templates.md#body-response): идентификатор запроса, IP-адрес клиента и время запроса.

- API {#api}

    Воспользуйтесь методом REST API [create](../custom_page/api-ref/CustomPage/create.md) для ресурса [CustomPage](../custom_page/api-ref/CustomPage/index.md) или вызовом gRPC API [CustomPageService/Create](../custom_page/api-ref/grpc/CustomPage/create.md).

    В запросе передайте параметры шаблона:

    * `folderId` (в gRPC — `folder_id`) — идентификатор каталога. Обязательное поле.
    * `name` — имя шаблона.
    * `content` — тело ответа размером не более 2 КБ.
    * `contentType` (в gRPC — `content_type`) — значение HTTP-заголовка `Content-Type`, соответствующее формату тела ответа.
    * `statusCode` (в gRPC — `status_code`) — HTTP-код ответа. Используйте значение перечисления, например `FORBIDDEN` для `403` или `TOO_MANY_REQUESTS` для `429`.

    При необходимости добавьте описание в поле `description`, метки ресурса в `labels` и не более десяти HTTP-заголовков ответа в `headers`. Например, `"headers": {"Cache-Control": "no-store"}` запрещает кеширование ответа. Не добавляйте в `headers` заголовки `Content-Type` и `Content-Length`.

    В теле ответа можно использовать [динамические параметры](../concepts/response-templates.md#body-response): идентификатор запроса, IP-адрес клиента и время запроса.

{% endlist %}

Чтобы использовать созданный шаблон, [добавьте его к профилю или правилу](template-attach.md).

#### Полезные ссылки {#see-also}

* [Добавить шаблон страницы ответа к профилю или правилу](template-attach.md)
* [Шаблоны страниц ответов](../concepts/response-templates.md)