# Управление политикой обслуживания

Чтобы включить и настроить [политику обслуживания ВМ](../../concepts/vm-policies.md), выполните следующие шаги:

1. [Создайте ВМ с настроенной политикой обслуживания](#create).
2. [Проверьте обработку событий обслуживания](#check).
3. [Подключитесь к ВМ по SSH](#ssh).
4. [Создайте скрипт для отслеживания событий обслуживания ВМ](#script).
5. [Симулируйте наступление события обслуживания ВМ](#simulate).
6. [Опционально. Измените тип политики обслуживания для ВМ](#change-policy).

## Создайте ВМ с настроенной политикой обслуживания {#create}

{% list tabs group=instructions %}

- CLI {#cli}

  Создайте ВМ с политиками обслуживания:

  ```
  FOLDER_ID=$(yc config get folder-id)

  yc compute instance create --name mnt-vm1 --hostname mnt-vm1\
    --folder-id $FOLDER_ID \
    --zone {{ region-id }}-a \
    --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
    --cores=2 --memory=4G --core-fraction=100 \
    --network-interface subnet-name=default-{{ region-id }}-a,ipv4-address=auto,nat-ip-version=ipv4 \
    --ssh-key ~/.ssh/id_ed25519.pub \
    --maintenance-policy restart \
    --maintenance-grace-period 1m
  ```

- Terraform {#tf}

  1. Создайте Terraform-манифест `mnt-vm.tf`:

      ```
      terraform {
        required_providers {
          yandex = {
            source  = "yandex-cloud/yandex"
            version = "~> 0.105.0"
          }
        }
      }

      variable "folder_id" {
        type = string
      }

      data "yandex_compute_image" "vm_image" {
        family = "ubuntu-2204-lts"
      }

      data "yandex_vpc_subnet" "vm_subnet" {
        folder_id = var.folder_id
        name      = "default-{{ region-id }}-a"
      }

      resource "yandex_compute_instance" "vm_instance" {
        name                     = "mnt-vm1"
        folder_id                = var.folder_id
        hostname                 = "mnt-vm1"
        zone                     = "{{ region-id }}-a"
        maintenance_policy       = "restart" # restart| migrate | unspecified
        maintenance_grace_period = "1m"

        resources {
          cores  = 2
          memory = 4
        }

        boot_disk {
          initialize_params {
            image_id = data.yandex_compute_image.vm_image.id
          }
        }

        network_interface {
          subnet_id = data.yandex_vpc_subnet.vm_subnet.id
          nat       = true
        }

        metadata = {
          ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
        }
      }
      ```

  1. Примените Terraform-манифест:

      ```bash
      export YC_TOKEN=$(yc iam create-token)
      export TF_VAR_folder_id=$(yc config get folder-id)

      terraform init
      terraform apply
      ```

{% endlist %}

## Проверьте обработку событий обслуживания {#check}

Проверить конфигурацию политик обслуживания ВМ после ее создания можно с помощью CLI. Выполните команду:

```
yc compute instance get --name=mnt-vm1 --format=json | grep maintenance
```

Ожидаемый результат:

```
  "maintenance_policy": "RESTART",
  "maintenance_grace_period": "60s"
```

## Подключитесь к ВМ по SSH {#ssh}

Получите IP-адрес ВМ и сохраните его в переменную, а затем подключитесь к ВМ по SSH с именем вашего пользователя:

```
VM_IP=$(yc compute instance get --name=mnt-vm1 --format=json | jq -r '.network_interfaces[0].primary_v4_address.one_to_one_nat.address')

ssh <имя_пользователя>@$VM_IP
```

## Создайте скрипт для отслеживания событий обслуживания ВМ {#script}

Создайте файл `mnt-pol.sh` и добавьте в него следующий код:

```
#!/bin/bash

while true
do 
  echo -n `date`" : "
  curl -s -H Metadata-Flavor:Google http://metadata.google.internal/computeMetadata/v1/instance/maintenance-event
  echo
  sleep 1
done
```

Запустите скрипт:

```
chmod u+x mnt-pol.sh
./mnt-pol.sh
```

## Симулируйте наступление события обслуживания ВМ {#simulate}

Симулировать наступление события обслуживания с помощью CLI. Выполните команду:

```
yc compute instance simulate-maintenance-event --name=mnt-vm1
```

Убедитесь, что событие отображается в терминале:

```
yc-user@mnt-vm1:~$ ./mnt-pol.sh
Tue Jan 16 14:14:40 UTC 2024 : NONE
Tue Jan 16 14:14:41 UTC 2024 : NONE
...
Tue Jan 16 14:23:38 UTC 2024 : NONE
Tue Jan 16 14:23:39 UTC 2024 : TERMINATE_ON_HOST_MAINTENANCE
Tue Jan 16 14:23:40 UTC 2024 : TERMINATE_ON_HOST_MAINTENANCE
Tue Jan 16 14:23:41 UTC 2024 : TERMINATE_ON_HOST_MAINTENANCE
...
Tue Jan 16 14:24:48 UTC 2024 : TERMINATE_ON_HOST_MAINTENANCE
Tue Jan 16 14:24:49 UTC 2024 : NONE
```

## Измените тип политики обслуживания для ВМ {#change-policy}

Изменить тип политики обслуживания для ВМ можно указав новое значение параметра `--maintenance-policy` командой:

```
yc compute instance update --name=mnt-vm1 --maintenance-policy=migrate
```

Симулируйте наступление события обслуживания с помощью CLI:

```
yc compute instance simulate-maintenance-event --name=mnt-vm1
```

Снова запустите скрипт и убедитесь, что политика изменилась:

```
yc-user@mnt-vm1:~$ ./mnt-pol.sh
Tue Jan 16 14:32:09 UTC 2024 : NONE
Tue Jan 16 14:32:10 UTC 2024 : NONE
...
Tue Jan 16 14:32:23 UTC 2024 : MIGRATE_ON_HOST_MAINTENANCE
Tue Jan 16 14:32:24 UTC 2024 : MIGRATE_ON_HOST_MAINTENANCE
...
Tue Jan 16 14:33:23 UTC 2024 : MIGRATE_ON_HOST_MAINTENANCE
Tue Jan 16 14:33:24 UTC 2024 : MIGRATE_ON_HOST_MAINTENANCE
Tue Jan 16 14:33:25 UTC 2024 : NONE
```
