# Установка Policy Reporter


[Policy Reporter](https://kyverno.github.io/policy-reporter/) предназначен для работы с результатами срабатываний Kyverno-политик — [PolicyReports](https://kyverno.io/docs/policy-reports/). Также он поддерживает инструменты Falco, jsPolicy, Kube Bench и Trivy. Policy Reporter позволяет визуализировать результаты в графическом виде. Для долгосрочного хранения или дальнейшей загрузки в SIEM-систему результаты можно выгрузить во внешнее хранилище, например в [{{ objstorage-full-name }} (S3)](../../../storage/) или [{{ yds-full-name }}](../../../data-streams/).

{% note warning %}

Чтобы использовать Policy Reporter, установите [Kyverno](/marketplace/products/yc/kyverno) или другой продукт, который поддерживает запись результатов в [wg-policy-prototypes](https://github.com/kubernetes-sigs/wg-policy-prototypes/blob/master/policy-report/README.md).

{% endnote %}

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. Для выгрузки результатов срабатываний политик настройте внешнее хранилище:

    * **{{ objstorage-name }}**

      1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с [ролью](../../../iam/concepts/access-control/roles.md) `storage.uploader`. Он необходим для доступа к {{ objstorage-name }}.
      1. [Создайте статический ключ доступа](../../../iam/operations/sa/create-access-key.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) в формате JSON и сохраните его в файл `sa-key.json`:

         ```bash
         yc iam access-key create \
           --service-account-name=<имя_сервисного_аккаунта> \
           --format=json > sa-key.json
         ```

      1. [Создайте бакет](../../../storage/operations/buckets/create.md) с ограниченным доступом в {{ objstorage-name }}.

    * **{{ yds-name }}**

      [Создайте поток данных](../../../data-streams/quickstart/create-stream.md).

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **Доступные для установки приложения** выберите [Policy Reporter](/marketplace/products/yc/policy-reporter) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
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
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Policy Reporter выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_policy-reporter.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_policy-reporter.helmChart.tag }} \
     --untar && \
   helm upgrade --install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set clusterId=<идентификатор_кластера> \
     --set ui.enabled=<включение_Policy_Reporter_UI> \
     --set target.s3.enabled=<экспорт_в_Object_Storage> \
     --set target.s3.bucket=<имя_бакета_Object_Storage> \
     --set-file serviceaccountawskeyvalue=<путь_к_файлу_со_статическим_ключом_сервисного_аккаунта> \
     --set target.kinesis.enabled=<экспорт_в_Data_Streams> \
     --set target.kinesis.endpoint=<эндпоинт_потока_Data_Streams> \
     --set target.kinesis.streamName=<имя_потока_Data_Streams> \
     policy-reporter ./policy-reporter/
   ```

   Где: 

   * `ui.enabled` — включение Policy Reporter UI. Возможные значения: `true` или `false`.
   * `target.s3.enabled` — экспорт в {{ objstorage-name }}. Возможные значения: `true` или `false`.
   * `target.kinesis.enabled` — экспорт в {{ yds-name }}. Возможные значения: `true` или `false`.

   Параметры `target.s3.bucket` и `serviceaccountawskeyvalue` необходимы только при включенном экспорте в {{ objstorage-name }} `target.s3.enabled=true`, а `target.kinesis.endpoint` и `target.kinesis.streamName` — при включенном экспорте в {{ yds-name }} `target.kinesis.enabled=true`.

## Проверка работы приложения {#check}

1. Настройте в кластере {{ managed-k8s-name }} приложение Kyverno & Kyverno Policies и создайте тестовую политику согласно [инструкции](../../tutorials/marketplace/kyverno.md).
1. [Подключитесь к Policy Reporter UI](https://kyverno.github.io/policy-reporter/#core--policy-reporter-ui--kyverno-plugin) для анализа и визуализации PolicyReports или убедитесь, что данные поступают в {{ objstorage-name }} или {{ yds-name }}.

## Примеры использования {#examples}

* [{#T}](../../tutorials/marketplace/kyverno.md)
* [{#T}](../../tutorials/sign-cr-with-cosign.md)

## См. также {#see-also}

* [Документация Policy Reporter](https://kyverno.github.io/policy-reporter/).
* [Пример в библиотеке решений {{ yandex-cloud }}: Анализ логов безопасности {{ k8s }} в ELK](https://github.com/yandex-cloud-examples/yc-export-mk8s-auditlogs-to-elk/blob/main/README.md).
