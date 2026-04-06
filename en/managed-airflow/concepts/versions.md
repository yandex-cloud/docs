# Versioning in {{ maf-name }}

## Available {{ AF }} versions {#available-versions}

{{ maf-name }} supports several {{ AF }} versions, each available on one of several Python versions. The following version combinations are supported:

Version {{ AF }} | Python version
--- | ---
2.8 | 3.8
2.8 | 3.10
2.10 | 3.10
2.10 | 3.12
3.0 | 3.12
3.1 | 3.12

{% note warning %}

The package contents in {{ AF }} may vary in different versions. Some packages available in earlier versions are not included in {{ AF }} 3.0 and higher. If required, you can install them when creating or updating a cluster.

{% endnote %}

## Version update {#update}

{% include [version-update-rules](../../_includes/managed-airflow/version-update-rules.md) %}

#### See also {#see-also}

* [{{ AF }}](update-policy.md) versioning policy
* [{#T}](../operations/cluster-version-update.md)
