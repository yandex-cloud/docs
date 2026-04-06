When updating versions in {{ maf-name }}, you can change the following:

* Python version to any supported one for the current {{ AF }} version.
* {{ AF }} version to the next supported version within the same branch: `2.X` or `3.X`.

    You cannot update {{ AF }} from `2.X` to `3.X`. To update to `3.X`, [create a new cluster](../../managed-airflow/operations/cluster-create.md) and attach the old cluster's DAG storage to it.

{{ maf-name }} does not allow simultaneous updates of {{ AF }} and Python versions because user dependencies may stop working on newer Python versions.

For example, to update a cluster from {{ AF }} `2.8` and Python `3.8` to {{ AF }} `2.10` and Python `3.12`:

1. Update Python to `3.10` and test the cluster with its dependencies.
1. Update {{ AF }} to `2.10` and test the cluster after you migrate the database.
1. Update Python to `3.12` and test the dependencies again.
