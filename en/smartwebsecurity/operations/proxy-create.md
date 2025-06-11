---
title: How to create a proxy server in {{ sws-full-name }}
description: Follow this guide to create a proxy server to process incoming requests and protect domains in {{ sws-full-name }}.
---

# Creating a proxy server

{% list tabs group=instructions %}

A [proxy server](../concepts/domain-protect.md#proxy) accepts requests from users to your website or web application and forwards them for validation. 

You can add multiple proxy servers, for example, to separate the application's stable version from a version under development.

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Open the **Domain protection** section.
  1. Click **Create proxy server**.
  1. Enter a name for the proxy server.
  1. Optionally, enter a description.
  1. Optionally, add [labels](../../resource-manager/concepts/labels.md).
  1. To save detailed information about operations with requests:
     1. Enable the **Log requests** option.
     1. Select an existing log group or [create a new one](../../logging/operations/create-group.md).
  1. To reduce the volume of logs in storage, add log discard rules:
      1. Click **Add rule**.
      1. Select **HTTP codes** or **HTTP code classes** for which logs will be discarded.
      1. Specify what percentage of logs to discard.
      1. Add another rule if a different percentage is required for different HTTP codes.
  1. Click **Create server**.

{% include [after-proxy-create](../../_includes/smartwebsecurity/after-proxy-create.md) %}

{% endlist %}

### See also {#see-also}

* [{#T}](domain-create.md)
