* **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../../../managed-kafka/concepts/maintenance.md) settings:

    {% include [Maintenance window](../console/maintenance-window-description.md) %}


* {% include [Deletion protection](../console/deletion-protection.md) %}

    Even with cluster deletion protection enabled, one can still delete a user or topic or connect manually and delete the data.


* **{{ ui-key.yacloud.mdb.forms.label_disk-encryption }}**: Enable this setting to encrypt the disks with a [custom KMS key](../../../kms/concepts/key.md).

   * To [create](../../../kms/operations/key.md#create) a new key, click **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.

   * To use the key you created earlier, select it in the **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** field.

   To learn more about disk encryption, see [Storage](../../../managed-kafka/concepts/storage.md#disk-encryption).

   {% note warning %}
   
   You can enable disk encryption only when creating a cluster.
   
   {% endnote %}


* **{{ ui-key.yacloud.kafka.field_schema-registry }}**: Enable this setting to manage data schemas using [{{ mkf-msr }}](../../../managed-kafka/concepts/managed-schema-registry.md).

    {% include [mkf-schema-registry-alert](schema-registry-alert.md) %}

* To allow sending requests to the {{ KF }} API, enable **{{ ui-key.yacloud.kafka.field_rest-api-config }}**.

    It is implemented using [Karapace](https://github.com/Aiven-Open/karapace), an open-source tool. The Karapace API is compatible with the [Confluent REST Proxy API](https://docs.confluent.io/platform/current/kafka-rest/api.html) with only minor exceptions.

    {% note warning %}

    You cannot disable **{{ ui-key.yacloud.kafka.field_rest-api-config }}** once it is enabled.

    {% endnote %}


* To use the [{{ KF }} web interface](../../../managed-kafka/concepts/kafka-ui.md), enable **{{ ui-key.yacloud.kafka.field_kafka-ui }}**.

