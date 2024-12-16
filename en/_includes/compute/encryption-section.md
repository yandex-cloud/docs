Optionally, under **{{ ui-key.yacloud.compute.disk-form.section_encryption }}**:

  * Select **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}**.
  * In the **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** field, select the [key](../../kms/concepts/key.md) you created earlier. To [create](../../kms/operations/key.md#create) a new key, click **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.

  {% include [encryption-disable-warning](encryption-disable-warning.md) %}
  
  {% include [encryption-keys-note](encryption-keys-note.md) %}
