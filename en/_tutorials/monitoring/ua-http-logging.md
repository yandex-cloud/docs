# Transferring logs through {{ unified-agent-short-name }} HTTP input to {{ cloud-logging-full-name }}

[{{ unified-agent-full-name }}](../../monitoring/concepts/data-collection/unified-agent/) allows you to receive and send user application logs to [{{ cloud-logging-full-name }}](../../logging/).

In this tutorial, you will configure log transfer from a test Python application. The application will send logs to {{ unified-agent-short-name }} [http input](../../monitoring/concepts/data-collection/unified-agent/inputs.md#http_input). {{ unified-agent-short-name }} will send the received logs via the [yc_logs](../../monitoring/concepts/data-collection/unified-agent/outputs.md#yc_logs_output) output to the {{ cloud-logging-name }} `default` log group.

To set up log transfer:

1. [Get your cloud ready](#before-begin).
1. [Install and configure {{ unified-agent-full-name }}](#configure-ua).
1. [Create and run a log-generating application](#generate-logs).
1. [View the logs](#read-logs).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

1. Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).

1. Fee for logging operations and log storage in a log group (see [{{ cloud-logging-full-name }} pricing](../../logging/pricing.md)).

## Prepare the infrastructure {#infrastructure-prepare}

### Create a service account {#sa-create}

1. [Create](../../iam/operations/sa/create.md) a service account named `sa-logger` in the folder you want to write logs to.
1. [Assign](../../iam/operations/roles/grant.md) the `logging.writer` [role](../../logging/security/index.md#logging-writer) to the service account.

### Create a VM {#vm-create}

1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) from a public [Ubuntu 24.04](/marketplace/products/yc/ubuntu-24-04-lts) image.
   
   Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select the `sa-logger` service account.
   
1. [Connect to the VM](../../compute/operations/vm-connect/ssh.md#vm-connect) over SSH.

## Install and configure {{ unified-agent-short-name }} {#configure-ua}

1. Download the latest deb package:

      ```bash
      ubuntu_name="ubuntu-22.04-jammy" ua_version=$(curl --silent https://storage.yandexcloud.net/yc-unified-agent/latest-version) bash -c 'curl --silent --remote-name https://storage.yandexcloud.net/yc-unified-agent/releases/${ua_version}/deb/${ubuntu_name}/yandex-unified-agent_${ua_version}_amd64.deb'
      ```
1. Check the deb package version using the `ls` command.
   
1. Install {{ unified-agent-short-name }} from the deb package by specifying its version:

   ```bash
   sudo dpkg -i yandex-unified-agent_24.09.03_amd64.deb
   ```
   
   Other installation methods are described in [{#T}](../../monitoring/concepts/data-collection/unified-agent/installation.md). 

1. Check that {{ unified-agent-short-name }} is running:

   ```bash
   sudo systemctl status unified-agent.service
   ```

1. Open the {{ unified-agent-short-name }} configuration file:
   
   ```bash
   sudo nano /etc/yandex/unified_agent/config.yml
   ```

1. Add configuration to the file to receive and send logs:

   ```yaml
   status:
     port: "16241"

   routes:
      - input:
         plugin: http
         config:
            port: 22132
        channel:
         output:
            plugin: yc_logs
            config:
               folder_id: "b1grj7grr1kn********"
               iam:
                  cloud_meta: {}
   
   import:
   - /etc/yandex/unified_agent/conf.d/*.yml
   ```

   Where `folder_id` is the ID of the folder you want to write logs to.

1. Make sure the configuration file is correct (the command should output the contents of the file):

   ```bash
   unified_agent check-config -c /etc/yandex/unified_agent/config.yml
   ```

1. Restart {{ unified-agent-short-name }}:

   ```bash
   sudo systemctl restart unified-agent.service
   ```

1. Check the {{ unified-agent-short-name }} status:

   ```bash
   sudo systemctl status unified-agent.service
   ```

## Create and run a log-generating application {#generate-logs}

1. Create a file named `logtest.py`:

   ```py
   import time
   import requests
   import random

   # Possible URLs for requests
   urls = [
      '/',
      '/admin',
      '/hello',
      '/docs',
      '/api/resource1',
      '/api/resource2',
      '/api/resource3'
   ]

   # Unified Agent HTTP input configuration
   unified_agent_url = 'http://51.250.98.18:22132/write'

   # Possible response codes and their probabilities
   response_codes = [200, 201, 400, 404, 500]
   response_weights = [0.7, 0.1, 0.1, 0.05, 0.05]

   # Generating and sending logs to HTTP input
   def generate_and_send_logs():
      while True:
         url = random.choice(urls)
         status_code = random.choices(response_codes, response_weights)[0]
         log_message = f"Requested {url}, received status code {status_code}"
         print(log_message)
         
         # Sending log to Unified Agent HTTP input
         send_logs_to_http(log_message)
         
         # Sending logs every 5 seconds
         time.sleep(5)

   # Sending logs to HTTP input
   def send_logs_to_http(log_message):
      headers = {"Content-Type": "text/plain"}
      response = requests.post(unified_agent_url, headers=headers, data=log_message)
      if response.status_code == 200:
         print("Log sent successfully")
      else:
         print(f"Failed to send log: {response.status_code}")

   if __name__ == "__main__":
      generate_and_send_logs()
   ```

   Where `unified_agent_url` is the VM's public IP address with {{ unified-agent-short-name }}.

   By default, {{ unified-agent-short-name }} accepts data on all interfaces. Therefore, you can specify a public IP address even if the log source is on the same VM. If there is no public address, put `localhost`.

1. Upgrade the versions of installed packages:

    ```bash
    sudo apt-get update
    ```

1. Install Python:

   ```bash
   sudo apt install python3
   ```

1. Run the application:
   ```bash
   python3 logtest.py
   ```

## View the logs {#read-logs}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder you specified in the {{ unified-agent-full-name }} settings.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Select the `default` log group.
    1. Navigate to the **{{ ui-key.yacloud.common.logs }}** tab.
    1. The page that opens will show the log group records.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To view records in the log group, run this command:
    ```
    yc logging read --folder-id=<folder_ID>
    ```

    Where `--folder-id` is the folder ID specified in the {{ unified-agent-full-name }} settings.

- API {#api}

    To view log group records, use the [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md) gRPC API call.

{% endlist %}

## Delete the resources you created {#delete-resources}

If you no longer need the resources you created, delete them:

1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
1. [Delete the log group](../../logging/operations/delete-group.md).