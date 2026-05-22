### No public access to managed YDB {#ydb-public}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | network.ydb-public ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for public access settings on YDB clusters.

{% endnote %}

When accessing the database in dedicated mode, we recommend that you use it inside VPC and disable public access to it from the internet. In serverless mode, the database can be accessed from the internet. You must therefore take this into account when modeling threats to your infrastructure. For more information about the operating modes, see the [Serverless and dedicated modes](https://yandex.cloud/en/docs/ydb/concepts/serverless-and-dedicated) section in the Managed Service for YDB documentation.

When setting up database permissions, use the principle of least privilege.

#### Guides and solutions

* For more information about the operating modes, see the Serverless and dedicated modes section in the Managed Service for [YDB documentation](https://yandex.cloud/en/docs/ydb/concepts/serverless-and-dedicated)
* When setting up database permissions, use the principle of least privilege.
