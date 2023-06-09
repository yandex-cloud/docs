Рекомендуемый способ подключения к [виртуальной машине](../compute/concepts/vm.md) по [SSH](../glossary/ssh-keygen.md) основан на использовании пары ключей: открытый ключ размещается на ВМ, закрытый ключ хранится у пользователя. Подключение с помощью пары ключей более безопасно, чем подключение по логину и паролю.

{% include [vm-connect-ssh-linux-note](vm-connect-ssh-linux-note.md) %}

## Создание пары ключей SSH {#creating-ssh-keys}

{% include [vm-ssh-prepare-key](vm-ssh-prepare-key.md) %}

## Подключение к виртуальной машине {#vm-connect}

Вы можете подключиться к ВМ по протоколу SSH, когда она будет запущена (в статусе `RUNNING`). Для этого можно использовать утилиту `ssh` в Linux и macOS и программу [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) для Windows.

Для подключения необходимо указать адрес ВМ. Это может быть [IP-адрес](../vpc/concepts/address.md) или ее [FQDN](../vpc/concepts/address.md#fqdn). Доступ по FQDN возможен из другой ВМ {{ yandex-cloud }}, если она подключена к той же [виртуальной сети](../vpc/concepts/network.md#network). IP-адрес для подключения можно узнать в [консоли управления]({{ link-console-main }}) на странице ВМ в блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}**.