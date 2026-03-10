The `ai.admin` role enables using Yandex Translate, Yandex Vision OCR, Yandex SpeechKit, and Yandex AI Studio.

Users with this role can:
* Use Yandex Translate to [translate texts]({{ link-docs-ai }}translate/quickstart).
* Use Yandex Vision OCR to [analyze images]({{ link-docs-ai }}vision/concepts/ocr/).
* Use Yandex SpeechKit for speech [recognition]({{ link-docs-ai }}speechkit/stt/) and [synthesis]({{ link-docs-ai }}speechkit/tts/).
* View info on [text generation models]({{ link-docs-ai }}ai-studio/concepts/generation/models) in Yandex AI Studio.
* Use [AI agents]({{ link-docs-ai }}ai-studio/concepts/agents/), text and image generation models, [text embedding]({{ link-docs-ai }}ai-studio/concepts/embeddings#yandexgpt-embeddings) models, and [classifier]({{ link-docs-ai }}ai-studio/concepts/classifier/models) models in Yandex AI Studio.
* View info on uploaded [files]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading) as well as create, update, view, and delete them.
* View info on Vector Store [search indexes]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore), create, modify, and delete them, as well as conduct searches using these indexes.
* [Fine-tune]({{ link-docs-ai }}ai-studio/concepts/tuning/#fm-tuning) Yandex AI Studio models as well as create, modify, and delete fine-tuned models.
* View info on [datasets]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/), use them to fine-tune models, as well as create, modify, and delete datasets.
* View info on the relevant [cloud]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud) and [folder]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder).
* View info on [Yandex Translate]({{ link-docs-ai }}translate/concepts/limits#translate-quotas), [Yandex Vision OCR]({{ link-docs-ai }}vision/concepts/limits#vision-quotas), [Yandex SpeechKit]({{ link-docs-ai }}speechkit/concepts/limits#speechkit-quotas), and [Yandex AI Studio]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas) quotes.

This role includes the `ai.editor`, `ai.assistants.admin`, `ai.datasets.admin`, and `ai.models.admin` permissions.
