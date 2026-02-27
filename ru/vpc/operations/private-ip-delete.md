---
title: Удалить зарезервированный внутренний IP-адрес
description: Следуя данной инструкции, вы сможете освободить зарезервированный внутренний IP-адрес.
---

# Удалить внутренний IP-адрес

Перед удалением зарезервированный адрес необходимо освободить, удалив ресурс, к которому он привязан.

Если для адреса включена защита от удаления, то перед удалением адреса ее нужно отключить, деактивировав соответствующую опцию.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога, в котором находится нужный адрес.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. Выберите подсеть, в которой находится зарезервированный адрес.
   1. Перейдите на вкладку ![addresses](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.subnetworks.switch_ip-addresses }}**.
   1. Рядом с IP-адресом, который нужно удалить, нажмите кнопку ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}