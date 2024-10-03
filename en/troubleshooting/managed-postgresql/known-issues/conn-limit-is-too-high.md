# Resolving the "max_connections conn_limit is too high" error


## Issue description {#issue-description}

You see the `max_connections conn_limit is too high` error.

## Solution {#issue-resolution}

By default, {{ mpg-full-name }} sets the maximum possible limit on the number of connections to each PostgreSQL cluster host. This maximum is calculated as follows: `200 × <number of vCPUs per host>`. For example, for an `s1.micro` cluster, the default value of the `max_connections` parameter is 400, and it cannot be increased. To have more connections, you need to upgrade the cluster class.

{% note info %}

{{ mpg-full-name }} reserves 15 connections for service users on each PostgreSQL host.

For example, if the `max_connections` parameter set for the cluster is 100, you can reserve no more than 85 connections for your cluster users.

{% endnote %}
