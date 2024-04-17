---
title: "{{ tracker-full-name }} release notes for March 2024"
description: "Check out {{ tracker-full-name }} release notes for March 2024."
---

# {{ tracker-full-name }} release notes: March 2024

* [Updates](#top-news)
* [Fixes and improvements](#fixes)

## Updates {#top-news}

### _Issue lifecycle_ chart {#issue-lifecycle}

Now you can find a chart in issues that shows the time your issue remains in each of the statuses. The chart is available on the **History** tab of an issue. Using the ![](../../_assets/tracker/svg/arrow.svg) icon, you can expand the chart: each status will appear in a separate row.

![](../../_assets/tracker/issue-lifecycle.png =700x)

### Bulk operations in projects and portfolios {#bulk-projects-portfolios}

For projects within a portfolio, you can now use [bulk edit operations](../manager/create-portfolio.md#bulk-change) to perform the following for multiple projects simultaneously:

* Change their status.
* Assign a person in charge.
* Move them to a different portfolio.
* Edit their parameters.
* Delete them.

### Links in projects and portfolios {#links}

In [projects](../manager/create-project.md#links) and [portfolios](../manager/create-portfolio.md#links), you can now add *Depends on*/*Blocks* links.


## Fixes and improvements {#fixes}

### New interface for SLA rules, templates, and notifications {#new-ui}

The new interface now supports a few more {{ tracker-name }} pages:

* **SLA rules** page in the queue settings.
* [Page for managing issue and comment templates]({{ link-tracker-templates }}): **Settings** ⟶ **Interface** ⟶ **Manage templates**.
* [Notification settings page]({{ link-sub-roles }}): **Settings** ⟶ **Interface** ⟶ **Notification settings**.

### Exporting issues via reports {#issues-reports}

{{ tracker-name }} supports exporting issue lists from filters as XMS, CSV, and XLSX files. The export feature is often unstable: errors occur, files do not download or contain an incomplete issue list.

Now, a new tool is available for exporting issues via report generation. To use the new export feature:

1. On the page with issues, click ![](../../_assets/console-icons/file-arrow-down.svg) **Export** and select the file format from the list: XML, CSV, or XLSX.
1. In the bottom-right corner of the page, a report generation message will appear. Click the link in this message to go to the report page.
1. On the report page, click **Download**. This will save the file with the issue list in the downloads.

You can still use the old export tool: click ![](../../_assets/console-icons/file-arrow-down.svg) **Export** ⟶ **Download file (earlier version)** and select the file format. This will save the file in the downloads.

### _Cycle time_ widget improvements {#cycle-time-improvements}

Added new parameters to the [**Cycle time**](../user/cycle-time.md) widget: you can now select sprints as a step.
