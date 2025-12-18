# How `Conn limit` works



## Case description {#case-description}

You need to understand how the `Conn limit` parameter works in {{ mpg-name }}.

## Solution {#case-resolution}

`Conn limit` sets the maximum allowed number of connections per user. In *session pooling*, this setting limits the number of user connections to each host in a {{ PG }} cluster.

Here are the basic principles of session pooling:

1. When creating a user, {{ mpg-name }} reserves for this user 50 connections to each host in a {{ PG }} cluster by default. The minimum number of connections per user is 1.
1. The total number of connections reserved for users must not exceed the `Max connections` value. {{ mpg-name }} reserves 15 service connections per host.

For example, if the cluster is set to `"max_connections": 100`, you can reserve a maximum of 85 connections per cluster host for users. At the same time, the sum of the `Conn limit` values for all users in the cluster must not exceed 85.

{% note info %}

`Max connections` sets the maximum number of concurrent connections to a {{ PG }} host. The minimum value is 1. The maximum and default values are host class-dependent and calculated as follows:

```
200 × <Number of vCPUs per host>
```

{% endnote %}

Hosts with a guaranteed vCPU share below 100% *(burstable)* use fixed maximum values:

* `b1.nano`, `b1.micro`, `b2.nano`, `b2.micro`: 100
* `b1.medium`, `b2.medium`: 200

By default, the maximum value is used.

You can find detailed information in [this article](../../../managed-postgresql/concepts/settings-list.md).