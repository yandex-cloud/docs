---
title: '{{ si-full-name }} release notes'
description: This section contains the {{ si-name }} release notes.
---

# {{ si-full-name }} release notes

## February 2026 {#february-2026}

### Updates {#updates}

* Added support for starting a workflow by a link.
* Added support for the `auto_approve` field for the [AIStudioAgent]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/aistudioagent) step.

## January 2026 {#january-2026}

### Updates {#updates}

* Added support for the `message` field for the [AIStudioAgent]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/aistudioagent) step.

## December 2025 {#december-2025}

### Updates {#updates}

* Upgraded the version of the `jq` templating language in {{ sw-name }}.

## November 2025 {#november-2025}

### Updates {#updates}

* Updated the list of supported {{ ai-studio-name }} models in {{ sw-name }} integration steps.

## October 2025 {#october-2025}

### Updates {#updates}

* Added support for the `No markup` formatting mode in the constructor's [Telegram bot]({{ link-docs-ai }}ai-studio/operations/workflows/constructor/telegrambot) step.

### Fixes and improvements {#fixes-improvements}

* Renamed the _Foundation Models_ step to [AI Studio models]({{ link-docs-ai }}ai-studio/operations/workflows/constructor/foundationmodelscall).
* Formatting modes for the [Telegram bot]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/telegrambot) step now work differently: if there is a message format parsing error, it will be sent in its original form.

## September 2025 {#september-2025}

### Updates {#updates}

* Added support for the [DatabaseQuery]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/databasequery), [VectorStore]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/vectorstore), and [AIStudioAgent]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/aistudioagent) steps.
* Added starting workflows by [timer]({{ link-docs-ai }}ai-studio/operations/workflows/execution/start-by-timer).
* Added support for _Playground_ and an editor with syntax highlighting to write and debug templated jq expressions.

### Fixes and improvements {#fixes-improvements}

* Fixed a bug in connector deletion protection on/off setting.

## August 2025 {#august-2025}

### Updates {#updates}

* Added support for [error transition rules]({{ link-docs-ai }}ai-studio/operations/workflows/constructor/setup-catch-rule) for integration steps in the {{ sw-name }} constructor.

## July 2025 {#july-2025}

### Updates {#updates}

* Supported a new connector source type, [{{ er-name }} API](concepts/eventrouter/connector.md#from-api).
* Supported the [TelegramBot]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/telegrambot) step.

## June 2025 {#june-2025}

### Updates {#updates}

* Supported `At least once` guaranteed delivery for internal {{ sw-full-name }} errors.
* Supported LLMs and knowledge sources for the AIAgent step.
* Supported the `concurrency` field for the [Foreach]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/management/foreach) and [Parallel]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/management/parallel) steps.

## May 2025 {#may-2025}

### Updates {#updates}

* {{ sw-full-name }} is now publicly available at the [Preview](../overview/concepts/launch-stages.md) stage.
* Supported a new connector source type, [Timer](concepts/eventrouter/connector.md#timer).
* Supported the AIAgent step.
* Updated the [{{ sw-full-name }} quotas](concepts/limits.md#sw-quotas).

## April 2025 {#april-2025}

### Updates {#updates}

* Added support for the [Workflow]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/workflow), [Disk]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/disk), and [While]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/management/while) steps in {{ sw-name }}.
* Added support for `EXCEL` and `CSV` types for the [ObjectStorage]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/objectstorage) and [Disk]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/disk) steps in {{ sw-name }}: now objects of these types can be automatically decoded from a base64-encoded string.
* Added support for [error transition rules]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/index#catchrule) for {{ sw-name }} integration steps.

## March 2025 {#march-2025}

### Updates {#updates}

* Added support for `TEXT` and `JSON` types for the [ObjectStorage]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/objectstorage) step in {{ sw-name }}: now objects of these types can be automatically decoded from a base64-encoded string.

## February 2025 {#february-2025}

### Fixes and improvements {#fixes-improvements}

* Updated the input data format for a {{ sw-name }} workflow. You can now input not only JSON objects to a workflow, but any valid JSON structures, e.g., arrays or strings.

## December 2024 {#december-2024}

### Updates {#updates}

* Added support for the [Tracker]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/tracker), [Postbox]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/postbox), and [Wait]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/management/wait) steps in {{ sw-name }}.

## November 2024 {#november-2024}

### Updates {#updates}

* Added support for the [YDBDocument]({{ link-docs-ai }}ai-studio/concepts/workflows/yawl/integration/ydbdocument) step in {{ sw-name }}.
* Added support for {{ er-name }} in {{ TF }}.
