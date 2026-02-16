# Fixing the `max_connections conn_limit is too high` error



## Issue description {#issue-description}

You get the `max_connections conn_limit is too high` error when connecting to {{ mpg-name }}.

## Solution {#issue-resolution}

By default, {{ mpg-name }} limits the maximum number of connections to each {{ PG }} cluster host. This maximum value is calculated as follows: `200 × <number of vCPUs on each host>`. For an `s1.micro` class cluster, the default `max_connections` value is 400, and it cannot be increased. To have more connections, you need to upgrade the cluster class.

{% note info %}

{{ mpg-name }} reserves 15 connections for service users per {{ PG }} host. 

For example, if `max_connections` is set to 100 for the cluster, you can reserve no more than 85 connections for your cluster users.

{% endnote %}