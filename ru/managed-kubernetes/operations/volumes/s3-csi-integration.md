# Интеграция с {{ objstorage-name }}

{{ CSI }} позволяет динамически резервировать [бакеты](../../../storage/concepts/bucket.md) [{{ objstorage-full-name }}](../../../storage/) и монтировать их к [подам](../../concepts/index.md#pod) [кластера {{ managed-k8s-name }}](../../concepts/index.md#kubernetes-cluster). При этом можно монтировать уже существующие бакеты или создавать новые.

Чтобы воспользоваться возможностями {{ CSI }}:
1. [Подготовьте рабочее окружение](#create-environment).
1. [Настройте {{ CSI }}](#configure-csi).

См. также:
* [Как использовать {{ CSI }} при работе с `PersistentVolume`](#csi-usage).
* [Примеры создания `PersistentVolume`](#examples).

## Подготовка рабочего окружения {#create-environment}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с [ролью](../../../iam/concepts/access-control/roles.md) `storage.editor`.
1. [Создайте статический ключ доступа](../../../iam/operations/sa/create-access-key.md) для [сервисного аккаунта](../../../iam/concepts/index.md#sa). Сохраните идентификатор ключа и секретный ключ — они понадобятся при установке {{ CSI }}.
1. [Создайте бакет](../../../storage/operations/buckets/create.md) {{ objstorage-name }}, который будет смонтирован к `PersistentVolume`. Сохраните имя бакета — оно понадобится при установке {{ CSI }}.
1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Настройка {{ CSI }} {#configure-csi}

{% list tabs %}

- С помощью {{ marketplace-full-name }}

  Установите приложение {{ CSI }} для S3 с помощью [пошаговой инструкции](../applications/csi-s3.md#install-fb-marketplace). При установке приложения укажите параметры:
  * **Пространство имен** — `kube-system`.
  * **Название класса хранения** — `csi-s3`.
  * **Название секрета** — `csi-s3-secret`.

  После установки приложения можно создавать [статические](../../concepts/volume.md#static-provisioning) и [динамические](../../concepts/volume.md#dynamic-provisioning) `PersistentVolume`, которые будут использовать бакеты {{ objstorage-name }}.

- Вручную

  1. Создайте файл `secret.yaml`, в котором укажите настройки доступа для {{ CSI }}:

     ```yaml
     ---
     apiVersion: v1
     kind: Secret
     metadata:
       namespace: kube-system
       name: csi-s3-secret
     stringData:
       accessKeyID: <идентификатор_ключа_доступа>
       secretAccessKey: <секретный_ключ>
       endpoint: https://{{ s3-storage-host }}
     ```

     В полях `accessKeyID` и `secretAccessKey` укажите [полученные ранее](#create-environment) идентификатор и значение секретного ключа.
  1. Создайте файл с описанием класса хранилища `storageclass.yaml`:

     ```yaml
     ---
     kind: StorageClass
     apiVersion: storage.k8s.io/v1
     metadata:
       name: csi-s3
     provisioner: ru.yandex.s3.csi
     parameters:
       mounter: geesefs
       options: "--memory-limit=1000 --dir-mode=0777 --file-mode=0666"
       bucket: <опционально:_имя_существующего_бакета>
       csi.storage.k8s.io/provisioner-secret-name: csi-s3-secret
       csi.storage.k8s.io/provisioner-secret-namespace: kube-system
       csi.storage.k8s.io/controller-publish-secret-name: csi-s3-secret
       csi.storage.k8s.io/controller-publish-secret-namespace: kube-system
       csi.storage.k8s.io/node-stage-secret-name: csi-s3-secret
       csi.storage.k8s.io/node-stage-secret-namespace: kube-system
       csi.storage.k8s.io/node-publish-secret-name: csi-s3-secret
       csi.storage.k8s.io/node-publish-secret-namespace: kube-system
     ```

     Чтобы использовать существующий бакет, укажите его имя в параметре `bucket`. Эта настройка актуальна только для [динамических `PersistentVolume`](#dpvc-csi-usage).
  1. Клонируйте [GitHub-репозиторий](https://github.com/yandex-cloud/k8s-csi-s3.git), содержащий актуальный драйвер {{ CSI }}:

     ```bash
     git clone https://github.com/yandex-cloud/k8s-csi-s3.git
     ```

  1. Создайте ресурсы для {{ CSI }} и класс хранилища:

     ```bash
     kubectl create -f secret.yaml && \
     kubectl create -f k8s-csi-s3/deploy/kubernetes/provisioner.yaml && \
     kubectl create -f k8s-csi-s3/deploy/kubernetes/driver.yaml && \
     kubectl create -f k8s-csi-s3/deploy/kubernetes/csi-s3.yaml && \
     kubectl create -f storageclass.yaml
     ```

     После установки драйвера {{ CSI }} и настройки класса хранилища можно создавать статические и динамические `PersistentVolume`, которые будут использовать бакеты {{ objstorage-name }}.

{% endlist %}

## Использование {{ CSI }} {#csi-usage}

При настроенном {{ CSI }} создание статических и динамических `PersistentVolumes` имеет свои особенности.

### Динамический PersistentVolume {#dpvc-csi-usage}

При работе с динамическим `PersistentVolume`:
* Укажите имя нужного класса хранилища в параметре `spec.storageClassName` при создании `PersistentVolumeClaim`.
* При необходимости укажите имя бакета в параметре `bucket` при [создании класса хранилища](#configure-csi). Это влияет на поведение {{ CSI }}:
  * Если при настройке класса хранилища было указано имя бакета в параметре `bucket`, {{ CSI }} создаст отдельный каталог внутри этого бакета на каждый созданный `PersistentVolume`.

    {% note info %}

    Такая настройка может быть полезна, если в [облаке](../../../resource-manager/concepts/resources-hierarchy.md#cloud) действуют строгие [квоты]({{ link-console-quotas }}) на количество бакетов {{ objstorage-name }}.

    {% endnote %}

  * Если при настройке класса хранилища не было указано имя бакета в параметре `bucket`, то {{ CSI }} создаст отдельный бакет на каждый созданный `PersistentVolume`.

[Пример создания](#create-dynamic-pvc) динамического `PersistentVolume`.

### Статический PersistentVolume {#spvc-csi-usage}

При работе со статическим `PersistentVolume`:
* Укажите пустое значение параметра `spec.storageClassName` при создании `PersistentVolumeClaim`.
* Укажите имя нужного бакета или директории бакета в параметре `spec.csi.volumeHandle` при создании `PersistentVolume`. Если такого бакета не существует — создайте его.

  {% note info %}

  При удалении такого `PersistentVolume` соответствующий ему бакет не будет удален автоматически.

  {% endnote %}

* Если вам нужно изменить опции клиента [GeeseFS](../../../storage/tools/geesefs.md) для работы с бакетом, укажите их в параметре `spec.csi.volumeAttributes.options` при создании `PersistentVolume`. Например, в опции `--uid` можно указать идентификатор пользователя-владельца всех файлов в хранилище. Список опций GeeseFS см. с помощью команды `geesefs -h` или в [репозитории на GitHub](https://github.com/yandex-cloud/geesefs/blob/master/internal/flags.go#L88).

  Опции GeeseFS, указанные в параметре `parameters.options` класса хранилища (`StorageClass`), для статических `PersistentVolume` игнорируются. Подробнее см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/storage/storage-classes/#mount-options).

[Пример создания](#create-static-pvc) статического `PersistentVolume`.

## Примеры использования {#examples}

### Динамический PersistentVolume {#create-dynamic-pvc}

Чтобы использовать {{ CSI }} совместно с динамическим `PersistentVolume`:
1. [Настройте {{ CSI }}](#configure-csi).
1. Создайте `PersistentVolumeClaim`:
   1. Создайте файл `pvc-dynamic.yaml`, содержащий описание `PersistentVolumeClaim`:

      {% cut "pvc-dynamic.yaml" %}

      ```yaml
      ---
      apiVersion: v1
      kind: PersistentVolumeClaim
      metadata:
        name: csi-s3-pvc-dynamic
        namespace: kube-system
      spec:
        accessModes:
        - ReadWriteMany
        resources:
          requests:
            storage: 5Gi
        storageClassName: csi-s3
      ```

      {% endcut %}

      При необходимости измените размер запрашиваемого хранилища в значении параметра `spec.resources.requests.storage`.
   1. Создайте `PersistentVolumeClaim`:

      ```bash
      kubectl create -f pvc-dynamic.yaml
      ```

   1. Убедитесь, что `PersistentVolumeClaim` перешел в состояние `Bound`:

      ```bash
      kubectl get pvc csi-s3-pvc-dynamic
      ```

      Результат:

      ```text
      NAME                STATUS  VOLUME                    CAPACITY  ACCESS MODES  STORAGECLASS  AGE
      csi-s3-pvc-dynamic  Bound   pvc-<имя_dynamic-бакета>  5Gi       RWX           csi-s3        73m
      ```

1. Создайте под для проверки динамического `PersistentVolume`.
   1. Создайте файл `pod-dynamic.yaml`, содержащий описание пода:

      {% cut "pod-dynamic.yaml" %}

      ```yaml
      ---
      apiVersion: v1
      kind: Pod
      metadata:
        name: csi-s3-test-ubuntu-dynamic
      spec:
        containers:
        - name: csi-s3-test-ubuntu
          image: ubuntu
          command: ["/bin/sh"]
          args: ["-c", "for i in {1..10}; do echo $(date -u) >> /data/s3-dynamic/dynamic-date.txt; sleep 10; done"]
          volumeMounts:
            - mountPath: /data/s3-dynamic
              name: s3-volume
        volumes:
          - name: s3-volume
            persistentVolumeClaim:
              claimName: csi-s3-pvc-dynamic
              readOnly: false
      ```

      {% endcut %}

   1. Создайте под, на котором будет смонтирован бакет для динамического `PersistentVolume`:

      ```bash
      kubectl create -f pod-dynamic.yaml
      ```

   1. Убедитесь, что под перешел в состояние `Running`:

      ```bash
      kubectl get pods
      ```

   В процессе работы под несколько раз выполнит команду `date` и запишет результат в файл `/data/s3-dynamic/dynamic-date.txt`. Этот файл будет размещен в бакете.
1. Убедитесь, что файл попал в бакет:
   1. Перейдите на страницу каталога и выберите сервис **{{ objstorage-name }}**.
   1. Нажмите на бакет `pvc-<имя_dynamic-бакета>`.

### Статический PersistentVolume {#create-static-pvc}

Чтобы использовать {{ CSI }} совместно со статическим `PersistentVolume`:
1. [Настройте {{ CSI }}](#configure-csi).
1. Создайте `PersistentVolumeClaim`:
   1. Создайте файл `pvc-static.yaml`, содержащий описание `PersistentVolumeClaim`:

      {% cut "pvc-static.yaml" %}

      ```yaml
      ---
      apiVersion: v1
      kind: PersistentVolumeClaim
      metadata:
        name: csi-s3-pvc-static
        namespace: kube-system
      spec:
        accessModes:
          - ReadWriteMany
        resources:
          requests:
            storage: 10Gi
        storageClassName: ""
      ```

      {% endcut %}

      При необходимости измените размер запрашиваемого хранилища в значении параметра `spec.resources.requests.storage`.
   1. Создайте файл `pv-static.yaml`, содержащий описание статического `PersistentVolume`:

      {% cut "pv-static.yaml" %}

      ```yaml
      ---
      apiVersion: v1
      kind: PersistentVolume
      metadata:
        name: s3-volume
      spec:
        storageClassName: csi-s3
        capacity:
          storage: 10Gi
        accessModes:
          - ReadWriteMany
        claimRef:
          namespace: kube-system
          name: csi-s3-pvc-static
        csi:
          driver: ru.yandex.s3.csi
          volumeHandle: "<имя_бакета>/<опционально:_путь_к_каталогу_в_бакете>"
          controllerPublishSecretRef:
            name: csi-s3-secret
            namespace: kube-system
          nodePublishSecretRef:
            name: csi-s3-secret
            namespace: kube-system
          nodeStageSecretRef:
            name: csi-s3-secret
            namespace: kube-system
          volumeAttributes:
            capacity: 10Gi
            mounter: geesefs
            options: "--memory-limit=1000 --dir-mode=0777 --file-mode=0666 --uid=1001"
      ```

      В этом примере настройки GeeseFS для работы с бакетом изменены по сравнению со `StorageClass`. В них добавлена опция `--uid`, в которой указан идентификатор пользователя-владельца всех файлов в хранилище — `1001`. Подробнее о настройке GeeseFS для статического `PersistentVolume` см. [выше](#spvc-csi-usage).

      {% endcut %}

   1. Создайте `PersistentVolumeClaim`:

      ```bash
      kubectl create -f pvc-static.yaml
      ```

   1. Создайте статический `PersistentVolume`:

      ```bash
      kubectl create -f pv-static.yaml
      ```

   1. Убедитесь, что `PersistentVolumeClaim` перешел в состояние `Bound`:

      ```bash
      kubectl get pvc csi-s3-pvc-static
      ```

      Результат:

      ```text
      NAME               STATUS  VOLUME                  CAPACITY  ACCESS MODES  STORAGECLASS  AGE
      csi-s3-pvc-static  Bound   <имя_PersistentVolume>  10Gi      RWX           csi-s3        73m
      ```

1. Создайте под для проверки статического `PersistentVolume`.
   1. Создайте файл `pod-static.yaml`, содержащий описание пода:

      {% cut "pod-static.yaml" %}

      ```yaml
      ---
      apiVersion: v1
      kind: Pod
      metadata:
        name: csi-s3-test-ubuntu-static
        namespace: kube-system
      spec:
        containers:
        - name: csi-s3-test-ubuntu
          image: ubuntu
          command: ["/bin/sh"]
          args: ["-c", "for i in {1..10}; do echo $(date -u) >> /data/s3-static/static-date.txt; sleep 10; done"]
          volumeMounts:
            - mountPath: /data/s3-static
              name: s3-volume
        volumes:
          - name: s3-volume
            persistentVolumeClaim:
              claimName: csi-s3-pvc-static
              readOnly: false
      ```

      {% endcut %}

   1. Создайте под, на котором будет смонтирован бакет для статического `PersistentVolume`:

      ```bash
      kubectl create -f pod-static.yaml
      ```

   1. Убедитесь, что под перешел в состояние `Running`:

      ```bash
      kubectl get pods
      ```

   В процессе работы под несколько раз выполнит команду `date` и запишет результат в файл `/data/s3-static/static-date.txt`. Этот файл будет размещен в бакете.
1. Убедитесь, что файл попал в бакет:
   1. Перейдите на страницу каталога и выберите сервис **{{ objstorage-name }}**.
   1. Нажмите на бакет `<имя_бакета>`.