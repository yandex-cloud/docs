## Создайте {{ GL }} Runner {#runners}

Для того, чтобы запускать задачи сборки на [кластере {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), создайте [{{ GL }} Runner](https://docs.gitlab.com/runner/install/kubernetes.html).

1. Подключите Helm-репозиторий, который содержит дистрибутив {{ GL }} Runner:

   ```bash
   helm repo add gitlab https://charts.gitlab.io
   ```

1. Узнайте настройки {{ GL }} Runner:
   1. Откройте в браузере ссылку вида `http://<публичный IP-адрес ВМ GitLab>/root`.
   1. Выберите проект с именем `gitlab-test`.
   1. В открывшемся окне слева нажмите кнопку **Setting** и выберите пункт **CI/CD**.
   1. В блоке **Runners** нажмите кнопку **Expand**.
   1. Сохраните значения параметров `URL` и `registration token` — они понадобятся на следующем шаге.
1. Создайте файл `values.yaml`, содержащий настройки {{ GL }} Runner:

   ```yaml
   imagePullPolicy: IfNotPresent
   gitlabUrl: <URL инстанса Gitlab>
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

1. Установите {{ GL }} Runner с помощью команды:

   ```bash
   helm install --namespace default gitlab-runner -f values.yaml gitlab/gitlab-runner
   ```

1. Убедитесь, что под {{ GL }} Runner перешел в состояние `Running`:

   ```bash
   kubectl get pods -n default | grep gitlab-runner
   ```

Теперь вы можете запускать автоматизированные сборки внутри своего кластера {{ k8s }}.

Подробнее про установку и настройку {{ GL }} Runner читайте в [документации GitLab](https://docs.gitlab.com/runner/install/).