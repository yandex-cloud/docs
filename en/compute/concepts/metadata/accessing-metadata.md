---
title: Getting the {{ compute-name }} VM instance metadata
description: In this article, you will learn about the ways to get {{ compute-full-name }} VM instance metadata.
---

# Access to VM instance metadata

The [metadata service](../vm-metadata.md) allows you to [read](../../operations/vm-metadata/get-vm-metadata.md) metadata from both [outside](#external-access) and [inside](#internal-access) VM instances.

## Accessing metadata from outside the VM instance {#external-access}

You can [access](../../operations/vm-metadata/get-vm-metadata.md#external-access) VM instance metadata from the outside using the following {{ yandex-cloud }} tools: the [management console]({{ link-console-main }}), [CLI](../../../cli/cli-ref/compute/cli-ref/instance/get.md), [{{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md), and [API](../../api-ref/Instance/get.md). 

{% include [external-access-directories](../../../_includes/compute/metadata/external-access-directories.md) %}

## Accessing metadata from inside the VM instance {#external-access}

{% include [vm-metadata](../../../_includes/vm-metadata.md) %}

For more information on getting metadata from inside the VM instance, see [Examples of requests to the metadata service from inside the VM instance](../../operations/vm-metadata/get-vm-metadata.md#request-examples).

#### See also {#see-also}

* [Getting VM instance metadata](../../operations/vm-metadata/get-vm-metadata.md)
* [{#T}](../vm-metadata.md)
* [{#T}](./directories.md)
* [{#T}](./public-image-keys.md)
* [{#T}](./sending-metadata.md)
* [{#T}](./identity-document.md)