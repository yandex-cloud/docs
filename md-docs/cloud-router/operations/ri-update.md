[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Router](../index.md) > [Пошаговые инструкции](index.md) > Изменить параметры виртуального маршрутизатора

# Изменить параметры виртуального маршрутизатора

{% note info %}

Для выполнения операции необходима роль [cloud-router.editor](../security/index.md#cloudrouter-editor).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [виртуальный маршрутизатор](../concepts/routing-instance.md).
  1. [Перейдите](https://console.yandex.cloud/link/cloud-router) в сервис **Cloud Router**.
  1. В строке с виртуальным маршрутизатором нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. Введите новое имя и описание виртуального маршрутизатора.
  1. Добавьте или удалите [метки](../../resource-manager/concepts/labels.md).   
  1. Включите или выключите опцию **Защита от удаления**, которая позволяет защитить виртуальный маршрутизатор от непреднамеренного удаления.
  1. В поле **Приватные соединения** добавьте или удалите [приватные соединения](../../interconnect/concepts/priv-con.md).
  1. В поле **Сети** добавьте или удалите [сети](../../vpc/concepts/network.md) и IP-префиксы.

- CLI {#cli}

  В настоящее время в CLI доступно изменение следующих параметров виртуального маршрутизатора:
  * название приватного соединения — `new-name`;
  * описание приватного соединения — `description`.
  
  {% note info %}
  
  Для изменения анонсов IP-префиксов и добавления (удаления) приватных соединений в виртуальном маршрутизаторе рекомендуется использовать [отдельные команды](cr-cic-ops.md#ri) и не использовать опции `--vpc-net` и `--cic-prc` команды update.
  
  {% endnote %}
  
  Например, для изменения значения параметра `description` у виртуального маршрутизатора необходимо выполнить следующие шаги:

  1. Посмотрите описание команды CLI для изменения [виртуального маршрутизатора](../concepts/routing-instance.md):

      ```bash
      yc cloudrouter routing-instance update  --help
      ```

  1. Измените значение параметра `description` для виртуального маршрутизатора:

      ```bash
      yc cloudrouter routing-instance update c3l87**********1dpin \
        --description "My new RI description" \
        --async
      ```

      Ожидаемый результат:

      ```text
      id: al4r9**********4613n
      description: routing instance update
      created_at: "2025-04-08T21:21:33.106772882Z"
      created_by: bfbud**********v7dfn
      modified_at: "2025-04-08T21:21:33.106772882Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.cloudrouter.v1.UpdateRoutingInstanceMetadata
        routing_instance_id: c3l87**********1dpin
      ```

  1. Проверьте значение изменяемого параметра после завершения выполнения операции:

     ```bash
     yc cloudrouter routing-instance get c3l87**********1dpin
     ```

{% endlist %}