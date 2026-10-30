The `ai.playground.user` role enables creating requests to Playground, getting a list of all available models, and using these models in {{ ai-studio-full-name }} Playground.

{% cut "Users with this role can:" %}


* View info on [{{ responses-api }} configurations]({{ link-docs-ai }}ai-studio/operations/generation/create-prompt), as well as create, use, modify, and delete them.
* View info on uploaded [files]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading) and their contents.
* View info on [search indexes]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore) as well as conduct searches using these indexes.
* View info on {{ ai-studio-full-name }} [text generation models]({{ link-docs-ai }}ai-studio/concepts/generation/models) and use them.
* View info on {{ ai-studio-full-name }} image generation models and use them.
* View info on {{ ai-studio-full-name }} [text embedding models]({{ link-docs-ai }}ai-studio/concepts/embeddings#yandexgpt-embeddings) and use them.
* View info on {{ ai-studio-full-name }} [classifier models]({{ link-docs-ai }}ai-studio/concepts/classifier/models) and use them.
* Use [text translation]({{ link-docs-ai }}translate/concepts/) features in {{ ai-studio-full-name }}.
* Use [optical character recognition]({{ link-docs-ai }}vision/concepts/ocr/) in {{ ai-studio-full-name }}.
* Use speech [recognition]({{ link-docs-ai }}speechkit/stt/) and [synthesis]({{ link-docs-ai }}speechkit/tts/) in {{ ai-studio-full-name }}.
* View info on {{ ai-studio-full-name }} [quotas]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas).
* View info on the relevant [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).


{% endcut %}

This role includes the `ai.assistants.viewer`, `ai.models.user`, `ai.imageGeneration.user`, `ai.languageModels.user`, `ai.speechkit-stt.user`, `ai.speechkit-tts.user`, `ai.translate.user`, and `ai.vision.user` permissions.

To manage search indexes in Playground, you also need the `ai.assistants.editor` role.
