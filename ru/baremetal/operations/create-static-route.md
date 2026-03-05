---
title: Как создать статический маршрут в VRF {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете настроить статический маршрут в VRF {{ baremetal-full-name }}.
---

# Создать статический маршрут

В приватной сети {{ baremetal-full-name }} вы можете создавать [статические маршруты](../concepts/private-network.md#static-routes) для сетевого трафика.

{% include [static-routes-to-vpc-ri-notice2](../../_includes/baremetal/static-routes-to-vpc-ri-notice2.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужный [виртуальный сегмент сети (VRF)](../concepts/private-network.md#vrf-segment).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![vector-square](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud.baremetal.label_networks }}** и в открывшемся списке выберите VRF, в котором вы хотите создать статический маршрут. В открывшемся окне:

      1. В правом верхнем углу экрана нажмите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
      1. В блоке **{{ ui-key.yacloud.baremetal.vrfs.VrfForm.title_section-vrf-static-routes_4KS9m }}** нажмите кнопку **{{ ui-key.yacloud.baremetal.vrfs.AddStaticRoute.label_add-static-route_wY5KQ }}**.
      1. В поле **{{ ui-key.yacloud.baremetal.vrfs.VrfStaticRoutesField.column_destination_t24Ah }}** задайте [CIDR](https://ru.wikipedia.org/wiki/Бесклассовая_адресация) подсети назначения.

          Префикс назначения может быть равен `0.0.0.0/0` либо должен представлять собой корректный диапазон приватных IPv4-адресов, входящих в один из диапазонов: `10.0.0.0/8`, `172.16.0.0/12` или `192.168.0.0/16`.

          При этом префикс назначения не может совпадать или пересекаться с диапазоном IP-адресов приватной подсети или другого статического маршрута, входящих в данный VRF.
      1. В поле **{{ ui-key.yacloud.baremetal.vrfs.VrfStaticRoutesField.column_next-hop_gM3vY }}** задайте адрес, на который будет направляться трафик, предназначенный для адресов, входящих в префикс назначения.

          В этом поле вы можете указать только IPv4-адрес, входящий в диапазон любой приватной подсети в данном VRF.
      1. (Опционально) Включите опцию **{{ ui-key.yacloud.baremetal.vrfs.VrfStaticRoutesField.column_is-console-enabled_hiCs9 }}**, чтобы анонсировать статический маршрут в [облачную подсеть](../../vpc/concepts/network.md#subnet) {{ vpc-full-name }}.

          {% include [static-routes-to-vpc-ri-notice](../../_includes/baremetal/static-routes-to-vpc-ri-notice.md) %}

  1. При необходимости нажмите **{{ ui-key.yacloud.baremetal.vrfs.AddStaticRoute.label_add-static-route_wY5KQ }}**, чтобы добавить в VRF дополнительные статические маршруты.

      Количество статических маршрутов в облаке ограничено [квотами](../concepts/limits.md#baremetal-quotas).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../concepts/private-network.md#static-routes)