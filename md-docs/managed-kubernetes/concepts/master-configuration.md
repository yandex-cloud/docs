# Рекомендуемые конфигурации мастера

Конфигурацию [мастера](index.md#master) можно выбрать при [создании](../operations/kubernetes-cluster/kubernetes-cluster-create.md) или [изменении](../operations/kubernetes-cluster/kubernetes-cluster-update.md#manage-resources) кластера. Для стабильной работы конфигурация мастера должна соответствовать нагрузке на кластер {{ k8s }}.

С помощью таблицы можно подобрать минимальную конфигурацию мастера мастера по параметрам кластера. Конфигурации могут меняться, [смотрите список доступных конфигураций](../operations/kubernetes-cluster/kubernetes-cluster-configuration-list.md).

Выбранная конфигурация задает минимальные значения ресурсов для мастера. Если в кластере работает [автоматическое масштабирование мастера](autoscale.md#master-autoscaler), выбранная конфигурация будет использоваться в качестве нижней границы масштабирования.

#|
|| **Параметры кластера** {align="center"} | > | > | **Расчетные требования к мастеру** {align="center"} | > | **Рекомендуемая конфигурация мастера** {align="center"} | > | > ||
|| **CNI** | **Узлы** | **Максимум подов** | **vCPU** | **RAM** | **Standard** | **CPU Optimized** | **Memory Optimized** ||
|| Calico | 128 | 8&nbsp;192 | 3 vCPU | 12 ГБ | 4 vCPU, 16 ГБ RAM (s-c4-m16) | 8 vCPU, 16 ГБ RAM (c-c8-m16) | 4 vCPU, 32 ГБ RAM (m-c4-m32) ||
|| Calico | 128 | 14&nbsp;080 | 6 vCPU | 21 ГБ | 8 vCPU, 32 ГБ RAM (s-c8-m32) | 16 vCPU, 32 ГБ RAM (c-c16-m32) | 8 vCPU, 64 ГБ RAM (m-c8-m64) ||
|| Calico | 256 | 16&nbsp;384 | 6 vCPU | 24 ГБ | 8 vCPU, 32 ГБ RAM (s-c8-m32) | 16 vCPU, 32 ГБ RAM (c-c16-m32) | 8 vCPU, 64 ГБ RAM (m-c8-m64) ||
|| Calico | 256 | 28&nbsp;160 | 11 vCPU | 42 ГБ | 16 vCPU, 64 ГБ RAM (s-c16-m64) | 32 vCPU, 64 ГБ RAM (c-c32-m64) | 16 vCPU, 128 ГБ RAM (m-c16-m128) ||
|| Calico | 512 | 32&nbsp;768 | 12 vCPU | 48 ГБ | 16 vCPU, 64 ГБ RAM (s-c16-m64) | 32 vCPU, 64 ГБ RAM (c-c32-m64) | 16 vCPU, 128 ГБ RAM (m-c16-m128) ||
|| Cilium | 128 | 8&nbsp;192 | 4 vCPU | 16 ГБ | 4 vCPU, 16 ГБ RAM (s-c4-m16) | 8 vCPU, 16 ГБ RAM (c-c8-m16) | 4 vCPU, 32 ГБ RAM (m-c4-m32) ||
|| Cilium | 128 | 14&nbsp;080 | 7 vCPU | 26 ГБ | 8 vCPU, 32 ГБ RAM (s-c8-m32) | 16 vCPU, 32 ГБ RAM (c-c16-m32) | 8 vCPU, 64 ГБ RAM (m-c8-m64) ||
|| Cilium | 256 | 16&nbsp;384 | 8 vCPU | 30 ГБ | 8 vCPU, 32 ГБ RAM (s-c8-m32) | 16 vCPU, 32 ГБ RAM (c-c16-m32) | 8 vCPU, 64 ГБ RAM (m-c8-m64) ||
|| Cilium | 256 | 28&nbsp;160 | 13 vCPU | 51 ГБ | 16 vCPU, 64 ГБ RAM (s-c16-m64) | 32 vCPU, 64 ГБ RAM (c-c32-m64) | 16 vCPU, 128 ГБ RAM (m-c16-m128) ||
|| Cilium | 512 | 32&nbsp;768 | 15 vCPU | 59 ГБ | 16 vCPU, 64 ГБ RAM (s-c16-m64) | 32 vCPU, 64 ГБ RAM (c-c32-m64) | 16 vCPU, 128 ГБ RAM (m-c16-m128) ||
|#