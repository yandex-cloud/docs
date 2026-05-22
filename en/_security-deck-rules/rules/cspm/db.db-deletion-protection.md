### Deletion protection is enabled {#db-deletion-protection}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | db.db-deletion-protection ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for deletion protection on managed database clusters.

{% endnote %}

In Yandex Cloud managed databases, you can enable deletion protection. The deletion protection feature safeguards the cluster against accidental deletion by a user. Even with cluster deletion protection enabled, one can still connect to the cluster manually and delete the data.

#### Guides and solutions

1. In the management console, select the cloud or folder to enable deletion protection in.
2. In the list of services, select a service or services with managed databases.
3. In the object settings, go to the **Advanced settings** tab.
4. In the object parameters, enable **Deletion protection**.
