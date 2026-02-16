# Политики Gwin

Gwin — инструмент для создания балансировщиков нагрузки {{ alb-full-name }} и управления ими в [кластерах {{ managed-k8s-full-name }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

Контроллер поддерживает спецификации [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) и [Gateway API](https://gateway-api.sigs.k8s.io/). Для настройки дополнительных возможностей {{ alb-name }}, выходящих за рамки стандартной спецификации {{ k8s }}, реализован механизм политик, которые управляются с помощью [CustomResourceDefinitions](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/) или аннотаций.

Дополнительные возможности, которые предоставляет {{ alb-name }}:

* [Логирование](../../../application-load-balancer/concepts/monitoring.md#logging) и настройка правил отбрасывания логов.
* [Автомасштабирование](../../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) с контролем ресурсных единиц.
* [Зональное управление трафиком](../../../application-load-balancer/concepts/application-load-balancer.md#lb-location) для обеспечения высокой доступности сервисов.
* Гибкие настройки балансировки, включающие [локализацию трафика](../../../application-load-balancer/concepts/backend-group.md#locality) и [режим паники](../../../application-load-balancer/concepts/backend-group.md#panic-mode).
* Ограничение скорости обработки запросов на уровне виртуальных хостов.
* [Профили безопасности](../../../smartwebsecurity/concepts/profiles.md) и [WAF-защита](../../../smartwebsecurity/concepts/waf.md).
* Использование [групп безопасности](../../../vpc/concepts/security-groups.md).
* Интеграция с сервисами {{ yandex-cloud }} — [{{ certificate-manager-full-name }}](../../../certificate-manager/index.yaml), [{{ cloud-logging-full-name }}](../../../logging/index.yaml).

Механизм политик открывает доступ к этим возможностям. Он также позволяет:

* Расширять стандартные ресурсы с помощью аннотаций, не меняя спецификации этих ресурсов.
* Создавать сложные конфигурации из нескольких ресурсов политик.
* Объединять оба подхода для большей гибкости.

## Конфигурирование политик {#configure-policies}

Конфигурировать политики можно двумя равнозначными способами — с помощью аннотаций и ресурсов политик.

* Аннотации — быстрый способ добавить специфичные настройки к стандартным ресурсам. Аннотации поддерживают точечную нотацию, что позволяет создавать сложные вложенные конфигурации и записывать их в формате `ключ:значение`.

  Пример:

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: example-ingress
      annotations:
        gwin.yandex.cloud/subnets: "subnet-1,subnet2"
        gwin.yandex.cloud/logs.logGroupId: "group-1"
        gwin.yandex.cloud/rules.backends.balancing.mode: "ROUND_ROBIN"
    spec:
      ...
    ```

* Ресурсы политик — политики оформляются в виде отдельных ресурсов.

  Пример:

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: example-ingress
    spec:
      ...
    ---
    apiVersion: gwin.yandex.cloud/v1
    kind: IngressPolicy
    metadata:
      name: example-ingress-policy
    spec:
      targetRefs:
        - kind: Ingress
          name: example-ingress
      policy:
        subnets: ["subnet-1", "subnet2"]
        logs:
          logGroupId: "group-1"
        rules:
          backends:
            balancing:
              mode: "ROUND_ROBIN"
    ```

## Применение политик к целевым ресурсам {#apply-policies}

Политики можно применять к определенным ресурсам с помощью ссылок (`targetRefs`) или селекторов (`selector`).

Пример с использованием ссылки:

```yaml
kind: IngressPolicy
spec:
  targetRefs:
    - kind: Ingress
      name: my-app
...
```

Пример с использованием селектора:

```yaml
kind: IngressPolicy
spec:
  selector:
    matchLabels:
      environment: production
 ...
```

{% note info %}

Политики действуют только в пределах одного пространства имен {{ k8s }}.

{% endnote %}

## Слияние конфигураций {#merge-config}

Когда к одному ресурсу применяется несколько источников конфигурации, они объединяются. Настройки сливаются рекурсивно: вложенные объекты объединяются на всех уровнях. 

При объединении конфигурации проверяются на конфликты: если в разных источниках будут обнаружены одинаковые поля с разными значениями, возникнет ошибка валидации ресурса.

### Пример слияния {#merge-example}

Ресурс `Ingress` с аннотациями:

```yaml
kind: Ingress
metadata:
  annotations:
    gwin.yandex.cloud/subnets: "subnet-1,subnet-2"
    gwin.yandex.cloud/logs.logGroupId: "group-1"
```

Ресурс политики `IngressPolicy`:

```yaml
kind: IngressPolicy
spec:
  policy:
    securityGroups: ["sg-1"]
    rules:
      backends:
        balancing:
          mode: "ROUND_ROBIN"
```

Результат слияния настроек в единую конфигурацию:

```yaml
securityGroups: ["sg-1"]
logs:
  subnets: ["subnet-1", "subnet-2"]
  securityGroups: ["sg-1"]
  logGroupId: "group-1"
  rules:
    backends:
      balancing:
        mode: "ROUND_ROBIN"
```

### Слияние глобальных и специфичных настроек {#merge-global-specific}

Некоторые параметры можно задать как для всех объектов определенного типа, так и для конкретного объекта. Параметры для конкретного объекта не перезаписывают глобальные параметры и может возникнуть конфликт, если в разных источниках конфигурации в одном поле заданы разные значения.


Пример конфликтующих конфигураций:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: my-gateway
  annotations:
    # Параметр задан для всех обработчиков:
    gwin.yandex.cloud/listeners.http.protocolSettings.allowHTTP10: "true"
spec:
  ...
```

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: my-gateway
  annotations:
    # Параметр задан для конкретного обработчика «api»:
    gwin.yandex.cloud/listener.api.http.protocolSettings.allowHTTP10: "false"
spec:
  ...
```

## Решение проблем {#troubleshooting}

При возникновении проблем с политиками:

  1. Проверьте статус ресурсов. Ошибки валидации можно увидеть в поле `.status.conditions` описания объекта или в событиях {{ k8s }}.
  1. Убедитесь, что указано нужное пространство имен.
  1. Убедитесь, что `targetRefs` или `selector` указывают на нужные ресурсы.
  1. Если источников конфигурации несколько, убедитесь, что одинаковые поля в разных источниках имеют одинаковые значения.