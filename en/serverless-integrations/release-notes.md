---
title: '{{ si-full-name }} release notes'
description: This section contains {{ si-name }} release notes.
---

# {{ si-full-name }} release notes

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
