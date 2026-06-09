# Создание сетевого балансировщика с помощью Ingress-контроллера NGINX

При установке [Ingress-контроллера NGINX](https://kubernetes.github.io/ingress-nginx/) вы можете создать [внешний](../../network-load-balancer/concepts/index.md) или [внутренний сетевой балансировщик](../../network-load-balancer/concepts/nlb-types.md) нагрузки, а также настроить [проброс портов](#port-forwarding).

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролями](../../iam/concepts/access-control/roles.md) `k8s.clusters.agent`, `vpc.publicAdmin`, `container-registry.images.puller` и `load-balancer.admin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роль `load-balancer.admin` нужна для создания [сетевого балансировщика нагрузки](../../network-load-balancer/concepts/index.md).
1. [Создайте группы безопасности](connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Создайте кластер Managed Service for Kubernetes](kubernetes-cluster/kubernetes-cluster-create.md). В настройках кластера укажите сервисный аккаунт и группы безопасности, созданные ранее.
1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.
1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](connect/index.md#kubectl-connect).
1. Настройте Helm для работы с репозиторием NGINX:

   1. Добавьте в Helm репозиторий для NGINX:

      ```bash
      helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
      ```

      Результат:

      ```text
      "ingress-nginx" has been added to your repositories
      ```

   1. Обновите набор данных для создания экземпляра приложения в [кластере Managed Service for Kubernetes](../concepts/index.md#kubernetes-cluster):

      ```bash
      helm repo update
      ```

      Результат:

      ```text
      Hang tight while we grab the latest from your chart repositories...
      ...Successfully got an update from the "ingress-nginx" chart repository
      Update Complete. ⎈Happy Helming!⎈
      ```

   
   Ingress-контроллер NGINX можно также [установить с помощью Yandex Cloud Marketplace](../alb-ref/nginx-gwin-migration.md).


## Внешний сетевой балансировщик {#external}

{% note warning %}

* Созданный сетевой балансировщик тарифицируется согласно установленным [правилам тарификации](../../network-load-balancer/pricing.md).
* Не изменяйте и не удаляйте сетевой балансировщик и целевые группы, которые будут автоматически созданы в вашем каталоге, через интерфейсы Yandex Cloud (консоль управления, Terraform, CLI и API). Это может привести к некорректной работе кластера.

{% endnote %}

Для создания сетевого балансировщика у сервисного аккаунта, привязанного к кластеру Managed Service for Kubernetes, должна быть роль `load-balancer.admin`.

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

{% note warning %}

* Созданный сетевой балансировщик тарифицируется согласно установленным [правилам тарификации](../../network-load-balancer/pricing.md).
* Не изменяйте и не удаляйте сетевой балансировщик и целевые группы, которые будут автоматически созданы в вашем каталоге, через интерфейсы Yandex Cloud (консоль управления, Terraform, CLI и API). Это может привести к некорректной работе кластера.

{% endnote %}

Для создания сетевого балансировщика у сервисного аккаунта, привязанного к кластеру Managed Service for Kubernetes, должна быть роль `load-balancer.admin`.

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
           yandex.cloud/subnet-id: <идентификатор_подсети>
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

## Проброс портов {#port-forwarding}

Несмотря на то, что Ingress-контроллер NGINX официально поддерживает маршрутизацию только внешнего HTTP- и HTTPS-трафика, его можно сконфигурировать на прием и перенаправление внешнего TCP или UDP трафика к внутренним сервисам. Для этого установите Ingress-контроллер, используя [конфигурационный файл](https://github.com/kubernetes/ingress-nginx/blob/main/charts/ingress-nginx/values.yaml) `values.yaml` с настройками перенаправления и префиксом `portNamePrefix`.
1. Создайте файл `values.yaml`:

   ```yaml
   <протокол>: {<внешний_порт>: "<пространство_имен_сервиса>/<имя_сервиса>:<внутренний_порт>"}
   portNamePrefix: "<префикс>"
   ```

   Где `<протокол>` — протокол: `tcp` или `udp`.

1. Установите Ingress-контроллер NGINX, используя конфигурационный файл `values.yaml`:

   ```bash
   helm install ingress-nginx -f values.yaml ingress-nginx/ingress-nginx
   ```

>Пример
>
>Допустим, нужно организовать проброс трафика со следующими параметрами:
>* Имя сервиса — `example-go`.
>* Пространство имен сервиса — `default`.
>* Внутренний порт сервиса — `8080`.
>* Внешний порт — `9000`.
>* Префикс для имени порта — `test`
>
>Конфигурационный файл `values.yaml` для такого проброса:
>
>```yaml
>tcp: {9000: "default/example-go:8080"}
>portNamePrefix: "test"
>```

После установки Ingress-контроллера созданный сетевой балансировщик будет иметь дополнительный обработчик `test-9000-tcp` с заданными настройками перенаправления.

Имя порта Ingress-контроллера NGINX и обработчика сетевого балансировщика формируется из настроек перенаправления: `<внешний_порт>-<протокол>`. Ограничения Yandex Cloud не допускают цифр в начале имени обработчика, поэтому для правильной настройки необходимо указать префикс `portNamePrefix`. Таким образом, имя порта и обработчика будет сформировано как `<значение_префикса_portNamePrefix>-<внешний_порт>-<протокол>`.

Имя порта имеет техническое ограничение в 15 символов, а имя обработчика не может начинаться с цифр. Поэтому префикс `portNamePrefix` должен:
* Начинаться с букв.
* Иметь длину не более 5-8 символов в зависимости от длины значения внешнего порта.

Чтобы убедиться, что порты проброшены, просмотрите список обработчиков в [детальной информации о сетевом балансировщике](../../network-load-balancer/operations/load-balancer-list.md#get).