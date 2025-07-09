
# Private embedding

### Can I use RLS with private embedding? {#rls-available}

[RLS](../../datalens/security/row-level-security.md) enables you to restrict data access for users or user groups within a single dataset.

You can [embed private objects](../../datalens/security/private-embedded-objects.md#how-to-private-embed) into a website or app using special [JWT token](https://en.wikipedia.org/wiki/JSON_Web_Token) links without needing to authenticate in {{ datalens-short-name }}.

In this case, no data will appear when embedding private objects based on a dataset that uses RLS to restrict access for specific users or groups. For example, if you set `'first-company': user-login-1@yandex.ru, @group:group-name-1` as the RLS configuration for the `Company name` field.

If RLS settings allow all users and groups to access rows with a given value, private embedding will display data with this value in rows. For example, if you set `'first-company': *` as the RLS configuration for the `Company name` field, you will see rows with `first-company` in the `Company name` field when embedding objects based on this dataset.

### How can set up access permissions for data? {#data-access}

You set up access permissions for sections with special [JWT token](https://en.wikipedia.org/wiki/JSON_Web_Token) links using the toolkit of the website or app you are embedding your objects into.

### How do I set up data export? {#data-export}

You can set up data export when configuring [private embedding](../../datalens/security/private-embedded-objects.md#how-to-private-embed). To do this, enable or disable **Allow data export** in the settings window. This option invokes a menu you can use to export the chart data. To export data, click ![image](../../_assets/console-icons/ellipsis.svg) → ![image](../../_assets/console-icons/arrow-down-to-line.svg) **Save as** in the top-right corner of the chart and select the format: `XLSX`, `CSV`, or `Markdown`.

### Can I use file data sources for private embedding? {#file-embedded}

You can embed objects built based on file data sources (connection to [file](../../datalens/operations/connection/create-file.md), [Yandex Documents](../../datalens/operations/connection/create-yadocs.md), and [Google Sheets](../../datalens/operations/connection/create-google-sheets.md)).

### Can I use the state parameter? {#state}

In private embedding, you cannot use the `state` parameter for the state of the filtered charts.

### Can I embed private objects into {{ tracker-full-name }} and {{ wiki-full-name }}? {#tracker-wiki}

This option is not currently supported.

### How do I start editing a chart? {#chart-edit}

Embedded dashboards can only be opened in view mode. Their navigation bar and, by default, the ![image](../../_assets/console-icons/ellipsis.svg) menu for charts are hidden. You can enable **Allow data export** in embedding settings for your charts to display the ![image](../../_assets/console-icons/ellipsis.svg) menu, which allows exporting the chart data.

### Can I request access to edit a dashboard? {#dashboard-request-request}

The **Request access** option is not available on embedded dashboards.

### Does the UI customization available in the _Business_ plan apply to embedded objects? {#ui-customization}

The {{ datalens-short-name }} UI customization available in the _Business_ plan applies to all embedded objects.