---
title: "Как арендовать сервер в {{ baremetal-full-name }}"
description: "Следуя данной инструкции, вы сможете арендовать сервер в {{ baremetal-full-name }}."
---

# Арендовать сервер

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите арендовать сервер.
  1. В списке сервисов выберите **{{ baremetal-name }}**.
  1. Нажмите кнопку **Заказать сервер**.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет арендован сервер.
  1. Выберите [пул](../../concepts/index.md#server-pools), из которого будет арендован сервер.
  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-config }}**:
  
     1. Выберите [конфигурацию сервера](../../concepts/server-configurations.md).
     1. Настройте разметку диска:

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

     1. Укажите идентификатор существующей [приватной подсети](../../concepts/index.md#private-subnet) или нажмите кнопку **{{ ui-key.yacloud.common.create }}** для создания новой.

        Если у вас нет подсетей, нажмите ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.baremetal.action-create-subnetwork }}** и создайте ее:

        * В открывшемся окне укажите имя и описание подсети.
        * Нажмите кнопку **Создать подсеть**.

     1. В поле **{{ ui-key.yacloud.baremetal.field_needed-public-ip }}** выберите способ назначения публичного адреса:

        * `{{ ui-key.yacloud.baremetal.label_public-ip-auto }}` — чтобы назначить случайный IP-адрес.
        * `{{ ui-key.yacloud.baremetal.label_public-ip-no }}` — чтобы не назначать публичный IP-адрес.
  
  1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

     1. В поле **{{ ui-key.yacloud.baremetal.field_server-user }}** введите имя пользователя.
     1. В поле **{{ ui-key.yacloud.baremetal.field_password }}** введите или сгенерируйте пароль пользователя.
     1. В поле **{{ ui-key.yacloud.baremetal.field_ssh-public-key }}** вставьте содержимое файла открытого ключа. Пару ключей для подключения по SSH необходимо [создать](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.

  1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-info }}**:

     1. В поле **{{ ui-key.yacloud.baremetal.field_name }}** введите имя сервера.
     1. (Опционально) Добавьте **{{ ui-key.yacloud.baremetal.field_description }}** к серверу.
     1. (Опционально) Задайте **{{ ui-key.yacloud.component.label-set.label_labels }}**.
  
  1. Нажмите кнопку **Заказать сервер**.

{% endlist %}
