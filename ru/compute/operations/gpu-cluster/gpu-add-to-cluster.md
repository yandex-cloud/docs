# Добавить виртуальную машину в кластер GPU

В кластерах GPU можно создавать только виртуальные машины на платформе {{ a100-epyc }} c 8 GPU. Вам понадобится подготовить образ диска с драйверами [по инструкции](../image-create/custom-image.md) и использовать его при создании ВМ.

{% note info %}

Кластеры GPU сейчас доступны только в зоне `ru-central1-a`. Добавить виртуальную машину в кластер можно только из той же зоны доступности.

{% endnote %}

{% list tabs %}

- CLI

  ```bash
  export YC_GPU_CLUSTER=$(yc compute gpu-cluster list --format=json | jq -r .[].id)
  export YC_ZONE="ru-central1-a"
  export SUBNET_NAME="my-subnet-name"
  export SUBNET_ID=$(yc vpc subnet get --name=$SUBNET_NAME --format=json | jq -r .id)
  yc compute instance create --name node-gpu-test \
    --create-boot-disk size=64G,image-id=<идентификатор_образа_с_драйверами>,type=network-ssd \
    --ssh-key=$HOME/.ssh/id_rsa.pub \
    --gpus 8 --cores 224 --memory=952G \
    --zone $YC_ZONE \
    --network-interface subnet-id=$SUBNET_ID,nat-ip-version=ipv4 \
    --platform gpu-standard-v3 \
    --gpu-cluster-id=$YC_GPU_CLUSTER
  ```

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

    1. Опишите в конфигурационном файле {{ TF }} параметры ресурса, который необходимо создать:

              
        ```hcl
        provider "yandex" {
          zone = "{{ region-id }}-a"
        }

        resource "yandex_compute_instance" "default" {
          name           = "vm-gpu"
          platform_id    = "gpu-standard-v3"
          zone           = "{{ region-id }}-a"
          gpu_cluster_id = "<идентификатор_кластера_GPU>"

          resources {
            cores  = "224"
            memory = "952"
            gpus   = "8"
          }

          boot_disk {
            initialize_params {
              image_id = "<идентификатор_образа_с_драйверами>"
              size     = "64"
            }
          }

          network_interface {
            subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
            nat       = true
          }

          metadata = {
            user-data = "#cloud-config\nusers:\n  - name: <имя_пользователя>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("<путь_к_открытому_SSH-ключу>")}"
          }
        }

        resource "yandex_vpc_network" "network-1" {
          name = "network1"
        }

        resource "yandex_vpc_subnet" "subnet-1" {
          name           = "subnet1"
          zone           = "<зона_доступности>"
          v4_cidr_blocks = ["192.168.10.0/24"]
          network_id     = "${yandex_vpc_network.network-1.id}"
        }
        ```



        Где:

        * `gpu_cluster_id` — идентификатор кластера GPU. Обязательный параметр.
        * `image_id` — идентификатор образа с драйверами. Обязательный параметр.
        * `yandex_vpc_network` — описание [облачной сети](../../../vpc/concepts/network.md).
        * `yandex_vpc_subnet` — описание [подсети](../../../vpc/concepts/network.md#subnet), в которой будет создана виртуальная машина.

        
        {% note info %}

        Если у вас уже есть подходящие ресурсы (облачная сеть и подсеть), описывать их повторно не нужно. Используйте их имена и идентификаторы в соответствующих параметрах.

        {% endnote %}

        Подробную информацию о параметрах ресурса `yandex_compute_instance` см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/compute_instance).

    1. В блоке `metadata` укажите имя пользователя и путь к открытому SSH-ключу. Подробнее см. в разделе [{#T}](../../../compute/concepts/vm-metadata.md).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  После этого в указанном кластере будет создана ВМ. Проверить появление ВМ и ее настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```bash
    yc compute instance get <имя_виртуальной_машины>
    ```

{% endlist %}