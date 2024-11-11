[{{ oslogin }}](../organization/concepts/os-login.md) используется для предоставления пользователям доступа к ВМ по SSH c помощью {{ iam-short-name }}. Для доступа к ВМ по {{ oslogin }} необходимо [включить](../organization/operations/os-login-access.md) доступ по {{ oslogin }} на уровне организации.

Для подключения к ВМ по {{ oslogin }} у пользователя должна быть роль `compute.osLogin` или `compute.osAdminLogin`, а виртуальная машина должна поддерживать {{ oslogin }} на уровне операционной системы. Вы можете [создать](../compute/operations/vm-connect/os-login-create-vm.md) новую виртуальную машину с поддержкой {{ oslogin }} или [настроить](../compute/operations/vm-connect/enable-os-login.md) доступ по {{ oslogin }} для существующей ВМ.

Чтобы подключиться к виртуальной машине по {{ oslogin }}, нужно указать имя или идентификатор этой ВМ.

К ВМ с включенным доступом по {{ oslogin }} нельзя подключиться с SSH-ключом при помощи стандартного [SSH-клиента](../compute/operations/vm-connect/ssh.md#vm-connect).