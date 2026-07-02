[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Политики > Деактивировать политику

# Деактивировать политику

Stackland позволяет выключать уведомления для выбранной политики на заданное время или навсегда с помощью ресурса `ClusterPolicyMute`. Список политик кластера можно получить с помощью команды: `kubectl get ClusterPolicy`.

## Через CLI {#cli}

Чтобы деактивировать политику:

1. Создайте файл ресурса `ClusterPolicyMute`. Например, с помощью команды `touch clusterpolicymute.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    {% cut "Деактивировать политику для пода на время" %}

    Политика `stackland-disallow-host-path` будет деактивирована для пода с названием `debug-pod` в проекте prod до `"2026-01-20T12:00:00Z"`. Причина деактивации: «Требуется доступ к хост-путям для диагностики проблемы в продакшн-среде. Необходимо временно отключить ограничение для отладки». Деактивация инициирована пользователем с почтой `devops@example.com`.

    ```yaml
    apiVersion: policyreporter.kyverno.io/v1alpha1
    kind: ClusterPolicyMute
    metadata:
      name: mute-kyverno-stackland-disallow-host-path-debug-pod-1705315200 # mute-<engine>-<policy>-<resource>-<timestamp>
      labels:
        policy.stackland.io/engine: kyverno
        policy.stackland.io/policy: stackland-disallow-host-path
    spec:
      engine: kyverno
      policyName: stackland-disallow-host-path
      resource:
        kind: Pod
        name: debug-pod
        namespace: prod
      reason: "Требуется доступ к хост-путям для диагностики проблемы в продакшн-среде. Необходимо временно отключить ограничение для отладки"
      expiresAt: "2026-01-20T12:00:00Z"
      createdBy: "devops@example.com"
    ```

    {% endcut %}

    {% cut "Деактивировать политику, используя регулярное выражение" %}

    Политика `stackland-disallow-capabilities` будет деактивирована для всех подов в проекте stage, название которых соответствует регулярному выражению `temp-.*`, до `"2026-02-01T00:00:00Z"`. Причина деактивации: «Деактивировать политику для тестирования на stage». Деактивация инициирована пользователем с почтой `qa-team@example.com`.

    ```yaml
    apiVersion: policyreporter.kyverno.io/v1alpha1
    kind: ClusterPolicyMute
    metadata:
      name: mute-kyverno-stackland-disallow-capabilities-pods-1705315300 # mute-<engine>-<policy>-<resource>-<timestamp>
      labels:
        policy.stackland.io/engine: kyverno
        policy.stackland.io/policy: stackland-disallow-capabilities
    spec:
      engine: kyverno
      policyName: stackland-disallow-capabilities
      resource:
        kind: Pod
        namePattern: "^test-.*"  # Regex: все поды начинающиеся с "test-"
        namespace: stage
      reason: "Деактивировать политику для тестирования на stage"
      expiresAt: "2026-02-01T00:00:00Z"
      createdBy: "qa-team@example.com"
    ```

    {% endcut %}

    {% cut "Полностью отключить политику" %}

    Политика `stackland-disallow-host-path` будет полностью отключена для объекта Deployment с названием `legacy-storage-deployment` в проекте data-storage. Причина деактивации: «Для работы устаревшей системы хранения данных требуется доступ к хост-путям. Отключение политики необходимо для обеспечения совместимости и корректной работы приложения». Деактивация инициирована пользователем с почтой `security@example.com`.

    ```yaml
    apiVersion: policyreporter.kyverno.io/v1alpha1
    kind: ClusterPolicyMute
    metadata:
      name: mute-kyverno-stackland-disallow-host-path-legacy-storage-deployment-1705315400 # mute-<engine>-<policy>-<resource>-<timestamp>
      labels:
        policy.stackland.io/engine: kyverno
        policy.stackland.io/policy: stackland-disallow-host-path
    spec:
      engine: kyverno
      policyName: stackland-disallow-host-path
      resource:
        kind: Deployment
        name: legacy-storage-deployment
        namespace: data-storage
      reason: "Для работы устаревшей системы хранения данных требуется доступ к хост-путям. Отключение политики необходимо для обеспечения совместимости и корректной работы приложения"
      # expiresAt отсутствует
      createdBy: "security@example.com"
    ```

    {% endcut %}

1. Примените манифест: `kubectl apply -f clusterpolicymute.yaml`.

## Через консоль управления {#console}

1. В левом меню выберите **Политики безопасности**.
1. Перейдите на вкладку **Мьюты**.
1. Нажмите **Создать мьют**.
1. Заполните поля:

    * **Имя** — название мьюта. Только строчные буквы, цифры и дефисы.
    * **Движок** — выберите движок из списка доступных.
    * **Политика** — выберите политику, для которой нужно деактивировать уведомления.
    * **Тип ресурса** — выберите тип ресурса Kubernetes (например, Pod, Deployment).
    * **Имя ресурса** — укажите название ресурса или используйте паттерн для применения мьюта к нескольким ресурсам.
    * **Проект** — выберите проект, в котором находится ресурс. Можно использовать паттерн для применения к нескольким проектам.
    * **Причина** — укажите причину деактивации политики.
    * **Истекает** — выберите период действия мьюта:
        * **День** — мьют будет действовать один день.
        * **Неделя** — мьют будет действовать одну неделю.
        * **Месяц** — мьют будет действовать один месяц.
        * **Своя дата** — укажите конкретную дату и время истечения мьюта.
        * **Без срока действия** — установите флажок, чтобы деактивировать политику навсегда.

1. Нажмите **Создать**.

Готово, уведомления о нарушении политики будут выключены на время или навсегда.