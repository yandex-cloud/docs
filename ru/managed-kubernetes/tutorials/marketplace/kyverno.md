# Настройка Kyverno & Kyverno Policies

Приложение [Kyverno](https://kyverno.io) и его расширение [Kyverno policies](https://github.com/kyverno/kyverno/tree/main/charts/kyverno-policies) используются для управления политиками безопасности {{ k8s }}. Они представлены в Kyverno как ресурсы {{ k8s }}.

Чтобы интегрировать [Kyverno & Kyverno Pоlicies](/marketplace/products/yc/kyverno) в {{ managed-k8s-name }}:
1. [{#T}](#kyverno-policies).
1. [{#T}](#check-apps).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. Создайте [кластер](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [группу узлов](../../../managed-kubernetes/concepts/index.md#node-group) {{ managed-k8s-name }}.

   {% list tabs %}

   - Вручную

     1. Если у вас еще нет [сети](../../../vpc/concepts/network.md#network), [создайте ее](../../../vpc/operations/network-create.md).
     1. Если у вас еще нет [подсетей](../../../vpc/concepts/network.md#subnet), [создайте их](../../../vpc/operations/subnet-create.md) в [зонах доступности](../../../overview/concepts/geo-scope.md), где будут созданы кластер {{ k8s }} и группа узлов.
     1. [Создайте кластер {{ managed-k8s-name }}](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации.
     1. [Создайте правило для подключения к сервисам из интернета](../../../managed-kubernetes/operations/connect/security-groups.md#rules-nodes) и примените его к группе узлов кластера {{ managed-k8s-name }}.

   - С помощью {{ TF }}

     1. Если у вас еще нет {{ TF }}, [установите его](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
     1. Скачайте в ту же рабочую директорию файл конфигурации кластера [k8s-cluster.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-cluster.tf). В файле описаны:
        * [Сеть](../../../vpc/concepts/network.md#network).
        * [Подсеть](../../../vpc/concepts/network.md#subnet).
        * [Группа безопасности](../../operations/connect/security-groups.md) и правила, необходимые для работы кластера, группы узлов и инстанса {{ managed-k8s-name }}:
          * Правила для служебного трафика.
          * Правила для доступа к API {{ k8s }} и управления кластером с помощью `kubectl` через порты 443 и 6443.
          * Правила для доступа к сервисам из интернета.
        * Кластер {{ managed-k8s-name }}.
        * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и группы узлов {{ managed-k8s-name }}}.
     1. Укажите в файле конфигурации:
        * [Идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
        * [Версию {{ k8s }}](../../concepts/release-channels-and-updates.md) для кластера и групп узлов {{ managed-k8s-name }}.
        * CIDR кластера {{ k8s }}.
        * Имя сервисного аккаунта. Оно должно быть уникальным в рамках каталога.
     1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
     1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [kubectl-install-links](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Создайте политику Kyverno {#kyverno-policies}

1. Установите приложение [Kyverno & Kyverno Pоlicies](/marketplace/products/yc/kyverno) согласно [инструкции](../../operations/applications/kyverno.md).
1. Создайте политику, которая будет требовать, чтобы все [поды](../../concepts/index.md#pod) имели [метку](../../../overview/concepts/services.md#labels) `app.kubernetes.io/name`.
   1. Сохраните спецификацию для создания объекта `ClusterPolicy` в YAML-файл с названием `policy.yaml`:

      ```yaml
      apiVersion: kyverno.io/v1
      kind: ClusterPolicy
      metadata:
        name: require-labels
      spec:
        validationFailureAction: enforce
        rules:
        - name: check-for-labels
          match:
            any:
            - resources:
                kinds:
                - Pod
          validate:
            message: "label 'app.kubernetes.io/name' is required"
            pattern:
              metadata:
                labels:
                  app.kubernetes.io/name: "?*"
      ```

   1. Выполните команду:

      ```bash
      kubectl apply -f ./policy.yaml
      ```

      Результат:

      ```text
      clusterpolicy.kyverno.io/require-labels created
      ```

## Проверьте работу Kyverno & Kyverno Pоlicies {#check-apps}

* Создайте под без метки `app.kubernetes.io/name`:

  ```bash
  kubectl run nginx --image nginx
  ```

  Результат:

  ```text
  Error from server: admission webhook "validate.kyverno.svc-fail" denied the request:

  resource Pod/default/nginx was blocked due to the following policies

  require-labels:
    check-for-labels: 'validation error: label ''app.kubernetes.io/name'' is required.
      Rule check-for-labels failed at path /metadata/labels/app.kubernetes.io/name/'
  ```

* Создайте под с меткой `app.kubernetes.io/name`:

  ```bash
  kubectl run nginx --image nginx --labels app.kubernetes.io/name=nginx
  ```

  Результат:

  ```text
  pod/nginx created
  ```

{% note info %}

Несмотря на то, что политики предназначены для подов, Kyverno применяет их на все ресурсы, способные создавать поды.

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

{% list tabs %}

- Вручную

  1. [Удалите кластер {{ k8s }}](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. [Удалите созданные подсети](../../../vpc/operations/subnet-delete.md) и [сети](../../../vpc/operations/network-delete.md).
  1. [Удалите созданный сервисный аккаунт](../../../iam/operations/sa/delete.md).

- С помощью {{ TF }}

  1. В командной строке перейдите в директорию, в которой расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  1. Удалите конфигурационный файл `k8s-cluster.tf`.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     Все ресурсы, которые были описаны в конфигурационном файле `k8s-cluster.tf`, будут удалены.

{% endlist %}