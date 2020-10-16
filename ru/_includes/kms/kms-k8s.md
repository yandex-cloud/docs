Используйте ключ {{ kms-short-name }} для шифрования секретов — конфиденциальной информации, такой как пароли, OAuth-токены и SSH-ключи, в {{ managed-k8s-full-name }}. Для этого при создании кластера укажите ключ {{ kms-short-name }}, который будет использоваться при шифровании и расшифровке.

Ключ шифрования необходимо указать при создании кластера {{ k8s }}, его нельзя добавить при изменении кластера.

{% list tabs %}

- Консоль управления

    Укажите ключ при создании кластера {{ k8s }}:
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан кластер {{ k8s }}.
    1. В списке сервисов выберите **{{ managed-k8s-name }}**.
    1. Нажмите кнопку **Создать кластер**.
    1. В поле **Ключ шифрования** укажите необходимый ключ или [создайте новый](../../kms/operations/key.md#create).
    1. Закончите заполнение параметров [создания кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).
    1. Нажмите кнопку **Создать кластер**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Указать ключ при [создании](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) кластера {{ k8s }} можно двумя способами.

  - Используя идентификатор ключа:

      ```bash
      yc k8s create --kms-key-id <идентификатор ключа шифрования> \
      ...
      ```

  - Используя имя ключа:

      ```bash
      yc k8s create --kms-key-name <имя ключа шифрования> \
      ...
      ```

- API

    Укажите ключ шифрования при [создании](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) кластера {{ k8s }}. Для этого воспользуйтесь методом [create](../../managed-kubernetes/api-ref/Cluster/create.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster).

{% endlist %}

Взаимодействие {{ managed-k8s-name }} с {{ kms-short-name }} происходит с помощью [механизма {{ kms-short-name }} провайдеров](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/). {{ managed-k8s-name }} поддерживает {{ kms-short-name }}-плагин, который используется для шифрования и расшифровки ключей шифрования данных (DEK) в {{ kms-short-name }}. Шифрование секретов осуществляется стандартными средствами {{ k8s }}.