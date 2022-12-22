# Установка Container Storage Interface для S3

[Container Storage Interface для S3](/marketplace/products/yc/csi-s3) (_CSI_) позволяет динамически резервировать [бакеты](../../../storage/concepts/bucket.md) S3-совместимых хранилищ и монтировать их к [подам](../../concepts/index.md#pod) [кластера {{ k8s }}](../../concepts/index.md#kubernetes-cluster) в виде [постоянных томов](../../concepts/volume.md#persistent-volume) (_PersistentVolume_). Подключение выполняется при помощи [FUSE](https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра))-реализации файловой системы [GeeseFS](https://github.com/yandex-cloud/geesefs).

## Создание сервисного аккаунта {#create-sa-key}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с [ролью](../../../iam/concepts/access-control/roles.md) `storage.editor`.
1. [Создайте статический ключ доступа](../../../iam/operations/sa/create-access-key.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md). Сохраните идентификатор ключа и секретный ключ — они понадобятся при установке приложения.
1. (опционально) Чтобы новые тома помещались в один бакет с разными префиксами, [создайте бакет](../../../storage/operations/buckets/create.md) {{ objstorage-full-name }}. Сохраните имя бакета — оно понадобится при установке приложения. Пропустите этот шаг, если для каждого тома требуется создавать отдельный бакет.

## Установка с помощью {{ marketplace-full-name }} {#install-fb-marketplace}

1. Перейдите на страницу каталога и выберите сервис **{{ managed-k8s-name }}**.
1. Нажмите на имя нужного кластера и выберите вкладку **{{ marketplace-short-name }}**.
1. В разделе **Доступные для установки приложения** выберите [Container Storage Interface для S3](/marketplace/products/yc/csi-s3) и нажмите кнопку **Использовать**.
1. Задайте настройки приложения:
   * **Пространство имен** — выберите [пространство имен](../../concepts/index.md#namespace) `kube-system`.
   * **Название приложения** — укажите название приложения, например `csi-s3`.
   * **Создать класс хранения** — выберите эту опцию, чтобы создать новый [класс хранилища](../volumes/manage-storage-class.md) при развертывании приложения.
   * **Создать секрет** — выберите эту опцию, чтобы создать новый секрет для класса хранилища при установке приложения.
   * **Идентификатор ключа S3** — скопируйте в это поле идентификатор ключа сервисного аккаунта.
   * **Секретный ключ S3** — скопируйте в это поле секретный ключ сервисного аккаунта.
   * **Общий S3 бакет для томов** — укажите имя общего бакета, в котором будут создаваться [динамически распределяемые тома](../../concepts/volume.md#dynamic-provisioning). Чтобы CSI создавал новый бакет для каждого тома, оставьте это поле пустым.
   * **Адрес S3-сервиса** — адрес S3-сервиса, который будет использовать приложение. По умолчанию `https://{{ s3-storage-host }}`.
   * **Опции монтирования GeeseFS** — опции монтирования для программы GeeseFS. Полный список опций см. в [документации GeeseFS](https://github.com/yandex-cloud/geesefs).
   * **Политика очистки томов** — выберите политику очистки томов PersistentVolume при удалении PersistentVolumeClaim:
     * **Retain** — сохранять том.
     * **Delete** — удалять том.
   * **Название класса хранения** — если вы ранее выбрали опцию **Создать класс хранения**, укажите имя нового класса хранилища.
   * **Название секрета** — если вы ранее выбрали опцию **Создать секрет**, укажите имя нового секрета, который будет создан для класса хранилища. В ином случае укажите имя существующего секрета, который будет использован для класса хранилища.
1. Нажмите кнопку **Установить**.

## Установка с помощью Helm-чарта {#install-using-helm}

1. {% include [Установка Helm](../../../_includes/managed-kubernetes/helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с CSI выполните команду:

   ```bash
   export HELM_EXPERIMENTAL_OCI=1 && \
   helm pull oci://{{ registry }}/yc-marketplace/yandex-cloud/csi-s3/csi-s3 \
     --version 0.30.9 \
     --untar && \
   helm install \
     --namespace <пространство имен> \
     --create-namespace \
     --set secret.accessKey=<идентификатор ключа> \
     --set secret.secretKey=<секретный ключ> \
     csi-s3 .
   ```

При установке приложения CSI обязательными являются параметры `secret.accessKey` и `secret.secretKey`. Вы можете не указывать остальные параметры, либо переопределить их в команде установки с помощью ключа `--set <имя параметра>=<новое значение>`.

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
`secret.endpoint` | Адрес S3-сервиса | `https://{{ s3-storage-host }}`

## См. также {#see-also}

* [Спецификация CSI](https://github.com/container-storage-interface/spec/blob/master/spec.md)
* [Интеграция с {{ objstorage-name }}](../volumes/s3-csi-integration.md)
* [Работа с постоянными и динамическими томами в {{ k8s }}](../../concepts/volume.md)