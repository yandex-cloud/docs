# Установка Loki

[Loki](https://grafana.com/oss/loki/) — горизонтально масштабируемая, высокодоступная многопользовательская система агрегации и хранения логов. Loki индексирует не содержимое логов, а набор меток для каждого потока логов.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с [ролями](../../../iam/concepts/access-control/roles.md) `storage.uploader` и `storage.viewer`. Он необходим для доступа к [{{ objstorage-full-name }}](../../../storage/).
1. [Создайте статический ключ доступа](../../../iam/operations/sa/create-access-key.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) в формате JSON и сохраните его в файл `sa-key.json`:

   ```bash
   yc iam access-key create \
     --service-account-name=<имя_сервисного_аккаунта> \
     --format=json > sa-key.json
   ```

1. [Создайте бакет](../../../storage/operations/buckets/create.md) с ограниченным доступом в {{ objstorage-name }}.

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [Loki](/marketplace/products/yc/loki) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:

   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для Loki или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Имя бакета** — укажите имя [бакета](../../../storage/concepts/bucket.md) в {{ objstorage-name }}.
   * **Статический ключ для доступа** — скопируйте содержимое файла `sa-key.json`.
   * **Установить Promtail** — оставьте опцию включенной, чтобы поставлять локальные журналы инстансу Grafana Loki с помощью [агента Promtail](https://grafana.com/docs/loki/latest/clients/promtail/). Обычно агент используется для приложений, для которых нужен регулярный мониторинг.

1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.
1. После развертывания Loki будет доступен по адресу внутри кластера {{ managed-k8s-name }}: `http://loki-gateway.<пространство_имен>.svc.cluster.local`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Loki выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_loki.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_loki.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set storageConfig.aws.bucketnames=<имя_бакета_Object_Storage> \
     --set-file serviceaccountawskeyvalue=<путь_к_файлу_со_статическим_ключом_сервисного_аккаунта> \
     loki ./loki/
   ```

## См. также {#see-also}

* [Документация Grafana Loki](https://grafana.com/docs/loki/latest/).