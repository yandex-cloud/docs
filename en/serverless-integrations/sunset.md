---
title: '{{ si-full-name }} shutdown'
description: We are sunsetting {{ si-full-name }}. This page outlines the decommissioning timeline and procedure, and provides migration recommendations.
---

# {{ si-full-name }} shutdown

{% note warning %}

We are sunsetting {{ si-full-name }}. This page outlines the decommissioning timeline and procedure, and provides migration recommendations.

{% endnote %}

## What's happening {#what-happens}

We are sunsetting {{ si-full-name }} that brought together multiple features. The features themselves remain available in the platform's other services:

* {{ sw-full-name }} moves to [{{ ai-studio-name }}]({{ link-docs-ai }}ai-studio/concepts/workflows/workflow). All workflows and their associated logic remain unchanged.

* We are sunsetting {{ er-name }}. You can use triggers for {{ sf-name }}, {{ serverless-containers-name }}, {{ api-gw-name }}, and {{ sw-name }} instead.

* {{ api-gw-full-name }} will remain available as a standalone service.

## Key dates {#key-dates}

The {{ si-full-name }} decommissioning process will follow these three stages:

* **September 4, 2026**: {{ sw-name }} will no longer be supported in the {{ yandex-cloud }} UI. To create and manage workflows, use the [{{ ai-studio-name }} UI]({{ link-console-ai }}/link//workflows).

* **September 15, 2026**: {{ er-name }} switches to read-only mode. You will no longer be able to create new buses, connectors, and rules.

* **December 8, 2026**: Full {{ si-full-name }} decommissioning. Access to the interface will be disabled for all users.

## What happens to your data {#data}

None of your data (buses, connectors, and rules) will be lost. After decommissioning, we will retain backups of your data until January 31, 2027. To get them, you will need to contact our [support]({{ link-console-support }}).

All workflows will be automatically migrated to {{ ai-studio-name }}.

## Migration {#migration}

You can use triggers as an alternative to {{ er-name }} buses. Some buses will be migrated automatically, while others will require manual migration.

We have prepared a guide to help you with migration: [{#T}](tutorials/eventrouter-migration.md).

{% note warning %}

We recommend that you migrate all buses by yourself. With automatic migration, there is no guarantee that the system will function completely the same after the migration.

{% endnote %}

## Further questions {#support}

If you have any questions related to service shutdown:

* Contact [support]({{ link-console-support }}).
* Contact your account manager.

Thank you for using {{ si-full-name }}.
