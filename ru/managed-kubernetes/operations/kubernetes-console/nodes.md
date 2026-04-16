---
title: Управление размещением подов на узлах в {{ managed-k8s-full-name }}
description: Из статьи вы узнаете, как в {{ yandex-cloud }} управлять размещением подов на узлах в {{ k8s }} с помощью консоли управления без использования kubectl.
---

# Управление размещением подов на узлах

Узлы — виртуальные машины {{ compute-full-name }}, на которых запускаются поды с пользовательскими контейнерами. Консоль управления позволяет управлять размещением подов на узле в {{ managed-k8s-name }} без использования kubectl.

## Запретить размещение подов на узле {#cordon}

В консоли управления можно запрещать размещение новых подов на узле так же, как с помощью команды `kubectl cordon <имя_узла>`. Запущенные на узле поды продолжат работать.

Чтобы запретить размещение подов на узле:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Nodes](../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.k8s.nodes.label_nodes }}**.
  1. Нажмите на имя нужного узла.
  1. В правом верхнем углу нажмите кнопку ![Cordon](../../../_assets/console-icons/lock.svg) **{{ ui-key.yacloud.k8s.nodes.button_action-cordon }}**.
  1. Подтвердите действие.

{% endlist %}

## Разрешить размещение подов на узле {#uncordon}

В консоли управления можно разрешать размещение подов на узле так же, как с помощью команды `kubectl uncordon <имя_узла>`.

Чтобы разрешить размещение подов на узле:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Nodes](../../../_assets/console-icons/graph-node.svg) **{{ ui-key.yacloud.k8s.cluster.switch_nodes-manager }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.k8s.nodes.label_nodes }}**.
  1. Нажмите на имя нужного узла.
  1. В правом верхнем углу нажмите кнопку ![Uncordon](../../../_assets/console-icons/lock-open.svg) **{{ ui-key.yacloud.k8s.nodes.button_action-uncordon }}**.
  1. Подтвердите действие.

{% endlist %}

### См. также {#see-also}

* [{#T}](../../concepts/index.md)
