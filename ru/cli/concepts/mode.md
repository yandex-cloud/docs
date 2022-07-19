# Синхронный и асинхронный режимы выполнения команд

В CLI доступны два режима выполнения команд: синхронный и асинхронный.

Все команды по умолчанию выполняются в **синхронном режиме**. После запуска команды в этом режиме CLI ожидает завершения соответствующей операции в {{ yandex-cloud }}. Если выполнение команды занимает длительное время, на экран выводятся точки, обозначающие процесс выполнения.

Команды, которые выполняются длительное время, удобно запускать в **асинхронном режиме**. После запуска команды в этом режиме CLI сразу выдает информацию о соответствующей операции в {{ yandex-cloud }} и дает пользователю возможность продолжить работу. Чтобы использовать этот режим, запустите команду с флагом `--async`. В ответ на такой вызов CLI вернет идентификатор операции, который в дальнейшем используется для получения информации об операции.

Чтобы получить информацию об операции, запущенной в асинхронном режиме, воспользуйтесь следующими командами:

- Узнать текущий статус выполнения операции:

    ```
    yc operation get <идентификатор операции>
    ```

    - Если операция еще не завершилась, будет повторно выведена информация об операции.
    - Если операция завершилась, будет выведен результат операции.

- Вернуться к синхронному режиму выполнения операции:

    ```
    yc operation wait <идентификатор операции>
    ```

## Примеры {#example}

Сравните выполнение команды по созданию виртуальной машины в разных режимах.

### Выполнение команды в синхронном режиме {#sync}

Сначала на экран выводятся точки, обозначающие, что операция выполняется, затем выводится результат операции.

```
yc compute instance create --name my-inst3 --metadata user-data="#ps1\nnet user Administrator Passw0rd" --zone {{ region-id }}-a --public-ip --create-boot-disk image-folder-id=standard-images,image-name=windows-2016-gvlk-1537967224
....................................................................................................................................................................done
id: epdplofgadqohn5ppkt3
folder_id: b1g88tflru0ek1omtsu0
created_at: "2019-01-23T14:18:21Z"
name: my-inst3
zone_id: {{ region-id }}-a
platform_id: standard-v3
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "100"
status: RUNNING
boot_disk:
  mode: READ_WRITE
  device_name: epdb30lg3sidrc65hbg1
  auto_delete: true
  disk_id: epdb30lg3sidrc65hbg1
network_interfaces:
- index: "0"
  mac_address: d0:0d:19:ae:1f:05
  subnet_id: e2lj2pco4kg851gsv3n2
  primary_v4_address:
    address: 10.0.0.11
    one_to_one_nat:
      address: 84.201.142.79
      ip_version: IPV4
fqdn: epdplofgadqohn5ppkt3.auto.internal
```

### Выполнение команды в асинхронном режиме {#async}

После запуска команды на экран выводится информация об операции, а выполнение продолжается в фоновом режиме.

```
yc compute instance create --name my-test-inst --metadata user-data="#ps1\nnet user Administrator Passw0rd" --zone {{ region-id }}-a --public-ip --create-boot-disk image-folder-id=standard-images,image-name=windows-2016-gvlk
-1537967224 --async
id: epdjte17at0fguj52ili
description: Create instance
created_at: "2019-02-13T08:49:25Z"
created_by: ajed79hm85fu3g6g5uej
modified_at: "2019-02-13T08:49:25Z"
metadata:
  '@type': type.googleapis.com/yandex.cloud.compute.v1.CreateInstanceMetadata
  instance_id: epdil0po4toutfhjrk0g
```
