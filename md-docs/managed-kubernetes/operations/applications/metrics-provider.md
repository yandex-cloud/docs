# Установка Metrics Provider

Metrics Provider транслирует метрики объектов [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster) в системы мониторинга и [системы автоматического масштабирования](../../concepts/autoscale.md). Метрики можно транслировать и в обратную сторону: например, объекты кластера могут получать метрики сервиса [Yandex Monitoring](../../../monitoring/concepts/index.md).

Провайдер преобразует запрос на получение внешних метрик от объекта кластера Managed Service for Kubernetes в нужный Monitoring формат, а также выполняет обратное преобразование — от Monitoring до объекта кластера.

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с [ролью](../../../iam/concepts/access-control/roles.md) `monitoring.viewer`.
1. [Создайте авторизованный ключ доступа](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) в формате JSON и сохраните его в файл `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name=<имя_сервисного_аккаунта> \
     --output=sa-key.json
   ```

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../../vpc/operations/security-group-add-rule.md).

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного кластера Managed Service for Kubernetes и выберите вкладку **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [Metrics Provider](https://yandex.cloud/ru/marketplace/products/yc/metric-provider) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `metrics-provider-space`). Если вы оставите пространство имен по умолчанию, Metrics Provider может работать некорректно.
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
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. Добавьте репозиторий `metric-provider`:

   ```bash
   cat sa-key.json | helm registry login cr.yandex --username 'json_key' --password-stdin && \
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/metric-provider/chart/metric-provider \
     --version 0.1.13 \
     --untar
   ```

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, Metrics Provider может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `metrics-provider-space`).

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

1. Настройте и установите Metrics Provider:

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

* [Metrics Provider для автомасштабирования Managed Service for Kubernetes](../../tutorials/load-testing-grpc-autoscaling.md).
* [Использование Metrics Provider для трансляции метрик](../../tutorials/marketplace/metrics-provider.md).