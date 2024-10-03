---
title: '{{ serverless-containers-full-name }} release notes'
description: This section contains {{ serverless-containers-name }} release notes.
---

# {{ serverless-containers-full-name }} release notes

## April 2024 {#april-2024}

### Fixes and improvements {#fixes-improvements}

* Removed the [user network](concepts/networking#user-network) requirement to have a subnet in the `ru-central1-c` availability zone, since [this zone is discontinued](../overview/concepts/ru-central1-c-deprecation).

## March 2024 {#march-2024}

### Updates {#updates}

* Added support for editing all trigger parameters in {{ TF }}.
* Released [{{ objstorage-full-name }} bucket mounting](concepts/mounting.md) to a container for [general availability](../overview/concepts/launch-stages.md).

### Fixes and improvements {#fixes-improvements}

* Increased the maximum batch size in a [{{ message-queue-full-name }} trigger](concepts/trigger/ymq-trigger.md) to 1,000 messages.

## January – February 2024 {#jan-feb-2024}

### Updates {#updates}

* Added support for container logging settings in {{ TF }}.
* Added support for [mounting {{ objstorage-full-name }} buckets](concepts/mounting.md) to a container via the CLI and {{ TF }}.
