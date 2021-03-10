---
editable: false
---
# Pricing for {{ datalens-full-name }}

In {{ datalens-short-name }}, you pay for:

* The number of ten-minute sessions to the data source. The session considers requests from charts and dashboards.
* The size of the database for the materialized data.
* Additional {{ datalens-short-name }} features.

The number of sessions, the database size for materialized data, and the list of available features are determined by the monthly billing plan.
You can choose one of the following plans: **Free** or **Standard**.

The plan applies to [the folder](../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ datalens-short-name }} instance is located.

{% note info %}

Additional {{ datalens-short-name }} features that are available in {{ marketplace-short-name }} don't affect the selected plan and are paid separately.

{% endnote %}

## Prices and features {#prices}

{% list tabs %}

- Prices in USD

  | Service | Free | Standard |
  | ----- | ----- | ----- |
  | Monthly price, without VAT | Free | $24.358974 |
  | [Internal sessions](#session-types) per month | No limits | No limits |
  | [External sessions](#session-types) per month | 100 | 1000 |
  | One additional<br/> external session, with VAT | - | $0.024358 |
  | Database size for materialized data, GB | 0.5 | 10 |
  | Geocoding* | - | ✔ |

- Prices in roubles

  | Service | Free | Standard |
  | ----- | ----- | ----- |
  | Monthly price, with VAT | Free | ₽1900 |
  | [Internal sessions](#session-types) per month | No limits | No limits |
  | [External sessions](#session-types) per month | 100 | 1000 |
  | One additional<br/> external session, with VAT | - | ₽1.90 |
  | Database size for materialized data, GB | 0.5 | 10 |
  | Geocoding* | - | ✔ |

{% endlist %}

\* Geocoding functions: [GEOCODE](function-ref/GEOCODE.md) and [GEOINFO](function-ref/GEOINFO.md).

You can check the reporting period of your {{ datalens-short-name }} instance in your [billing account](https://datalens.yandex.com/billing).

## Session {#sessions}

Sessions are ten-minute periods when the user makes requests to a data source. For example, a user updates charts and dashboards and builds custom requests in the wizard.

![image](../_assets/datalens/concepts/datalens-sessions.svg)

The session starts with a data request and ends when there are no new requests for at least ten minutes.
The time difference between the first and last request is rounded up to ten minutes.

The session is calculated based on the user activity in the folder. If multiple users are working in the same {{ datalens-short-name }} instance at the same time, the service counts multiple sessions.
If one user is working in multiple {{ datalens-short-name }} instances at the same time, the service calculates sessions in these instances independently of one another.

### Session types {#session-types}

In {{ datalens-short-name }}, sessions are categorized as internal or external:

| Session type | Data source |
| ----- | ----- |
| Internal | Materialized datasets<br/>CSV connections<br/>Metrica<br/>Metrica Logs API<br/>AppMetrica<br/>AppMetrica Logs API<br/>Yandex.Cloud Managed Databases:<br/> - [Managed Service for ClickHouse](../managed-clickhouse)<br/> - [Managed Service for PostgreSQL](../managed-postgresql)<br/> - [Managed Service for MySQL<sup>®</sup>](../managed-mysql) |
| External | Any external data source that is not related to Yandex or Yandex.Cloud. |

### How sessions are calculated {#how-sessions-counted}

Each pricing plan determines the number of external sessions available. There is no limit to the number of internal sessions or requests, regardless of the pricing plan.
If a session has at least one request to an external data source, the whole session is considered external.

> For instance, a dashboard contains some charts that request a materialized dataset and a single chart that requests an external data source.

When this kind of dashboard updates, the session is considered external.

The session doesn't consider requests from:

* The preview window in datasets.
* Public dashboards and charts.

## Materialized data {#materialized-data}

A materialized data quota is available for each {{ datalens-short-name }} instance.

The quota includes:
* Dataset preview data.
* Materialized dataset data.
* Materialized connection data.
* Geocoding result caching data.

  {% note info %}

  The geocoding result cache is stored for 30 days.

  {% endnote %}

## Enabling a billing plan {#enable-the-plan}

To activate a billing plan, go to your billing account and select the desired plan. The period starts on the date when the {{ datalens-short-name }} instance is created.
When activating the **Standard** plan, you're charged on the first day of the period. When extending the plan, you're charged the day before the first day of a new reporting period.

If you created a billing account in the cloud, then the {{ datalens-short-name }} instance automatically switches to the **Free** plan.
Until you create a billing account, the {{ datalens-short-name }} instance remains in demo mode.

> If you created a {{ datalens-short-name }} instance on January 31, the next charge would occur on February 28 (or February 29 if it's a leap year).

### Switching plans {#change-the-plan}

You can switch from the **Free** to the **Standard** plan at any time. When you switch plans, the period starts the day the plan is switched.

So if you go from the **Standard** plan to the **Free** plan, the new plan and period would come into effect when the paid period under the **Standard** plan ends. In this case, the start date of the new period becomes the date the **Standard** plan ends.

### Automatic payment for additional sessions {#autoprolongation}

Under the **Standard** plan, you can set up automatic payment for additional sessions. To do this, you should specify your planned budget in the billing account.

Automatic payment isn't available in the **Free** plan. If you reach the session limit or the DB size limit for this plan, you can switch to the **Standard** plan.

## Blocks {#locks}

### Blocking when the external sessions limit is reached {#locks-sessions}

If you reach the limit on the number of external sessions, {{ datalens-short-name }} automatically disables requests from your charts and dashboards to external sources. Other {{ datalens-short-name }} features remain accessible.
The {{ datalens-short-name }} homepage will display a message saying that the limit is reached.

To unblock your resources, do one of the following:

* Switch from the **Free** plan to the **Standard** plan.
* Enable [automatic payment for additional sessions](#autoprolongation) for the **Standard** plan.
* Wait for the start of the new reporting period (for any plan).

### Cloud suspension {#locks-cloud}

Your cloud may be suspended if there are arrears on your account, if your trial period is over, or if you are in violation of the [{{ yandex-cloud }} Terms of Use](https://yandex.com/legal/cloud_termsofuse/).

When a cloud is suspended, your {{ datalens-short-name }} instance will be unavailable. You won't be able to use {{ datalens-short-name }} until access to the cloud is restored.

Learn more in [Automatic cloud suspension](../overview/concepts/data-deletion.md#block).