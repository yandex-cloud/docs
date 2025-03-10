---
title: Как переустановить ОС на сервере {{ baremetal-name }} из образа {{ marketplace-name }}
description: Следуя данной инструкции, вы сможете переустановить операционную систему сервера {{ baremetal-full-name }} из образа {{ marketplace-full-name }}.
---

# Переустановить операционную систему из образа {{ marketplace-full-name }}

{{ baremetal-full-name }} позволяет переустановить операционную систему сервера из публичного образа [{{ marketplace-full-name }}](/marketplace). При переустановке вы можете выбрать любую доступную в {{ marketplace-name }} для серверов {{ baremetal-name }} операционную систему, а также перераспределить дисковое пространство, пересобрать RAID-массивы и перенастроить параметры доступа root-пользователя.

Чтобы переустановить операционную систему сервера {{ baremetal-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужный сервер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![ArrowsRotateLeft](../../../_assets/console-icons/arrows-rotate-left.svg) **{{ ui-key.yacloud.baremetal.action_reinstall-server-os-menu }}**.
  1. В открывшемся окне:

      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите один из доступных образов ОС.
      1. (Опционально) Настройте разметку дисков:

          1. В разделе **{{ ui-key.yacloud.baremetal.title_section-disk }}** нажмите кнопку **{{ ui-key.yacloud.baremetal.action_disk-layout-settings }}**.
          1. Укажите параметры разделов. Чтобы создать новый раздел, нажмите кнопку ![icon](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.baremetal.actions_add-partition }}**.

             {% note info %}

             Чтобы самостоятельно собрать RAID-массивы и настроить разделы дисков, нажмите кнопку **{{ ui-key.yacloud.baremetal.action_destroy-raid }}**.

             {% endnote %}

          1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

          Если не вносить изменений в разметку дисков, на сервере сохранятся заданные ранее настройки RAID-массивов и распределения дискового пространства.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

          {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.action_reinstall-server-os }}** и дождитесь переустановки операционной системы сервера.

{% endlist %}