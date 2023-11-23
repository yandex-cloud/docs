---
title: "Как создать пространство имен в кластере {{ k8s }} в {{ managed-k8s-full-name }}"
description: "Следуя данной инструкции, вы сможете создать пространство имен в кластере {{ managed-k8s-name }}." 
---

# Создание пространства имен в кластере {{ k8s }}

Чтобы создать пространство имен в кластере {{ managed-k8s-name }}:

{% list tabs %}

- Консоль управления

  1. Откройте раздел **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}** в каталоге, где требуется изменить кластер {{ k8s }}.
  1. Выберите нужный кластер из списка.
  1. Перейдите на вкладку **{{ ui-key.yacloud.k8s.cluster.switch_namespaces }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.k8s.namespaces.button_create }}**.
  1. Укажите **{{ ui-key.yacloud.k8s.namespaces.popup-add_field_name }}** пространства имен. Оно должно соответствовать стандарту [RFC 1123](https://datatracker.ietf.org/doc/html/rfc1123):

     {% include [name-format-2](../../../_includes/name-format-2.md) %}

     {% include [note-namespace-kube](../../../_includes/managed-kubernetes/note-namespace-kube.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

- kubectl

  {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

  Выполните следующую команду:

  ```bash
  kubectl create namespace <имя_пространства_имен>
  ```

  Имя пространства имен должно соответствовать стандарту [RFC 1123](https://datatracker.ietf.org/doc/html/rfc1123):

  {% include [name-format-2](../../../_includes/name-format-2.md) %}

  {% include [note-namespace-kube](../../../_includes/managed-kubernetes/note-namespace-kube.md) %}

{% endlist %}