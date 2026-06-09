# Установка {{ MP }}

{{ MP }} транслирует метрики объектов [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) в системы мониторинга и [системы автоматического масштабирования](../../concepts/autoscale.md). Метрики можно транслировать и в обратную сторону: например, объекты кластера могут получать метрики сервиса [{{ monitoring-full-name }}](../../../monitoring/concepts/index.md).

Провайдер преобразует запрос на получение внешних метрик от объекта кластера {{ managed-k8s-name }} в нужный {{ monitoring-name }} формат, а также выполняет обратное преобразование — от {{ monitoring-name }} до объекта кластера.

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с [ролью](../../../iam/concepts/access-control/roles.md) `monitoring.viewer`.
1. [Создайте авторизованный ключ доступа](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) в формате JSON и сохраните его в файл `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name=<имя_сервисного_аккаунта> \
     --output=sa-key.json
   ```

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера {{ managed-k8s-name }} и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. В [консоли управления]({{ link-console-main }}) выберите каталог.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного кластера {{ managed-k8s-name }} и выберите вкладку **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [{{ MP }}](https://yandex.cloud/ru/marketplace/products/yc/metric-provider) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `metrics-provider-space`). Если вы оставите пространство имен по умолчанию, {{ MP }} может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Идентификатор каталога** — укажите [идентификатор каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать {{ MP }}.
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
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. Добавьте репозиторий `metric-provider`:

   ```bash
   cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
   helm pull oci://{{ mkt-k8s-key.yc_metric-provider.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_metric-provider.helmChart.tag }} \
     --untar
   ```

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, {{ MP }} может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `metrics-provider-space`).

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

1. Настройте и установите {{ MP }}:

   ```bash
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     --set yandexMetrics.folderId=<идентификатор_каталога> \
     --set window=<ширина_временного_окна> \
     --set-file yandexMetrics.token.serviceAccountJson=<путь_к_файлу_с_авторизованным_ключом_сервисного_аккаунта> \
     --set yandexMetrics.downsampling.gridAggregation=<функция_агрегации> \
     --set yandexMetrics.downsampling.gapFilling=<заполнение_данных> \
     --set yandexMetrics.downsampling.maxPoints=<максимальное_количество_точек> \
     --set yandexMetrics.downsampling.gridInterval=<ширина_временного_окна_прореживания> \
     --set yandexMetrics.downsampling.disabled=<режим_прореживания_данных> \
     metric-provider ./metric-provider/
   ```

   Обязательные параметры:
   * `--namespace` — [пространство имен](../../concepts/index.md#namespace), где будет развернут провайдер.
   * `yandexMetrics.folderId` — [идентификатор каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать провайдер.
   * `window` — ширина временного окна, за которую будут собираться метрики (в формате `DdHhMmSs`, например `5d10h30m20s`).
   * `yandexMetrics.token.serviceAccountJson` — путь к файлу с авторизованным ключом сервисного аккаунта с ролью `monitoring.viewer`.

   Параметры прореживания (`downsampling`). Для работы провайдера нужно выбрать хотя бы один из параметров:
   * `yandexMetrics.downsampling.gridAggregation` — [функция агрегации](../../../monitoring/concepts/querying.md#combine-functions) данных. Значение по умолчанию — `AVG`.
   * `yandexMetrics.downsampling.gapFilling` — настройки заполнения пропусков в данных:
     * `NULL` — возвращает `null` в качестве значения метрики и `timestamp` в качестве временной метки.
     * `NONE` — не возвращает значений.
     * `PREVIOUS` — возвращает значение из предыдущей точки.
   * `yandexMetrics.downsampling.maxPoints` — максимальное количество точек, которое будет получено в ответе на запрос. Значение параметра должно быть больше `10`.
   * `yandexMetrics.downsampling.gridInterval` — ширину временного окна (сетки) в миллисекундах. Используется для прореживания: точки внутри окна объединяются в одну при помощи функции агрегации. Значение параметра должно быть больше `0`.
   * `yandexMetrics.downsampling.disabled` — отключение прореживания данных. Возможные значения: `true` или `false`.

     {% note info %}

     Используйте только один из параметров `yandexMetrics.downsampling.maxPoints`, `yandexMetrics.downsampling.gridInterval` или `yandexMetrics.downsampling.disabled`. Подробнее о параметрах прореживания см. в [документации API](../../../monitoring/api-ref/MetricsData/read.md).

     {% endnote %}

## Примеры использования {#examples}

* [{{ MP }} для автомасштабирования {{ managed-k8s-name }}](../../tutorials/load-testing-grpc-autoscaling.md).
* [{#T}](../../tutorials/marketplace/metrics-provider.md).