# An AI service for auto-replying to Wildberries reviews

This tutorial explains how to deploy a service to {{ sf-full-name }} that automatically replies to customer reviews in your Wildberries seller dashboard using a large language model — for example, [{{ yagpt-full-name }}]({{ link-docs-ai }}ai-studio/concepts/generation/index).

The service runs on a schedule via a [timer](../../../functions/concepts/trigger/timer.md): on every tick the function fetches a batch of unanswered reviews through the Wildberries Feedbacks API, generates an individual reply through an LLM, and posts it back to Wildberries.

The solution is open source under the MIT license and is available [in a public repository](https://github.com/eslazarev/ai-wildberries-review-responder). The service runs on your own credentials and never shares your Wildberries API token with third parties.

Architecture:

* **{{ sf-name }}** runs the code on a schedule with no need for a persistent server.
* **The timer trigger** invokes the function every N minutes (every 30 minutes by default).
* **{{ yagpt-full-name }}** generates the replies — inside {{ sf-name }} the function authenticates with the IAM token of its service account; an explicit API key is not required.
* **The Wildberries Feedbacks API** is the external source of input data and the destination for replies.

You can deploy the service the following way:

* [Management console](console.md) — a step-by-step scenario through the {{ yandex-cloud }} management console or a single command via the Serverless Framework.

> To learn about the resources you will be billed for, see the [Required paid resources](console.md#paid-resources) section.
