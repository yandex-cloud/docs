# Creating a VM with Container Optimized Image

Create a VM from a Container Optimized Image and run a Docker container on it.

_A Container Optimized Image_ is a VM [image](../../compute/concepts/image.md) that is optimized for running Docker containers. The image includes Ubuntu 16.04, Docker, and Docker Compose.

It's integrated with the Yandex.Cloud platform, which allows you to:

- Run the Docker container specified in the VM settings immediately after creation from the management console or YC CLI.
- Access Docker container open network ports without any additional configuration.
- Update running Docker containers with minimum downtime.

To launch a Docker container:

- [Read about the structure of metadata used to create Docker containers](#meta-structure).
- [Prepare a file with metadata](#metadata).
- [Create a VM with a Docker container](#coi-vm).

## Structure of metadata for creating Docker containers {#meta-structure}

The format matches [pod {{ k8s }} specs](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.11/#podspec-v1-core).

```
spec:
  containers: # List of containers on the VM. There should only be one Docker container.
  - command: # CMD to run in Docker image, optional field.
    - <command>
    args: 
    - <command arguments>
    env: # Environment variables for Docker image.
    - name: <key>
      value: <value>
    image: <Docker image name and tag>
    name: <Docker container name>
    securityContext:
      privileged: false
    stdin: false
    tty: false
    volumeMounts: []
  restartPolicy: Always
  volumes: []
```

## Create a VM with a Docker container from a Container Optimized Image {#create-vm}

### Prepare a file with metadata {#metadata}

Save the following sample metadata to the file `my-container.yaml`:

```
spec:
  containers:
  - command:
    - sleep
    args:
    - 100000
    env:
    - name: MYENV
      value: myvalue
    image: ubuntu
    name: container-name
    securityContext:
      privileged: false
    stdin: false
    tty: false
    volumeMounts:
      - mountPath: /home/yc-user/cache
        name: cache-volume
  restartPolicy: Always
  volumes:
    - name: cache-volume
      emptyDir:
        medium: Memory
        sizeLimit: 10M 
```

### Create a VM with a Docker container {#coi-vm}

Create a VM and Docker container using the metadata from the `my-container.yaml` file:

```
$ yc compute instance create \
--name coi-vm \
--ssh-key ssh-key.pub \ 
--service-account-name=default-sa \ 
--create-boot-disk image-id=fd8psnb698l16qrc2kpd \ 
--zone=ru-central1-b \
--metadata-from-file docker-container-declaration=my-container.yaml \ 
--public-ip 
done (1m27s)
id: epdegdecs9o14r13gbad
folder_id: b1g88tflru0ek1omtsu0
created_at: "2019-07-22T12:05:50Z"
name: coi-vm
zone_id: ru-central1-b
platform_id: standard-v2
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "100"
status: RUNNING
boot_disk:
  mode: READ_WRITE
  device_name: epd9vda1h0knttpcuhfu
  auto_delete: true
  disk_id: epd9vda1h0knttpcuhfu
network_interfaces:
- index: "0"
  mac_address: d0:0d:e8:35:cc:e2
  subnet_id: e2l1nona7t5q4nbaa0om
  primary_v4_address:
    address: 172.18.0.13
    one_to_one_nat:
      address: 84.201.154.62
      ip_version: IPV4
fqdn: epdegdecs9o14r13gbad.auto.internal
scheduling_policy: {}
service_account_id: aje3932acd0c5ur7dagp
```

Once created, the VM will appear in the list of running VMs in the **{{ compute-name }}** section of the [management console](https://console.cloud.yandex.com/).

For more information about working with VMs, see our [step-by-step instructions](../../compute/operations/index.md).

## Update a Docker container {#update}

To update a Docker container, update the metadata file and add it to the VM using the following command:

```
$ yc compute instance add-metadata \
                      --metadata-from-file docker-container-declaration=<path to the metadata file> \
                      <VM name>
```

