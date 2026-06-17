# Установка Kyverno & Kyverno Policies

[Kyverno](https://kyverno.io) — приложение для управления политиками безопасности Kubernetes. Политики безопасности представлены в Kyverno как ресурсы Kubernetes. Kyverno поддерживает инструменты `kubectl`, `git` и `kustomize`. Интерфейс командной строки Kyverno можно использовать для тестирования политик и проверки ресурсов как части конвейера [CI/CD](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd).

[Kyverno policies](https://github.com/kyverno/kyverno/tree/main/charts/kyverno-policies) — расширение для Kyverno. Kyverno policies содержит реализацию Kubernetes [Pod Security Standards (PSS)](https://kubernetes.io/docs/concepts/security/pod-security-standards/). Оригиналы политик загружены в отдельный репозиторий [Kyverno policies](https://github.com/kyverno/policies/tree/main/pod-security).

{% note tip %}

Чтобы выявить уязвимости в работе кластера Kubernetes, используйте приложение [Chaos Mesh](chaos-mesh.md). Нахождение уязвимостей поможет настроить политики безопасности.

{% endnote %}

## Перед началом работы {#before-you-begin}

[Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте](../../../vpc/operations/security-group-add-rule.md) его.

{% note warning %}

От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.

{% endnote %}

## Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [Kyverno & Kyverno Policies](https://yandex.cloud/ru/marketplace/products/yc/kyverno) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:
   * **Пространство имен** — создайте новое [пространство имен](../../concepts/index.md#namespace) (например, `kyverno-space`). Если вы оставите пространство имен по умолчанию, Kyverno может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Включение Kyverno Policies** — выберите, чтобы установить расширение Kyverno Policies.
   * **Pod Security Standard profile** — выберите [профиль Pod Security Standard](https://kubernetes.io/docs/concepts/security/pod-security-standards/):
     * `baseline` — минимально ограничительная политика, которая предотвращает известные превышения привилегий.
     * `restricted` — политика с жесткими ограничениями, соответствующая современным методам защиты подов.
     * `privileged` — политика без ограничений, предоставляющая максимально широкий уровень разрешений.
   * **Validation failure action** — выберите способ реагирования на срабатывания Kyverno:
     * `audit` — режим оповещения.
     * `enforce` — режим блокировки.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Kyverno выполните команду:

   ```bash
   helm pull oci://cr.yandex/yc-marketplace/multi-kyverno \
     --version 1.0.0 \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     multi-kyverno ./multi-kyverno/
   ```

   Если вы укажете в параметре `namespace` пространство имен по умолчанию, Kyverno может работать некорректно. Рекомендуем указывать значение, отличное от всех существующих пространств имен (например, `kyverno-space`).

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

## Версии приложения {#versions}

Для каждой версии Kubernetes поддерживается определенная версия Kyverno. Нужная версия Kyverno устанавливается по умолчанию в зависимости от вашей версии Kubernetes.

|   Версия Kubernetes  | Версия Kyverno |       Документация       |
| -------------------- | -------------- | ------------------------ |
| До 1.21 включительно |       1.6      | [Документация Kyverno 1.6](https://release-1-6-0.kyverno.io/docs/) |
|         1.22         |       1.7      | [Документация Kyverno 1.7](https://release-1-7-0.kyverno.io/docs/) |
|         1.23         |       1.8      | [Документация Kyverno 1.8](https://release-1-8-0.kyverno.io/docs/) |
|      1.24 и выше     |       1.9      | [Документация Kyverno 1.9](https://release-1-9-0.kyverno.io/docs/) |

## Удаление приложения {#uninstall}

Если приложение Kyverno вам больше не нужно, удалите его:

{% list tabs group=instructions %}

- Yandex Cloud Marketplace {#marketplace}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
   1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
   1. Нажмите на имя нужного [кластера Kubernetes](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
   1. В разделе **Установленные приложения**, в строке приложения [Kyverno & Kyverno Policies](https://yandex.cloud/ru/marketplace/products/yc/kyverno), сначала нажмите кнопку ![image](../../../_assets/marketplace/three_dots.png =22x13), затем — **Удалить**.
   1. [Подключитесь к кластеру](../connect/index.md#kubectl-connect) с помощью kubectl.
   1. [Очистите конфигурации веб-хуков приложения](https://release-1-8-0.kyverno.io/docs/installation/#clean-up-webhook-configurations), иначе кластер будет работать некорректно.

- Helm {#helm}

   1. [Подключитесь к кластеру](../connect/index.md#kubectl-connect) с помощью kubectl.
   1. Удалите приложение:

      ```bash
      helm uninstall --namespace <пространство_имен> multi-kyverno ./multi-kyverno/
      ```

   1. [Очистите конфигурации веб-хуков приложения](https://release-1-8-0.kyverno.io/docs/installation/#clean-up-webhook-configurations), иначе кластер будет работать некорректно.

{% endlist %}

## Примеры использования {#examples}

* [Настройка Kyverno & Kyverno Policies](../../tutorials/marketplace/kyverno.md).

## Полезные ссылки {#see-also}

* [Документация Kyverno](https://kyverno.io/docs/).