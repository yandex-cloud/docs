---
title: Перенести публичный IP-адрес от одной ВМ на другую
description: Чтобы перенести публичный IP-адрес от одной ВМ на другую, сделайте IP-адрес статическим, отвяжите его от исходной ВМ и привяжите к новой.
---

# Перенести публичный IP-адрес от одной ВМ на другую

Чтобы перенести публичный IP-адрес от одной ВМ на другую, сделайте IP-адрес статическим, отвяжите его от исходной ВМ и привяжите к новой.


## Сделайте публичный IP-адрес исходной ВМ статическим

{% include [set-static-ip](../../../_includes/vpc/set-static-ip.md) %}


## Отвяжите публичный IP-адрес от исходной ВМ

{% include [vm-detach-public-ip](../../../_includes/compute/vm-detach-public-ip.md) %}


## Создайте новую ВМ без публичного IP-адреса

{% list tabs group=instructions %}

- Консоль управления {#console}

  При [создании ВМ](../vm-create/create-linux-vm.md) в блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** в поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_none }}`.

- CLI {#cli}

  При [создании ВМ](../vm-create/create-linux-vm.md) в блоке `--network-interface` исключите параметр `nat-ip-version=ipv4`.

- {{ TF }} {#tf}

  При [создании ВМ](../vm-create/create-linux-vm.md) в блоке `network_interface` укажите `nat = false`.

- API {#api}

  При [создании ВМ](../vm-create/create-linux-vm.md) в теле запроса исключите блок `primaryV4AddressSpec`.

{% endlist %}


## Привяжите IP-адрес к новой ВМ

{% note info %}

Если новая ВМ находится в другом каталоге, [переместите](../../../vpc/operations/address-move.md) публичный IP-адрес в этот же каталог.

{% endnote %}

{% include [vm-attach-public-ip](../../../_includes/compute/vm-attach-public-ip.md) %}