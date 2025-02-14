# Обзор сервиса {{ ca-full-name }}

{% include [preview-stage](../../_includes/code-assistant/preview-stage.md) %}

{% include [ask-for-turning-on](../../_includes/code-assistant/ask-for-turning-on.md) %}

{% include [about-service](../../_includes/code-assistant/about-service.md) %}

{% include [supported-versions](../../_includes/code-assistant/supported-versions.md) %}

{% note info %}

Для работы {{ ca-name }} требуется постоянный доступ в интернет.

{% endnote %}

Непосредственный анализ кода выполняется на вычислительных мощностях {{ yandex-cloud }}, поэтому {{ ca-name }} не нагружает локальные рабочие станции пользователей.

LLM, которые применяются в {{ ca-name }}, дообучены на корпусе общедоступного кода. Качество и количество предложений по автодополнению зависит от объема и разнообразия общедоступного кода, представленного на конкретном языке.

{% include [syntax-support](../../_includes/code-assistant/syntax-support.md) %}

{% include [auto-manual-modes](../../_includes/code-assistant/auto-manual-modes.md) %}

Поддерживаются следующие типы подсказок:
* Inline completion — автодополнения по ходу написания текста (кода, тестов, документации).
* Full-function completion — автодополнения целых функций или методов.

{% include [help-indicator-load](../../_includes/code-assistant/help-indicator-load.md) %}

Подробнее об управлении индикатором подсказок см. [{#T}](../quickstart.md#help-indicator)


#### См. также {#see-also}

* [{#T}](../quickstart.md)
* [Условия использования сервиса {{ ca-name }}](https://yandex.ru/legal/cloud_terms_code_assistant/)