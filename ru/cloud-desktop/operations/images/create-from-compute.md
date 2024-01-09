---
title: "Как cоздать образ на основе виртуальной машины {{ compute-full-name }} в {{ cloud-desktop-full-name }}"
description: "Следуя данной инструкции, вы сможете cоздать образ на основе виртуальной машины."
---

# Создать образ на основе виртуальной машины {{ compute-name }}

Чтобы создать [пользовательский образ](../../concepts/images.md#custom-images) {{ cloud-desktop-name }} из [виртуальной машины](../../../compute/concepts/vm.md) {{ compute-name }}:
1. Если у вас еще нет ВМ, [создайте](../../../compute/operations/vm-create/create-linux-vm.md) ее.
1. Обратитесь в [техническую поддержку]({{ link-console-support }}) для подключения ВМ к {{ cloud-desktop-name }}.
1. [Создайте](../../../compute/operations/image-create/create-from-disk.md) образ из диска ВМ.
1. Добавьте образ в {{ cloud-desktop-name }}:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан образ.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
      1. На панели слева выберите ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.vdi.label_desktop-images }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.vdi.button_add-image }}**.
      1. В поле **{{ ui-key.yacloud.vdi.label_image-source }}** выберите `{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}`.
      1. В поле **{{ ui-key.yacloud.vdi.label_image }}** выберите образ, созданный ранее.
      1. Введите имя образа.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

    {% endlist %}
