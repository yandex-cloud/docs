---
title: Решение проблем с {{ coi }} в {{ cos-full-name }}
description: Следуя данной инструкции, вы сможете решить проблемы с {{ coi }}.
---

# Решение проблем

Для просмотра логов запуска [Docker-образов](/blog/posts/2022/03/docker-containers) используйте команду:

```bash
sudo journalctl -eu yc-container-daemon
```

Ниже приведены часто возникающие ошибки и способы их решения.

## У сервисного аккаунта нет прав на скачивание указанного Docker-образа {#permission-denied}

**Пример**:

```text
Mar 25 12:07:39 instance-name yc-container-daemon[516]:
{"level":"DEBUG","ts":"2021-03-25T12:07:39.785Z","caller":"container/image.go:75","msg":"trying to pull image (0/3)"}
Mar 25 12:07:39 instance-name yc-container-daemon[516]:
{"level":"DEBUG","ts":"2021-03-25T12:07:39.786Z","caller":"container/image.go:47","msg":"pulling image: '{{ registry }}/crpgrueprn********/nginx:1.16.0'"}
Mar 25 12:07:41 instance-name yc-container-daemon[516]:
{"level":"ERROR","ts":"2021-03-25T12:07:41.005Z","caller":"container/image.go:78","msg":"error pulling image: Error response from daemon: pull access denied for {{ registry }}/crpgruern********/ngin>
```

**Как исправить**: [назначьте сервисному аккаунту роль](../../iam/operations/sa/set-access-bindings.md) `viewer` или `container-registry.images.puller` на репозиторий, реестр или каталог. Подробнее про роли, действующие в сервисе, читайте в [документации](../../container-registry/security/index.md).

## Отсутствует сетевой доступ к {{ container-registry-name }} {#connection-to-cr}

**Пример**:

```text
Sep 28 08:00:18 instance-name yc-container-daemon[952]:
{"level":"DEBUG","ts":"2019-09-28T08:00:18.842Z ","caller":"container/container.go:121","msg":"trying to pull image (0/3)"}
Sep 28 08:00:18 instance-name yc-container-daemon[952]:
{"level":"DEBUG","ts":"2019-09-28T08:00:18.842Z","caller":"container/container.go:162","msg":"pulling image: '{{ registry }}/crpgrueprnhc********/nginx:1.16.0'"}
Sep 28 08:00:33 instance-name yc-container-daemon[952]:
{"level":"ERROR","ts":"2019-09-28T08:00:33.843Z","caller":"container/container.go:124","msg":"error pulling image: Error response from daemon: Get https://{{ registry }}/v2/: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)"}
```

