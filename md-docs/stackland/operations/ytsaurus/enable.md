[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Базы данных > YTsaurus > Включить YTsaurus

# Включить YTsaurus

Компонент [YTsaurus](../../concepts/components/ytsaurus.md) разворачивает один общий кластер YTsaurus на платформу. Кластер описывается ресурсом `YTsaurusConfig` с именем `main`. По умолчанию компонент отключен (`spec.enabled: false`); чтобы развернуть кластер, переведите ресурс в состояние `spec.enabled: true`.

{% note warning %}

На платформе допустим только один кластер YTsaurus. Имя ресурса `YTsaurusConfig` должно быть `main`.

{% endnote %}

## Через CLI {#cli}

1. Откройте текущий ресурс `YTsaurusConfig main` для редактирования: `kubectl edit ytsaurusconfig main`. Если предпочитаете применять конфигурацию из файла, выгрузите ресурс: `kubectl get ytsaurusconfig main -o yaml > ytsaurusconfig.yaml`.
1. Замените содержимое одной из конфигураций ниже:

    {% list tabs %}

    - Минимальная конфигурация

        Включает компонент с минимальным набором подкомпонентов: ядро кластера, веб-интерфейс и HTTP-прокси. Подходит для тестового окружения.

        ```yaml
        apiVersion: stackland.yandex.cloud/v1alpha1
        kind: YTsaurusConfig
        metadata:
          name: main
        spec:
          enabled: true
          clusterName: cluster
          cluster:
            discovery:
              instanceCount: 1
            primaryMasters:
              instanceCount: 1
              storage:
                size: "5Gi"
            httpProxies:
              instanceCount: 1
            dataNodes:
              - name: ssd
                instanceCount: 3
                storage:
                  size: "20Gi"
            execNodes:
              - name: default
                instanceCount: 1
                storage:
                  size: "10Gi"
            schedulers:
              instanceCount: 1
            controllerAgents:
              instanceCount: 1
            bundleController:
              enabled: true
            queryTrackers:
              instanceCount: 1
            queueAgents:
              instanceCount: 1
            rpcProxies:
              instanceCount: 1
            strawberry:
              enabled: true
            yqlAgents:
              instanceCount: 1
            ui:
              enabled: true
              ingressEnabled: true
        ```

    - Расширенная конфигурация

        Полный набор подкомпонентов с явно заданными ресурсами и хранилищем: тэблет-узлы, Strawberry, CHYT, SPYT, Task Proxy, Cron. Подходит для производственного окружения.

        ```yaml
        apiVersion: stackland.yandex.cloud/v1alpha1
        kind: YTsaurusConfig
        metadata:
          name: main
        spec:
          enabled: true
          clusterName: cluster
          cluster:
            discovery:
              instanceCount: 1
              resources:
                cpu: "100m"
                memory: "256Mi"
        
            primaryMasters:
              instanceCount: 1
              storage:
                storageClass: stackland-ssd
                size: "10Gi"
              resources:
                cpu: "500m"
                memory: "1Gi"
        
            httpProxies:
              instanceCount: 2
              resources:
                cpu: "500m"
                memory: "1Gi"
        
            dataNodes:
              - name: ssd
                instanceCount: 3
                storage:
                  storageClass: stackland-ssd
                  size: "50Gi"
                resources:
                  cpu: "500m"
                  memory: "1Gi"
        
            execNodes:
              - name: default
                instanceCount: 2
                storage:
                  storageClass: stackland-ssd
                  size: "20Gi"
                resources:
                  cpu: "4000m"
                  memory: "4Gi"
        
            schedulers:
              instanceCount: 1
              resources:
                cpu: "500m"
                memory: "512Mi"
        
            controllerAgents:
              instanceCount: 1
              resources:
                cpu: "500m"
                memory: "512Mi"
        
            bundleController:
              enabled: true
        
            queryTrackers:
              instanceCount: 1
              resources:
                cpu: "200m"
                memory: "512Mi"
        
            queueAgents:
              instanceCount: 1
              resources:
                cpu: "200m"
                memory: "512Mi"
        
            rpcProxies:
              instanceCount: 2
              resources:
                cpu: "200m"
                memory: "512Mi"
        
            strawberry:
              enabled: true
              resources:
                cpu: "200m"
                memory: "512Mi"
        
            tabletNodes:
              - name: default
                instanceCount: 2
                resources:
                  cpu: "1000m"
                  memory: "2Gi"
        
            yqlAgents:
              instanceCount: 1
              resources:
                cpu: "500m"
                memory: "1Gi"
        
            ui:
              enabled: true
              ingressEnabled: true
              resources:
                cpu: "200m"
                memory: "512Mi"
        
            cron:
              clear_tmp:
                enabled: true
        
            taskProxy:
              enabled: true
              instanceCount: 1
        
            spyt:
              enabled: true
        
            chyt:
              enabled: true
        
            tutorial:
              enabled: false
        
            odin:
              enabled: false
        ```

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

1. Проверить состояние кластера YTsaurus можно командой:

    ```bash
    kubectl -n stackland-ytsaurus get ytsaurus cluster
    ```

    Имя ресурса соответствует значению `spec.clusterName` в `YTsaurusConfig`. Подождите, пока статус кластера не перейдет в `Running`. На первичный запуск может потребоваться 10–20 минут.

## Дальнейшие действия {#next-steps}

После включения компонента:

* [Получите пароль и токен администратора](get-admin-credentials.md).
* [Откройте веб-интерфейс YTsaurus](connect-ui.md).
* [Подключитесь к HTTP-прокси YTsaurus](connect-api.md).
* [Измените настройки кластера](edit-cluster.md), если нужно скорректировать ресурсы, состав групп узлов или подкомпонентов.