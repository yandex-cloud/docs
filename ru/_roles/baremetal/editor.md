
Роль `baremetal.editor` позволяет управлять серверами {{ baremetal-name }}, приватными подсетями, виртуальными сегментами сети (VRF) и образами операционных систем серверов.

Пользователи с этой ролью могут:
* просматривать информацию о [серверах](../../baremetal/concepts/servers.md) {{ baremetal-name }}, в том числе об их [конфигурации](../../baremetal/concepts/server-configurations.md);
* арендовать сервера {{ baremetal-name }} и отказываться от их аренды, а также изменять настройки серверов {{ baremetal-name }};
* просматривать информацию о [приватных подсетях](../../baremetal/concepts/private-network.md#private-subnet), а также создавать, изменять и удалять приватные подсети;
* просматривать информацию о [виртуальных сегментах сети (VRF)](../../baremetal/concepts/private-network.md#vrf-segment), а также создавать, изменять и удалять VRF;
* просматривать информацию о загруженных образах операционных систем серверов {{ baremetal-name }}, а также загружать, изменять и удалять такие образы;
* переустанавливать операционные системы серверов {{ baremetal-name }};
* [использовать KVM-консоль](../../baremetal/operations/servers/server-kvm.md) серверов;
* использовать [IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface) для управления питанием серверов — включать, выключать и перезагружать их;
* просматривать информацию о [квотах](../../baremetal/concepts/limits.md#baremetal-quotas) сервиса {{ baremetal-full-name }};
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `baremetal.operator`.