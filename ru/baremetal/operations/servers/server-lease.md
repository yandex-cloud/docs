---
title: Как арендовать сервер в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете арендовать сервер в {{ baremetal-full-name }}.
---

# Арендовать сервер

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите арендовать сервер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}**.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет арендован сервер.
  1. Выберите [пул](../../concepts/servers.md#server-pools), из которого будет арендован сервер.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-config }}**:
  
     1. Выберите [конфигурацию сервера](../../concepts/server-configurations.md).
     1. (Опционально) Настройте разметку диска:

        1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**.
        1. Укажите параметры разделов. Чтобы создать новый раздел, нажмите кнопку ![icon](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.baremetal.actions_add-partition }}**.

           {% note info %}

           Чтобы самостоятельно собрать RAID-массивы и настроить разделы дисков, нажмите кнопку **{{ ui-key.yacloud.baremetal.action_destroy-raid }}**.

           {% endnote %}

        1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите один из доступных образов ОС. Вы можете [загрузить собственный образ](../image-upload.md) и использовать его.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-lease-conditions }}**:

     1. Укажите количество серверов, которое хотите арендовать.
     1. Выберите период, на который арендуете серверы.
  
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-network-settings }}**:

     1. Укажите идентификатор существующей [приватной подсети](../../concepts/network.md#private-subnet) или нажмите кнопку **{{ ui-key.yacloud.common.create }}** для создания новой.

        Если у вас нет подсетей, нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.baremetal.action-create-subnetwork }}** и создайте ее:

        * В открывшемся окне укажите имя и описание подсети.
        * Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-subnetwork }}**.

     1. В поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите способ назначения публичного адреса:

        * `{{ ui-key.yacloud.baremetal.label_public-ip-auto }}` — чтобы назначить случайный IP-адрес.
        * `{{ ui-key.yacloud.baremetal.label_public-ip-no }}` — чтобы не назначать публичный IP-адрес.

  1. {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-info }}**:

     1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** введите имя сервера.
     1. (Опционально) Добавьте **{{ ui-key.yacloud.baremetal.field_description }}** к серверу.
     1. (Опционально) Задайте **{{ ui-key.yacloud.component.label-set.label_labels }}**.
  
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-server }}**.

{% endlist %}
