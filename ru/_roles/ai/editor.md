Роль `ai.editor` позволяет использовать сервисы {{ translate-full-name }}, {{ vision-full-name }}, {{ speechkit-full-name }} и {{ ai-studio-full-name }}.

Пользователи с этой ролью могут:
* использовать сервис {{ translate-full-name }} для [перевода текста]({{ link-docs-ai }}translate/quickstart);
* использовать сервис {{ vision-full-name }} для [анализа изображений]({{ link-docs-ai }}vision/concepts/ocr/);
* использовать сервис {{ speechkit-full-name }} для [распознавания]({{ link-docs-ai }}speechkit/stt/) и [синтеза]({{ link-docs-ai }}speechkit/tts/) речи;
* просматривать информацию о [моделях генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models) {{ ai-studio-full-name }};
* просматривать информацию о [правилах модерации]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules) ответов моделей, а также создавать, применять, изменять и удалять такие правила;
* использовать [AI-агентов]({{ link-docs-ai }}ai-studio/concepts/agents/), а также модели генерации текста и изображений, модели [векторного представления текста]({{ link-docs-ai }}ai-studio/concepts/embeddings#yandexgpt-embeddings) и [классификаторов]({{ link-docs-ai }}ai-studio/concepts/classifier/models) в сервисе {{ ai-studio-full-name }};
* просматривать информацию о загруженных [файлах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading), а также загружать, изменять, просматривать и удалять такие файлы;
* просматривать информацию о [поисковых индексах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore) {{ vector-store-name }}, создавать, изменять и удалять поисковые индексы, а также выполнять поиск по ним;
* [дообучать]({{ link-docs-ai }}ai-studio/concepts/tuning/#fm-tuning) модели {{ ai-studio-full-name }}, а также создавать, изменять и удалять дообученные модели;
* просматривать информацию о [датасетах]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/), использовать их для дообучения моделей, а также создавать, изменять и удалять датасеты;
* просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud) и [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder);
* просматривать информацию о квотах сервисов [{{ translate-full-name }}]({{ link-docs-ai }}translate/concepts/limits#translate-quotas), [{{ vision-full-name }}]({{ link-docs-ai }}vision/concepts/limits#vision-quotas), [{{ speechkit-full-name }}]({{ link-docs-ai }}speechkit/concepts/limits#speechkit-quotas) и [{{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas).

Включает разрешения, предоставляемые ролями `ai.viewer`, `ai.translate.user`, `ai.vision.user`, `ai.speechkit-stt.user`, `ai.speechkit-tts.user`, `ai.languageModels.user`, `ai.imageGeneration.user`, `ai.assistants.editor`, `ai.datasets.editor`, `ai.models.editor` и `ai.guardrails.editor`.
