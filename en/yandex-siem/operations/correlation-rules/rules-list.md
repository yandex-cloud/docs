---
title: Working with a list of correlation rules in {{ yandex-siem-full-name }}
description: Follow this guide to learn how to view correlation rules, filter them, and manage their deployment in {{ yandex-siem-full-name }}.
---

# Working with a list of correlation rules

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

This section describes how to view a list of correlation rules, apply filters, and manage rule deployment.

## Getting started {#before-you-begin}

{% include [before-you-begin](../../../_includes/yandex-siem/before-you-begin.md) %}

## Viewing a list of rules {#list}

To view a list of correlation rules:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.

  You will see a list of all available rules and their statuses. Click a column header to sort the list by that column.

{% endlist %}

## Rule filtering {#filter}

To filter correlation rules based on specific criteria:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. Use filters above the list:
     * **Status**: Filter rules by status: **Healthy**, **Unhealthy**, or **Inactive**.
     * **Type**: Filter by type: **Preset** or **Custom**.
     * **{{ ui-key.yacloud_org.security.siem.CorrelationRuleTable.category }}**: Filter by threat category.
     * **Severity**: Filter by trigger severity level.

  The list will refresh to show only rules that match the selected criteria.

{% endlist %}

## Staging a rule for deployment {#mark-for-deploy}

To apply changes to a rule, stage it for deployment:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. In the rule's row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.security.siem.action_mark-for-deployment_sUf3V }}**.

  The rule deployment status will switch to **{{ ui-key.yacloud_org.security.siem.detect-deployment_created_2GEyZ }}**. Once deployment is complete, the status will change to **{{ ui-key.yacloud_org.security.siem.detect-deployment_deployed_ejgvu }}**.

{% endlist %}

## Canceling rule deployment {#cancel-deploy}

To cancel a scheduled rule deployment:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. In the rule's row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.security.siem.action_not-deploy_sPzwj }}**.

  The rule deployment status will switch back to **{{ ui-key.yacloud_org.security.siem.deployment_status_changed }}**.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/correlation-rules.md)
* [{#T}](manage-rules.md)
* [{#T}](../exceptions/manage-exceptions.md)
