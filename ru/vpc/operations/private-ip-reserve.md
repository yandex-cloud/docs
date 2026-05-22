---
title: Зарезервировать внутренний IP-адрес
description: Следуя данной инструкции, вы сможете зарезервировать внутренний IP-адрес.
---

# Зарезервировать внутренний IP-адрес

Вы можете зарезервировать [внутренний IP-адрес](../concepts/address.md#internal-addresses), чтобы использовать его для передачи информации между ресурсами внутри облака.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога, в котором нужно зарезервировать адрес.
   1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. Выберите подсеть, в которой нужно зарезервировать адрес.
   1. Перейдите на вкладку ![addresses](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.subnetworks.switch_ip-addresses }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.vpc.Subnetwork.SubnetUsedAddressesList.button_create_sPV4s }}**.  
   1. В открывшемся окне:
       * Введите имя и описание внутреннего адреса.
       * В поле **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** введите адрес, который необходимо зарезервировать.
       * (Опционально) Включите опцию **{{ ui-key.yacloud.vpc.addresses.popup-create_field_deletion-protection }}**.
       * (Опционально) Укажите [метки](../../resource-manager/concepts/labels.md).
   1. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

{% endlist %}