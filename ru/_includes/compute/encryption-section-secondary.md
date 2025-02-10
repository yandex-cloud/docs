(Опционально) Чтобы [зашифровать](../../compute/concepts/encryption.md) загрузочный или дополнительный диск, в блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** справа от имени диска нажмите значок ![image](../../_assets/console-icons/pencil.svg) и задайте параметры шифрования для диска:

* Выберите опцию **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}**.
* В поле **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** выберите [ключ](../../kms/concepts/key.md), которым вы хотите зашифровать диск. Чтобы [создать](../../kms/operations/key.md#create) новый ключ, нажмите кнопку **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.

{% include [encryption-role](encryption-role.md) %}

{% include [encryption-disable-warning](encryption-disable-warning.md) %}

{% include [encryption-keys-note](encryption-keys-note.md) %}
