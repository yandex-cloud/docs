---
title: Как с нуля создать MCP-сервер в {{ mcp-hub-name }}
description: Следуя данной инструкции, вы научитесь с нуля создавать собственные MCP-серверы в {{ mcp-hub-name }} через интерфейс {{ foundation-models-full-name }}.
---

# Создать MCP-сервер в {{ mcp-hub-name }} с нуля

{% include [note-preview](../../../_includes/note-preview.md) %}

В [{{ mcp-hub-name }}](../../concepts/mcp-hub/index.md) вы можете с нуля создавать новые MCP-серверы, содержащие такие инструменты, как HTTPS-запрос к внешнему API, [функция](../../../functions/concepts/function.md) {{ sf-full-name }} или [рабочий процесс](../../../serverless-integrations/concepts/workflows/workflow.md) {{ sw-full-name }}.

Чтобы создать новый MCP-сервер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть [роль](../../security/index.md#serverless-mcpGateways-editor) `serverless.mcpGateways.editor` или выше.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_foundation-models }}**.
  1. На панели слева выберите ![logo-mcp](../../../_assets/console-icons/logo-mcp.svg) **MCP-серверы** и нажмите кнопку **Создать MCP-сервер**. В открывшемся окне:

      1. В блоке **Способ добавления** выберите опцию ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **Создать**.
      1. В блоке **Инструменты** выберите [тип](../../concepts/mcp-hub/index.md#brand-new) добавляемого в MCP-сервер инструмента — `HTTPS-запросы`, `{{ sf-name }}` или `{{ sw-name }}`:

          {% list tabs %}

          - HTTPS-запросы

            1. В поле **Имя инструмента** задайте имя для создаваемого инструмента. Требования к имени:

                {% include [name-format](../../../_includes/name-format.md) %}

            1. В поле **Инструкция для агента** задайте обязательное текстовое описание инструмента. Описание должно содержать информацию об условиях, при которых AI-агент должен использовать этот инструмент. Например:

                ```text
                Инструмент для создания тикетов в корпоративной системе обработки задач. Используй этот 
                инструмент, чтобы регистрировать жалобы клиентов, запросы на получение консультаций, отчеты 
                об ошибках. При использовании инструмента задавай параметры queue, type, priority и summary. 
                В параметре queue (имя очереди) всегда передавай константу SUPPORT. В параметре type (тип 
                обращения) передавай одно из значений: bug (отчет об ошибке), complaint (жалоба клиента) или 
                support-request (запрос на получение консультации). В параметре priority (приоритет) 
                передавай одно из значений: low (низкий), medium (средний) или high (высокий). В параметре 
                summary передавай значение в виде текста, описывающего суть обращения словами пользователя.
                ```
            1. В поле **URL** укажите эндпоинт, на который будет отправляться HTTPS-запрос.

                Чтобы указать query-параметры в URL, используйте синтаксис jq. Например: `{{ link-console-main }}/folders/\(.folder-id)`.
            1. В поле **Метод** выберите метод запроса: `GET`, `POST`, `DELETE`, `PATCH`, `OPTIONS` или `HEAD`.
            1. Разверните блок **Дополнительные параметры** и укажите аутентификационные данные, которые будут передаваться в HTTPS-запросах:

                {% include [create-server-console-auth-params](../../../_includes/ai-studio/mcp-hub/create-server-console-auth-params.md) %}

            1. {% include [create-server-console-tool-params](../../../_includes/ai-studio/mcp-hub/create-server-console-tool-params.md) %}
            1. В блоке **Параметры HTTPS-запроса** настройте параметры HTTPS-запросов:

                * В секции **Заголовки запроса** укажите имена и значения заголовков, которые будут передаваться в запросах.
                * В секции **Query-параметры** задайте имена и значения параметров, которые будут передаваться в запросе.
                * В секции **Тело запроса** посмотрите пример получившегося запроса и при необходимости скорректируйте его.

                    {% include [empty-request-body](../../../_includes/ai-studio/mcp-hub/empty-request-body.md) %}

                    Параметры поддерживают шаблонизацию — их значения могут генерироваться динамически. Язык шаблонизации — `jq`. Подробнее см. в [документации jq](https://jqlang.github.io/jq/manual/).

                    Например: значение `\(.city)` параметра HTTPS-запроса будет взято из параметра инструмента `city`. Также при помощи конструкции `Bearer \(.token)` для заголовка `Authorization` вы сможете настроить авторизацию с использованием токена, переданного в параметре инструмента.

          - {{ sf-name }}

            1. В поле **Имя инструмента** задайте имя для создаваемого инструмента. Требования к имени:

                {% include [name-format](../../../_includes/name-format.md) %}

            1. В поле **Инструкция для агента** задайте обязательное текстовое описание инструмента. Описание должно содержать информацию об условиях, при которых AI-агент должен использовать этот инструмент. Например:

                ```text
                Инструмент распознает текст на изображении, передаваемом в кодировке base64. В распознанном 
                тексте инструмент выделяет пары "артикул":"количество" и возвращает в формате JSON-структуры.
                ```
            1. В поле **Функция** выберите [функцию](../../../functions/concepts/function.md) {{ sf-name }}, которая будет выполнять обработку запросов, и ее [версию](../../../functions/concepts/function.md#version).
            1. {% include [create-server-console-tool-params](../../../_includes/ai-studio/mcp-hub/create-server-console-tool-params.md) %}

            {% include [empty-request-body](../../../_includes/ai-studio/mcp-hub/empty-request-body.md) %}

          - {{ sw-name }}

            1. В поле **Имя инструмента** задайте имя для создаваемого инструмента. Требования к имени:

                {% include [name-format](../../../_includes/name-format.md) %}

            1. В поле **Инструкция для агента** задайте обязательное текстовое описание инструмента. Описание должно содержать информацию об условиях, при которых AI-агент должен использовать этот инструмент. Например:

                ```text
                Инструмент вызывает рабочий процесс для автоматической суммаризации длинного текста. Передает 
                исходный текст, максимальную длину суммаризации и язык.
                ```
            1. В поле **Рабочий процесс** выберите [рабочий процесс](../../../serverless-integrations/concepts/workflows/workflow.md) {{ sw-name }}, который будет выполнять обработку запросов.
            1. {% include [create-server-console-tool-params](../../../_includes/ai-studio/mcp-hub/create-server-console-tool-params.md) %}

            {% include [empty-request-body](../../../_includes/ai-studio/mcp-hub/empty-request-body.md) %}

          {% endlist %}

      1. Чтобы добавить в MCP-сервер дополнительный инструмент, нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **Добавить инструмент**.

          {% include [server-tool-number-notice](../../../_includes/ai-studio/mcp-hub/server-tool-number-notice.md) %}

      1. В блоке **Параметры сервера**:

          1. {% include [create-server-console-general-params-ss1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss1.md) %}
          1. {% include [create-server-console-general-params-ss2](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss2.md) %}
          1. {% include [create-server-console-general-params-ss3](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss3.md) %}
          1. {% include [create-server-console-general-params-ss4](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss4.md) %}
          1. {% include [create-server-console-general-params-ss4-1](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss4-1.md) %}
          1. {% include [create-server-console-general-params-ss5](../../../_includes/ai-studio/mcp-hub/create-server-console-general-params-ss5.md) %}
      1. Нажмите кнопку **Сохранить**.

{% endlist %}

{% include [server-creation-result-phrase](../../../_includes/ai-studio/mcp-hub/server-creation-result-phrase.md) %}

#### См. также {#see-also}

* [{#T}](../../concepts/mcp-hub/index.md)
* [{#T}](./connect-external.md)
* [{#T}](./create-from-template.md)
