# Настройка Kyverno & Kyverno Policies


Приложение [Kyverno](https://kyverno.io) и его расширение [Kyverno policies](https://github.com/kyverno/kyverno/tree/main/charts/kyverno-policies) используются для управления политиками безопасности {{ k8s }}. Они представлены в Kyverno как ресурсы {{ k8s }}.

Чтобы интегрировать [Kyverno & Kyverno Policies](/marketplace/products/yc/kyverno) в {{ managed-k8s-name }}:

1. [{#T}](#install-kyverno).
1. [{#T}](#check-baseline).
1. [{#T}](#create-check-policies).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

1. Создайте [кластер](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [группу узлов](../../../managed-kubernetes/concepts/index.md#node-group) {{ managed-k8s-name }}.

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. Если у вас еще нет [сети](../../../vpc/concepts/network.md#network), [создайте ее](../../../vpc/operations/network-create.md).
     1. Если у вас еще нет [подсетей](../../../vpc/concepts/network.md#subnet), [создайте их](../../../vpc/operations/subnet-create.md) в [зонах доступности](../../../overview/concepts/geo-scope.md), где будут созданы кластер {{ k8s }} и группа узлов.
     1. {% include [configure-sg-manual](../../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. [Создайте кластер {{ managed-k8s-name }}](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../../managed-kubernetes/operations/node-group/node-group-create.md) любой подходящей конфигурации. При создании укажите группы безопасности, подготовленные ранее.

   - {{ TF }} {#tf}

     1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
     1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
     1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
     1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

     1. Скачайте в ту же рабочую директорию файл конфигурации кластера [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf). В файле описаны:
        * [Сеть](../../../vpc/concepts/network.md#network).
        * [Подсеть](../../../vpc/concepts/network.md#subnet).
        * Кластер {{ managed-k8s-name }}.
        * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и группы узлов {{ managed-k8s-name }}.
        * {% include [configure-sg-terraform](../../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. Укажите в файле конфигурации:
        * [Идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
        * [Версию {{ k8s }}](../../concepts/release-channels-and-updates.md) для кластера и групп узлов {{ managed-k8s-name }}.
        * CIDR кластера {{ k8s }}.
        * Имя сервисного аккаунта. Оно должно быть уникальным в рамках каталога.
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

## Установите приложение Kyverno & Kyverno Policies {#install-kyverno}

Установите приложение [Kyverno & Kyverno Policies](/marketplace/products/yc/kyverno) согласно [инструкции](../../operations/applications/kyverno.md) со следующими настройками:

* **Pod Security Standard profile** — `baseline`.
* **Validation failure action** — `enforce`.

[Профиль Pod Security Standard](https://kubernetes.io/docs/concepts/security/pod-security-standards/) `baseline` уже содержит минимально ограничительную политику, которая предотвращает известные превышения привилегий.

## Проверьте работу политики для профиля baseline {#check-baseline}

* Создайте под `nginx` со стандартными параметрами:

  ```bash
  kubectl run nginx --image nginx
  ```

  Результат:

  ```text
  pod/nginx created
  ```

  Такой под удовлетворяет требованиям правил политики для профиля `baseline`.

* Создайте под `nginx` в привилегированном режиме:

  ```bash
  kubectl run nginx --image nginx --privileged=true
  ```

  Результат:

  ```text
  Error from server: admission webhook "validate.kyverno.svc-fail" denied the request:

  policy Pod/default/nginx for resource violation:

  disallow-privileged-containers:
    privileged-containers: 'validation error: Privileged mode is disallowed. The fields
      spec.containers[*].securityContext.privileged and spec.initContainers[*].securityContext.privileged
      must be unset or set to `false`. rule privileged-containers failed at path /spec/containers/0/securityContext/privileged/'
  ```

  Правила политики для профиля `baseline` запрещают создание подов в привилегированном режиме.

{% note info %}

Несмотря на то, что политики предназначены для подов, Kyverno применяет их на все ресурсы, способные создавать поды.

{% endnote %}

## Создайте собственную политику Kyverno policies и проверьте ее работу {#create-check-policies}

1. Создайте политику, которая будет требовать, чтобы все [поды](../../concepts/index.md#pod) имели [метку](../../../resource-manager/concepts/labels.md) `app.kubernetes.io/name`:
   1. Сохраните спецификацию для создания объекта `ClusterPolicy` в YAML-файл с названием `policy.yaml`:

      ```yaml
      apiVersion: kyverno.io/v1
      kind: ClusterPolicy
      metadata:
        name: require-labels
      spec:
        validationFailureAction: Enforce
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
      kubectl apply -f policy.yaml
      ```

      Результат:

      ```text
      clusterpolicy.kyverno.io/require-labels created
      ```
1. {% include [install policy reporter](../../../_includes/managed-kubernetes/install-policy-reporter.md) %}

## Проверьте работу Kyverno & Kyverno Policies {#check-apps}

* Создайте под `nginx` без {{ k8s }}-метки `app.kubernetes.io/name`:

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

* Создайте под `nginx` с меткой `app.kubernetes.io/name`:

  ```bash
  kubectl run nginx --image nginx --labels app.kubernetes.io/name=nginx
  ```

  Результат:

  ```text
  pod/nginx created
  ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

  1. [Удалите кластер {{ k8s }}](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. [Удалите созданные подсети](../../../vpc/operations/subnet-delete.md) и [сети](../../../vpc/operations/network-delete.md).
  1. [Удалите созданный сервисный аккаунт](../../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

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
