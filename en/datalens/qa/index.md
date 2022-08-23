---
title: "{{ datalens-full-name }}. FAQ"
description: "How to get the logs of my work in the {{ datalens-full-name }} service? Answers to this and other questions in this article."
---

# General questions

This section includes answers to frequently asked user questions about {{ datalens-short-name }}.

Sections:

* [Permissions](#permissions)
* [Connections](#connections)
* [Data materialization](#materialization)
* [Datasets](#datasets)
* [Charts](#charts)
* [Calculated fields](#calculation-fields)
* [Dashboards](#dashboards)
* [Other](#other)

## Permissions {#permissions}

### How do I add a user and send them a link to the dashboard? {#how-add-user-send-ref}

To allow another user with a Yandex account to open your dashboard, configure access to {{ datalens-full-name }}:

1. Add a user:

   {% list tabs %}

   - To an organization

     {% include [datalens-add-user-organization](../../_includes/datalens/operations/datalens-add-user-organization.md) %}

     After that, the user has access to your {{ datalens-full-name }} instance.

   - To a cloud

     1. Go to [Access control]({{ link-console-access-management }}).
     1. In the top right-hand corner, click **Add user**.
     1. Enter the user's Yandex email address and click **Add**. The new user appears in the list of users.
     1. Click ![image](../../_assets/datalens/horizontal-ellipsis.svg) next to the new user and select **Configure roles**.
     1. Under **Roles in folders**, select a folder. In the **Roles** column, click ![image](../../_assets/plus-sign.svg). Assign the `datalens.instances.user` role.

     After that, the user has access to your {{ datalens-full-name }} instance.

   {% endlist %}

1. Make sure that the user has access to the dashboard:

   1. Open the dashboard.
   1. In the **Add member** field, enter "All" or the name of the user who needs extended permissions.
   1. Go to the **Current object** section and set the permissions for the dashboard:

      * View: Read only is available.
      * Edit: View and edit options are available.
      * Administration: View, edit, and manage options are available.

   1. Enable the **Linked objects** option to grant permissions to other dashboard-related objects (connections, dashboards, and charts).

The user is granted access to your {{ datalens-short-name }} and objects with **All** permissions. You can assign this user individual permissions to objects.

You can send the link to the dashboard from the browser. For more information about permissions for {{ datalens-short-name }} objects, see the [documentation](../security/index.md#permissions).

You can also make your dashboard public using [{#T}](../concepts/datalens-public.md).

{% include [permission-error](../../_includes/datalens/qa/permission-error.md) %}

{% include [copy-into-folder](../../_includes/datalens/qa/copy-into-folder.md) %}

{% include [revoke-token.md](../../_includes/datalens/qa/revoke-token.md) %}

## Connections {#connections}

{% include [postgre-type.md](../../_includes/datalens/qa/postgre-type.md) %}

{% include [metrica-clickhouse-connection](../../_includes/datalens/qa/metrica-clickhouse-connection.md) %}

{% include [uploading-data-logs-api.md](../../_includes/datalens/qa/uploading-data-logs-api.md) %}

{% include [csv-rows-display](../../_includes/datalens/qa/csv-rows-display.md) %}

{% include [csv-long-loading](../../_includes/datalens/qa/csv-long-loading.md) %}

{% include [csv-network-error](../../_includes/datalens/qa/csv-network-error.md) %}

### What do I do if a Google Sheets spreadsheet is not working properly? {#google-sheets-error}

{% include [google-sheets-error](../../_includes/datalens/qa/google-sheets-error.md) %}

## Data materialization {#materialization}

{% include [qa-materialization-error](../../_includes/datalens/qa/materialization-error.md) %}

{% include [unavailable-materialization](../../_includes/datalens/qa/unavailable-materialization.md) %}

{% include [operating-mode-with-data-source](../../_includes/datalens/qa/operating-mode-with-data-source.md) %}

{% include [materialization-on-off](../../_includes/datalens/qa/materialization-on-off.md) %}

## Datasets {#datasets}

{% include [incorrectly-identified-date-field](../../_includes/datalens/qa/incorrectly-identified-date-field.md) %}

{% include [how-to-link-two-tables](../../_includes/datalens/qa/linking-two-tables.md) %}

{% include [add-line-numeration](../../_includes/datalens/qa/add-line-numeration.md) %}

{% include [unix-time](../../_includes/datalens/qa/unix-time.md) %}

{% include [add-sql](../../_includes/datalens/qa/add-sql.md) %}

## Charts {#charts}

{% include [show-top-100-values](../../_includes/datalens/qa/show-top-100-values.md) %}

{% include [create-labels-in-pie-chart](../../_includes/datalens/qa/create-labels-in-pie-chart.md) %}

{% include [hide-legend-in-chart](../../_includes/datalens/qa/hide-legend-in-chart.md) %}

{% include [add-two-indicators](../../_includes/datalens/qa/add-two-indicators.md) %}

{% include [create-grouped-column-chart](../../_includes/datalens/qa/create-grouped-column-chart.md) %}

{% include [number-of-indicators-in-color-section](../../_includes/datalens/qa/number-of-indicators-in-color-section.md) %}

{% include [creating-line-chart-with-columns](../../_includes/datalens/qa/creating-line-chart-with-columns.md) %}

{% include [pie-chart-note](../../_includes/datalens/qa/pie-chart-note.md) %}

{% include [making-logarithmic-scale](../../_includes/datalens/qa/making-logarithmic-scale.md) %}

{% include [sign-last-point](../../_includes/datalens/qa/sign-last-point.md) %}

{% include [sign-multiple-lines](../../_includes/datalens/qa/sign-multiple-lines.md) %}

{% include [resize-column](../../_includes/datalens/qa/resize-column.md) %}

{% include [rename-column](../../_includes/datalens/qa/rename-column.md) %}

{% include [null-setting-in-charts](../../_includes/datalens/qa/null-setting-in-charts.md) %}

## Calculated fields {#calculation-fields}

{% include [calculate-cumulative-sum](../../_includes/datalens/qa/calculating-cumulative-sum.md) %}

{% include [calculate-ifnull-zn-nan](../../_includes/datalens/qa/calculating-ifnull-zn-nan.md) %}

## Dashboards {#dashboards}

{% include [configure-link-between-selectors](../../_includes/datalens/qa/configure-link-between-selectors.md) %}

{% include [unavailable-selector-values](../../_includes/datalens/qa/unavailable-selector-values.md) %}

{% include [apply-filter-to-two-datasets](../../_includes/datalens/qa/apply-filter-to-two-datasets.md) %}

{% include [configure-selectors](../../_includes/datalens/qa/configure-selectors.md) %}

{% include [making-available-chart](../../_includes/datalens/qa/making-available-chart.md) %}

### How do I make a dashboard containing Yandex Metrica or AppMetrica data public? {#how-metrica-appmetrica-share}

Datasets based on a connection to the Yandex Metrica API and AppMetrica do not support materialization and you cannot publish such a dashboard.

To share a dashboard containing Yandex Metrica or AppMetrica data, use one of the following methods:

{% include [datalens-metrica-appmetrica-share](../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}

## Other {#other}

### Can I get logs of my operations with services? {#logs}

Yes, you can request log records about your resources from {{ yandex-cloud }} services. For more information, see [{#T}](../../support/request.md).

{% include [copy-folder](../../_includes/datalens/qa/copy-folder.md) %}

### Can I install {{ datalens-short-name }} locally inside the company? {#datalens-local}

{{ datalens-short-name }} is offered only as a cloud service. We would also like to note:

- {{ datalens-short-name }} is a {{ yandex-cloud }} service, which is compliant with Federal Law No. 152 and industry security standards. More information is available in [{{ yandex-cloud }} security]{% if lang == "ru" %}(https://cloud.yandex.ru/security){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en-ru/security){% endif %}.

- For {{ datalens-short-name }}, you can [set up identity federations](../../organization/quick-start.md).

### Why is the cloud with a {{ datalens-short-name }} instance blocked? {#datalens-suspended}

Your cloud may be blocked in the following cases:

- Outstanding charges for {{ yandex-cloud }} paid services that are in the same cloud as {{ datalens-short-name }}.
- Expiration of a trial period for {{ yandex-cloud }} paid services.
- Violation of the [Terms of use]{% if lang == "ru" %}(https://yandex.ru/legal/cloud_termsofuse/){% endif %}{% if lang == "en" %}(https://yandex.ru/legal/cloud_termsofuse/?lang=en){% endif %} {{ yandex-cloud }}.

When a cloud is suspended, your {{ datalens-short-name }} instance will be unavailable. You won't be able to use {{ datalens-short-name }} until access to the cloud is restored.

Learn more in [Automatic cloud suspension](../../overview/concepts/data-deletion.md#block).

{% include [object-id](../../_includes/datalens/qa/object-id.md) %}

{% include [network-error](../../_includes/datalens/qa/network-error.md) %}

## How to report a problem {#how-to-resolve-problem}

There are two ways to report a problem:
* From the {{ datalens-full-name }} interface. In the {{ datalens-full-name }} interface, next to the error code, click **Report problem** and enter all the necessary details of the problem in the description. A {{ yandex-cloud }} support ticket will be created automatically.
* From a direct report to [technical support]({{ link-console-support }}) {{ yandex-cloud }}.

In your report, please provide (if possible):
* The most accurate description of the problem and the sequence of your actions.
* Images, GIFs, or videos.

You can leave feedback and suggestions regarding the service in the [{{ yandex-cloud }} user community](https://cloud.yandex.ru/features?serviceId=23).

To receive news and discuss best service practices, join the [DataLens](https://t.me/YandexDataLens) community in Telegram.

