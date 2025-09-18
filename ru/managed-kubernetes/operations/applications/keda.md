---
title: Установка KEDA с поддержкой {{ monitoring-full-name }}
description: Следуя данной инструкции, вы сможете установить KEDA с поддержкой {{ monitoring-name }}.
---

# Установка KEDA с поддержкой {{ monitoring-full-name }}


[KEDA](https://keda.sh) — приложение, которое выполняет автомасштабирование ресурсов {{ k8s }} на основе мониторинга нагрузки.

Приложение KEDA:

* Интегрирует автомасштабирование {{ k8s }} с {{ monitoring-full-name }}.
* Позволяет масштабировать приложения на основе метрик из {{ monitoring-name }}, например метрик {{ alb-name }} или управляемых баз данных.
* Поддерживает настройку временных окон, агрегирование и обработку `NaN`-значений.

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md):

   ```bash
   yc iam service-account create --name keda-sa
   ```

1. [Назначьте роль](../../../iam/operations/roles/grant.md) `monitoring.viewer` сервисному аккаунту, созданному ранее:

   ```bash
   yc resource-manager folder add-access-binding \
     --id <идентификатор_каталога> \
     --service-account-name keda-sa \
     --role monitoring.viewer
   ```

   Идентификатор каталога можно получить [со списком каталогов](../../../resource-manager/operations/folder/get-id.md).

