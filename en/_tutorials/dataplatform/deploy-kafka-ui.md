# Deploying the {{ KF }} web interface

You can install the [{{ KF }} web interface](https://docs.kafka-ui.provectus.io/overview/readme) for your {{ mkf-name }} cluster. With a web interface, you can track data streams, troubleshoot, manage [brokers](../../managed-kafka/concepts/brokers.md), cluster, [producers, and consumers](../../managed-kafka/concepts/producers-consumers.md).


You can deploy the {{ KF }} web interface in two ways:

* In a [Docker container](#docker) on a {{ yandex-cloud }} virtual machine. This option is cheaper but less reliable, which makes it more suitable for getting started with the {{ KF }} web interface.
* In a [{{ managed-k8s-full-name }} cluster](#kubernetes). This option is more expensive and more reliable, which makes it suitable for consistent and long-term use of the web interface.


## Deploying in Docker containers {#docker}

To deploy the {{ KF }} web interface in a Docker container:

1. [Install additional dependencies](#infra-for-docker).
1. [Create a TrustStore](#truststore-for-docker).
1. [Set up the {{ KF }} web interface](#prepare-ui-via-docker).

If you no longer need the resources you created, [delete them](#clear-out).

### Getting started {#before-you-begin-to-work-with-docker}

Prepare the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

   
   1. [Configure a security group](../../managed-kafka/operations/connect.md#configuring-security-groups) for your {{ mkf-name }} cluster and VM so that you can connect to topics from a cloud-based VM.


   1. [Create a {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-create.md). When creating it, specify the configured security group.
   1. [Create an {{ KF }} user](../../managed-kafka/operations/cluster-accounts.md#create-user).
   1. In the network hosting the {{ mkf-name }} cluster, [create a VM](../../compute/operations/vm-create/create-linux-vm.md) running Ubuntu 22.04 with a public IP address, and the configured security group.

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
   1. Download the [kafka-ui-via-docker.tf](https://github.com/yandex-cloud-examples/yc-deploy-kafka-ui/blob/main/kafka-ui-via-docker.tf) configuration file to the same working directory.

      This file describes:

      * Network.
      * Subnet.
      * VM running Ubuntu 22.04.

      
      * Default security group and rules required to connect to the cluster and VM from the internet.


      * {{ mkf-name }} cluster.
      * {{ KF }} user.

   1. Specify the variable values in the `kafka-ui-via-docker.tf` file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Install additional dependencies {#infra-for-docker}

1. [Connect to the VM via SSH](../../compute/operations/vm-connect/ssh.md#vm-connect):

   ```bash
   ssh <username>@<VM_public_IP_address>
   ```

   Where `<username>` is the VM account username. You can find the VM's public IP address in the [management console]({{ link-console-main }}), on the VM page.

1. To check that the {{ mkf-name }} cluster is available, connect to one of its hosts with the `KAFKA` role:

   ```bash
   telnet <host_FQDN> {{ port-mkf-ssl }}
   ```

   You can view the FQDN in the management console:

   1. Go to the cluster page.
   1. Go to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Copy the value in the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column, in the row of the host with the `KAFKA` role.

   If the cluster is available, you will get this message:

   ```text
   Connected to <host_FQDN>
   ```

   After this, you can abort the command as it does not complete but awaits data transfer.

1. Install Docker:

   ```bash
   sudo apt update && sudo apt install docker.io
   ```

1. Install `keytool` to manage keys and certificates:

   ```bash
   sudo apt install openjdk-19-jre-headless
   ```

### Create a TrustStore {#truststore-for-docker}

When deploying {{ KF }} in a Docker container, TrustStore commands run on a VM.

{% include [TrustStore](../../_includes/mdb/mkf/truststore.md) %}

### Set up the {{ KF }} web interface {#prepare-ui-via-docker}

1. On the VM, run the Docker container to deploy your web interface in:

   ```bash
   sudo docker run -it -p 8080:8080 \
      -e DYNAMIC_CONFIG_ENABLED=true \
      -e KAFKA_CLUSTERS_0_NAME=<cluster_name> \
      -e KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS=<host_FQDN>:{{ port-mkf-ssl }} \
      -e KAFKA_CLUSTERS_0_PROPERTIES_SECURITY_PROTOCOL=SASL_SSL \
      -e KAFKA_CLUSTERS_0_PROPERTIES_SASL_MECHANISM=PLAIN \
      -e KAFKA_CLUSTERS_0_PROPERTIES_CLIENT_DNS_LOOKUP=use_all_dns_ips \
      -e KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG='org.apache.kafka.common.security.plain.PlainLoginModule required username="<user_name>" password="<user_password>";' \
      -e KAFKA_CLUSTERS_0_PROPERTIES_SSL_TRUSTSTORE_LOCATION=/truststore/truststore.jks \
      -e KAFKA_CLUSTERS_0_PROPERTIES_SSL_TRUSTSTORE_PASSWORD=<TrustStore_password> \
      -v /truststore/truststore.jks:/truststore/truststore.jks \
      provectuslabs/kafka-ui
   ```

   Specify the following in the environment variables:

   * `KAFKA_CLUSTERS_0_NAME`: {{ mkf-name }} cluster name.
   * `KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS`: FQDN of the host with the `KAFKA` role in the {{ mkf-name }} cluster.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG`, `username`: {{ KF }} user name.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG`, `password`: {{ KF }} user password.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SSL_TRUSTSTORE_PASSWORD`: Password you set when creating the `truststore.jks` file.

   Once started, the command does not terminate. While it is running, the {{ KF }} web interface is available.

1. On a local machine, go to `http://<VM_public_IP_address>:8080` in your browser. The {{ KF }} web interface with {{ mkf-name }} cluster data will open.

   You can find the VM's public IP address in the management console, on the VM page.


## Deploying in a {{ managed-k8s-name }} cluster {#kubernetes}

To deploy the {{ KF }} web interface in a {{ managed-k8s-name }} cluster:

1. [Install additional dependencies](#infra-for-kubernetes).
1. [Create a TrustStore](#truststore-for-kubernetes).
1. [Deploy your application with the {{ KF }} web interface in the {{ k8s }} pod](#application-in-pod).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

### Getting started {#before-you-begin-to-work-with-kubernetes}

Prepare the infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

   1. Configure a single security group:

      * [For the {{ mkf-name }} cluster](../../managed-kafka/operations/connect.md#configuring-security-groups) so as to enable connection to topics over the internet.
      * [For the {{ managed-k8s-name }} cluster and node group](../../managed-kubernetes/operations/connect/security-groups.md).

   1. [Create a {{ mkf-name }} cluster](../../managed-kafka/operations/cluster-create.md). When creating it, specify the configured security group.
   1. [Create an {{ KF }} user](../../managed-kafka/operations/cluster-accounts.md#create-user).
   1. In the network hosting the {{ mkf-name }} cluster, [create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md). When creating it, specify the configured security group and assign a public address to the cluster.
   1. [Create a node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in the {{ managed-k8s-name }} cluster. When creating it, specify the configured security group.

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
   1. Download the [kafka-ui-via-kubernetes.tf](https://github.com/yandex-cloud-examples/yc-deploy-kafka-ui/blob/main/kafka-ui-via-kubernetes.tf) configuration file to the same working directory.

      This file describes:

      * Network.
      * Subnet.
      * Default security group and rules required to connect to the following from the internet:

         * {{ mkf-name }} cluster.
         * {{ managed-k8s-name }} cluster.
         * {{ managed-k8s-name }} node group.

      * {{ mkf-name }} cluster.
      * {{ KF }} user.
      * {{ managed-k8s-name }} cluster.
      * {{ managed-k8s-name }} node group.

   1. Specify the variable values in the `kafka-ui-via-kubernetes.tf` file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Install additional dependencies {#infra-for-kubernetes}

On a local machine:

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. To check that the {{ mkf-name }} cluster is available, connect to one of its hosts with the `KAFKA` role:

   ```bash
   telnet <host_FQDN> {{ port-mkf-ssl }}
   ```

   You can view the FQDN in the management console:

   1. Go to the cluster page.
   1. Go to **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
   1. Copy the value in the **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** column, in the row of the host with the `KAFKA` role.

   If the cluster is available, you will get this message:

   ```text
   Connected to <host_FQDN>
   ```

   After this, you can abort the command as it does not complete but awaits data transfer.

1. Install `keytool` to manage keys and certificates:

   ```bash
   sudo apt update && sudo apt install openjdk-19-jre-headless
   ```

### Create a TrustStore {#truststore-for-kubernetes}

When deploying {{ KF }} in a {{ managed-k8s-name }} cluster, TrustStore commands run on a local machine.

{% include [TrustStore](../../_includes/mdb/mkf/truststore.md) %}

### Deploy your application with the {{ KF }} web interface in the {{ k8s }} pod {#application-in-pod}

1. To deliver the `truststore.jks` file to the {{ k8s }} pod, create a [secret](https://kubernetes.io/docs/concepts/configuration/secret/) containing this file:

   ```bash
   kubectl create secret generic truststore --from-file=/truststore/truststore.jks
   ```

1. Create a file named `kafka-ui-configMap.yaml` with the [configMap](https://kubernetes.io/docs/concepts/configuration/configmap/) configuration. It contains information about the {{ mkf-name }} cluster and TrustStore:

   ```yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
      name: kafka-ui-values
   data:
      KAFKA_CLUSTERS_0_NAME: <{{ KF }}_cluster_name>
      KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS: <host_FQDN>:{{ port-mkf-ssl }}
      KAFKA_CLUSTERS_0_PROPERTIES_SECURITY_PROTOCOL: SASL_SSL
      KAFKA_CLUSTERS_0_PROPERTIES_SASL_MECHANISM: PLAIN
      KAFKA_CLUSTERS_0_PROPERTIES_CLIENT_DNS_LOOKUP: use_all_dns_ips
      KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG: 'org.apache.kafka.common.security.plain.PlainLoginModule required username="<user_name>" password="<user_password>";'
      KAFKA_CLUSTERS_0_PROPERTIES_SSL_TRUSTSTORE_LOCATION: /truststore/truststore.jks
      KAFKA_CLUSTERS_0_PROPERTIES_SSL_TRUSTSTORE_PASSWORD: <TrustStore_password>
      AUTH_TYPE: "DISABLED"
      MANAGEMENT_HEALTH_LDAP_ENABLED: "FALSE"
   ```

   Specify the following in the environment variables:

   * `KAFKA_CLUSTERS_0_NAME`: {{ mkf-name }} cluster name.
   * `KAFKA_CLUSTERS_0_BOOTSTRAPSERVERS`: FQDN of the host with the `KAFKA` role in the {{ mkf-name }} cluster.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG`, `username`: {{ KF }} user name.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SASL_JAAS_CONFIG`, `password`: {{ KF }} user password.
   * `KAFKA_CLUSTERS_0_PROPERTIES_SSL_TRUSTSTORE_PASSWORD`: Password you set when creating the `truststore.jks` file.

1. Create a file named `kafka-ui-pod.yaml` with the configuration of the pod to deploy your application with the {{ KF }} web interface in:

   ```yaml
   apiVersion: v1
   kind: Pod
   metadata:
      name: kafka-ui-pod
   spec:
      containers:
      - name: kafka-ui-pod
        image: provectuslabs/kafka-ui
        envFrom:
           - configMapRef:
                name: kafka-ui-values
        volumeMounts:
        - name: truststore
          mountPath: "/truststore"
          readOnly: true
      volumes:
      - name: truststore
        secret:
           secretName: truststore
      - name: kafka-ui-configmap
        configMap:
           name: kafka-ui-values
   ```

1. Apply the configMap configuration:

   ```bash
   kubectl apply -f kafka-ui-configMap.yaml
   ```

1. Apply the pod configuration:

   ```bash
   kubectl apply -f kafka-ui-pod.yaml
   ```

### Check the result {#check-result}

1. View the pod logs to make sure the {{ KF }} web interface is deployed successfully:

   ```bash
   kubectl logs kafka-ui-pod
   ```

   The result contains the following lines:

   ```text
    _   _ ___    __             _                _          _  __      __ _
   | | | |_ _|  / _|___ _ _    /_\  _ __ __ _ __| |_  ___  | |/ /__ _ / _| |_____
   | |_| || |  |  _/ _ | '_|  / _ \| '_ / _` / _| ' \/ -_) | ' </ _` |  _| / / _`|
    \___/|___| |_| \___|_|   /_/ \_| .__\__,_\__|_||_\___| |_|\_\__,_|_| |_\_\__,|
                                    |_|                                             

   2024-01-23 12:13:25,648 INFO  [background-preinit] o.h.v.i.u.Version: HV000001: Hibernate Validator 8.0.0.Final
   2024-01-23 12:13:25,745 INFO  [main] c.p.k.u.KafkaUiApplication: Starting KafkaUiApplication using Java 17.0.6 with PID 1 (/kafka-ui-api.jar started by kafkaui in /)
   2024-01-23 12:13:25,746 DEBUG [main] c.p.k.u.KafkaUiApplication: Running with Spring Boot v3.0.6, Spring v6.0.8
   2024-01-23 12:13:25,747 INFO  [main] c.p.k.u.KafkaUiApplication: No active profile set, falling back to 1 default profile: "default"
   ```

1. Set the {{ KF }} web interface port to `8080`:

   ```bash
   kubectl --namespace default port-forward kafka-ui-pod 8080:8080
   ```

1. In your browser, open `http://127.0.0.1:8080/`. The {{ KF }} web interface with {{ mkf-name }} cluster data will open.


## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

   Delete:

   
   1. {{ mkf-name }} [cluster](../../managed-kafka/operations/cluster-delete.md).
   1. [Virtual machine](../../compute/operations/vm-control/vm-delete.md).
   1. {{ managed-k8s-name }} [node group](../../managed-kubernetes/operations/node-group/node-group-delete.md).
   1. {{ managed-k8s-name }} [cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).


- {{ TF }} {#tf}

   1. In the terminal window, go to the directory containing the infrastructure plan.
   1. Delete the `kafka-ui-via-docker.tf` or the `kafka-ui-via-kubernetes.tf` configuration file depending on the deployment method used.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the configuration file will be deleted.

{% endlist %}
