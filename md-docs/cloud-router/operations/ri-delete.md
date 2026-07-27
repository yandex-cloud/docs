[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Router](../index.md) > [Пошаговые инструкции](index.md) > Удалить виртуальный маршрутизатор

# Удалить виртуальный маршрутизатор

{% note info %}

Для выполнения операции необходима роль [cloud-router.editor](../security/index.md#cloudrouter-editor).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [виртуальный маршрутизатор](../concepts/routing-instance.md).
  1. [Перейдите](https://console.yandex.cloud/link/cloud-router) в сервис **Cloud Router**.
  1. В строке с виртуальным маршрутизатором нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  1. Убедитесь, что в виртуальном маршрутизаторе, который должен быть удален, нет других дочерних объектов, например, приватных соединений:
  
      ```bash
      yc cloudrouter routing-instance get c3l87**********1dpin
      ```

  1. Посмотрите описание команды CLI для удаления [виртуального маршрутизатора](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance delete --help
      ```

  1. Удалите виртуальный маршрутизатор:

      ```bash
      yc cloudrouter routing-instance delete c3l87**********1dpin --async
      ```

{% endlist %}