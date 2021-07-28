## Подключитесь к кластеру {{ k8s }} {#cluster-connect}

Чтобы работать с кластером {{ k8s }} с помощью kubectl:

* [Настройте группы безопасности](../../managed-kubernetes/operations/security-groups.md#rules-master) кластера.

    {% note warning %}

    Настройки групп безопасности могут препятствовать подключению к кластеру.

    {% endnote %}

* Добавьте учетные данные кластера {{ k8s }} в конфигурационный файл kubectl:

    1. Выполните команду:

        ```bash
        {{ yc-k8s }} cluster get-credentials --external --name k8s-demo
        ```

    1. Проверьте конфигурацию kubectl:

        ```yaml
        kubectl config view
        apiVersion: v1
        clusters:
        - cluster:
            certificate-authority-data: DATA+OMITTED
        ...
        ```

    * По умолчанию учетные данные добавляются в директорию `$HOME/.kube/config`.
    * Если необходимо изменить расположение конфигураций, используйте флаг `--kubeconfig <путь к файлу>`.
