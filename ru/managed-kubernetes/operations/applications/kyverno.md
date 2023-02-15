# Установка Kyverno & Kyverno Policies

[Kyverno](https://kyverno.io) — приложение для управления политиками безопасности {{ k8s }}. Политики безопасности представлены в Kyverno как ресурсы {{ k8s }}. Kyverno поддерживает инструменты `kubectl`, `git` и `kustomize`. Интерфейс командной строки Kyverno можно использовать для тестирования политик и проверки ресурсов как части конвейера [CI/CD](/blog/posts/2022/10/ci-cd).

[Kyverno policies](https://github.com/kyverno/kyverno/tree/main/charts/kyverno-policies) — расширение для Kyverno. Kyverno policies содержит реализацию {{ k8s }} [Pod Security Standards (PSS)](https://kubernetes.io/docs/concepts/security/pod-security-standards/). Оригиналы политик загружены в отдельный репозиторий [Kyverno policies](https://github.com/kyverno/policies/tree/main/pod-security).

Отправлять оповещения из Kyverno в другие системы можно с помощью расширения [Policy reporter](/marketplace/products/yc/policy-reporter).

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного [кластера {{ k8s }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/marketplace.svg) **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [Kyverno & Kyverno Policies](/marketplace/products/yc/kyverno) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для Kyverno или создайте новое.
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

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Kyverno выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/marketplace/charts/kyverno \
     --version <версия Helm-чарта> \
     --untar && \
   helm install \
     --namespace <пространство имен> \
     --create-namespace \
     kyverno ./kyverno/
   ```

   Актуальную версию Helm-чарта можно посмотреть на [странице приложения](/marketplace/products/yc/kyverno#docker-images).

## См. также {#see-also}

* [Документация Kyverno](https://kyverno.io/docs/).