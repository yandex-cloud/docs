`os-settings` — настройки операционной системы. При аренде сервера укажите их в объекте `--server`, при переустановке ОС — в параметре `--os-settings`. Чтобы арендовать сервер без операционной системы, не передавайте поле `os-settings`. Возможные настройки:

* `image-id` — идентификатор одного из доступных [публичных образов](../../../baremetal/concepts/images.md#marketplace-images) ОС в {{ marketplace-full-name }}.
* `ssh-key` — SSH-ключ для подключения к серверу:

  * `ssh-public-key-text` — содержимое открытого SSH-ключа. Пару SSH-ключей для подключения к серверу по [SSH](../../../glossary/ssh-keygen.md) необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
  * `user-ssh-id` — идентификатор пользовательского SSH-ключа.
* `password` — пароль root-пользователя:

  * `password-plain-text` — пароль в открытом виде.

    {% include [server-lease-access-password-warning](../server-lease-access-password-warning.md) %}

  * `password-lockbox-secret` — [секрет](../../../lockbox/concepts/secret.md) {{ lockbox-full-name }}:

    * `secret-id` — идентификатор секрета.
    * `version-id` — версия секрета.
    * `key` — ключ секрета.
