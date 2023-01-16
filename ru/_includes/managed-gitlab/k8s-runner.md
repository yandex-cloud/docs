## Создайте {{ GLR }} {#runners}

Чтобы запускать задачи сборки в [кластере {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), создайте [{{ GLR }}](https://docs.gitlab.com/runner/install/kubernetes.html).
1. Подключите Helm-репозиторий, который содержит дистрибутив {{ GLR }}:

   ```bash
   helm repo add gitlab https://charts.gitlab.io
   ```

1. Узнайте настройки {{ GLR }}:
   1. Откройте в браузере административную панель {{ GL }}:
      * Если {{ GL }} развернут на [виртуальной машине](../../compute/concepts/vm.md) {{ compute-full-name }}, используйте ее [публичный IP-адрес](../../compute/concepts/network.md#public-ip).
      * Если {{ GL }} развернут в сервисе {{ mgl-name }}, используйте [FQDN инстанса](../../compute/concepts/network.md##hostname).
   1. Выберите проект с именем `gitlab-test`.
   1. В открывшемся окне слева нажмите кнопку **Settings** и выберите пункт **CI/CD**.
   1. В блоке **Runners** нажмите кнопку **Expand**.
   1. Сохраните значения параметров `URL` и `registration token` — они понадобятся на следующем шаге.
1. Создайте файл `values.yaml`, содержащий настройки {{ GLR }}:

   {% cut "values.yaml" %}

   ```yaml
   ---
   imagePullPolicy: IfNotPresent
   gitlabUrl: <публичный IP-адрес ВМ или FQDN инстанса {{ mgl-name }}>
   runnerRegistrationToken: "<registration token>"
   terminationGracePeriodSeconds: 3600
   concurrent: 10
   checkInterval: 30
   sessionServer:
    enabled: false
   rbac:
     create: true
     clusterWideAccess: true
     podSecurityPolicy:
       enabled: false
       resourceNames:
         - gitlab-runner
   runners:
     config: |
       [[runners]]
         [runners.kubernetes]
           namespace = "{{.Release.Namespace}}"
           image = "ubuntu:20.04"
           privileged = true
   ```

   {% endcut %}

1. Установите {{ GLR }} с помощью команды:

   ```bash
   helm install --namespace default gitlab-runner -f values.yaml gitlab/gitlab-runner
   ```

1. Дождитесь перехода пода {{ GLR }} в состояние `Running`:

   ```bash
   kubectl get pods -n default | grep gitlab-runner
   ```

Теперь вы можете запускать автоматизированные сборки внутри своего [кластера {{ k8s }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

Подробнее про установку и настройку {{ GLR }} читайте в [документации {{ GL }}](https://docs.gitlab.com/runner/install/).