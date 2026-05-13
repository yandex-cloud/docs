# Отключить SpeechSense

Вы можете отключить компонент SpeechSense в кластере Stackland. При отключении контроллер автоматически удалит все ресурсы компонента.

## Отключить компонент {#disable}

1. Создайте файл манифеста `speechsense-disable.yaml`:

    apiVersion: stackland.yandex.cloud/v1alpha1
    kind: SpeechsenseConfig
    metadata:
      name: default
    spec:
      enabled: false
    ```
    ```

1. Примените манифест:

    ```bash
    kubectl apply -f speechsense-disable.yaml
    ```

1. Убедитесь, что ресурсы удалены:

    ```bash
    kubectl get pods -n stackland-speechsense
    ```

    Команда не должна возвращать подов.

Контроллер автоматически удалит:

* Helm-релиз `stackland-speechsense`.
* Кластеры баз данных, если они не используются другими компонентами.
* Секреты и сертификаты.

{% note warning %}

PVC с данными баз данных сохраняются для возможности восстановления. Для полной очистки удалите PVC вручную:

```bash
kubectl delete pvc --all -n stackland-speechsense
```

{% endnote %}

## Что дальше {#whats-next}

* [Настроить и активировать SpeechSense](configure.md) — повторная активация SpeechSense.
* [SpeechSense](../../concepts/components/speechsense.md) — описание компонента.