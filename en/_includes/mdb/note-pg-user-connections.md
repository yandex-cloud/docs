> [!IMPORTANT]

The total number of connections reserved for users must not exceed the value of the parameter `max_connections`. Keep in mind that [!KEYREF mpg-short-name] reserves 15 connections for service users per user [!KEYREF PG] host. For example, if the cluster has the setting `"max_connections": 100` you can reserve a maximum of 85 connections for cluster users.

