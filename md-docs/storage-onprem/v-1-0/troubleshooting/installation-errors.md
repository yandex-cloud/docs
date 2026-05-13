# Устранение неисправностей при установке

В редких случаях при установке On-premises Yandex Object Storage оператор может завершиться с ошибкой на одном из шагов. Для устранения проблемы необходимо определить причину сбоя, исправить ее и возобновить установку.

Порядок действий при возникновении ошибки во время установки:

1. Перейдите на мастер-узел кластера Kubernetes.
1. Узнайте статусы `update requests` с помощью команды:

    ```bash
    cd /opt/kubernetes; make show-status
    ```

    Результат:

    ```text
    NAME                   STATUS
    bootstrap-head-7bni5   Done
    install-head-h6oqh     Failed
    ```

1. Посмотрите описание `update request` со статусом `Failed` с помощью команды:

    ```bash
    kubectl describe updaterequests <имя_update_request>
    ```

    Результат:

    ```text
    Name:         install-head-h6oqh
    Namespace:
    Labels:       <none>
    Annotations:  <none>
    API Version:  storage.yandex.cloud/v1alpha1
    Kind:         UpdateRequest
    ...
      Index:             7
        Message:           Step completed successfully
        Status:            Done
        Apps:
          Last Sync Time:  2026-02-11T15:26:21Z
          Message:         App is healthy and synced
          Name:            argocd/trash
          Retries Left:    10
          Status:          Done
          Last Sync Time:  2026-02-11T15:26:21Z
          Message:         App is healthy and synced
          Name:            argocd/nscfg
          Retries Left:    10
          Status:          Done
          Last Sync Time:  2026-02-11T15:26:22Z
          Message:         App is healthy and synced
          Name:            argocd/minio-tenant
          Retries Left:    10
          Status:          Done
          Message:         App not found but optional, skipped
          Name:            argocd/psmdb-mastermind
          Retries Left:    0
          Status:          Done
        Index:             8
        Message:           Step completed successfully
        Status:            Done
        Apps:
          Last Sync Time:  2026-02-11T16:01:44Z
          Message:         App is stuck (OutOfSync but operation succeeded) - Operation: Succeeded (successfully synced (no more tasks)), Sync: OutOfSync, Health: Healthy
          Name:            argocd/elliptics
          Retries Left:    0
          Status:          Failed
          Last Sync Time:  2026-02-11T15:31:07Z
          Message:         App is healthy and synced
          Name:            argocd/mastermind
          Retries Left:    10
          Status:          Done
    ```

    В данном примере проблема с приложением [Elliptics](../concepts/architecture/elliptics.md) (статус `Failed` в разделе `Apps`).

1. Посмотрите состояние приложения:

    ```bash
    kubectl describe application <имя_приложения> -n argocd
    ```

1. Посмотрите состояние проблемного компонента:

    ```bash
    kubectl (get|describe) (pods|jobs|ds|etc) -n <имя_приложения>-<имя_компонента>
    ```

1. После устранения проблемы с компонентом продолжите установку, выполнив команду:

    ```bash
    kubectl annotate updaterequests <имя_update_request> updates.storage.yandex.cloud/resume=1
    ```

Если самостоятельно устранить проблему не удалось, обратитесь в [техническую поддержку](../quickstart.md#support).