**Как исправить**: проверьте доступ к {{ container-registry-name }} командой: `nc -vz {{ registry }} 443`. Если доступа нет, [настройте NAT-инстанс](../../tutorials/routing/nat-instance/index.md) или назначьте публичный IP-адрес на виртуальные машины с {{ coi }}. Также можно [настроить NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подсети, в которой создаются ВМ.

## К ВМ не привязан сервисный аккаунт для доступа к {{ container-registry-name }} {#sa-for-registry}

**Пример**:

```text
Mar 25 12:13:23 instance-name yc-container-daemon[518]:
{"level":"WARN","ts":"2021-03-25T12:13:23.466Z","caller":"container/container.go:240","msg":"Attempting to pull Container Registry image with empty credentials. It will only work if public registry>
Mar 25 12:13:23 instance-name yc-container-daemon[518]:
{"level":"DEBUG","ts":"2021-03-25T12:13:23.466Z","caller":"container/image.go:75","msg":"trying to pull image (0/3)"}
Mar 25 12:13:23 instance-name yc-container-daemon[518]:
{"level":"DEBUG","ts":"2021-03-25T12:13:23.467Z","caller":"container/image.go:47","msg":"pulling image: '{{ registry }}/crpgruehrnhc********/nginx:1.16.0'"}
Mar 25 12:13:24 instance-name yc-container-daemon[518]:
{"level":"ERROR","ts":"2021-03-25T12:13:24.706Z","caller":"container/image.go:78","msg":"error pulling image: Error response from daemon: unauthorized: Authentication problem ; requestId = b2f6f07>
```

**Как исправить**: для приватных реестров [привяжите сервисный аккаунт](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) для доступа к Docker-образам.

## Не хватает места на диске {#disk-full}

**Пример**:

```text
Mar 25 12:34:22 instance-name yc-container-daemon[518]:
{"level":"DEBUG","ts":"2021-03-25T12:34:22.043Z","caller":"container/image.go:75","msg":"trying to pull image (0/3)"}
Mar 25 12:34:22 instance-name yc-container-daemon[518]:
{"level":"DEBUG","ts":"2021-03-25T12:34:22.043Z","caller":"container/image.go:47","msg":"pulling image: 'openjdk:7' (normalized: 'docker.io/library/openjdk:7')"}
Mar 25 12:34:46 instance-name yc-container-daemon[518]:
{"level":"DEBUG","ts":"2021-03-25T12:34:46.276Z","caller":"container/image.go:59","msg":"received ImagePull response: ... {\"message\":\"failed to register layer: Error processing tar file(exit status 1): write /usr/bin/hostnamectl: no space left on device\"},\"error\":\"failed to register layer: Error processing tar file(exit status 1): write /usr/bin/hostnamectl: no space left on device\"}\r\n)."}
```

**Как исправить**: остановите ВМ и [увеличьте размер диска](../../compute/operations/disk-control/update.md#change-disk-size).

## Не указан раздел диска {#disk-partition}

**Пример**:

```text
Oct 23 19:43:36 instance-name yc-container-daemon[781]: {"level":"ERROR","ts":"2024-10-23T19:43:36.478Z","caller":"mdtracking/checker.go:135","msg":"OnChange callback failed: received multiline output from lsblk, the device likely contains subpartitions:\nNAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS\nloop0    7:0    0  63.3M  1 loop /snap/core20/1822\nloop1    7:1    0    64M  1 loop /snap/core20/2379\nloop2    7:2    0 111.9M  1 loop /snap/lxd/24322\nloop3    7:3    0    87M  1 loop /snap/lxd/29351\nloop4    7:4    0  49.8M  1 loop /snap/snapd/18357\nloop5    7:5    0  38.8M  1 loop /snap/snapd/21759\nvda    252:0    0    30G  0 disk \n├─vda1 252:1    0     1M  0 part \n└─vda2 252:2    0    30G  0 part /\nvdb    252:16   0    20G  0 disk \n├─vdb1 252:17   0     1M  0 part \n└─vdb2 252:18   0    15G  0 part \n"}
```

**Как исправить**: узнайте номер раздела для монтирования с помощью команды `lsblk`, добавьте параметр `partition: x` в [спецификацию Docker Compose](../concepts/coi-specifications.md#compose-spec), где `x` — номер раздела для монтирования и [обновите](../tutorials/vm-update.md) ВМ, используя отредактированную спецификацию.

## Не монтируется диск {#disk-mount}

**Пример**:

```text
Sep 29 08:10:10 instance-name yc-container-daemon[743]: {"level":"ERROR","ts":"2024-09-29T08:10:10.133Z","caller":"mdtracking/checker.go:135","msg":"OnChange callback failed: device /dev/disk/by-id/virtio-coi-data access error: stat /dev/disk/by-id/virtio-coi-data: no such file or directory"}
```

**Как исправить**: задайте параметр `device-name`, равный значению `device_name` в [спецификации Docker Compose](../concepts/coi-specifications.md#compose-spec-example). Параметр `device-name` можно задать в параметрах и командах CLI по добавлению дисков на ВМ или в консоли управления при [подключении](../../compute/operations/vm-control/vm-attach-disk#attach) диска к ВМ. В примере логов выше `device-name` будет `coi-data`.

## Платформа запрошенного образа не соответствует платформе хоста {#platforms-not-match}

**Пример**:

```text
WARNING: The requested image's platform (linux/arm64/v8) does not match the detected host platform (linux/amd64/v4) and no specific platform was requested
```

**Как исправить**: используйте Docker-образ с поддержкой той платформы, которая соответствует ОС и архитектуре вашей ВМ.

Один Docker-образ может поддерживать [несколько платформ](https://docs.docker.com/build/building/multi-platform/). При запуске такого образа Docker автоматически выбирает вариант, который соответствует ОС и архитектуре вашего хоста. Если образ не содержит вариант, соответствующий вашей платформе, он не запустится, и появится сообщение об ошибке.
