# {{ maf-full-name }} release notes

This section contains {{ maf-name }} release notes.

{% include [Tags](../_includes/mdb/release-notes-tags.md) %}

## April 2024 {#apr-2024}

* Now you can install deb packages as dependencies when [creating](operations/cluster-create.md) or [updating](operations/cluster-update.md) a cluster.
* Now you will get a clear error text in case of issues when installing pip and deb dependencies. Moreover, if you specified incorrect packages, the update cluster operation will roll back, allowing you to edit the input without contacting support.
* Scripts in DAG files now run faster.
