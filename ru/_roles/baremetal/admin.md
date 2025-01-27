Роль `baremetal.admin` позволяет управлять серверами BareMetal, приватными подсетями, виртуальными сегментами сети (VRF) и образами операционных систем серверов.

Пользователи с этой ролью могут:
* просматривать информацию о [серверах](../../baremetal/concepts/servers.md) BareMetal, в том числе об их [конфигурации](../../baremetal/concepts/server-configurations.md);
* арендовать сервера BareMetal и отказываться от их аренды, а также изменять настройки серверов BareMetal;
* просматривать информацию о [приватных подсетях](../../baremetal/concepts/network.md#private-subnet), а также создавать, изменять и удалять приватные подсети;
* просматривать информацию о [виртуальных сегментах сети (VRF)](../../baremetal/concepts/network.md#vrf-segment), а также создавать, изменять и удалять VRF;
* просматривать информацию о загруженных образах операционных систем серверов BareMetal, а также загружать, изменять и удалять такие образы;
* переустанавливать операционные системы серверов BareMetal;
* [использовать KVM-консоль](../../baremetal/operations/servers/server-kvm.md) серверов;
* использовать [IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface) для управления питанием серверов — включать, выключать и перезагружать их;
* просматривать информацию о [квотах](../../baremetal/concepts/limits.md#baremetal-quotas) сервиса Yandex BareMetal;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `baremetal.editor`.