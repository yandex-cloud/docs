[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Базы данных > YTsaurus > Изменить настройки кластера

# Изменить настройки кластера YTsaurus

Если компонент [YTsaurus](../../concepts/components/ytsaurus.md) включен, можно изменить параметры кластера через ресурс `YTsaurusConfig main`. На платформе допустим только один экземпляр ресурса; имя ресурса фиксированное — `main`.

{% note warning %}

* Не обновляйте сразу несколько подкомпонентов кластера в одном изменении: нет гарантии, что после такого обновления кластер вернется в состояние `Ready`. Применяйте изменения по одному подкомпоненту и дожидайтесь готовности кластера перед следующим изменением.
* При изменении ресурсов, реплик и состава подкомпонентов оператор YTsaurus перезапускает соответствующие поды. На время применения новой конфигурации часть запросов прерывается.
* Размер `storage.size` у `primaryMasters`, `dataNodes` и `execNodes` можно только увеличить. Уменьшение размера валидация Kubernetes отклонит.
* Класс хранилища `storage.storageClass` зашивается в PVC при первом создании пода. После создания PVC класс изменить нельзя; чтобы перейти на другой класс, удалите соответствующую группу и создайте её заново с новым классом — данные группы будут удалены.
* В списках `dataNodes[]`, `execNodes[]` и `tabletNodes[]` поле `name` — иммутабельный ключ группы. Изменение `name` приводит к удалению старой группы вместе с данными и созданию новой группы.
* Группа `execNodes` с именем `default` обязательна; удалить её или переименовать нельзя.
* Чтобы отключить компонент целиком, см. инструкцию [Отключить YTsaurus](disable.md).

{% endnote %}

## Через CLI {#cli}

1. Выгрузите текущий ресурс `YTsaurusConfig main` в файл:

    ```bash
    kubectl get ytsaurusconfig main -o yaml > ytsaurusconfig.yaml
    ```

    Альтернативный вариант — открыть ресурс для интерактивного редактирования: `kubectl edit ytsaurusconfig main`.

1. Отредактируйте параметры в одном из разделов ниже.

1. Примените манифест:

    ```bash
    kubectl apply -f ytsaurusconfig.yaml
    ```

1. Дождитесь, когда компонент перейдет в состояние готовности:

    ```bash
    kubectl get componentinstallation ytsaurus-main -w
    ```

    На время применения новой конфигурации `status.phase` принимает значение `Updating`, после успешного применения — `Ready`. При ошибке текст диагностики доступен в `status.message`.

1. Дополнительно отслеживайте состояние кластера YTsaurus:

    ```bash
    kubectl -n stackland-ytsaurus get ytsaurus cluster -w
    ```

    Имя ресурса соответствует `spec.clusterName` в `YTsaurusConfig`. Существенные изменения (например, увеличение `primaryMasters.storage.size` или добавление новой группы узлов) занимают несколько минут — оператор выполняет последовательный перезапуск компонентов.

## Базовая конфигурация {#basic}

* `spec.enabled` — флаг включения компонента. Значение `false` отключает компонент и удаляет кластер вместе с данными. Подробнее см. в инструкциях [Включить YTsaurus](enable.md) и [Отключить YTsaurus](disable.md).
* `spec.clusterName` — название кластера YTsaurus, отображается в веб-интерфейсе и используется для адресации ресурсов в namespace `stackland-ytsaurus`.

## Ресурсы и реплики ядра кластера {#core-resources}

Для каждого блока в `spec.cluster` можно изменить количество подов `instanceCount` и ресурсы `resources` (`cpu`, `memory`). Диапазоны `instanceCount` определены валидационной схемой `YTsaurusConfig`.

* `spec.cluster.discovery.instanceCount` — 1–50.
* `spec.cluster.discovery.resources.cpu`, `spec.cluster.discovery.resources.memory`.
* `spec.cluster.primaryMasters.instanceCount` — 1–50.
* `spec.cluster.primaryMasters.resources.cpu`, `spec.cluster.primaryMasters.resources.memory`.
* `spec.cluster.primaryMasters.storage.size` — размер диска для метаданных. Можно только увеличить.
* `spec.cluster.primaryMasters.storage.storageClass` — класс хранилища. После создания PVC изменить нельзя.
* `spec.cluster.httpProxies.instanceCount` — 1–3.
* `spec.cluster.httpProxies.resources.cpu`, `spec.cluster.httpProxies.resources.memory`.
* `spec.cluster.schedulers.instanceCount` — 1–10.
* `spec.cluster.schedulers.resources.cpu`, `spec.cluster.schedulers.resources.memory`.
* `spec.cluster.controllerAgents.instanceCount` — 1–10.
* `spec.cluster.controllerAgents.resources.cpu`, `spec.cluster.controllerAgents.resources.memory`.
* `spec.cluster.queryTrackers.instanceCount` — 1–10.
* `spec.cluster.queryTrackers.resources.cpu`, `spec.cluster.queryTrackers.resources.memory`.
* `spec.cluster.queueAgents.instanceCount` — 1–10.
* `spec.cluster.queueAgents.resources.cpu`, `spec.cluster.queueAgents.resources.memory`.
* `spec.cluster.rpcProxies.instanceCount` — 1–3.
* `spec.cluster.rpcProxies.resources.cpu`, `spec.cluster.rpcProxies.resources.memory`.
* `spec.cluster.yqlAgents.instanceCount` — 1–3.
* `spec.cluster.yqlAgents.resources.cpu`, `spec.cluster.yqlAgents.resources.memory`.
* `spec.cluster.bundleController.enabled` — флаг включения контроллера тэблет-бандлов.

## Изменение групп data nodes {#data-nodes}

Группы узлов хранения описываются массивом `spec.cluster.dataNodes`. Каждая запись массива идентифицируется полем `name` (паттерн `^[a-z][a-z0-9-]*$`).

* `spec.cluster.dataNodes[].instanceCount` — 3–10. Минимум три узла в каждой группе.
* `spec.cluster.dataNodes[].storage.size` — размер диска. Можно только увеличить.
* `spec.cluster.dataNodes[].storage.storageClass` — класс хранилища. После создания PVC изменить нельзя.
* `spec.cluster.dataNodes[].resources.cpu`, `spec.cluster.dataNodes[].resources.memory`.

Чтобы **добавить новую группу**, добавьте элемент в массив с уникальным `name`. Оператор создаст для группы новые поды и PVC.

Чтобы **удалить группу**, уберите соответствующий элемент из массива. Поды группы удаляются, а PVC и хранящиеся в них данные удаляются вместе с подом, так как создаются из `volumeClaimTemplates`. Удалите группу только если данные больше не нужны.

## Изменение групп exec nodes {#exec-nodes}

Группы узлов исполнения описываются массивом `spec.cluster.execNodes`. Массив должен содержать запись с `name: default` — оператор отклонит конфигурацию без этой группы.

* `spec.cluster.execNodes[].name` — паттерн `^[a-z][a-z0-9-]*$`. Иммутабельный ключ группы.
* `spec.cluster.execNodes[].instanceCount` — 1–50.
* `spec.cluster.execNodes[].storage.size` — размер диска для слотов и кэшей. Можно только увеличить.
* `spec.cluster.execNodes[].storage.storageClass` — класс хранилища. После создания PVC изменить нельзя.
* `spec.cluster.execNodes[].resources.cpu`, `spec.cluster.execNodes[].resources.memory`.
* `spec.cluster.execNodes[].resources.gpu` — количество GPU на под. Требует включенного компонента [Поддержка NVIDIA® GPU](../../concepts/components/gpu.md) и наличия GPU на узлах кластера.

Правила добавления и удаления групп — те же, что для `dataNodes`. Группу `default` удалять нельзя.

## Изменение групп tablet nodes {#tablet-nodes}

Список `spec.cluster.tabletNodes` опциональный; его можно оставить пустым, если динамические таблицы не используются.

* `spec.cluster.tabletNodes[].name` — паттерн `^[a-z][a-z0-9-]*$`. Иммутабельный ключ группы.
* `spec.cluster.tabletNodes[].instanceCount` — 1–50.
* `spec.cluster.tabletNodes[].resources.cpu`, `spec.cluster.tabletNodes[].resources.memory`.

Узлы динамических таблиц не используют отдельные PVC, поэтому при удалении группы удаляются только поды.

## Управление дополнительными подкомпонентами {#extras}

Дополнительные подкомпоненты включаются и отключаются через флаги `enabled` в соответствующих полях `spec.cluster`. При смене флага оператор создает или удаляет helm-релиз и связанные ресурсы Kubernetes.

* `spec.cluster.ui.enabled` — веб-интерфейс YTsaurus.
* `spec.cluster.ui.ingressEnabled` — публикация Ingress на адрес `ytsaurus.<домен_системы>`. Имеет смысл только при `ui.enabled: true`.
* `spec.cluster.ui.resources.cpu`, `spec.cluster.ui.resources.memory` — ресурсы пода веб-интерфейса.
* `spec.cluster.strawberry.enabled` — Strawberry-контроллер. Требуется, если планируется использовать CHYT или SPYT.
* `spec.cluster.strawberry.resources.cpu`, `spec.cluster.strawberry.resources.memory`.
* `spec.cluster.chyt.enabled` — CHYT, движок ClickHouse® поверх YTsaurus. Перед включением убедитесь, что включен `strawberry`.
* `spec.cluster.spyt.enabled` — SPYT, движок Apache Spark™ поверх YTsaurus. Перед включением убедитесь, что включен `strawberry`.
* `spec.cluster.taskProxy.enabled` — Task Proxy для запуска внешних задач.
* `spec.cluster.taskProxy.instanceCount` — 1–10.
* `spec.cluster.tutorial.enabled` — встроенный туториал YTsaurus. Создает каталог `//home/tutorial` с примерами.
* `spec.cluster.odin.enabled` — служба мониторинга Odin. После включения активируются правила `odin-alerts`.

## Cron-задачи {#cron}

Регулярная очистка каталога `//tmp` настраивается в `spec.cluster.cron.clear_tmp`:

* `spec.cluster.cron.clear_tmp.enabled` — флаг включения очистки.
* `spec.cluster.cron.clear_tmp.interval` — периодичность запуска. Формат `^[0-9]+[hms]$` (например, `15m`, `1h`, `30s`). По умолчанию `15m`.
* `spec.cluster.cron.clear_tmp.account_usage_percent_save_total` — порог суммарного использования квоты аккаунта, до которого выполняется очистка. Значение от 0 до 100, по умолчанию `50`.
* `spec.cluster.cron.clear_tmp.account_usage_percent_save_per_owner` — порог использования квоты на одного владельца. Значение от 0 до 100, по умолчанию `10`.
* `spec.cluster.cron.clear_tmp.max_dir_node_count` — максимальное число узлов в каталоге `//tmp`, после которого включается очистка. По умолчанию `100000`.

## Что дальше {#what-is-next}

* [Получить пароль и токен администратора](get-admin-credentials.md).
* [Открыть веб-интерфейс YTsaurus](connect-ui.md).
* [Подключиться к HTTP-прокси YTsaurus](connect-api.md).
* [Отключить YTsaurus](disable.md).