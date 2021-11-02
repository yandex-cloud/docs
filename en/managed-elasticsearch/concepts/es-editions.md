# Elasticsearch editions

Features provided in {{ mes-name }} depend on the {{ ES }} edition:

| Name | Description | `BASIC` | `GOLD` | `PLATINUM` |
| ---------- | ---------- | :-----: | :----: | :--------: |
| Search and visualization | Basic Elasticsearch and Kibana search and visualization tools | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Data and delivery management | Managing data delivery from Kibana and the [index lifecycle](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-lifecycle-management.html) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Security and encryption | Support for encryption-in-transit, intra-cluster encryption, and role-based access control (RBAC) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Audit | Retrospective tracking for actions with clusters and their data | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Additional visualization tools | Easier viewing and working with information. For example, thanks to data-dependent dynamic link generation and export to PDF | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Advanced monitoring and notifications | Customized Jira, Slack, and email notification settings for monitoring | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Extended support for working with geodata | Aggregation by geo attributes | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Graph analytics | Analyzing relationships between index elements | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| Machine learning | ML features: anomaly detection, regression, and classification | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| Advanced access control | Integration with third-party authentication and authorization providers (SAML). Granular configuration of data access levels | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |

{% if audience == "draft" %}

{{ mes-name }} supports the following {{ ES }} editions:

- `BASIC`

    In this edition:

    - The minimum security settings are provided (authentication, authorization, and logging).
    - Basic monitoring features are provided.

- `GOLD`

    In this edition, the following is provided in addition to all the `BASIC` features:

    - Advanced security settings (Single Sign-On, attribute-level access control, and other features).
    - Support for Elasticsearch Token Service.
    - Export of reports to PDF and PNG.

- `PLATINUM`

    In this edition, the following is provided in addition to all the `GOLD` features:

    - All {{ ES }} security features.
    - Support for JDBC, ODBC, and Tableau Connector clients.
    - Integration with IBM Resilient and ServiceNow ITSM.
    - Cross-cluster replication.
    - Integration with ML technologies.
    - Use of private content sources.

{% endif %}

You can [update the {{ ES }} edition](../operations/cluster-version-update.md#start-edition-update) after you create a cluster. If you decide to downgrade the edition, please double-check that reduced functionality won't affect your applications.