# Шифрование секретов в {{ managed-k8s-full-name }}

Используйте [ключ](../../kms/concepts/key.md) {{ kms-full-name }} для шифрования [секретов](../../lockbox/concepts/secret.md) — конфиденциальной информации, такой как пароли, OAuth-токены и [SSH-ключи](../../glossary/ssh-keygen.md), в [{{ managed-k8s-full-name }}](../../managed-kubernetes/). Для этого при создании [кластера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) укажите ключ {{ kms-name }}, который будет использоваться при шифровании и расшифровании.

Ключ шифрования необходимо указать при создании кластера {{ managed-k8s-name }}, его нельзя добавить при изменении кластера.


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входит плата за сервис {{ kms-name }}: количество активных версий ключа (в статусах `Active` и `Scheduled For Destruction`) и выполненных криптографических операций (см. [тарифы {{ kms-name }}](../../kms/pricing.md)).


{% list tabs group=instructions %}

- Консоль управления {#console}

  Укажите ключ при создании кластера {{ managed-k8s-name }}:
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан кластер {{ managed-k8s-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.clusters.button_create }}**.
  1. В поле **{{ ui-key.yacloud.k8s.clusters.create.field_kms-key }}** укажите необходимый ключ или [создайте новый](../../kms/operations/key.md#create).
  1. Закончите заполнение параметров [создания кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Указать ключ при [создании](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) кластера {{ managed-k8s-name }} можно двумя способами.

  - Используя идентификатор ключа:

    ```bash
    {{ yc-k8s }} cluster create \
      ...
      --kms-key-id <идентификатор_ключа> \
      ...
    ```

  - Используя имя ключа:

    ```bash
    {{ yc-k8s }} cluster create \
      ...
      --kms-key-name <имя_ключа> \
      ...
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Укажите ключ при [создании кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) {{ managed-k8s-name }}:
  1. Добавьте блок `kms_provider` в описание кластера {{ managed-k8s-name }}:

     ```hcl
     resource "yandex_kubernetes_cluster" "<имя_кластера>" {
       ...
       kms_provider {
         key_id = "<идентификатор_ключа>"
       }
     }
     ```

  1. Проверьте корректность конфигурационных файлов.

     {% include [terraform-create-cluster-step-2](../../_includes/mdb/terraform-create-cluster-step-2.md) %}

  1. Создайте кластер {{ managed-k8s-name }}.

     {% include [terraform-create-cluster-step-3](../../_includes/mdb/terraform-create-cluster-step-3.md) %}

- API {#api}

  Укажите ключ шифрования при [создании](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) кластера {{ managed-k8s-name }}. Для этого воспользуйтесь методом REST API [create](../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/create.md) для ресурса [Cluster](../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../../managed-kubernetes/managed-kubernetes/api-ref/grpc/Cluster/create.md).

  Передайте идентификатор ключа в соответствующем параметре поля `kmsProvider`.

{% endlist %}

Взаимодействие {{ managed-k8s-name }} с {{ kms-name }} происходит с помощью [механизма провайдеров {{ kms-name }}](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/). {{ managed-k8s-name }} поддерживает плагин {{ kms-name }}, который используется для шифрования и расшифрования ключей шифрования данных (DEK) в {{ kms-name }}. Шифрование секретов осуществляется стандартными средствами {{ k8s }}.

## См. также {#see-also}

* [Начало работы с {{ managed-k8s-name }}](../../managed-kubernetes/quickstart.md).
* [{#T}](../../kms/concepts/envelope.md).
* [Создание секретов в Kubernetes](https://kubernetes.io/docs/concepts/configuration/secret/#creating-your-own-secrets).