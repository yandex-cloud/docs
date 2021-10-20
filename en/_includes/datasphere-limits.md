#### Quotas {#datasphere-quotas}

| Type of limit | Value |
| ----- | ----- |
| Number of projects per cloud | 10 |
| Number of [custom images](../datasphere/operations/user-images.md) per cloud | 3 |
| Number of [datasets](../datasphere/concepts/dataset.md) per project | 3 |
| Total dataset capacity per cloud | 500 GB |
| Project storage volume^1^ | 10 GB |
| **Restrictions on the use of VM for individuals** | |
| c1.32 | 0 |
| c1.80 | 0 |
| g1.1 ^2^ | 0 |
| g1.2 | 0 |
| g1.4 | 0 |
| g2.1 | 0 |
| g2.8 | 0 |

^1^ for all projects created after October 15, 2021.

^2^ the quota increase is available when the balance of the billing account is more than {% if region == "ru" %}₽500{% endif %}{% if region == "kz" %}₸3000{% endif %}{% if region == "int" %}$10{% endif %} or by request to technical support.

#### Limits {#datasphere-limits}

{% note info %}

Technical restrictions on the maximum amount of data stored in the {{ ml-platform-name }} project are valid until December 15, 2021 and apply only to projects created before October 15, 2021.

{% endnote %}

| Type of limit | Value |
| ----- | ----- |
| Maximum amount of data stored in {{ ml-platform-name }} | 300 GB |

