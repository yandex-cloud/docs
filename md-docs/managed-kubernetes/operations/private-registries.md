[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for Kubernetes](../index.md) > [Пошаговые инструкции](index.md) > Работа с приватными реестрами Docker-образов

# Работа с приватными реестрами Docker-образов

Managed Service for Kubernetes поддерживает интеграцию с приватными реестрами Docker-образов [Yandex Container Registry](../tutorials/container-registry.md) и [Yandex Cloud Registry](../../cloud-registry/concepts/index.md). Сервис авторизуется в этих реестрах от имени [облачного сервисного аккаунта](../concepts/index.md#service-accounts), назначенного группе узлов. Это предпочтительный и наиболее безопасный способ, поскольку авторизация происходит автоматически с помощью короткоживущих [IAM-токенов](../../iam/concepts/authorization/iam-token.md).

Назначить сервисный аккаунт группе узлов можно при [создании](kubernetes-cluster/kubernetes-cluster-create.md) или [изменении](kubernetes-cluster/kubernetes-cluster-update.md) кластера Managed Service for Kubernetes.

Чтобы сервисный аккаунт имел доступ к реестрам, ему должны быть [назначены](../../iam/operations/sa/assign-role-for-sa.md) следующие роли на каталог с реестром:

* [container-registry.images.puller](../../container-registry/security/index.md#container-registry-images-puller) — для Container Registry.
* [cloud-registry.artifacts.puller](../../cloud-registry/security/index.md#cloud-registry-artifacts-puller) — для Cloud Registry.

При такой интеграции в манифесте подов не нужно указывать какие-либо аутентификационные данные, например:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: private-reg
spec:
  containers:
  - name: private-reg-container
    image: cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>:<тег>
```

Если по какой-то причине для авторизации в Container Registry или Cloud Registry невозможно использовать сервисный аккаунт с указанными ролями, используйте [авторизованный ключ](../../iam/concepts/authorization/key.md) с неограниченным сроком жизни.

{% note warning %}

Использование долгоживущего ключа менее безопасно, чем использование IAM-токенов.

{% endnote %}

Чтобы авторизоваться в реестре с помощью ключа:

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](connect/index.md#kubectl-connect).

1. Создайте авторизованный ключ и сохраните его в файл `key.json`:

    ```bash
    yc iam key create \
      --service-account-name <имя_сервисного_аккаунта> \
      --output key.json
    ```

1. Создайте секрет с данными ключа:

    ```bash
    kubectl create secret docker-registry yc-registry-secret \
      --docker-server=cr.yandex \
      --docker-username=json_key \
      --docker-password="$(cat key.json)" \
      --namespace=<пространство_имен>
    ```

1. Создайте YAML-файл манифеста со ссылкой на созданный секрет:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: private-reg
    spec:
      containers:
      - name: private-reg-container
        image: cr.yandex/<идентификатор_реестра>/<имя_Docker-образа>:<тег>
      imagePullSecrets:
      - name: yc-registry-secret
    ```

1. Примените новую конфигурацию:

    ```bash
    kubectl apply -f <путь_до_YAML-файла>
    ```

1. Убедитесь, что образ успешно скачан из реестра:

    ```bash
    kubectl get pods
    ```

    Результат:

    ```text
    NAME           READY   STATUS             RESTARTS   AGE
    private-reg    1/1     Running            0          7s
    ```