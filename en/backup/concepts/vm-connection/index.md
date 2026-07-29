---
title: Connecting resources you need to back up to {{ backup-name }}
description: In this article, you will learn what resources can be connected to {{ backup-name }}.
---

# Connecting resources you need to back up to {{ backup-name }}


To back up your [{{ compute-full-name }}](../../../compute/index.yaml) [VMs](../../../compute/concepts/vm.md), [{{ baremetal-name }} servers](../../../baremetal/concepts/servers.md), or other [resources](../index.md#protected-resources) in {{ backup-name }}, you need to connect these resources to {{ backup-name }} and set them up properly.

You connect a resource you need to back up by installing the [{{ backup-name }} agent](../agent.md) to its [operating system](#os). Depending on the type of resource you need to back up, the agent can be installed either automatically or manually.

For more information about connecting various types of resources to {{ backup-name }}, see these sections:

* [Connecting {{ compute-name }} VMs](./compute.md).
* [Connecting {{ baremetal-name }} servers](./baremetal.md).
* [Connecting VMs and servers from outside {{ yandex-cloud }}](./external-resources.md).

## Operating systems supported by {{ backup-name }} {#os}

Automatic installation of the {{ backup-name }} agent is available only for {{ compute-full-name }} VMs and {{ baremetal-full-name }} servers with particular operating systems. For more information, see [Connecting a {{ compute-name }} VM](./compute.md) and [Connecting a {{ baremetal-name }} server](./baremetal.md).

You can install the {{ backup-name }} agent manually on all supported types of resources. For a complete list of operating systems supporting agent installation, see the [backup provider guides](https://docs.cyberprotect.ru/ru-RU/CyberBackupCloud/21.06/user/#supported-operating-systems-and-environments.html).

## Technical requirements for resources to back up {#requirements}

{% include [vm-requirements](../../../_includes/backup/vm-requirements.md) %}

## Supported file systems {#file-systems}

{% include [fss-supported](../../../_includes/backup/fss-supported.md) %}

#### See also {#see-also}

* [{#T}](./compute.md)
* [{#T}](./baremetal.md)
* [{#T}](./external-resources.md)