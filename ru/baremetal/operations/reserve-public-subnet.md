---
title: Как заказать выделенную публичную подсеть в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете заказать выделенную публичную подсеть в {{ baremetal-full-name }}.
---

# Заказать выделенную публичную подсеть

[Выделенная публичная подсеть](../concepts/network.md#public-subnet) — это публичная подсеть, состоящая из определенного диапазона публичных IP-адресов, которые будут доступны вашим серверам в выбранных [пулах](../concepts/servers.md#server-pools).

Вы можете арендовать новую выделенную публичную подсеть или преобразовать имеющуюся [эфемерную публичную подсеть](../concepts/network.md#ephemeral-public-subnet) в выделенную.

### Арендовать новую выделенную публичную подсеть {#reserve-new-subnet}

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

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды для аренды новой [выделенной публичной подсети](../concepts/network.md#public-subnet):

     ```bash
     yc baremetal public-subnet create --help
     ```
  
  1. Арендуйте подсеть:
     
     ```bash
     yc baremetal public-subnet create \
       --hardware-pool-id <пул> \
       --prefix-length 29 \
       --name <имя_публичной_подсети> \
       --description "<описание_публичной_подсети>" \
       --labels <ключ>=<значение>
     ```

     Где:
     * `--hardware-pool-id` — [пулы](../concepts/servers.md#server-pools), в которых будет доступна подсеть.

       {% include [link-public-subnet](../../_includes/baremetal/instruction-steps/link-public-subnet.md) %}

     * `--prefix-length` — размер заказываемой подсети.

       Можно заказать только подсети размером `/29` (шесть доступных IP-адресов) и `/28` (четырнадцать доступных IP-адресов).
     
     * `--name` — имя подсети. Требования к имени:
       
       {% include [name-format](../../_includes/name-format.md) %}
       
     * `--description` — описание подсети. Необязательный параметр.
     * `--labels` — [метки](../../resource-manager/concepts/labels.md) подсети. Необязательный параметр.

{% endlist %}

### Преобразовать эфемерную публичную подсеть в выделенную {#transform-ephemeral-to-dedicated}

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

- CLI {#cli}

  1. Посмотрите описание команды для преобразования эфемерной публичной подсети:

     ```bash
     yc baremetal public-subnet update --help
     ```
  
  1. Преобразуйте подсеть:
     
     ```bash
     yc baremetal public-subnet update \
       --id <идентификатор_публичной_эфимерной_подсети> \
       --type dedicated \
       --hardware-pool-id <пул> \
       --name <имя_публичной_подсети> \
       --description "<описание_публичной_подсети>" \
       --labels <ключ>=<значение>
     ```

     Где:
     * `--id` — идентификатор эфимерной публичной подсети.
     * `--type` — тип, в который преобразуется подсеть.
     * `--hardware-pool-id` — [пулы](../concepts/servers.md#server-pools), в которых будет доступна подсеть.

       {% include [link-public-subnet](../../_includes/baremetal/instruction-steps/link-public-subnet.md) %}
     
     * `--name` — имя подсети.
     * `--description` — описание подсети. Необязательный параметр.
     * `--labels` — [метки](../../resource-manager/concepts/labels.md) подсети. Необязательный параметр.

{% endlist %}

## Примеры {#examples}

### Аренда новой выделенную публичной подсети {#reserve-new-subnet-example}

Арендуйте новую выделенную публичную подсеть размером `/29`:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal public-subnet create \
    --hardware-pool-id ru-central1-m3 \
    --prefix-length 29 \
    --name demo-public-subnet \
    --description "My first public subnet" \
    --labels env=test
  ```

  Результат

  ```text
  id: ly5jmqxxrcsu********
  cloud_id: b1gia87mbaom********
  folder_id: b1g0ijbfaqsn********
  name: demo-public-subnet
  description: My first public subnet
  zone_id: ru-central1-m
  hardware_pool_ids:
    - ru-central1-m3
  type: DEDICATED
  prefix_length: "29"
  cidr: 94.139.248.184/29
  gateway_ip: 94.139.248.185
  created_at: "2025-06-26T14:11:49.458568Z"
  labels:
    env: test
  ```

{% endlist %}

### Преобразование эфемерной публичной подсети в выделенную {#transform-ephemeral-to-dedicated-example}

Измените типа публичной подсети с `ephemeral` на `dedicated`:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc baremetal public-subnet update \
    --id ly5vr6tugxk7******** \
    --type dedicated \
    --description "Transformed dedicated public subnet"
  ```

  Результат

  ```text
  id: ly5vr6tugxk7********
  cloud_id: b1gia87mbaom********
  folder_id: b1g0ijbfaqsn********
  name: transformed-public-subnet
  description: Transformed dedicated public subnet
  zone_id: ru-central1-m
  hardware_pool_ids:
    - ru-central1-m3
  type: DEDICATED
  prefix_length: "29"
  cidr: 94.139.248.184/29
  gateway_ip: 94.139.248.185
  created_at: "2025-06-26T14:11:49.458568Z"
  ```

{% endlist %}