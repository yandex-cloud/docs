---
title: Управление шаблонами страниц ответов в {{ sws-full-name }}
description: Следуя этой инструкции, вы сможете получить информацию о шаблоне страницы ответа, изменить или удалить его в {{ sws-name }}.
---

# Управлять шаблоном страницы ответа

## Изменить шаблон {#change-template}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с шаблоном.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![square-article](../../_assets/console-icons/square-article.svg) **{{ ui-key.yacloud.smart-web-security.customPages_rriaz }}**.
  1. В строке с нужным шаблоном нажмите ![options](../../_assets/console-icons/ellipsis.svg) → ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. В открывшемся окне измените параметры:

      * **{{ ui-key.yacloud.smart-web-security.custom-pages.context_name }}**.
      * **{{ ui-key.yacloud.smart-web-security.CustomPageForm.field_description_vtia9 }}**.
      * **{{ ui-key.yacloud.smart-web-security.custom-pages.label_status_code }}** — [HTTP-код](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml), который будет возвращаться клиенту при использовании шаблона.
      * **{{ ui-key.yacloud.smart-web-security.custom-pages.label_format }}**: `HTML`, `JSON`, `XML` или `Custom`.

          Форматам `HTML`, `JSON` и `XML` соответствуют значения HTTP-заголовка [Content-Type](https://www.rfc-editor.org/rfc/rfc9110.html#name-content-type): `text/html`, `application/json` и `application/xml`.

          Чтобы указать другое значение, выберите `Custom` и измените **{{ ui-key.yacloud.smart-web-security.custom-pages.label_content_type }}**.

      * Чтобы добавить HTTP-заголовок, нажмите **{{ ui-key.yacloud.smart-web-security.CustomPageForm.add_header_8Zgm9 }}** и укажите его **{{ ui-key.yacloud.common.label_key }}** (название заголовка) и **{{ ui-key.yacloud.common.value }}**. Для одного шаблона можно добавить не более десяти заголовков. Не добавляйте `Content-Type` и `Content-Length`: значение `Content-Type` задается при выборе формата ответа.

          Чтобы удалить заголовок, нажмите ![options](../../_assets/console-icons/xmark.svg) напротив его строки.

      * **{{ ui-key.yacloud.smart-web-security.custom-pages.label_body }}** — измените содержимое страницы, которое будет возвращено клиенту. Размер тела ответа не должен превышать 2 КБ, а содержимое должно соответствовать выбранному формату.
      * Добавьте или удалите из тела ответа пресеты — дополнительные параметры, которые могут передаваться клиенту на странице ответа.

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

  Чтобы посмотреть предварительный вид страницы ответа, на странице шаблона нажмите ![eye](../../_assets/console-icons/eye.svg) **{{ ui-key.yacloud.smart-web-security.CustomPagesActions.label_view_tJsLT }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды изменения шаблона:

     ```bash
     yc smartwebsecurity custom-page custom-page update --help
     ```

  1. [Получите идентификатор шаблона](#get-template-info).
  1. Измените нужные параметры. Например, чтобы заменить тело ответа и его формат, выполните команду:

     ```bash
     yc smartwebsecurity custom-page custom-page update \
       --id <идентификатор_шаблона> \
       --content '{"message":"Доступ ограничен. Обратитесь в поддержку: support@example.com."}' \
       --content-type application/json
     ```

     Где:

     * `--id` — идентификатор шаблона. Обязательный параметр.
     * `--content` — новое тело ответа размером не более 2 КБ.
     * `--content-type` — значение HTTP-заголовка `Content-Type`, соответствующее формату тела ответа.

     Укажите только параметры, которые нужно изменить: CLI автоматически сформирует маску обновления. Остальные параметры сохранятся. Описания параметров шаблона приведены в [инструкции по созданию](template-create.md).

- API {#api}

    Воспользуйтесь методом REST API [update](../custom_page/api-ref/CustomPage/update.md) для ресурса [CustomPage](../custom_page/api-ref/CustomPage/index.md) или вызовом gRPC API [CustomPageService/Update](../custom_page/api-ref/grpc/CustomPage/update.md).

    Передайте идентификатор шаблона в `customPageId` (в gRPC — `custom_page_id`) и новые значения полей. Перечислите изменяемые поля в маске обновления: `updateMask` для REST API или `update_mask` для gRPC API. Например, чтобы изменить только тело ответа, передайте новое значение `content` и включите `content` в маску.

    {% note warning %}

    Без маски обновления неуказанные поля будут сброшены к значениям по умолчанию.

    {% endnote %}

{% endlist %}

## Получить информацию о шаблоне {#get-template-info}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с шаблоном.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![square-article](../../_assets/console-icons/square-article.svg) **{{ ui-key.yacloud.smart-web-security.customPages_rriaz }}**.
  1. Выберите нужный шаблон.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о шаблоне.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команд получения списка шаблонов и информации об отдельном шаблоне:

     ```bash
     yc smartwebsecurity custom-page custom-page list --help
     yc smartwebsecurity custom-page custom-page get --help
     ```

  1. Получите список шаблонов в каталоге:

     ```bash
     yc smartwebsecurity custom-page custom-page list \
       --folder-id <идентификатор_каталога>
     ```

     `--folder-id` — идентификатор каталога с шаблонами. Можно не указывать, если каталог задан в профиле CLI.

  1. Получите информацию о нужном шаблоне, указав его идентификатор из списка:

     ```bash
     yc smartwebsecurity custom-page custom-page get \
       --id <идентификатор_шаблона>
     ```

     `--id` — идентификатор шаблона. Вместо него можно указать имя шаблона в параметре `--name`.

- API {#api}

    1. Чтобы получить список шаблонов в каталоге, воспользуйтесь методом REST API [list](../custom_page/api-ref/CustomPage/list.md) для ресурса [CustomPage](../custom_page/api-ref/CustomPage/index.md) или вызовом gRPC API [CustomPageService/List](../custom_page/api-ref/grpc/CustomPage/list.md). Передайте идентификатор каталога в `folderId` (в gRPC — `folder_id`).
    1. Чтобы получить информацию об отдельном шаблоне, воспользуйтесь методом REST API [get](../custom_page/api-ref/CustomPage/get.md) для ресурса [CustomPage](../custom_page/api-ref/CustomPage/index.md) или вызовом gRPC API [CustomPageService/Get](../custom_page/api-ref/grpc/CustomPage/get.md). Передайте идентификатор шаблона в `customPageId` (в gRPC — `custom_page_id`).

{% endlist %}

## Удалить шаблон {#delete-template}

Перед удалением [замените шаблон](template-attach.md) в профилях безопасности, профилях ARL и их правилах, где он используется. Пока шаблон добавлен в профиль или правило, удалить его нельзя.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с шаблоном.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![square-article](../../_assets/console-icons/square-article.svg) **{{ ui-key.yacloud.smart-web-security.customPages_rriaz }}**.
  1. В строке с нужным шаблоном нажмите ![options](../../_assets/console-icons/ellipsis.svg) → ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

      Если шаблон еще используется, при попытке удаления появится список объектов с этим шаблоном. Перейдите в настройки каждого объекта и выберите другой шаблон.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды удаления шаблона:

     ```bash
     yc smartwebsecurity custom-page custom-page delete --help
     ```

  1. [Получите идентификатор шаблона](#get-template-info).
  1. Удалите шаблон:

     ```bash
     yc smartwebsecurity custom-page custom-page delete \
       --id <идентификатор_шаблона>
     ```

     `--id` — идентификатор шаблона. Вместо него можно указать имя шаблона в параметре `--name`.

- API {#api}

    Воспользуйтесь методом REST API [delete](../custom_page/api-ref/CustomPage/delete.md) для ресурса [CustomPage](../custom_page/api-ref/CustomPage/index.md) или вызовом gRPC API [CustomPageService/Delete](../custom_page/api-ref/grpc/CustomPage/delete.md). Передайте идентификатор шаблона в `customPageId` (в gRPC — `custom_page_id`).

{% endlist %}
