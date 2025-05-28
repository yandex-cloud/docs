---
title: Как заказать выделенную публичную подсеть в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете заказать выделенную публичную подсеть в {{ baremetal-full-name }}.
---

# Заказать выделенную публичную подсеть

[Выделенная публичная подсеть](../concepts/network.md#public-subnet) — это публичная подсеть, состоящая из определенного диапазона публичных IP-адресов, которые будут доступны вашим серверам в выбранных [пулах](../concepts/servers.md#server-pools).

Вы можете арендовать новую выделенную публичную подсеть или преобразовать имеющуюся [эфемерную публичную подсеть](../concepts/network.md#ephemeral-public-subnet) в выделенную.

## Арендовать новую выделенную публичную подсеть {#reserve-new-subnet}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите зарезервировать [выделенную публичную подсеть](../concepts/network.md#public-subnet).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets }}**.
  1. Справа вверху нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-public-subnet-full }}**.
  1. В поле **{{ ui-key.yacloud.baremetal.field_server-zone }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет доступна подсеть.
  1. {% include [reserve-priv-subnet-step-1](../../_includes/baremetal/instruction-steps/reserve-priv-subnet-step-1.md) %}
  1. Выберите размер заказываемой подсети.
  
      В консоли управления можно заказать только подсети размером `/29` (шесть доступных IP-адресов) и `/28` (четырнадцать доступных IP-адресов). Если вам необходима более широкая публичная подсеть, запросите ее через [обращение]({{ link-console-support }}/tickets/create) в службу технической поддержки.
  1. {% include [reserve-priv-subnet-step-2](../../_includes/baremetal/instruction-steps/reserve-priv-subnet-step-2.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-public-subnet }}**.

{% endlist %}

## Преобразовать эфемерную публичную подсеть в выделенную {#transform-ephemeral-to-dedicated}

{% note info %}

Эфемерную публичную подсеть можно преобразовать только в выделенную публичную подсеть размера `/31`.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится эфемерная публичная подсеть, которую вы хотите преобразовать в выделенную.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.baremetal.label_public-subnets }}**.
  1. В открывшемся списке публичных подсетей в строке с нужной эфемерной подсетью нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.action_dedicate-ephemeral-subnet }}**.
  1. {% include [reserve-priv-subnet-step-1](../../_includes/baremetal/instruction-steps/reserve-priv-subnet-step-1.md) %}
  1. {% include [reserve-priv-subnet-step-2](../../_includes/baremetal/instruction-steps/reserve-priv-subnet-step-2.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-public-subnet }}**.

{% endlist %}