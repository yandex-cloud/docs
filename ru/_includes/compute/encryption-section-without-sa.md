(Опционально) Чтобы [зашифровать](../../compute/concepts/encryption.md) диск, в блоке **{{ ui-key.yacloud.compute.instances.create.section_storages }}** задайте для диска параметры шифрования:

  * Выберите опцию **Зашифрованный диск**.
  * В поле **Ключ {{ kms-short-name }}** выберите [ключ](../../kms/concepts/key.md), которым вы хотите зашифровать диск. Чтобы [создать](../../kms/operations/key.md#create) новый ключ, нажмите кнопку **Создать**.

  {% include [encryption-keys-note](encryption-keys-note.md) %}
