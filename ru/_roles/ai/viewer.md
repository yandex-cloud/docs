Роль `ai.viewer` позволяет просматривать информацию о моделях генерации текста и правилах модерации моделей, о текстовых агентах и каналах публикации текстовых агентов, а также о конфигурациях {{ responses-api }}, подписках и других сущностях в {{ ai-studio-full-name }}.

{% cut "Пользователи с этой ролью могут:" %}


* просматривать информацию о [моделях генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models);
* просматривать список [текстовых агентов]({{ link-docs-ai }}ai-studio/concepts/agents/text-agents) в каталоге, информацию о них, их версиях и операциях с ними;
* просматривать информацию о [каналах публикации текстовых агентов]({{ link-docs-ai }}ai-studio/concepts/agents/text-agents#publication-channels), а также список каналов в каталоге;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к текстовым агентам и каналам публикации текстовых агентов;
* просматривать информацию о [конфигурациях {{ responses-api }}]({{ link-docs-ai }}ai-studio/operations/generation/create-prompt);
* просматривать информацию о загруженных [файлах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading) и содержимое таких файлов;
* просматривать информацию о [поисковых индексах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore), а также выполнять поиск по таким индексам;
* просматривать информацию о [правилах модерации]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules) моделей;
* просматривать информацию о своей [подписке]({{ link-docs-ai }}ai-studio/manage/concepts/subscription#subscription);
* просматривать информацию о [профилях рабочих мест]({{ link-docs-ai }}ai-studio/manage/concepts/#runtime-profile) пользователей и назначенных правах доступа к таким профилям;
* просматривать информацию о [рабочих местах]({{ link-docs-ai }}ai-studio/manage/concepts/#work-runtime) пользователей и назначенных правах доступа к рабочим местам;
* просматривать информацию о [датасетах]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/);
* просматривать информацию о [квотах]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas) сервиса {{ ai-studio-full-name }};
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).


{% endcut %}

Включает разрешения, предоставляемые ролями `ai.auditor`, `ai.agentChannels.viewer`, `ai.canvasAgents.viewer`, `ai.assistants.viewer`, `ai.datasets.viewer`, `ai.models.viewer`, `ai.guardrails.viewer`, `ai.subscriptions.viewer`, `ai.workRuntimes.viewer` и `ai.workProfiles.viewer`.
