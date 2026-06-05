
Роль `ai.assistants.admin` позволяет использовать AI-агентов, а также управлять файлами и поисковыми индексами {{ vector-store-name }}.

Пользователи с этой ролью могут:
* использовать [AI-агентов]({{ link-docs-ai }}ai-studio/concepts/agents/);
* просматривать информацию о загруженных [файлах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading), а также загружать, изменять, просматривать и удалять такие файлы;
* просматривать информацию о [поисковых индексах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore) {{ vector-store-name }}, создавать, изменять и удалять поисковые индексы, а также выполнять поиск по ним;
* просматривать информацию о [квотах]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas) сервиса {{ ai-studio-full-name }};
* просматривать информацию об [облаке]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud);
* просматривать информацию о [каталоге]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#folder).

Включает разрешения, предоставляемые ролью `ai.assistants.editor`.