[OS Login](../organization/concepts/os-login.md) используется для предоставления пользователям доступа к ВМ по SSH c помощью {{ iam-short-name }}. Для доступа к ВМ по OS Login необходимо [включить](../organization/operations/os-login-access.md) доступ по OS Login на уровне организации.

Для подключения к ВМ по OS Login у пользователя должна быть роль `compute.osLogin` или `compute.osAdminLogin`, а виртуальная машина должна поддерживать OS Login на уровне операционной системы. Вы можете [создать](../compute/operations/vm-connect/os-login-create-vm.md) новую виртуальную машину с поддержкой OS Login или [настроить](../compute/operations/vm-connect/enable-os-login.md) доступ по OS Login для существующей ВМ.

Чтобы подключиться к виртуальной машине по OS Login, нужно указать имя или идентификатор этой ВМ.

К ВМ с включенным доступом по OS Login нельзя подключиться с SSH-ключом при помощи стандартного [SSH-клиента](../compute/operations/vm-connect/ssh.md#vm-connect).