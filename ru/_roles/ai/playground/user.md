Роль `ai.playground.user` позволяет создавать запросы в Playground, получать список всех доступных моделей и использовать их в Playground {{ ai-studio-full-name }}.

{% cut "Пользователи с этой ролью могут:" %}


* просматривать информацию о [конфигурациях {{ responses-api }}]({{ link-docs-ai }}ai-studio/operations/generation/create-prompt), а также создавать, использовать, изменять и удалять такие конфигурации;
* просматривать информацию о загруженных [файлах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading) и содержимое таких файлов;
* просматривать информацию о [поисковых индексах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore), а также выполнять поиск по таким индексам;
* просматривать информацию о [моделях генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models) {{ ai-studio-full-name }} и использовать такие модели;
* просматривать информацию о моделях генерации изображений {{ ai-studio-full-name }} и использовать такие модели;
* просматривать информацию о моделях [векторного представления текста]({{ link-docs-ai }}ai-studio/concepts/embeddings#yandexgpt-embeddings) {{ ai-studio-full-name }} и использовать такие модели;
* просматривать информацию о моделях [классификаторов]({{ link-docs-ai }}ai-studio/concepts/classifier/models) {{ ai-studio-full-name }} и использовать такие модели;
* использовать функциональность [перевода текста]({{ link-docs-ai }}translate/concepts/) в {{ ai-studio-full-name }};
* использовать функциональность [распознавания текста на изображениях]({{ link-docs-ai }}vision/concepts/ocr/) в {{ ai-studio-full-name }};
* использовать функциональность [распознавания]({{ link-docs-ai }}speechkit/stt/) и [синтеза]({{ link-docs-ai }}speechkit/tts/) речи в {{ ai-studio-full-name }};
* просматривать информацию о [квотах]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas) сервиса {{ ai-studio-full-name }};
* просматривать информацию об [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder).


{% endcut %}

Включает разрешения, предоставляемые ролями `ai.assistants.viewer`, `ai.models.user`, `ai.imageGeneration.user`, `ai.languageModels.user`, `ai.speechkit-stt.user`, `ai.speechkit-tts.user`, `ai.translate.user` и `ai.vision.user`.

Чтобы управлять поисковыми индексами в Playground, дополнительно необходима роль `ai.assistants.editor`.
