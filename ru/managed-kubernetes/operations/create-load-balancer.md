# Обеспечение доступа к приложению, запущенному в кластере {{ k8s }}

Для предоставления доступа к приложению, запущенному в кластере {{ k8s }}, вы можете использовать публичные и внутренние [сервисы различных типов](../concepts/service.md).

Чтобы предоставить публичный доступ к приложению, воспользуйтесь сервисом типа `LoadBalancer` с публичным IP-адресом.

Доступ к приложению может быть предоставлен из внутренних сетей, но не из кластера {{ k8s }}: из [подсетей](../../vpc/concepts/network.md#subnet) {{ vpc-full-name }} или внутренних подсетей организации, подключенных к {{ yandex-cloud }} с помощью сервиса [{{ interconnect-full-name }}](../../vpc/interconnect/index.md) или через VPN. Для этого используйте сервис типа `LoadBalancer` на основе [внутреннего балансировщика нагрузки](../../load-balancer/concepts/internal-load-balancer.md).

{% note info %}

В отличие от IP-адреса пода или узла, который может меняться в случае обновления ресурсов группы узлов, IP-адрес сервиса типа `LoadBalancer` не изменяется.

{% endnote %}

Подготовьте и запустите в кластере {{ k8s }} приложение, к которому необходимо предоставить доступ с помощью сервиса типа `LoadBalancer`. В качестве примера используйте простое приложение, которое отвечает на HTTP-запросы на порт 8080.

* [Создайте простое приложение](#simple-app)
* [Создайте сервис типа LoadBalancer с публичным IP-адресом](#lb-create)
* [Создайте сервис типа LoadBalancer с внутренним IP-адресом](#lb-int-create)
* [Дополнительные настройки для сервиса типа LoadBalancer](#advanced)

## Создайте простое приложение {#simple-app}

1. Сохраните следующую спецификацию для создания приложения в YAML-файл с именем `hello.yaml`:

   [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) — объект API {{ k8s }}, который управляет реплицированным приложением.

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: hello
   spec:
     replicas: 2
     selector:
       matchLabels:
         app: hello
     template:
       metadata:
         labels:
           app: hello
       spec:
         containers:
         - name: hello-app
           image: cr.yandex/crpjd37scfv653nl11i9/hello:1.1
   ```

1. Создайте приложение:

   {% list tabs %}

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     ```bash
     kubectl apply -f hello.yaml
     ```

     Результат выполнения команды:

     ```bash
     deployment.apps/hello created
     ```

   {% endlist %}

1. Посмотрите информацию о созданном приложении:

   {% list tabs %}

   - CLI

     ```bash
     kubectl describe deployment hello
     ```

     Результат выполнения команды:

     ```bash
     Name:                   hello
     Namespace:              default
     CreationTimestamp:      Wed, 28 Oct 2020 23:15:25 +0300
     Labels:                 <none>
     Annotations:            deployment.kubernetes.io/revision: 1
     Selector:               app=hello
     Replicas:               2 desired | 2 updated | 2 total | 1 available | 1 unavailable
     StrategyType:           RollingUpdate
     MinReadySeconds:        0
     RollingUpdateStrategy:  25% max unavailable, 25% max surge
     Pod Template:
       Labels:  app=hello
       Containers:
        hello-app:
         Image:        cr.yandex/crpab12cdef353nl11i9/hello:1.1
         Port:         <none>
         Host Port:    <none>
         Environment:  <none>
         Mounts:       <none>
       Volumes:        <none>
     Conditions:
       Type           Status  Reason
       ----           ------  ------
       Available      False   MinimumReplicasUnavailable
       Progressing    True    ReplicaSetUpdated
     OldReplicaSets:  <none>
     NewReplicaSet:   hello-74c9c1b238 (2/2 replicas created)
     Events:
       Type    Reason             Age   From                   Message
       ----    ------             ----  ----                   -------
       Normal  ScalingReplicaSet  10s   deployment-controller  Scaled up replica set hello-74c9c1b238 to 2
     ```

   {% endlist %}

## Создайте сервис типа LoadBalancer с публичным IP-адресом {#lb-create}

Когда вы создаете сервис типа `LoadBalancer`, контроллер {{ yandex-cloud }} создает и настраивает для вас [сетевой балансировщик нагрузки](../../load-balancer/concepts/index.md) в вашем каталоге с публичным IP-адресом.

{% note warning %}

* Созданный сетевой балансировщик тарифицируется согласно установленным [правилам тарификации](../../load-balancer/pricing.md).
* Не изменяйте и не удаляйте сетевой балансировщик нагрузки и целевые группы, которые будут автоматически созданы в вашем каталоге после создания сервиса с типом `LoadBalancer`.

{% endnote %}

1. Сохраните следующую спецификацию для создания сервиса типа `LoadBalancer` в YAML-файл с именем `load-balancer.yaml`:

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: hello
   spec:
     ports:
     - port: 80
       name: plaintext
       targetPort: 8080
     selector:
       app: hello
     type: LoadBalancer
   ```

   Где:
   * `port` — порт сетевого балансировщика, на котором будут обслуживаться пользовательские запросы.
   * `targetPort` — порт контейнера, на котором доступно приложение.
   * `selector` — метки селектора, использованные в шаблоне подов при создании объекта `Deployment`.

1. Создайте сетевой балансировщик нагрузки:

   {% list tabs %}

   - CLI

     ```bash
     kubectl apply -f load-balancer.yaml
     ```

     Результат выполнения команды:

     ```bash
     service/hello created
     ```

   {% endlist %}

1. Посмотрите информацию о созданном сетевом балансировщике нагрузки:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите ваш каталог по умолчанию.
     1. Выберите сервис **{{ load-balancer-name }}**.
     1. На вкладке **Балансировщики** отображен сетевой балансировщик нагрузки с префиксом `k8s` в имени и уникальным идентификатором вашего кластера {{ k8s }} в описании.

   - CLI

     ```bash
     kubectl describe service hello
     ```

     Результат выполнения команды:

     ```bash
     Name:                     hello
     Namespace:                default
     Labels:                   <none>
     Annotations:              Selector:  app=hello
     Type:                     LoadBalancer
     IP:                       172.20.169.7
     LoadBalancer Ingress:     130.193.50.111
     Port:                     plaintext  80/TCP
     TargetPort:               8080/TCP
     NodePort:                 plaintext  32302/TCP
     Endpoints:                10.1.130.4:8080
     Session Affinity:         None
     External Traffic Policy:  Cluster
     Events:
       Type    Reason                Age    From                Message
       ----    ------                ----   ----                -------
       Normal  EnsuringLoadBalancer  2m43s  service-controller  Ensuring load balancer
       Normal  EnsuredLoadBalancer   2m17s  service-controller  Ensured load balancer

     ```

   {% endlist %}

1. Убедитесь, что приложение доступно из интернета:

   {% list tabs %}

   - CLI

     ```bash
     curl http://130.193.50.111
     ```

     Где:
     * `130.193.50.111` — публичный IP-адрес из поля `LoadBalancer Ingress`.

     Результат выполнения команды:

     ```bash
     Hello, world!
     Running in 'hello-74c9c1b238-c1rpa'
     ```

   {% endlist %}

## Создайте сервис типа LoadBalancer с внутренним IP-адресом {#lb-int-create}

Чтобы создать балансировщик нагрузки с внутренним IP-адресом, укажите в YAML-спецификации сервиса в секции `annotations` парамеры `yandex.cloud/load-balancer-type` и `yandex.cloud/subnet-id`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: hello
  annotations:
    yandex.cloud/load-balancer-type: internal
    yandex.cloud/subnet-id: e1b23q26ab1c0dce8te9
spec:
  ports:
  - port: 80
    name: plaintext
    targetPort: 8080
  selector:
    app: hello
  type: LoadBalancer
```

Где:
* `yandex.cloud/subnet-id` — идентификатор подсети, в которой необходимо выделить IP-адрес для сетевого балансировщика нагрузки.
* `port` — порт сетевого балансировщика, на котором будут обслуживаться пользовательские запросы.
* `targetPort` — порт контейнера, на котором доступно приложение.
* `selector` — метки селектора, использованные в шаблоне подов при создании объекта `Deployment`.

## Дополнительные настройки для сервиса типа LoadBalancer {#advanced}

В {{ managed-k8s-short-name }} для сервиса типа `LoadBalancer` доступны следующие дополнительные настройки:

* Назначение [заранее зарезервированного публичного IP-адреса](../../vpc/operations/get-static-ip.md) с помощью параметра `loadBalancerIP`.
* Управление трафиком с помощью параметра [externalTrafficPolicy](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15/#service-v1-core):
  * `Cluster` — трафик попадает на любой из узлов кластера {{ k8s }}. При этом:
    * В случае отсутствия нужных подов на узле, трафик перенаправляется с помощью [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) на другой узел.
  * `Local` — трафик напрямую попадает на узлы, где запущены контейнеры приложений. При этом:
    * Сохраняется IP-адрес запроса пользователя.
    * Используется меньше горизонтального трафика между виртуальными машинами.

Параметры `loadBalancerIP` и `externalTrafficPolicy` не обязательные. Если их не указывать, балансировщик будет создан с динамическим IP-адресом и параметром `externalTrafficPolicy: Cluster`.

Пример YAML-спецификации сервиса типа `LoadBalancer` с этими параметрами:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: hello
spec:
  ports:
  - port: 80
    name: plaintext
    targetPort: 8080
  selector:
    app: hello
  loadBalancerIP: <заранее зарезервированный IP-адрес>
  type: LoadBalancer
  externalTrafficPolicy: <Local или Cluster>
```