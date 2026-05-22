# Connecting to an {{ KF }} cluster

In this tutorial, we will analyze the [kcat](https://github.com/edenhill/kcat) commands for external and internal [connections to an {{ KF }} cluster](#how-to) and send a message from the producer to the consumer.

## Getting started {#before-begin}

1. Install [kcat](https://github.com/edenhill/kcat).
1. If the project does not exist yet, create it: `kubectl create namespace <project name>`.
1. Create an [{{ KF }} cluster](create-cluster.md).
1. Create a [topic](create-topic.md).
1. Create a [user](create-user.md) with administrator privileges.

## How to connect to an {{ KF }} cluster {#how-to}

{% list tabs %}

- External connection

  {% note info %}

  To connect to {{ KF }} from outside the cluster, you must enable the public access option (`listenerType: LoadBalancer`) in the {{ KF }} cluster settings.

  {% endnote %}

  1. Get an external link to the {{ KF }} cluster: `kubectl get kafkaclusters <cluster name> -o jsonpath='{.status.listenersStatus.external.fqdn}' -n <project_name>`.
  1. Get the port to connect to: `kubectl get kafkaclusters <cluster name> -o jsonpath='{.status.listenersStatus.external.port}' -n <project name>`.
  1. Copy the connection certificate from the {{ KF }} cluster resource field named `status.listenersStatus.external.certificate`: `kubectl describe kafkaclusters <cluster name> -n <project name>`.
  1. Save the certificate to a file named `<path to certificate>/ca.crt`.
  1. Run the following command to receive messages from the topic:

      ```bash
      kcat -C \
      -b <link to cluster>:<port> \
      -t <topic name> \
      -X security.protocol=SASL_SSL \
      -X sasl.mechanism=SCRAM-SHA-512 \
      -X sasl.username="<username>" \
      -X sasl.password="<user password>" \
      -X ssl.endpoint.identification.algorithm=none \
      -X ssl.ca.location=/<path to certificate>/ca.crt -Z -K:
      ```

  1. Open a new terminal and send the following message to the topic:

      ```bash
      echo "test message" | kcat -P \
      -b <link to cluster>:<port> \
      -t <topic name> \
      -k key \
      -X security.protocol=SASL_SSL \
      -X sasl.mechanism=SCRAM-SHA-512 \
      -X sasl.username="<username>" \
      -X sasl.password="<user password>" \
      -X ssl.endpoint.identification.algorithm=none \
      -X ssl.ca.location=/<path to certificate>/ca.crt -Z
      ```

  The consumer will receive a message: "test message".

- Internal connection

  1. Get an internal link to the {{ KF }} cluster: `kubectl get kafkaclusters <cluster name> -o jsonpath='{.status.listenersStatus.internal.fqdn}' -n <project_name>`.
  1. Get the port to connect to: `kubectl get kafkaclusters <cluster name> -o jsonpath='{.status.listenersStatus.internal.port}' -n <project name>`.
  1. Run the following command to receive messages from the topic:

      ```bash
      kcat -C \
      -b <link to cluster>:<port> \
      -t <topic name> \
      -X security.protocol=SASL_PLAINTEXT \
      -X sasl.mechanism=SCRAM-SHA-512 \
      -X sasl.username="<username>" \
      -X sasl.password="<user password>" -Z -K:
      ```

  1. Open a new terminal and send the following message to the topic:

      ```bash
      echo "test message" | kcat -P \
      -b <link to cluster>:<port> \
      -t <topic name> \
      -k key \
      -X security.protocol=SASL_PLAINTEXT \
      -X sasl.mechanism=SCRAM-SHA-512 \
      -X sasl.username="<username>" \
      -X sasl.password="<user password>" -Z
      ```

  The consumer will receive a message: "test message".

{% endlist %}
