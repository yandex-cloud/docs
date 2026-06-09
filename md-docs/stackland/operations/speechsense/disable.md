# Отключить {{ speechsense-name }}

Вы можете отключить компонент {{ speechsense-name }} в кластере {{ stackland-name }}. При отключении контроллер автоматически удалит все ресурсы компонента.

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

* [{#T}](configure.md) — повторная активация {{ speechsense-name }}.
* [{{ speechsense-name }}](../../concepts/components/speechsense.md) — описание компонента.