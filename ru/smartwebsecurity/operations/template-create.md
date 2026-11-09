---
title: Как создать шаблон ответа
description: Следуя данной инструкции, вы сможете создать собственный шаблон для ответа на запрос клиента.
---

# Создать шаблон страницы ответа

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать шаблон.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![square-article](../../_assets/console-icons/square-article.svg) **{{ ui-key.yacloud.smart-web-security.customPages_rriaz }}** и нажмите **{{ ui-key.yacloud.smart-web-security.createCustomPage_t4SuU }}**.
  1. Введите **{{ ui-key.yacloud.smart-web-security.custom-pages.context_name }}** — имя шаблона.

      Имя должно содержать от 1 до 50 символов: строчные и заглавные латинские буквы, цифры, дефисы, нижние подчеркивания и точки. Первый символ — буква или цифра.

  1. (Опционально) Введите описание шаблона.
  1. Выберите **{{ ui-key.yacloud.smart-web-security.custom-pages.label_status_code }}** — [HTTP-код](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml), который будет возвращаться клиенту при использовании шаблона.
  1. Выберите **{{ ui-key.yacloud.smart-web-security.custom-pages.label_format }}**: `HTML`, `JSON`, `XML` или `Custom`.

      Форматам `HTML`, `JSON` и `XML` соответствуют значения HTTP-заголовка [Content-Type](https://www.rfc-editor.org/rfc/rfc9110.html#name-content-type): `text/html`, `application/json` и `application/xml`. Чтобы указать другое значение, выберите `Custom`.

  1. Для формата `Custom` введите **{{ ui-key.yacloud.smart-web-security.custom-pages.label_content_type }}**. Например, `text/plain`.
  1. (Опционально) Чтобы добавить к ответу HTTP-заголовок, нажмите **{{ ui-key.yacloud.smart-web-security.CustomPageForm.add_header_8Zgm9 }}** и укажите параметры:

      * **{{ ui-key.yacloud.common.label_key }}** — название HTTP-заголовка, например `Cache-Control`.
      * **{{ ui-key.yacloud.common.value }}** — значение заголовка, например `no-store`, чтобы запретить кеширование ответа.

      Можно добавить не более десяти заголовков. Не добавляйте заголовки `Content-Type` и `Content-Length`: значение `Content-Type` задается при выборе формата ответа.

  1. Введите **{{ ui-key.yacloud.smart-web-security.custom-pages.label_body }}** — содержимое страницы, которое будет возвращено клиенту. Размер тела ответа не должен превышать 2 КБ.

      {% include [template-body-response](../../_includes/smartwebsecurity/template-body-response.md) %}

  1. (Опционально) Добавьте в тело ответа дополнительные параметры, выбрав нужный пресет: **{{ ui-key.yacloud.smart-web-security.CustomPageForm.preset_unique_key_j7Rw2 }}**, **{{ ui-key.yacloud.smart-web-security.CustomPageForm.preset_client_ip_m4Np5 }}**, **{{ ui-key.yacloud.smart-web-security.CustomPageForm.preset_request_time_k9Lx1 }}**.

      Эти данные могут быть полезны, например, при обращении клиента в поддержку.

      {% include [template-body-presets](../../_includes/smartwebsecurity/template-body-presets.md) %}

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

  Чтобы посмотреть предварительный вид страницы ответа, на странице шаблона нажмите ![eye](../../_assets/console-icons/eye.svg) **{{ ui-key.yacloud.smart-web-security.CustomPagesActions.label_view_tJsLT }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

* [{#T}](template-attach.md)
* [{#T}](../concepts/response-templates.md)
