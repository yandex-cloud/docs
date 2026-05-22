В этом примере вы установите демонстрационное приложение [Spring PetClinic](https://github.com/spring-projects/spring-petclinic) и настроите отправку телеметрии в {{ monium-name }}. 

Для установки демонстрационного приложения вы можете временно создать [виртуальную машину](../../compute/concepts/vm.md) {{ compute-full-name }}. Подробнее о создании подходящей виртуальной машины читайте в разделе [{#T}](../../compute/operations/vm-create/create-linux-vm.md).

Ниже приведены примеры команд для установки демонстрационного приложения в ОС Linux Ubuntu.

{% note warning %}

Для корректной работы агента `OTel Collector` на ВМ или сервере должен быть разрешен _исходящий трафик_ на TCP-порте `443`.

Для корректной работы демонстрационного приложения на ВМ или сервере должен быть разрешен _входящий трафик_ на TCP-портах `4317`, `4318` и `8080`.

При использовании виртуальной машины {{ compute-name }} [создайте](../../vpc/operations/security-group-create.md) и [привяжите](../../compute/operations/vm-control/vm-change-security-groups-set.md) к ней [группу безопасности](../../vpc/concepts/security-groups.md), разрешающую указанные типы трафика.

{% endnote %}