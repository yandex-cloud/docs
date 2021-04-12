# Elasticsearch editions

Features provided in {{ mes-name }} depend on the {{ ES }} edition:

| Name | `BASIC` | `GOLD` | `PLATINUM` |
| ------------------------------------------- | :----------------------------------: | :----------------------------------: | :----------------------------------: |
| Search and visualization | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Security and encryption | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Audit | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Additional visualization tools | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Advanced monitoring | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Extended support for working with geodata | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg) |
| Graph analysis | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| Machine learning | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |
| Advanced access control | ![no](../../_assets/common/no.svg) | ![no](../../_assets/common/no.svg) | ![yes](../../_assets/common/yes.svg) |

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

