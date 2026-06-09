# Шифрование секретов в {{ managed-k8s-full-name }}

Используйте [ключ](../../../kms/concepts/key.md) {{ kms-full-name }} для шифрования [секретов](../../../lockbox/concepts/secret.md) — конфиденциальной информации, такой как пароли и [SSH-ключи](../../../glossary/ssh-keygen.md), в [{{ managed-k8s-full-name }}](../../../managed-kubernetes/index.md). Для этого при создании [кластера {{ managed-k8s-name }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) укажите ключ {{ kms-name }}, который будет использоваться при шифровании и расшифровании.

Ключ шифрования необходимо указать при создании кластера {{ managed-k8s-name }}, его нельзя добавить при изменении кластера.


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входит плата за сервис {{ kms-name }}: количество активных версий ключа (в статусах `Active` и `Scheduled For Destruction`) и выполненных криптографических операций (см. [тарифы {{ kms-name }}](../../../kms/pricing.md)).


{% list tabs group=instructions %}

- Консоль управления {#console}

  Укажите ключ при создании кластера {{ managed-k8s-name }}:
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан кластер {{ managed-k8s-name }}.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.k8s.clusters.button_create }}**.
  1. В поле **{{ ui-key.yacloud.k8s.clusters.create.field_kms-key }}** укажите необходимый ключ или [создайте новый](../../../kms/operations/key.md#create).
  1. Закончите заполнение параметров [создания кластера](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Указать ключ при [создании](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) кластера {{ managed-k8s-name }} можно двумя способами.

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

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Укажите ключ при [создании кластера](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) {{ managed-k8s-name }}:
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

     1. В командной строке перейдите в каталог, в котором создан конфигурационный файл.
        
     1. Выполните проверку с помощью команды:
        
        ```bash
        terraform plan
        ```
     
     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. Это проверочный этап: ресурсы не будут созданы.

  1. Создайте кластер {{ managed-k8s-name }}.

     1. Если в конфигурации нет ошибок, выполните команду:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите создание ресурсов.
     
     После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся IP-адреса виртуальных машин. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Укажите ключ шифрования при [создании](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) кластера {{ managed-k8s-name }}. Для этого воспользуйтесь методом REST API [create](../../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/create.md) для ресурса [Cluster](../../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../../../managed-kubernetes/managed-kubernetes/api-ref/grpc/Cluster/create.md).

  Передайте идентификатор ключа в соответствующем параметре поля `kmsProvider`.

{% endlist %}

Взаимодействие {{ managed-k8s-name }} с {{ kms-name }} происходит с помощью [механизма провайдеров {{ kms-name }}](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/). {{ managed-k8s-name }} поддерживает плагин {{ kms-name }}, который используется для шифрования и расшифрования ключей шифрования данных (DEK) в {{ kms-name }}. Шифрование секретов осуществляется стандартными средствами {{ k8s }}.

## См. также {#see-also}

* [Начало работы с {{ managed-k8s-name }}](../../../managed-kubernetes/quickstart.md).
* [{#T}](../../../kms/concepts/envelope.md).
* [Создание секретов в Kubernetes](https://kubernetes.io/docs/concepts/configuration/secret/#creating-your-own-secrets).