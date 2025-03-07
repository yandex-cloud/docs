---
title: How to get VM metadata
description: Follow this guide to get metadata from both inside and outside a VM.
---

# Getting VM metadata

The [metadata service](../../../compute/concepts/vm-metadata.md) allows you to read metadata from both [outside](#external-access) and [inside](#internal-access) VM instances.

## Accessing metadata from outside the VM instance {#external-access}

{% include [metadata-external-access](../../../_includes/compute/metadata-external-access.md) %}

## Accessing metadata from inside the VM instance {#external-access}

{% include [vm-metadata](../../../_includes/vm-metadata.md) %}

### HTTP request {#gce-http}

{% include [internal-http-request](../../../_includes/compute/metadata/internal-http-request.md) %}

### Request examples {#request-examples}

{% include [internal-request-examples](../../../_includes/compute/metadata/internal-request-examples.md) %}