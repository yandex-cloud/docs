---
title: "{{ datalens-full-name }}. Questions and answers"
description: "How do I get the logs of my activity in {{ datalens-full-name }}? Find the answer to this and other questions in this article."
---

# Questions and answers about {{ datalens-name }}

This section includes answers to frequently asked user questions about {{ datalens-short-name }}.

Sections:

* [Permissions](#permissions)
* [Connections](#connections)
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

You can send the link to the dashboard from the browser. For more information about permissions for {{ datalens-short-name }} objects, see the [documentation]{% if lang == "ru" %}(https://cloud.yandex.ru/docs/datalens/security/#permissions){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en-ru/docs/datalens/security/#permissions){% endif %}.

You can also make your dashboard public using [{#T}](../concepts/datalens-public.md).

{% include [permission-error](../../_qa/datalens/permission-error.md) %}

{% include [copy-into-folder](../../_qa/datalens/copy-into-folder.md) %}

{% include [revoke-token.md](../../_qa/datalens/revoke-token.md) %}

## Connections {#connections}

{% include [postgre-type.md](../../_qa/datalens/postgre-type.md) %}

{% include [metrica-clickhouse-connection](../../_qa/datalens/metrica-clickhouse-connection.md) %}

{% include [uploading-data-logs-api.md](../../_qa/datalens/uploading-data-logs-api.md) %}

{% include [csv-rows-display](../../_qa/datalens/csv-rows-display.md) %}

{% include [csv-long-loading](../../_qa/datalens/csv-long-loading.md) %}

{% include [csv-network-error](../../_qa/datalens/csv-network-error.md) %}

### What do I do if a Google Sheets spreadsheet is not working properly? {#google-sheets-error}

{% include [google-sheets-error](../../_qa/datalens/google-sheets-error.md) %}

## Datasets {#datasets}

{% include [incorrectly-identified-date-field](../../_qa/datalens/incorrectly-identified-date-field.md) %}

{% include [how-to-link-two-tables](../../_qa/datalens/linking-two-tables.md) %}

{% include [add-line-numeration](../../_qa/datalens/add-line-numeration.md) %}

{% include [unix-time](../../_qa/datalens/unix-time.md) %}

{% include [add-sql](../../_qa/datalens/add-sql.md) %}

{% include [make-geocode](../../_qa/datalens/make-geocode.md) %}

{% include [get-geo](../../_qa/datalens/get-geo.md) %}

{% include [qa-materialization-error](../../_qa/datalens/where-is-materialization.md) %}

## Charts {#charts}

{% include [show-top-100-values](../../_qa/datalens/show-top-100-values.md) %}

{% include [create-labels-in-pie-chart](../../_qa/datalens/create-labels-in-pie-chart.md) %}

{% include [hide-legend-in-chart](../../_qa/datalens/hide-legend-in-chart.md) %}

{% include [add-two-indicators](../../_qa/datalens/add-two-indicators.md) %}

{% include [create-grouped-column-chart](../../_qa/datalens/create-grouped-column-chart.md) %}

{% include [number-of-indicators-in-color-section](../../_qa/datalens/number-of-indicators-in-color-section.md) %}

{% include [creating-line-chart-with-columns](../../_qa/datalens/creating-line-chart-with-columns.md) %}

{% include [pie-chart-note](../../_qa/datalens/pie-chart-note.md) %}

{% include [making-logarithmic-scale](../../_qa/datalens/making-logarithmic-scale.md) %}

{% include [sign-last-point](../../_qa/datalens/sign-last-point.md) %}

{% include [sign-multiple-lines](../../_qa/datalens/sign-multiple-lines.md) %}

{% include [resize-column](../../_qa/datalens/resize-column.md) %}

{% include [rename-column](../../_qa/datalens/rename-column.md) %}

{% include [null-setting-in-charts](../../_qa/datalens/null-setting-in-charts.md) %}

## Calculated fields {#calculation-fields}

{% include [calculate-cumulative-sum](../../_qa/datalens/calculating-cumulative-sum.md) %}

{% include [calculate-ifnull-zn-nan](../../_qa/datalens/calculating-ifnull-zn-nan.md) %}

## Dashboards {#dashboards}

{% include [configure-link-between-selectors](../../_qa/datalens/configure-link-between-selectors.md) %}

{% include [unavailable-selector-values](../../_qa/datalens/unavailable-selector-values.md) %}

{% include [apply-filter-to-two-datasets](../../_qa/datalens/apply-filter-to-two-datasets.md) %}

{% include [configure-selectors](../../_qa/datalens/configure-selectors.md) %}

{% include [making-available-chart](../../_qa/datalens/making-available-chart.md) %}

### How do I make a dashboard containing Yandex Metrica or AppMetrica data public? {#how-metrica-appmetrica-share}

You can't publish a dashboard like this.

To share a dashboard containing Yandex Metrica or AppMetrica data, use one of the following methods:

{% include [datalens-metrica-appmetrica-share](../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}

## Other {#other}

### Can I get logs of my operations with services? {#logs}

Yes, you can request log records about your resources from {{ yandex-cloud }} services. For more information, see [{#T}](../../support/request.md).

{% include [copy-folder](../../_qa/datalens/copy-folder.md) %}

### Can I install {{ datalens-short-name }} locally inside the company? {#datalens-local}

{{ datalens-short-name }} is offered only as a cloud service. We would also like to note:

* {{ datalens-short-name }} is a {{ yandex-cloud }} service, which is compliant with Federal Law No. 152 and industry security standards. More information is available in [{{ yandex-cloud }} security]{% if lang == "ru" %}(https://cloud.yandex.ru/security){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en-ru/security){% endif %}.

* For {{ datalens-short-name }}, you can [set up identity federations](../../organization/quick-start.md).

### Why is the cloud with a {{ datalens-short-name }} instance blocked? {#datalens-suspended}

Your cloud may be blocked in the following cases:

* Outstanding charges for {{ yandex-cloud }} paid services that are in the same cloud as {{ datalens-short-name }}.
* Expiration of a trial period for {{ yandex-cloud }} paid services.
* Violation of the {{ yandex-cloud }} [Terms of Use]{% if lang == "ru" %}(https://yandex.ru/legal/cloud_termsofuse/?lang=ru){% endif %}{% if lang == "en" %}(https://yandex.ru/legal/cloud_termsofuse/?lang=en){% endif %}.

When a cloud is suspended, your {{ datalens-short-name }} instance will be unavailable. You won't be able to use {{ datalens-short-name }} until access to the cloud is restored.

Learn more in [Automatic cloud suspension](../../overview/concepts/data-deletion.md#block).

{% include [object-id](../../_qa/datalens/object-id.md) %}

{% include [network-error](../../_qa/datalens/network-error.md) %}

## How to report a problem {#how-to-resolve-problem}

There are two ways to report a problem:

* From the {{ datalens-full-name }} interface. In the {{ datalens-full-name }} interface, next to the error code, click **Report problem** and enter all the necessary details of the problem in the description. A {{ yandex-cloud }} support ticket will be created automatically.
* From a direct report to [technical support]({{ link-console-support }}) {{ yandex-cloud }}.

In your report, please provide (if possible):

* The most accurate description of the problem and the sequence of your actions.
* Images, GIFs, or videos.

You can leave feedback and suggestions regarding the service in the [{{ yandex-cloud }} user community](https://cloud.yandex.ru/features?serviceId=23).

To receive news and discuss best service practices, join the [DataLens](https://t.me/YandexDataLens) community in Telegram.
