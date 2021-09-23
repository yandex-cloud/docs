# Интеграция с {{ objstorage-full-name }}

Сервис {{ CSI }} позволяет динамически резервировать [бакеты](../../../storage/concepts/bucket.md) {{ objstorage-name }} и монтировать их к [подам](../../concepts/index.md#pod) кластера.

Чтобы настроить монтирование бакета к поду {{ k8s }}:

1. [{#T}](#create-environment).
1. [{#T}](#test-csi).

## Подготовьте рабочее окружение {#create-environment}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с ролью `storage.editor`.

1. [Создайте статический ключ доступа](../../../iam/operations/sa/create-access-key.md) для сервисного аккаунта.

1. Создайте файл `secret.yaml`, в котором укажите настройки доступа для {{ CSI }}:

    ```yaml
    ---
    apiVersion: v1
    kind: Secret
    metadata:
      namespace: kube-system
      name: csi-s3-secret
    stringData:
      accessKeyID: <идентификатор ключа доступа>
      secretAccessKey: <секретный ключ>
      endpoint: https://storage.yandexcloud.net
    ```

1. Создайте файл с описанием класса хранилища `storageclass.yaml`:

    {% cut "storageclass.yaml" %}

    ```yaml
    ---
    kind: StorageClass
    apiVersion: storage.k8s.io/v1
    metadata:
      name: csi-s3
    provisioner: ru.yandex.s3.csi
    parameters:
      mounter: geesefs
      options: "--memory-limit 1000 --dir-mode 0777 --file-mode 0666"
      csi.storage.k8s.io/provisioner-secret-name: csi-s3-secret
      csi.storage.k8s.io/provisioner-secret-namespace: kube-system
      csi.storage.k8s.io/controller-publish-secret-name: csi-s3-secret
      csi.storage.k8s.io/controller-publish-secret-namespace: kube-system
      csi.storage.k8s.io/node-stage-secret-name: csi-s3-secret
      csi.storage.k8s.io/node-stage-secret-namespace: kube-system
      csi.storage.k8s.io/node-publish-secret-name: csi-s3-secret
      csi.storage.k8s.io/node-publish-secret-namespace: kube-system
    ```

    {% endcut %}

    {% note tip %}

    В процессе выполнения сценария драйвер {{ CSI }} создаст новый бакет. Чтобы использовать уже существующий бакет, добавьте в блок `parameters` поле `bucket`, в значении которого укажите имя бакета.

    {% endnote %}

1. Создайте файл `pvc.yaml`, содержащий описание Persistent Volume Claim с новым классом хранилища:

    {% cut "pvc.yaml" %}

    ```yaml
    ---
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: csi-s3-pvc
      namespace: default
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

1. Создайте файл `pod.yaml`, содержащий описание пода:

    {% cut "pod.yaml" %}

    ```yaml
    ---
    apiVersion: v1
    kind: Pod
    metadata:
      name: csi-s3-test-nginx
      namespace: default
    spec:
      containers:
       - name: csi-s3-test-nginx
         image: nginx
         volumeMounts:
           - mountPath: /usr/share/nginx/html/s3
             name: webroot
      volumes:
       - name: webroot
         persistentVolumeClaim:
           claimName: csi-s3-pvc
           readOnly: false
    ```

    {% endcut %}

1. Клонируйте Github-репозиторий, содержащий актуальный драйвер {{ CSI }}:

    ```bash
    git clone https://github.com/yandex-cloud/k8s-csi-s3.git
    ```

1. Создайте ресурсы {{ CSI }}:

    ```bash
    kubectl create -f secret.yaml && \
    kubectl create -f k8s-csi-s3/deploy/kubernetes/provisioner.yaml && \
    kubectl create -f k8s-csi-s3/deploy/kubernetes/attacher.yaml/attacher.yaml && \
    kubectl create -f k8s-csi-s3/deploy/kubernetes/csi-s3.yaml && \
    kubectl create -f storageclass.yaml
    ```

    Ожидаемый результат выполнения команды:

    ```text
    secret/csi-s3-secret created
    serviceaccount/csi-provisioner-sa created
    clusterrole.rbac.authorization.k8s.io/external-provisioner-runner created
    clusterrolebinding.rbac.authorization.k8s.io/csi-provisioner-role created
    service/csi-provisioner-s3 created
    statefulset.apps/csi-provisioner-s3 created
    serviceaccount/csi-attacher-sa created
    clusterrole.rbac.authorization.k8s.io/external-attacher-runner created
    clusterrolebinding.rbac.authorization.k8s.io/csi-attacher-role created
    service/csi-attacher-s3 created
    statefulset.apps/csi-attacher-s3 created
    serviceaccount/csi-s3 created
    clusterrole.rbac.authorization.k8s.io/csi-s3 created
    clusterrolebinding.rbac.authorization.k8s.io/csi-s3 created
    daemonset.apps/csi-s3 created
    storageclass.storage.k8s.io/csi-s3 created
    ```

## Проверьте доступ пода к бакету {#test-csi}

1. Создайте Persistent Volume Claim:

    ```bash
    kubectl create -f pvc.yaml
    ```

1. Убедитесь, что Persistent Volume Claim перешел в состояние `Bound`:

    ```bash
    kubectl get pvc csi-s3-pvc
    ```

    Ожидаемый результат выполнения команды:

    ```text
    NAME         STATUS   VOLUME             CAPACITY   ACCESS MODES   STORAGECLASS   AGE
    csi-s3-pvc   Bound    pvc-<имя бакета>   5Gi        RWX            csi-s3         73m
    ```

1. Создайте под, на который будет смонтирован бакет:

    ```bash
    kubectl create -f pod.yaml
    ```

1. Убедитесь, что под перешел в состояние `Running`:

    ```bash
    kubectl get pods
    ```

1. Проверьте, что бакет смонтирован к поду и доступен на запись:

    1. Подключитесь к консоли пода:

        ```bash
        kubectl exec -ti csi-s3-test-nginx bash
        ```

    1. Убедитесь, что бакет смонтирован к поду:

        ```bash
        mount | grep fuse
        ```

        Ожидаемый результат выполнения команды:

        ```text
        pvc-<имя бакета>: on /usr/share/nginx/html/s3 type fuse.geesefs (rw,nosuid,nodev,relatime,user_id=0,group_id=0,default_permissions,allow_other)
        ```

    1. Создайте файл на поде:

        ```bash
        echo "Test message" > /usr/share/nginx/html/s3/test.txt
        ```

    1. Убедитесь, что файл попал в бакет:

        1. Перейдите на страницу каталога и выберите сервис **{{ objstorage-name }}**.
        1. Нажмите на бакет `pvc-<имя бакета>`.
