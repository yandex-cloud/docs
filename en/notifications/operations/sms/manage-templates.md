---
title: Managing SMS templates in {{ cns-full-name }}
description: Follow this guide to create and delete SMS notification templates in {{ cns-full-name }}.
---

# Managing SMS templates

{% include [sms-template-creation-intro](../../../_includes/notifications/sms-template-creation-intro.md) %}

## Creating an SMS template {#create}

{% include [sms-template-create](../../../_includes/notifications/sms-template-create.md) %}

## Deleting a template {#delete}

Before deleting an active SMS template on the {{ cns-name }} side, [deregister](#deregister) that template on the telecom provider side. You can delete templates in the `Deregistered` [status](../../concepts/sms.md#template-status) only.

### Deregistering a template {#deregister}

To deregister an SMS template in the `Active` status:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the template.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. In the left-hand panel, select ![route](../../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.cns.label_channels }}** and select a channel with an [individual sender](../../concepts/sms.md#individual-sender) you want to delete a template from.
  1. In the left-hand menu, select ![square-chart-bar](../../../_assets/console-icons/square-chart-bar.svg) **{{ ui-key.yacloud.cns.local.label_templates_26VqM }}**.
  1. In the row with the template, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select **Deregister**.
  1. In the window that opens, confirm deregistration.

{% endlist %}

The SMS template will now enter the `Deregistering` [status](../../concepts/sms.md#template-status) and be submitted for deregistration to the telecom providers. A [support]({{ link-console-support }}) ticket will be created at the same time. Once all telecom providers complete tempate deregistration, the template will become `Deregistered`, and you will be able to delete it from {{ cns-name }}.

### Deleting a deregistered template {#delete-deregistered}

To delete an SMS template in the `Deregistered` status:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the template.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. In the left-hand panel, select ![route](../../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.cns.label_channels }}** and select a channel with an [individual sender](../../concepts/sms.md#individual-sender) you want to delete a template from.
  1. In the left-hand menu, select ![square-chart-bar](../../../_assets/console-icons/square-chart-bar.svg) **{{ ui-key.yacloud.cns.local.label_templates_26VqM }}**.
  1. In the row with the template, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the deletion.

{% endlist %}

{% include [sms-template-delete-registering](../../../_includes/notifications/sms-template-delete-registering.md) %}

#### See also {#see-also}

* [{#T}](../../concepts/sms.md#templates)