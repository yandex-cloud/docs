---
title: "Как остановить, запустить или перезапустить виртуальную машину"
description: "Команда Остановить выключает виртуальную машину. После выключения виртуальная машина переходит в статус STOPPED. Вы сможете включить машину в любой момент, чтобы продолжить работу. Команда Запустить включает остановленную виртуальную машину. После включения виртуальная машина переходит в статус RUNNING, и начинается загрузка операционной системы."
---

# Остановить, запустить или перезапустить виртуальную машину

## Остановить {#stop}

Команда **{{ ui-key.yacloud.compute.instances.button_action-stop }}** выключает ВМ. После выключения ВМ переходит в статус `Stopped`. Пока ВМ остановлена, плата за нее не взимается.

Вы сможете включить ВМ в любой момент, чтобы продолжить работу. Все данные и внесенные вами изменения сохраняются.

Некоторые параметры ВМ (например, загрузочный диск) можно изменить только когда ВМ остановлена.

Чтобы остановить ВМ:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Чтобы остановить одну ВМ, выберите ВМ → нажмите значок ![image](../../../_assets/options.svg) → **{{ ui-key.yacloud.compute.instances.button_action-stop }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_stop }}**.

  Чтобы выполнить это действие с несколькими виртуальными машинами, выделите нужные ВМ в списке → нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_gr-action-stop }}** в нижней части экрана → в открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_gr-stop }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для остановки ВМ:

     ```bash
     yc compute instance stop --help
     ```

  1. Получите список всех ВМ в каталоге по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ, например `first-instance`.
  1. Остановите ВМ:

     ```bash
     yc compute instance stop first-instance
     ```

- API

  Воспользуйтесь методом REST API [stop](../../api-ref/Instance/stop.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Stop](../../api-ref/grpc/instance_service.md#Stop).

{% endlist %}

## Запустить {#start}

Команда **{{ ui-key.yacloud.compute.instances.button_action-start }}** включает остановленную ВМ. После включения ВМ переходит в статус `Running`, и начинается загрузка операционной системы. С этого момента начинает взиматься плата за использование ВМ.

Чтобы запустить ВМ:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Чтобы запустить одну ВМ, выберите ВМ → нажмите значок ![image](../../../_assets/options.svg) → **{{ ui-key.yacloud.compute.instances.button_action-start }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

  Чтобы выполнить это действие с несколькими виртуальными машинами, выделите нужные ВМ в списке → нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_action-start }}** в нижней части экрана → в открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_start }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для запуска ВМ:

     ```bash
     yc compute instance start --help
     ```

  1. Получите список всех ВМ в каталоге по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ, например `first-instance`.
  1. Запустите ВМ:

     ```bash
     yc compute instance start first-instance
     ```

- API

  Воспользуйтесь методом REST API [start](../../api-ref/Instance/start.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Start](../../api-ref/grpc/instance_service.md#Start).

{% endlist %}

## Перезапустить {#restart}

Команда **{{ ui-key.yacloud.compute.instances.button_action-restart }}** выполняет перезагрузку ВМ.

Чтобы перезапустить ВМ:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Чтобы перезапустить одну ВМ, выберите ВМ → нажмите значок ![image](../../../_assets/options.svg) → **{{ ui-key.yacloud.compute.instances.button_action-restart }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_restart }}**.

  Чтобы выполнить это действие с несколькими виртуальными машинами, выделите нужные ВМ в списке → нажмите кнопку **{{ ui-key.yacloud.compute.instances.button_action-restart }}** в нижней части экрана → в открывшемся окне нажмите кнопку **{{ ui-key.yacloud.compute.instances.popup-confirm_button_restart }}**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для перезапуска ВМ:

     ```bash
     yc compute instance restart --help
     ```

  1. Получите список всех ВМ в каталоге по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной ВМ, например `first-instance`.
  1. Перезапустите ВМ:

     ```bash
     yc compute instance restart first-instance
     ```

- API

  Воспользуйтесь методом REST API [restart](../../api-ref/Instance/restart.md) для ресурса [Instance](../../api-ref/Instance/) или вызовом gRPC API [InstanceService/Restart](../../api-ref/grpc/instance_service.md#Restart).

{% endlist %}