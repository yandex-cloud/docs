# Установка Policy Reporter

[Policy Reporter](https://kyverno.github.io/policy-reporter/) предназначен для работы с результатами срабатываний Kyverno-политик — [PolicyReports](https://kyverno.io/docs/policy-reports/). Также он поддерживает инструменты Falco, jsPolicy, Kube Bench и Trivy. Policy Reporter позволяет визуализировать результаты в графическом виде. Для долгосрочного хранения или дальнейшей загрузки в SIEM-систему результаты можно выгрузить во внешнее хранилище, например в [{{ objstorage-full-name }} (S3)](../../../storage/) или [{{ yds-full-name }}](../../../data-streams/).

{% note warning %}

Чтобы использовать Policy Reporter, установите [Kyverno](/marketplace/products/yc/kyverno) или другой продукт, который поддерживает запись результатов в [wg-policy-prototypes](https://github.com/kubernetes-sigs/wg-policy-prototypes/blob/master/policy-report/README.md).

{% endnote %}

## Перед началом работы {#before-you-begin}

Для выгрузки результатов срабатываний политик настройте внешнее хранилище:

* {{ objstorage-name }}:

  1. {% include [cli-install](../../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с [ролью](../../../iam/concepts/access-control/roles.md) `storage.uploader`. Он необходим для доступа к {{ objstorage-name }}.
  1. [Создайте статический ключ доступа](../../../iam/operations/sa/create-access-key.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) в формате JSON и сохраните его в файл `sa-key.json`:

     ```bash
     yc iam access-key create \
       --service-account-name=<имя сервисного аккаунта> \
       --format=json > sa-key.json
     ```

  1. [Создайте бакет в {{ objstorage-name }}](../../../storage/operations/buckets/create.md).

* {{ yds-name }}:

  [Создайте поток данных](../../../data-streams/quickstart/create-stream.md).

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [Policy Reporter](/marketplace/products/yc/policy-reporter) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для Policy Reporter или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Идентификатор кластера** — выберите кластер {{ managed-k8s-name }} из списка.
   * **Установить Policy Reporter UI** — включите опцию, чтобы установить компонент **Policy Reporter UI** для отображения результатов в графическом виде.
   * **Экспорт в {{ objstorage-name }}** — включите опцию, чтобы экспортировать результаты в {{ objstorage-name }}. Также необходимо заполнить дополнительные поля:
     * **Имя бакета {{ objstorage-name }}** — укажите имя [бакета](../../../storage/concepts/bucket.md) в {{ objstorage-name }}.
     * **Статический ключ для доступа к {{ objstorage-name }}** — скопируйте содержимое файла `sa-key.json` или создайте новый ключ доступа для сервисного аккаунта. Сервисный аккаунт должен иметь роль `storage.uploader`.
   * **Экспорт в YDS** — включите опцию, чтобы экспортировать результаты в {{ yds-name }}. При этом необходимо заполнить дополнительные поля:
     * **Endpoint YDS** — укажите эндпоинт [потока](../../../data-streams/concepts/glossary.md#stream-concepts) {{ yds-name }}.
     * **Имя YDS стрима** — укажите имя потока {{ yds-name }}.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Policy Reporter выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/kyverno/chart/policy-reporter \
     --version <версия Helm-чарта> \
     --untar && \
   helm upgrade --install \
     --namespace <пространство имен> \
     --create-namespace \
     --set clusterId=<идентификатор кластера> \
     --set ui.enabled=<включение Policy Reporter UI: true или false> \
     --set target.s3.enabled=<экспорт в {{ objstorage-name }}: true или false> \
     --set target.s3.bucket=<имя бакета {{ objstorage-name }}> \
     --set-file serviceaccountawskeyvalue=<путь к файлу со статическим ключом сервисного аккаунта> \
     --set target.kinesis.enabled=<экспорт в {{ yds-name }}: true или false> \
     --set target.kinesis.endpoint=<эндпоинт потока {{ yds-name }}> \
     --set target.kinesis.streamName=<имя потока {{ yds-name }}> \
     policy-reporter ./policy-reporter
   ```

   Актуальную версию Helm-чарта можно посмотреть на [странице приложения](/marketplace/products/yc/policy-reporter#docker-images).

   Параметры `target.s3.bucket` и `serviceaccountawskeyvalue` необходимы только при включенном экспорте в {{ objstorage-name }} `target.s3.enabled=true`, а `target.kinesis.endpoint` и `target.kinesis.streamName` — при включенном экспорте в {{ yds-name }} `target.kinesis.enabled=true`.

## См. также {#see-also}

* [Документация Policy Reporter](https://kyverno.github.io/policy-reporter/).
* [Пример в библиотеке решений {{ yandex-cloud }}: Анализ логов безопасности {{ k8s }} в ELK](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/auditlogs/export-auditlogs-to-ELK_k8s/README.md).