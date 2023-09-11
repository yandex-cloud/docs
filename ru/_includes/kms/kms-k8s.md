Используйте ключ {{ kms-short-name }} для шифрования секретов — конфиденциальной информации, такой как пароли, OAuth-токены и [SSH-ключи](../../glossary/ssh-keygen.md), в {{ managed-k8s-full-name }}. Для этого при создании кластера укажите ключ {{ kms-short-name }}, который будет использоваться при шифровании и расшифровании.

Ключ шифрования необходимо указать при создании кластера {{ k8s }}, его нельзя добавить при изменении кластера.

{% list tabs %}

- Консоль управления

    Укажите ключ при создании кластера {{ k8s }}:
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан кластер {{ k8s }}.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.k8s.clusters.button_create }}**.
    1. В поле **{{ ui-key.yacloud.k8s.clusters.create.field_kms-key }}** укажите необходимый ключ или [создайте новый](../../kms/operations/key.md#create).
    1. Закончите заполнение параметров [создания кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

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

- API

    Укажите ключ шифрования при [создании](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) кластера {{ k8s }}. Для этого воспользуйтесь методом REST API [create](../../managed-kubernetes/api-ref/Cluster/create.md) для ресурса [Cluster](../../managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../../managed-kubernetes/api-ref/grpc/cluster_service.md#Create).
    Передайте идентификатор ключа в соответствующем параметре поля `kmsProvider`.

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

{% endlist %}

Взаимодействие {{ managed-k8s-name }} с {{ kms-short-name }} происходит с помощью [механизма {{ kms-short-name }} провайдеров](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/). {{ managed-k8s-name }} поддерживает {{ kms-short-name }}-плагин, который используется для шифрования и расшифрования ключей шифрования данных (DEK) в {{ kms-short-name }}. Шифрование секретов осуществляется стандартными средствами {{ k8s }}.
