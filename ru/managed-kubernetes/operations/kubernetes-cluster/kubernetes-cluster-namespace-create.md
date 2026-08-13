---
title: Управление пространствами имен в {{ managed-k8s-full-name }}
description: Из статьи вы узнаете, как в {{ yandex-cloud }} управлять пространствами имен в {{ k8s }} с помощью консоли управления без использования kubectl.
---

# Управление пространствами имен

Пространства имен в {{ k8s }} позволяют разделять ресурсы кластера между несколькими командами или проектами. Консоль управления позволяет создавать и удалять пространства имен в {{ managed-k8s-name }} без использования kubectl.

## Создание пространства имен

В консоли управления можно создавать пространства имен так же, как с помощью команды `kubectl create namespace <имя_пространства_имен>`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер {{ managed-k8s-name }}.
  1. Нажмите на вкладку **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите **{{ ui-key.yacloud.k8s.cluster.switch_namespaces }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.namespaces.button_filter-create }}**.
  1. В открывшемся окне введите **{{ ui-key.yacloud.k8s.namespaces.popup-add_field_name }}** пространства имен.

     {% include [note-namespace-kube](../../../_includes/managed-kubernetes/note-namespace-kube.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

## Удаление пространства имен

Удаление пространства имен соответствует выполнению команды `kubectl delete namespace <имя_пространства_имен>`. При удалении пространства имен все созданные в нем ресурсы будут удалены.

Чтобы удалить пространство имен:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите]({{ link-console-main }}/link/managed-kubernetes) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Выберите кластер {{ managed-k8s-name }}.
  1. Нажмите на вкладку **{{ ui-key.yacloud.shared.layout.PageTabs.button_other_hnYwF }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите **{{ ui-key.yacloud.k8s.cluster.switch_namespaces }}**.
  1. В строке пространства имен нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите действие.

{% endlist %}
