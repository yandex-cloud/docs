# Step-by-step guides

## {{ iam-name }} {#iam}

* [Creating a user](iam/create-user.md)
* [Creating a user group](iam/create-group.md)
* [Connecting a SAML federation](iam/connect-saml-federation.md)
* [Assigning access permissions](iam/assign-role.md)

## Databases {#databases}

{{ mpg-name }}:

* [Creating a PostgreSQL cluster](postgresql/create-cluster.md)
* [Updating cluster settings](postgresql/edit-cluster.md)
* [Creating a user](postgresql/create-user.md)
* [Updating a user](postgresql/edit-user.md)
* [Deleting a user](postgresql/delete-user.md)
* [Creating a database](postgresql/create-database.md)
* [Updating a database](postgresql/edit-database.md)
* [Deleting a database](postgresql/delete-database.md)
* [Creating a backup](postgresql/new-copy.md)
* [Recovering a cluster](postgresql/recover-copy.md)
* [Deleting a cluster](postgresql/delete-cluster.md)

{{ mch-name }}:

* [Creating an {{ CH }}](clickhouse/create-cluster.md) cluster
* [Updating cluster settings](clickhouse/edit-cluster.md)
* [Creating a backup](clickhouse/new-copy.md)
* [Recovering a cluster](clickhouse/recover-copy.md)
* [Deleting a cluster](clickhouse/delete-cluster.md)
* [Creating a database](clickhouse/create-database.md)
* [Updating a database](clickhouse/edit-database.md)
* [Deleting a database](clickhouse/delete-database.md)
* [Creating a role](clickhouse/create-role.md)
* [Editing a role](clickhouse/edit-role.md)
* [Deleting a role](clickhouse/delete-role.md)
* [Creating a user](clickhouse/create-user.md)
* [Updating a user](clickhouse/edit-user.md)
* [Deleting a user](clickhouse/delete-user.md)

{{ yt-name }}:

* [Enabling {{ yt-name }}](ytsaurus/enable.md)
* [Updating cluster settings](ytsaurus/edit-cluster.md)
* [Getting an administrator password and token](ytsaurus/get-admin-credentials.md)
* [Opening the web UI](ytsaurus/connect-ui.md)
* [Connecting to the HTTP proxy](ytsaurus/connect-api.md)
* [Disabling {{ yt-name }}](ytsaurus/disable.md)

## {{ rest-catalog-name }} {#rest-catalog}

* [Creating a catalog](rest-catalog/create-catalog.md)
* [Updating a catalog](rest-catalog/edit-catalog.md)
* [Creating a catalog user](rest-catalog/create-principal.md)
* [Deleting a catalog user](rest-catalog/delete-principal.md)
* [Deleting a catalog](rest-catalog/delete-catalog.md).

## Buckets {#buckets}

* [Creating a bucket](storage/create-bucket.md)
* [Creating AccessKey](storage/create-accesskey.md)
* [Deleting a bucket](storage/delete-bucket.md)
* [Deleting AccessKey](storage/delete-accesskey.md)

## Message broker {#broker}

* [Creating an {{ KF }} cluster](kafka/create-cluster.md)
* [Creating a topic](kafka/create-topic.md)
* [Creating a user](kafka/create-user.md)
* [Connecting to a cluster](kafka/connect-to-kafka.md)
* [Deleting a cluster](kafka/delete-cluster.md)
* [Deleting a topic](kafka/delete-topic.md)
* [Deleting a user](kafka/delete-user.md)

## Logging {#logging}

* [Viewing logs](logging/logs-view.md)
* [Recovering Loki in standalone mode if PVC is full](logging/loki-recovery.md)

## Monitoring {#monitoring}

* [Creating a dashboard](monitoring/dashboard-create.md)
* [Updating a dashboard](monitoring/dashboard-update.md)
* [Deleting a dashboard](monitoring/dashboard-delete.md)
* [Managing access to dashboards](monitoring/dashboard-access.md)
* [Creating a notification channel](monitoring/alerts-create-contact-point.md)
* [Creating an alert rule](monitoring/alerts-create-rule.md)

## {{ datalens-name }} {#datalens}

* [Installing images](datalens/install-images.md)
* [Enabling {{ datalens-name }}](datalens/configure.md)
* [Disabling {{ datalens-name }}](datalens/disable.md)

## Policies {#policies}

* [Activating a policy preset](policy-manager/apply-preset.md)
* [Deactivating a policy](policy-manager/apply-mute.md)
* [Deleting a policy preset](policy-manager/delete-preset.md)

## {{ speechsense-name }} {#speechsense}

* [Uploading images](speechsense/install-images.md)
* [Configuring and activating](#scaling-settings)
* [Disabling](speechsense/disable.md)

## Projects {#projects}

* [Creating a project](projects/create-project.md)
* [Managing namespaces](projects/manage-namespaces.md)
* [Configuring roles in a project](projects/project-roles.md)
* [Setting project quotas](projects/namespace-quotas.md)

## Disk subsystem {#disk-storage}

* [Diagnosing a disk subsystem](disk-storage/troubleshooting.md)
* [Switching storage class of a component](disk-storage/change-storage-class.md)

## Managing a cluster {#cluster-management}

* [Upgrading a cluster](cluster/upgrade-cluster.md)
* [Scaling a cluster](cluster/scale-cluster.md)
