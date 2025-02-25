# {{ ca-full-name }} overview

{% include [preview-stage](../../_includes/code-assistant/preview-stage.md) %}

{% include [about-service](../../_includes/code-assistant/about-service.md) %}

{% include [supported-versions](../../_includes/code-assistant/supported-versions.md) %}

{% note info %}

To work with {{ ca-name }}, you will need continuous internet access.

{% endnote %}

The code analysis is running using the {{ yandex-cloud }} computing resources, which means {{ ca-name }} does not generate any load against the user workstations.

LLMs that are used in {{ ca-name }} have been fine-tuned based on the open-source code corpus. The quality and number of auto-completion prompts depends on the amount and diversity of open-source code in a particular language.

{% include [syntax-support](../../_includes/code-assistant/syntax-support.md) %}

{% include [auto-manual-modes](../../_includes/code-assistant/auto-manual-modes.md) %}

{{ ca-name }} supports the following types of suggestions:
* Inline completion: Provides suggestions as you type. Works for code, texts, and documents.
* Full-function completion: Provides autocompletion for entire functions or methods.

#### See also {#see-also}

* [{#T}](../quickstart.md)
* [{{ ca-full-name }} terms of use](https://yandex.com/legal/cloud_terms_code_assistant/)

