By default, users with the `{{ roles-datalens-admin }}` role can export workbooks. You can disable this option at the {{ datalens-short-name }} instance level. After you ban export:

* ![icon](../../../_assets/console-icons/file-arrow-up.svg) **Export** button will disappear from the workbook interface.
* Users will not be able to export workbooks.
* Any JSON export files created before you disable export may be imported to a new workbook.

Only the {{ datalens-short-name }} instance [admin](../../../datalens/security/roles.md#datalens-admin) (the `{{ roles-datalens-admin }}` role) can disable export.

To prohibit export of workbooks:

1. In the left-hand panel, select ![sliders](../../../_assets/console-icons/sliders.svg) **Service settings**.
1. Select the **Security** tab.
1. Disable **Workbook export** (on by default).