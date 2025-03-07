---
title: Установка Loki
description: Следуя данной инструкции, вы сможете установить Loki.
---

# Установка Loki


[Loki](https://grafana.com/oss/loki/) — горизонтально масштабируемая, высокодоступная многопользовательская система агрегации и хранения логов. Loki индексирует не содержимое логов, а набор меток для каждого потока логов.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. Подготовьтесь к установке Loki:

    1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с [ролями](../../../iam/concepts/access-control/roles.md) `storage.uploader` и `storage.viewer`. Он необходим для доступа к [{{ objstorage-full-name }}](../../../storage/).
    1. [Создайте статический ключ доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) в формате JSON:

        ```bash
        yc iam access-key create \
          --service-account-name=<имя_сервисного_аккаунта> \
          --format=json > sa-key.json
        ```

    1. [Создайте бакет](../../../storage/operations/buckets/create.md) с ограниченным доступом в {{ objstorage-name }}.

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Loki](/marketplace/products/yc/loki) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:

   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для Loki или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Имя бакета** — укажите имя [бакета](../../../storage/concepts/bucket.md) в {{ objstorage-name }}.
   * **Статический ключ для доступа** — скопируйте содержимое файла `sa-key.json`.
   * **Установить Promtail** — оставьте опцию включенной, чтобы поставлять локальные журналы инстансу Grafana Loki с помощью [агента Promtail](https://grafana.com/docs/loki/latest/clients/promtail/). Обычно агент используется для приложений, для которых нужен регулярный мониторинг.

1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Loki выполните команду, указав в ней параметры ресурсов, созданных [ранее](#before-you-begin):

    ```bash
    helm pull oci://{{ mkt-k8s-key.yc_loki.helmChart.name }} \
      --version {{ mkt-k8s-key.yc_loki.helmChart.tag }} \
      --untar && \
    helm install \
      --namespace <пространство_имен> \
      --create-namespace \
      --set global.bucketname=<имя_бакета> \
      --set-file global.serviceaccountawskeyvalue=<путь_к_файлу_sa-key.json> \
      loki ./loki/
    ```

    {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

1. Убедитесь, что все поды Loki перешли в состояние `Running`:

    ```bash
    kubectl get pods -A -l "app.kubernetes.io/instance=loki"
    ```

## Подключение к Loki {#loki-connect}

После развертывания Loki будет доступен внутри кластера {{ managed-k8s-name }} по следующему адресу:

```text
http://<имя_сервиса_Loki_gateway>.<пространство_имен>.svc.cluster.local
```

Чтобы узнать пространство имен и имя сервиса Loki gateway выполните команду:

```bash
kubectl get service -A | grep distributed-gateway
```

Результат:

```text
test-namespace   loki-loki-distributed-gateway   ClusterIP   10.96.168.88   <none>   80/TCP    15m
```

## См. также {#see-also}

* [Документация Grafana Loki](https://grafana.com/docs/loki/latest/).
