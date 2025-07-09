
# Reports


{% include [business-note](../../_includes/datalens/datalens-functionality-available-business-note.md) %}


### Does {{ datalens-short-name }} support selectors in reports? {#selector-in-report}

{{ datalens-short-name }} supports selectors in [reports](../../datalens/reports/index.md), which enables you to configure data filtering. You can add a regular [selector](../../datalens/dashboard/selector.md) or a [JS selector](../../datalens/charts/editor/widgets/controls.md) to a report. Before adding a selector, make sure you have the `{{ permission-write }}` or `{{ permission-admin }}` access to the report. For more information, see [{#T}](../../datalens/security/manage-access.md).


### Is there a report demo version? {#demo-report}

Reports are only available with the Business [service plan](../../datalens/pricing.md#service-plans).

To view a report example, deploy the [DataLens demo dashboard](https://datalens.yandex.cloud/gallery/wcyljs3cf5mwi) from {{ datalens-gallery }}:

1. Click **Use** → **Deploy**. The workbook will be created in the root of workbooks and collections. Its name must be unique, so edit the name if you need to.
1. Click **Create**. You will see the report example in the created workbook.


### Can I view reports in full-screen mode and switch between pages? {#report-preview}

Yes. You can view a report in [full-screen mode](../../datalens/reports/report-operations.md#report-preview) as a document or presentation.

### Can I configure auto-refresh in presentation mode? {#report-preview-autoupdate}

No, but you can use browser extensions to set up auto-refresh for the browser page.

### Is there a way to keep a revision history for reports? {#report-versioning}

Yes, you can keep the [history](../../datalens/reports/versioning.md) of report configuration revisions as versions.

### Can I use the keyboard to move report widgets? {#report-hot-keys}

You can use these hotkeys to move a selected [widget](../../datalens/reports/report-operations.md#add-widget):

* Arrow keys to move by one pixel.
* **Shift** + arrow keys to move by ten pixels.

### Is there widget auto-alignment in reports? {#grid-alignment}

Reports do not support selection and auto-alignment of multiple widgets. For easier widget alignment, enable the **Show grid** option in [report settings](../../datalens/reports/report-operations.md#report-settings).

### Can I use filtering of charts by other charts in presentation mode? {#chart-chart-filtration}

Reports do not support filtering charts by other charts.

### Are reports available on mobile devices? {#mobile-report}

Currently, {{ datalens-short-name }} does not support reports on mobile devices.

### Can I save a dashboard as a report? {#dashboard-on-report}

No, but you can copy and paste a widget to a report from any dashboard in the same workbook.


### Can I publish reports? {#link-on-report}

You cannot grant [public access](../../datalens/concepts/datalens-public.md) to a report, but you can [share a report link](../../datalens/reports/report-operations.md#link-on-report) with users who already have the [access](../../datalens/security/).


### Can I set custom header sizes in reports? {#title-size}

You can select the header text size from preset options, such as `XS`, `S`, `M`, `L`, and `XL`, or click ![icon](../../_assets/console-icons/pencil-to-line.svg) and specify text size in pixels.

### Is there an option to refresh all charts on a page? {#page-refresh}

To refresh report charts with applied parameters on the current page only, click ![icon](../../_assets/console-icons/arrows-rotate-right.svg) at the top of the report.
