The [Fluent Bit](https://fluentbit.io/) log processor lets you transfer the cluster logs from [VM instances](../compute/concepts/vm.md) to [{{ cloud-logging-full-name }}](../logging/). The [Fluent Bit plugin for {{ cloud-logging-full-name }}](https://github.com/yandex-cloud/fluent-bit-plugin-yandex) module is used to transfer logs.

To configure log transfer from a VM instance created from the {{ coi }} image:

1. [Create application that generates logs](#generate-logs).
1. [Create a Docker image and push it to the registry](#create-docker).
1. [Configure Fluent Bit](#fluent-bit).
1. [Create a VM from a {{ coi }}](#create-vm).

## Before you begin

1. [Create a service account](../iam/operations/sa/create.md) with the `logging.writer` and `container-registry.images.puller` roles for the folder.
1. [Create a registry](../container-registry/operations/registry/registry-create.md) {{ container-registry-full-name }}.
1. [Create a cloud network](../vpc/operations/network-create.md). When creating, select the **Create subnets** option.

## Create application that generates logs {#generate-logs}

Create a `logs.py` file:
```py
import logging
import random
import sys
import time

import uuid

logger = logging.getLogger(__name__)

# Set log format
formatter = logging.Formatter(
    '[req_id=%(req_id)s] [%(levelname)s] %(code)d %(message)s'
)

handler = logging.StreamHandler(stream=sys.stdout)
handler.setFormatter(formatter)

logger.addHandler(handler)

# Configure default logging level, optional
logger.setLevel(logging.DEBUG)

# Generate URL-like values
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
        # Create a pair of code and URL value
        path, code = fake_url()
        extra = {"code": code, "req_id": req_id}
        # If code is 200, write to Info log
        if code == 200:
            logger.info(
                'Path: %s',
                path,
                extra=extra,
            )
        # Otherwise, write to Error log
        else:
            logger.error(
                'Error: %s',
                path,
                extra=extra,
            )
        # For multiple messages with the same request id, in 30% of cases, write the second entry
        # to Debug log.
        if random.random() > 0.7:
            logger.debug("some additional debug log record %f", random.random(), extra=extra)

        # Wait 1 second to avoid log clogging
        time.sleep(1)
```

## Create a Docker image and push it to the registry {#create-docker}

1. Create a file named Dockerfile and add the lines below:

   ```
   FROM python:3.10

   WORKDIR /usr/src/app

   COPY logs.py .

   CMD [ "python", "./logs.py" ]
   ```

   Dockerfile describes a [Docker image](../container-registry/concepts/docker-image.md) that contains an application generating logs.

1. Build a Docker image:

   ```bash
   docker build . \
     -t {{ registry }}/<registry_ID>/coi:logs
   ```

1. [Log in](../container-registry/operations/authentication.md) to the registry and upload a Docker image:

   ```bash
   docker push {{ registry }}/<registry_ID>/coi:logs
   ```

## Configure Fluent Bit {#fluent-bit}

1. Create a `spec.yaml` file: It describes the specification of two containers: with an application that generates logs, and with a Fluent Bit agent.

   Specify the following in the field:
   * `image`: URL of a Docker image. To find it out, in the [management console]({{ link-console-main }}), go to the **Overview of Docker image** page and copy the value of the **Tags** field.
   * `YC_GROUP_ID`: ID of the [default log group](../logging/concepts/log-group.md): `default`.

   In the `fluentbit` section, the `image` field shows the image of a container with the Fluent Bit agent, current at the time of this documentation. For a list of all available images, follow the [link](https://github.com/yandex-cloud/fluent-bit-plugin-yandex/releases).

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
         # Fluent Bit understands this log format
         driver: fluentd
         options:
           # Fluent Bit listens to logs on 24224
           fluentd-address: localhost:24224
           # Tags are used for routing logs
           tag: app.logs

     fluentbit:
       container_name: fluentbit
       image: {{ registry }}/yc/fluent-bit-plugin-yandex:v1.0.3-fluent-bit-1.8.6
       ports:
         - 24224:24224
         - 24224:24224/udp
       restart: always
       environment:
         YC_GROUP_ID: <ID_of_log_group>
       volumes:
         - /etc/fluentbit/fluentbit.conf:/fluent-bit/etc/fluent-bit.conf
         - /etc/fluentbit/parsers.conf:/fluent-bit/etc/parsers.conf
   ```

1. Create a `user-data.yaml` file. It describes rules to read container logs. If necessary, in the `users` section, update the username and SSH key. Learn more about how to [generate SSH keys](../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
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
       sudo: [ 'ALL=(ALL) NOPASSWD:ALL' ]
       ssh-authorized-keys:
         - ssh-ed25519 AAAA
   ```

   The `SERVICE` section displays Fluent Bit settings. [Learn more about the settings](https://docs.fluentbit.io/manual/administration/configuring-fluent-bit).

   The `INPUT` section displays where and how to retrieve logs. To work with Fluentd and Fluent Bit logs, the `forward` protocol is used. Fluent Bit listens to logs on port 24224.

   The `PARSER` section describes the `regex` parser. It sets a regular expression that processes entries:
   * `req_id`: Unique ID of the request.
   * `severity`: Logging level.
   * `code`: HTTP response code.
   * `text`: All the remaining text.

   The `FILTER` section shows that only entries tagged `app.logs` are searched for. The `log` field of each entry is processed by the `regex` parser, all other fields are saved in `Reserve_Data On`.

## Create a VM from a {{ coi }} image {#create-vm}

Specify the following in the field:
* `zone`: [Availability zone](../overview/concepts/geo-scope.md), for example `{{ region-id }}-a`.
* `subnet-name`: Name of the [subnet](../vpc/concepts/network.md#subnet) in the indicated zone.
* `service-account-name`: Service account name.

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

## View the logs {#read-logs}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder with the `default` log group whose ID you indicated in `spec.yaml`.
   1. Select **{{ cloud-logging-name }}**.
   1. Select the `default` log group. The page that opens will show the log group records.

- CLI

   {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

   To view records in the log group, run the command:

   ```
   yc logging read --group-id=<log_group_ID>
   ```

   Where `--group-id` is the ID of the `default` log group specified in `spec.yaml`.

- API

   You can view the entries in a log group using the API [read](../logging/api-ref/grpc/log_reading_service.md).

{% endlist %}


## Delete the resources you created {#delete-resources}

If you no longer need these resources, delete them:

1. [Delete a cloud network](../vpc/operations/network-delete.md).
1. [Delete the Docker image](../container-registry/operations/docker-image/docker-image-delete.md).
1. [Delete the registry](../container-registry/operations/registry/registry-delete.md).
1. [Delete the VM](../compute/operations/vm-control/vm-delete.md).
1. [Delete the log group](../logging/operations/delete-group.md).
