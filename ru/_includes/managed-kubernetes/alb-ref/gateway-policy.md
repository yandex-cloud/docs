# Поля ресурса GatewayPolicy

Ресурс `GatewayPolicy` предназначен для задания облачных политик, которые применяются к ресурсам `Gateway` в рамках одного пространства имен {{ k8s }}. Политика может быть применена к определенным ресурсам с помощью ссылок (`targetRefs`) или селектора (`selector`). Если ни одно из этих полей не указано, политика применяется ко всем ресурсам в пространстве имен.

`GatewayPolicy` — это расширение Gateway API, реализуемое в {{ alb-name }}. Ниже описаны поля и аннотации ресурса, с которыми работает Gateway API {{ alb-name }}.

{% note info %}

Вы также можете задать параметры политик с помощью аннотаций ресурса `Gateway`. Набор параметров ресурса `GatewayPolicy` и аннотации `Gateway` равнозначны.

{% endnote %}

Пример определения ресурса `GatewayPolicy` (предназначен только для демонстрации всех параметров):

```yaml
apiVersion: gateway.alb.yc.io/v1
kind: GatewayPolicy
metadata:
  name: my-gateway-policy
spec:
  targetRefs:
    - name: some-gateway
      kind: Gateway
      group: gateway.networking.k8s.io
  
  selector:
    matchLabels:
      app: my-app

  policy:
    subnets: ["subnet-id-1", "subnet-id-2"]
    securityGroups: ["sg-id-1", "sg-id-2"]

    logs:
      logGroupID: "some-log-group-id"
      disable: false                 
      discardRule:
        http-errors:                 
          httpCodes: [404, 500]  
          httpCodeIntervals: ["4XX", "5XX"]
          discardPercent: 100   

    autoScale:
      minZoneSize: 2
      maxSize: 10 

    zone:
      ru-central1-a:  
        receiveTraffic: true
```

## GatewayPolicy {#gatewaypolicy}

```yaml
apiVersion: gateway.alb.yc.io/v1
kind: GatewayPolicy
metadata:
  name: <string>
  namespace: <string>
spec:
  targetRefs:
    - name: <string>
      kind: <string>
      group: <string>
  selector:
    matchLabels:
      <string>: <string>
    matchExpressions:
      - key: <string>
        operator: <string>
        values:
          - <string>
  policy:
    subnets: [...]
    securityGroups: [...]
    logs: ...
    autoScale: ...
    zone: ...
status:
  conditions: [...]
  attachedGateways: <integer>
```

Где:

* `apiVersion`: `gateway.alb.yc.io/v1`
* `kind`: `GatewayPolicy`
* `metadata` (`ObjectMeta`, обязательное)

  Метаданные ресурса.

  * `name` (`string`, обязательное)
  
    Имя ресурса. Подробнее о формате см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

  * `namespace` (`string`)
  
    [Пространство имен](../../../managed-kubernetes/concepts/index.md#namespace), к которому относится ресурс. Значение по умолчанию — `default`.

* `spec` (`GatewayPolicySpec`, обязательное)

  Спецификация политики.

  * `targetRefs` (`[]LocalObjectReference`)

    Список ссылок на ресурсы, к которым применяется политика. Если указаны, политика применяется только к этим ресурсам.

  * `selector` (`LabelSelector`)

    Селектор для выбора ресурсов по меткам. Если указан, политика применяется только к выбранным ресурсам.

  * `policy` (`Gateway`)

    Облачная конфигурация, применяемая к выбранным ресурсам. Подробнее см. [ниже](#gatewaypolicy-gateway).

* `status` (`GatewayPolicyStatus`)

  Текущее состояние политики.

  * `conditions` — массив условий статуса. Подробнее о формате см. в [документации {{ k8s }}](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#condition-v1-meta).

  * `attachedGateways` — количество привязанных ресурсов `Gateway`.

## Gateway {#gatewaypolicy-gateway}

Ресурс, определяющий облачные параметры балансировщика, которые могут быть заданы через политику.

```yaml
subnets: [<string>, ...]
securityGroups: [<string>, ...]
logs:
  logGroupID: <string>
  disable: <bool>
  discardRule:
    <имя_правила>:
      httpCodes: [<int>, ...]
      httpCodeIntervals: [<string>, ...]
      grpcCodes: [<string>, ...]
      discardPercent: <int>
autoScale:
  minZoneSize: <int>
  maxSize: <int>
zone:
  <зона_доступности>:
    receiveTraffic: <bool>
```

Где:

* `subnets` (`[]string`)

  Список [подсетей](../../../vpc/concepts/network.md#subnet) {{ vpc-name }} в [зонах доступности](../../../overview/concepts/geo-scope.md), где размещен балансировщик. Идентификаторы подсетей перечисляются через запятую.

* `securityGroups` (`[]string`)

  Список [групп безопасности](../../../vpc/concepts/security-groups.md) {{ vpc-name }} для балансировщика. Идентификаторы групп перечисляются через запятую.

  Для корректной работы балансировщика и Gateway API группы безопасности должны быть настроены, как описано в разделе [{#T}](../../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md).

* `logs` (`LogOptions`)

  Параметры логирования балансировщика.

  * `logGroupID` (`string`)
  
    Идентификатор [лог-группы](../../../logging/concepts/log-group.md) для записи [логов балансировщика](../../../application-load-balancer/logs-ref.md) в {{ cloud-logging-full-name }}.

  * `disable` (`bool`)
  
    Отключение логирования.

  * `discardRule` (`map[string]string`)

    Правила отбрасывания логов.

    * `httpCodes` (`[]int`)

      HTTP-коды, которые будут отброшены.

    * `httpCodeIntervals` (`[]string`)

      Группы HTTP-кодов (например, `4xx`), которые будут отброшены.

    * `grpcCodes` (`[]string`)

      Коды gRPC, которые будут отброшены.

    * `discardPercent` (`int`)
    
      Процент логов, которые будут отброшены (`0` — все сохраняются, `100` — все отбрасываются).

* `autoScale` (`AutoScalePolicy`)

  Параметры масштабирования балансировщика.

  * `minZoneSize` (`int`)
  
    Минимальное количество [ресурсных единиц](../../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) в каждой зоне доступности. По умолчанию минимум равен 2. Указать минимальное значение меньше 2 нельзя.

  * `maxSize` (`int`)
  
    Максимальное суммарное количество ресурсных единиц.

* `zone` (`map[string]string`)

  Параметры для отдельных зон доступности.

  * `receiveTraffic` (`bool`)
  
    Если `true`, трафик на узлы балансировщика в этой зоне отключен.
