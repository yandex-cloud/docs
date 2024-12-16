---
title: '{{ serverless-containers-full-name }} release notes'
description: This section contains {{ serverless-containers-name }} release notes.
---

# {{ serverless-containers-full-name }} release notes

## November 2024 {#november-2024}

### Updates {#updates}

* Added support for container mode selection in the CLI, API, and {{ TF }}.

## September — October 2024 {#sept-oct-2024}

### Updates {#updates}

* Added support for [long-lived containers](concepts/long-lived-containers.md).
* Added support for sending [container termination notifications](concepts/termination-notifications.md).
* Added support for [mounting ephemeral disks](concepts/mounting.md#mount-ephemeral-storage).

## April 2024 {#april-2024}

### Fixes and improvements {#fixes-improvements}

* Removed the [user network](concepts/networking#user-network) requirement to have a subnet in the `ru-central1-c` availability zone because [this zone is discontinued](../overview/concepts/ru-central1-c-deprecation).

## March 2024 {#march-2024}

### Updates {#updates}

* Added support for editing all trigger parameters in {{ TF }}.
* [{{ objstorage-full-name }}](concepts/mounting.md) bucket mounting to a container is now at the [general availability](../overview/concepts/launch-stages.md) stage.

### Fixes and improvements {#fixes-improvements}

* Increased the maximum batch size in a [{{ message-queue-full-name }}](concepts/trigger/ymq-trigger.md) trigger to 1,000 messages.

## January – February 2024 {#jan-feb-2024}

### Updates {#updates}

* Added support for container logging settings in {{ TF }}.
* Added support for [mounting {{ objstorage-full-name }}](concepts/mounting.md) buckets to a container via the CLI and {{ TF }}.
