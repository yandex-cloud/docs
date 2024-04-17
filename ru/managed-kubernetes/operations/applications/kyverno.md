# Установка Kyverno & Kyverno Policies


[Kyverno](https://kyverno.io) — приложение для управления политиками безопасности {{ k8s }}. Политики безопасности представлены в Kyverno как ресурсы {{ k8s }}. Kyverno поддерживает инструменты `kubectl`, `git` и `kustomize`. Интерфейс командной строки Kyverno можно использовать для тестирования политик и проверки ресурсов как части конвейера [CI/CD](/blog/posts/2022/10/ci-cd).

[Kyverno policies](https://github.com/kyverno/kyverno/tree/main/charts/kyverno-policies) — расширение для Kyverno. Kyverno policies содержит реализацию {{ k8s }} [Pod Security Standards (PSS)](https://kubernetes.io/docs/concepts/security/pod-security-standards/). Оригиналы политик загружены в отдельный репозиторий [Kyverno policies](https://github.com/kyverno/policies/tree/main/pod-security).

Отправлять оповещения из Kyverno в другие системы можно с помощью расширения [Policy reporter](/marketplace/products/yc/policy-reporter).

{% note tip %}

Чтобы выявить уязвимости в работе кластера {{ k8s }}, используйте приложение [Chaos Mesh](chaos-mesh.md). Нахождение уязвимостей поможет настроить политики безопасности.

{% endnote %}

## Перед началом работы {#before-you-begin}

{% include [check-sg-prerequsites](../../../_includes/managed-kubernetes/security-groups/check-sg-prerequsites-lvl3.md) %}

{% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

## Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **Доступные для установки приложения** выберите [Kyverno & Kyverno Policies](/marketplace/products/yc/kyverno) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_use }}**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) для Kyverno или создайте новое. В нем не должны находиться какие-либо приложения или объекты, иначе Kyverno будет работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Включение Kyverno Policies** — выберите, чтобы установить расширение Kyverno Policies.
   * **Pod Security Standard profile** — выберите [профиль Pod Security Standard](https://kubernetes.io/docs/concepts/security/pod-security-standards/):
     * `baseline` — минимально ограничительная политика, которая предотвращает известные превышения привилегий.
     * `restricted` — политика с жесткими ограничениями, соответствующая современным методам защиты подов.
     * `privileged` — политика без ограничений, предоставляющая максимально широкий уровень разрешений.
   * **Validation failure action** — выберите способ реагирования на срабатывания Kyverno:
     * `audit` — режим оповещения.
     * `enforce` — режим блокировки.
1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `{{ ui-key.yacloud.k8s.cluster.marketplace.label_release-status-DEPLOYED }}`.

## Установка с помощью Helm-чарта {#helm-install}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. {% include [Настройка kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с Kyverno выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ mkt-k8s-key.yc_kyverno.helmChart.name }} \
     --version {{ mkt-k8s-key.yc_kyverno.helmChart.tag }} \
     --untar && \
   helm install \
     --namespace <пространство_имен> \
     --create-namespace \
     kyverno ./kyverno/
   ```

   Выберите пространство имен, в котором нет каких-либо приложений или объектов, иначе Kyverno будет работать некорректно.

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

- {{ marketplace-full-name }} {#marketplace}

   1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Нажмите на имя нужного [кластера {{ k8s }}](../../concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
   1. В разделе **{{ ui-key.yacloud.k8s.cluster.marketplace.section_releases }}**, в строке приложения [Kyverno & Kyverno Policies](/marketplace/products/yc/kyverno), сначала нажмите кнопку ![image](../../../_assets/marketplace/three_dots.png =22x13), затем — **{{ ui-key.yacloud.k8s.cluster.marketplace.button_release-uninstall }}**.
   1. [Подключитесь к кластеру](../connect/index.md#kubectl-connect) с помощью kubectl.
   1. [Очистите конфигурации веб-хуков приложения](https://release-1-8-0.kyverno.io/docs/installation/#clean-up-webhook-configurations), иначе кластер будет работать некорректно.

- Helm {#helm}

   1. [Подключитесь к кластеру](../connect/index.md#kubectl-connect) с помощью kubectl.
   1. Удалите приложение:

      ```bash
      helm uninstall --namespace <пространство_имен> kyverno ./kyverno/
      ```

   1. [Очистите конфигурации веб-хуков приложения](https://release-1-8-0.kyverno.io/docs/installation/#clean-up-webhook-configurations), иначе кластер будет работать некорректно.

{% endlist %}

## См. также {#see-also}

* [Документация Kyverno](https://kyverno.io/docs/).
