Роль `ai.admin` позволяет использовать сервисы Yandex Translate, Yandex Vision, Yandex SpeechKit и Yandex Foundation Models.

Пользователи с этой ролью могут:
* использовать сервис Yandex Translate для [перевода текста](../../translate/quickstart.md);
* использовать сервис Yandex Vision OCR для [анализа изображений](../../vision/concepts/ocr/index.md);
* использовать сервис Yandex SpeechKit для [распознавания](../../speechkit/stt/index.md) и [синтеза](../../speechkit/tts/index.md) речи;
* использовать [языковые модели](../../foundation-models/concepts/yandexgpt/index.md) генерации YandexGPT API, модели генерации изображений YandexART, а также [AI-ассистентов](../../foundation-models/concepts/assistant/index.md) в сервисе Yandex Foundation Models;
* просматривать информацию о [датасетах](../../foundation-models/dataset/api-ref/grpc/index.md), а также создавать, изменять и удалять датасеты;
* [дообучать](../../foundation-models/concepts/tuning/index.md#fm-tuning) модели генерации текста Yandex Foundation Models, а также создавать, изменять и удалять дообученные модели;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о квотах сервисов Translate, Vision, SpeechKit и Foundation Models.

Включает разрешения, предоставляемые ролями `ai.editor`, `ai.assistants.admin`, `ai.datasets.admin` и `ai.models.admin`.
