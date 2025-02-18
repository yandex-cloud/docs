---
title: '{{ backup-full-name }} release notes'
description: This section contains {{ backup-name }} release notes.
---

# {{ backup-full-name }} release notes

## Q4 2024 {#q4-2024}

* Added support for new operating systems:
    * For {{ compute-full-name }} VMs:
      * [Debian 12](/marketplace/products/yc/debian-12)
      * [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-2404-lts-oslogin).
    * For {{ baremetal-full-name }} servers:
      * Debian 10
      * Debian 11
      * Ubuntu 24.04 LTS
* Added support for {{ baremetal-name }} server backup management in the [management console]({{ link-console-main }}).
* Added new [{{ yandex-cloud }} CLI](../cli/quickstart.md) features:
  * [Viewing](./operations/backup-vm/view-disk-layout.md) the parameters of backup disks and partitions.
  * Service [activation](./operations/activate-service.md).
  * [Connecting](./operations/connect-vm-oslogin-linux.md) and [reconnecting](./operations/refresh-connection-oslogin-linux.md) a VM with OS Login.

## Q3 2024 {#q3-2024}

* Enabled setting an existing backup policy when [creating a VM with a {{ backup-name }} connection](./operations/create-vm.md) in the management console, YC CLI, {{ TF }}, and API.
* Added support for a new data source in {{ TF }} [yandex_backup_policy]({{ tf-provider-datasources-link }}/backup_policy) to get information about a backup policy.
* Added a new resource in {{ TF }} [yandex_backup_policy_bindings]({{ tf-provider-resources-link }}/backup_policy_bindings) to link VMs to backup policies.
* Implemented sending [service metrics](metrics.md) to {{ monitoring-full-name }}.
* Added the ability to [create](./operations/backup-vm/create.md) VM backups outside the backup policy schedule using the YC CLI.
* Added support for [{{ baremetal-full-name }}](./tutorials/backup-baremetal.md) server backups.

## Q2 2024 {#q2-2024}

* Updated the [{{ backup-name }} agent](concepts/agent.md).
* Added support for new operating systems:
  * [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts)
  * [Ubuntu 22.04 LTS OS Login](/marketplace/products/yc/ubuntu-2204-lts-oslogin)
  * [CentOS Stream](/marketplace/products/yc/centos-stream-8)
  * [Astra Linux SE 1.7 Voronezh](/marketplace/products/astralinux/alse)
  * [Astra Linux SE 1.7 Orel](/marketplace/products/astralinux/alse-orel)
* Added support for images with {{ oslogin }}:
  * [Ubuntu 20.04 LTS OS Login](/marketplace/products/yc/ubuntu-2004-lts-oslogin)
  * [Ubuntu 18.04 LTS OS Login](/marketplace/products/yc/ubuntu-1804-lts-oslogin)
  * [CentOS 7 OS Login](/marketplace/products/yc/centos-7-oslogin)
* Added the REST API [listTasks](./backup/api-ref/Resource/listTasks.md) method for the [Resource](./backup/api-ref/Resource/index.md) resource and the [ResourceService/ListTasks](backup/api-ref/grpc/Resource/listTasks.md) gRPC API call. You can use them to view the backup activities of connected VMs.
* Added the following parameters to the REST API methods for the [Resource](./backup/api-ref/Resource/index.md) resource and to the [ResourceService](backup/api-ref/grpc/Resource/index.md) gRPC API calls:
  * `initStatus`: VM initialization status in {{ backup-name }}.
  * `metadata`: Metadata for detailed information about the VM registration process in {{ backup-name }}.
* Added these events to the service's [audit logs](at-ref.md):
  * `InitResource`: Initializing a VM connection to {{ backup-name }}.
  * `UpdateResource`: Updating the status of a VM connection to {{ backup-name }}.

## Q1 2024 {#q1-2024}

* In the management console, on the ![list-check](../_assets/console-icons/list-check.svg) **Operations** tab, some inherently long-running tasks are now considered asynchronous operations, with a completion percentage added for certain actions.
* Updated the process of applying changes for [backup storage](./concepts/policy.md#retention) rules. By default, new rules will now take effect as soon as another backup is created.
* Added support for creation of a policy with the `scheduling.scheme=CUSTOM` custom backup schedule scheme. For more information, see [Backup policy specification](./concepts/policy.md#specification).