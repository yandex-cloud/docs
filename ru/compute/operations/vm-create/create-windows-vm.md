# Создать виртуальную машину из публичного образа Windows

В этом разделе приведена инструкция для создания виртуальной машины с операционной системой Windows. Для создания виртуальной машины на базе Linux воспользуйтесь инструкцией [#T](create-linux-vm.md).

Чтобы создать виртуальную машину:

{% list tabs %}

- Консоль управления
  
  {% include [create-instance-via-concole-windows](../../_includes_service/create-instance-via-concole-windows.md) %}
  
- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  {% include [create-instance-via-cli-windows](../../_includes_service/create-instance-via-cli-windows.md) %}
  
- API
  
  Воспользуйтесь методом [Create](../../api-ref/Instance/create.md) для ресурса `Instance`.
  
{% endlist %}

{% include [initialization-windows-vm](../../../_includes/initialization-windows-vm.md) %}

При создании виртуальной машине назначаются IP-адрес и FQDN. Эти данные можно использовать для доступа к виртуальной машине по RDP.

Публичный IP-адрес можно сделать статическим. Подробнее читайте в разделе [#T](../vm-control/vm-set-static-ip.md).

#### См. также

- [#T](../vm-connect/rdp.md)
