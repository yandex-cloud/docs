## Создайте тестовое приложение {#app-create}

Создайте тестовое приложение, которое можно будет развернуть в [кластере {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster):
1. Добавьте в проект `Dockerfile`:
   1. Авторизуйтесь в {{ GL }}.
   1. На главной странице выберите репозиторий.
   1. Выберите раздел **Repository** → **Files**.
   1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `Dockerfile` и добавьте в него код:

      ```Dockerfile
      FROM alpine:3.10
      CMD echo "Hello"
      ```

   1. Напишите комментарий к коммиту в поле **Commit message**: `Dockerfile for test application`.
   1. Нажмите кнопку **Commit changes**.
1. Добавьте в проект манифест создания ресурсов кластера {{ managed-k8s-name }}:
   1. Выберите раздел **Repository** → **Files**.
   1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `k8s.yaml`:

      {% cut "k8s.yaml" %}

      ```yaml
      apiVersion: v1
      kind: Namespace
      metadata:
        name: hello-world
      ---
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        name: hello-world-deployment
        namespace: hello-world
      spec:
        replicas: 1
        selector:
          matchLabels:
            app: hello
        template:
          metadata:
            namespace: hello-world
            labels:
              app: hello
          spec:
            containers:
              - name: hello-world
                image: __VERSION__
                imagePullPolicy: Always
       ```

      {% endcut %}

   1. Напишите комментарий к коммиту в поле **Commit message**: `Docker image deployment config`.
   1. Нажмите кнопку **Commit changes**.