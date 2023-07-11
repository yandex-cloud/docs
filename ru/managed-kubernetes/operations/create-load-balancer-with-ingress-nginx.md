# Создание сетевого балансировщика с помощью Ingress-контроллера NGINX

При установке [Ingress-контроллера NGINX](https://kubernetes.github.io/ingress-nginx/) вы можете создать как [внешний](../../network-load-balancer/concepts/index.md), так и [внутренний сетевой балансировщик](../../network-load-balancer/concepts/internal-load-balancer.md) нагрузки.

## Перед началом работы {#before-you-begin}

1. {% include [Установка Helm](../../_includes/managed-kubernetes/helm-install.md) %}

1. [Установите kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с кластером {{ managed-k8s-name }}](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).
1. Добавьте в Helm репозиторий для NGINX:

   ```bash
   helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
   ```

   Результат:

   ```text
   "ingress-nginx" has been added to your repositories
   ```

1. Обновите набор данных для создания экземпляра приложения в [кластере {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster):

   ```bash
   helm repo update
   ```

   Результат:

   ```text
   Hang tight while we grab the latest from your chart repositories...
   ...Successfully got an update from the "ingress-nginx" chart repository
   Update Complete. ⎈Happy Helming!⎈
   ```

## Внешний сетевой балансировщик {#external}

Внешний сетевой балансировщик создается при установке Ingress-контроллера NGINX в стандартной конфигурации:

```bash
helm install ingress-nginx ingress-nginx/ingress-nginx
```

Результат:

```text
NAME: ingress-nginx
LAST DEPLOYED: Sun Jul 18 22:35:37 2022
NAMESPACE: default
...
The ingress-nginx controller has been installed.
It may take a few minutes for the LoadBalancer IP to be available.
You can watch the status by running 'kubectl --namespace default get services -o wide -w ingress-nginx-controller'
...
```

## Внутренний сетевой балансировщик {#internal}

Чтобы установить внутренний сетевой балансировщик:
1. Настройте [конфигурацию контроллера](https://github.com/kubernetes/ingress-nginx/blob/main/charts/ingress-nginx/values.yaml). Для этого создайте конфигурационный файл `values.yaml` и укажите в нем идентификатор [подсети](../../vpc/concepts/network.md#subnet), в которой должен работать сетевой балансировщик:

   ```yaml
   controller:
     service:
       external:
         enabled: false
       internal:
         enabled: true
         annotations:
           yandex.cloud/load-balancer-type: internal
           yandex.cloud/subnet-id: <идентификатор подсети>
   ```

1. Установите Ingress-контроллер NGINX, используя конфигурационный файл `values.yaml`:

   ```bash
   helm install ingress-nginx -f values.yaml ingress-nginx/ingress-nginx
   ```

   Результат:

   ```text
   NAME: ingress-nginx
   LAST DEPLOYED: Sun Jul 18 22:55:37 2022
   NAMESPACE: default
   ...
   The ingress-nginx controller has been installed.
   It may take a few minutes for the LoadBalancer IP to be available.
   You can watch the status by running 'kubectl --namespace default get services -o wide -w ingress-nginx-controller'
   ...
   ```

## Проверьте результат {#check-result}

Чтобы убедиться, что нужный сетевой балансировщик был создан, получите [список сетевых балансировщиков в каталоге](../../network-load-balancer/operations/load-balancer-list.md#list).