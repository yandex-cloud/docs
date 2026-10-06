[Документация Yandex Cloud](../../../index.md) > [Yandex Application Load Balancer](../../index.md) > [Инструменты для Managed Service for Kubernetes](../index.md) > [Gwin](index.md) > Маршрутизация трафика напрямую в поды кластера

# Маршрутизация трафика Application Load Balancer напрямую в поды кластера Yandex Managed Service for Kubernetes с Gwin 

По умолчанию Application Load Balancer направляет трафик на NodePort сервиса, а [Yandex Managed Service for Kubernetes](../../../managed-kubernetes/index.md) с помощью `kube-proxy` перенаправляет его в один из подов. Схема выглядит так:

![image](../../../_assets/application-load-balancer/routing-to-nodeport.svg)

При маршрутизации напрямую в поды Gwin регистрирует IP‑адреса подов в целевой группе Application Load Balancer и балансировщик направляет запрос сразу в под:

![image](../../../_assets/application-load-balancer/routing-to-pods.svg)

Это убирает промежуточный переход через узел, снижает задержку, разгружает узлы и позволяет Application Load Balancer балансировать запросы между подами напрямую.

## Сравнение маршрутизации в поды и в NodePort {#routing-compare}

| Сценарий | Маршрутизация в поды | NodePort |
| --- | --- | --- |
| Распределение нагрузки | Application Load Balancer равномерно распределяет запросы между всеми готовыми подами. | Application Load Balancer переиспользует соединения с узлами, а `kube-proxy` выбирает под только при открытии соединения. Часть реплик может не получать трафик. |
| Масштабирование и [канареечное развертывание](https://martinfowler.com/bliki/CanaryRelease.html) | Новые готовые реплики сразу включаются в распределение нагрузки. Масштабирование разгружает работающие поды, а канареечная версия получает свою долю трафика. | Новые поды не обязательно получают трафик, пока Application Load Balancer держит старые соединения с узлами. |
| Проверка готовности и штатное завершение | После настройки Health Check Application Load Balancer перестает направлять запросы в неготовый под. При завершении Gwin удаляет под из целевой группы до остановки приложения. | `kube-proxy` не направляет в неготовый под новые соединения, но не прерывает существующие. Под может продолжать получать запросы после статуса `NotReady` и во время завершения. |
| Путь трафика | `Application Load Balancer -> Под` | `Application Load Balancer -> Узел:NodePort -> Под` |
| Задержка и нагрузка на узел | Нет промежуточного узла, его сетевого стека и `kube-proxy`. | Дополнительный переход увеличивает задержку и занимает сетевые ресурсы узла. |

{% note info %}

Преимущества маршрутизации в поды напрямую зависят от правильной настройки условий готовности (`readinessGate`), хука `preStop`, времени завершения пода и Health Check.

{% endnote %}

При аварийном завершении пода или недоступности узла во время маршрутизации в поды Application Load Balancer продолжает отправлять часть запросов в эту цель. Пока Health Check не признает цель нездоровой, возможны ошибки 5xx или таймауты. 

При маршрутизации в NodePort соединение с аварийно завершившимся подом разрывается, и Kubernetes направляет новые соединения в оставшиеся поды. Поэтому, если приложение часто завершается аварийно и не может перенести это окно, используйте маршрутизацию в NodePort или настройте повторные попытки на стороне клиента — это поможет сгладить кратковременные сбои.

## Особенности работы с Cilium в туннельном режиме {#cilium-features}

В Managed Service for Kubernetes в кластерах с сетевым контроллером [Cilium](../../../managed-kubernetes/concepts/network-policy.md#cilium) в [туннельном режиме](https://docs.cilium.io/en/v1.14/network/concepts/routing/#encapsulation) IP‑адреса подов недоступны из сети напрямую. CIDR‑диапазоны подов живут только в логической сети и не маршрутизируются [Virtual Private Cloud](../../../vpc/index.md). Поэтому Application Load Balancer не может напрямую обращаться к IP‑адресам подов.

Чтобы связать маршруты до сетей подов через узлы кластера и подсеть Application Load Balancer, Gwin создает таблицу маршрутов. На каждого владельца создается одна таблица с меткой `gwin-owner: <owner>`: 

* Если подсеть Application Load Balancer уже содержит таблицу этого владельца — она принимается в управление.
* Если ни одна подсеть Application Load Balancer не содержит таблицы — создается новая и привязывается ко всем подсетям.
* Если подсеть Application Load Balancer содержит таблицу без метки владельца — Gwin останавливается с событием `PodRouteSubnetConflict`.
* Таблица, которая больше не нужна, автоматически отсоединяется и удаляется. Это происходит, например, когда удаляется последний сервис, в котором в качестве цели используются поды.

{% note info %}

Таблица маршрутов управляется исключительно Gwin. Не добавляйте в нее маршруты и не привязывайте ее к другим подсетям — Gwin заменяет полный список маршрутов при каждой синхронизации.

{% endnote %}

Для корректной работы маршрутизации в поды в кластере с Cilium должны быть выполнены условия: 

* Для Application Load Balancer выделена подсеть отдельно от узлов кластера. Не создавайте Application Load Balancer в подсети узлов кластера.
* [Сервисному аккаунту](*sa) Gwin [назначены](../../../iam/operations/sa/assign-role-for-sa.md) роли: 
   * `vpc.privateAdmin` — для управления таблицами маршрутов и ассоциациями подсетей;  
   * `k8s.viewer` — для обнаружения кластера.
* Есть [квоты](*quotas) на создание статических маршрутов (`vpc.staticRoutes.count`). Каждому узлу выделяется свой pod-CIDR, поэтому нужен один статический маршрут на узел. По умолчанию квота — 256 маршрутов на облако.
* CIDR подов не пересекается с диапазонами подсетей. Для одинакового IP‑адреса появятся два конфликтующих маршрута.

Даже если выполнены все условия, Gwin не начинает управлять маршрутами, пока не убедится в том, что:

1. В ресурсах Gateway API или Ingress есть ссылка на сервис, который использует в качестве цели поды.
1. Кластеру действительно нужны внутренние маршруты. Gwin проверяет, что Cilium в туннельном режиме. В кластерах с изначально маршрутизируемыми CIDR‑диапазонами подов (например, Calico или Cilium с `routing_mode=direct`) Gwin остается в режиме ожидания.
1. Каждая подсеть Application Load Balancer выделена исключительно для балансировщика и не используется ни одной группой узлов кластера. Если подсеть используется совместно, Gwin генерирует событие `PodRouteSubnetConflict` и не создает и не обновляет таблицы маршрутов.

## Настройка маршрутизации в поды {#setup}

Для примера минимальной настройки маршрутизации в поды используется HTTP‑приложение. Эндпоинт приложения `GET /healthz` возвращает `200`, когда под готов принимать трафик.

{% note warning %}

Маршрутизация в поды работает с Gwin версии 1.9.1 и выше.

{% endnote %}

Если вы еще не устанавливали Gwin, сделайте это по инструкции [Установка контроллера Gwin](quickstart.md). После этого сконфигурируйте приложение по инструкции ниже. Несколько установок Gwin или кластеров, совместно использующих сеть, не поддерживаются.

### Создайте Gateway {#create-gateway}

Чтобы определить, как Application Load Balancer будет принимать входящий трафик, создайте `Gateway`:

   ```yaml
   apiVersion: gateway.networking.k8s.io/v1
   kind: Gateway
   metadata:
     name: example-gateway
     annotations:
       gwin.yandex.cloud/subnets: <идентификатор_подсети>
       gwin.yandex.cloud/securityGroups: <идентификатор_группы_безопасности>
   spec:
     gatewayClassName: gwin-default
     listeners:
       - name: http
         protocol: HTTP
         port: 80
         allowedRoutes:
           namespaces:
             from: Same
   ```

   Где:

   * `gwin.yandex.cloud/subnets` — подсеть, в которой будет создан Application Load Balancer. Важно, чтобы эта подсеть не была занята узлами кластера. Это особенно критично при работе с Cilium в туннельном режиме.
   * `gwin.yandex.cloud/securityGroups` — [группа безопасности](*sec-group), которая настроена на сети с балансировщиком.
   * `gatewayClassName: gwin-default` — указание контроллеру Gwin, что этот Gateway нужно обработать и создать для него балансировщик.
   * `listeners` — описание того, как именно балансировщик будет слушать трафик: протокол, порт, разрешенные маршруты.

### Настройте Deployment {#setup-deployment}

`Deployment` управляет жизненным циклом подов: их созданием, обновлением и перезапуском. Для маршрутизации в поды критически важны настройки, которые синхронизируют состояние пода в Kubernetes с его регистрацией в Application Load Balancer. 

Настройте `Deployment`:

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: example-app
   spec:
     selector:
       matchLabels:
         app: example-app
     template:
       metadata:
         labels:
           app: example-app
       spec:
         readinessGates:
           - conditionType: gwin.yandex.cloud/load-balanced
         terminationGracePeriodSeconds: 30
         containers:
           - name: app
             image: example-app:latest
             ports:
               - containerPort: 8080
             readinessProbe:
               httpGet:
                 path: /healthz
                 port: 8080
             lifecycle:
               preStop:
                 exec:
                   command: ["sh", "-c", "sleep 30"]
   ```

   Где:
   
   * `readinessGates` — условие готовности пода. Под не перейдет в статус `Ready`, пока Gwin не зарегистрирует его в целевой группе Application Load Balancer. Это предотвращает отправку трафика в под, который еще не виден балансировщику.
   * `terminationGracePeriodSeconds: 30` и `preStop: sleep 30` — время, в течение которого под остается «живым» после получения сигнала о завершении. Это нужно, чтобы Gwin успел удалить под из целевой группы Application Load Balancer до того, как приложение остановится. Без этого под может продолжать получать запросы даже после начала завершения.
   * `readinessProbe` — проверка готовности приложения принимать трафик. Для Application Load Balancer будет отдельно настроен аналогичный Health Check, чтобы не отправлять запросы в неготовые поды.

### Настройте Service {#setup-service}

`Service` группирует поды и предоставляет им стабильный сетевой адрес. Явно укажите, что нужно направлять трафик напрямую в поды, а не через NodePort:

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: example-app
     annotations:
       gwin.yandex.cloud/targets.type: Pod
       gwin.yandex.cloud/targets.cidrs: <pod-CIDR>
       gwin.yandex.cloud/targets.albZoneMatch: "false"
   spec:
     type: ClusterIP
     selector:
       app: example-app
     ports:
       - name: http
         port: 80
         targetPort: 8080
   ```

   Где:
   
   * `gwin.yandex.cloud/targets.type: Pod` — ключевая аннотация, которая говорит Gwin направлять трафик напрямую в поды.
   * `gwin.yandex.cloud/targets.cidrs` — аннотация гарантирует, что если в кластере есть поды с IP-адресами из разных сетей, в целевую группу Application Load Balancer попадут только поды из указанного CIDR.
   * `gwin.yandex.cloud/targets.albZoneMatch: "false"` — аннотация разрешает использовать поды, которые находятся в зонах, где нет экземпляров Application Load Balancer. Рекомендуется размещать Application Load Balancer во всех зонах с подами, но эта настройка дает гибкость в особых случаях.
   * `type: ClusterIP` — стандартный тип сервиса, который не создает внешние IP, но позволяет Gwin извлекать IP подов для регистрации в Application Load Balancer.

### Создайте HTTPRoute {#httproute-create}

HTTPRoute определяет маршрутизацию на уровне приложения. Создайте HTTPRoute:

   ```yaml
   apiVersion: gateway.networking.k8s.io/v1
   kind: HTTPRoute
   metadata:
     name: example-route
   spec:
     parentRefs:
       - name: example-gateway
     hostnames:
       - app.example.com
     rules:
       - backendRefs:
           - name: example-app
             port: 80
   ```

   Где:

   * `parentRefs` — связывает маршрут с конкретным Gateway. Трафик, приходящий на этот Gateway, будет обрабатываться по правилам этого HTTPRoute.
   * `hostnames` — определяет, для каких доменных имен действует этот маршрут.
   * `backendRefs` — указывает, куда именно направлять трафик.

### Настройте Health Check Application Load Balancer

Application Load Balancer должен самостоятельно проверять, готов ли под принимать трафик, и исключать из балансировки те поды, которые не отвечают. Gwin не создает эти проверки автоматически, поэтому их нужно настроить явно. Health check должен соответствовать `readinessProbe` приложения, чтобы статусы в Kubernetes и Application Load Balancer были синхронизированы.

Настройте Health Check Application Load Balancer с помощью `RoutePolicy` или аннотациями на `HTTPRoute`. Рекомендуем использовать первый вариант. 

{% list tabs %}

- RoutePolicy

   ```yaml
   apiVersion: gwin.yandex.cloud/v1
   kind: RoutePolicy
   metadata:
     name: example-app
   spec:
     targetRefs:
       - group: gateway.networking.k8s.io
         kind: HTTPRoute
         name: example-route
     policy:
       rules:
         backends:
           hc:
             interval: 3s
             timeout: 3s
             unhealthyThreshold: 1
             http:
               path: /healthz
   ```

- Аннотации

   ```yaml
   metadata:
     annotations:
       gwin.yandex.cloud/rules.backends.hc.interval: "3s"
       gwin.yandex.cloud/rules.backends.hc.timeout: "3s"
       gwin.yandex.cloud/rules.backends.hc.unhealthyThreshold: "1"
       gwin.yandex.cloud/rules.backends.hc.http.path: /healthz
   ```

{% endlist %}

Для gRPC‑ и TCP‑бэкендов вместо `http` настройте соответствующую проверку `grpc` или `stream` в `RoutePolicy`.

## Проверка и диагностика {#inspection-and-diagnostic}

После настройки маршрутизации в поды убедитесь, что Gateway, маршрут и политика приняты контроллером:

```bash
kubectl get gateway example-gateway
kubectl get httproute example-route
kubectl get routepolicy example-app
```

У Gateway и HTTPRoute должен быть статус `Ready`, а `RoutePolicy` применена.

Новый под не станет `Ready`, пока Gwin не зарегистрирует его в целевой группе Application Load Balancer. Чтобы проверить состояние пода, воспользуйтесь командой:

```bash
kubectl describe pod <pod-name>
```

В разделе `Conditions` найдите условие `gwin.yandex.cloud/load-balanced` со значением `True`.

Если ресурс не переходит в статус `Ready`, проверьте события:

```bash
kubectl get events --sort-by=.lastTimestamp
```

Описание основных событий:

| Событие | Описание |
|--------|----------|
| `PodRouteSubnetConflict` | Подсеть Application Load Balancer используется группой узлов кластера или содержит таблицу маршрутов другого владельца, либо владелец не указан. Маршруты для подов остановлены. |
| `PodRouteDetectFailed` | Не удалось определить кластер или его режим маршрутизации — отсутствуют метки узлов или нет роли `k8s.clusters.get`. |
| `PodRouteSyncFailed` | Не удалось выполнить выбор маршрута или облачную операцию. Например, неоднозначные внутренние IP-адреса узлов или превышение квоты. |
| `PodRouteSkipped` | CIDR‑диапазон подов узла пока нельзя маршрутизировать. Например, у узла нет подходящего внутреннего IP. |

### Полезные метрики {#metrics}

| Метрика | Описание |
|--------|----------|
| `gwin_pod_routes_managed` | Маршруты владельца в таблице. |
| `gwin_pod_routes_table_size` | Общее количество маршрутов в таблице. Полезно для контроля квот. |
| `gwin_pod_routes_sync_errors_total` | Количество неудачных попыток синхронизации. |
| `gwin_pod_routes_last_sync_timestamp` | Время последней успешной синхронизации. |


[*sa]: Аккаунт, от имени которого контроллер будет создавать ресурсы Application Load Balancer и назначать им роли. Подробнее о сервисных аккаунтах в [документации](../../../iam/concepts/users/service-accounts.md).

[*quotas]: *Квоты* — организационные ограничения, которые можно изменить по запросу в техническую поддержку. Подробнее о квотах Virtual Private Cloud на [странице](../../../vpc/concepts/limits.md). 

[*sec-group]: *Группа безопасности* — это ресурс, который создается на уровне облачной сети и используется в сервисах Yandex Cloud для разграничения сетевого доступа объекта, к которому она применяется. Подробнее в разделе [Группы безопасности](../../../vpc/concepts/security-groups.md).