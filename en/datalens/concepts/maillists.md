---
title: Adding a mailing list in {{ datalens-full-name }}
description: This article explains what types of mailing lists you can add in {{ datalens-full-name }}.
---

# Adding a mailing list in {{ datalens-full-name }}

You can set up a [mailing list for a dashboard](../operations/dashboard/add-maillists.md). Recipients will be getting emails with links to the dashboard and chart states specified in the mailing list settings. You can set up the dashboard selector states, schedule, chart sizes, and other parameters. Mailing lists are available for the current dashboard version only.

Also, you can set up a [mailing list for a report](../reports/add-report-maillists.md). The email will deliver a `.pdf` file containing the report pages you specify in the mailing list settings. You can set up the schedule and your mailing list recipients.

{% note info %}

* To add or update a mailing list, you need the `Editor` [role](../security/roles.md#datalens-workbooks-editor) or higher for the workbook.
* Mailing lists are only available for dashboards and reports located in [workbooks](../workbooks-collections/index.md).
* Mailing lists do not support [RLS](../security/row-level-security.md).
* Mailing lists only support [shared objects](../security/workbooks-access-advanced.md) that are configured to allow delegated access permissions.

{% endnote %}

You can receive the newsletter only if you have a role for the workbook in which this newsletter is configured.

User permissions for the workbook are checked when you are added to the mailing list and each time the newsletter is sent.

{% include [datdatalens-maillist-add-recipients](../../_includes/datalens/datalens-maillist-add-recipients.md) %}

If you have access to the workbook (the `Limited Viewer` role at the minimum) where the newsletter is stored, you can subscribe to it.
