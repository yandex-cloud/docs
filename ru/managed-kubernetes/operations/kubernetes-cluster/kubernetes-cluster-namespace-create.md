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

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Namespaces](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.k8s.cluster.switch_namespaces }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. В открывшемся окне введите **{{ ui-key.yacloud.k8s.namespaces.popup-add_field_name }}** пространства имен.

     {% include [note-namespace-kube](../../../_includes/managed-kubernetes/note-namespace-kube.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

## Удаление пространства имен

Удаление пространства имен соответствует выполнению команды `kubectl delete namespace <имя_пространства_имен>`. При удалении пространства имен все созданные в нем ресурсы будут удалены.

Чтобы удалить пространство имен:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите на имя нужного кластера и на панели слева выберите ![Namespaces](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.k8s.cluster.switch_namespaces }}**.
  1. В строке пространства имен нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите действие.

{% endlist %}
