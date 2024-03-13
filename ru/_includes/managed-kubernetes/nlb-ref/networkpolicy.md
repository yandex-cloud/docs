# Поля и аннотации ресурса NetworkPolicy

Ресурс `NetworkPolicy` используется для подключения к сервисам, опубликованным через {{ network-load-balancer-name }}, с определенных IP-адресов.

`NetworkPolicy` — стандартный ресурс {{ k8s }}. В этом справочнике описаны поля и аннотации ресурса, которые поддерживают {{ network-load-balancer-name }} для {{ managed-k8s-name }}. Полный справочник ресурса см. в [документации {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/policy-resources/network-policy-v1/).

## NetworkPolicy {#network-policy}

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata: <ObjectMeta>
spec: <NetworkPolicySpec>
```

#|
|| **Поле**     | **Значение или тип**   | **Описание**                   ||
|| `apiVersion` | `networking.k8s.io/v1` | **Обязательное**
                                           Версия API Kubernetes          ||
|| `kind`       | `NetworkPolicy`        | Тип ресурса                    ||
|| `metadata`   | `ObjectMeta`           | **Обязательное**
                                          [Метаданные ресурса](#metadata) ||
|| `spec`       | `NetworkPolicySpec`    | **Обязательное**
                                          [Спецификация ресурса](#spec)   ||
|#

{% cut "Пример" %}

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: whitelist-netpol
  namespace: ns-example
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
  - Ingress
  ingress:
  - from:
    - ipBlock:
        cidr: 198.18.235.0/24
    - ipBlock:
        cidr: 198.18.248.0/24
    - ipBlock:
        cidr: 172.16.1.0/12
```

{% endcut %}

## ObjectMeta {#metadata}

```yaml
name: <string>
namespace: <string>
```

#|
|| **Поле**      | **Значение или тип** | **Описание** ||
|| `name`        | `string`             | **Обязательное**
[Имя политики](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names) ||
|| `namespace` | `string`  | [Пространство имен](../../../managed-kubernetes/concepts/index.md#namespace) для сохранения политики ||
|#

## NetworkPolicySpec {#spec}

```yaml
podSelector: <selectorRules>
policyTypes:
  - Ingress
ingress:
  - <IngressRule>
  - ...
```

#|
|| **Поле** | **Значение или тип** | **Описание** ||
|| `podSelector`   | `LabelSelector` | **Обязательное**
Правила фильтрации [подов](../../../managed-kubernetes/concepts/index.md#pod).

См. [документацию {{ k8s }}](https://kubernetes.io/docs/reference/kubernetes-api/common-definitions/label-selector/#LabelSelector)
||

|| `policyTypes`    | `[]Policy`      | **Обязательное**
Тип политики. Только значение `Ingress`.
||

|| `ingress` | `[]IngressRule` | **Обязательное**
[Список правил фильтрации трафика](#rule)
||
|#

### IngressRule {#rule}

```yaml
from:
  - ipBlock: <IPBlock>
  - ...
```

#|
|| **Поле** | **Значение или тип** | **Описание** ||
|| `from`   | `[]IPBlock`          | **Обязательное**
Список [диапазонов IP-адресов](#ipblock), с которых разрешен доступ к балансировщику
||
|#

### IPBlock {#ipblock}

```yaml
ipBlock:
  cidr: <string>
```

#|
|| **Поле** | **Значение или тип** | **Описание** ||
|| `cidr`      | `string`       | **Обязательное**
Диапазон IP-адресов, с которых разрешен доступ к балансировщику.

Диапазоны `198.18.235.0/24` и `198.18.248.0/24` указываются всегда, так как они [зарезервированы {{ network-load-balancer-name }}](../../../network-load-balancer/concepts/health-check.md#target-statuses) для проверки состояния узлов
||
|#