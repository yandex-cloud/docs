# Обновить кластер

Обновите кластер {{ stackland-name }} до новой версии с помощью ресурса Kubernetes `TargetInstallationState`. Обновление выполняется постепенно с эвакуацией нагрузки и перезагрузкой узлов.

## Перед началом работы {#before-you-begin}

1. Убедитесь, что у вас есть доступ к кластеру с правами администратора.
1. Проверьте текущую версию кластера:

    ```bash
    kubectl get targetinstallationstate main -o jsonpath='{.status.currentVersion}'
    ```

1. Узнайте, какие версии доступны для обновления. Список доступных версий зависит от того, подключен ли ваш кластер к интернету:

    * **Кластер с доступом в интернет** — доступные версии загружаются автоматически из реестра контейнеров {{ stackland-name }}.
    * **Изолированный кластер** — доступные версии определяются образами, загруженными в локальный реестр.

## Выбрать релизный канал {#release-channel}

Релизный канал определяет, какие версии {{ stackland-name }} доступны для обновления. По умолчанию используется канал `stable`.

Доступные каналы:

* `stable` — стабильные релизы для production-использования. Доступен всем клиентам по умолчанию.
* `alpha` — ранние релизы для тестирования новых функций. Доступ предоставляется по запросу.

Чтобы изменить релизный канал, отредактируйте ресурс `PlatformConfig`:

```bash
kubectl edit platformconfig main
```

В спецификации укажите нужный канал:

