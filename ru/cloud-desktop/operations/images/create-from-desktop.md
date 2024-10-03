---
title: Как создать образ на основе рабочего стола
description: Следуя данной инструкции, вы сможете создать образ на основе рабочего стола.
---

# Создать образ на основе рабочего стола

{% note info %}

[Рабочий стол](../../concepts/desktops-and-groups.md), из которого вы хотите создать [пользовательский образ](../../concepts/images.md#custom-images), должен быть [остановлен](../desktops/start-stop.md#stop).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан образ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.vdi.label_desktop-images }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vdi.button_add-image }}**.
  1. В поле **{{ ui-key.yacloud.vdi.label_image-source }}** выберите `{{ ui-key.yacloud.iam.folder.dashboard.label_vdi }}`.
  1. В поле **{{ ui-key.yacloud.vdi.label_desktop }}** выберите рабочий стол, из которого вы хотите создать образ.

      Для образа будет использован [загрузочный диск](../../concepts/disks.md#boot-disk) рабочего стола.
  1. Введите имя образа.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}
