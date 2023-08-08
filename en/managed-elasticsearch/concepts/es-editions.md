# Elasticsearch editions

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

{% note info %}

As of June 13, 2022, the `Gold` edition in {{ mes-name }} clusters is no longer supported. You cannot create a new cluster with this edition or switch to it from `Basic` or `Platinum`. On July 6, 2022, all `Gold` edition clusters were automatically upgraded to `Platinum`.

{% endnote %}

Features provided in {{ mes-name }} depend on the {{ ES }} edition:

| Name | Description | `Basic` | `Gold` | `Platinum` |
|----------|----------| :-----: | :----: | :--------: |
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


You can [upgrade the {{ ES }} edition](../operations/cluster-version-update.md#start-edition-update) after you create a cluster. If you decide to downgrade the edition, please double-check that reduced functionality won't affect your applications.
