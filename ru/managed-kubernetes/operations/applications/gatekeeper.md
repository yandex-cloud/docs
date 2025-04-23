# Установка Gatekeeper

[Gatekeeper](https://open-policy-agent.github.io/gatekeeper/website/) — настраиваемый контроллер и аудитор [политик](../../concepts/network-policy.md) для {{ k8s }}. Gatekeeper принимает поступающие в кластер запросы и в реальном времени проверяет их на соответствие предварительно настроенным политикам.

## Перед началом работы {#before-you-begin}

{% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

{% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.

1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.

1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Gatekeeper](https://yandex.cloud/ru/marketplace/products/yc/gatekeeper) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.

1. Задайте настройки приложения:
    * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `gatekeeper-space`). Если вы оставите пространство имен по умолчанию, Gatekeeper может работать некорректно.
    * **Название приложения** — укажите название приложения.
    * **Интервал между аудитами** — задайте время в секундах между запусками аудитов. Значение `0` отключает выполнение аудитов.
    * **Лимит нарушений ограничения** — укажите максимальное количество нарушений, которое будет фиксироваться для каждого ограничения.
    * **Только совпадающие типы ресурсов** — выберите эту опцию, если для каждого ограничения нужно проверять только те типы ресурсов {{ k8s }}, которые указаны в ограничении в явном виде. Если типы ресурсов не указаны или опция выключена, будут проверяться все ресурсы.
    * **Создавать события при аудите** — выберите эту опцию, если для каждого выявленного при аудите нарушения ограничения нужно создавать событие (Kubernetes event) с подробной информацией о нарушении.
    * **События в затронутом пространстве имен** — выберите эту опцию, если события с подробной информацией о нарушении нужно создавать в том пространстве имен, где было зафиксировано нарушение ограничения. Применимо только при включенной опции **Создавать события при аудите**.
    
      Если опция **События в затронутом пространстве имен** выключена, события будут создаваться в пространстве имен, в котором установлен Gatekeeper.

    * **Разрешить внешние данные** — выберите эту опцию, если нужно включить экспериментальную поддержку внешних источников данных.

1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.

1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Gatekeeper выполните команду:
  
    ```bash
    helm pull oci://{{ mkt-k8s-key.yc_gatekeeper.helmChart.name }} \
      --version {{ mkt-k8s-key.yc_gatekeeper.helmChart.tag }} \
      --untar && \
    helm install \
      --namespace <пространство_имен> \
      --create-namespace \
      gatekeeper ./gatekeeper/
    ```

  Если вы укажете в параметре `namespace` пространство имен по умолчанию, Gatekeeper может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `gatekeeper-space`).

  Необязательные параметры можно переопределить в команде установки с помощью ключа `--set <имя_параметра>=<новое_значение>`.

  Список доступных для переопределения параметров и их значения по умолчанию приведены в таблице:

  Имя параметра | Описание | Значение по умолчанию
  --- | --- | ---
  `auditInterval` | Время в секундах между запусками аудитов | `60`
  `constraintViolationsLimit` | Максимальное количество нарушений, которое будет фиксироваться для каждого ограничения | `20`
  `auditMatchKindOnly` | Только совпадающие типы ресурсов | `false`
  `emitAuditEvents` | Создавать события при аудите | `false`
  `auditEventsInvolvedNamespace` | Создавать события в затронутом пространстве имен | `false`
  `enableExternalData` | Экспериментальная поддержка внешних источников данных | `true`

## См. также {#see-also}

* [Документация Gatekeeper](https://open-policy-agent.github.io/gatekeeper/website/docs/)

* [Библиотека политик Gatekeeper](https://open-policy-agent.github.io/gatekeeper-library/website/)

