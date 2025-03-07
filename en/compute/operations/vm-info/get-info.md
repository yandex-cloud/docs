---
title: Getting information about a VM
description: Follow this guide to get information about a VM.
---

# Getting information about a VM


To get basic information about each [VM](../../concepts/vm.md) you created, go to the VM page in the [management console]({{ link-console-main }}). To get detailed information with custom [metadata](../../concepts/vm-metadata.md), use the [CLI](../../../cli/cli-ref/compute/cli-ref/instance/get.md) or [API](../../api-ref/Instance/get.md).

You can also get basic information and metadata [from within a VM](#inside-instance).

## Getting information from outside a VM {#outside-instance}

{% include [metadata-external-access](../../../_includes/compute/metadata-external-access.md) %}

## Getting information from within a VM {#inside-instance}

{% include [vm-metadata](../../../_includes/vm-metadata.md) %}

### HTTP request {#gce-http}

{% include [internal-http-request](../../../_includes/compute/metadata/internal-http-request.md) %}

### Request examples {#request-examples}

{% include [internal-request-examples](../../../_includes/compute/metadata/internal-request-examples.md) %}