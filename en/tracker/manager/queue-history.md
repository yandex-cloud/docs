---
title: "How to view the history of queue changes "
description: "Follow this guide to view history of queue changes."
---

# Viewing the history of queue changes

{% note warning %}

Only the queue's owner can configure the queue by default.

{% endnote %}

The log includes records about the changes in queue settings. Each record includes the date, author, and contents of the change.

## Viewing changelogs {#show-log}

1. Open the queue page.

1. In the top-right corner of the page, click ![](../../_assets/tracker/svg/settings-old.svg) **{{ ui-key.startrek.ui_components_PageQueue_header.settings }}**.

1. Go to the **{{ ui-key.startrek.blocks-desktop_b-page-queue-admin.tab-title--events }}** tab.

## Filtering entries {#filter-records}

To find a record in the log, use filters:

![image](../../_assets/tracker/queue-history.png)

1. **By author**
    Find changes made by a certain user.

1. **By change type**
    View changes in settings belonging to a certain type.

1. **{{ ui-key.startrek.blocks-desktop_b-filter.by-components }}**
    View changes in components: creation, deletion, parameter changes, etc.

1. **{{ ui-key.startrek.blocks-desktop_b-file-list_sort_yes.date }}**
    Find changes over a period. You can select an interval or set only the start or end date in a range.

1. **Reset filters**
    To cancel the filter action, click Reset.
