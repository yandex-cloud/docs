Роль `ai.editor` позволяет использовать сервисы Yandex Translate, Yandex Vision OCR, Yandex SpeechKit и Yandex AI Studio.

Пользователи с этой ролью могут:
* использовать сервис Yandex Translate для [перевода текста](../../translate/quickstart.md);
* использовать сервис Yandex Vision OCR для [анализа изображений](../../vision/concepts/ocr/index.md);
* использовать сервис Yandex SpeechKit для [распознавания](../../speechkit/stt/index.md) и [синтеза](../../speechkit/tts/index.md) речи;
* просматривать информацию о [моделях генерации текста](../../ai-studio/concepts/generation/models.md) Yandex AI Studio;
* использовать [AI-агентов](../../ai-studio/concepts/agents/index.md), а также модели генерации текста и изображений, модели [векторного представления текста](../../ai-studio/concepts/embeddings.md#yandexgpt-embeddings) и [классификаторов](../../ai-studio/concepts/classifier/models.md) в сервисе Yandex AI Studio;
* просматривать информацию о загруженных [файлах](../../ai-studio/concepts/search/vectorstore.md#file-uploading), а также загружать, изменять, просматривать и удалять такие файлы;
* просматривать информацию о [поисковых индексах](../../ai-studio/concepts/search/vectorstore.md) Vector Store, создавать, изменять и удалять поисковые индексы, а также выполнять поиск по ним;
* [дообучать](../../ai-studio/concepts/tuning/index.md#fm-tuning) модели Yandex AI Studio, а также создавать, изменять и удалять дообученные модели;
* просматривать информацию о [датасетах](../../ai-studio/dataset/api-ref/grpc/index.md), использовать их для дообучения моделей, а также создавать, изменять и удалять датасеты;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о квотах сервисов [Yandex Translate](../../translate/concepts/limits.md#translate-quotas), [Yandex Vision OCR](../../vision/concepts/limits.md#vision-quotas), [Yandex SpeechKit](../../speechkit/concepts/limits.md#speechkit-quotas) и [Yandex AI Studio](../../ai-studio/concepts/limits.md#yandexgpt-quotas).

Включает разрешения, предоставляемые ролями `ai.viewer`, `ai.translate.user`, `ai.vision.user`, `ai.speechkit-stt.user`, `ai.speechkit-tts.user`, `ai.languageModels.user`, `ai.imageGeneration.user`, `ai.assistants.editor`, `ai.datasets.editor` и `ai.models.editor`.
