# Versioning in {{ maf-name }}

## Available {{ AF }} versions {#available-versions}

{{ maf-name }} supports several {{ AF }} versions, each available on one of several Python versions. The following version combinations are supported:

Version {{ AF }} | Python version
--- | ---
2.8 | 3.8
2.8 | 3.10
2.10 | 3.10
2.10 | 3.12

## Version update {#update}

In {{ maf-name }}, version updates are performed according to the following rules:

* You can change your Python version to any supported for the current {{ AF }} version.
* You can change your {{ AF }} version to the next supported version.

Note that {{ maf-name }} does not allow the following update strategies:

* Dropping every other {{ AF }} version update. Each new {{ AF }} version requiring a metadata database migration, we recommend that you do your updates sequentially.
* Updating Python and {{ AF }} versions simultaneously. Custom dependencies may not work on newer versions of Python, so we recommend you to update your cluster components separately.

With that said, the recommended {{ maf-name }} cluster update strategy from `Airflow=2.8, Python=3.8` to `Airflow=2.10, Python.3=12` would be as follows:

1. Update Python to 3.10, make sure the cluster is up and running with the dependencies in place.
1. Update {{ AF }} to 2.10, make sure the cluster is up and running following the DB migration.
1. Update Python to 3.12, test the dependencies once again.
