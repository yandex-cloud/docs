(Опционально) В блоке **{{ ui-key.yacloud.compute.disk-form.section_encryption }}**:

  * Выберите опцию **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}**.
  * В поле **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** выберите [ключ](../../kms/concepts/key.md), созданный ранее. Чтобы [создать](../../kms/operations/key.md#create) новый ключ, нажмите кнопку **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.

  {% include [encryption-role](encryption-role.md) %}

  {% include [encryption-disable-warning](encryption-disable-warning.md) %}
  
  {% include [encryption-keys-note](encryption-keys-note.md) %}
