---
title: Working with the investigation list in {{ ycdr-full-name }}
description: Follow this guide to learn how to filter, search, and sort investigations in {{ ycdr-name }}.
---

# Working with the investigation list

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

This section describes how to work with the investigations list: filter investigations by date, search by name and tags, and sort by modification date.

## Getting started {#before-you-begin}

{% include [before-you-begin](../../../_includes/ycdr/before-you-begin.md) %}

## Opening the investigation list {#open-list}

To open the investigation list:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select **{{ ycdr-name }}**.
  1. Navigate to the **{{ ui-key.yacloud_org.security.ycdr.YcdrPageLayout.investigations_wYxSe }}** tab.

  The list displays all investigations for which you have access permissions.

{% endlist %}

## Filtering by creation date {#filter-date}

To filter investigations by creation date:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to **{{ ui-key.yacloud_org.security.ycdr.YcdrPageLayout.investigations_wYxSe }}**.
  1. Click the date filter.
  1. Select a period:
     * Certain date.
     * Date range.
  1. Apply the filter.

  The list will refresh to only show investigations created within the selected period.

{% endlist %}

## Searching by name or tag {#search}

To find an investigation:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to **{{ ui-key.yacloud_org.security.ycdr.YcdrPageLayout.investigations_wYxSe }}**.
  1. Enter your keywords in the search field.
  1. The results will be displayed automatically.

  The system will search for keywords in the following fields:
  * Investigation name.
  * Investigation description.
  * Tags.

  {% note tip %}

  Use tags for quick category-based searches, e.g., `prod`, `security-incident`, `february-2024`.

  {% endnote %}

{% endlist %}

## Sorting by modification date {#sort}

To sort investigations:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to **{{ ui-key.yacloud_org.security.ycdr.YcdrPageLayout.investigations_wYxSe }}**.
  1. Click the **{{ ui-key.yacloud_org.security.siem.InvestigationPageLayout.fieldModified }}** column header.
  1. Select the sort order:
     * Ascending, i.e., from oldest to newest.
     * Descending, i.e., from newest to oldest.

  By default, investigations are sorted by modification date in descending order.

{% endlist %}

## Viewing investigation information {#view-info}

The investigations list displays the following details for each investigation:

* **Name**: Brief description of the investigation's purpose.
* **Creation date**: Timestamp when the investigation was created.
* **Last modified date**: Timestamp of the most recent modification.
* **Tags**: Keywords to group and search for investigations.

To open an investigation, click its name in the list.

#### See also {#see-also}

* [{#T}](../../concepts/investigations.md)
* [{#T}](../../concepts/queries.md)
* [{#T}](manage-investigations.md)
* [{#T}](../queries/index.md)