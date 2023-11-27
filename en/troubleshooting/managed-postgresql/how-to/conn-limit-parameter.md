# Understanding the Conn limit parameter



## Scenario description {#case-description}

You need to understand how the `Conn limit` parameter works in {{ mpg-full-name }}.

## Solution {#case-resolution}

The `Conn limit` setting specifies the maximum allowable number of connections per user. In *session pooling*, this setting limits the number of user connections with each host in the PostgreSQL cluster.

Basic principles of session pooling:
1. When creating a user, {{ mpg-full-name }} reserves for this user 50 connections to each host in the PostgreSQL cluster by default. The minimum number of connections per user is 1.
2. The total number of connections reserved for users must not exceed the value of the `Max connections` parameter. {{ mpg-full-name }} reserves 15 service connections per host.

For example, if the cluster has the `"max_connections": 100` setting, you can reserve a maximum of 85 connections per cluster host for users. At the same time, the sum of the `Conn limit` settings for all users in the cluster must not exceed 85.

{% note info %}

The `Max connections` setting specifies the maximum number of simultaneous connections to the PostgreSQL host. The minimum value is 1, while the maximum value and default value depend on the selected host class and are defined by the formula:
`200 × <number of vCPUs per host>`.

{% endnote %}

For hosts with a guaranteed vCPU share below 100% *(burstable)*, fixed maximum values are used:
- `b1.nano`, `b1.micro`, `b2.nano`, `b2.micro` — `100`
- `b1.medium`, `b2.medium` — `200`.

By default, the maximum value is used.

You can find detailed information in the [documentation](https://cloud.yandex.ru/docs/managed-postgresql/concepts/settings-list).