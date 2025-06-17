---
title: Exporting and importing workbooks
description: Follow this guide to export and import workbooks.
---

# Exporting and importing workbooks

In {{ datalens-short-name }}, you can move [workbooks](./index.md) between installations using export and import tools. For example, you can export a ready-made workbook with its settings and links from cloud {{ datalens-full-name }} to an [open source](https://datalens.tech) installation.


{% note info %}

* You can only export and import workbooks.
* Some connection types [are not available](#restrictions) for export and import.
* Export is available to users with the `{{ roles-datalens-admin }}` role.
* Import is available to users who have permission to create a new workbook.

{% endnote %}



## Exporting a workbook {#export-workbook}

To export a workbook:

1. In the left-hand panel, select ![collections](../../_assets/console-icons/rectangles-4.svg) **Collections and workbooks**.
1. Use one of the following methods to start exporting the workbook you need:
   
   * Next to the workbook, click ![image](../../_assets/console-icons/ellipsis.svg) → ![icon](../../_assets/console-icons/file-arrow-up.svg) **Export**.
   * Open the workbook and click ![image](../../_assets/console-icons/ellipsis.svg) → ![icon](../../_assets/console-icons/file-arrow-up.svg) **Export** at the top.

1. Click **Export**. You can see the progress in the indicator. Note the following:

   * Workbooks are exported to a JSON file.
   * Export may take a few minutes.
   * Sensitive [connection](../concepts/connection.md) data is not saved. During [import](#import-workbook), the user will have to set up connections again, e.g., specify a token or enter a password, and for connections to a [file](../operations/connection/create-file.md), [Yandex Documents](../operations/connection/create-yadocs.md), or [Google Sheets](../operations/connection/create-google-sheets.md), reupload the data.   
   * Other {{ datalens-short-name }} versions may not support certain connection types. During import, such connections will not work.
   
   If you try to close the indicator window before the export is complete, you will get the cancel export warning. Select:

   * **Return** to continue the export.
   * **Cancel export** to stop it.
   
Once the export is complete, you may get [warnings](./export-import-notifications.md#export-notifications) with workbook details and a list of objects requiring attention. To download the export file in JSON format, click **Download**.

{% note tip %}

You can edit the exported JSON file, e.g., add a password for a connection. However, {{ datalens-short-name }} does not guarantee successful import and correct operation of the workbook if you manually edit its configuration. We recommend that you carefully review all changes before import to mitigate possible issues.

{% endnote %}

If the workbook export fails, you will get an error [message](./export-import-notifications.md#export-notifications). Try to fix the error and re-export the workbook.

## Importing a workbook {#export-workbook}

To import a workbook:

1. In the left-hand panel, select ![collections](../../_assets/console-icons/rectangles-4.svg) **Collections and workbooks**.
1. In the top-right corner, click **Create** → **Create workbook**.
1. In the workbook creation window:
   
   1. Enter a name for the workbook.

      {% note info %}

      The workbook name must be unique within the selected collection.

      {% endnote %}

   1. At the bottom, click ![icon](../../_assets/console-icons/paperclip.svg) **Select file** and select the JSON file with the workbook configuration.
   1. Click **Create**.

   You can see the import progress in the indicator. If you close the indicator window before the import is complete, it will not be interrupted. While the import is in progress, you will see the new workbook in the workbook list labeled as `Importing`, and selecting it will open the import progress window.

Once the import is complete, you may get [warnings](./export-import-notifications.md#import-notifications) with details of the imported workbook and a list of objects requiring attention. To go to the new workbook, click **Open workbook**. You can configure additional settings if you need to, e.g., enter a password for a connection.


{% note info %}

When transferring workbooks with connections to a [file](../operations/connection/create-file.md), [Yandex Documents](../operations/connection/create-yadocs.md), or [Google Sheets](../operations/connection/create-google-sheets.md), reupload the data. To do this, in the connection, to the right of the file name, click ![icon](../../_assets/console-icons/ellipsis.svg) → **Replace** and then:

* In a connection to a file, select the data file.
* In connections to Yandex Documents and Google Sheets, specify a link to the data file.

When transferring workbooks with connections to [managed databases](../concepts/connection.md#db) created in `Select in organization` mode, they will be imported manually (`Specify manually`). If you need to, complete the connection setup manually after import.

{% endnote %}


If the workbook import fails, you will get an error [message](./export-and-import.md#import-notifications). Try to fix the error and re-import the workbook.


## Disabling workbook export {#workbooks-export-disable}


{% include [business-note](../../_includes/datalens/datalens-functionality-available-business-note.md) %}


By default, users with the `{{ roles-datalens-admin }}` role can export workbooks. You can disable this option at the {{ datalens-short-name }} instance level. After you disable export:

* ![icon](../../_assets/console-icons/file-arrow-up.svg) **Export** button will disappear from the workbook interface.
* Users will not be able to export workbooks.
* Any JSON export files created before you disable export may be imported to a new workbook.

Only the {{ datalens-short-name }} instance [admin](../security/roles.md#datalens-admin) (the `{{ roles-datalens-admin }}` role) can disable export.

To prohibit export of workbooks:

1. In the left-hand panel, select ![sliders](../../_assets/console-icons/sliders.svg) **Service settings**.
1. Disable **Workbook export** (enabled by default).



## Limitations {#restrictions}

These connection types are not available for export and import.


* [{{ ydb-short-name }}](../operations/connection/create-ydb.md)
* [{{ yq-full-name }}](../operations/connection/create-yandex-query.md)
* [Yandex Monitoring](../operations/connection/create-monitoring.md)
* [Metrica](../operations/connection/create-metrica-api.md)
* [AppMetrica](../operations/connection/create-appmetrica.md)
* [Analystics podcasts](../operations/connection/create-podcasts.md)
* [{{ billing-name }}](../operations/connection/create-cloud-billing.md)
* [{{ datalens-short-name }} Usage Analytics](../operations/connection/create-usage-tracking.md)
* [{{ speechsense-name }}](../operations/connection/create-speechsense.md)
* [1C Extractor](../operations/connection/create-extractor1c.md)
* [Bitrix24](../operations/connection/create-bitrix24.md)
* MoySklad
* Equeo
* Kontur.Market


