# Transferring logs from {{ coi }} to {{ cloud-logging-full-name }}

The [Fluent Bit](https://fluentbit.io/) logging processor allows you to transfer logs from [VM instances](../../compute/concepts/vm.md) created from a {{ coi }} to [{{ cloud-logging-full-name }}](../../logging/). To transfer logs, you will use the [Fluent Bit plugin for {{ cloud-logging-full-name }}](https://github.com/yandex-cloud/fluent-bit-plugin-yandex).

To configure log transfer from a VM instance created from a {{ coi }}:
1. [Create a log-generating application](#generate-logs).
1. [Create a Docker image and push it to the registry](#create-docker).
1. [Configure Fluent Bit](#fluent-bit).
1. [Create a VM from a {{ coi }}](#create-vm).

## Getting started {#before-you-begin}

1. [Create a service account](../../iam/operations/sa/create.md) with the `logging.writer` and `container-registry.images.puller` [roles](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
1. [Create a registry](../../container-registry/operations/registry/registry-create.md) in [{{ container-registry-full-name }}](../../container-registry/).
1. [Create a cloud network](../../vpc/operations/network-create.md). Select **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** when creating it.

## Create a log-generating application {#generate-logs}

Create a file named `logs.py`:

```py
import logging
import random
import sys
import time

import uuid

logger = logging.getLogger(__name__)

# Set the log format.
formatter = logging.Formatter(
  '[req_id=%(req_id)s] [%(levelname)s] %(code)d %(message)s'
)

handler = logging.StreamHandler(stream=sys.stdout)
handler.setFormatter(formatter)

logger.addHandler(handler)

# Configure the default logging level (optional).
logger.setLevel(logging.DEBUG)

# Generate URL-like values.
PATHS = [
  '/',
  '/admin',
  '/hello',
  '/docs',
]

PARAMS = [
  'foo',
  'bar',
  'query',
  'search',
  None
]

def fake_url():
  path = random.choice(PATHS)
  param = random.choice(PARAMS)
  if param:
    val = random.randint(0, 100)
    param += '=%s' % val
  code = random.choices([200, 400, 404, 500], weights=[10, 2, 2, 1])[0]
  return '?'.join(filter(None, [path, param])), code

if __name__ == '__main__':
  while True:
    req_id = uuid.uuid4()
    # Create a pair consisting of a code and a URL value.
    path, code = fake_url()
    extra = {"code": code, "req_id": req_id}
    # If the code is 200, write to the `Info` level log.
    if code == 200:
      logger.info(
        'Path: %s',
        path,
        extra=extra,
      )
    # Otherwise, write to the `Error` level log.
    else:
      logger.error(
        'Error: %s',
        path,
        extra=extra,
      )
    # To have multiple messages with the same request ID, in 30% of cases, write the second entry to the `Debug` level log.
    if random.random() > 0.7:
      logger.debug("some additional debug log record %f", random.random(), extra=extra)

    # To avoid log cluttering, wait for 1 second.
    time.sleep(1)
```

## Create a Docker image and push it to the registry {#create-docker}

1. Create a Dockerfile and add the following lines to it:

    ```dockerfile
    FROM python:3.10

    WORKDIR /usr/src/app

    COPY logs.py .

    CMD [ "python", "./logs.py" ]
    ```

    The Dockerfile describes a [Docker image](../../container-registry/concepts/docker-image.md) that contains an application generating logs.
1. Build the Docker image:

    ```bash
    docker build . \
      -t {{ registry }}/<registry_ID>/coi:logs
    ```

1. [Log in](../../container-registry/operations/authentication.md) to the [registry](../../container-registry/concepts/registry.md) and upload the Docker image to it:

    ```bash
    docker push {{ registry }}/<registry_ID>/coi:logs
    ```

## Configure Fluent Bit {#fluent-bit}

1. Create a file named `spec.yaml`. It describes the specification of two containers: with an application that generates logs, and with a Fluent Bit agent.

   Specify the following in the field:
   * `image`: Docker image URL. To find it out, in the [management console]({{ link-console-main }}), go to the **{{ ui-key.yacloud.cr.image.section_overview }}** page and copy the value of the **{{ ui-key.yacloud.cr.image.label_tag }}** field.
   * `YC_GROUP_ID`: ID of the `default` [log group](../../logging/concepts/log-group.md).

   In the `fluentbit` section, the `image` field shows the current image of a container with the Fluent Bit agent. For a list of all available images, follow [this link](https://github.com/yandex-cloud/fluent-bit-plugin-yandex/releases).

   ```yaml
   version: '3.7'
   services:
     logs:
       container_name: logs-app
       image: <Docker_image_URL>
       restart: always
       depends_on:
         - fluentbit
       logging:
         # Fluent Bit parses logs in this format.
         driver: fluentd
         options:
           # Fluent Bit listens to logs on port 24224.
           fluentd-address: localhost:24224
           # Tags are used for routing logs.
           tag: app.logs

     fluentbit:
       container_name: fluentbit
       image: cr.yandex/yc/fluent-bit-plugin-yandex:v2.1.1-fluent-bit-1.8.15
       ports:
         - 24224:24224
         - 24224:24224/udp
       restart: always
       environment:
         YC_GROUP_ID: <log_group_ID>
       volumes:
         - /etc/fluentbit/fluentbit.conf:/fluent-bit/etc/fluent-bit.conf
         - /etc/fluentbit/parsers.conf:/fluent-bit/etc/parsers.conf
   ```

1. Create a file named `user-data.yaml`. It describes the container log reading rules. If required, change the username and SSH key in the `users` section. [Learn more about generating SSH keys](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

   
   ```yaml
   #cloud-config
   write_files:
     - content: |
         [SERVICE]
             Flush         1
             Log_File      /var/log/fluentbit.log
             Log_Level     error
             Daemon        off
             Parsers_File  /fluent-bit/etc/parsers.conf

         [FILTER]
             Name parser
             Match app.logs
             Key_Name log
             Parser app_log_parser
             Reserve_Data On

         [INPUT]
             Name              forward
             Listen            0.0.0.0
             Port              24224
             Buffer_Chunk_Size 1M
             Buffer_Max_Size   6M

         [OUTPUT]
             Name            yc-logging
             Match           *
             group_id        ${YC_GROUP_ID}
             message_key     text
             level_key       severity
             default_level   WARN
             authorization   instance-service-account
       path: /etc/fluentbit/fluentbit.conf
     - content: |
         [PARSER]
             Name   app_log_parser
             Format regex
             Regex  ^\[req_id=(?<req_id>[0-9a-fA-F\-]+)\] \[(?<severity>.*)\] (?<code>\d+) (?<text>.*)$
             Types  code:integer
       path: /etc/fluentbit/parsers.conf

   users:
     - name: username
       groups: sudo
       shell: /bin/bash
       sudo: 'ALL=(ALL) NOPASSWD:ALL'
       ssh_authorized_keys:
         - ssh-ed25519 AAAA
   ```


   The `SERVICE` section displays the Fluent Bit settings. [Learn more about the settings](https://docs.fluentbit.io/manual/administration/configuring-fluent-bit).

   The `INPUT` section displays where and how to retrieve logs. To work with Fluentd and Fluent Bit logs, the `forward` protocol is used. Fluent Bit listens to logs on port 24224.

   The `PARSER` section describes the `regex` parser. It sets a regular expression that processes records:
   * `req_id`: Unique request ID
   * `severity`: Logging level
   * `code`: HTTP response code
   * `text`: All remaining text

   The `FILTER` section shows that only records tagged `app.logs` are searched for. The `log` field of each record is parsed by `regex`, all other fields are saved in `Reserve_Data On`.

## Create a VM from a {{ coi }} {#create-vm}

Specify the following in the field:
* `--zone`: [Availability zone](../../overview/concepts/geo-scope.md), e.g., `{{ region-id }}-a`.
* `--subnet-name`: Name of the [subnet](../../vpc/concepts/network.md#subnet) in this zone.
* `--service-account-name`: [Service account](../../iam/concepts/users/service-accounts.md) name.

```bash
IMAGE_ID=$(yc compute image get-latest-from-family container-optimized-image --folder-id standard-images --format=json | jq -r .id)

yc compute instance create \
  --name coi-vm \
  --zone=<zone> \
  --network-interface subnet-name=<subnet_name>,nat-ip-version=ipv4 \
  --metadata-from-file user-data=user-data.yaml,docker-compose=spec.yaml \
  --create-boot-disk image-id=${IMAGE_ID} \
  --service-account-name <service_account_name>
```

{% include [cli-metadata-variables-substitution-notice](../../_includes/compute/create/cli-metadata-variables-substitution-notice.md) %}

## View the logs {#read-logs}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder with the `default` log group whose ID you specified in the `spec.yaml` file.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. Select the `default` log group. The page that opens will show the log group records.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To view records in the log group, run this command:

  ```bash
  yc logging read --group-id=<log_group_ID>
  ```

  `--group-id`: ID of the `default` log group specified in the `spec.yaml` file.

- API {#api}

  You can view the log group records using the [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md) gRPC API call.

{% endlist %}

## Delete the resources you created {#delete-resources}

If you no longer need the resources you created, delete them:
1. [Delete the cloud network](../../vpc/operations/network-delete.md).
1. [Delete the Docker image](../../container-registry/operations/docker-image/docker-image-delete.md).
1. [Delete the registry](../../container-registry/operations/registry/registry-delete.md).
1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
1. [Delete the log group](../../logging/operations/delete-group.md).
