# Передача логов с Container Optimized Image в Yandex Cloud Logging

Обработчик логов [Fluent Bit](https://fluentbit.io/) позволяет транслировать логи с [виртуальных машин](../../../compute/concepts/vm.md), созданных из образов Container Optimized Image, в сервис [Yandex Cloud Logging](../../../logging/index.md). Для передачи логов используется модуль [Fluent Bit plugin for Yandex Cloud Logging](https://github.com/yandex-cloud/fluent-bit-plugin-yandex).

Чтобы настроить передачу логов с ВМ, созданной из образа Container Optimized Image:
1. [Создайте приложение, генерирующее логи](#generate-logs).
1. [Создайте Docker-образ и загрузите его в реестр](#create-docker).
1. [Настройте Fluent Bit](#fluent-bit).
1. [Создайте ВМ из образа Container Optimized Image](#create-vm).

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) с [ролями](../../../iam/concepts/access-control/roles.md) `logging.writer` и `container-registry.images.puller` на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
1. [Создайте реестр](../../../container-registry/operations/registry/registry-create.md) [Yandex Container Registry](../../../container-registry/index.md).
1. [Создайте облачную сеть](../../../vpc/operations/network-create.md). При создании выберите опцию **Создать подсети**.

## Создайте приложение, генерирующее логи {#generate-logs}

Создайте файл `logs.py`:

```py
import logging
import random
import sys
import time

import uuid

logger = logging.getLogger(__name__)

# Задаем формат логов.
formatter = logging.Formatter(
  '[req_id=%(req_id)s] [%(levelname)s] %(code)d %(message)s'
)

handler = logging.StreamHandler(stream=sys.stdout)
handler.setFormatter(formatter)

logger.addHandler(handler)

# Настраиваем уровень логирования по умолчанию, опционально.
logger.setLevel(logging.DEBUG)

# Генерируем URL-подобные значения.
PATHS = [
  '/',
  '/admin',
  '/hello',
  '/docs',
]

PARAMS = [
  'foo',
  'bar',
  'query',
  'search',
  None
]

def fake_url():
  path = random.choice(PATHS)
  param = random.choice(PARAMS)
  if param:
    val = random.randint(0, 100)
    param += '=%s' % val
  code = random.choices([200, 400, 404, 500], weights=[10, 2, 2, 1])[0]
  return '?'.join(filter(None, [path, param])), code

if __name__ == '__main__':
  while True:
    req_id = uuid.uuid4()
    # Создаем пару — код и значение URL.
    path, code = fake_url()
    extra = {"code": code, "req_id": req_id}
    # Если код 200, пишем в лог с уровнем Info.
    if code == 200:
      logger.info(
        'Path: %s',
        path,
        extra=extra,
      )
    # Иначе с уровнем Error.
    else:
      logger.error(
        'Error: %s',
        path,
        extra=extra,
      )
    # Чтобы было несколько сообщений с одинаковым request id, в 30% случаев пишем вторую запись в лог с уровнем Debug.
    if random.random() > 0.7:
      logger.debug("some additional debug log record %f", random.random(), extra=extra)

    # Ждем одну секунду, чтобы не засорять журнал.
    time.sleep(1)
```

## Создайте Docker-образ и загрузите его в реестр {#create-docker}

1. Создайте файл Dockerfile и добавьте в него следующие строки:

    ```dockerfile
    FROM python:3.10

    WORKDIR /usr/src/app

    COPY logs.py .

    CMD [ "python", "./logs.py" ]
    ```

    Dockerfile описывает [Docker-образ](../../../container-registry/concepts/docker-image.md), который содержит приложение, генерирующее логи.
1. Соберите Docker-образ:

    ```bash
    docker build . \
      -t cr.yandex/<идентификатор_реестра>/coi:logs
    ```

1. [Аутентифицируйтесь](../../../container-registry/operations/authentication.md) в [реестре](../../../container-registry/concepts/registry.md) и загрузите в него Docker-образ:

    ```bash
    docker push cr.yandex/<идентификатор_реестра>/coi:logs
    ```

## Настройте Fluent Bit {#fluent-bit}

1. Создайте файл `spec.yaml`. Он описывает спецификацию двух контейнеров: с приложением, генерирующим логи, и агентом Fluent Bit.

   Укажите в поле:
   * `image` — URL Docker-образа. Чтобы узнать его, в [консоли управления](https://console.yandex.cloud) перейдите на страницу **Обзор Docker-образа** и скопируйте значение из поля **Теги**.
   * `YC_GROUP_ID` — идентификатор [лог-группы по умолчанию](../../../logging/concepts/log-group.md) `default`.

   В секции `fluentbit`, в поле `image`, указан актуальный на момент написания инструкции образ контейнера с агентом Fluent Bit. Список всех доступных образов можно найти по [ссылке](https://github.com/yandex-cloud/fluent-bit-plugin-yandex/releases).

   ```yaml
   version: '3.7'
   services:
     logs:
       container_name: logs-app
       image: <URL_Docker-образа>
       restart: always
       depends_on:
         - fluentbit
       logging:
         # Fluent Bit понимает логи в этом формате.
         driver: fluentd
         options:
           # Fluent Bit слушает логи на порту 24224.
           fluentd-address: localhost:24224
           # Теги используются для маршрутизации логов.
           tag: app.logs

     fluentbit:
       container_name: fluentbit
       image: cr.yandex/yc/fluent-bit-plugin-yandex:v2.1.1-fluent-bit-1.8.15
       ports:
         - 24224:24224
         - 24224:24224/udp
       restart: always
       environment:
         YC_GROUP_ID: <идентификатор_лог-группы>
       volumes:
         - /etc/fluentbit/fluentbit.conf:/fluent-bit/etc/fluent-bit.conf
         - /etc/fluentbit/parsers.conf:/fluent-bit/etc/parsers.conf
   ```

1. Создайте файл `user-data.yaml`. Он описывает правила, по которым будут читаться логи контейнера. Если необходимо, в секции `users` измените имя пользователя и [SSH-ключ](../../../glossary/ssh-keygen.md). Подробнее о том, как [сгенерировать SSH-ключи](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

   
   ```yaml
   #cloud-config
   write_files:
     - content: |
         [SERVICE]
             Flush         1
             Log_File      /var/log/fluentbit.log
             Log_Level     error
             Daemon        off
             Parsers_File  /fluent-bit/etc/parsers.conf

         [FILTER]
             Name parser
             Match app.logs
             Key_Name log
             Parser app_log_parser
             Reserve_Data On

         [INPUT]
             Name              forward
             Listen            0.0.0.0
             Port              24224
             Buffer_Chunk_Size 1M
             Buffer_Max_Size   6M

         [OUTPUT]
             Name            yc-logging
             Match           *
             group_id        ${YC_GROUP_ID}
             message_key     text
             level_key       severity
             default_level   WARN
             authorization   instance-service-account
       path: /etc/fluentbit/fluentbit.conf
     - content: |
         [PARSER]
             Name   app_log_parser
             Format regex
             Regex  ^\[req_id=(?<req_id>[0-9a-fA-F\-]+)\] \[(?<severity>.*)\] (?<code>\d+) (?<text>.*)$
             Types  code:integer
       path: /etc/fluentbit/parsers.conf

   users:
     - name: username
       groups: sudo
       shell: /bin/bash
       sudo: 'ALL=(ALL) NOPASSWD:ALL'
       ssh_authorized_keys:
         - ssh-ed25519 AAAA
   ```


   В секции `SERVICE` указаны настройки приложения Fluent Bit. [Подробнее о настройках](https://docs.fluentbit.io/manual/administration/configuring-fluent-bit).

   В секции `INPUT` указано, откуда и как забирать логи. Для работы с логами в формате Fluentd и Fluent Bit используется протокол `forward`. Fluent Bit слушает логи на порту 24224.

   В секции `PARSER` описан парсер `regex`. В нем задано регулярное выражение, с помощью которого обрабатываются записи:
   * `req_id` — уникальный идентификатор запроса.
   * `severity` — уровень логирования.
   * `code` — HTTP-код ответа.
   * `text` — весь остальной текст.

   В секции `FILTER` указано, что ищутся только записи с тегом `app.logs`. Поле `log` каждой записи обрабатывается парсером `regex`, все остальные поля сохраняются в `Reserve_Data On`.

## Создайте ВМ из образа Container Optimized Image {#create-vm}

Укажите в поле:
* `--zone` — [зону доступности](../../../overview/concepts/geo-scope.md), например `ru-central1-a`.
* `--subnet-name` — имя [подсети](../../../vpc/concepts/network.md#subnet) в указанной зоне.
* `--service-account-name` — имя [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).

```bash
IMAGE_ID=$(yc compute image get-latest-from-family container-optimized-image --folder-id standard-images --format=json | jq -r .id)

yc compute instance create \
  --name coi-vm \
  --zone=<зона> \
  --network-interface subnet-name=<имя_подсети>,nat-ip-version=ipv4 \
  --metadata-from-file user-data=user-data.yaml,docker-compose=spec.yaml \
  --create-boot-disk image-id=${IMAGE_ID} \
  --service-account-name <имя_сервисного_аккаунта>
```

{% note info %}

Команды [`yc compute instance create`](../../../cli/cli-ref/compute/cli-ref/instance/create.md) | [`create-with-container`](../../../cli/cli-ref/compute/cli-ref/instance/create-with-container.md) | [`update`](../../../cli/cli-ref/compute/cli-ref/instance/update.md) | [`add-metadata`](../../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) поддерживают подстановку в метаданные ВМ значений переменных окружения. Эти значения, заданные в ключе `user-data` в формате `$<имя_переменной>`, в момент выполнения команды Yandex Cloud CLI будут подставлены в метаданные ВМ из переменных окружения среды, в которой выполняется команда. 

Чтобы изменить такое поведение, не подставлять значение переменной из среды выполнения команды CLI и передать в метаданные ВМ имя переменной в формате `$<имя_переменной>`, используйте синтаксис с двумя символами доллара. Например: `$$<имя_переменной>`.

Подробнее в разделе [Особенности передачи переменных окружения в метаданных через CLI](../../../compute/concepts/metadata/sending-metadata.md#environment-variables).

{% endnote %}

## Посмотрите логи {#read-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится лог-группа `default`, идентификатор которой вы указали в файле `spec.yaml`.
  1. Перейдите в сервис **Cloud Logging**.
  1. Выберите лог-группу `default`. На открывшейся странице отобразятся записи.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы посмотреть записи в лог-группе, выполните команду:

  ```bash
  yc logging read --group-id=<идентификатор_лог-группы>
  ```

  Где `--group-id` — идентификатор лог-группы `default`, который указан в файле `spec.yaml`.

- API {#api}

  Посмотреть записи в лог-группе можно с помощью вызова gRPC API [LogReadingService/Read](../../../logging/api-ref/grpc/LogReading/read.md).

{% endlist %}

## Удалите созданные ресурсы {#delete-resources}

Если созданные ресурсы вам больше не нужны, удалите их:
1. [Удалите облачную сеть](../../../vpc/operations/network-delete.md).
1. [Удалите Docker-образ](../../../container-registry/operations/docker-image/docker-image-delete.md).
1. [Удалите реестр](../../../container-registry/operations/registry/registry-delete.md).
1. [Удалите ВМ](../../../compute/operations/vm-control/vm-delete.md).
1. [Удалите лог-группу](../../../logging/operations/delete-group.md).