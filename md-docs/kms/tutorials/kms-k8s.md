[Документация Yandex Cloud](../../index.md) > [Yandex Key Management Service](../index.md) > [Практические руководства](index.md) > Шифрование секретов в Managed Service for Kubernetes

# Шифрование секретов в Yandex Managed Service for Kubernetes

Используйте [ключ](../concepts/key.md) Yandex Key Management Service для шифрования [секретов](../../lockbox/concepts/secret.md) — конфиденциальной информации, такой как пароли и [SSH-ключи](../../glossary/ssh-keygen.md), в [Yandex Managed Service for Kubernetes](../../managed-kubernetes/index.md). Для этого при создании [кластера Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) укажите ключ Key Management Service, который будет использоваться при шифровании и расшифровании.

Ключ шифрования необходимо указать при создании кластера Managed Service for Kubernetes, его нельзя добавить при изменении кластера.


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входит плата за сервис Key Management Service: количество активных версий ключа (в статусах `Active` и `Scheduled For Destruction`) и выполненных криптографических операций ([тарифы Key Management Service](../pricing.md)).


{% list tabs group=instructions %}

- Консоль управления {#console}

  Укажите ключ при создании кластера Managed Service for Kubernetes:
  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан кластер Managed Service for Kubernetes.
  1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
  1. Нажмите кнопку **Создать кластер**.
  1. В поле **Ключ шифрования** укажите необходимый ключ или [создайте новый](../operations/key.md#create).
  1. Закончите заполнение параметров [создания кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md).
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Указать ключ при [создании](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) кластера Managed Service for Kubernetes можно двумя способами.

  - Используя идентификатор ключа:

    ```bash
    yc managed-kubernetes cluster create \
      ...
      --kms-key-id <идентификатор_ключа> \
      ...
    ```

  - Используя имя ключа:

    ```bash
    yc managed-kubernetes cluster create \
      ...
      --kms-key-name <имя_ключа> \
      ...
    ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Укажите ключ при [создании кластера](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) Managed Service for Kubernetes:
  1. Добавьте блок `kms_provider` в описание кластера Managed Service for Kubernetes:

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
     
     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет. Это проверочный этап: ресурсы не будут созданы.

  1. Создайте кластер Managed Service for Kubernetes.

     1. Если в конфигурации нет ошибок, выполните команду:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите создание ресурсов.
     
     После этого в указанном каталоге будут созданы все требуемые ресурсы, а в терминале отобразятся IP-адреса виртуальных машин. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Укажите ключ шифрования при [создании](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) кластера Managed Service for Kubernetes. Для этого воспользуйтесь методом REST API [create](../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/create.md) для ресурса [Cluster](../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Create](../../managed-kubernetes/managed-kubernetes/api-ref/grpc/Cluster/create.md).

  Передайте идентификатор ключа в соответствующем параметре поля `kmsProvider`.

{% endlist %}

Взаимодействие Managed Service for Kubernetes с Key Management Service происходит с помощью [механизма провайдеров Key Management Service](https://kubernetes.io/docs/tasks/administer-cluster/kms-provider/). Managed Service for Kubernetes поддерживает плагин Key Management Service, который используется для шифрования и расшифрования ключей шифрования данных (DEK) в Key Management Service. Шифрование секретов осуществляется стандартными средствами Kubernetes.

## Полезные ссылки {#see-also}

* [Начало работы с Managed Service for Kubernetes](../../managed-kubernetes/quickstart.md).
* [Шифрование по схеме envelope encryption](../concepts/envelope.md).
* [Создание секретов в Kubernetes](https://kubernetes.io/docs/concepts/configuration/secret/#creating-your-own-secrets).