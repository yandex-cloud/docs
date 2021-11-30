To run multiple instances of the service in Docker containers, you can create an instance group from a [{{ coi }}](../../cos/concepts/index.md). In such groups, you can update Docker containers with VM metadata using the [COI or Docker Compose specification](../../cos/concepts/index.md#coi-specifications).

{% include [warning.md](warning.md) %}

{% include [sa.md](sa.md) %}

To create an instance group built on a {{ coi }}:

1. {% include [cli-install.md](../cli-install.md) %}

1. {% include [default-catalogue.md](../default-catalogue.md) %}

1. View a description of the create instance group command in the CLI:

    ```
    $ {{ yc-compute-ig }} create --help
    ```

1. Check whether there are networks in the folder:

    ```
    $ yc vpc network list
    ```

    If there aren't any, [create one](../../vpc/operations/network-create.md).

1. Create a YAML file with a name like `specification.yaml`.

1. Select the latest version of the {{ coi }} from the [public images](../../compute/operations/images-with-pre-installed-software/get-list.md).

    To get the ID of the latest version of the {{ coi }} image, run the command:

    ```
    $ yc compute image get-latest-from-family container-optimized-image --folder-id standard-images
    id: <image ID>
    folder_id: standard-images
    ...
    ```

1. In the `specification.yaml` file you created, specify the following:

    - General information about the group:

        ```
        name: container-optimized-group
        service_account_id: aje3932acd8avp6edhbt
        description: "This instance group was created from YAML config."
        ```

        Keys:

        | Key | Value |
        | ----- | ----- |
        | `name` | A name for the instance group. The name must be unique within the folder. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The maximum length of the name is 63 characters. |
        | `service_account_id` | ID of the service account. |
        | `description` | A description of the instance group. |

    - [Instance template](../../compute/concepts/instance-groups/instance-template.md):

        ```
        instance_template:
            platform_id: standard-v3
            resources_spec:
                memory: 2G
                cores: 2
            boot_disk_spec:
                mode: READ_WRITE
                disk_spec:
                    image_id: fd81a49qficqvt0dthu8
                    type_id: network-hdd
                    size: 32G
            network_interface_specs:
                - network_id: c64mknqgnd8avp6edhbt
                  primary_v4_address_spec: {}
            metadata:
                docker-container-declaration: |-
                    spec:
                        containers:
                            - name: nginx
                              image: cr.yandex/mirror/nginx:1.17.4-alpine
                              securityContext:
                                privileged: false
                              tty: false
                              stdin: false
        ```

        {% include [default-unit-size](default-unit-size.md) %}

        Keys:

        | Key | Value |
        | ----- | ----- |
        | `platform_id` | Platform ID. |
        | `memory` | Amount of memory (RAM). |
        | `cores` | Number of processor cores (vCPUs). |
        | `mode` | Disk access mode.</br>- `READ_ONLY`: read-only access.</br>- `READ_WRITE`: read/write access. |
        | `image_id` | ID of the public {{ coi }}. |
        | `type_id` | Disk type. |
        | `size` | Disk size. |
        | `network_id` | The `default-net` ID. |
        | `primary_v4_address_spec` | IPv4 specification. Only IPv4 is currently available. You can allow public access to group instances by specifying the IP version for the public IP address. For more information, see [{#T}](../../compute/concepts/instance-groups/instance-template.md#instance-template). |
        | `metadata` | Values to pass to the VM metadata. |
        | `docker-container-declaration` | The key in the VM metadata that is used with the [COI specification of the Docker container](../../cos/concepts/index.md#coi-specifications). In the metadata, you can use the [Docker Compose specification](../../cos/concepts/index.md#compose-spec). To do this, specify the `docker-compose` key instead of the `docker-container-declaration` key. |

    - [Policies](../../compute/concepts/instance-groups/policies/index.md):

        ```
        deploy_policy:
            max_unavailable: 1
            max_expansion: 0
        scale_policy:
            fixed_scale:
                size: 3
        allocation_policy:
            zones:
                - zone_id: ru-central1-a
        ```

        Keys:

        | Key | Value |
        | ----- | ----- |
        | `deploy_policy` | Deployment policy for instances in the group. |
        | `scale_policy` | Scaling policy for instances in the group. |
        | `allocation_policy` | Policy for allocating instances across zones and regions. |

        Full code for the `specification.yaml` file:

        ```
        name: container-optimized-group
        service_account_id: aje3932acd8avp6edhbt
        description: "This instance group was created from YAML config."
        instance_template:
            service_account_id: aje3932acd8avp6edhbt # ID of the service account to access private Docker images.
            platform_id: standard-v3
            resources_spec:
                memory: 2G
                cores: 2
            boot_disk_spec:
                mode: READ_WRITE
                disk_spec:
                    image_id: fd81a49qficqvt0dthu8
                    type_id: network-hdd
                    size: 32G
            network_interface_specs:
                - network_id: c64mknqgnd8avp6edhbt
                  primary_v4_address_spec: {}
            metadata:
                docker-container-declaration: |-
                    spec:
                        containers:
                            - name: nginx
                              image: cr.yandex/mirror/nginx:1.17.4-alpine
                              securityContext:
                                privileged: false
                              tty: false
                              stdin: false
        deploy_policy:
            max_unavailable: 1
            max_expansion: 0
        scale_policy:
            fixed_scale:
                size: 3
        allocation_policy:
            zones:
                - zone_id: ru-central1-a
        ```

        {% note info %}

        To use in `specification.yaml` [the Docker Compose specification](../../cos/concepts/index.md#compose-spec), specify the `docker-compose` key instead of the `docker-container-declaration` key.

        {% endnote %}

1. Create an instance group in the default folder:

    ```
    $ {{ yc-compute-ig }} create --file specification.yaml
    ```

    This command creates a group of three similar instances with the following characteristics:
    - Named `container-optimized-group`.
    - From the latest version of the public {{ coi }}.
    - With a running Docker container based on `cr.yandex/mirror/nginx:1.17.4-alpine`.
    - In the `default-net` network.
    - In the `ru-central1-a` availability zone.
    - With 2 vCPUs and 2 GB of RAM.
    - With a 32 GB network HDD.

