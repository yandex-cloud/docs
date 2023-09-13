# Queue statistics

To view statistics on queue issues:

1. Open the queue page.

1. In the top-right corner, click ![](../../_assets/tracker/svg/actions.svg), then click ![](../../_assets/tracker/svg/statistic.svg)&nbsp;**{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_stat }}**.
   On the **{{ ui-key.startrek.blocks-desktop_b-page_type_queue.tab_stat }}** tab, you can see:

   - Number and distribution of issues by type.
   - Number and distribution of issues by priorities.
   - The number of issues belonging to different components.
   - The issue statistics by assignee.


## Time Spent report {#section_uxt_3ft_xz}

On the statistics page, you can generate a report on the time spent. The report only includes issues that use [time tracking](../user/time-spent.md).

To generate the report:

1. Click **{{ ui-key.startrek.blocks-desktop_b-page-stat.make-report }}**.

1. Select the  report type:
   - **{{ ui-key.startrek.blocks-desktop_b-widget.timesheet }}**: For each assignee, the table lists the issues they worked on, their type, queue, priority, and data on time spent.
   - **{{ ui-key.startrek.blocks-desktop_b-widget.pivot }}**: Report grouped by issue. For each issue in the table, you can see a list of assignees that worked on the issue, the issue type, priority, and time spent.

1. Specify the period for which you want to get the report.

1. Select the desired queue. To do this, start typing the queue key in the **{{ ui-key.startrek.blocks-desktop_b-widget.queue-hint }}** field and select a queue from the drop-down list. You can select multiple queues at the same time.

1. Select the users or a group of users for which you want to generate the report.

1. Click **{{ ui-key.startrek.blocks-desktop_b-widget.export-xlsx }}**.


The report is saved as an `XLSX` file. You can view such a file with most of today's spreadsheet programs, for example, Microsoft Excel or LibreOffice Calc.
