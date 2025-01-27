Роль `baremetal.operator` позволяет работать на серверах BareMetal, а также просматривать информацию о ресурсах сервиса Yandex BareMetal.

Пользователи с этой ролью могут:
* просматривать информацию о [серверах](../../baremetal/concepts/servers.md) BareMetal, в том числе об их [конфигурации](../../baremetal/concepts/server-configurations.md);
* [использовать KVM-консоль](../../baremetal/operations/servers/server-kvm.md) серверов;
* использовать [IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface) для управления питанием серверов — включать, выключать и перезагружать их;
* просматривать информацию о [приватных подсетях](../../baremetal/concepts/network.md#private-subnet) и [виртуальных сегментах сети (VRF)](../../baremetal/concepts/network.md#vrf-segment);
* просматривать информацию о загруженных образах операционных систем серверов;
* просматривать информацию о [квотах](../../baremetal/concepts/limits.md#baremetal-quotas) сервиса Yandex BareMetal;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `baremetal.viewer`.