# Обеспечение доступа к приложению, запущенному в кластере {{ k8s }}

Для предоставления доступа к приложению, запущенному в кластере {{ k8s }}, вы можете использовать [сервисы различных типов](../concepts/service.md). Для предоставления публичного доступа воспользуйтесь сервисом типа `LoadBalancer`.

{% note info %}

В отличие от IP-адреса пода или узла, который может меняться в случае обновления ресурсов группы узлов, IP-адрес сервиса типа `LoadBalancer` не изменяется.

{% endnote %}

Подготовьте и запустите в кластере {{ k8s }} приложение, к которому необходимо предоставить доступ с помощью сервиса типа `LoadBalancer`. В качестве примера используйте простое приложение, которое отвечает на HTTP-запросы на порт 8080.

- [Создайте простое приложение](#simple-app)
- [Создайте сервис типа LoadBalancer](#lb-create)
- [Проверьте результат](#check-result)
- [Дополнительные настройки для сервиса типа LoadBalancer](#advanced)

## Создайте простое приложение {#simple-app}

1. Сохраните следующую спецификацию для создания приложения в YAML-файл с названием `hello.yaml`:

    [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) — объект API {{ k8s }}, управляющий реплицированным приложением.
    
    ```
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
1. Выполните команду: 

    ```
    $ kubectl apply -f hello.yaml
    deployment.apps/hello created
    ```
1. Посмотрите информацию о созданном приложении:

    ```
    $ kubectl describe deployment hello
    Name:                   hello
    Namespace:              default
    CreationTimestamp:      Mon, 23 Sep 2019 12:13:28 +0300
    Labels:                 <none>
    Annotations:            deployment.kubernetes.io/revision: 1
                            kubectl.kubernetes.io/last-applied-configuration:
                              {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"name":"hello","namespace":"default"},"spec":{"replicas":2,"selec...
    Selector:               app=hello
    Replicas:               2 desired | 2 updated | 2 total | 2 available | 0 unavailable
    StrategyType:           RollingUpdate
    MinReadySeconds:        0
    RollingUpdateStrategy:  25% max unavailable, 25% max surge
    Pod Template:
      Labels:  app=hello
      Containers:
       hello-app:
        Image:        cr.yandex/crpjd37scfv653nl11i9/hello:1.1
        Port:         <none>
        Host Port:    <none>
        Environment:  <none>
        Mounts:       <none>
      Volumes:        <none>
    Conditions:
      Type           Status  Reason
      ----           ------  ------
      Available      True    MinimumReplicasAvailable
      Progressing    True    NewReplicaSetAvailable
    OldReplicaSets:  <none>
    NewReplicaSet:   hello-9ffd9ff9b (2/2 replicas created)
    Events:
      Type    Reason             Age   From                   Message
      ----    ------             ----  ----                   -------
      Normal  ScalingReplicaSet  24s   deployment-controller  Scaled up replica set hello-9ffd9ff9b to 2
    ``` 
       
## Создайте сервис с типом LoadBalancer {#lb-create}

Когда вы создаете сервис с типом `LoadBalancer`, контроллер {{ yandex-cloud }} создает и настраивает для вас [сетевой балансировщик нагрузки](../../load-balancer/concepts/index.md) в вашем каталоге с публичным IP-адресом.

{% note warning %}

* Созданный сетевой балансировщик тарифицируется согласно установленным [правилам тарификации](../../load-balancer/pricing.md).
* Не изменяйте и не удаляйте сетевой балансировщик нагрузки и целевые группы, которые будут автоматически созданы в вашем каталоге после создания сервиса с типом `LoadBalancer`. 

{% endnote %}

1. Сохраните следующую спецификацию для создания сервиса типа `LoadBalancer` в YAML-файл с названием `load-balancer.yaml`. 

    - В поле `targetPort` указан порт контейнера, на котором доступно приложение. 
    - В поле `port` указан порт сетевого балансировщика, на котором будут обслуживаться пользовательские запросы.
    - В поле `selector` указаны метки селектора, использованные в шаблоне подов при создании объекта `Deployment`.

    ```
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
1. Выполните команду: 

    ```
    $ kubectl apply -f load-balancer.yaml
    service/hello configured
    ```
1. Посмотрите информацию о созданном балансировщике:    
    
    ```
    $ kubectl describe service hello
    Name:                     hello
    Namespace:                default
    Labels:                   <none>
    Annotations:              kubectl.kubernetes.io/last-applied-configuration:
                                {"apiVersion":"v1","kind":"Service","metadata":{"annotations":{},"name":"hello","namespace":"default"},"spec":{"ports":[{"name":"plaintext...
    Selector:                 app=hello
    Type:                     LoadBalancer
    IP:                       10.15.165.125
    LoadBalancer Ingress:     84.201.145.125
    Port:                     plaintext  80/TCP
    TargetPort:               8080/TCP
    NodePort:                 plaintext  31050/TCP
    Endpoints:                10.16.129.6:8080,10.16.130.6:8080
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:
      Type    Reason                Age   From                Message
      ----    ------                ----  ----                -------
      Normal  EnsuringLoadBalancer  39s   service-controller  Ensuring load balancer
      Normal  EnsuredLoadBalancer   4s    service-controller  Ensured load balancer
    ```
1.  В [консоли управления]({{ link-console-main }}) откройте раздел **{{ load-balancer-name }}**. Там должен появиться балансировщик нагрузки с префиксом `k8s` в имени и уникальным идентификатором вашего кластера {{ k8s }} в описании.

## Проверьте результат {#check-result}

Чтобы проверить результат, выполните команду:

```
$ curl http://<IP-адрес из поля LoadBalancer Ingress> 
Hello, world!
Running in 'hello-9ffd9ff9b-4jnxs'
```

## Дополнительные настройки для сервиса типа LoadBalancer {#advanced}

В {{ managed-k8s-short-name }} для сервиса типа `LoadBalancer` доступны следующие дополнительные настройки:

- Назначение [заранее зарезервированного IP-адреса](../../vpc/operations/get-static-ip.md) с помощью параметра `loadBalancerIP`.
- Управление трафиком с помощью параметра [externalTrafficPolicy](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15/#service-v1-core): 
    - `Local` — трафик напрямую попадает на узлы, где запущены контейнеры приложений. При этом: 
        - Сохраняется IP-адрес запроса пользователя.
        - Используется меньше горизонтального трафика между виртуальными машинами.
    - `Cluster` — трафик попадает на любой из узлов кластера {{ k8s }}. При этом: 
        - В случае отсутствия нужных подов на узле, трафик перенаправляется с помощью [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) на другой узел. 
    
Параметры `loadBalancerIP` и `externalTrafficPolicy` не обязательные. Если их не указывать, балансировщик будет создан с динамическим IP-адресом и параметром `externalTrafficPolicy: Cluster`.
 
Пример спецификации сервиса типа `LoadBalancer`:

```
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
