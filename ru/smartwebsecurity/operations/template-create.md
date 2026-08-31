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
  1. Введите **{{ ui-key.yacloud.smart-web-security.custom-pages.context_name }}** — имя файла, который будет возвращаться в ответ на запрос клиента.

      Имя может быть от 1 до 50 символов, содержать строчные и заглавные буквы латинского алфавита, цифры, дефисы, нижние подчеркивания и точки. Первый символ — буква или цифра.

  1. (Опционально) Введите описание шаблона.
  1. Выберите **{{ ui-key.yacloud.smart-web-security.custom-pages.label_status_code }}** — один из стандартных [HTTP-кодов ответов](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml), для которого клиенту будет возвращена страница по вашему шаблону.
  1. Выберите **{{ ui-key.yacloud.smart-web-security.custom-pages.label_format }}**: `HTML`, `JSON`, `XML` или `Custom`.

      Каждому из форматов будет соответствовать свой HTTP-заголовок [Content-Type](https://www.rfc-editor.org/rfc/rfc9110.html#name-content-type): `text/html`, `application/json`, `application/xml`. Чтобы указать произвольный заголовок, выберите `Custom`.

  1. Для формата `Custom` введите **{{ ui-key.yacloud.smart-web-security.custom-pages.label_content_type }}**. Например, `text/plain`.
  1. (Опционально) Чтобы добавить к ответу HTTP-заголовок, нажмите **{{ ui-key.yacloud.smart-web-security.CustomPageForm.add_header_8Zgm9 }}** и укажите параметры:

      * **{{ ui-key.yacloud.common.label_key }}** — название HTTP-заголовка, например: `User-Agent`, `Host`.
      * **{{ ui-key.yacloud.common.value }}**, например: `Mozilla/5.0 (...)`, `example.com`.

      Можно добавить не более 10 заголовков. Заголовки Content-Type и Content-Length добавить нельзя, задать Content-Type можно в отдельном поле для формата `Custom`.

  1. Введите **{{ ui-key.yacloud.smart-web-security.custom-pages.label_body }}** — содержимое страницы, которое будет возвращено клиенту. Объем ответа должен быть не более `2 КБ` (примерно 2000 символов в кодировке UTF-8).

      {% include [template-body-response](../../_includes/smartwebsecurity/template-body-response.md) %}

  1. (Опционально) Добавьте в тело ответа дополнительные параметры, выбрав нужный пресет: **{{ ui-key.yacloud.smart-web-security.CustomPageForm.preset_unique_key_j7Rw2 }}**, **{{ ui-key.yacloud.smart-web-security.CustomPageForm.preset_client_ip_m4Np5 }}**, **{{ ui-key.yacloud.smart-web-security.CustomPageForm.preset_request_time_k9Lx1 }}**.

      Эти данные могут быть полезны, например, при обращении клиента в поддержку.

      {% include [template-body-presets](../../_includes/smartwebsecurity/template-body-presets.md) %}

  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

  Чтобы увидеть итоговую страницу на стороне клиента, на странице шаблона нажмите ![eye](../../_assets/console-icons/eye.svg) **{{ ui-key.yacloud.smart-web-security.CustomPagesActions.label_view_tJsLT }}**.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](template-attach.md)
* [{#T}](../concepts/response-templates.md)
