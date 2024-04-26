# Platform architecture {{ yandex-cloud }}

The {{ yandex-cloud }} platform is a suite of reliable and secure services for all kinds of business scenarios. The platform's services use a single pool of unified hardware resources. This makes the platform readily scalable and allows to automatically ramp up infrastructure capacity as needed at minimal cost.

![Architecture](../_assets/overview/architecture.svg =450x)

The {{ yandex-cloud }} network and server hardware is deployed in [four data centers](concepts/geo-scope.md). They host the platform's basic infrastructure: virtual networks and VMs, network block storages, and [YDB](https://ydb.tech). Thanks to virtualization, the data centers can be used to create simulated computing environments that divide physical and network infrastructures between VMs.

The [platform's services](concepts/services.md) run on top of the basic infrastructure. You can use the services through a number of interfaces: the [management console](../console/) and native service interfaces, the [{{ yandex-cloud }} mobile app](mobile-app/index.md), [the command-line interface (CLI)](../cli/), development tools, and [APIs](api.md).

