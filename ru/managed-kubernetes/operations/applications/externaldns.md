# Установка ExternalDNS c плагином для {{ dns-full-name }}

[ExternalDNS](https://github.com/kubernetes-sigs/external-dns) позволяет автоматически создавать [DNS-записи](../../../dns/concepts/resource-record.md) в [{{ dns-full-name }}](../../../dns/). ExternalDNS делает ресурсы {{ k8s }} доступными для обнаружения через общедоступные DNS-серверы.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы c {{ dns-name }}.
1. [Назначьте ему роль](../../../iam/operations/sa/assign-role-for-sa.md) `dns.editor`.
1. [Создайте авторизованный ключ](../../../iam/operations/authorized-key/create.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) в формате JSON и сохраните его в файл `key.json`:

   ```bash
   yc iam key create \
     --service-account-name <имя_сервисного_аккаунта> \
     --format json \
     --output key.json
   ```

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [ExternalDNS c плагином для {{ dns-full-name }}](/marketplace/products/yc/externaldns) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для ExternalDNS или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Ключ сервисной учетной записи** — вставьте содержимое файла `key.json` или создайте новый авторизованный ключ для сервисного аккаунта. Сервисный аккаунт должен иметь [роль](../../../iam/concepts/access-control/roles.md) `dns.editor`.
   * **ID каталога** — укажите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [зона {{ dns-name }}](../../../dns/concepts/dns-zone.md).
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с ExternalDNS выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/externaldns/helm/externaldns \
     --version <версия_Helm-чарта> \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set config.folder_id=<идентификатор_каталога,_в_котором_находится_зона_Cloud_DNS> \
     --set-file config.auth.json=<путь_к_файлу_с_авторизованным_ключом_сервисного_аккаунта> \
     externaldns ./externaldns/
    ```

## См. также {#see-also}

* [Документация ExternalDNS](https://github.com/kubernetes-sigs/external-dns/).