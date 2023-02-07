# FAQ

This section includes answers to frequently asked user questions about {{ datalens-short-name }}.

If you can't find an answer to your question here, see [How to report a problem](#how-to-resolve-problem).

Sections:

* [Permissions](#permissions)
* [Connections](#connections)
* [Datasets](#datasets)
* [Charts](#charts)
* [Calculated fields](#calculated-fields)
* [Dashboards](#dashboards)
* [Other](#other)

## Permissions {#permissions}

### Notifications about permission requests {#permission-request-notifications}

When permissions are requested for an object, all administrators of the object get notified about this by email, including permission requests for linked entities. The requested object will be the first in the list of links. To grant permissions for all the entities, click the object link and add permissions for the object and its linked entities for your users. You can also click on each link in the notification and approve permissions in the **Permissions** dialog.

**Restrictions:**

* Only employees who are object administrators are notified, not groups.
* Administrators of linked entities aren't notified
* Permissions for linked entities won't be approved if the approver isn't an administrator of the linked entity.
* Datasets and connections for `ChartEditor` scripts aren't included in connections.

{% include [qa-for-users.md](../_qa/datalens/permission-error.md) %}

### Can I grant view permissions for my chart to all users instead of having to assign permissions individually? {#viewing-rights-for-all-users}

To do this, grant permissions to the group:

1. **Yandex**: All Yandex full-time employees.
1. **All**: All Yandex employees, including freelancers. To grant permissions to external employees, follow the [instructions](https://wiki.yandex-team.ru/Statbox/Dostup-k-Statistike-dlja-Outstaff/).
1. You can grant permissions to a specific group.

{% include [copy-into-folder](../_qa/datalens/copy-into-folder.md) %}

{% include [revoke-token.md](../_qa/datalens/revoke-token.md) %}

### How to grant access to the ChartEditor to external employees? {#charteditor-outstaff-access}

{% include [access](../_includes/datalens/internal/editor/access.md) %}

## Connections {#connections}

{% include [postgre-type.md](../_qa/datalens/postgre-type.md) %}

### What do I do if a Google Sheets spreadsheet is not working properly? {#google-sheets-error}

{% include [google-sheets-error](../_qa/datalens/google-sheets-error.md) %}

### Problems with time zones (unexpected 3-hour time shift) {#timezone-problems}

Work with timezones is being carried out in this [issue](https://st.yandex-team.ru/BI-1478).

{% include [csv-file-rows-display.md](../_qa/datalens/csv-file-rows-display.md) %}

### How do I connect to an external database? {#connect-external-db}

To connect external {{ CH }}, {{ PG }}, {{ MY }}, {{ MS }} databases or Oracle Database to the internal DataLens (datalens.yandex-team.ru), grant permissions for the `_DL_INT_BACK_PROD_NETS_` cluster in [Puncher](https://puncher.yandex-team.ru/). See [Image](https://jing.yandex-team.ru/files/elenbaskakova/Pravila_2019-01-22_19-48-39.png).

### What password do I enter for the clickhouse.metrika balancer.yandex.net load balancer? {#password-for-clickhouse-metrika}

To obtain a username and password, follow the [instructions](https://wiki.yandex-team.ru/jandexmetrika/mtmega/#2.akkauntvbazedannyx).

Configure the ports:

* `8123`: Disable the **HTTPS** option.
* `8443`: Enable the **HTTPS** option.

## Datasets {#datasets}

### How do I create a dataset based on dynamic tables? {#how-to-create-dataset}

Use the scenario [{#T}](tutorials/data-from-ch-over-yt.md).

If you get the following error in DataLens when creating a dataset based on a dynamic table: `Dynamic store read for table <table name> is disabled; in order to read dynamic stores, set attribute "enable_dynamic_store_read" to true and remount table; if you indeed want to read only static part of dynamic table, pass setting chyt.dynamic_table.enable_dynamic_store_read = 0`.

This means that you need to remount the table and set the `enable_dynamic_store_read` attribute to CHYT.

To remount a table, contact the data owner in YT (to learn how to do this, see the [post in Atushka](https://clubs.at.yandex-team.ru/yt/4033)).

{% include [incorrectly-identified-date-field](../_qa/datalens/incorrectly-identified-date-field.md) %}

{% include [how-to-link-two-tables](../_qa/datalens/linking-two-tables.md) %}

### How do I display new data when updating the CHYT source table? {#new-data-in-chyt-table}

1. Click **Update fields** in the dataset.
1. If you have a range in the source data, and columns were added only to the range, keep in mind that CHYT overlaps sets of columns across the entire range. Discussion in [Telegram](https://nda.ya.ru/t/oRZEpipf5qSRFj).

### Cyrillic characters are displayed incorrectly in the dataset {#incorrect-cyrillic-symbols}

If your dataset is created on top of the CHYT connection, make sure that the field in YT has the `string` type. {{ datalens-short-name }} does not work with specific data types, for example, with the `any` type in YT.

### How do I use a selector to link two datasets? {#how-to-add-common-selector}

See the example of setting a link between widgets in the instructions [{#T}](operations/dashboard/create-alias.md).

{% include [add-line-numeration](../_qa/datalens/add-line-numeration.md) %}

{% include [unix-time](../_qa/datalens/unix-time.md) %}

{% include [make-geocode](../_qa/datalens/make-geocode.md) %}

{% include [get-geo](../_qa/datalens/get-geo.md) %}

{% include [qa-materialization](../_qa/datalens/where-is-materialization.md) %}

## {{ datalens-short-name }} datasets in the Editor {#datalens-datasets-in-editor}

{{ datalens-short-name }} datasets are available for use in [Editor](https://charts.yandex-team.ru/editor) as [a source](editor/sources/dataset.md).

## Charts {#charts}

{% include [show-top-100-values.md](../_qa/datalens/show-top-100-values.md) %}

{% include [create-labels-in-pie-chart.md](../_qa/datalens/create-labels-in-pie-chart.md) %}

{% include [hide-legend-in-chart.md](../_qa/datalens/hide-legend-in-chart.md) %}

{% include [add-two-indicators.md](../_qa/datalens/add-two-indicators.md) %}

{% include [create-grouped-column-chart.md](../_qa/datalens/create-grouped-column-chart.md) %}

{% include [number-of-indicators-in-color-section.md](../_qa/datalens/number-of-indicators-in-color-section.md) %}

{% include [creating-line-chart-with-columns.md](../_qa/datalens/creating-line-chart-with-columns.md) %}

### How do I see the query sent by the chart? {#request-from-chart}

1. In the upper right-hand corner of the chart, click the three dots and select **Inspector** (see the [image](https://jing.yandex-team.ru/files/pampiduzik/2021-02-12T07%3A23%3A58Z.56275ff.png)).
2. In the **Data sources** section, open the parameters of the second source: it will show the request body and under **More information** ‒ your SQL query (see the [screenshot](https://jing.yandex-team.ru/files/pampiduzik/2021-02-12T07%3A26%3A03Z.b42e7f7.png)).

{% include [pie-chart-note](../_qa/datalens/pie-chart-note.md) %}

{% include [making-logarithmic-scale](../_qa/datalens/making-logarithmic-scale.md) %}

{% include [sign-last-point](../_qa/datalens/sign-last-point.md) %}

{% include [sign-multiple-lines](../_qa/datalens/sign-multiple-lines.md) %}

{% include [rename-column](../_qa/datalens/rename-column.md) %}

{% include [cell-image](../_qa/datalens/cell-image.md) %}

{% include [null-setting-in-charts.md](../_qa/datalens/null-setting-in-charts.md) %}

### How can I download all the values from a table, not just the first 100 rows? {#pagination}

1. Go to the [chart settings](concepts/chart/settings.md#common-settings).
1. In the window that opens, set the **Pagination** function to **Off**.

### How do I add an image to a table? {#cell-image}

You can only add an image to a table cell in [ChartEditor](https://charts.yandex-team.ru/editor). To do this, specify the link to the required image in the [backround-image](http://htmlbook.ru/css/background-image) property for [css cell style](./editor/widgets/table/index.md#example). See [example](https://datalens.yandex-team.ru/editor/1penklxj2bds0-table-with-base64-image).

## Calculated fields {#calculation-fields}

### How do I create a calculated field (formula) in a Statface Report or (App)Metrica API connection? {#how-to-create-calculated-fields}

A limited [list of operators and functions](https://cloud.yandex.ru/docs/datalens/function-ref/availability) is supported.

### How do I create an aggregation on a field in a Statface Report or (App)Metrica API connection? {#how-to-create-aggregation}

Not supported. See the question [How do I create a calculated field (formula) in a Statface Report or (App)Metrica API connection?](#how-to-create-calculated-fields)

{% include [how-to-calculate-cumulative-sum](../_qa/datalens/calculating-cumulative-sum.md) %}

{% include [calculate-ifnull-zn-nan](../_qa/datalens/calculating-ifnull-zn-nan.md) %}

## Dashboards {#dashboards}

### Can I create a selector based on two dataset fields (start_date and end_date) that works as follows: if at least one day from the selector belongs to the interval (start_date;end_date), then keep this row? {#selector-based-on-range}

That's not possible at the moment. You will be able to do this using more/less and two selectors when operators in selectors are upgraded (see the [issue](https://st.yandex-team.ru/DLFR-285)).
See a more complicated construction with parameterization support in the [issue](https://st.yandex-team.ru/DLFR-174).

For now, you can try doing this using the `Editor` and manual selectors, but there are no ready-made code samples to share.

{% include [configure-link-between-selectors](../_qa/datalens/configure-link-between-selectors.md) %}

{% include [unavailable-selector-values](../_qa/datalens/unavailable-selector-values.md) %}

### I get a newsletter with "No permission to view the dashboard" {#no-permissions-to-view-dashboard}

By default, the newsletter is run by the `robot-charts-postman` robot. To grant access to the robot, you must assign the read/execute permissions to the robot. To grant the user's permissions to the newsletter, add the user's OAuth token when configuring newsletters.

### Can I publish public dashboards from the internal network? {#publishing-public-dashboards-from-internal-network}

This isn't supported.

{% include [apply-filter-to-two-datasets](../_qa/datalens/apply-filter-to-two-datasets.md) %}

{% include [configure-selectors](../_qa/datalens/configure-selectors.md) %}

### Selectors throw an error when I select a value (connecting to Statface Report) {#error-of-value-selection}

This is because linked selectors don't work for this connection type.

To fix this error:

1. Create selectors without specifying any default values.
1. Break links between the selectors.
1. Set default values in the selectors.

## Partner analytics {#partner-analytics}

Partner analytics let you share dashboards with partners by differentiating permissions using an external cloud-based DataLens. This way, you can implement a single dashboard over a single data cube, and each partner will see only the data they have permissions for. [Read the Wiki to learn more](https://wiki.yandex-team.ru/DataLens/Partnerskaja-analitika/).

## Other {#other}

{% include [copy-folder](../_qa/datalens/copy-folder.md) %}

### There is an error in a chart: A CHYT clique is not available. How to restore a clique? {#clique-is-not-running}

If you see a Clique error like `*chyt_analytics is not running; actual state = failed`, ask the person in charge to restore the clique.

To find the person in charge:

1. Open the operation on the YT cluster you need, such as [Hahn](https://yt.yandex-team.ru/hahn/operations).
1. Enter the clique name with an asterisk. For example, `*chyt_analytics`.
1. Click **Go to operation**.
1. Check the username of the person in charge in the **User** field.

### Can I roll back the version of a {{ datalens-short-name }} object? {#dl-rollback}

You can view the change history and roll back versions of dashboards and charts in the dashboard/chart menu (see versioning of a [dashboard](concepts/dashboard.md#versioning)/[chart](concepts/chart/index.md#versioning)). For other objects, the user cannot roll back an object version themselves. Use the bug icon {{ datalens-short-name }} to create ticket. In the issue, specify the {{ datalens-short-name }} objects and the version (time) to roll back your object to.

{% include [object-id](../_qa/datalens/object-id.md) %}

{% include [network-error](../_qa/datalens/network-error.md) %}

## How to report a problem {#how-to-resolve-problem}

We are always here to help if you have any difficulties or issues.
Tell us about problems and errors using the bug icon (it will automatically create an issue in the [DLHELP](https://st.yandex-team.ru/createTicket?queue=DLHELP) queue).
In your report, please provide (if possible):

* The most accurate description of the problem and the sequence of your actions.
* Screenshots, GIFs, or videos (helpful, but not necessary).
Use the [DLFR](https://st.yandex-team.ru/createTicket?queue=DLFR) queue for comments and suggestions.
Follow the service in [Atushka](https://clubs.at.yandex-team.ru/statistics/) and the Telegram channel [DataLens News](https://nda.ya.ru/t/9_PEx46n5pcL8j).

