---
title: "{{ sf-full-name }} release notes"
description: "This section contains {{ sf-name }} release notes."
---

# {{ sf-full-name }} release notes

## May – June 2024 {#may-june-2024}

### Updates {#updates}

* Added support for the `concurrency` parameter in the CLI, API, and {{ TF }}.

### Fixes and improvements {#fixes-improvements}

* Fixed the error that occurred when creating function versions with the `golang` runtime environment that use the [opentracing-go](github.com/opentracing/opentracing-go) package.

## April 2024 {#april-2024}

### Updates {#updates}

* Added support for [allocating RAM for the `/tmp` directory](operations/function/allocate-memory-tmp.md) for the function version with at least 1 GB of memory.

### Fixes and improvements {#fixes-improvements}

* Fixed the `yandex_function_scaling_policy` import error in {{ TF }}.
* Removed the [user network](concepts/networking#user-network) requirement to have a subnet in the `ru-central1-c` availability zone as [this zone has been discontinued](../overview/concepts/ru-central1-c-deprecation).

## March 2024 {#march-2024}

### Updates {#updates}

* Added support for editing all trigger parameters in {{ TF }}.
* Released [{{ objstorage-full-name }}](concepts/mounting.md) bucket mounting to a function for [general availability](../overview/concepts/launch-stages.md).

### Fixes and improvements {#fixes-improvements}

* Increased the maximum batch size in a [{{ message-queue-full-name }}](concepts/trigger/ymq-trigger.md) trigger to 1,000 messages.

## January – February 2024 {#jan-feb-2024}

### Updates {#updates}

* Added support for [mounting {{ objstorage-full-name }}](concepts/mounting.md) buckets to a function via the CLI and {{ TF }}.
* Added support for function logging settings in {{ TF }}.

### Fixes and improvements {#fixes-improvements}

* Fixed the error encountered when displaying the quota for the number of function tags.
