---
title: Query history in {{ ycdr-full-name }}
description: Follow this guide to learn how to use query history in {{ ycdr-name }}.
---

# History

{% include [preview-by-request](../../../_includes/note-preview-by-request.md) %}

This section describes how to use query history.

## Viewing previous runs {#view-history}

To view details of a run:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the query history.
  1. Select a run from the list.
  1. View the run details.

{% endlist %}

The query history displays a list of previous runs with the following details:

* Date and time of the query.
* Query text.
* Time period.
* Execution status.
* Number of results.

## Running a historical query {#run-from-history}

To run a historical query:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the query history.
  1. Find the run you need.
  1. Click **{{ ui-key.yacloud_org.security.siem.cell-result-action-launch_v9v5f }}**.

  The query will use the parameters from the selected run.

{% endlist %}

## Editing a historical query {#edit-from-history}

To edit a historical query:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the query history.
  1. Find the run you need.
  1. Click **Edit**.

  This will copy the query text to the editor so you can make changes and run the query with new parameters.

{% endlist %}

## Sharing a historical query {#share-from-history}

To share a historical query:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Open the query history.
  1. Find the run you need.
  1. Click **{{ ui-key.yacloud_org.security.siem.cell-result-action-share_i1khy }}**.
  1. Copy the link.

  This link contains the query text and time period from the selected run.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/investigations.md)
* [{#T}](../../concepts/queries.md)
* [{#T}](manage-queries.md)
* [{#T}](work-with-templates.md)
* [{#T}](../../kql-reference.md)