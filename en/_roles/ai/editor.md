The `ai.editor` role enables using Yandex Translate, Yandex Vision OCR, Yandex SpeechKit, and Yandex AI Studio.

Users with this role can:
* Use Yandex Translate to [translate texts](../../translate/quickstart.md).
* Use Yandex Vision OCR to [analyze images](../../vision/concepts/ocr/index.md).
* Use Yandex SpeechKit for speech [recognition](../../speechkit/stt/index.md) and [synthesis](../../speechkit/tts/index.md).
* View info on [text generation models](../../ai-studio/concepts/generation/models.md) in Yandex AI Studio.
* Use [AI agents](../../ai-studio/concepts/agents/index.md), text and image generation models, [text embedding](../../ai-studio/concepts/embeddings.md#yandexgpt-embeddings) models, and [classifier](../../ai-studio/concepts/classifier/models.md) models in Yandex AI Studio.
* View info on uploaded [files](../../ai-studio/concepts/search/vectorstore.md#file-uploading) as well as create, update, view, and delete them.
* View info on Vector Store [search indexes](../../ai-studio/concepts/search/vectorstore.md), create, modify, and delete them, as well as conduct searches using these indexes.
* [Fine-tune](../../ai-studio/concepts/tuning/index.md#fm-tuning) Yandex AI Studio models as well as create, modify, and delete fine-tuned models.
* View info on [datasets](../../ai-studio/dataset/api-ref/grpc/index.md), use them to fine-tune models, as well as create, modify, and delete datasets.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
* View info on quotes for [Yandex Translate](../../translate/concepts/limits.md#translate-quotas), [Yandex Vision OCR](../../vision/concepts/limits.md#vision-quotas), [Yandex SpeechKit](../../speechkit/concepts/limits.md#speechkit-quotas), and [Yandex AI Studio](../../ai-studio/concepts/limits.md#yandexgpt-quotas).

This role includes the `ai.viewer`, `ai.translate.user`, `ai.vision.user`, `ai.speechkit-stt.user`, `ai.speechkit-tts.user`, `ai.languageModels.user`, `ai.imageGeneration.user`, `ai.assistants.editor`, `ai.datasets.editor`, and `ai.models.editor` permissions.
