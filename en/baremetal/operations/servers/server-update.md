---
title: How to update a server in {{ baremetal-full-name }}
description: In this tutorial, you will learn how to update your {{ baremetal-full-name }} server’s name and description.
---

# Updating a server

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the server belongs to.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the row with the server you need, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. If required, change the server’s name, description, labels, lease duration, and network settings.

      {% note info %}

      The lease duration setting changes will apply only after the current server lease period expires.

      {% endnote %}

  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}
