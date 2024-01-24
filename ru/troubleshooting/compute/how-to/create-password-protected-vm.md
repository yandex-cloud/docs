# Как создать виртуальную машину с доступом по паролю


## Описание сценария {#case-description}

Необходимо создать виртуальную машину с доступом по паролю.

## Решение {#case-resolution}

В публичных образах Linux, предоставляемых Yandex Cloud, возможность подключения по протоколу SSH с использованием логина и пароля по умолчанию отключена. Включить ее можно либо изнутри виртуальной машины, либо при создании ВМ с помощью метаданных.

Подробнее о метаданных ВМ мы пишем в [документации](../../../compute/concepts/vm-metadata).

{% note alert %}

Обратите внимание, что подключение с помощью логина и пароля менее безопасно, чем подключение с помощью пары ключей.

{% endnote %}

Пример метаданных, с которыми будет создан пользователь `username` с паролем `12345678`:
```
#cloud-config
datasource:
 Ec2:
  strict_id: false
ssh_pwauth: yes
users:
  - name: username
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
chpasswd: 
  list: |
     username:12345678
  expire: False

```
Передать метаданные можно при создании ВМ с помощью CLI, API или Terraform. Пример команды для CLI:
```
yc compute instance create  --name instance --zone ru-central1-a \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts \
--metadata-from-file user-data=metadata.yaml
```