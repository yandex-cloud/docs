---
title: Managing investigations in {{ ycdr-full-name }}
description: Follow this guide to learn how to create, update, copy, and delete investigations in {{ ycdr-name }}.
---

# Managing investigations

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

This section describes how to create investigations, manage their settings, and perform basic operations with them.

## Getting started {#before-you-begin}

{% include [before-you-begin](../../../_includes/ycdr/before-you-begin.md) %}

## Creating an investigation {#create}

To create an investigation:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ ycdr-name }}**.
  1. Navigate to the **{{ ui-key.yacloud_org.security.ycdr.YcdrPageLayout.investigations_wYxSe }}** tab.
  1. Click **{{ ui-key.yacloud_org.security.siem.InvestigationsPage.create-investigation_iCPUP }}**.
  1. Enter a name for your investigation in the header field.
  1. Under **{{ ui-key.yacloud_org.security.siem.InvestigationPageLayout.fieldDescription_wiAxw }}**, add a description for your investigation.

  {% note tip %}

  Use clear names that reflect the investigation objective, e.g., `Failed login analysis for February` or `Prod cluster suspicious activity`.

  {% endnote %}

{% endlist %}

## Updating an investigation {#edit}

### Renaming an investigation {#rename}

To rename an investigation:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the investigation.
  1. At the top of the page, click the investigation name.
  1. Enter a new name.
  1. Press **Enter** or click outside the input field.

{% endlist %}

### Editing a description {#edit-description}

To edit an investigation description:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open an investigation.
  1. Under **{{ ui-key.yacloud_org.security.siem.InvestigationPageLayout.information_cZr8L }}**, click the **{{ ui-key.yacloud_org.security.siem.InvestigationPageLayout.fieldDescription_wiAxw }}** field.
  1. Enter a new description.
  1. Press **Enter** or click outside the input field.

{% endlist %}


## Copying an investigation {#copy}

To create an investigation copy:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open an investigation.
  1. In the actions menu, select **{{ ui-key.yacloud_org.security.siem.InvestigationPageLayout.copy_wiAxw }}**.
  1. Wait until the copy is created.

  The copy inherits all requests and settings of the original investigation.

{% endlist %}

## Deleting an investigation {#delete}

To delete an investigation:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open an investigation.
  1. In the actions menu, select **{{ ui-key.yacloud_org.security.siem.action_delete_wM5k5 }}**.
  1. Confirm the deletion.

  {% note warning %}

  Deleting an investigation is irreversible. All requests and results will be deleted.

  {% endnote %}

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/investigations.md)
* [{#T}](../../concepts/queries.md)
* [{#T}](investigations-list.md)
* [{#T}](../queries/index.md)