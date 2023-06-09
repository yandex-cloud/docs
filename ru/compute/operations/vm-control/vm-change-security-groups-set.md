# Изменить группы безопасности сетевого интерфейса виртуальной машины

Cетевому интерфейсу ВМ можно назначить одновременно несколько [групп безопасности](../../../vpc/operations/security-group-create.md).

{% note info %}

{% include [security-groups-note](../../../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

Как изменить имя, описание и метки ВМ читайте в разделе [{#T}](vm-update.md).

{% list tabs %}

- Консоль управления

  Чтобы изменить перечень применяемых к виртуальной машине групп безопасности:
  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Нажмите на имя нужной ВМ.
  1. В правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_action-stop }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**.
  1. Подождите пока ВМ перейдет в статус `Stopped`.
  1. Измените группы безопасности сетевого интерфейса ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.label_network-interface }}**:
     * В правом верхнем углу блока нажмите ![image](../../../_assets/options.svg) и выберите **{{ ui-key.yacloud.compute.instance.overview.button_edit-network-interface }}**.
     * В открывшемся окне в поле **{{ ui-key.yacloud.compute.instance.edit-network-interface.field_security-groups-ids }}** добавьте или удалите применяемые к сетевому интерфейсу ВМ группы безопасности.
     * Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_action-start }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

{% endlist %}