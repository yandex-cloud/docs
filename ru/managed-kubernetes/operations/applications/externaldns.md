---
title: Установка ExternalDNS c плагином для {{ dns-full-name }}
description: Следуя данной инструкции, вы сможете установить ExternalDNS c плагином для {{ dns-name }}.
---

# Установка ExternalDNS c плагином для {{ dns-full-name }}


[ExternalDNS](https://github.com/kubernetes-sigs/external-dns) позволяет автоматически создавать [DNS-записи](../../../dns/concepts/resource-record.md) в [{{ dns-full-name }}](../../../dns/). ExternalDNS делает ресурсы {{ k8s }} доступными для обнаружения через общедоступные DNS-серверы.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), необходимый для работы c {{ dns-name }}.
1. [Назначьте ему роль](../../../iam/operations/sa/assign-role-for-sa.md) `dns.editor`.
1. [Создайте авторизованный ключ](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) в формате JSON и сохраните его в файл `key.json`:

   ```bash
   yc iam key create \
     --service-account-name <имя_сервисного_аккаунта> \
     --format json \
     --output key.json
   ```

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [ExternalDNS с плагином для {{ dns-full-name }}](/marketplace/products/yc/externaldns) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `externaldns-space`). Если вы оставите пространство имен по умолчанию, ExternalDNS может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Ключ сервисной учетной записи** — вставьте содержимое файла `key.json` или создайте новый авторизованный ключ для сервисного аккаунта. Сервисный аккаунт должен иметь [роль](../../../iam/concepts/access-control/roles.md) `dns.editor`.
   * **ID каталога** — укажите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [зона {{ dns-name }}](../../../dns/concepts/dns-zone.md).
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с ExternalDNS выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_externaldns.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_externaldns.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set config.folder_id=<идентификатор_каталога_с_DNS-зоной> \
     --set-file config.auth.json=<путь_к_файлу_с_авторизованным_ключом_сервисного_аккаунта> \
     externaldns ./externaldns/
    ```

    Если вы укажете в параметре `namespace` пространство имен по умолчанию, ExternalDNS может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `externaldns-space`).

    {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## Особенности работы {#features}

Чтобы автоматически создавать DNS-записи с помощью приложения [ExternalDNS с плагином для {{ dns-full-name }}](/marketplace/products/yc/externaldns):
* С [Ingress-контроллерами](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) не нужны дополнительные настройки.
* Для сервисов типа [LoadBalancer](https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer) необходимо использовать аннотацию `"external-dns.alpha.kubernetes.io/hostname=<ваш_домен>"`.

  Чтобы установить значение TTL для DNS-записи, используйте аннотацию `"external-dns.alpha.kubernetes.io/ttl=<значение_TTL_в_секундах>"`.

## Примеры использования {#examples}

* [{#T}](../../tutorials/alb-ingress-controller-log-options.md).
* [{#T}](../../tutorials/load-testing-grpc-autoscaling.md).

## См. также {#see-also}

* [Документация ExternalDNS](https://github.com/kubernetes-sigs/external-dns/).
