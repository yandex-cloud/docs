# {{ maf-full-name }} release notes

This section contains {{ maf-name }} release notes.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## September 2024 {#sep-2024}

On September 16, 2024, {{ maf-name }} has entered the [General Availability](../overview/concepts/launch-stages.md) stage and its use is now charged according to the [pricing policy](pricing.md).

## June 2024 {#jun-2024}

* Now {{ AF }} job logs are stored in {{ objstorage-full-name }}. This addresses the issue of unavailable logs on disabled workers after autoscaling completion.
* In {{ lockbox-full-name }}, you can now store the connections, variables, and configuration data used in DAG files. For more information, see [Storing connections and variables in {{ lockbox-full-name }}](tutorials/lockbox-secrets-in-maf-cluster.md).

## May 2024 {#may-2024}

Now you can assign to a cluster a service account it will use to access other {{ yandex-cloud }} services, e.g., {{ cloud-logging-name }}, {{ monitoring-full-name }}, and {{ lockbox-full-name }}. It also enables the use of the full {{ yandex-cloud }} SDK functionality when writing DAG scripts with no need for additional authorization setup.

## April 2024 {#apr-2024}

* Now you can install deb packages as dependencies when [creating](operations/cluster-create.md) or [updating](operations/cluster-update.md) a cluster.
* Now you will get a clear error text in case of issues when installing pip and deb dependencies. Moreover, if you specified incorrect packages, the update cluster operation will roll back, allowing you to edit the input without contacting support.
* Scripts in DAG files now run faster.
