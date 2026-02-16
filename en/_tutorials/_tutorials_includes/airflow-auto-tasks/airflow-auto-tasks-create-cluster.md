{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to [create a cluster](../../../managed-airflow/operations/cluster-create.md) in.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
  1. Click **{{ ui-key.yacloud.airflow.button_create-cluster }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, enter a name for your cluster. The name must be unique within the folder.
  1. Under **{{ ui-key.yacloud.airflow.section_accesses }}**, set a password for the admin user. The password must be not less than 8 characters long and contain at least:

        * One uppercase letter
        * One lowercase letter
        * One digit
        * One special character

     {% note info %}

     Save the password locally or memorize it. The service does not show passwords after the registry is created.

     {% endnote %}

  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select:

      * [Availability zone](../../../overview/concepts/geo-scope): `{{ region-id }}-a`
      * Cloud network: `yq-network`
      * Subnet: `yq-network-{{ region-id }}-a`
      * [Security group](../../../vpc/concepts/security-groups.md): default

        {% include [sg-ui-access](../../../_includes/mdb/maf/note-sg-ui-access.md) %}

  1. Under **{{ ui-key.yacloud.mdb.forms.section_dependencies }}**, specify the pip package name and version restriction:

      ```text
      apache-airflow-providers-yandex>=3.10
      ```

  1. Under **{{ ui-key.yacloud.airflow.section_storage }}**, select the bucket you created earlier.

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
