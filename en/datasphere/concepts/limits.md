# Quotas and limits in {{ ml-platform-name }}

{{ ml-platform-full-name }} has the following limits:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

#### Quotas {#datasphere-quotas}

| Type of limit | Value |
--- | ---
| Number of [projects](./project.md) in [community](./community.md) | 10 |
| Total [dataset](./dataset.md) size in community | 1024 GB |
| Number of datasets in community | 10 |
| Number of Docker images in community | 3 |
| Project [storage](./project.md#storage) size (can [be increased in project](../operations/projects/storage-resize.md)) | 10 GB |
| Number of communities linked to one [billing account](../../billing/concepts/billing-account.md) | 100 |
| Number of communities per [organization](../../organization/) | 100 |
| **VM use restrictions for individuals** |
| c1.32 | 0 |
| c1.80 | 0 |
| g1.1 ^1^ | 0 |
| g1.2 | 0 |
| g1.4 | 0 |
| g2.1 | 0 |
| g2.2 | 0 |
| g2.4 | 0 |
| g2.8 | 0 |

^1^ [quotas]({{ link-console-quotas }}) can be increased if the billing account balance exceeds {% if region == "ru" %}₽500{% endif %}{% if region == "kz" %}₸3000{% endif %}{% if region == "int" %}$10{% endif %} or upon request to the support team.

#### Limits {#datasphere-limits}

| Type of limit | Value |
--- | ---
| Number of datasets concurrently connected to project | 3 |
| Maximum pinned [checkpoints](./checkpoints.md) in project | 10 |
| Maximum non-pinned checkpoints in project | 10 |
| Maximum project storage size | 4096 GB |
| Maximum dataset size | 4096 GB |