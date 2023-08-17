# Установка Metrics Provider

Metrics Provider — связующий элемент между объектом в кластере {{ managed-k8s-name }} и сервисом [{{ monitoring-full-name }}](../../../monitoring/concepts/index.md).

Провайдер преобразует запрос на получение внешних метрик от объекта в кластере {{ k8s }} в нужный {{ monitoring-name }} формат, а также выполняет обратное преобразование — от {{ monitoring-name }} до объекта кластера.

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с ролью `monitoring.viewer`.
1. [Создайте авторизованный ключ доступа](../../../iam/operations/authorized-key/create.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) в формате JSON и сохраните его в файл `sa-key.json`:

   ```bash
   yc iam key create \
      --service-account-name=<имя сервисного аккаунта> \
      --output=sa-key.json
   ```

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на страницу каталога и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [Metrics Provider](/marketplace/products/yc/metric-provider) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) или создайте новое.
   * **Название приложения** — укажите название приложения.
   * **Идентификатор каталога** — укажите [идентификатор каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать Metrics Provider.
   * **Ширина временного окна** — укажите ширину временного окна, за которую будут собираться метрики (в формате `DdHhMmSs`, например, `5d10h30m20s`).
   * (Опционально) **Отключение прореживания** — выберите эту опцию, чтобы не применять к данным [функцию прореживания](../../../monitoring/concepts/decimation.md).
   * (Опционально) **Функция агрегации** — выберите [функцию агрегации](../../../monitoring/concepts/querying.md#combine-functions) данных. Значение по умолчанию — `AVG`.
   * (Опционально) **Заполнение данных** — выберите настройки заполнения пропусков в данных:
     * `NULL` — возвращает `null` в качестве значения метрики и `timestamp` в качестве временной метки. Значение по умолчанию.
     * `NONE` — не возвращает значений.
     * `PREVIOUS` — возвращает значение из предыдущей точки.
   * (Опционально) **Максимальное количество точек** — укажите максимальное количество точек, которое будет получено в ответе на запрос. Значение параметра должно быть больше `10`.
   * (Опционально) **Ширина временного окна прореживания** — укажите ширину временного окна (сетки) в миллисекундах. Используется для прореживания: точки внутри окна объединяются в одну при помощи функции агрегации. Значение параметра должно быть больше `0`.

     {% note info %}

     Выберите только одну из настроек **Максимальное количество точек** или **Ширина временного окна прореживания**. Чтобы не использовать эти настройки, оставьте оба поля пустыми. Подробнее см. в [документации API](../../../monitoring/api-ref/MetricsData/read.md).

     {% endnote %}

   * **Secret Key** — скопируйте содержимое файла `sa-key.json` или создайте новый ключ доступа для сервисного аккаунта. Сервисный аккаунт должен иметь роль `monitoring.viewer`.
1. Нажмите кнопку **Установить**.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [install-kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Добавьте репозиторий `metric-provider`:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ mkt-k8s-key.yc_metric-provider.helmChart.name }} \
     --version={{ mkt-k8s-key.yc_metric-provider.helmChart.tag }} \
     --untar
   ```

1. Настройте и установите Metrics Provider:

   ```bash
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set yandexMetrics.folderId=<идентификатор_каталога> \
     --set window=<ширина_временного_окна> \
     --set-file yandexMetrics.token.serviceAccountJson=<путь_к_файлу_со_статическим_ключом_сервисного_аккаунта> \
     --set yandexMetrics.downsampling.gridAggregation=<функция_агрегации> \
     --set yandexMetrics.downsampling.gapFilling=<заполнение_данных> \
     --set yandexMetrics.downsampling.maxPoints=<максимальное_количество_точек> \
     --set yandexMetrics.downsampling.gridInterval=<ширина_временного_окна_прореживания> \
     --set yandexMetrics.downsampling.disabled=<true_или_false> \
     metric-provider ./chart/
   ```

   Обязательные параметры:
   * `namespace` — [пространство имен](../../concepts/index.md#namespace), где будет развернут провайдер.
   * `yandexMetrics.folderId` — [идентификатор каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать провайдер.
   * `window` — ширина временного окна, за которую будут собираться метрики (в формате `DdHhMmSs`, например `5d10h30m20s`).
   * `yandexMetrics.token.serviceAccountJson` — путь к файлу со статическим ключом сервисного аккаунта с ролью `monitoring.viewer`.

   Параметры прореживания (`downsampling`). Для работы провайдера нужно выбрать хотя бы один из параметров:
   * `yandexMetrics.downsampling.gridAggregation` — [функция агрегации](../../../monitoring/concepts/querying.md#combine-functions) данных. Значение по умолчанию — `AVG`.
   * `yandexMetrics.downsampling.gapFilling` — настройки заполнения пропусков в данных:
     * `NULL` — возвращает `null` в качестве значения метрики и `timestamp` в качестве временной метки.
     * `NONE` — не возвращает значений.
     * `PREVIOUS` — возвращает значение из предыдущей точки.
   * `yandexMetrics.downsampling.maxPoints` — максимальное количество точек, которое будет получено в ответе на запрос. Значение параметра должно быть больше `10`.
   * `yandexMetrics.downsampling.gridInterval` — ширину временного окна (сетки) в миллисекундах. Используется для прореживания: точки внутри окна объединяются в одну при помощи функции агрегации. Значение параметра должно быть больше `0`.
   * `yandexMetrics.downsampling.disabled` — отключение прореживания данных.

     {% note info %}

     Используйте только один из параметров `yandexMetrics.downsampling.maxPoints`, `yandexMetrics.downsampling.gridInterval` или `yandexMetrics.downsampling.disabled`. Подробнее о параметрах прореживания см. в [документации API](../../../monitoring/api-ref/MetricsData/read.md).

     {% endnote %}

## Примеры использования {#examples}

* [Metrics Provider для автомасштабирования {{ managed-k8s-name }}](../../tutorials/load-testing-grpc-autoscaling.md).