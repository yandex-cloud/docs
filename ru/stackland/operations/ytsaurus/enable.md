# Включить {{ yt-name }}

Компонент [{{ yt-name }}](../../concepts/components/ytsaurus.md) разворачивает один общий кластер {{ YT }} на платформу. Кластер описывается ресурсом `YTsaurusConfig` с именем `main`. По умолчанию компонент отключен (`spec.enabled: false`); чтобы развернуть кластер, переведите ресурс в состояние `spec.enabled: true`.

{% note warning %}

На платформе допустим только один кластер {{ YT }}. Имя ресурса `YTsaurusConfig` должно быть `main`.

{% endnote %}

## Через CLI {#cli}

1. Откройте текущий ресурс `YTsaurusConfig main` для редактирования: `kubectl edit ytsaurusconfig main`. Если предпочитаете применять конфигурацию из файла, выгрузите ресурс: `kubectl get ytsaurusconfig main -o yaml > ytsaurusconfig.yaml`.
1. Замените содержимое одной из конфигураций ниже:

    {% list tabs %}

    - Минимальная конфигурация

        Включает компонент с минимальным набором подкомпонентов: ядро кластера, веб-интерфейс и HTTP-прокси. Подходит для тестового окружения.

        {% include notitle [YAML-файл](../../_includes/yamls/operations/ytsaurus/enable-min.md) %}

    - Расширенная конфигурация

        Полный набор подкомпонентов с явно заданными ресурсами и хранилищем: тэблет-узлы, Strawberry, CHYT, SPYT, Task Proxy, Cron. Подходит для производственного окружения.

        {% include notitle [YAML-файл](../../_includes/yamls/operations/ytsaurus/enable-full.md) %}

    {% endlist %}

1. Примените манифест: `kubectl apply -f ytsaurusconfig.yaml`. Ресурс работает на уровне кластера, пространство имен указывать не нужно.

1. Дождитесь, когда компонент перейдет в состояние готовности. Проверить статус установки можно командой:

    ```bash
    kubectl get componentinstallation ytsaurus-main -o jsonpath='{.status.phase}'
    ```

    Возможные значения:

    * `Installing` — компонент устанавливается.
    * `Updating` — применяется новая конфигурация.
    * `Ready` — компонент установлен и готов к работе.
    * `Error` — возникла ошибка. Подробности доступны в поле `status.message`.

1. Проверить состояние кластера {{ YT }} можно командой:

    ```bash
    kubectl -n stackland-ytsaurus get ytsaurus cluster
    ```

    Имя ресурса соответствует значению `spec.clusterName` в `YTsaurusConfig`. Подождите, пока статус кластера не перейдет в `Running`. На первичный запуск может потребоваться 10–20 минут.

## Дальнейшие действия {#next-steps}

После включения компонента:

* [Получите пароль и токен администратора](get-admin-credentials.md).
* [Откройте веб-интерфейс {{ YT }}](connect-ui.md).
* [Подключитесь к HTTP-прокси {{ YT }}](connect-api.md).
* [Измените настройки кластера](edit-cluster.md), если нужно скорректировать ресурсы, состав групп узлов или подкомпонентов.
