# DNS

{{ stackland-name }} позволяет обращаться к сервисам кластера (как к Kubernetes API, так и к собственным сервисам, запущенным в кластере) извне по доменным именам.

Чтобы использовать DNS:

1. Перед созданием кластера выделите кластеру доменную зону на внешнем DNS-сервере.
2. Настройте делегирование выделенной доменной зоны: создайте NS- и A-записи для IP-адресов серверов с ролью `control-plane` или `combined`.
3. Пропишите доменную зону в параметре `cluster.baseDomain.fqdn` инсталлятора.

{{ stackland-name }} обеспечивает доступ к DNS на порту 53 (UDP и TCP) выбранных адресов.

## Подзоны и правила создания записей {#subzones-and-record-creation-rules}

В выделенной для кластера зоне существуют следующие подзоны:

* [системные записи](#sys-subzone) — подзона используется для размещения записей системных сервисов {{ stackland-name }};
* [подзона svc](#svc-subzone) — подзона используется для автоматического создания записей сервисов с типом `LoadBalancer`;
* [корневая подзона](#root-subzone) — используется для размещения записей пользовательских сервисов.

### Системные записи {#sys-subzone}

Подзона `sys.{{ cluster-domain }}` предназначена для размещения записей системных сервисов {{ stackland-name }}. Чтобы предотвратить конфликты имен при добавлении новых системных сервисов, пользователь не может создавать записи в этой подзоне. Например, невозможно создать ресурс Ingress с доменом `ingress.sys.{{ cluster-domain }}`.

Примеры системных записей в подзоне:
- `api.sys.{{ cluster-domain }}` — доступ к Kubernetes API;
- `console.sys.{{ cluster-domain }}` — доступ к консоли управления;
- `grafana.sys.{{ cluster-domain }}` — доступ к интерфейсу Grafana;
- `storage.sys.{{ cluster-domain }}` — доступ к {{ objstorage-name }} API.

### Подзона svc {#svc-subzone}

Подзона `svc` используется для автоматического создания DNS-записей для сервисов типа `LoadBalancer`.

Если пользователь не указал аннотацию `dns.stackland.yandex.cloud/hostname`, сервис будет доступен по умолчанию по следующему имени: `<название сервиса>.<название проекта>.svc.{{ cluster-domain }}`.

Рассмотрим пример создания сервиса без указания аннотации `dns.stackland.yandex.cloud/hostname`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: kafka01
  namespace: billing
spec:
  type: LoadBalancer
  # ...
```

В этом случае сервис будет автоматически доступен по имени `kafka01.billing.svc.{{ cluster-domain }}`.

### Корневая подзона {#root-subzone}

Корневая подзона предназначена для размещения пользовательских DNS-записей с помощью Ingress и Service с типом LoadBalancer. Пользователь может создавать в зоне произвольные записи, за исключением использования подзон `sys` и `svc`.

Примеры пользовательских записей:

- `phpmyadmin.{{ cluster-domain }}`;
- `phpmyadmin.warehouse.{{ cluster-domain }}`;
- `billing.prod.{{ cluster-domain }}`;
- `billing.test.{{ cluster-domain }}`;
- `pg01.bob.{{ cluster-domain }}`.

#### Создание DNS-записей

Для HTTP-сервисов пользователь может создать DNS-запись с помощью ресурса `Ingress`. Пример конфигурации:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: phpmyadmin
spec:
  ingressClassName: stackland-default
  rules:
  - host: phpmyadmin.{{ cluster-domain }} # это имя будет использовано для создания DNS-записи
    # ...
```

Для прочих сервисов:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: the-service
  annotations:
    dns.stackland.yandex.cloud/hostname: "the-service.{{ cluster-domain }}"
spec:
  type: LoadBalancer
  # ...
```

Ограничения:

* {{ stackland-name }} запрещает создание ресурсов, если значения параметра `host` в ресурсе `Ingress` и аннотации `dns.stackland.yandex.cloud/hostname` в ресурсе `Service` являются поддоменами `sys.{{ cluster-domain }}` и `svc.{{ cluster-domain }}`;
* {{ stackland-name }} не позволит создать ресурс `Ingress` или `Service`, если уже существует другой ресурс с таким же доменным именем.

## Внешняя и внутренняя DNS-зоны {#external-and-internal-zones}

В системе используются две DNS-зоны:

1. Внутренняя зона `*.cluster.local`, за обслуживание которой отвечает `kube-dns`.
2. Внешняя зона `*.{{ cluster-domain }}`.

### Сравнение зон {#comparison-of-zones}

#### Примеры записей {#example-records}

| **Внутренняя зона** (`*.cluster.local`) | **Внешняя зона** (`*.{{ cluster-domain }}`) |
| --- | --- |
| `kubernetes.default.svc.cluster.local` | `api.sys.{{ cluster-domain }}` |
| `storage.stackland-object-storage.svc.cluster.local` | `storage.sys.{{ cluster-domain }}` |
| `pg01-rw.my-namespace.svc.cluster.local` | `pg01-rw.my-namespace.svc.{{ cluster-domain }}` |
| `redmine.redmine.svc.cluster.local` | `redmine.{{ cluster-domain }}` |

#### Результат разрешения {#resolution-result}

| **Внутренняя зона** (`*.cluster.local`) | **Внешняя зона** (`*.{{ cluster-domain }}`) |
| --- | --- |
| IP-адрес в overlay-сети | IP-адрес из диапазона LoadBalancer |

#### Кто использует записи {#who-uses-records}

| **Внутренняя зона** (`*.cluster.local`) | **Внешняя зона** (`*.{{ cluster-domain }}`) |
| --- | --- |
| Сервисы, запущенные в кластере | Приложения, запущенные снаружи кластера, или пользователи |
