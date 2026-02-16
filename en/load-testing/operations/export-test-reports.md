---
title: How to export a test report to {{ objstorage-full-name }}
description: Follow this guide to export your reports to static formats.
---

# Exporting test reports

In {{ load-testing-name }}, you can export test results to a [{{ objstorage-full-name }}](../../storage/) bucket as static format files, such as HTML, PDF, or CSV. Once generated, you can download a report from the bucket either via a link or directly. 

## Exporting a report to {{ objstorage-full-name }} {#export-report}

1. In the [management console]({{ link-console-main }}), select the folder.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. In the ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab, select the test you need.
1. On the test page, click ![image](../../_assets/console-icons/ellipsis.svg) in the top-right corner and select **{{ ui-key.yacloud.load-testing.button_export-report }}**.
1. In the **{{ ui-key.yacloud.load-testing.label_report-export-title }}** dialog:
	- Under **{{ ui-key.yacloud.load-testing.field_report-export-bucket }}**, select the bucket you need or create a new one.
	- In the **{{ ui-key.yacloud.load-testing.field_report-export-folder }}** field, enter the name of the folder you want to save your report to. If there is no folder with this name in the bucket, it will be created.
	- Under **{{ ui-key.yacloud.load-testing.field_report-export-format }}**, select the target format.
	- Configure the time interval format as needed in the **{{ ui-key.yacloud.load-testing.field_report-export-time-interval }}** field (whole or current). The current interval will only become available after you move the interval boundaries on the timeline in the **{{ ui-key.yacloud.load-testing.label_test-report }}** tab.
1. Click **{{ ui-key.yacloud.load-testing.button_export-report }}**.

## Downloading a report from {{ objstorage-full-name }} {#download-report}

1. In the [management console]({{ link-console-main }}), select the folder.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-testing }}**.
1. In the ![image](../../_assets/load-testing/test.svg) **{{ ui-key.yacloud.load-testing.label_tests-list }}** tab, select the test you need.
1. In the **{{ ui-key.yacloud.load-testing.label_report-exports-history-title }}** tab, make sure the export operation you need is shown as **{{ ui-key.yacloud.common.operations.column_value_done }}**.
1. Use the link in the **File path** column to go to the export operation page.
1. In the top-right corner, click **{{ ui-key.yacloud.storage.file.button_generate }}** to get a link to the report.
1. To download the report, click **{{ ui-key.yacloud.storage.bucket.button_download }}**.
1. You can configure access permissions for your reports, if required. In the top-right corner, click ![image](../../_assets/console-icons/ellipsis.svg) to select a user group and set access level for it.
