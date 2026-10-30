The `ai.auditor` role enables viewing info on text generation models, text-based agents and their publication channels, {{ responses-api }} configurations, subscriptions, and other entities in {{ ai-studio-full-name }}.

{% cut "Users with this role can:" %}


* View the metadata of [text generation models]({{ link-docs-ai }}ai-studio/concepts/generation/models).
* View the list of [text-based agents]({{ link-docs-ai }}ai-studio/concepts/agents/text-agents) in the folder as well as info on them, their versions, and operations with them.
* View info on [channels for publishing text-based agents]({{ link-docs-ai }}ai-studio/concepts/agents/text-agents#publication-channels), as well as the list of channels in the folder.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for text-based agents and their publication channels.
* View info on [{{ responses-api }}]({{ link-docs-ai }}ai-studio/operations/generation/create-prompt) configurations, uploaded [files]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading), and [search indexes]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore).
* View the metadata of model [guardrails]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules).
* View their [subscription's]({{ link-docs-ai }}ai-studio/manage/concepts/subscription#subscription) metadata.
* View the metadata of user [seat profiles]({{ link-docs-ai }}ai-studio/manage/concepts/#runtime-profile) and access permissions granted for such profiles.
* View the metadata of user [seats]({{ link-docs-ai }}ai-studio/manage/concepts/#work-runtime) and access permissions granted for seats.
* View [dataset]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/) metadata.
* View info on {{ ai-studio-full-name }} [quotas]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas).
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).


{% endcut %}

This role includes the `ai.agentChannels.auditor`, `ai.canvasAgents.auditor`, `ai.assistants.auditor`, `ai.datasets.auditor`, `ai.models.auditor`, `ai.guardrails.auditor`, `ai.subscriptions.auditor`, `ai.workProfiles.auditor`, and `ai.workRuntimes.auditor` permissions.