1. [Создайте авторизованный ключ](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для сервисного аккаунта, созданного ранее, и сохраните его в файл `authorized-key.json`:

   ```bash
   yc iam key create \
     --service-account-name keda-sa \
     --output authorized-key.json
   ```

1. {% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

    {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [KEDA с поддержкой {{ monitoring-full-name }}](/marketplace/products/yc/keda) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) `keda-system`. Если вы оставите пространство имен по умолчанию, KEDA может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Ключ сервисного аккаунта** — скопируйте в это поле содержимое файла `authorized-key.json`.

1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.
1. Создайте ресурс `ScaledObject` с настройками автомасштабирования ресурсов:

   ```yaml
   apiVersion: keda.sh/v1alpha1
   kind: ScaledObject
   metadata:
     name: <имя_ресурса>
   spec:
     scaleTargetRef:
       name: <имя_ресурса_для_автомасштабирования>
     pollingInterval: <интервал_проверки_событий_мониторинга>
     cooldownPeriod: <период_ожидания_после_события>
     minReplicaCount: <минимальное_количество_реплик_для_автомасштабирования>
     maxReplicaCount: <максимальное_количество_реплик_для_автомасштабирования>
     triggers:
     - type: external
       metadata:
         scalerAddress: keda-external-scaler-yc.keda-system.svc.cluster.local:8080
         query: <запрос_метрики_Yandex_Monitoring>
         folderId: "<идентификатор_каталога>"
         targetValue: "<целевое_значение_метрики>"
         downsampling.disabled: <включить_режим_прореживания_данных>
         downsampling.gridAggregation: "<функция_агрегации_данных>"
         downsampling.gridInterval: "<ширина_временного_окна_прореживания>"
         downsampling.maxPoints: <максимальное_количество_точек>
         downsampling.gapFilling: <заполнение_данных>

         timeWindow: "<окно_временного_интервала>"
         timeWindowOffset: "<отступ_временного_окна>"
    
         logLevel: "<уровень_логирования>"
         logMetrics: "<разрешить_логирование_запросов_{{ monitoring-name}}>"
         logAggregation: "<разрешить_логирование_агрегации_данных>"
   ```

   Обязательные метаданные в поле `triggers`:

   * `scalerAddress` — адрес сервиса автомасштабирования. Всегда `keda-external-scaler-yc.keda-system.svc.cluster.local:8080`.
   * `query` — запрос метрики {{ monitoring-name }}.
   * `folderId` — [идентификатор каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать провайдер.
   * `targetValue` — целевое значение метрики, при превышении которого добавляется под для реплики.

   Параметры прореживания (`downsampling`). Для работы автомасштабирования нужно выбрать хотя бы один из параметров:
   * `downsampling.gridAggregation` — [функция агрегации](../../../monitoring/concepts/querying.md#combine-functions) данных. Возможные значения: `MAX`, `MIN`, `SUM`, `AVG`, `LAST`, `COUNT`. Значение по умолчанию — `AVG`.
   * `downsampling.gapFilling` — настройки заполнения пропусков в данных:
     * `NULL` — возвращает `null` в качестве значения метрики и `timestamp` в качестве временной метки.
     * `NONE` — не возвращает значений.
     * `PREVIOUS` — возвращает значение из предыдущей точки.
   * `downsampling.maxPoints` — максимальное количество точек, которое будет получено в ответе на запрос. Значение параметра должно быть больше `10`.
   * `downsampling.gridInterval` — ширина временного окна (сетки) в миллисекундах. Используется для прореживания: точки внутри окна объединяются в одну при помощи функции агрегации. Значение параметра должно быть больше `0`.
   * `downsampling.disabled` — отключение прореживания данных. Возможные значения: `true` или `false`.

     {% note info %}

     Используйте только один из параметров `downsampling.maxPoints`, `downsampling.gridInterval` или `downsampling.disabled`. Подробнее о параметрах прореживания см. в [документации API](../../../monitoring/api-ref/MetricsData/read.md).

     {% endnote %}

   Параметры временного окна:
   * `timeWindow` — временной период, в котором рассчитывается функция агрегации (в формате `DdHhMmSs`, например `5d10h30m20s`).
   * `timeWindowOffset` — задержка вычисления функции во временном окне.

   Параметры логирования:
   * `logLevel` — уровень логирования. Возможные значения: `debug`, `info`, `warn`, `error`, `none`. Значение по умолчанию — `info`.
   * `logMetrics` — разрешить логирование запросов {{ monitoring-name }}: `true` или `false`. Значение по умолчанию — `false`.
   * `logAggregation` — разрешить логирование агрегации данных: `true` или `false`. Значение по умолчанию — `false`.

   Подробнее о параметрах ресурса `ScaledObject` см. в [документации проекта на Github](https://github.com/yandex-cloud/yc-keda-external-scaler).

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с KEDA выполните команду:

   ```bash
   helm pull oci://{{ mkt-k8s-key.yc_keda.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_keda.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace keda-system \
     --create-namespace \
     --set-file secret.data=./authorized-key.json \
     --set keda.enabled=true \
     keda ./keda
   ```

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, KEDA может работать некорректно.

   {% include [Support OCI](../../../_includes/managed-kubernetes/note-helm-experimental-oci.md) %}

## Пример использования приложения {#keda-usage}

1. Разверните приложение `nginx` в кластере {{ managed-k8s-name }}.
1. Установите приложение [ALB Ingress Controller](alb-ingress-controller.md) и ресурс `Ingress` для приложения `nginx`.
1. Создайте ресурс `ScaledObject` с настройками автомасштабирования подов веб-приложения по метрикам {{ alb-name }}:

   ```yaml
   apiVersion: keda.sh/v1alpha1
   kind: ScaledObject
   metadata:
     name: demo-app-scaler
   spec:
     scaleTargetRef:
       name: <имя_ресурса_Deployment>
     pollingInterval: 30
     cooldownPeriod: 60
     minReplicaCount: 1
     maxReplicaCount: 20
     triggers:
     - type: external
       metadata:
         scalerAddress: keda-external-scaler-yc.keda-system.svc.cluster.local:8080
         query: |
          alias(replace_nan(series_sum("load_balancer.requests_count_per_second"{
          service="application-load-balancer", 
          load_balancer="<идентификатор_балансировщика>", 
          http_router="*", virtual_host="*", 
          route="<идентификатор_маршрута>", 
          backend_group="*", backend="*", 
          zone="*", code="total"}), 0), "Total requests count")
         folderId: "<идентификатор_каталога>"
         targetValue: "<целевое_значение_метрики>"
         downsampling.gridAggregation: "AVG"
         downsampling.gridInterval: "120000"

         timeWindow: "2m"
         timeWindowOffset: "30s"
    
         logLevel: "debug"
         logMetrics: "true"
         logAggregation: "true"
   ```

## См. также {#see-also}

* [Документация KEDA](https://keda.sh/docs/).
* [KEDA с поддержкой {{ monitoring-full-name }} на GitHub](https://github.com/yandex-cloud/yc-keda-external-scaler).
