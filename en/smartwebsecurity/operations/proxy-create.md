---
title: How to create a proxy server in {{ sws-full-name }}
description: Follow this guide to create a proxy server to process incoming requests and protect domains in {{ sws-full-name }}.
---

# Creating a proxy server

{% note info %}

The proxy server has an MTU limit of 1,450 bytes for all packets.

{% endnote %}

{% list tabs group=instructions %}

A [proxy server](../concepts/domain-protect.md#proxy) accepts requests from users to your website or web application and forwards them for validation. 

You can add multiple proxy servers, for example, to separate the application's stable version from a version under development.

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**.
  1. Click **{{ ui-key.yacloud.smart-web-security.ProxyServers.createProxyServer_jatYQ }}**.
  1. Enter a name for the proxy server.
  1. Optionally, provide a description.
  1. Optionally, add [labels](../../resource-manager/concepts/labels.md).
  1. Optionally, to save detailed information about operations with requests:

      1. Enable **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.swith-enable-logging_e42nT }}**.
      1. Select an existing log group or [create a new one](../../logging/operations/create-group.md).
      1. Optionally, to reduce the stored log data volume, add log discard rules:

          1. Click **{{ ui-key.yacloud.smart-web-security.ProxyServerForm.add-rule_fnmLk }}**.
          1. Select **HTTP codes** and, optionally, **HTTP code classes** to discard logs for.
          1. Specify what percentage of logs to discard.
          1. Add more rules to use different discard percentages for different HTTP codes.
  1. Click **{{ ui-key.yacloud.smart-web-security.ProxyServerFormCreate.createServer_sycVk }}**.

{% include [after-proxy-create](../../_includes/smartwebsecurity/after-proxy-create.md) %}

{% endlist %}

### See also {#see-also}

* [{#T}](domain-create.md)
