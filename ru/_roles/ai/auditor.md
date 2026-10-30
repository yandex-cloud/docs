Роль `ai.auditor` позволяет просматривать информацию о моделях генерации текста и правилах модерации моделей, о текстовых агентах и каналах публикации текстовых агентов, а также о конфигурациях {{ responses-api }}, подписках и других сущностях в {{ ai-studio-full-name }}.

{% cut "Пользователи с этой ролью могут:" %}


* просматривать метаданные [моделей генерации текста]({{ link-docs-ai }}ai-studio/concepts/generation/models);
* просматривать список [текстовых агентов]({{ link-docs-ai }}ai-studio/concepts/agents/text-agents) в каталоге, информацию о них, их версиях и операциях с ними;
* просматривать информацию о [каналах публикации текстовых агентов]({{ link-docs-ai }}ai-studio/concepts/agents/text-agents#publication-channels), а также список каналов в каталоге;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к текстовым агентам и каналам публикации текстовых агентов;
* просматривать информацию о [конфигурациях {{ responses-api }}]({{ link-docs-ai }}ai-studio/operations/generation/create-prompt), загруженных [файлах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading) и [поисковых индексах]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore);
* просматривать метаданные [правил модерации]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules) моделей;
* просматривать метаданные своей [подписки]({{ link-docs-ai }}ai-studio/manage/concepts/subscription#subscription);
* просматривать метаданные [профилей рабочих мест]({{ link-docs-ai }}ai-studio/manage/concepts/#runtime-profile) пользователей и назначенные права доступа к таким профилям;
* просматривать метаданные [рабочих мест]({{ link-docs-ai }}ai-studio/manage/concepts/#work-runtime) пользователей и назначенные права доступа к рабочим местам;
* просматривать метаданные [датасетов]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/);
* просматривать информацию о [квотах]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas) сервиса {{ ai-studio-full-name }};
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).


{% endcut %}

Включает разрешения, предоставляемые ролями `ai.agentChannels.auditor`, `ai.canvasAgents.auditor`, `ai.assistants.auditor`, `ai.datasets.auditor`, `ai.models.auditor`, `ai.guardrails.auditor`, `ai.subscriptions.auditor`, `ai.workProfiles.auditor` и `ai.workRuntimes.auditor`.
