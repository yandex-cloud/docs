---
title: Как остановить, запустить или перезапустить сервер в {{ baremetal-full-name }}
description: 'Следуя данной инструкции, вы сможете управлять арендованным сервером {{ baremetal-full-name }}: остановить, запустить или перезапустить его.'
---

# Остановить, запустить или перезапустить сервер

## Остановить {#stop}

Чтобы остановить сервер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.stop }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.stop }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды для остановки сервера:

      ```bash
      yc baremetal server power-off --help
      ```

   1. Выполните команду:

      ```bash
      yc baremetal server power-off <имя_или_идентификатор_сервера>
      ```

{% endlist %}

## Запустить {#start}

Чтобы запустить остановленный сервер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит остановленный сервер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.start }}**.

- CLI {#cli}

   1. Посмотрите описание команды для запуска сервера:

      ```bash
      yc baremetal server power-on --help
      ```

   1. Выполните команду:

      ```bash
      yc baremetal server power-on <имя_или_идентификатор_сервера>
      ```

{% endlist %}

## Перезапустить {#restart}

Чтобы перезапустить сервер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.action_reboot-server }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.baremetal.action_reboot-server }}**. Сервер перейдет в статус `Restarting`.

- CLI {#cli}

   1. Посмотрите описание команды для перезапуска сервера:

      ```bash
      yc baremetal server reboot --help
      ```

   1. Выполните команду:

      ```bash
      yc baremetal server reboot <имя_или_идентификатор_сервера>
      ```

{% endlist %}