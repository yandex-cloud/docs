---
title: '{{ si-full-name }} is decommissioned'
description: '{{ si-full-name }} ceased to operate.'
---

# {{ si-full-name }} is decommissioned

{% note warning %}

{{ si-full-name }} ceased to operate on October 8, 2026.

{% endnote %}

## What happened {#what-happens}

{{ si-full-name }} that brought together multiple features ceased to operate. The features themselves remain available in the platform’s other services:

* {{ sw-full-name }} moved to [{{ ai-studio-name }}]({{ link-docs-ai }}ai-studio/concepts/workflows/workflow). All workflows and their associated logic remain unchanged.

* {{ er-name }} ceased to operate. You can use triggers for {{ sf-name }}, {{ serverless-containers-name }}, {{ api-gw-name }}, and {{ sw-name }} instead.

* {{ api-gw-full-name }} remains available as a standalone service.

## What happens to your data {#data}

Your data backups (buses, connectors, and rules) will remain available until January 31, 2027. To get them, you will need to contact our [support]({{ link-console-support }}).

## Migration {#migration}

You can use triggers as an alternative to {{ er-name }} buses. Some buses have migrated automatically, while others still require you to migrate them manually.

We have prepared a guide to help you with migration: [{#T}](tutorials/eventrouter-migration.md).

{% note warning %}

We recommend that you migrate all buses by yourself. With automatic migration, there is no guarantee that the system will function completely the same after the migration.

{% endnote %}

## Further questions {#support}

If you have any questions regarding {{ yq-full-name }} shutdown:

* Contact [support]({{ link-console-support }}).
* Contact your account manager.

Thank you for using {{ si-full-name }}.
