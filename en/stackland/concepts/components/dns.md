# DNS

{{ stackland-name }} allows you to access cluster services (both the Kubernetes API and native services running in the cluster) from the outside using domain names.

To use DNS:

1. Before creating a cluster, allocate a domain zone to the cluster on an external DNS server.
1. Set up delegation of the dedicated domain zone: create NS and A records for the IP addresses of servers with the `control-plane` or `combined` role.
1. Specify the domain zone in the `cluster.baseDomain.fqdn` installer property.

{{ stackland-name }} provides DNS access on port 53 (UDP and TCP) for selected addresses.

## Subzones and record creation rules {#subzones-and-record-creation-rules}

The zone allocated to the cluster contains the following subzones:

* [System records](#sys-subzone): Used to host records of {{ stackland-name }} system services.
* [SVC subzone](#svc-subzone): Used to automatically create service records with the `LoadBalancer` type.
* [Root subzone](#root-subzone): Used to host user service records.

### System records {#sys-subzone}

The `sys.{{ cluster-domain }}` subzone is intended for hosting {{ stackland-name }} system service records. To prevent name conflicts when adding new system services, the user cannot create records in this subzone. For example, you cannot create an Ingress resource with the `ingress.sys.{{ cluster-domain }}` domain.

Examples of system records in the subzone:
- `api.sys.{{ cluster-domain }}`: Access to the Kubernetes API.
- `console.sys.{{ cluster-domain }}`: Access to the management console.
- `grafana.sys.{{ cluster-domain }}`: Access to the Grafana interface.
- `storage.sys.{{ cluster-domain }}`: Access to the {{ objstorage-name }} API.

### SVC subzone {#svc-subzone}

The `svc` subzone is used to automatically create DNS records for services of the `LoadBalancer` type.

If you do not specify the `dns.stackland.yandex.cloud/hostname` annotation, the service will be available by default under the following name: `<service name>.<project name>.svc.{{ cluster-domain }}`.

Let's look at an example of creating a service without specifying the `dns.stackland.yandex.cloud/hostname` annotation:

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

In this case, the service will be automatically accessible by the following name: `kafka01.billing.svc.{{ cluster-domain }}`.

### Root subzone {#root-subzone}

The root subzone is designed to host custom DNS records using `Ingress` and `Service` with the `LoadBalancer` type. Users can create any records in the zone, with the exception of using the `sys` and `svc` subzones.

Examples of user records:

- `phpmyadmin.{{ cluster-domain }}`
- `phpmyadmin.warehouse.{{ cluster-domain }}`
- `billing.prod.{{ cluster-domain }}`
- `billing.test.{{ cluster-domain }}`
- `pg01.bob.{{ cluster-domain }}`

#### Creating DNS records

For HTTP services, users can create a DNS record using the `Ingress` resource. Configuration example:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: phpmyadmin
spec:
  ingressClassName: stackland-default
  rules:
  - host: phpmyadmin.{{ cluster-domain }} # This name will be used to create a DNS record.
    # ...
```

For other services:

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

The following restrictions apply:

* {{ stackland-name }} will block creating resources if the `host` value in the `Ingress` resource and the `dns.stackland.yandex.cloud/hostname` annotation value in the `Service` resource are subdomains of `sys.{{ cluster-domain }}` and `svc.{{ cluster-domain }}`.
* {{ stackland-name }} prevents the creation of an `Ingress` or `Service` resource if another resource already uses the same domain name.

## External and internal DNS zones {#external-and-internal-zones}

The system uses two DNS zones:

1. `*.cluster.local` internal zone, maintained by `kube-dns`.
1. `*.{{ cluster-domain }}` external zone.

### Zone comparison {#comparison-of-zones}

#### Example records {#example-records}

| **Internal zone** (`*.cluster.local`) | **External zone** (`*.{{ cluster-domain }}`) |
| --- | --- |
| `kubernetes.default.svc.cluster.local` | `api.sys.{{ cluster-domain }}` |
| `storage.stackland-object-storage.svc.cluster.local` | `storage.sys.{{ cluster-domain }}` |
| `pg01-rw.my-namespace.svc.cluster.local` | `pg01-rw.my-namespace.svc.{{ cluster-domain }}` |
| `redmine.redmine.svc.cluster.local` | `redmine.{{ cluster-domain }}` |

#### Resolution result {#resolution-result}

| **Internal zone** (`*.cluster.local`) | **External zone** (`*.{{ cluster-domain }}`) |
| --- | --- |
| IP address in the overlay network | IP address from the `LoadBalancer` range |

#### Who uses records {#who-uses-records}

| **Internal zone** (`*.cluster.local`) | **External zone** (`*.{{ cluster-domain }}`) |
| --- | --- |
| Services running in the cluster | Applications running outside the cluster, or users |