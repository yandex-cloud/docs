---
title: Как удалить виртуальную машину
description: Следуя данной инструкции, вы сможете удалить виртуальную машину.
alternate:
  - href: ru/compute/operations/vm-control/vm-delete.md
    type: text/markdown
    title: Markdown version
---

# Удалить виртуальную машину

{% note warning %}

Удаление ВМ — неотменяемая и необратимая операция, восстановить удаленную ВМ невозможно.

{% endnote %}

{% include [disk-auto-delete](../../_includes_service/disk-auto-delete.md) %}

Если к ВМ подключены ранее созданные диски, то при удалении ВМ диски будут отключены. Данные на дисках сохранятся и в дальнейшем эти диски можно будет подключить к другой ВМ.

{% include [delete-vm](../../../_includes/compute/delete-vm.md) %}
