# Finding and eliminating errors when creating a demonstration stand

If you encounter problems while [creating](quickstart.md) the {{ sk-hybrid-name }} demonstration stand, run diagnostics to find errors:

1. [Connect to the VM over SSH](../compute/operations/vm-connect/ssh.md#vm-connect):

   ```bash
   ssh <username>@<VM_public_IP_address>
   ```

   Where `<username>` is the VM account username. You can find the VM's public IP address in the [management console]({{ link-console-main }}), on the VM page.

1. Check if the `8080` and `9080` ports are open to receive client requests:

   ```bash
   telnet <VM_public_address> 8080 && telnet <VM_public_address> 9080
   ```

   In the command, specify the public IP address of the VM that was created with the [infrastructure](quickstart.md#create-infrastructure). Learn how to [get the IP address of a VM](../compute/operations/vm-info/get-info.md#outside-instance).

1. Check the list of downloaded Docker images:

   ```bash
   docker images --digests
   ```

   Make sure the required images are present. They are loaded into the {{ container-registry-full-name }} registry after you [provide](quickstart.md#get-started) the registry ID to the {{ speechkit-name }} command.

   Expected result:

   ```text
   REPOSITORY                                        TAG   DIGEST             IMAGE ID  CREATED  SIZE
   cr.yandex/crp33...7i/release/stt/v100/stt_server  0.21  sha256:83245...6b  0d1...89  ...      15.3GB
   cr.yandex/crp33...7i/release/tts/v100/tts_server  0.21  sha256:41c1f...ea  d3a...7d  ...      16.1GB
   cr.yandex/crp33...7i/release/envoy                0.21  sha256:853ed...cb  6f7...31  ...      220MB
   cr.yandex/crp33...7i/release/license_server       0.21  sha256:44d24...3d  59e...62  ...      1.23GB
   ```

   If you changed image labels, make sure you used the required Docker image during [load testing](quickstart.md#stt-and-tts). To do this, in the `DIGEST` column, compare the hash sums of the image you used and the image in the resulting list.

1. Make sure Docker containers are successfully launched from the {{ sk-hybrid-name }} images:

   ```bash
   docker ps -a
   ```

   Example of expected result:

   ```text
   CONTAINER ID  IMAGE                                                  ...  STATUS            ...
   659...a0      cr.yandex/crp33...7i/release/stt/v100/stt_server:0.21  ...  Up About an hour  ...
   af3...1f      cr.yandex/crp33...7i/release/tts/v100/tts_server:0.21  ...  Up About an hour  ...
   e42...36      cr.yandex/crp33...7i/release/envoy:0.21                ...  Up About an hour  ...
   a4a...43      cr.yandex/crp33...7i/release/license_server:0.21       ...  Up About an hour  ...
   ```

1. Check the list of open network connections and the network configuration:

   1. Install the `netstat` utility:

      ```bash
      sudo apt install net-tools
      ```

   1. Make sure {{ sk-hybrid-name }} services are ready to serve network connections on their dedicated ports. For a list of ports, see the `docker-compose.yaml` file. It is stored in the [node-deploy.tf](https://github.com/yandex-cloud-examples/yc-speechkit-hybrid-deployment/blob/main/node-deploy.tf) file, in the `COMPOSE_V100_STT_TTS` variable.

      Run the command to get information about network connections of services:

      ```bash
      sudo netstat -tulpn && sudo ip addr
      ```

      Expected result:

      ```text
      Proto  Recv-Q  Send-Q  Local Address  Foreign Address  State   PID/Program name
      tcp         0       0  0.0.0.0:8080   0.0.0.0:*        LISTEN  1582/envoy
      tcp         0       0  0.0.0.0:9080   0.0.0.0:*        LISTEN  1582/envoy
      tcp         0       0  0.0.0.0:17882  0.0.0.0:*        LISTEN  1688/asr_server
      tcp         0       0  0.0.0.0:17982  0.0.0.0:*        LISTEN  1637/tts_server
      tcp         0       0  0.0.0.0:9091   0.0.0.0:*        LISTEN  1582/envoy
      tcp6        0       0  :::8085        :::*             LISTEN  1581/java
      tcp6        0       0  :::8086        :::*             LISTEN  1581/java
      tcp6        0       0  :::8087        :::*             LISTEN  1581/java
      tcp6        0       0  :::17880       :::*             LISTEN  1688/asr_server
      tcp6        0       0  :::17980       :::*             LISTEN  1637/tts_server
      tcp6        0       0  :::9087        :::*             LISTEN  1581/java
      tcp6        0       0  :::8003        :::*             LISTEN  1581/java
      ```

1. Make sure the GPU driver is healthy. Its integration with the used containerization system is one of the [hardware requirements](system-requirements.md#hardware).

   1. Find out the NVIDIA kernel version:

      ```bash
      cat /proc/driver/nvidia/version
      ```

      Example of expected result:

      ```text
      NVRM version: NVIDIA UNIX x86_64 Kernel Module 470.199.02 ...
      ```

   1. Check the GPU driver status:

      ```bash
      sudo nvidia-smi
      ```

      Example of expected result:

      ```text
      +-----------------------------------------------------------------------------+
      | NVIDIA-SMI 470.199.02   Driver Version: 470.199.02   CUDA Version: 11.4     |
      |-------------------------------+----------------------+----------------------+
      | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
      | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
      |===============================+======================+======================|
      |   0  Tesla V100-SXM2...  Off  | 00000000:8B:00.0 Off |                    0 |
      | N/A   33C    P0    36W / 300W |      0MiB / 32510MiB |      2%      Default |
      +-------------------------------+----------------------+----------------------+
      ```

   1. Make sure the GPU driver has been successfully integrated into the containerization system:

      ```bash
      nvidia-container-cli info
      ```

      Example of expected result:

      ```text
      NVRM version:   470.199.02
      CUDA version:   11.4
      Device Index:   0
      Device Minor:   0
      Model:          Tesla V100-SXM2-32GB
      Brand:          Tesla
      GPU UUID:       GPU-1af...cb
      Bus Location:   00000000:8b:00.0
      Architecture:   7.0
      ```

1. Check if there are errors like `WARNING`, `ERROR`, `EMERG`, or `ALERT` in the STDOUT output of the containers. To do this, dump the output into text files. Run the following command in the `yc-speechkit-hybrid-deployment` repository directory:

   ```bash
   mkdir -p logs ; cd ./logs
   for c in $(docker ps --format '{{.Names}}' | awk '{print $NF}'); do echo $c && docker logs $c &> $c.log; done
   ```

   If you [contact technical support]({{ link-console-support }}), tell them what command you ran and send the received text files.

1. Examine the contents of the `docker-compose.yaml` file, which is used to launch Docker containers.

   `docker-compose.yaml` is described in the `node-deploy.tf` file, in the `COMPOSE_V100_STT_TTS` variable. The contents of the variable are automatically dumped into the `docker-compose.yaml` file. It is hosted and built on the VM that runs {{ sk-hybrid-name }}.

   Errors may occur during assembly. To process them, make sure the contents of the `docker-compose.yaml` file match the environment configuration information. This information was collected using the steps described above.
   