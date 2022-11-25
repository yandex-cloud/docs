# Запустить группу виртуальных машин

При запуске группы будут запущены все остановленные ВМ в группе. Вы можете запустить отдельную ВМ, например для диагностики, но для включения [автоматического восстановления](../../concepts/instance-groups/autohealing.md) и [масштабирования](../../concepts/instance-groups/scale.md), необходимо запустить группу целиком.

{% note warning %}

Если группа остановлена {{ yandex-cloud }} из-за блокировки за неуплату, снова запустить группу можно только после снятия блокировки.

{% endnote %}

{% list tabs %}

- Консоль управления

  1. Откройте страницу каталога в [консоли управления]({{ link-console-main }}).
  1. Выберите сервис **{{ compute-name }}**.
  1. На панели слева выберите ![image](../../../_assets/compute/vm-group-pic.svg) **Группы виртуальных машин**.
  1. Выберите группу ВМ, нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и выберите пункт **Запустить группу**.
  1. В открывшемся окне нажмите кнопку **Запустить**.

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для запуска группы ВМ:

     ```bash
     {{ yc-compute-ig }} start --help
     ```

  1. Получите список групп ВМ в каталоге по умолчанию:

     {% include [instance-group-list.md](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной группы, например `first-instance-group`.
  1. Запустите группу ВМ в каталоге по умолчанию:

     ```bash
     {{ yc-compute-ig }} start first-instance-group
     ```

     {{ ig-name }} начнет запускать ВМ в группе. Когда все ВМ будут запущены, группа перейдет в статус `ACTIVE`.

- API

  Запустить группу можно с помощью метода API [start](../../api-ref/InstanceGroup/start.md).

  Список доступных групп запрашивайте методом [listInstances](../../api-ref/InstanceGroup/listInstances.md).

{% endlist %}