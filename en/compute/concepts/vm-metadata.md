---
title: '{{ compute-name }} VM instance metadata'
description: In this article, you will learn about metadata available in the {{ compute-full-name }} VM instance metadata service.
---

# VM metadata

{% note info %}

You can [get](./metadata/accessing-metadata.md) direct access (without authentication) to metadata through a special [metadata service](#metadata-formats) available inside the VM instance using the following URL: `http://169.254.169.254`. The metadata service inside the VM instance is available to all VM instances regardless of their network settings and internet access.

{% endnote %}

_VM instance metadata_ is metadata (additional data) about the [VM instance](./vm.md).

The VM instance metadata service stores metadata in [folders](./metadata/directories.md) as `key-value` pairs. 

You can use metadata:
* To enable the [cloud-init](https://cloudinit.readthedocs.io/en/latest/index.html) process when creating a VM instance.
* To provide the required information in the `user-data` key to services or applications run on the VM instance after it is created.
* To get data from inside the VM instance required for authentication in {{ yandex-cloud }}.

The VM instance ID, {{ marketplace-name }} [image](./image.md) ID, and a number of other metadata values together form a unique [identity document](./metadata/identity-document.md) of the VM instance.

## VM instance metadata service parameters {#metadata-formats}

In {{ yandex-cloud }}, you can access VM instance metadata in [Google Compute Engine](https://en.wikipedia.org/wiki/Google_Compute_Engine) format (not all fields are supported). This is the most secure and recommended format for VM instance metadata. Be sure to use the `Metadata-Flavor:Google` HTTP header when [accessing](./metadata/accessing-metadata.md) the metadata service.

{{ compute-name }} VMs support the following VM metadata service settings:

{% include [metadata-service-settings](../../_includes/compute/metadata-service-settings.md) %}

You can get the current VM instance metadata service parameters together with the [VM information](./metadata/accessing-metadata.md#external-access) using the [CLI](../../cli/cli-ref/compute/cli-ref/instance/get.md) and [API](../api-ref/Instance/get.md).

You can configure the metadata service when [creating](../operations/index.md#vm-create) or [updating](../operations/vm-control/vm-update.md) VMs. For more information on how to configure the metadata service, see [this guide](../operations/vm-metadata/setup-metadata-service.md).

#### See also {#see-also}

* [{#T}](./metadata/directories.md)
* [{#T}](./metadata/public-image-keys.md)
* [{#T}](./metadata/sending-metadata.md)
* [{#T}](./metadata/accessing-metadata.md)
* [{#T}](./metadata/identity-document.md)
* [{#T}](instance-groups/instance-template.md)