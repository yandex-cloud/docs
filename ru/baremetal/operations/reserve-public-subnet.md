---
title: Как заказать публичную подсеть в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете заказать публичную подсеть в {{ baremetal-full-name }}.
---

# Заказать публичную подсеть

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите зарезервировать [публичную подсеть](../concepts/network.md#public-subnet).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets }}**.
  1. Справа вверху нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-public-subnet-full }}**.
  1. В поле **{{ ui-key.yacloud.baremetal.field_server-zone }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет доступна подсеть.
  1. В поле **{{ ui-key.yacloud.baremetal.field_server-pool }}** выберите [пулы](../concepts/servers.md#server-pools), в которых будет доступна подсеть.

      Вы можете привязать публичную подсеть одновременно к нескольким пулам. 
  1. Выберите размер заказываемой подсети.

      В консоли управления можно заказать только подсети размером `/29` (шесть доступных IP-адресов) и `/28` (четырнадцать доступных IP-адресов). Если вам необходима более широкая публичная подсеть, запросите ее через [обращение]({{ link-console-support }}/tickets/create) в службу технической поддержки.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_common-info }}**:

      1. В поле **{{ ui-key.yacloud.baremetal.field_subnetwork-name }}** введите имя публичной подсети.
      1. (Опционально) В поле **{{ ui-key.yacloud.baremetal.field_description }}** добавьте описание подсети.
      1. (Опционально) В поле **{{ ui-key.yacloud.component.label-set.label_labels }}** задайте [метки](../../resource-manager/concepts/labels.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-public-subnet }}**.

{% endlist %}
