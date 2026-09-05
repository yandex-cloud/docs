---
title: Adding a mailing list in {{ datalens-full-name }}
description: This article describes what mailing lists you can add in {{ datalens-full-name }}.
---

# Adding a mailing list in {{ datalens-full-name }}

You can set up a [mailing list for a dashboard](../operations/dashboard/add-maillists.md) by email. Recipients will get emails with links to the dashboard and chart states specified in the mailing list settings. You can configure the dashboard selector states, schedule, chart sizes, and other parameters. Mailing lists are only available for the current version of a dashboard.

You can also set up a [mailing list for a report](../reports/add-report-maillists.md) by email. Recipients will get a `.pdf` file with the report pages specified in the mailing list settings. You can configure the schedule and recipients of the mailing list.

{% note info %}

* A user with the [role](../security/roles.md#datalens-workbooks-editor) `Editor` or higher for the workbook can add or update a mailing list.
* Mailing lists are only available for dashboards and reports stored in [workbooks](../workbooks-collections/index.md).
* [RLS](../security/row-level-security.md) is not supported in mailing lists.
* If a mailing list uses [shared objects](../security/workbooks-access-advanced.md), only the ones with access delegation configured are supported.

{% endnote %}

Only users who have a role for the workbook the mailing list is configured in can receive the mailing list.

The user's permissions for the workbook are checked when the user is added to the mailing list and every time it is sent.

{% include [datdatalens-maillist-add-recipients](../../_includes/datalens/datalens-maillist-add-recipients.md) %}

A user with access to the workbook that stores the mailing list (minimum role: `Limited viewer`) can subscribe to it.
