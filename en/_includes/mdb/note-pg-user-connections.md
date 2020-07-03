{% note warning %}

The total number of connections reserved for users must not exceed the value of the parameter `max_connections`. Keep in mind that {{ mpg-short-name }} reserves 15 connections for service users per {{ PG }} host. For example, if the cluster has the setting `"max_connections": 100` you can reserve a maximum of 85 connections for cluster users.

{% endnote %}

