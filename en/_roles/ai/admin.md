The `ai.admin` role enables using {{ ai-studio-full-name }} models, managing subscriptions, text-based agents, {{ responses-api }} configurations, other entities, and access to them in {{ ai-studio-full-name }}.

{% cut "Users with this role can:" %}


* View info on [text generation models]({{ link-docs-ai }}ai-studio/concepts/generation/models), image generation models, [text embedding models]({{ link-docs-ai }}ai-studio/concepts/embeddings#yandexgpt-embeddings), and [classifier models]({{ link-docs-ai }}ai-studio/concepts/classifier/models) in {{ ai-studio-full-name }}, as well as use such models.
* View the list of [text-based agents]({{ link-docs-ai }}ai-studio/concepts/agents/text-agents) in the folder as well as info on them, their versions, and operations with them.
* Create, modify, and delete text-based agents.
* Create versions of text-based agents.
* Test any version of a text-based agent in the testing interface, including ones not yet published in a channel: send messages to the agent and view execution events.
* View info on [channels for publishing text-based agents]({{ link-docs-ai }}ai-studio/concepts/agents/text-agents#publication-channels), as well as the list of channels in the folder.
* Create, modify, and delete channels for publishing text-based agents, as well as suspend and resume their operation.
* Publish text-based agent versions in channels.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for text-based agents and their publication channels, as well as modify such permissions.
* View info on [{{ responses-api }} configurations]({{ link-docs-ai }}ai-studio/operations/generation/create-prompt), as well as create, use, modify, and delete them.
* View info on uploaded [files]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore#file-uploading) as well as create, update, view, and delete them.
* View info on [search indexes]({{ link-docs-ai }}ai-studio/concepts/search/vectorstore), create, modify, and delete them, as well as conduct searches using these indexes.
* View info on model [guardrails]({{ link-docs-ai }}ai-studio/concepts/security/guardrails#rules), as well as create, apply, modify, and delete such guardrails.
* Get a list of [subscriptions]({{ link-docs-ai }}ai-studio/manage/concepts/subscription#subscription) in the cloud and view information on them.
* Purchase, modify, and delete subscriptions, including other users' subscriptions.
* Reset consumption windows for any subscription in the cloud.
* Use their subscription.
* View info on user [seat profiles]({{ link-docs-ai }}ai-studio/manage/concepts/#runtime-profile).
* View info on access permissions granted for user seat profiles and modify such permissions.
* Create, use, modify, and delete user seat profiles.
* View info on user [seats]({{ link-docs-ai }}ai-studio/manage/concepts/#work-runtime).
* View info on access permissions granted for user seats and modify such permissions.
* Create and delete seats.
* Use their seat.
* View info on [datasets]({{ link-docs-ai }}ai-studio/dataset/api-ref/grpc/) as well as create, use, modify, and delete them.
* Use [speech recognition]({{ link-docs-ai }}speechkit/stt/) and [synthesis]({{ link-docs-ai }}speechkit/tts/), [text translation]({{ link-docs-ai }}translate/concepts/), and [optical character recognition]({{ link-docs-ai }}vision/concepts/ocr/) in {{ ai-studio-full-name }}.
* View info on {{ ai-studio-full-name }} [quotas]({{ link-docs-ai }}ai-studio/concepts/limits#yandexgpt-quotas).
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).


{% endcut %}

This role includes the `ai.editor`, `ai.agentChannels.admin`, `ai.canvasAgents.admin`, `ai.assistants.admin`, `ai.datasets.admin`, `ai.models.admin`, `ai.guardrails.admin`, `ai.subscriptions.admin`, `ai.workRuntimes.admin`, and `ai.workProfiles.admin` permissions.
