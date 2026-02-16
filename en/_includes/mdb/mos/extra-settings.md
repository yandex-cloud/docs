* **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../../../managed-opensearch/concepts/maintenance.md) settings:

    {% include [Maintenance window](../console/maintenance-window-description.md) %}


* **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: Account for [accessing {{ objstorage-full-name }}](../../../managed-opensearch/operations/s3-access.md) as a repository of {{ OS }} snapshots. Learn more about service accounts in [this {{ iam-full-name }} guide](../../../iam/concepts/users/service-accounts.md).



* {% include [Deletion protection](../console/deletion-protection.md) %}

    Even with cluster deletion protection enabled, it is still possible to delete a user or connect to the cluster manually and delete the data.
