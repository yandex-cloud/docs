{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана группа рабочих столов.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.vdi.button_empty-create-desktop-group }}**.
  1. Введите имя и описание группы рабочих столов.
  1. Выберите [образ](../../cloud-desktop/concepts/images.md) операционной системы.
  1. В блоке **{{ ui-key.yacloud.vdi.section_disks }}**:
      * Выберите [типы](../../compute/concepts/disk.md#disks-types) загрузочного и рабочего [дисков](../../cloud-desktop/concepts/disks.md).
      * Укажите размеры загрузочного и рабочего дисков.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * Укажите количество ядер vCPU.
      * Выберите [гарантированную долю](../../compute/concepts/performance-levels.md) vCPU.
      * Укажите объем RAM.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}** выберите [облачную сеть](../../vpc/concepts/network.md#network) и [подсети](../../vpc/concepts/network.md#subnet), в которых будут размещаться рабочие столы.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
