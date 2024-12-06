# Установка Crossplane с поддержкой {{ yandex-cloud }}

[Crossplane](https://crossplane.io/) — свободно распространяемое дополнение к {{ k8s }}, позволяющее командам разработки платформы собрать инфраструктуру для нескольких вендоров и производить более высокоуровневые [API](../../../glossary/rest-api.md) сервисов для потребления командами разработки приложений.

Установить Crossplane можно следующими способами:
* [В консоли управления с помощью {{ marketplace-full-name }}](#marketplace-install)
* [C помощью Helm-чарта из репозитория {{ marketplace-name }}](#helm-install)
* [С помощью Helm-чарта из репозитория Crossplane](#helm-repo-install)

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с [ролью](../../../iam/concepts/access-control/roles.md) `admin` на каталог, в котором вы хотите управлять ресурсами с помощью Crossplane.
1. Создайте [авторизованный ключ](../../../iam/concepts/authorization/key.md) для сервисного аккаунта и сохраните его в файл:

   ```bash
   yc iam key create \
     --service-account-name <имя_сервисного_аккаунта> \
     --output key.json
   ```

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Установка в консоли управления с помощью {{ marketplace-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Crossplane с поддержкой {{ yandex-cloud }}](/marketplace/products/yc/crossplane) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для Crossplane или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Ключ сервисного аккаунта** — вставьте содержимое файла [авторизованного ключа](../../../iam/concepts/authorization/key.md) сервисного аккаунта, [полученного ранее](#before-you-begin), или создайте новый.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

{% include [crossplane-provider-info](../../../_includes/managed-kubernetes/crossplane-provider-info.md) %}

## Установка с помощью Helm-чарта из репозитория {{ marketplace-name }} {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Crossplane выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_crossplane.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_crossplane.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set-file providerJetYc.creds=key.json \
     crossplane ./crossplane/
   ```

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

1. Убедитесь, что все поды crossplane перешли в состояние `Running`:

   ```bash
   kubectl get pods -A | grep -E "crossplane|provider-jet-yc"
   ```

{% include [crossplane-provider-info](../../../_includes/managed-kubernetes/crossplane-provider-info.md) %}

## Установка с помощью Helm-чарта из репозитория Crossplane {#helm-repo-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}
1. Создайте пространство имен для Crossplane:

   ```bash
   kubectl create namespace <пространство_имен>
   ```

1. Добавьте GitHub-репозиторий Helm:

   ```bash
   helm repo add crossplane-stable https://charts.crossplane.io/stable && \
   helm repo update
   ```

1. Установите Crossplane:

   ```bash
   helm install crossplane --namespace <пространство_имен> crossplane-stable/crossplane
   ```

1. Убедитесь, что Crossplane установлен и работает:

   ```bash
   helm list --namespace <пространство_имен> && \
   kubectl get all --namespace <пространство_имен>
   ```

1. Установите Crossplane CLI:

   ```bash
   curl --silent --location https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh | sh && \
   sudo mv kubectl-crossplane $(dirname $(which kubectl))
   ```

1. Установите провайдер:

   ```bash
   crossplane xpkg install provider xpkg.upbound.io/yandexcloud/crossplane-provider-yc:v0.5.1
   ```
   
   Актуальная версия провайдера доступна в [GitHub-репозитории](https://github.com/yandex-cloud/crossplane-provider-yc).

1. Создайте секрет `yc-creds`:

   ```bash
   kubectl create secret generic yc-creds \
     --namespace "<пространство_имен>" \
     --from-file=credentials=<путь_к_файлу_key.json>
   ```

1. Убедитесь, что [провайдер {{ yandex-cloud }}](https://github.com/yandex-cloud/crossplane-provider-yc/tree/main) установлен:
   
   ```bash
   kubectl get provider
   ```

1. Создайте манифест с настройками провайдера {{ yandex-cloud }} для Crossplane `providerconfig.yaml`:

   ```yaml
   apiVersion: yandex-cloud.jet.crossplane.io/v1beta1
   kind: ProviderConfig
   metadata:
     name: default
   spec:
     credentials:
       cloudId: <идентификатор_облака>
       folderId: <идентификатор_каталога>
       source: Secret
       secretRef:
         name: yc-creds
         namespace: <пространство_имен>
         key: credentials
   ```

1. Примените настройки провайдера:

   ```bash
   kubectl apply -f providerconfig.yaml
   ```

## Настройка провайдера {#change-provider-settings}

1. Чтобы изменить настройки провайдера {{ yandex-cloud }} для Crossplane, например указать, в каком [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) и каком [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) будут по умолчанию создаваться ресурсы, выполните команду:

   ```bash
   kubectl edit ProviderConfig/default
   ```

1. Отредактируйте параметры, которые вы хотите изменить и сохраните изменения.

## Получение информации о ресурсах {#see-resources}

1. Посмотрите, какие ресурсы {{ yandex-cloud }} можно создать с помощью Crossplane:

   ```bash
   kubectl get crd | grep yandex-cloud.jet.crossplane.io
   ```

1. Посмотрите параметры конкретного ресурса, которые можно задать с помощью Crossplane:
   
   ```bash
   kubectl describe crd <имя_ресурса>
   ```

   Например, запросите параметры для создания [виртуальной машины](../../../compute/concepts/vm.md) {{ compute-full-name }}:

   ```bash
   kubectl describe crd instances.compute.yandex-cloud.jet.crossplane.io
   ```

   Примеры конфигурации ресурсов {{ yandex-cloud }} см. в [репозитории провайдера на GitHub](https://github.com/yandex-cloud/crossplane-provider-yc/tree/main/examples).

## Примеры использования {#examples}

* [{#T}](../../tutorials/marketplace/crossplane.md)

## См. также {#see-also}

* [Документация Crossplane](https://docs.crossplane.io/)
