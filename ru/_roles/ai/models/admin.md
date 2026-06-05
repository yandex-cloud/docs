Роль `ai.models.admin` позволяет управлять дообучением моделей {{ ai-studio-full-name }}, а также использовать сервисы {{ translate-full-name }}, {{ vision-full-name }}, {{ speechkit-full-name }} и {{ ai-studio-full-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [моделях генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models) {{ ai-studio-full-name }};
* [дообучать]({{ link-docs-ai }}ai-studio/concepts/tuning/#fm-tuning) модели {{ ai-studio-full-name }}, а также создавать, изменять и удалять дообученные модели;
* использовать [AI-агентов]({{ link-docs-ai }}ai-studio/concepts/agents/), а также модели генерации текста и изображений, модели [векторного представления текста]({{ link-docs-ai }}ai-studio/concepts/embeddings#yandexgpt-embeddings) и [классификаторов]({{ link-docs-ai }}ai-studio/concepts/classifier/models) в сервисе {{ ai-studio-full-name }};
* использовать сервис {{ translate-full-name }} для [перевода текста]({{ link-docs-ai }}translate/quickstart);
* использовать сервис {{ vision-full-name }} для [анализа изображений]({{ link-docs-ai }}vision/concepts/ocr/);
* использовать сервис {{ speechkit-full-name }} для [распознавания]({{ link-docs-ai }}speechkit/stt/) и [синтеза]({{ link-docs-ai }}speechkit/tts/) речи.

Включает разрешения, предоставляемые ролью `ai.models.editor`.
