# Components {{ stackland-name }}

{{ stackland-full-name }} includes default components that are ready to use. A user can modify their settings, if required, through a special custom resource.

The components can be enabled and disabled as needed. Managing the components is handled through Component Manager.

## Main components {#main-components}

### {{ iam-name }}

[{{ iam-name }}](iam.md) is an identity and access management component that enables user authentication and authorization in clusters and projects. Through access bindings, users are assigned roles that define their permissions. SAML and LDAP federations are supported, as well as synchronization with Active Directory.

### CNI

CNI (Container Network Interface) is a standardized interface for Kubernetes components used to implement overlay networks. Overlay networks isolate applications you have running in Kubernetes from one another. {{ stackland-name }} uses [Cilium](https://www.cilium.io), a full-stack open source component. Cilium supports network policies allowing the administrator to manage network access to HTTP endpoints and other resources.

### Load Balancer {#load-balancer}

Network load balancer is a component implementing Kubernetes services of the `LoadBalancer` type. The load balancer in {{ stackland-name }} is built on Cilium and uses L2 announcements (ARP) to ensure fault tolerance. Future versions of {{ stackland-name }} may include alternative implementations of network load balancers and fault tolerance tools.

### Logging Stack {#logging-stack}

[Logging Stack](logging.md) implements logging in the cluster. This component includes the log aggregation system (Loki), the log shipper (Fluent Bit), and the log viewing interface (Grafana).

### DNS {#dns}

This component is responsible for resolving all names used in the {{ stackland-name }} cluster. It is based on [CoreDNS](https://coredns.io), the de facto in the Kubernetes ecosystem. The DNS server included in this component is the authoritative server for the zone assigned to the {{ stackland-name }} cluster when it was deployed. It resolves names assigned to the {{ stackland-name }} components, such as [Monitoring](#monitoring), as well as user resources like `Ingress` and `Service`.

### Ingress {#ingress}

This is a reverse proxy used as an L7 load balancer on pods that implement the backend of applications deployed in Kubernetes. It also terminates incoming HTTPS connections (see [Certificate Manager](#certificate-manager) for details). The {{ stackland-name }} implementation uses [ingress-nginx](https://kubernetes.github.io/ingress-nginx/), well-known and reliable Ingress controller for the NGINX web server.

### {{ certificate-manager-name }} {#certificate-manager}

[{{ certificate-manager-name }}](certificate-manager.md) is a cluster certificate management solution based on [cert-manager](https://cert-manager.io/). It automates the issuing of certificates and their placement in the cluster secrets, so they can be used by your services.

### Policy Manager {#policy-manager}

[Policy Manager](policy-manager.md) brings together tools that check Kubernetes resources for compliance with policies and generate reports in [OpenReports](https://openreports.io/docs/api/) format. The current implementation is based on [Kyverno](https://kyverno.io/).

### Secrets Store {#secrets-store}

[Secrets Store](secrets-store.md) is designed for managing secrets within the cluster. The Secrets Store is responsible for the secure storage and versioning of secrets, and their embedding into pods at startup. You can store passwords, tokens, private keys, and more in Secrets Store. It is based on [OpenBao](https://openbao.org/), a fork of [Vault](https://www.vaultproject.io/).

### Volumes {#volumes}

Volumes is a block storage management component based on [TopoLVM](https://github.com/topolvm/topolvm), a CSI (Container Storage Interface) driver for Kubernetes. It uses LVM on cluster nodes to create and manage volumes. This component can dynamically increase the size of volumes and accounts for available disk space before placing pods.

Learn more about the disk subsystem, storage classes, and monitoring in [Disk subsystem](disk-storage.md).

### {{ objstorage-name }} {#object-storage}

[{{ objstorage-name }}](storage.md) is an S3-compatiable object storage based on {{ objstorage-full-name }}. You can use it with any tools and SDKs that support the S3 API. The component allows you to manage your buckets using the `Bucket` resource. Access management is implemented via {{ iam-name }}.

### {{ monitoring-name }} {#monitoring}

[{{ monitoring-name }}](monitoring.md) offers tools for monitoring, metric visualization, and alerting.

Prometheus handles metric collection for cluster resources, running applications, and infrastructure. It uses the PromQL query language and provides ready-to-use agents for popular databases, web servers, message queues, and other services. Alertmanager configures alerting rules and processes alerts.

Logging is based on Loki. It collects logs centrally and allows analyzing them through Grafana. Fluent Bit ships logs to Loki.

While {{ stackland-name }} provides ready-to-use dashboards and alerts, you can also configure your own using familiar tools.

### {{ gpu-operator }} {#nvidia-gpu}

[{{ gpu-operator }}](gpu.md) is a component that provides {{ nvidia }} GPU support in clusters. It enables GPU discovery on nodes, driver installation, and integration with Kubernetes via Device Plugin.

## Platform components {#platform-components}

### {{ mpg-name }} {#postgresql}

[{{ mpg-name }}](postgresql.md) is an open-source object-relational DBMS. It simplifies database cluster deployment and upgrades, ensures fault-tolerance, and provides tools for backup and monitoring.

### {{ mkf-name }} {#kafka}

[{{ mkf-name }}](kafka.md) is a message broker that allows you to create {{ KF }} entities, such as clusters, topics, and users through custom resources, e.g., `KafkaCluster`, `KafkaTopic`, and `KafkaUserAccess`, respectively.

### {{ mch-name }} {#clickhouse}

[{{ mch-name }}](clickhouse.md) is a columnar analytical DBMS. It simplifies {{ CH }} cluster deployment and management as well as ensures monitoring and scaling.

## Modules {#modules} 

### {{ datalens-name }} {#datalens}

[{{ datalens-name }}](datalens.md) is a business analytics and data visualization platform. Use it to create interactive dashboards and charts based on various data sources. The component does not come with the basic package and requires a separate license.

### {{ speechsense-name }} {#speechsense}

[{{ speechsense-name }}](speechsense.md) is a speech analytics module for analyzing call recordings and text conversations. The component does not come with the basic package and requires a separate license.
