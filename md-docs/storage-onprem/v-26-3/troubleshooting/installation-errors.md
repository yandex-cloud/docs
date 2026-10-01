[Документация Yandex Cloud](../../../index.md) > [On-premises Yandex Object Storage](../../index.md) > Версия 26.3 > Установка и настройка > Устранение неисправностей при установке

# Устранение неисправностей при установке

Ошибка может возникнуть при выполнении плейбука Ansible или позднее, когда оператор устанавливает компоненты внутри кластера Kubernetes.

## Ошибки плейбука Ansible {#ansible-errors}

В выводе Ansible найдите задачу с результатом `FAILED` и хост, на котором она завершилась с ошибкой. После исправления причины [продолжите установку с нужного шага](../install/installation-steps.md#tags).

Типовые ошибки и способы их устранения:

#|
|| **Ошибка или симптом** | **Действия** ||
|| На шаге 1 файл `vault.yaml` или `vault_yav.yaml` уже существует и не пуст. | Для продолжения с существующими секретами добавьте к команде установки `--skip-tags step1`. Перегенерация секретов описана [ниже](#replace-secrets). ||
|| На шаге 1: `openssl: command not found`. | Установите OpenSSL версии 3 или выше на установочном хосте. ||
|| На шаге 6: `Available HDD candidates: NONE`. | На проблемном хосте выполните `lsblk -d -o NAME,ROTA,TYPE` и проверьте, что HDD видны системе. Уже смонтированные в `/srv/*` диски и диски в составе MD RAID исключаются из подготовки. ||
|| На шагах 7–9: `No rule to make target 'new-cluster'`, аналогичная ошибка для `new-master` или `new-node`. | Убедитесь, что настройка хостов и распаковка архива завершились успешно: на хосте должен быть `/opt/kubernetes/Makefile`. При необходимости повторите шаги с тегами `hosts` и `release`. ||
|| На шаге 10 узлы не переходят в статус `Ready`. | На первом мастер-хосте проверьте поды: `kubectl get pods -n calico-system`. На проблемном хосте проверьте журнал kubelet: `journalctl -u kubelet -n 50`. ||
|| На шагах 11–13: `LVM volume group 'topolvm' is missing on host`. | На указанном хосте [создайте группу томов `topolvm`](../install/environment-preparation.md#metadata-disks). Плейбук не создает ее автоматически. ||
|| На шаге 11 истекло время ожидания трех готовых реплик `argocd-redis-ha-server`. | На первом мастер-хосте проверьте готовность узлов командой `kubectl get nodes`, поды командой `kubectl get pods -n argocd` и PVC командой `kubectl get pvc -n argocd`. ||
|| На шаге 12 приложение `yc-storage-operator` не переходит в статус `Healthy`. | Проверьте версию в `yc_storage_operator.helm_oci.targetRevision`. На первом мастер-хосте выполните `kubectl describe application yc-storage-operator -n argocd`, чтобы узнать состояние приложения. ||
|#

### Повторная генерация секретов {#replace-secrets}

Если вы начинаете установку заново и существующие секреты больше не нужны, выполните на установочном хосте из каталога `ansible`:

```bash
./run.sh install -i inventory.ini \
  -e cluster=my-onprem -e replace_secrets=true --tags step1
```

Замените `my-onprem` на имя своего стенда. Параметр `replace_secrets=true` удаляет существующие `vault.yaml` и `vault_yav.yaml` и создает новый `vault.yaml`. Для продолжения установки с уже созданными секретами используйте `--skip-tags step1`.

## Ошибки установки компонентов {#operator-errors}

В редких случаях при установке On-premises Yandex Object Storage оператор может завершиться с ошибкой на одном из шагов. Для устранения проблемы необходимо определить причину сбоя, исправить ее и возобновить установку.

Порядок действий при возникновении ошибки во время установки:

1. Перейдите на мастер-узел кластера Kubernetes.
1. Узнайте статусы `update requests` с помощью команды:

    ```bash
    kubectl get updaterequests.storage.yandex.cloud
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
    kubectl describe <тип_ресурса> <имя_ресурса> -n <пространство_имен>
    ```

    Где `<тип_ресурса>` — например, `pod`, `job` или `daemonset`, а `<пространство_имен>` — пространство имен проблемного компонента.

1. После устранения проблемы с компонентом продолжите установку, выполнив команду:

    ```bash
    kubectl annotate updaterequests <имя_update_request> updates.storage.yandex.cloud/resume=1
    ```

Если самостоятельно устранить проблему не удалось, обратитесь в [техническую поддержку](../quickstart.md#support).