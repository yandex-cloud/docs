Подготовьте [SSH-ключ](../../../glossary/ssh-keygen.md) для [доступа к ВМ](../../../compute/operations/vm-connect/ssh.md).

{% list tabs group=operating_system %}

- Linux/macOS {#linux-macos}

  {% include [vm-ssh-prepare-key-linux-macos](../../../_includes/vm-ssh-prepare-key-linux-macos.md) %}

- Windows 10/11 {#windows}

  {% include [vm-ssh-prepare-key-win-10-11](../../../_includes/vm-ssh-prepare-key-win-10-11.md) %}

- Windows 7/8 {#windows7-8}

  {% include [vm-ssh-prepare-key-win-7-8](../../../_includes/vm-ssh-prepare-key-win-7-8.md) %}

{% endlist %}

{% note warning %}

Надежно сохраните закрытый ключ: без него подключиться к ВМ будет невозможно.

{% endnote %}