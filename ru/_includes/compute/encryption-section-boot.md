(Опционально) Чтобы [зашифровать](../../compute/concepts/encryption.md) загрузочный диск, в блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** задайте для диска параметры шифрования:

  * Выберите опцию **Зашифрованный диск**.
  * В поле **Ключ {{ kms-short-name }}** выберите [ключ](../../kms/concepts/key.md), которым вы хотите зашифровать диск. Чтобы [создать](../../kms/operations/key.md#create) новый ключ, нажмите кнопку **Создать**.
  * В поле **Сервисный аккаунт** выберите [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) c [ролью](../../iam/concepts/access-control/roles.md#kms-keys-encrypterdecrypter) `kms.keys.encrypterDecrypter` на указанный ключ. Чтобы [создать](../../iam/operations/sa/create.md) новый сервисный аккаунт, нажмите кнопку **Создать**.

  {% include [encryption-preview-note](encryption-preview-note.md) %}

  {% include [encryption-keys-note](encryption-keys-note.md) %}
