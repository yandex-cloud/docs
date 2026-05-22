### The setting for access from DataLens is not active if not needed {#db-datalens-access}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | access.db-datalens-access ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for DataLens access settings on managed database clusters.

{% endnote %}

Do not enable access to databases containing critical data from the management console, [DataLens](https://yandex.cloud/en/docs/datalens), or other services unless you have to. Access from DataLens may be required for data analysis and visualization. For such access, the Yandex Cloud service network is used, with authentication and TLS encryption. You can enable and disable access from DataLens or other services in the cluster settings or when creating it in the advanced settings section.

#### Guides and solutions

Instructions and solutions for implementation:

1. In the management console, select the cloud or folder where you want to disable access from DataLens.
2. In the list of services, select the service(s) where the managed databases are located.
3. In the object settings, go to the tab **Additional settings**.
4. In the object's parameters, disable the **Access from DataLens** option.