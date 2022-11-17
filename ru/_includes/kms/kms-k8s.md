Используйте ключ {{ kms-short-name }} для шифрования секретов — конфиденциальной информации, такой как пароли, OAuth-токены и {% if lang == "ru" and audience != "internal" %}[SSH-ключи](../../glossary/ssh-keygen.md){% else %}SSH-ключи{% endif %}, в {{ managed-k8s-full-name }}. Для этого при создании кластера укажите ключ {{ kms-short-name }}, который будет использоваться при шифровании и расшифровке.

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
      {{ yc-k8s }} cluster create \
         ...
         --kms-key-id <идентификатор ключа шифрования> \
         ...
      ```

  - Используя имя ключа:

      ```bash
      {{ yc-k8s }} cluster create \
         ...
         --kms-key-name <имя ключа шифрования> \
         ...
      ```

- {{ TF }}

    {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

    Если у вас еще нет {{ TF }}, [установите его и настройте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

    Укажите ключ при [создании кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) {{ k8s }}:

    1. Добавьте блок `kms_provider` в описание кластера:

        ```hcl
        resource "yandex_kubernetes_cluster" "<имя кластера>" {
          ...
          kms_provider {
            key_id = "<идентификатор ключа шифрования>"
          }
        }
        ```

    1. Проверьте корректность конфигурационных файлов.

        {% include [terraform-create-cluster-step-2](../../_includes/mdb/terraform-create-cluster-step-2.md) %}

    1. Создайте кластер.

        {% include [terraform-create-cluster-step-3](../../_includes/mdb/terraform-create-cluster-step-3.md) %}

- API

    Укажите ключ шифрования при [создании](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) кластера {{ k8s }}. Для этого воспользуйтесь методом [create](../../managed-kubernetes/api-ref/Cluster/create.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster) и передайте идентификатор ключа в параметре `kmsProvider.keyId`.

{% endlist %}

Взаимодействие {{ managed-k8s-name }} с {{ kms-short-name }} происходит с помощью [механизма {{ kms-short-name }} провайдеров](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/). {{ managed-k8s-name }} поддерживает {{ kms-short-name }}-плагин, который используется для шифрования и расшифровки ключей шифрования данных (DEK) в {{ kms-short-name }}. Шифрование секретов осуществляется стандартными средствами {{ k8s }}.
