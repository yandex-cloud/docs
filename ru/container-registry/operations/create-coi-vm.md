# Создать ВМ с Container Optimized Image

Создайте виртуальную машину из образа Container Optimized Image и запустите на ней Docker-контейнер.

_Container Optimized Image_ — [образ](../../compute/concepts/image.md) виртуальной машины, оптимизированный для запуска Docker-контейнеров. Образ включает в себя: Ubuntu 16.04, Docker и Docker Compose.

Образ интегрирован с платформой Яндекс.Облака, это позволяет: 
 - Запускать Docker-контейнер, указанный в настройках виртуальной машины, сразу после ее создания из консоли управления или YC CLI.
 - Получать доступ к открытым сетевым портам Docker-контейнера без дополнительных настроек.
 - Обновлять запущенный Docker-контейнер с минимальным временем простоя.

Чтобы запустить Docker-контейнер: 
- [Ознакомьтесь со структрурой метаданных для создания Docker-контейнера](#meta-structure).
- [Подготовьте файл с метаданными](#metadata).
- [Создайте ВМ с Docker-контейнером](#coi-vm).

## Структура метаданных для создания Docker-контейнера {#meta-structure}

Формат совпадает со [спецификацией {{ k8s }} для пода](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.11/#podspec-v1-core).

```
spec:
  containers: # Список контейнеров на ВМ. Должен быть только один Docker-контейнер.
  - command: # CMD для запуска в Docker-образе, необязательное поле.
    - <команда>
    args: 
    - <аргументы команды>
    env: # Переменные окружения для Docker-образа.
    - name: <ключ>
      value: <значение>
    image: <имя Docker-образа и тег>
    name: <имя Docker-контейнера>
    securityContext:
      privileged: false
    stdin: false
    tty: false
    volumeMounts: []
  restartPolicy: Always
  volumes: []
```

## Создайте ВМ с Docker-контейнером на базе Container Optimized Image {#create-vm}

### Подготовьте файл с метаданными {#metadata}

Сохраните следующий пример метаданных в файл `my-container.yaml`:

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

### Создайте ВМ с Docker-контейнером {#coi-vm}

Создайте ВМ и Docker-контейнер, используя метаданные из файла `my-container.yaml`:

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

После создания виртуальная машина появится в списке работающих ВМ в разделе **{{ compute-name }}** в [консоли управления](https://console.cloud.yandex.ru/).

Подробнее о работе с ВМ читайте в [пошаговых инструкциях](../../compute/operations/index.md). 

## Обновите Docker-контейнер {#update}

Чтобы обновить Docker-контейнер, обновите файл с метаданными и добавьте их к виртуальной машине командой:

```
$ yc compute instance add-metadata \
                      --metadata-from-file docker-container-declaration=<путь к файлу с метаданными> \
                      <имя виртуальной машины>
```
