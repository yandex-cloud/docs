# Отключить {{ yt-name }}

Чтобы отключить компонент [{{ yt-name }}](../../concepts/components/ytsaurus.md), переведите ресурс `YTsaurusConfig` в состояние `spec.enabled: false`.

{% note alert %}

При отключении компонента контроллер удаляет helm-релизы и пространство имен `stackland-ytsaurus`. Вместе с пространством имен удаляются все ресурсы кластера {{ YT }}, включая PVC и хранящиеся в них данные. Восстановление данных после отключения невозможно.

Перед отключением убедитесь, что данные кластера {{ YT }} больше не нужны или сохранены во внешнем хранилище.

{% endnote %}

## Через CLI {#cli}

1. Откройте ресурс `YTsaurusConfig main` для редактирования: `kubectl edit ytsaurusconfig main`. Установите `spec.enabled: false`. Поля `spec.cluster` можно оставить без изменений.

    Альтернативный вариант — применить готовый манифест:

    {% include notitle [YAML-файл](../../_includes/yamls/operations/ytsaurus/disable.md) %}

    ```bash
    kubectl apply -f ytsaurusconfig-disable.yaml
    ```

1. Дождитесь завершения удаления. Статус деинсталляции отображается в ресурсе `ComponentInstallation ytsaurus-main`:

    ```bash
    kubectl get componentinstallation ytsaurus-main -o jsonpath='{.status.phase}'
    ```

    На время удаления статус принимает значение `Uninstalling`. После успешного удаления ресурс `ComponentInstallation ytsaurus-main` будет удален из кластера.

1. Убедитесь, что пространство имен `stackland-ytsaurus` удалено:

    ```bash
    kubectl get namespace stackland-ytsaurus
    ```

    Команда должна вернуть ошибку `NotFound`.

## Повторно включить компонент {#re-enable}

Чтобы снова развернуть кластер {{ YT }}, переведите `spec.enabled` обратно в `true`. После повторного включения создается новый кластер {{ YT }} с пустым хранилищем; данные предыдущего кластера не восстанавливаются. Подробнее см. в инструкции [Включить {{ yt-name }}](enable.md).
