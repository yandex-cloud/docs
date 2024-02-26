[OS Login](../organization/concepts/os-login.md) используется для предоставления пользователям доступа к ВМ по SSH c помощью {{ iam-short-name }}. Для доступа к ВМ через OS Login необходимо [включить](../organization/operations/os-login-access.md) доступ через OS Login на уровне организации.

Для подключения к ВМ через OS Login у пользователя должна быть роль `compute.osLogin` или `compute.osAdminLogin`, а виртуальная машина должна поддерживать OS Login на уровне операционной системы. Вы можете [создать](../compute/operations/vm-connect/os-login-create-vm.md) новую виртуальную машину с поддержкой OS Login или [настроить](../compute/operations/vm-connect/enable-os-login.md) доступ через OS Login для существующей ВМ.

Чтобы подключиться к виртуальной машине через OS Login, нужно указать имя или идентификатор этой ВМ.

К ВМ с включенным доступом через OS Login нельзя подключиться с помощью [пары SSH-ключей](../compute/operations/vm-connect/ssh.md#creating-ssh-keys).