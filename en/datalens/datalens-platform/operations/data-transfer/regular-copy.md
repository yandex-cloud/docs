---
title: Regular copying in {{ datalens-platform-full-name }}
description: Follow this guide to create a `Regular copy` data delivery in {{ datalens-platform-full-name }}
---

# Creating a regular copy job

A [regular copy](../../concepts/data-transfer/index.md#regular-copy) job regularly transfers data from a source to a selected namespace in the [REST catalog](../../concepts/rest-catalog/index.md), according to a defined schedule. This way, the target keeps your data up to date with no need for a manual data reload.

{% include [sources](../../../../_includes/dlp/transfer/sources.md) %}

To create a regular copy job:

{% include [regular-copy](../../../../_includes/dlp/transfer/regular-copy-instruction.md) %}

{% include [activate](../../../../_includes/dlp/transfer/activate.md) %}

To check the result:

1. On the ingestion page, open the namespace in the REST catalog.
1. Make sure it contains your selected tables.
1. Open a table and verify its structure and data under **Preview**.

Read more about [updating the settings](manage-transfer.md#update-transfer) and [pausing a delivery](manage-transfer.md#pause-transfer).
