---
title: Добавить интеграцию с AI-агентом в рабочий процесс {{ sw-name }}
description: Следуя данной инструкции, вы сможете добавить интеграцию с AI-агентом в рабочий процесс {{ sw-full-name }} с помощью конструктора шагов рабочего процесса.
---

# Интеграция с AI-агентом

{% list tabs %}

- Консоль управления {#console}

  1. {% include [integrations-step1](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step1.md) %} 
  1. Из секции **{{ ui-key.yacloud.serverless-workflows.workflow-editor_integration-group-label }}** в левой части экрана перетащите элемент ![foundation-models-icon](../../../../_assets/foundation-models-icon.svg) **AI-агент** в нужное место рабочего процесса в окне конструктора.

      {% include [step-drag-destination-desc](../../../../_includes/serverless-integrations/workflows-constructor/step-drag-destination-desc.md) %}
  1. В окне со схемой рабочего процесса нажмите на добавленный блок **AI-агент**, чтобы выбрать его.
  1. {% include [integrations-step-select-settings-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-select-settings-tab.md) %}

      1. {% include [integrations-name-the-step](../../../../_includes/serverless-integrations/workflows-constructor/integrations-name-the-step.md) %}
      1. В блоке **Настройки AI-агента**:

          1. В поле **Модель** выберите большую языковую модель, которую будет использовать AI-агент.
          1. В поле **Роль** опишите роль, которая определяет функции и опыт AI-агента. Например: `консультант по выбору автозапчастей`.
          1. В поле **Цель** опишите индивидуальную цель, которой руководствуется AI-агент при принятии решений. Например: `помочь с выбором автозапчастей для указанного автомобиля`.
          1. (Опционально) В поле **Предыстория** укажите предысторию, которая определяет индивидуальность AI-агента и обогащает контекст. Например: `ты находишь лучшие автозапчасти по соотношению цены и качества и кратко объясняешь свой выбор`.
          1. (Опционально) В блоке **Источники знаний** с помощью кнопки ![plus](../../../../_assets/console-icons/plus.svg) укажите источники знаний для AI-агента. Выберите:
              * `Текст`, чтобы указать источник знаний в виде текста.
              * `Файл`, чтобы указать источник знаний в виде файла:

                  1. Выберите тип файла, который содержит источник знаний.
                  1. Выберите источник данных:
                      * `Публичный URL`, чтобы указать публичную ссылку на файл.
                      * `{{ objstorage-name }}`, чтобы указать имя [бакета](../../../../storage/concepts/bucket.md) и имя [объекта](../../../../storage/concepts/object.md), в которых находится файл (например, `prefix/subprefix/data.json`).
          1. (Опционально) В блоке **Инструменты** нажмите кнопку ![plus](../../../../_assets/console-icons/plus.svg) и добавьте инструмент, который AI-агент сможет использовать, чтобы получать дополнительные данные для формирования ответа:
              * В поле **Адрес MCP-сервера** укажите URL, по которому доступен [MCP-сервер](../../../../glossary/mcp.md). Например: `https://mcp.example.com/sse`.
              * В поле **Транспорт** выберите тип транспортного механизма, который будет использоваться для взаимодействия с MCP-сервером:

                  * `STREAMABLE` — AI-агент сможет получать обновления (события) с сервера без необходимости поддерживать постоянное HTTP-соединение. Данные между AI-агентом и сервером будут передаваться в обоих направлениях.
                  * `SSE` — AI-агент сможет получать обновления с сервера через одно постоянное HTTP-соединение. Данные будут передаваться только от сервера к AI-агенту.
              * В поле **Авторизация** укажите данные, необходимые для авторизации AI-агента на MCP-сервере:

                  * `Без авторизации` — авторизация на MCP-сервере не требуется.
                  * `OAuth-токен` — для авторизации на MCP-сервере используется [OAuth-токен](../../../../iam/concepts/authorization/oauth-token.md). Укажите OAuth-токен или [секрет](../../../../lockbox/concepts/secret.md) {{ lockbox-full-name }}, в котором сохранен этот токен. Выберите:

                      {% include [oauth](../../../../_includes/serverless-integrations/workflows-constructor/oauth.md) %}

                  * `IAM-токен` — для авторизации на MCP-сервере используется [IAM-токен](../../../../iam/concepts/authorization/iam-token.md), который автоматически выпускается для [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md), привязанного к рабочему процессу.

      1. (Опционально) В блоке **Задачи** с помощью кнопки ![plus](../../../../_assets/console-icons/plus.svg) задайте задачи, которые должен выполнить AI-агент:

          * В поле **Описание задачи** изложите суть задачи, которую должен выполнить AI-агент. Например: `подбери масляный фильтр для LADA Granta`.
          * (Опционально) В поле **Ожидаемый результат** опишите, в каком виде вы ожидаете получить результат. Например: `список адресов магазинов, где можно купить подходящие автозапчасти`.

      1. {% include [integrations-step-timeout](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-timeout.md) %}
      1. {% include [integrations-step-retry-policy](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-retry-policy.md) %}
  1. {% include [integrations-step-input-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-input-tab.md) %}
  1. {% include [integrations-step-output-tab](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-output-tab.md) %}
  1. {% include [integrations-step-add-catch-rule](../../../../_includes/serverless-integrations/workflows-constructor/integrations-step-add-catch-rule.md) %}

{% endlist %}

## См. также {#see-also}

* [Спецификация YaWL](../../../concepts/workflows/yawl/integration/aiagent.md)
* [{#T}](../workflow/create-constructor.md)
* [{#T}](../workflow/update.md)
