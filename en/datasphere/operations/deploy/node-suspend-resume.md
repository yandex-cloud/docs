---
title: How to suspend or resume a node
description: Follow this guide to suspend or resume a node.
---

# Suspending or resuming a node

## Suspending a node {#suspend}

Suspending a node will also stop instances and [billing](../../pricing.md#node), while keeping the node with all its settings in the project.

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. Next to the [node](../../concepts/deploy/index.md#node) in question, click ![options](../../../_assets/console-icons/ellipsis.svg) and select ![Suspend](../../../_assets/console-icons/circle-pause.svg) **{{ ui-key.yc-ui-datasphere.common.suspend }}**.

## Resuming a node {#resume}

Resuming a node will restart instances and billing.

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. Next the node in question, click ![options](../../../_assets/console-icons/ellipsis.svg) and select ![Resume](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yc-ui-datasphere.common.resume }}**.

{% note warning %}

The node will not resume if the required [VM configurations](../../concepts/configurations.md) are already in use during restart. If an error occurs, try again in a few minutes.

{% endnote %}
