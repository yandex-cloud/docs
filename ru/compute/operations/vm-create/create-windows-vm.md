# Создать виртуальную машину из публичного образа Windows

В этом разделе приведена инструкция для создания виртуальной машины с операционной системой Windows. Для создания виртуальной машины на базе Linux воспользуйтесь инструкцией [[!TITLE]](create-linux-vm.md).

---

**[!TAB Консоль управления]**

Чтобы создать виртуальную машину:

[!INCLUDE [create-instance-via-concole-windows](../../_includes_service/create-instance-via-concole-windows.md)]

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

Чтобы создать виртуальную машину:

[!INCLUDE [create-instance-via-cli-windows](../../_includes_service/create-instance-via-cli-windows.md)]

---

[!INCLUDE [initialization-windows-vm](../../../_includes/initialization-windows-vm.md)]

При создании виртуальной машине назначаются IP-адрес и FQDN. Эти данные можно использовать для доступа к виртуальной машине по RDP.

Публичный IP-адрес можно сделать статическим. Подробнее читайте в разделе [[!TITLE]](../vm-control/vm-set-static-ip.md).

#### См. также
- [[!TITLE]](../vm-control/vm-connect-rdp.md)
