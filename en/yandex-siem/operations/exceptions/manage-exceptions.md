---
title: Managing exceptions in {{ yandex-siem-full-name }}
description: Follow this guide to learn how to create, edit, disable, and delete exceptions in {{ yandex-siem-full-name }}.
---

# Managing exceptions

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

This section describes how to create exceptions, manage their settings, and perform basic operations with them.

## Getting started {#before-you-begin}

{% include [before-you-begin](../../../_includes/yandex-siem/before-you-begin.md) %}

## Creating an exception from a correlation rule {#create-from-rule}

To create an exception from a correlation rule:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. In the rule's row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.security.siem.action_create-exception_bLSu4 }}**.
  1. Under **{{ ui-key.yacloud_org.security.siem.condition_title_gAfRm }}**, add one or more `key = value` pairs for events that should not trigger the rule.
  1. Under **Parameters**, fill in the required **{{ ui-key.yacloud_org.security.siem.label_name_udzhS }}** field, and, optionally, the **{{ ui-key.yacloud_org.security.siem.label_description_4xXeP }}** field.
  1. Click **{{ ui-key.yacloud_org.siem.SearchActionButtonBlock.save }}**.

  The associated rule will be filled in automatically.

{% endlist %}

## Creating an exception from the exceptions section {#create-from-exceptions}

To create an exception from the exceptions section:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. Click **{{ ui-key.yacloud_org.security.siem.ExceptionsPage.create-exception }}**.
  1. From the list that opens, select the correlation rule you are creating the exception for.
  1. Under **{{ ui-key.yacloud_org.security.siem.condition_title_gAfRm }}**, add one or more `key = value` pairs for events that should not trigger the rule.
  1. Under **Parameters**, fill in the required **{{ ui-key.yacloud_org.security.siem.label_name_udzhS }}** field, and, optionally, the **{{ ui-key.yacloud_org.security.siem.label_description_4xXeP }}** field.
  1. Click **{{ ui-key.yacloud_org.siem.SearchActionButtonBlock.save }}**.

{% endlist %}

## Editing an exception {#edit}

To edit exception settings:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. In the exception row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.header_action_edit }}**.
  1. Edit the fields as needed.
  1. Click **{{ ui-key.yacloud_org.siem.SearchActionButtonBlock.save }}**.

{% endlist %}

## Disabling an exception {#disable}

To disable an exception:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. In the exception row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.security.siem.action_switch-off_kYx8w }}**.

  A disabled exception changes its status to **Inactive** and will no longer apply when processing events.

{% endlist %}

## Resetting changes {#reset}

To reset the changes you made to the exception to the last deployed version:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. In the exception row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.security.siem.action_reset-changes_eXJka }}**.

  All unsaved changed will be canceled. The exception will reset to the last deployed configuration.

{% endlist %}

## Deleting an exception {#delete}

To delete an exception:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ yandex-siem-full-name }}**.
  1. Navigate to **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. In the exception row, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.header_action_delete }}**.
  1. Confirm the deletion.

  {% note warning %}

  Exception deletion is irreversible. All exception settings will be cleared.

  {% endnote %}

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/correlation-rules.md)
* [{#T}](../correlation-rules/manage-rules.md)
* [{#T}](exceptions-list.md)
