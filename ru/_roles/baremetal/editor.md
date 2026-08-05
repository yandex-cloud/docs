
Роль `baremetal.editor` позволяет управлять серверами {{ baremetal-name }}, приватными подсетями, виртуальными сегментами сети (VRF) и образами операционных систем серверов, а также резервным копированием серверов с помощью сервиса {{ backup-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [серверах](../../baremetal/concepts/servers.md) {{ baremetal-name }}, в том числе об их [конфигурации](../../baremetal/concepts/server-configurations.md);
* арендовать сервера {{ baremetal-name }} и отказываться от их аренды, а также изменять настройки серверов {{ baremetal-name }};
* просматривать информацию о [приватных подсетях](../../baremetal/concepts/private-network.md#private-subnet), а также создавать, изменять и удалять приватные подсети;
* просматривать информацию о [виртуальных сегментах сети (VRF)](../../baremetal/concepts/private-network.md#vrf-segment), а также создавать, изменять и удалять VRF;
* просматривать информацию о загруженных образах операционных систем серверов {{ baremetal-name }}, а также загружать, изменять и удалять такие образы;
* переустанавливать операционные системы серверов {{ baremetal-name }};
* [использовать KVM-консоль](../../baremetal/operations/servers/server-kvm.md) серверов;
* использовать [IPMI](https://en.wikipedia.org/wiki/Intelligent_Platform_Management_Interface) для управления питанием серверов — включать, выключать и перезагружать их;
* просматривать информацию о подключенных [провайдерах](../../backup/concepts/index.md#providers) резервного копирования, а также подключать провайдеров, доступных в {{ backup-name }};
* просматривать информацию о [подключенных](../../backup/concepts/vm-connection/index.md) к {{ backup-name }} защищаемых ресурсах, а также подключать и отключать защищаемые ресурсы от сервиса;
* просматривать информацию о [политиках резервного копирования](../../backup/concepts/policy.md) и привязанных к ним ресурсах;
* привязывать политики резервного копирования к защищаемым ресурсам, а также отвязывать их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к политикам резервного копирования;
* просматривать информацию о [квотах](../../baremetal/concepts/limits.md#baremetal-quotas) сервиса {{ baremetal-full-name }};
* просматривать информацию о [квотах](../../backup/concepts/limits.md#backup-quotas) сервиса {{ backup-name }};
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролями `baremetal.operator` и `backup.user`.