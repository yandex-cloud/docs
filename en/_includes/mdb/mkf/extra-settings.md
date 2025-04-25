* **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../../../managed-kafka/concepts/maintenance.md) settings:

    {% include [Maintenance window](../console/maintenance-window-description.md) %}


* {% include [Deletion protection](../console/deletion-protection.md) %}

    Even with cluster deletion protection enabled, one can still delete a user or topic or connect manually and delete the data.

* To manage data schemas using [{{ mkf-msr }}](../../../managed-kafka/concepts/managed-schema-registry.md), enable the **{{ ui-key.yacloud.kafka.field_schema-registry }}** setting.

    {% include [mkf-schema-registry-alert](schema-registry-alert.md) %}

* To allow sending requests to the {{ KF }} API, enable **{{ ui-key.yacloud.kafka.field_rest-api-config }}**.

    It is implemented based on the [Karapace](https://github.com/Aiven-Open/karapace) open-source tool. The Karapace API is compatible with the [Confluent REST Proxy API](https://docs.confluent.io/platform/current/kafka-rest/api.html) with only minor exceptions.

    {% note warning %}

    You cannot disable **{{ ui-key.yacloud.kafka.field_rest-api-config }}** once it is enabled.

    {% endnote %}

