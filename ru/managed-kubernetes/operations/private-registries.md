---
title: Как работать с приватными реестрами Docker-образов в {{ managed-k8s-full-name }}
description: Следуя данной инструкции, вы сможете настроить взаимодействие с приватными реестрами Docker-образов в {{ managed-k8s-name }}.
---

# Работа с приватными реестрами Docker-образов

{{ managed-k8s-name }} поддерживает интеграцию с приватными реестрами Docker-образов [{{ container-registry-full-name }}](../tutorials/container-registry.md) и [{{ cloud-registry-full-name }}](../../cloud-registry/concepts/index.md). Сервис авторизуется в этих реестрах от имени [облачного сервисного аккаунта](../concepts/index.md#service-accounts), назначенного группе узлов. Это предпочтительный и наиболее безопасный способ, поскольку авторизация происходит автоматически с помощью короткоживущих [IAM-токенов](../../iam/concepts/authorization/iam-token.md).

Назначить сервисный аккаунт группе узлов можно при [создании](./kubernetes-cluster/kubernetes-cluster-create.md) или [изменении](./kubernetes-cluster/kubernetes-cluster-update.md) кластера {{ managed-k8s-name }}.

Чтобы сервисный аккаунт имел доступ к реестрам, ему должны быть [назначены](../../iam/operations/sa/assign-role-for-sa.md) следующие роли на каталог с реестром:

* [container-registry.images.puller](../../container-registry/security/index.md#container-registry-images-puller) — для {{ container-registry-name }}.
* [cloud-registry.artifacts.puller](../../cloud-registry/security/index.md#cloud-registry-artifacts-puller) — для {{ cloud-registry-name }}.

При такой интеграции в манифесте подов не нужно указывать какие-либо аутентификационные данные, например:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: private-reg
spec:
  containers:
  - name: private-reg-container
    image: {{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>
```

Если по какой-то причине для авторизации в {{ container-registry-name }} или {{ cloud-registry-name }} невозможно использовать сервисный аккаунт с указанными ролями, используйте [авторизованный ключ](../../iam/concepts/authorization/key.md) с неограниченным сроком жизни.

{% note warning %}

Использование долгоживущего ключа менее безопасно, чем использование IAM-токенов.

{% endnote %}

Чтобы авторизоваться в реестре с помощью ключа:

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [Настройка kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Создайте авторизованный ключ и сохраните его в файл `key.json`:

    ```bash
    yc iam key create \
      --service-account-name <имя_сервисного_аккаунта> \
      --output key.json
    ```

1. Создайте секрет с данными ключа:

    ```bash
    kubectl create secret docker-registry yc-registry-secret \
      --docker-server={{ registry }} \
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
        image: {{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>
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