```yaml
spec:
  releaseChannel: "stable"  # или "alpha"
```

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  Если кластер не имеет доступа в интернет, необходимо предварительно загрузить образы новой версии в локальный реестр через [CLI](#push-images).

  1. В левом меню выберите **Настройки**.
  1. В подменю выберите **Обновление**.
  1. Нажмите ссылку **Обновление** для перехода на страницу обновления кластера.
  1. На странице «Обновление кластера» в блоке «Текущий статус обновления» проверьте текущее состояние:

      * **Target version** — целевая версия обновления;
      * **Phase** — фаза обновления;
      * **Message** — сообщение о текущем состоянии.

  1. В разделе «Доступные обновления» укажите версию для обновления.
  1. Нажмите **Запустить обновление**.


- CLI {#cli}

  Инструкции CLI зависят от того, имеет ли кластер доступ в интернет.

    ### Кластер с доступом в интернет {#online-cluster}

    Если кластер имеет доступ в интернет, образы новой версии загружаются автоматически из реестра контейнеров {{ stackland-name }}.

    #### Подготовка к обновлению {#prepare-online}

    Дождитесь появления нового релиза в ресурсе `AvailableReleases`. Проверить доступные релизы можно командой:

    ```bash
    kubectl get availablereleases main -o yaml
    ```

    Пример вывода:

    ```yaml
    apiVersion: stackland.yandex.cloud/v1alpha1
    kind: AvailableReleases
    metadata:
      name: main
    status:
      releases:
        - version: "26.1.0"
          ready: true
        - version: "26.1.1"
          ready: true
    ```

    Когда нужная версия появится в списке со статусом `ready: true`, можно запускать обновление.

    #### Запустить обновление {#start-upgrade-online}

    1. Создайте файл манифеста. Например, с помощью команды `touch upgrade.yaml`.
    1. Откройте файл и вставьте конфигурацию:

        ```yaml
        apiVersion: stackland.yandex.cloud/v1alpha1
        kind: TargetInstallationState
        metadata:
          name: main
        spec:
          targetVersion: "<версия>"
          installationTimeout: "2h"
        ```

        Где:
        * `targetVersion` — целевая версия для обновления. Укажите значение из `availablereleases[main].status.releases[<желаемый_релиз>].version`.
        * `installationTimeout` — максимальное время выполнения обновления.

    1. Примените манифест:

        ```bash
        kubectl apply -f upgrade.yaml
        ```

  ### Изолированный кластер {#airgapped-cluster}

    Если кластер не имеет доступа в интернет, необходимо предварительно загрузить образы новой версии в локальный реестр.

    #### Скачать утилиту SLADM {#download-sladm}

    На машине с доступом в интернет скачайте свежую версию утилиты `sladm`, как при первоначальной установке.

    #### Загрузить образы на машине с интернетом {#download-images}

    На машине с доступом в интернет выполните команду:

    ```bash
    sladm pull --image-bundle full
    ```

    Где:
    * `--image-bundle` — тип пакета образов (`full` для полного набора).

    {% note info %}

    Для обновления образов отдельно лицензируемых компонентов, таких как {{ speechsense-name }}, дополнительно выполните загрузку с `--image-bundle speechsense`. Подробнее см. в разделе [{#T}](speechsense/install-images.md).

    {% endnote %}

    #### Перенести артефакты во внутренний контур {#transfer-artifacts}

    Перенесите на машину с доступом к локальному реестру кластера:

    * бинарный файл `sladm`;
    * файл `release.yaml`;
    * папку `<имя_релиза>-oci`.

    #### Загрузить образы в локальный реестр {#push-images}

    На машине с доступом к кластеру выполните команду:

    ```bash
    sladm push --local-registry --kubeconfig=<путь_к_kubeconfig> --image-bundle-folder <имя_папки>-oci
    ```

    Где:

    * `--local-registry` — указывает на использование локального реестра кластера;
    * `--kubeconfig` — путь к файлу kubeconfig для доступа к кластеру;
    * `--image-bundle-folder` — путь к папке с образами.

    #### Дождаться появления релиза {#wait-for-release}

    После загрузки образов дождитесь появления нового релиза в ресурсе `AvailableReleases`:

    ```bash
    kubectl get availablereleases main -o yaml
    ```

    Когда нужная версия появится в списке со статусом `ready: true`, можно запускать обновление.

    #### Запустить обновление {#start-upgrade-offline}

    1. Создайте файл манифеста. Например, с помощью команды `touch upgrade.yaml`.
    1. Откройте файл и вставьте конфигурацию:

        ```yaml
        apiVersion: stackland.yandex.cloud/v1alpha1
        kind: TargetInstallationState
        metadata:
          name: main
        spec:
          targetVersion: "<версия>"
          installationTimeout: "2h"
        ```

        Где:
        * `targetVersion` — целевая версия для обновления. Укажите значение из `availablereleases[main].status.releases[<желаемый_релиз>].version`.
        * `installationTimeout` — максимальное время выполнения обновления.

    1. Примените манифест:

        ```bash
        kubectl apply -f upgrade.yaml
        ```

{% endlist %}

## Проверить статус обновления {#check-status}

После применения манифеста вы можете отслеживать статус обновления:

```bash
kubectl get targetinstallationstate main
```

Пример вывода:

```text
NAME   TARGET VERSION   CURRENT VERSION   PHASE     MESSAGE                           AGE
main   26.1.1           26.1.0            Running   Running upgrade to version 26.1.1 5m
```

## Получить подробную информацию {#get-details}

Выполните команду:

```bash
kubectl describe targetinstallationstate main
```

В поле `status` отображается:

* `currentVersion` — текущая установленная версия.
* `phase` — фаза обновления:
    * `Pending` — обновление ожидает запуска.
    * `Running` — обновление выполняется.
    * `Completed` — обновление выполнено.
    * `Failed` — обновление завершилось с ошибкой.
* `message` — сообщение о текущем состоянии.
* `jobName` — имя задания Kubernetes, выполняющего обновление.
* `lastUpdateTime` — время последнего обновления статуса.

## Просмотреть логи обновления {#view-logs}

Чтобы просмотреть логи задания обновления, выполните команду:

```bash
kubectl logs -n stackland-system job/<имя_задания>
```

Имя задания можно получить из поля `status.jobName` ресурса `TargetInstallationState`.
