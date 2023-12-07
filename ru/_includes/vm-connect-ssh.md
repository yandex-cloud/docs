Рекомендуемый способ подключения к [виртуальной машине](../compute/concepts/vm.md) по [SSH](../glossary/ssh-keygen.md) основан на использовании пары ключей: открытый ключ размещается на ВМ, закрытый ключ хранится у пользователя. Подключение с помощью пары ключей более безопасно, чем подключение по логину и паролю.

{% include [vm-connect-ssh-linux-note](vm-connect-ssh-linux-note.md) %}

## Создание пары ключей SSH {#creating-ssh-keys}

{% include [vm-ssh-prepare-key](vm-ssh-prepare-key.md) %}

## Подключение к виртуальной машине по SSH {#vm-connect}

Вы можете подключиться к ВМ по протоколу SSH, когда она будет запущена (в статусе `RUNNING`). Для этого можно использовать утилиту `ssh` в Linux и macOS и программу [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) для Windows.

Для подключения необходимо указать адрес ВМ. Это может быть [IP-адрес](../vpc/concepts/address.md) или ее [FQDN](../vpc/concepts/address.md#fqdn). Доступ по FQDN возможен из другой ВМ {{ yandex-cloud }}, если она подключена к той же [виртуальной сети](../vpc/concepts/network.md#network). IP-адрес для подключения можно узнать в [консоли управления]({{ link-console-main }}) на странице ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}**.

## Подключение к виртуальной машине через OS Login {#os-login-connect}

{% include notitle [preview](./note-preview-by-request.md) %}

[OS Login](../organization/concepts/os-login.md) используется для предоставления пользователям доступа к ВМ по SSH c помощью {{ iam-short-name }}. Для доступа к ВМ через OS Login необходимо [включить](../organization/operations/os-login-access.md) доступ через OS Login на уровне организации.

Для подключения к ВМ через OS Login у пользователя должна быть роль `compute.osLogin` или `compute.osAdminLogin`, а виртуальная машина должна поддерживать OS Login на уровне операционной системы. Вы можете [создать](../compute/operations/vm-connect/os-login-create-vm.md) новую виртуальную машину с поддержкой OS Login или [настроить](../compute/operations/vm-connect/enable-os-login.md) доступ через OS Login для существующей ВМ.

Чтобы подключиться к виртуальной машине через OS Login, нужно указать имя или идентификатор этой ВМ.

К ВМ с включенным доступом через OS Login нельзя подключиться с помощью [пары SSH-ключей](../compute/operations/vm-connect/ssh.md#creating-ssh-keys).