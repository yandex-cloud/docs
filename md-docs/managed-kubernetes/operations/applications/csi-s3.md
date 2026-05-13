# Установка Container Storage Interface для S3


[Container Storage Interface для S3](https://yandex.cloud/ru/marketplace/products/yc/csi-s3) (_CSI_) позволяет динамически резервировать [бакеты](../../../storage/concepts/bucket.md) S3-совместимых хранилищ и монтировать их к [подам](../../concepts/index.md#pod) [кластера Managed Service for Kubernetes](../../concepts/index.md#kubernetes-cluster) в виде [постоянных томов](../../concepts/volume.md#persistent-volume) (_PersistentVolume_). Подключение выполняется при помощи [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра))-реализации файловой системы [GeeseFS](https://github.com/yandex-cloud/geesefs).

{% note info %}

Перед публикацией в Yandex Cloud Marketplace новые версии приложения тестируются на работоспособность в инфраструктуре Yandex Cloud, поэтому могут обновляться с задержкой. Чтобы использовать самую последнюю версию, [установите ее c помощью Helm-чарта из репозитория на GitHub](csi-s3.md#helm-github-install).

{% endnote %}

Установить Container Storage Interface для S3 можно следующими способами:
* [В консоли управления с помощью Cloud Marketplace](#marketplace-install)
* [C помощью Helm-чарта из репозитория Cloud Marketplace](#helm-install)
* [С помощью Helm-чарта из репозитория на GitHub](#helm-github-install)

## Перед началом работы {#before-you-begin}

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт с [ролью](../../../storage/security/index.md#storage-editor) `storage.editor`.
1. [Создайте](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа для сервисного аккаунта. Сохраните идентификатор ключа и секретный ключ — они понадобятся при установке приложения.
1. (Опционально) Чтобы новые тома помещались в один бакет с разными префиксами, [создайте](../../../storage/operations/buckets/create.md) бакет Yandex Object Storage. Сохраните имя бакета — оно понадобится при установке приложения. Пропустите этот шаг, если для каждого тома требуется создавать отдельный бакет.

1. [Убедитесь](../connect/security-groups.md), что группы безопасности для кластера Managed Service for Kubernetes и его групп узлов настроены корректно. Если отсутствует какое-либо из правил — [добавьте его](../../../vpc/operations/security-group-add-rule.md).

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

## Установка в консоли управления с помощью Cloud Marketplace {#marketplace-install}

1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного кластера Managed Service for Kubernetes и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [Container Storage Interface для S3](https://yandex.cloud/ru/marketplace/products/yc/csi-s3) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) `kube-system`.

      {% note warning %}
      
      Приложение работает корректно только с пространством имен `kube-system`.
      
      {% endnote %}

   * **Название приложения** — укажите название приложения, например `csi-s3`.
   * **Создать класс хранения** — выберите эту опцию, чтобы создать новый [класс хранилища](../volumes/manage-storage-class.md) при развертывании приложения.
   * **Создать секрет** — выберите эту опцию, чтобы создать новый секрет для класса хранилища при установке приложения.
   * **Идентификатор ключа S3** — скопируйте в это поле идентификатор ключа сервисного аккаунта.
   * **Секретный ключ S3** — скопируйте в это поле секретный ключ сервисного аккаунта.
   * **Общий бакет S3 для томов** — укажите имя общего бакета, в котором будут создаваться [динамически распределяемые тома](../../concepts/volume.md#dynamic-provisioning). Чтобы CSI создавал новый бакет для каждого тома, оставьте это поле пустым.
   * **Адрес S3-сервиса** — адрес S3-сервиса, который будет использовать приложение. По умолчанию `https://storage.yandexcloud.net`.
   * **Опции монтирования GeeseFS** — опции монтирования для программы GeeseFS. Полный список опций см. в [документации GeeseFS](https://github.com/yandex-cloud/geesefs).
   * **Политика очистки томов** — выберите политику очистки томов PersistentVolume при удалении PersistentVolumeClaim:
     * **Retain** — сохранять том.
     * **Delete** — удалять том.
   * **Название класса хранения** — если вы ранее выбрали опцию **Создать класс хранения**, укажите имя нового класса хранилища.
   * **Название секрета** — если вы ранее выбрали опцию **Создать секрет**, укажите имя нового секрета, который будет создан для класса хранилища. В ином случае укажите имя существующего секрета, который будет использован для класса хранилища.
   * **Игнорировать все политики taint** — выберите эту опцию, чтобы драйвер CSI, который монтирует файловую систему на узлах, игнорировал все политики taint для узлов кластера Managed Service for Kubernetes.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

## Установка с помощью Helm-чарта из репозитория Cloud Marketplace {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с CSI выполните команду, указав в ней параметры ключа, созданного [ранее](#before-you-begin):

   ```bash
   helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/csi-s3/csi-s3 \
     --version 0.43.6 \
     --untar && \
   helm install \
     --namespace kube-system \
     --set secret.accessKey=<идентификатор_ключа> \
     --set secret.secretKey=<секретный_ключ> \
     csi-s3 ./csi-s3/
   ```

   {% note info %}
   
   Если вы используете версию Helm ниже 3.8.0, добавьте в начало команды строку `export HELM_EXPERIMENTAL_OCI=1 && \`, чтобы включить поддержку [Open Container Initiative](https://opencontainers.org/) (OCI) в клиенте Helm.
   
   {% endnote %}

   Также вы можете [задать дополнительные параметры](#installation-parameters) Container Storage Interface для S3.

## Установка с помощью Helm-чарта из репозитория на GitHub {#helm-github-install}

В [репозитории на GitHub](https://github.com/yandex-cloud/k8s-csi-s3) размещается наиболее актуальная версия Container Storage Interface для S3 с поддержкой Object Storage.

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../connect/index.md#kubectl-connect).
1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с CSI выполните команду:

    ```bash
    helm repo add yandex-s3 https://yandex-cloud.github.io/k8s-csi-s3/charts && \
    helm repo update && \
    helm pull yandex-s3/csi-s3 --untar && \
    helm install \
      --namespace kube-system \
      --set secret.accessKey=<идентификатор_ключа> \
      --set secret.secretKey=<секретный_ключ> \
      csi-s3 ./csi-s3/
    ```

    Также вы можете [задать дополнительные параметры](#installation-parameters) Container Storage Interface для S3.

    Подробнее об [обновлении с разных версий k8s-csi-s3](https://github.com/yandex-cloud/k8s-csi-s3/tree/master#upgrading).

## Параметры для установки с помощью Helm-чарта {#installation-parameters}

При установке приложения Container Storage Interface для S3 обязательными являются параметры `secret.accessKey` и `secret.secretKey`. Вы можете не указывать остальные параметры, либо переопределить их в команде установки с помощью ключа `--set <имя_параметра>=<новое_значение>`.

Список доступных для переопределения параметров и их значения по умолчанию приведены в таблице:

Имя параметра | Описание | Значение по умолчанию
--- | --- | ---
`storageClass.create` | Требуется ли создание нового класса хранилища | `true`
`storageClass.name` | Имя класса хранилища | `csi-s3`
`storageClass.singleBucket` | Использовать один бакет для всех PersistentVolumeClaim |
`storageClass.mountOptions` | Опции монтирования GeeseFS | `--memory-limit 1000 --dir-mode 0777 --file-mode 0666`
`storageClass.reclaimPolicy` | Политика очистки томов | `Delete`
`storageClass.annotations` | Описание для класса хранилища |
`secret.create` | Требуется ли создание нового секрета | `true`
`secret.name` | Имя секрета | `csi-s3-secret`
`secret.accessKey` | Идентификатор ключа |
`secret.secretKey` | Секретный ключ |
`secret.endpoint` | Адрес S3-сервиса | `https://storage.yandexcloud.net`

## См. также {#see-also}

* [Спецификация CSI](https://github.com/container-storage-interface/spec/blob/master/spec.md)
* [Container Storage Interface для S3 с поддержкой Object Storage на GitHub](https://github.com/yandex-cloud/k8s-csi-s3)
* [Интеграция с Object Storage](../volumes/s3-csi-integration.md)
* [Примеры использования CSI](../volumes/s3-csi-integration.md#examples)
* [Работа с постоянными и динамическими томами в Kubernetes](../../concepts/volume.md)