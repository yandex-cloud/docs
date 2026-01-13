---
title: '{{ si-full-name }} release notes'
description: This section contains {{ si-name }} release notes.
---

# {{ si-full-name }} release notes

## October 2025 {#october-2025}

### Updates {#updates}

* Added support for the `No markup` formatting mode in the constructor's [Telegram bot](operations/workflows/constructor/telegrambot.md) step.

### Fixes and improvements {#fixes-improvements}

* Renamed the _Foundation Models_ step to [AI Studio models](operations/workflows/constructor/foundationmodelscall.md).
* Formatting modes for the [Telegram bot](concepts/workflows/yawl/integration/telegrambot.md) step now work differently: if there is a message format parsing error, it will be sent in its original form.

## September 2025 {#september-2025}

### Updates {#updates}

* Added support for the [DatabaseQuery](concepts/workflows/yawl/integration/databasequery.md), [VectorStore](concepts/workflows/yawl/integration/vectorstore.md), and [AIStudioAgent](concepts/workflows/yawl/integration/aistudioagent.md) steps.
* Added starting workflows by [timer](operations/workflows/execution/start-by-timer.md).
* Added support for _Playground_ and an editor with syntax highlighting to write and debug templated jq expressions.

### Fixes and improvements {#fixes-improvements}

* Fixed a bug in connector deletion protection on/off setting.

## August 2025 {#august-2025}

### Updates {#updates}

* In the {{ sw-name }} constructor, added support for [error transition rules](operations/workflows/constructor/setup-catch-rule.md) in integration steps.

## July 2025 {#july-2025}

### Updates {#updates}

* Supported a new connector source type, [{{ er-name }} API](concepts/eventrouter/connector.md#from-api).
* Supported the [TelegramBot](concepts/workflows/yawl/integration/telegrambot.md) step.

## June 2025 {#june-2025}

### Updates {#updates}

* Supported `At least once` guaranteed delivery for internal {{ sw-full-name }} errors.
* Supported LLMs and knowledge sources for the [AIAgent](concepts/workflows/yawl/integration/aiagent.md) step.
* Supported the `concurrency` field for the [Foreach](concepts/workflows/yawl/management/foreach.md) and [Parallel](concepts/workflows/yawl/management/parallel.md) steps.

## May 2025 {#may-2025}

### Updates {#updates}

* {{ sw-full-name }} is now publicly available at the [Preview](../overview/concepts/launch-stages.md) stage.
* Supported a new connector source type, [Timer](concepts/eventrouter/connector.md#timer).
* Supported the [AIAgent](concepts/workflows/yawl/integration/aiagent.md) step.
* Updated the [{{ sw-full-name }} quotas](concepts/limits.md#sw-quotas).

## April 2025 {#april-2025}

### Updates {#updates}

* Added support for the [Workflow](concepts/workflows/yawl/integration/workflow.md), [Disk](concepts/workflows/yawl/integration/disk.md), and [While](concepts/workflows/yawl/management/while.md) steps in {{ sw-name }}.
* Added support for `EXCEL` and `CSV` types for the [ObjectStorage](concepts/workflows/yawl/integration/objectstorage.md) and [Disk](concepts/workflows/yawl/integration/disk.md) steps in {{ sw-name }}: now objects of these types can be automatically decoded from a base64-encoded string.
* Added support for [error transition rules](concepts/workflows/yawl/index.md#catchrule) for {{ sw-name }} integration steps.

## March 2025 {#march-2025}

### Updates {#updates}

* Added support for `TEXT` and `JSON` types for the [ObjectStorage](concepts/workflows/yawl/integration/objectstorage.md) step in {{ sw-name }}: now objects of these types can be automatically decoded from a base64-encoded string.

## February 2025 {#february-2025}

### Fixes and improvements {#fixes-improvements}

* Updated the input data format for a {{ sw-name }} workflow. You can now input not only JSON objects to a workflow, but any valid JSON structures, e.g., arrays or strings.

## December 2024 {#december-2024}

### Updates {#updates}

* Added support for the [Tracker](concepts/workflows/yawl/integration/tracker.md), [Postbox](concepts/workflows/yawl/integration/postbox.md), and [Wait](concepts/workflows/yawl/management/wait.md) steps in {{ sw-name }}.

## November 2024 {#november-2024}

### Updates {#updates}

* Added support for the [YDBDocument](concepts/workflows/yawl/integration/ydbdocument.md) step in {{ sw-name }}.
* Added support for {{ er-name }} in {{ TF }}.
