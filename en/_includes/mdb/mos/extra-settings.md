* **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../../../managed-opensearch/concepts/maintenance.md) settings:

    {% include [Maintenance window](../console/maintenance-window-description.md) %}


* **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** is an account [to access {{ objstorage-full-name }}](../../../managed-opensearch/operations/s3-access.md) as a repository of {{ OS }} snapshots. For more detail on service accounts, see the [{{ iam-full-name }} documentation](../../../iam/concepts/users/service-accounts.md).



* {% include [Deletion protection](../console/deletion-protection.md) %}

    Even with cluster deletion protection enabled, one can still delete a user or connect to the cluster manually and delete the data.
