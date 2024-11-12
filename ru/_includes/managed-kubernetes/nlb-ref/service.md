# Поля и аннотации ресурса Service

Ресурс `Service` определяет [сервис {{ k8s }}](../../../managed-kubernetes/concepts/index.md#service). Для {{ network-load-balancer-name }} для {{ managed-k8s-name }} сервисы представляют собой балансировщики входящего трафика.

`Service` — стандартный ресурс {{ k8s }}. В этом справочнике описаны поля и аннотации ресурса, которые поддерживаются {{ network-load-balancer-name }} для {{ managed-k8s-name }}. Полный справочник ресурса см. в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

## Service {#service}

```yaml
apiVersion: v1
kind: Service
metadata: <ObjectMeta>
spec: <ServiceSpec>
```

#|
|| **Поле**     | **Значение или тип**   | **Описание**                   ||
|| `apiVersion` | `v1` | **Обязательное**
                                           Версия API Kubernetes          ||
|| `kind`       | `Service`              | Тип ресурса                    ||
|| `metadata`   | `ObjectMeta`           | **Обязательное**
                                          [Метаданные ресурса](#metadata) ||
|| `spec`       | `ServiceSpec`          | **Обязательное**
                                          [Спецификация ресурса](#servicespec)   ||
|#

{% cut "Пример" %}

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nlb-demo-1
spec:
  selector:
    app: app-demo-1
  type: LoadBalancer
  ports:
    - port: 80
      name: plaintext
      targetPort: 8080
```

{% endcut %}

## ObjectMeta {#metadata}

```yaml
name: <string>
annotations:
  yandex.cloud/load-balancer-type: <string>
  yandex.cloud/subnet-id: <string>
  yandex.cloud/load-balancer-healthcheck-healthy-threshold: <string>
  yandex.cloud/load-balancer-healthcheck-interval: <string>
  yandex.cloud/load-balancer-healthcheck-timeout: <string>
  yandex.cloud/load-balancer-healthcheck-unhealthy-threshold: <string>
```

#|
|| **Поле**      | **Значение или тип** | **Описание** ||
|| `name`        | `string`             | **Обязательное**
[Имя ресурса](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names)

Не соответствует имени балансировщика в {{ network-load-balancer-name }} ||
|| `annotations` | `map[string]string`  | [Аннотации ресурса](#annotations) ||
|#

### Аннотации (metadata.annotations) {#annotations}

Аннотации — это коллекция пар `ключ:значение`, которые используются для присвоения метаданных объекту. Значения аннотаций всегда имеют тип данных `string`. Подробнее об аннотациях см. в [документации Kubernetes](https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/).

Для объекта `ObjectMeta` можно передать следующие аннотации:

* **yandex.cloud/load-balancer-type**

  [Тип балансировщика](../../../network-load-balancer/concepts/nlb-types.md) (по умолчанию — с внешним IP-адресом).

  Значение для балансировщика с внутренним IP-адресом — `internal`.
* **yandex.cloud/subnet-id**

  Идентификатор подсети, в которой необходимо выделить IP-адрес для внутреннего сетевого балансировщика нагрузки.
* **yandex.cloud/load-balancer-healthcheck-healthy-threshold**

  Число последовательных удачных [проверок](../../../network-load-balancer/concepts/health-check.md), по достижении которого узел будет считаться доступным.

  Минимальное значение — `2`, максимальное значение — `10`.
* **yandex.cloud/load-balancer-healthcheck-interval**

  Интервал выполнения [проверок](../../../network-load-balancer/concepts/health-check.md) (в секундах).

  Минимальное значение — `2s`, максимальное значение — `300s`.
* **yandex.cloud/load-balancer-healthcheck-timeout**

  Таймаут выполнения [проверок](../../../network-load-balancer/concepts/health-check.md) (в секундах). Узел считается недоступным, если он не ответил за отведенное время.

  Минимальное значение — `1s`, максимальное значение — `60s`.
* **yandex.cloud/load-balancer-healthcheck-unhealthy-threshold**

  Число последовательных неудачных [проверок](../../../network-load-balancer/concepts/health-check.md), по достижении которого узел будет считаться недоступным.

  Минимальное значение — `2`, максимальное значение — `10`.

## ServiceSpec {#servicespec}

```yaml
type: LoadBalancer
ports:
  - <ServicePort>
  - ...
loadBalancerIP: <string>
externalTrafficPolicy: <string>
```

#|
|| **Поле** | **Значение или тип** | **Описание** ||
|| `type`   | `LoadBalancer` | **Обязательное**
Тип сервиса.

{% note warning %}

Сервисы {{ k8s }}, используемые в качестве сетевых балансировщиков нагрузки, должны иметь тип `LoadBalancer`. Подробнее об этом типе см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer).

{% endnote %}
||

|| `ports`    | `[]ServicePort`      | **Обязательное**
[Список портов, на которых доступен сервис](#ports).
||

|| `loadBalancerIP` | `string` | При использовании [внешнего балансировщика нагрузки](../../../network-load-balancer/concepts/nlb-types.md) в этом поле можно указать статический [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses). Такой адрес необходимо [зарезервировать заранее](../../../vpc/operations/get-static-ip.md). Во время резервирования публичного IP-адреса можно активировать [защиту от DDoS-атак](../../../vpc/ddos-protection/index.md).


Если не указывать статический IP-адрес, то сетевому балансировщику нагрузки будет назначен динамический IP-адрес ||
|| `externalTrafficPolicy` | `string` | [Политика управления трафиком]({{ k8s-api-link }}#servicespec-v1-core):

* `Cluster` — трафик попадает на любой из узлов кластера {{ k8s }}. В случае отсутствия нужных подов на узле, трафик перенаправляется с помощью [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy) на другой узел. Значение по умолчанию.
* `Local` — трафик напрямую попадает на узлы, где запущены [контейнеры приложений](../../../glossary/containerization.md#containers-apps). При этом:

  * Сохраняется IP-адрес запроса пользователя.
  * Используется меньше горизонтального трафика между виртуальными машинами.
||
|#

### ServicePort {#ports}

```yaml
name: <string>
port: <int32>
targetPort: <int32>
nodePort: <int32>
```

#|
|| **Поле** | **Значение или тип** | **Описание** ||
|| `name` | `string` | Имя порта внутри сервиса.
||
|| `port`    | `int32`      | **Обязательное**
Порт, на котором будут обслуживаться пользовательские запросы, поступающие к сервису.

Этот же порт будет назначен [обработчику](../../../network-load-balancer/concepts/listener.md) балансировщика нагрузки в качестве порта, на котором будет приниматься входящий трафик.
||
|| `targetPort`    | `int32`      | Порт контейнера, на котором доступно приложение.

Если не указывать это поле, то значение `targetPort` будет совпадать с `port`.

||
|| `nodePort`      | `int32`      | Порт, на котором будут обслуживаться пользовательские запросы, поступающие к сервису извне кластера.

Этот же порт будет назначен обработчику балансировщика нагрузки в качестве целевого порта, на котором ресурсы в целевой группе будут принимать трафик.

Обычно поле не указывается, поэтому значение `nodePort` выбирается автоматически в указанном диапазоне.

Однако вы можете указать нужный порт явно. Выбранный порт не должен использоваться другими объектами {{ k8s }}.

Диапазон значений: `{{ port-range-k8s-nodeport }}`.
||
|#
