---
title: "How to stop or resume a node"
description: "Follow this guide to stop or resume a node."
---

# Stopping or resuming a node

## Stopping a node {#suspend}

Instances and [billing](../../pricing.md#node) will stop alongside the node, but the node with all its settings will remain in the project.

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. In the line with the appropriate [node](../../concepts/deploy/index.md#node), click ![options](../../../_assets/console-icons/ellipsis.svg) and select ![Suspend](../../../_assets/console-icons/circle-pause.svg) **{{ ui-key.yc-ui-datasphere.common.suspend }}**.

## Resuming a node {#resume}

Resuming a node will restart instances and billing.

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. In the line with the appropriate node, click ![options](../../../_assets/console-icons/ellipsis.svg) and select ![Resume](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yc-ui-datasphere.common.resume }}**.

{% note warning %}

The node will not resume if the required [VM configurations](../../concepts/configurations.md) are occupied during restart. If an error occurs, try again in a few minutes.

{% endnote %}
