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

{% endlist %}

## Запустить {#start}

Команда **{{ ui-key.yacloud.common.start }}** запускает остановленный сервер.

Чтобы запустить сервер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит остановленный сервер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.start }}**.

{% endlist %}

## Перезапустить {#restart}

Команда **{{ ui-key.yacloud.baremetal.action_reboot-server }}** выполняет перезагрузку сервера.

Чтобы перезапустить сервер:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. В строке с нужным сервером нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.baremetal.action_reboot-server }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.baremetal.action_reboot-server }}**. Сервер перейдет в статус `Restarting`.

{% endlist %}
