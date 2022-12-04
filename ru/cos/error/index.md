# Решение проблем

Для просмотра логов запуска {% if lang == "ru" %}[Docker-образов](https://cloud.yandex.ru/blog/posts/2022/03/docker-containers){% else %}Docker-образов{% endif %} используйте команду:

```bash
sudo journalctl -u yc-container-daemon
```

Ниже приведены часто возникающие ошибки и способы их решения.

## У сервисного аккаунта нет прав на скачивание указанного Docker-образа {#permission-denied}

**Пример:**

```
Mar 25 12:07:39 instance-name yc-container-daemon[516]:
{"level":"DEBUG","ts":"2021-03-25T12:07:39.785Z","caller":"container/image.go:75","msg":"trying to pull image (0/3)"}
Mar 25 12:07:39 instance-name yc-container-daemon[516]:
{"level":"DEBUG","ts":"2021-03-25T12:07:39.786Z","caller":"container/image.go:47","msg":"pulling image: 'cr.yandex/crpgrueprnc1cgt1la/nginx:1.16.0'"}
Mar 25 12:07:41 instance-name yc-container-daemon[516]:
{"level":"ERROR","ts":"2021-03-25T12:07:41.005Z","caller":"container/image.go:78","msg":"error pulling image: Error response from daemon: pull access denied for cr.yandex/crpgruernc1bgt1la/ngin>
```

**Как исправить:** [назначьте сервисному аккаунту роль](../../iam/operations/sa/set-access-bindings.md) `viewer` или `container-registry.images.puller` на репозиторий, реестр или каталог. Подробнее про роли, действующие в сервисе, читайте в [документации](../../container-registry/security/index.md).

## Отсутствует сетевой доступ к {{ container-registry-name }} {#connection-to-cr}

**Пример:**

```
Sep 28 08:00:18 cl17bn514eluq62dj8jo-unar yc-container-daemon[952]:
{"level":"DEBUG","ts":"2019-09-28T08:00:18.842Z ","caller":"container/container.go:121","msg":"trying to pull image (0/3)"}
Sep 28 08:00:18 cl17bn514eluq62dj8jo-unar yc-container-daemon[952]:
{"level":"DEBUG","ts":"2019-09-28T08:00:18.842Z","caller":"container/container.go:162","msg":"pulling image: 'cr.yandex/crpgrueprnhc1cgt1lab/nginx:1.16.0'"}
Sep 28 08:00:33 cl17bn514eluq62dj8jo-unar yc-container-daemon[952]:
{"level":"ERROR","ts":"2019-09-28T08:00:33.843Z","caller":"container/container.go:124","msg":"error pulling image: Error response from daemon: Get https://cr.yandex/v2/: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)"}
```

**Как исправить:** проверьте доступ к {{ container-registry-name }} командой: `nc -vz cr.yandex 443`. Если доступа нет, [настройте NAT-инстанс](../../tutorials/routing/nat-instance.md) или назначьте публичный IP-адрес на виртуальные машины с {{ coi }}. Также можно [настроить NAT-шлюз](../../vpc/operations/create-nat-gateway.md) для подсети, в которой создаются ВМ.

## К ВМ не привязан сервисный аккаунт для доступа к {{ container-registry-name }} {#sa-for-registry}

**Пример:**

```
Mar 25 12:13:23 instance-name yc-container-daemon[518]:
{"level":"WARN","ts":"2021-03-25T12:13:23.466Z","caller":"container/container.go:240","msg":"Attempting to pull Container Registry image with empty credentials. It will only work if public registr>
Mar 25 12:13:23 instance-name yc-container-daemon[518]:
{"level":"DEBUG","ts":"2021-03-25T12:13:23.466Z","caller":"container/image.go:75","msg":"trying to pull image (0/3)"}
Mar 25 12:13:23 instance-name yc-container-daemon[518]:
{"level":"DEBUG","ts":"2021-03-25T12:13:23.467Z","caller":"container/image.go:47","msg":"pulling image: 'cr.yandex/crpgruehrnhc0bgt1lab/nginx:1.16.0'"}
Mar 25 12:13:24 instance-name yc-container-daemon[518]:
{"level":"ERROR","ts":"2021-03-25T12:13:24.706Z","caller":"container/image.go:78","msg":"error pulling image: Error response from daemon: unauthorized: Authentication problem ; requestId = b2f6f07>
```

**Как исправить:** для приватных реестров [привяжите сервисный аккаунт](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) для доступа к Docker-образам.

## Не хватает места на диске {#disk-full}

**Пример:**

```
Mar 25 12:34:22 intr13-vm yc-container-daemon[518]:
{"level":"DEBUG","ts":"2021-03-25T12:34:22.043Z","caller":"container/image.go:75","msg":"trying to pull image (0/3)"}
Mar 25 12:34:22 intr13-vm yc-container-daemon[518]:
{"level":"DEBUG","ts":"2021-03-25T12:34:22.043Z","caller":"container/image.go:47","msg":"pulling image: 'openjdk:7' (normalized: 'docker.io/library/openjdk:7')"}
Mar 25 12:34:46 intr13-vm yc-container-daemon[518]:
{"level":"DEBUG","ts":"2021-03-25T12:34:46.276Z","caller":"container/image.go:59","msg":"received ImagePull response: ... {\"message\":\"failed to register layer: Error processing tar file(exit status 1): write /usr/bin/hostnamectl: no space left on device\"},\"error\":\"failed to register layer: Error processing tar file(exit status 1): write /usr/bin/hostnamectl: no space left on device\"}\r\n)."}
```

**Как исправить:** остановите ВМ и [увеличьте размер диска](../../compute/operations/disk-control/update.md#change-disk-size).