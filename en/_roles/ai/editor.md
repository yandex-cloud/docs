The `ai.editor` role enables using {{ translate-full-name }}, {{ vision-full-name }}, {{ speechkit-full-name }}, and {{ ai-studio-full-name }}.

Users with this role can:
* Use {{ translate-full-name }} to [translate texts]({{ link-docs-ai }}translate/quickstart).
* Use {{ vision-full-name }} to [analyze images]({{ link-docs-ai }}vision/concepts/ocr/).
* Use {{ speechkit-full-name }} for speech [recognition]({{ link-docs-ai }}speechkit/stt/) and [synthesis]({{ link-docs-ai }}speechkit/tts/).
* View info on [text generation models]({{ link-docs-ai }}ai-studio/concepts/generation/models) in {{ ai-studio-full-name }}.
* View info on [guardrails]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules) for model responses, as well as create, apply, modify, and delete guardrails.
* Use [AI agents]({{ link-docs-ai }}ai-studio/concepts/agents/), text and image generation models, [text embedding]({{ link-docs-ai }}ai-studio/concepts/embeddings#yandexgpt-embeddings) models, and [classifier]({{ link-docs-ai }}ai-studio/concepts/classifier/models) models in {{ ai-studio-full-name }}.
* View info on uploaded [files]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading) as well as create, update, view, and delete them.
* View info on {{ vector-store-name }} [search indexes]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore), create, modify, and delete them, as well as conduct searches using these indexes.
* [Fine-tune]({{ link-docs-ai }}ai-studio/concepts/tuning/#fm-tuning) {{ ai-studio-full-name }} models as well as create, modify, and delete fine-tuned models.
* View info on [datasets]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/), use them to fine-tune models, as well as create, modify, and delete datasets.
* View info on the relevant [cloud]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud) and [folder]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder).
* View info on quotes for [{{ translate-full-name }}]({{ link-docs-ai }}translate/concepts/limits#translate-quotas), [{{ vision-full-name }}]({{ link-docs-ai }}vision/concepts/limits#vision-quotas), [{{ speechkit-full-name }}]({{ link-docs-ai }}speechkit/concepts/limits#speechkit-quotas), and [{{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas).

This role includes the `ai.viewer`, `ai.translate.user`, `ai.vision.user`, `ai.speechkit-stt.user`, `ai.speechkit-tts.user`, `ai.languageModels.user`, `ai.imageGeneration.user`, `ai.assistants.editor`, `ai.datasets.editor`, `ai.models.editor`, and `ai.guardrails.editor` permissions.
