The `ai.viewer` role enables viewing info on text generation models and model guardrails, text-based agents and their publication channels, {{ responses-api }} configurations, subscriptions, and other entities in {{ ai-studio-full-name }}.

{% cut "Users with this role can:" %}


* View info on [text generation models]({{ link-docs-ai }}ai-studio/concepts/generation/models).
* View the list of [text-based agents]({{ link-docs-ai }}ai-studio/concepts/agents/text-agents) in the folder as well as info on them, their versions, and operations with them.
* View info on [channels for publishing text-based agents]({{ link-docs-ai }}ai-studio/concepts/agents/text-agents#publication-channels), as well as the list of channels in the folder.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for text-based agents and their publication channels.
* View info on [{{ responses-api }} configurations]({{ link-docs-ai }}ai-studio/operations/generation/create-prompt).
* View info on uploaded [files]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading) and their contents.
* View info on [search indexes]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore) as well as conduct searches using these indexes.
* View info on model [guardrails]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules).
* View info on their [subscription]({{ link-docs-ai }}ai-studio/manage/concepts/subscription#subscription).
* View info on user [seat profiles]({{ link-docs-ai }}ai-studio/manage/concepts/#runtime-profile) and access permissions granted for them.
* View info on user [seats]({{ link-docs-ai }}ai-studio/manage/concepts/#work-runtime) and access permissions granted for them.
* View info on [datasets]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/).
* View info on {{ ai-studio-full-name }} [quotas]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas).
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).


{% endcut %}

This role includes the `ai.auditor`, `ai.agentChannels.viewer`, `ai.canvasAgents.viewer`, `ai.assistants.viewer`, `ai.datasets.viewer`, `ai.models.viewer`, `ai.guardrails.viewer`, `ai.subscriptions.viewer`, `ai.workRuntimes.viewer`, and `ai.workProfiles.viewer` permissions.
