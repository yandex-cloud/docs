Роль `ai.admin` позволяет использовать сервисы Yandex Translate, Yandex Vision OCR, Yandex SpeechKit и Yandex AI Studio.

Пользователи с этой ролью могут:
* использовать сервис Yandex Translate для [перевода текста]({{ link-docs-ai }}translate/quickstart);
* использовать сервис Yandex Vision OCR для [анализа изображений]({{ link-docs-ai }}vision/concepts/ocr/);
* использовать сервис Yandex SpeechKit для [распознавания]({{ link-docs-ai }}speechkit/stt/) и [синтеза]({{ link-docs-ai }}speechkit/tts/) речи;
* просматривать информацию о [моделях генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models) Yandex AI Studio;
* просматривать информацию о [правилах модерации]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules) ответов моделей, а также создавать, применять, изменять и удалять такие правила;
* использовать [AI-агентов]({{ link-docs-ai }}ai-studio/concepts/agents/), а также модели генерации текста и изображений, модели [векторного представления текста]({{ link-docs-ai }}ai-studio/concepts/embeddings#yandexgpt-embeddings) и [классификаторов]({{ link-docs-ai }}ai-studio/concepts/classifier/models) в сервисе Yandex AI Studio;
* просматривать информацию о загруженных [файлах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading), а также загружать, изменять, просматривать и удалять такие файлы;
* просматривать информацию о [поисковых индексах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore) Vector Store, создавать, изменять и удалять поисковые индексы, а также выполнять поиск по ним;
* [дообучать]({{ link-docs-ai }}ai-studio/concepts/tuning/#fm-tuning) модели Yandex AI Studio, а также создавать, изменять и удалять дообученные модели;
* просматривать информацию о [датасетах]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/), использовать их для дообучения моделей, а также создавать, изменять и удалять датасеты;
* просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud) и [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder);
* просматривать информацию о квотах сервисов [Yandex Translate]({{ link-docs-ai }}translate/concepts/limits#translate-quotas), [Yandex Vision OCR]({{ link-docs-ai }}vision/concepts/limits#vision-quotas), [Yandex SpeechKit]({{ link-docs-ai }}speechkit/concepts/limits#speechkit-quotas) и [Yandex AI Studio]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas).

Включает разрешения, предоставляемые ролями `ai.editor`, `ai.assistants.admin`, `ai.datasets.admin`, `ai.models.admin` и `ai.guardrails.admin`.
