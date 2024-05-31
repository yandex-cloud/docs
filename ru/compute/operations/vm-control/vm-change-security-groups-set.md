# Изменить группы безопасности сетевого интерфейса виртуальной машины

[Сетевому интерфейсу](../../concepts/network.md) ВМ можно назначить одновременно несколько [групп безопасности](../../../vpc/operations/security-group-create.md).

Как изменить имя, описание и метки ВМ читайте в разделе [{#T}](vm-update.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы изменить перечень применяемых к виртуальной машине групп безопасности:
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите на имя нужной ВМ.
  1. Измените группы безопасности сетевого интерфейса ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}**:
     * В правом верхнем углу блока нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
     * В открывшемся окне в поле **{{ ui-key.yacloud.compute.instance.edit-network-interface.field_security-groups-ids }}** добавьте или удалите применяемые к сетевому интерфейсу ВМ группы безопасности.
     * Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}