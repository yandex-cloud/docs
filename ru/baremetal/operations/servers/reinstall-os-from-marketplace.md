---
title: Как переустановить ОС на сервере {{ baremetal-name }} из образа {{ marketplace-short-name }}
description: Следуя данной инструкции, вы сможете переустановить операционную систему сервера {{ baremetal-full-name }} из образа {{ marketplace-short-name }}.
---

# Переустановить операционную систему из образа {{ marketplace-short-name }}

{{ marketplace-short-name }} — это каталог предварительно настроенных образов операционных систем доступных для установки на серверы {{ baremetal-name }}.

{{ baremetal-full-name }} позволяет переустановить операционную систему сервера из публичного образа {{ marketplace-short-name }}. При переустановке вы можете выбрать любую доступную в {{ marketplace-short-name }} для серверов {{ baremetal-name }} операционную систему, а также перераспределить дисковое пространство, пересобрать RAID-массивы и перенастроить параметры доступа root-пользователя.

Чтобы переустановить операционную систему сервера {{ baremetal-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужный сервер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![ArrowsRotateLeft](../../../_assets/console-icons/arrows-rotate-left.svg) **{{ ui-key.yacloud.baremetal.action_reinstall-server-os-menu }}**.
  1. В открывшемся окне:

      1. В блоке **{{ ui-key.yacloud.baremetal.title_section-server-product }}** выберите один из доступных образов ОС.
      1. {% include [server-lease-step6](../../../_includes/baremetal/instruction-steps/server-lease-step6.md) %}

          Если не вносить изменений в разметку дисков, на сервере сохранятся заданные ранее настройки RAID-массивов и распределения дискового пространства.
      1. В блоке **{{ ui-key.yacloud.baremetal.title_server-access }}**:

          {% include [server-lease-access](../../../_includes/baremetal/server-lease-access.md) %}

      1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.action_reinstall-server-os }}** и дождитесь переустановки операционной системы сервера.

{% endlist %}