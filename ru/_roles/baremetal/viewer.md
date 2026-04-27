
Роль `baremetal.viewer` позволяет просматривать информацию о ресурсах сервиса{{ baremetal-full-name }}.

Пользователи с этой ролью могут:
* просматривать информацию о [серверах](../../baremetal/concepts/servers.md) {{ baremetal-name }}, в том числе об их [конфигурации](../../baremetal/concepts/server-configurations.md);
* просматривать информацию о [приватных подсетях](../../baremetal/concepts/private-network.md#private-subnet) и [виртуальных сегментах сети (VRF)](../../baremetal/concepts/private-network.md#vrf-segment);
* просматривать информацию о загруженных образах операционных систем серверов {{ baremetal-name }};
* просматривать информацию о [квотах](../../baremetal/concepts/limits.md#baremetal-quotas) сервиса {{ baremetal-full-name }};
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `baremetal.auditor`.