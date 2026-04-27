---
title: Managing correlation rules in {{ yandex-siem-full-name }}
description: Follow this guide to learn how to create, edit, disable, and delete correlation rules in {{ yandex-siem-full-name }}.
---

# Managing correlation rules

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

This section describes how to create correlation rules, manage their settings, and perform basic operations with them.

## Getting started {#before-you-begin}

{% include [before-you-begin](../../../_includes/yandex-siem/before-you-begin.md) %}

## Creating a correlation rule {#create}

To create a correlation rule:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. Click **{{ ui-key.yacloud_org.security.siem.CorrelationRulesPage.create-correlation-rule }}**.
  1. In the **Correlation condition** field, enter your KQL query. Use templates, schema, or datasets as needed.
  1. Under **Aggregation**, specify the aggregation key and aggregation window.
  1. Under **{{ ui-key.yacloud_org.security.siem.detect-overview.title-actions-on-trigger_j8dE3 }}**, configure the new alert by setting its name, type, and classification.
  1. Under **Parameters**, fill in the required **{{ ui-key.yacloud_org.security.siem.label_name_udzhS }}** field, and, optionally, **{{ ui-key.yacloud_org.security.siem.label_description_4xXeP }}**, **{{ ui-key.yacloud_org.security.siem.CorrelationRuleTable.category }}**, and **Trigger severity**.
  1. Click **{{ ui-key.yacloud_org.siem.SearchActionButtonBlock.save }}**.

{% endlist %}

## Editing a rule {#edit}

To change edit a correlation rule:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. In the rule's row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.header_action_edit }}**.
  1. Edit the fields as needed.
  1. Click **{{ ui-key.yacloud_org.siem.SearchActionButtonBlock.save }}**.

{% endlist %}

## Disabling a rule {#disable}

To disable a correlation rule:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. In the rule's row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.security.siem.action_switch-off_kYx8w }}**.

  A disabled rule changes its status to **Inactive** and stops processing events.

{% endlist %}

## Resetting changes {#reset}

To reset the changes you made to the rule to the last deployed version:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. In the rule's row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.security.siem.action_reset-changes_eXJka }}**.

  All unsaved changed will be canceled. The rule will reset to the last deployed configuration.

{% endlist %}

## Deleting a rule {#delete}

You can only delete custom rules. You cannot delete preset rules.

To delete a custom correlation rule:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. In the rule's row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.header_action_delete }}**.
  1. Confirm the deletion.

  {% note warning %}

  Deleting a rule is irreversible. All rule settings will be deleted.

  {% endnote %}

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/correlation-rules.md)
* [{#T}](../exceptions/manage-exceptions.md)
* [{#T}](rules-list.md)
