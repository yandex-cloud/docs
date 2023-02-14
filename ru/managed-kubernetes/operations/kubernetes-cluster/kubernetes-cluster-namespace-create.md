# Создание пространства имен в кластере {{ k8s }}

Чтобы создать пространство имен в кластере {{ managed-k8s-name }}:

{% list tabs %}

- Консоль управления

  1. Откройте раздел **{{ managed-k8s-name }}** в каталоге, где требуется изменить кластер {{ k8s }}.
  1. Выберите нужный кластер из списка.
  1. Перейдите на вкладку **Пространство имен**.
  1. В правом верхнем углу нажмите кнопку **Создать**.
  1. Укажите **Имя** пространства имен. Оно должно соответствовать стандарту [RFC 1123](https://datatracker.ietf.org/doc/html/rfc1123):

     {% include [name-format-2](../../../_includes/name-format-2.md) %}

     {% include [note-namespace-kube](../../../_includes/managed-kubernetes/note-namespace-kube.md) %}

  1. Нажмите кнопку **Добавить**.

- kubectl

  {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

  Выполните следующую команду:

  ```bash
  kubectl create namespace <имя пространства имен>
  ```

  Имя пространства имен должно соответствовать стандарту [RFC 1123](https://datatracker.ietf.org/doc/html/rfc1123):

  {% include [name-format-2](../../../_includes/name-format-2.md) %}

  {% include [note-namespace-kube](../../../_includes/managed-kubernetes/note-namespace-kube.md) %}

{% endlist %}