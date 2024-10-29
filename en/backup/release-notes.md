---
title: '{{ backup-full-name }} release notes'
description: This section contains {{ backup-name }} release notes.
---

# {{ backup-full-name }} release notes

## Q2 2024 {#q2-2024}

* Updated the {{ backup-name }} backup agent.
* Added support for new operating systems:
  * [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts)
  * [Ubuntu 22.04 LTS OS Login](/marketplace/products/yc/ubuntu-2204-lts-oslogin)
  * [CentOS Stream](/marketplace/products/yc/centos-stream-8)
  * [Astra Linux SE 1.7 Voronezh](/marketplace/products/astralinux/alse)
  * [Astra Linux SE 1.7 Orel](/marketplace/products/astralinux/alse-orel)
* Added support for images with OS Login:
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