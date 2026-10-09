---
title: '{{ cloud-desktop-full-name }} shutdown'
description: Read on to learn when {{ cloud-desktop-name }} will be discontinued and how to save or migrate your data.
---

# {{ cloud-desktop-full-name }} shutdown

{% note warning %}

{{ cloud-desktop-full-name }} will be discontinued on December 14, 2026. Make sure to save your important data and migrate your desktop to another service before it happens.

{% endnote %}

## What is going on {#what-happens}

We have made the decision to discontinue {{ cloud-desktop-full-name }} since our product strategy changed. See below to learn when it will happen and how to migrate your desktops.

## Key dates {#key-dates}

The discontinuation process will follow these three stages:

* **October 13, 2026**: {{ cloud-desktop-name }} will become unavailable to new users. Those users who started using it before will be able to continue working with it.

* **November 10, 2026**: {{ cloud-desktop-name }} will go read-only. You will no longer be able to modify resources. You will still be able to copy your data and delete resources.

* **December 14, 2026**: {{ cloud-desktop-name }} will be fully discontinued. Your desktops will be stopped an you will no longer be able to access {{ cloud-desktop-name }} through the management console API, or CLI.

## What happens to your data {#data}

Your data backups and logs will be saved in a long-term storage. To restore your data after {{ cloud-desktop-name }} is discontinued, contact our [support]({{ link-console-support }}).

You may want to copy your desktop files and settings you need to another storage in advance, so that you may still have access to them after discontinuation.

## Migration {#migration}

{{ yandex-cloud }} does not have any service to offer that would exactly replace {{ cloud-desktop-name }}. As an alternative, you can consider [{{ baremetal-name }} {{ baremetal-extend-virtualization-name }}](../baremetal/concepts/extend/virtualization.md), which is a virtualization platform deployed on dedicated servers. It allows you to create and configure dedicated VDI clusters.

Please note that {{ baremetal-extend-virtualization-name }} is build for infrastructures that include hundreds of desktops. The fee for using it is calculated on a case-by-case basis.

If you want to learn more about testing and possible migration to this solution, [submit a request](../baremetal/operations/extend/virtualization.md) or contact your account manager.

Before {{ cloud-desktop-name }} is discontinued:

1. Save the copies of your desktop files and settings you need.
1. Migrate your runtime environment to the service of your choice and check whether the apps and data access work correctly.
1. Once you made sure everything works fine, [delete the desktops](operations/desktops/delete.md) you no longer need.

## Further questions {#support}

If you have any questions about the discontinuation or require assistance with your migration:

* Contact [support]({{ link-console-support }}).
* Contact your account manager.

Thank you for using {{ cloud-desktop-name }}.
