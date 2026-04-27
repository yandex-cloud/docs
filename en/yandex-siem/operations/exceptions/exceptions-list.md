---
title: Working with a list of exceptions in {{ yandex-siem-full-name }}
description: Follow this guide to learn how to view exceptions, filter them, and manage their deployment in {{ yandex-siem-full-name }}.
---

# Working with a list of exceptions

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

This section describes how to view a list of exceptions, apply filters, and manage exception deployment.

## Getting started {#before-you-begin}

{% include [before-you-begin](../../../_includes/yandex-siem/before-you-begin.md) %}

## Viewing a list of exceptions {#list}

To view a list of exceptions:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.

  You will see a list of all available exceptions and their statuses.

{% endlist %}

## Filtering exceptions {#filter}

To filter exceptions based on specific criteria:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. Use filters above the list:
     * **Status**: Filter exceptions by status: **Healthy**, **Unhealthy**, or **Inactive**.
     * **Attached rule**: Filter by the correlation rule attached to the exception.

  The list will refresh to show only exceptions that match the selected criteria.

{% endlist %}

## Staging an exception for deployment {#mark-for-deploy}

To apply changes to an exception, stage it for deployment:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. In the exception row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.security.siem.action_mark-for-deployment_sUf3V }}**.

  The exception deployment status will switch to **{{ ui-key.yacloud_org.security.siem.detect-deployment_created_2GEyZ }}**. Once deployment is complete, the status will change to **{{ ui-key.yacloud_org.security.siem.detect-deployment_deployed_ejgvu }}**.

{% endlist %}

## Canceling exception deployment {#cancel-deploy}

To cancel a scheduled exception deployment:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. In the exception row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.security.siem.action_not-deploy_sPzwj }}**.

  The exception deployment status will switch back to **{{ ui-key.yacloud_org.security.siem.deployment_status_changed }}**.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/correlation-rules.md)
* [{#T}](manage-exceptions.md)
* [{#T}](../correlation-rules/manage-rules.md)
