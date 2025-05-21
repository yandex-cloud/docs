---
title: '{{ si-full-name }} release notes'
description: This section contains {{ si-name }} release notes.
---

# {{ si-full-name }} release notes

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
