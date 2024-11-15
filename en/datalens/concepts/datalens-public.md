# Public access

You can make the charts and dashboards you create public, so any user can follow a link and view the object you published without logging in. However, the user will not be able to view chart settings, connections, or the dataset, or run an SQL query.

{% include [share-note](../../_includes/datalens/datalens-share-note.md) %}

## Publishing rules {#rules}

Before publishing data, make sure that:

* You have the `{{ permission-admin }}` permission to published charts, dashboards, and related objects.
* Your charts and dashboards do not contain any personal data or trade secrets. Access to published data is not restricted.
* The connection your objects run on top of supports data publication. You cannot publish data from the following connections:
  
  * [Snowflake](../operations/connection/create-snowflake.md)
  * [Metrica](../operations/connection/create-metrica-api.md)
  * [AppMetrica](../operations/connection/create-appmetrica.md)
  * [{{ yandex-cloud }} Billing](../operations/connection/create-cloud-billing.md)
  * [{{ datalens-short-name }} Usage Analytics](../operations/connection/create-usage-tracking.md)

    {% note info %}

    You can [share](#metrica-share) a dashboard or chart based on Yandex Metrica or AppMetrica data.

    {% endnote %}

To secure your published data:

* Grant the user permission to view only the tables that are used to build a dataset when connecting to a database.
* Minimize the data in a dataset and only add the required filters to your dashboard. You can download data on a public dashboard in a machine-readable format.

## Publishing an object {#how-to-publish}

{% list tabs group=datalens_public %}

- Publishing a dashboard {#dashboard}

  {% include [datalens-public-dashboard](../../_includes/datalens/operations/datalens-public-dashboard.md) %}

- Publishing a chart {#chart}

  {% include [datalens-public-chart](../../_includes/datalens/operations/datalens-public-chart.md) %}

{% endlist %}

## Viewing published objects {#public-objects-list}

The {{ datalens-short-name }} instance [admin](../security/roles.md#datalens-admin) may view a list of all objects published within that instance:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![sliders](../../_assets/console-icons/sliders.svg) **Service settings**.
1. Under **Publication**, click **View published**.

## Sharing a chart based on Yandex Metrica or AppMetrica data {#metrica-share}

To share a chart or dashboard containing Yandex Metrica or AppMetrica data, use one of the following methods:

{% include [datalens-metrica-appmetrica-share](../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}

## Disabling publication {#publication-disable}

{% include [business-note](../../_includes/datalens/datalens-functionality-available-business-note.md) %}

By default, users can publish charts and dashboards for which they have the admin permissions. You can disable this option at the {{ datalens-short-name }} instance level. After you disable publication:

* All previously published objects will no longer be public.
* Users will not be able to grant public access to objects.

Only the instance [admin](../security/roles.md#datalens-admin) (the `{{ roles-datalens-admin }}`role) can disable publication.

To disable object publication:

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. In the left-hand panel, select ![sliders](../../_assets/console-icons/sliders.svg) **Service settings**.
1. Under **Publication**:

   1. View a list of published objects that will no longer be publicly accessible. To do this, click **View published**.
   1. Disable **Publication**.

#### See also: {#see-also}

* [{#T}](../security/embedded-objects.md)
