# Миграция с Yandex IoT Core на MQTT-решения с открытым исходным кодом

{% note warning %}

Сервис Yandex IoT Core больше не доступен для новых пользователей. 

Текущие пользователи могут создавать ресурсы до 1 ноября 2026 года. После сервис перейдет в режим read-only, а 1 декабря 2026 года — прекратит работу. Подробнее о сроках и порядке закрытия читайте на странице [Закрытие сервиса](../sunset.md).

{% endnote %}

{% note warning %}

Инструменты, предложенные для миграции, являются продуктами с открытым исходным кодом, разработанными и поддерживаемыми третьими сторонами, не связанными с Яндексом. Предоставленное руководство по миграции носит исключительно информационный характер. Мы не несем ответственности за работу, функциональность, безопасность или любые последствия использования программного обеспечения сторонних инструментов, а также за возможные ошибки при адаптации ваших сценариев. Внимательно ознакомьтесь со всеми документами, регулирующими использование инструмента, выбранного для миграции.

{% endnote %}

После закрытия Yandex IoT Core вы можете развернуть альтернативное MQTT-решение самостоятельно: на [виртуальной машине](../../compute/concepts/vm.md) Yandex Compute Cloud или в [кластере](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) Yandex Managed Service for Kubernetes.

Вместо Yandex IoT Core можно использовать следующие опенсорс-решения, которые можно запустить в Yandex Cloud:

* [Eclipse Mosquitto](https://mosquitto.org/) — рекомендуемый вариант для большинства сценариев, где Yandex IoT Core использовался как MQTT-брокер.
* [TBMQ Community Edition](https://thingsboard.io/products/mqtt-broker/) — вариант для высоконагруженных MQTT-сценариев, где нужны кластеризация и долговременная доставка сообщений.
* [ThingsBoard Community Edition](https://thingsboard.io/) — вариант для сценариев, где, кроме MQTT, нужны управление устройствами, дашборды, механизм rule engine и пользовательский интерфейс.

{% note warning %}

У Yandex IoT Core нет полностью совместимого опенсорс-аналога. После миграции вам нужно самостоятельно администрировать брокер или IoT-платформу: обновлять ПО, настраивать TLS, хранить учетные данные, делать резервные копии, мониторить доступность и планировать отказоустойчивость.

{% endnote %}

## Как выбрать целевое решение {#choice}

В разделе приведено краткое сравнение трех решений. В текущем руководстве описаны подробные шаги развертывания для Eclipse Mosquitto. Чтобы использовать TBMQ и ThingsBoard, смотрите документацию соответствующего решения.

Критерий | Eclipse Mosquitto | TBMQ CE | ThingsBoard CE
--- | --- | --- | ---
Тип | Легковесный MQTT-брокер | Кластерный MQTT-брокер | IoT-платформа с MQTT API
Когда подходит | Прямая замена MQTT-части Yandex IoT Core | Высокая нагрузка, много подключений | Нужны пользовательский интерфейс, дашборды, механизм rule engine, управление устройствами
Кластеризация | Нет (только active/passive) | Да, горизонтальное масштабирование | Да
Внешние зависимости | Нет | Apache Kafka®, Redis, PostgreSQL | PostgreSQL (опционально другие хранилища)
Управление устройствами и пользовательский интерфейс | Нет | Нет | Да
Сложность эксплуатации | Низкая | Высокая | Высокая

Выбирайте Eclipse Mosquitto, если:

* устройства используют MQTT и подключаются к Yandex IoT Core по TLS;
* основная логика работает вокруг публикации и подписки на топики;
* вы готовы заменить интеграции Yandex IoT Core с Yandex Cloud Functions, Yandex Serverless Containers или Yandex Data Streams собственным обработчиком сообщений;
* вам достаточно одного брокера или отказоустойчивости уровня active/passive.

Выбирайте TBMQ Community Edition, если:

* у вас высокая нагрузка на MQTT-брокер;
* нужны кластеризация, горизонтальное масштабирование и более надежная доставка сообщений;
* вы готовы поддерживать дополнительную инфраструктуру, например Apache Kafka® и базу данных.

Выбирайте ThingsBoard Community Edition, если:

* Yandex IoT Core был частью более широкой IoT-системы;
* вам нужны управление устройствами, дашборды, механизм rule engine, пользовательский интерфейс, хранение телеметрии и обработка событий;
* вы готовы адаптировать устройства и бэкенд под модель данных ThingsBoard.

{% note tip %}

Мы рекомендуем начать с Eclipse Mosquitto. Это самый простой путь для переноса MQTT-трафика, а более сложную IoT-платформу можно добавить позже.

{% endnote %}

## Что изменится после миграции {#changes}

При переносе с Yandex IoT Core на пользовательское MQTT-решение изменятся несколько важных частей архитектуры.

### Эндпоинт {#endpoint}

В Yandex IoT Core устройства подключались к управляемому эндпоинту сервиса. После миграции вам понадобится создать собственный эндпоинт, например:

```text
mqtt.example.com:8883
```

Эндпоинт может указывать:

* на публичный IP-адрес виртуальной машины с Eclipse Mosquitto;
* на сетевой балансировщик перед брокером;
* на `Service` типа `LoadBalancer` в Yandex Managed Service for Kubernetes.

Для MQTT используйте TCP-порт `8883` и TLS. L7-балансировщик для обычного MQTT не подходит, так как MQTT использует TCP, а не HTTP.

Если часть клиентов подключалась по MQTT поверх WebSocket (например, веб- или браузерные клиенты), настройте в Mosquitto отдельного слушателя с `protocol websockets` и TLS (обычно на порту `443`) и откройте этот порт в группе безопасности.

### Аутентификация {#authentication}

В Yandex IoT Core устройства могли использовать:

* X.509-сертификаты;
* логин и пароль.

В Mosquitto можно использовать такие же подходы:

* `password_file` — для аутентификации по логину и паролю;
* `require_certificate` и `use_identity_as_username` — для аутентификации по клиентскому сертификату;
* `acl_file` — для ограничения доступа к топикам.

{% note warning %}

Пароли устройств и реестров не экспортируются из Yandex IoT Core в открытом виде. Получить их у Yandex Cloud нельзя. Если вы не сохранили пароли ранее, после миграции:

1. Сгенерируйте новый пароль для каждого устройства в целевом MQTT-брокере (например, через `mosquitto_passwd`).
1. Обновите прошивку или конфигурацию каждого устройства с новыми учетными данными.
1. Предусмотрите план поэтапной выкатки и окно обслуживания: при единовременной смене паролей все устройства, не получившие обновления, перестанут подключаться.
1. При большом парке устройств заранее подготовьте механизм массовой доставки учетных данных (OTA-обновление, конфигурационный сервис, MDM).

Yandex IoT Core также не экспортирует пароли реестров. Если ваш бэкенд использовал их для подключения к брокеру, выпустите для него новые учетные данные.

{% endnote %}

### Топики {#topics}

В Yandex IoT Core устройства и реестры используют следующие топики:

```text
$devices/<device_id>/events
$devices/<device_id>/state
$devices/<device_id>/commands
$devices/<device_id>/config
$registries/<registry_id>/events
$registries/<registry_id>/state
$registries/<registry_id>/commands
$registries/<registry_id>/config
```

Топики `state` и `config` — постоянные: брокер хранит в них последнее сообщение. Их аналог в обычном MQTT реализуется через retained-сообщения (подробнее в [разделе ниже](#permanent-topics)).

На время миграции сохраните эту структуру в Mosquitto без изменений (`$devices/...`, `$registries/...`), чтобы не трогать прошивку устройств. Все примеры ниже используют именно ее. Переход на топики без символа `$` — отдельный необязательный шаг: во время него нужно одновременно обновить прошивку устройств, ACL и подписчиков.

{% note info %}

Если устройства подключались к Yandex IoT Core с использованием алиасов топиков (например, публиковали в `events` вместо `$devices/<device_id>/events`), после миграции переведите их на полные имена топиков: Mosquitto не разворачивает алиасы Yandex IoT Core.

Системный алиас `$me` также не будет работать в Eclipse Mosquitto: обычный MQTT-брокер не заменяет `$me` на идентификатор устройства. Если устройства публиковали или читали топики через `$me/...`, переименуйте их в явные `$devices/<device_id>/...` или в выбранную вами новую схему топиков и одновременно обновите прошивку устройств, ACL и бэкенд-подписки.

{% endnote %}

{% note info %}

В MQTT топики, которые начинаются с `$`, имеют специальное значение. Подписка на `#` не получает сообщения из таких топиков. Если вы временно сохраняете структуру `$devices/...`, подписывайтесь на нее явно, например `$devices/#`.

{% endnote %}

{% note warning  %}

В отличие от Yandex IoT Core, который маршрутизировал `events`, `$devices/<id>/events` и `devices/<id>/events` в одно логическое сообщение, в обычном MQTT-брокере `$devices/<id>/events` и `devices/<id>/events` — разные топики. Сообщение, опубликованное в один, не попадет в подписчика другого.

Это критично при поэтапной миграции, когда часть устройств уже перевыпущена на новый префикс, а часть еще нет:

* в ACL дублируйте правила для обоих префиксов (примеры ниже это учитывают);
* бэкенд-подписчик должен подписаться и на `$devices/+/events/#`, и на `devices/+/events/#`, иначе он будет получать сообщения только от одной из групп устройств;
* команды и конфиги, наоборот, нужно публиковать в тот префикс, который ожидает конкретное устройство.

{% endnote %}

### Постоянные топики state и config {#permanent-topics}

В Yandex IoT Core топики `state` и `config` являются постоянными: сервис хранит последнее сообщение в таком топике.

В обычном MQTT похожее поведение реализуется с помощью флага `retain`. После миграции:

* при публикации состояния устройства в `state` передавайте сообщение с `retain = true`;
* при публикации конфигурации устройства в `config` также используйте `retain = true`;
* проверьте, что целевой брокер хранит retained-сообщения на постоянном диске.

Пример публикации retained-сообщения через `mosquitto_pub`:

```bash
mosquitto_pub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -u <device_id> \
  -P '<password>' \
  -t 'devices/<device_id>/state' \
  -m '{"online":true}' \
  -q 1 \
  -r
```

### Триггеры и экспорт сообщений {#export}

Если вы использовали триггеры для вызова функции Cloud Functions или контейнера Serverless Containers, после миграции их нужно заменить собственным подписчиком MQTT.

Такой подписчик должен:

* подписываться на MQTT-топики;
* преобразовывать сообщение в нужный формат;
* вызывать функцию, контейнер, HTTP API или отправлять сообщение в поток данных Yandex Data Streams;
* логировать ошибки и повторять обработку при сбоях.

Пример такого обработчика приведен в разделе [Замените триггеры](#replace-triggers).

## Архитектура миграции на Mosquitto {#architecture}

Рекомендуемая минимальная архитектура:

1. Устройства подключаются к Mosquitto по MQTTS на порт `8883`.
2. Mosquitto проверяет логин/пароль или клиентский сертификат устройства.
3. Mosquitto применяет ACL и разрешает устройству публиковать и читать только свои топики.
4. Бэкенд-подписчик получает сообщения из топиков `events` и `state`.
5. Бэкенд-подписчик передает сообщения в ваши обработчики, базы данных, функции Cloud Functions, контейнеры Serverless Containers или потоки данных Yandex Data Streams.
6. Команды и конфигурация публикуются бэкенд-приложением в топики `commands` и `config`.

```text
┌─────────────┐        MQTT/TLS          ┌──────────────┐
│ Устройства  │  ─────────────────────▶  │  Mosquitto   │
└─────────────┘                          └──────┬───────┘
                                                │ MQTT subscribe
                                                ▼
                                      ┌────────────────────┐
                                      │ Backend subscriber │
                                      └─────────┬──────────┘
                                                │
                 ┌──────────────────────────────┼──────────────────────────────┐
                 ▼                              ▼                              ▼
        Cloud Functions              Serverless Containers      Yandex Data Streams
```

## Выгрузите данные из Yandex IoT Core {#uploading-data}

Перед миграцией выгрузите список реестров, устройств, сертификатов и алиасов топиков.

Установите и настройте Yandex Cloud CLI, если он еще не установлен:

```bash
yc init
```

Проверьте активную конфигурацию CLI:

```bash
yc config get cloud-id
yc config get folder-id
yc config get compute-default-zone
```

{% note warning %}

Не публикуйте и не вставляйте в тикеты или чаты сырой вывод `yc config list`: он может содержать чувствительные данные. Для диагностики используйте команды `yc config get ...` или заранее замаскируйте чувствительные данные.

Если вы запускаете миграционные команды из CI, песочницы или другого ограниченного окружения, убедитесь, что `yc` может писать служебные логи в доступный каталог, либо запускайте команды вне песочницы. Иначе CLI может работать, но засорять вывод предупреждениями о невозможности записать логи.

Для автоматизации используйте каталог, который указан в `yc config get folder-id`, или передавайте `--folder-id <folder_id>` явно. Не завязывайте сценарий миграции на широкие команды вроде `yc resource-manager cloud list` и `yc resource-manager folder list`: в больших организациях они могут выполняться долго или требовать лишних прав.

{% endnote %}

Создайте каталог для экспорта:

```bash
FOLDER_ID="$(yc config get folder-id)"
mkdir -p iot-export
```

Выгрузите список реестров и брокеров. Передавайте `--folder-id` явно, чтобы экспорт не зависел от каталога, указанного в локальной конфигурации CLI:

```bash
yc iot registry list --folder-id "$FOLDER_ID" --format json > iot-export/registries.json
yc iot broker list --folder-id "$FOLDER_ID" --format json > iot-export/brokers.json
```

Выгрузите устройства, сертификаты реестров и алиасы топиков:

```bash
for registry_id in $(jq -r '.[].id' iot-export/registries.json); do
  yc iot device list \
    --folder-id "$FOLDER_ID" \
    --registry-id "$registry_id" \
    --format json > "iot-export/devices-$registry_id.json"

  yc iot registry certificate list \
    --folder-id "$FOLDER_ID" \
    --registry-id "$registry_id" \
    --format json > "iot-export/registry-certs-$registry_id.json"

  yc iot registry list-device-topic-aliases \
    --folder-id "$FOLDER_ID" \
    "$registry_id" \
    --format json > "iot-export/aliases-$registry_id.json"
done
```

Выгрузите сертификаты устройств:

```bash
for file in iot-export/devices-*.json; do
  registry_id="${file#iot-export/devices-}"
  registry_id="${registry_id%.json}"

  mkdir -p "iot-export/device-certs-$registry_id"

  jq -r '.[].id' "$file" | while read -r device_id; do
    yc iot device certificate list \
      --folder-id "$FOLDER_ID" \
      --device-id "$device_id" \
      --format json > "iot-export/device-certs-$registry_id/$device_id.json"
  done
done
```

{% note warning "Важно" %}

Файлы экспорта могут содержать идентификаторы устройств, сертификаты, алиасы топиков и другие чувствительные данные. Не сохраняйте их в публичных репозиториях. Для хранения используйте закрытый [бакет](../../storage/concepts/bucket.md) Yandex Object Storage, ограниченные права доступа и шифрование.

{% endnote %}

## Разверните Mosquitto на виртуальной машине {#vm-deployment}

Ниже приведен пример развертывания Mosquitto в Docker на виртуальной машине. Для продакшен-сценария настройте резервное копирование диска, мониторинг и процедуру восстановления.

### Создайте виртуальную машину {#create-vm}

Создайте ВМ Yandex Compute Cloud с Linux-образом и публичным IP-адресом или с доступом через сетевой балансировщик.

Рекомендации:

* используйте отдельный сервисный аккаунт для администрирования инфраструктуры;
* откройте во входящих правилах группы безопасности только порт `8883/TCP`;
* ограничьте доступ по SSH;
* храните TLS-ключи и пароли в Yandex Lockbox или в другом защищенном хранилище секретов;
* подключите Yandex Monitoring и Yandex Cloud Logging.

Перед созданием ВМ выберите SSH-ключ и административный CIDR, с которого разрешен доступ по SSH:

```bash
ls -1 ~/.ssh/*.pub

SSH_PUBLIC_KEY="$HOME/.ssh/<key>.pub"
SSH_PRIVATE_KEY="${SSH_PUBLIC_KEY%.pub}"

ssh-keygen -y -f "$SSH_PRIVATE_KEY" > /tmp/mqtt-broker-key.pub
diff -u /tmp/mqtt-broker-key.pub "$SSH_PUBLIC_KEY"
chmod 600 "$SSH_PRIVATE_KEY"

ADMIN_CIDR="<your-admin-ip-or-vpn-cidr>/32"
```

Если приватный ключ защищен ключевой фразой (`passphrase`), загрузите его в `ssh-agent` до запуска автоматизации или выберите отдельный ключ для миграции. Для CI и песочницы не полагайтесь только на автоопределение публичного IP через внешние HTTP-сервисы: исходный адрес SSH может отличаться от адреса, который видит такой сервис. В этом случае задайте `ADMIN_CIDR` явно, например, CIDR вашего VPN или бастионного хоста.

Создайте группу безопасности и настройте минимальные входящие правила:

```bash
yc vpc security-group create \
  --name mqtt-broker-sg \
  --network-name default

yc vpc security-group update-rules mqtt-broker-sg \
  --add-rule "direction=ingress,protocol=tcp,port=8883,v4-cidrs=0.0.0.0/0" \
  --add-rule "direction=ingress,protocol=tcp,port=22,v4-cidrs=${ADMIN_CIDR}"
```

В некоторых версиях Yandex Cloud CLI нет команды `yc vpc security-group rule add`. Используйте `yc vpc security-group update-rules --add-rule ...` или проверьте актуальный синтаксис через `yc vpc security-group update-rules --help`.

Пример создания ВМ с помощью CLI:

```bash
yc compute instance create \
  --name mqtt-broker \
  --zone ru-central1-a \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4,security-group-names=mqtt-broker-sg \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts,size=15,type=network-hdd \
  --memory 2 \
  --cores 2 \
  --core-fraction 20 \
  --metadata-from-file user-data=cloud-init.yaml \
  --metadata ssh-keys="ubuntu:$(cat "$SSH_PUBLIC_KEY")"
```

Установите Docker и Docker Compose на ВМ.

{% note warning "Важно" %}

При создании ВМ учитывайте особенности Yandex Cloud:

* SSH-ключ передавайте через `--metadata ssh-keys=...`, а не через `--ssh-key`. Флаг `--ssh-key` несовместим с `--metadata-from-file user-data`: Yandex Cloud CLI помещает SSH-ключ в `user-data`, перезаписывая ваш cloud-init. Если нужно одновременно передать и cloud-init, и SSH-ключ, используйте `--metadata ssh-keys=...` и `--metadata-from-file user-data=...` (это два разных ключа метаданных).
* Не используйте секцию `users:` в cloud-init. Yandex Cloud использует EC2-совместимый datasource, и при наличии блока `users:` cloud-init не добавит ваш SSH-ключ в `~/.ssh/authorized_keys` — добавление ключа выполняет именно метадата-сервис, а не модуль `users`. Готовый пользователь `ubuntu` (или соответствующий образу) уже создан в публичных образах Yandex Cloud. SSH-ключ для него подкладывается через `ssh-keys` в метаданных.
* В `write_files` не используйте heredoc внутри `content: |`. YAML-парсер будет падать с ошибкой `while scanning a simple key`, потому что содержимое heredoc обычно начинается с нулевого отступа и ломает блок `|`. Безопаснее:
    * выносить каждый статический файл (`mosquitto.conf`, `acl`) в отдельный `write_files`-элемент с буквальным `content: |`;
    * в `runcmd` копировать файлы через `cp` или собирать через `printf '%s\n' ...`, а не через `bash -c 'cat <<EOF ... EOF'`.
* Проверяйте выбранную пару SSH-ключей до создания ВМ: `ssh-keygen -y -f "$SSH_PRIVATE_KEY"` должен выдавать тот же публичный ключ, который вы передаете в метаданные. Если приватный ключ требует интерактивную ключевую фразу (`passphrase`), автоматический SSH не подключится без `ssh-agent`.
* Перед первым SSH-подключением выставьте права `600` на приватный ключ: `chmod 600 "$SSH_PRIVATE_KEY"`. С правами `644` SSH-клиент отвергнет ключ как «слишком открытый».

{% endnote %}

### Подготовьте каталог Mosquitto {#prepare-catalog}

Выполните команды:

```bash
mkdir -p mosquitto/config/certs mosquitto/data mosquitto/log
cd mosquitto
```

{% note warning %}

Контейнер `eclipse-mosquitto` работает от имени пользователя `mosquitto` (UID `1883`). Чтобы брокер мог сохранять persistence-базу и retained-сообщения (в том числе аналоги постоянных топиков `state` и `config`), каталог `data` должен быть доступен этому пользователю на запись:

```bash
sudo chown -R 1883:1883 data log
```

Если каталог `data` недоступен на запись, Mosquitto не сохранит retained-сообщения, и после перезапуска контейнера последнее состояние устройств будет потеряно.

{% endnote %}

Создайте файл `docker-compose.yaml`:

```yaml
services:
  mosquitto:
    image: eclipse-mosquitto:2
    container_name: mosquitto
    restart: unless-stopped
    ports:
      - "8883:8883"
    volumes:
      - ./config:/mosquitto/config:ro
      - ./data:/mosquitto/data
      - ./log:/mosquitto/log
```

### Подготовьте TLS-сертификат сервера {#prepare-tls-certificate}

Для продакшен-окружения используйте сертификат для домена, по которому устройства будут подключаться к брокеру, например:

```text
mqtt.example.com
```

Если устройства умеют проверять публичные корневые сертификаты, можно использовать публичный TLS-сертификат.

Если устройства используют собственный корневой сертификат, положите сертификат сервера и ключ в каталог:

```text
mosquitto/config/certs/server.crt
mosquitto/config/certs/server.key
```

Если вы используете аутентификацию устройств по клиентским сертификатам, также положите корневой сертификат, которым подписаны клиентские сертификаты:

```text
mosquitto/config/certs/device-ca.crt
```

### Вариант 1. Настройте логин и пароль {#login-password}

Создайте файл `config/mosquitto.conf`:

```text
persistence true
persistence_location /mosquitto/data/
autosave_interval 60

log_dest stdout

listener 8883 0.0.0.0
protocol mqtt

certfile /mosquitto/config/certs/server.crt
keyfile /mosquitto/config/certs/server.key

allow_anonymous false
password_file /mosquitto/config/passwords
acl_file /mosquitto/config/acl
```

Создайте файл паролей. Для первого пользователя используйте флаг `-c` и не создавайте файл заранее: `mosquitto_passwd -c` должен сам создать новый `password_file`.

```bash
docker run --rm -it \
  -v "$PWD/config:/mosquitto/config" \
  eclipse-mosquitto:2 \
  mosquitto_passwd -c /mosquitto/config/passwords <device_id>
```

Для неинтерактивной подготовки используйте `-b`, но не сохраняйте открытые пароли в shell history:

```bash
docker run --rm \
  -v "$PWD/config:/mosquitto/config" \
  eclipse-mosquitto:2 \
  mosquitto_passwd -b -c /mosquitto/config/passwords <device_id> '<device_password>'
```

{% note warning %}

Формат hash в `password_file` зависит от версии `mosquitto_passwd`. Генерируйте файл паролей той же версией Mosquitto, которую будет использовать целевой брокер, или проверяйте совместимость заранее.

Например, локальный `mosquitto_passwd` из более новой установки может создать hash в формате, который Ubuntu-пакет Mosquitto 2.0.18 не сможет прочитать, и брокер будет отклонять всех пользователей с ошибкой `Unable to decode password salt`. Для Docker-варианта используйте `mosquitto_passwd` из того же образа `eclipse-mosquitto`, который запускает брокер. Для apt-варианта Ubuntu подготовьте `password_file` через `mosquitto_passwd` из такого же пакета Mosquitto, как на целевой ВМ.

{% endnote %}

Для следующих пользователей запускайте команду без `-c`, чтобы не перезаписать файл:

```bash
docker run --rm -it \
  -v "$PWD/config:/mosquitto/config" \
  eclipse-mosquitto:2 \
  mosquitto_passwd /mosquitto/config/passwords <another_device_id>
```

Добавьте отдельного пользователя для бэкенд-приложений:

```bash
docker run --rm -it \
  -v "$PWD/config:/mosquitto/config" \
  eclipse-mosquitto:2 \
  mosquitto_passwd /mosquitto/config/passwords Backend
```

### Вариант 2. Настройте клиентские сертификаты {#user-certificate}

Если устройства уже используют X.509-сертификаты и вы хотите сохранить этот подход, настройте mTLS.

Создайте файл `config/mosquitto.conf`:

```text
persistence true
persistence_location /mosquitto/data/
autosave_interval 60

log_dest stdout

listener 8883 0.0.0.0
protocol mqtt

certfile /mosquitto/config/certs/server.crt
keyfile /mosquitto/config/certs/server.key
cafile /mosquitto/config/certs/device-ca.crt

require_certificate true
use_identity_as_username true

allow_anonymous false
acl_file /mosquitto/config/acl
```

При такой настройке Mosquitto будет использовать Common Name из клиентского сертификата как имя пользователя. Убедитесь, что Common Name соответствует идентификатору устройства или другому стабильному идентификатору, который вы используете в ACL.

{% note warning %}

При `require_certificate true` клиентский сертификат должны предъявлять все клиенты, включая бэкенд-подписчика. Учитывайте:

* Для бэкенд-подписчика необходимо выпустить клиентский сертификат, подписанный тем же корневым сертификатом (`device-ca.crt`), и подключаться с ним.
* Так как включен `use_identity_as_username true`, именем бэкенд-пользователя станет Common Name его сертификата. Правила `user Backend` в ACL ниже подразумевают, что Common Name бэкенд-сертификата равен `Backend`.
* Варианта с логином и паролем при этой конфигурации нет: блок `password_file` отсутствует. Примеры с `-u ... -P ...` в разделах ниже относятся к Варианту 1. Для mTLS вместо `-u/-P` передавайте `--cert client.crt --key client.key`.

{% endnote %}

{% note warning %}

Сертификаты, которые были зарегистрированы в Yandex IoT Core, нельзя перенести в Mosquitto как объект реестра. В пользовательском брокере вы настраиваете доверенный корневой сертификат и правила проверки сертификатов самостоятельно. Если у устройств самоподписанные сертификаты без общего корневого сертификата, может потребоваться перевыпустить сертификаты или использовать другую схему аутентификации.

{% endnote %}

### Настройте ACL {#acl}

Создайте файл `config/acl`.

Пример ACL, если имя пользователя совпадает с идентификатором устройства:

```text
pattern write $devices/%u/events/#
pattern write $devices/%u/state/#
pattern read $devices/%u/commands/#
pattern read $devices/%u/config/#

pattern write devices/%u/events/#
pattern write devices/%u/state/#
pattern read devices/%u/commands/#
pattern read devices/%u/config/#

user Backend
topic read $devices/+/events/#
topic read $devices/+/state/#
topic write $devices/+/commands/#
topic write $devices/+/config/#

topic read devices/+/events/#
topic read devices/+/state/#
topic write devices/+/commands/#
topic write devices/+/config/#
```

В этом примере:

* устройство может публиковать только свои события и состояние;
* устройство может читать только свои команды и конфигурацию;
* бэкенд-пользователь может читать телеметрию и публиковать команды.

Если вы использовали топики реестров, добавьте правила для `registries/...` или сгенерируйте индивидуальные правила доступа для каждого устройства.

{% note tip %}

Не выдавайте устройствам доступ к `#` или к топикам других устройств. Это снижает риск утечки телеметрии и несанкционированной отправки команд.

{% endnote %}

### Запустите Mosquitto {#launch}

Выполните команды:

```bash
docker compose up -d
docker compose logs -f mosquitto
```

Проверьте, что брокер слушает порт `8883`:

```bash
docker compose ps
```

### Альтернатива: установка Mosquitto через apt-пакет {#apt}

Если в вашей инфраструктуре не используется Docker, Mosquitto можно установить как системный пакет Ubuntu. Этот путь проще для cloud-init, но требует осторожности с конфигурацией.

```bash
sudo apt-get update
sudo apt-get install -y mosquitto mosquitto-clients
```

Дополнительные настройки кладите в `/etc/mosquitto/conf.d/<name>.conf`, а не в основной `/etc/mosquitto/mosquitto.conf`.

{% note warning %}

`/etc/mosquitto/mosquitto.conf` в пакете Ubuntu по умолчанию уже содержит строки:

```text
persistence true
persistence_location /var/lib/mosquitto/
```

Начиная с Mosquitto 2.x, повторное указание одной и той же опции в `conf.d`-файлах считается ошибкой конфигурации, и брокер не стартует с сообщением вида:

```text
Error: Duplicate persistence_location value in configuration.
```

В файлах внутри `conf.d/` указывайте только те опции, которых нет в `mosquitto.conf` по умолчанию. Если вам нужно поменять `persistence_location`, отредактируйте основной файл, не добавляйте опцию повторно. Для удобства проверки используйте:

```bash
sudo grep -RhE '^(persistence|persistence_location|password_file|acl_file|listener)' \
  /etc/mosquitto/mosquitto.conf /etc/mosquitto/conf.d/
```

Каждая опция должна встречаться ровно один раз.

{% endnote %}

Если вы разворачиваете Mosquitto через cloud-init, учитывайте порядок выполнения модулей: `write_files` отрабатывает до `packages`, поэтому группы `mosquitto` еще может не быть. Записывайте файлы как `root:root`, а владельца меняйте в `runcmd` после установки пакета.

ACL с топиками `$devices/...` и `$registries/...` безопаснее передавать в cloud-init в Base64: так символ `$` не будет интерпретирован shell-обвязкой при подготовке метаданных.

Файл `/etc/mosquitto/passwd`, который вы передаете в cloud-init, должен быть сгенерирован совместимой версией `mosquitto_passwd`. Если целевая ВМ использует Ubuntu-пакет Mosquitto 2.0.18, не подставляйте файл, созданный произвольной более новой локальной версией `mosquitto_passwd`: брокер может не прочитать хеш и будет отклонять пользователей.

Пример фрагмента cloud-init для apt-пакета:

```yaml
#cloud-config
packages:
  - mosquitto
  - mosquitto-clients

write_files:
  - path: /etc/mosquitto/conf.d/iot-migration.conf
    owner: root:root
    permissions: "0644"
    content: |
      listener 8883 0.0.0.0
      protocol mqtt
      certfile /etc/mosquitto/certs/server.crt
      keyfile /etc/mosquitto/certs/server.key
      allow_anonymous false
      password_file /etc/mosquitto/passwd
      acl_file /etc/mosquitto/acl
  - path: /etc/mosquitto/acl
    owner: root:root
    permissions: "0640"
    encoding: b64
    content: <base64-encoded-acl>
  - path: /etc/mosquitto/passwd
    owner: root:root
    permissions: "0640"
    encoding: b64
    content: <base64-encoded-password-file>

runcmd:
  - mkdir -p /etc/mosquitto/certs
  - chown mosquitto:mosquitto /etc/mosquitto/acl /etc/mosquitto/passwd
  - chmod 0640 /etc/mosquitto/acl /etc/mosquitto/passwd
  - systemctl reset-failed mosquitto
  - systemctl restart mosquitto
  - systemctl is-active mosquitto
```

Пакет Mosquitto может попытаться запустить сервис сразу после установки, еще до выполнения `runcmd`, когда сертификаты и права на файлы доступа не подготовлены. Из-за нескольких неудачных стартов systemd может перевести сервис в состояние `Start request repeated too quickly`. Команда `systemctl reset-failed mosquitto` перед финальным `restart` сбрасывает этот start-limit.

Не добавляйте в этот `conf.d`-файл `persistence` и `persistence_location`: они уже есть в `/etc/mosquitto/mosquitto.conf` пакета Ubuntu по умолчанию.

После правки конфигурации выполните команды:

```bash
sudo systemctl restart mosquitto
sudo systemctl status mosquitto
sudo ss -tlnp | grep 8883
```

Для Ubuntu-пакета Mosquitto 2.0.18 не используйте `mosquitto -t` как проверку конфигурации: эта версия воспринимает `-t` как неизвестную опцию. Если сервис не стартует, посмотрите диагностику:

```bash
sudo journalctl -u mosquitto -n 100 --no-pager
sudo grep -RhE '^(persistence|persistence_location|password_file|acl_file|listener)' \
  /etc/mosquitto/mosquitto.conf /etc/mosquitto/conf.d/
```

При работе через apt не забудьте дать пользователю `mosquitto` права на каталоги с данными и логами (`chown -R mosquitto:mosquitto /var/lib/mosquitto /var/log/mosquitto`) и в группе безопасности открыть только `8883/TCP`.

## Проверьте подключение {#check-connection}

На рабочей или тестовой ВМ установите клиентские утилиты Mosquitto.

{% note info %}

Команды ниже используют аутентификацию по логину и паролю (Вариант 1). Если вы настроили клиентские сертификаты (Вариант 2), вместо `-u <user> -P <password>` передавайте `--cert client.crt --key client.key`, а имя пользователя будет взято из Common Name сертификата.

{% endnote %}

{% note info %}

Если для smoke-теста вы используете самоподписанный сертификат, выпущенный не на DNS-имя из `-h`, проверка имени хоста завершится ошибкой. Для продакшен-окружения выпустите сертификат на фактическое MQTT DNS-имя. Для краткого smoke-теста по публичному IP можно временно добавить к командам `--insecure`, но не используйте это как штатную настройку устройств.

{% endnote %}

Подпишитесь на топик от имени бэкенд-пользователя:

```bash
mosquitto_sub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -u Backend \
  -P '<Backend_password>' \
  -t '$devices/+/events/#' \
  -q 1
```

Опубликуйте тестовое сообщение от имени устройства:

```bash
mosquitto_pub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -u <device_id> \
  -P '<device_password>' \
  -t '$devices/<device_id>/events' \
  -m '{"temperature":25}' \
  -q 1
```

Проверьте retained-сообщение для аналога постоянного топика `state`:

```bash
mosquitto_pub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -u <device_id> \
  -P '<device_password>' \
  -t '$devices/<device_id>/state' \
  -m '{"online":true}' \
  -q 1 \
  -r
```

Подпишитесь на этот топик новым клиентом. Он должен сразу получить последнее retained-сообщение:

```bash
mosquitto_sub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -u Backend \
  -P '<Backend_password>' \
  -t '$devices/<device_id>/state' \
  -q 1
```

### Проверьте изоляцию устройств через ACL {#device-isolation}

ACL — самая частая точка, в которой ошибки обнаруживаются уже после миграции. Обязательно проверьте, что одно устройство не может читать или писать в топики другого.

Сценарий 1. Чужие команды не доходят. Сначала от имени устройства `<device_a>` подпишитесь на топик чужого устройства `<device_b>`:

```bash
mosquitto_sub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -u <device_a> \
  -P '<device_a_password>' \
  -t '$devices/<device_b>/commands' \
  -q 1 \
  -W 5
```

Параметр `-W 5` ограничивает время работы 5 секундами. Пока подписчик работает, опубликуйте сообщение в `$devices/<device_b>/commands` от бэкенда и убедитесь, что подписчик ничего не получает. В логах брокера для устройства `<device_a>` должна быть запись об отказе ACL.

Сценарий 2. Чужие события не публикуются. От имени устройства `<device_a>` попробуйте опубликовать в чужой топик:

```bash
mosquitto_pub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -u <device_a> \
  -P '<device_a_password>' \
  -t '$devices/<device_b>/events' \
  -m '{"spoofed":true}' \
  -q 1
```

Команда может выполниться без видимой ошибки на клиенте, но сообщение не должно дойти до бэкенд-подписки на `$devices/<device_b>/events/#`. Проверяйте именно отсутствие сообщения у бэкенд-подписчика и отказ ACL в логах брокера, а не только код ответа `mosquitto_pub`.

Сценарий 3. Анонимное подключение запрещено. Подключитесь без учетных данных:

```bash
mosquitto_sub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -t '$devices/<device_a>/events' \
  -W 5
```

Клиент должен получить ошибку `Connection Refused: not authorised`.

{% note tip %}

Эти три проверки полезно автоматизировать (например, в shell-скрипте) и прогонять как smoke-тест после каждого изменения ACL или паролей. Если хотя бы один сценарий нарушается, на брокере возможна утечка телеметрии или подмена команд устройствами.

{% endnote %}

## Замените триггеры {#replace-triggers}

В Yandex IoT Core можно было настроить триггер, который вызывал функцию Cloud Functions или контейнер Serverless Containers при получении MQTT-сообщения. В пользовательском MQTT-брокере такую интеграцию нужно реализовать отдельным сервисом-подписчиком.

Ниже пример простого подписчика на Python. Он получает MQTT-сообщение и отправляет его в HTTP-обработчик.

Создайте файл `subscriber.py`:

```python
import base64
import json
import os
import queue
import threading
import time
from urllib import request

import paho.mqtt.client as mqtt


MQTT_HOST = os.environ["MQTT_HOST"]
MQTT_PORT = int(os.getenv("MQTT_PORT", "8883"))
MQTT_USERNAME = os.environ["MQTT_USERNAME"]
MQTT_PASSWORD = os.environ["MQTT_PASSWORD"]
MQTT_TOPIC = os.getenv("MQTT_TOPIC", "$devices/+/events/#")
MQTT_CLIENT_ID = os.getenv("MQTT_CLIENT_ID", "iot-core-migration-subscriber")
MQTT_CA_FILE = os.getenv("MQTT_CA_FILE", "rootCA.crt")
WORKER_COUNT = int(os.getenv("WORKER_COUNT", "4"))

HANDLER_URL = os.environ["HANDLER_URL"]

# Очередь и пул воркеров развязывают прием сообщений из MQTT и их обработку.
# Если обрабатывать HTTP-запрос прямо в on_message, медленный обработчик
# заблокирует сетевой цикл MQTT, и клиент отключится по keepalive.
message_queue: queue.Queue = queue.Queue(maxsize=10000)


def build_event(msg: mqtt.MQTTMessage) -> dict:
    payload_base64 = base64.b64encode(msg.payload).decode("ascii")
    topic_parts = msg.topic.split("/")

    event = {
        "mqtt_topic": msg.topic,
        "payload": payload_base64,
        "is_base64": True,
        "qos": msg.qos,
        "retain": msg.retain,
    }

    if len(topic_parts) >= 2 and topic_parts[0] in ("$devices", "devices"):
        event["device_id"] = topic_parts[1]

    if len(topic_parts) >= 2 and topic_parts[0] in ("$registries", "registries"):
        event["registry_id"] = topic_parts[1]

    return event


def send_to_handler(event: dict) -> None:
    body = json.dumps(event).encode("utf-8")
    http_request = request.Request(
        HANDLER_URL,
        data=body,
        headers={"Content-Type": "application/json"},
        method="POST",
    )

    with request.urlopen(http_request, timeout=10) as response:
        response.read()


def on_connect(client, userdata, flags, rc):
    if rc != 0:
        print(f"MQTT connection failed with rc={rc}")
        return

    print(f"Connected to MQTT broker. Subscribing to {MQTT_TOPIC}")
    client.subscribe(MQTT_TOPIC, qos=1)


def worker() -> None:
    while True:
        event = message_queue.get()
        try:
            for attempt in range(3):
                try:
                    send_to_handler(event)
                    break
                except Exception as error:
                    print(f"Handler call failed, attempt={attempt + 1}, error={error}")
                    time.sleep(2 ** attempt)
            else:
                print(f"Message was not processed: topic={event.get('mqtt_topic')}")
        finally:
            message_queue.task_done()


def on_message(client, userdata, msg):
    # Кладем событие в очередь и сразу возвращаем управление сетевому циклу:
    # put() приостанавливает прием, только когда все воркеры заняты.
    message_queue.put(build_event(msg))


for _ in range(WORKER_COUNT):
    threading.Thread(target=worker, daemon=True).start()

client = mqtt.Client(client_id=MQTT_CLIENT_ID)
client.username_pw_set(MQTT_USERNAME, MQTT_PASSWORD)
client.tls_set(ca_certs=MQTT_CA_FILE)

client.on_connect = on_connect
client.on_message = on_message

client.connect(MQTT_HOST, MQTT_PORT, keepalive=60)
client.loop_forever()
```

Создайте файл `requirements.txt`:

```text
paho-mqtt==1.6.1
```

Запустите подписчика:

```bash
export MQTT_HOST=mqtt.example.com
export MQTT_PORT=8883
export MQTT_USERNAME=Backend
export MQTT_PASSWORD='<Backend_password>'
export MQTT_TOPIC='$devices/+/events/#'
export MQTT_CA_FILE=./rootCA.crt
export HANDLER_URL='https://<your-handler-url>'

python3 -m pip install -r requirements.txt
python3 subscriber.py
```

Такого подписчика можно запустить:

* на виртуальной машине Compute Cloud;
* в кластере Managed Service for Kubernetes;
* в контейнере Serverless Containers, если приложение постоянно поддерживает MQTT-соединение;
* рядом с другими бэкенд-сервисами, которые обрабатывают телеметрию.

{% note tip %}

Для продакшен-сценария добавьте идемпотентность обработки, метрики, алерты, DLQ или отдельное хранилище необработанных сообщений. MQTT QoS 1 гарантирует доставку до подписчика, но не гарантирует успешную обработку вашим HTTP-обработчиком. Очередь в примере хранится в памяти процесса: при аварийном завершении необработанные сообщения теряются.

Чтобы увеличить пропускную способность, поднимите число воркеров (переменная `WORKER_COUNT`) или запустите несколько экземпляров подписчика с разделяемой подпиской MQTT (shared subscription) — брокер распределит сообщения между ними.

Подписчик по умолчанию читает только топик `events`. Чтобы получать постоянные сообщения `state`, подпишитесь дополнительно на `$devices/+/state/#`.

{% endnote %}

## Замените экспорт в Yandex Data Streams {#replace-yds}

Если вы использовали экспорт сообщений из Yandex IoT Core в потоки данных Yandex Data Streams, используйте один из вариантов:

* MQTT-подписчик читает сообщения из Mosquitto и отправляет их в поток данных Yandex Data Streams;
* Бэкенд-приложение одновременно публикует данные в MQTT и в поток данных Yandex Data Streams;
* Потоковая обработка выполняется в отдельном сервисе, который подписан на MQTT-топики.

Общий принцип:

```text
Mosquitto → MQTT subscriber → Yandex Data Streams
```

При реализации учитывайте:

* размер сообщения;
* порядок сообщений;
* повторную отправку при ошибках;
* идемпотентность записи;
* мониторинг задержек и ошибок записи.

## Перенесите устройства {#replace-device}

После подготовки брокера и бэкенд-интеграций начните перенос устройств.

Рекомендуемый порядок:

1. Создайте новый DNS-адрес MQTT-брокера, например `mqtt.example.com`.
1. Настройте TLS-сертификат для этого адреса.
1. Создайте тестовое устройство или тестовую группу устройств.
1. Проверьте публикацию `events` и `state`.
1. Проверьте получение `commands` и `config`.
1. Проверьте, что бэкенд получает сообщения и корректно их обрабатывает.
1. Переведите небольшую пилотную группу устройств.
1. Сравните телеметрию в старом и новом контуре.
1. Переведите остальные устройства партиями.
1. После завершения миграции отключите публикацию в Yandex IoT Core.

Если прошивка устройств поддерживает одновременную публикацию в два MQTT-брокера, используйте период двойной отправки. Это поможет сравнить данные и снизить риск потери телеметрии.

{% note warning %}

Не откладывайте перенос до даты остановки Yandex IoT Core. После перевода сервиса в режим read-only вы не сможете изменять часть ресурсов, а после полной остановки устройства перестанут обмениваться сообщениями через сервис.

{% endnote %}

### Удалите тестовые ресурсы {#delete}

Если вы создавали тестовую ВМ или группу безопасности для smoke-теста, удаляйте их только после того, как убедились, что продакшен-трафик уже переключен на постоянный эндпоинт.

```bash
yc compute instance delete mqtt-broker
yc vpc security-group delete mqtt-broker-sg
```

Не добавляйте к этим командам флаг `--quiet` без проверки установленной версии Yandex Cloud CLI: в некоторых версиях он не поддерживается для `yc compute instance delete`. Если нужна неинтерактивная очистка, сначала проверьте актуальный синтаксис:

```bash
yc compute instance delete --help
```

## Развертывание Mosquitto в Yandex Managed Service for Kubernetes {#k8s}

Mosquitto можно запустить в кластере Managed Service for Kubernetes. Для продакшен-окружения используйте:

* `StatefulSet`;
* `PersistentVolumeClaim` для каталога `/mosquitto/data`;
* `Secret` для TLS-ключей и паролей;
* `ConfigMap` для `mosquitto.conf` и ACL;
* `Service` типа `LoadBalancer` для TCP-порта `8883`;
* `PodDisruptionBudget`;
* регулярные резервные копии persistent volume.

Пример `Service`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mosquitto
spec:
  type: LoadBalancer
  selector:
    app: mosquitto
  ports:
    - name: mqtts
      port: 8883
      targetPort: 8883
      protocol: TCP
```

{% note warning %}

Обычный Mosquitto не является кластерным MQTT-брокером. Не запускайте несколько независимых подов Mosquitto за одним балансировщиком как active/active-кластер, если вам нужны общие retained-сообщения, единые сессии и предсказуемая доставка. Для таких сценариев рассмотрите TBMQ Community Edition или другую кластерную архитектуру.

{% endnote %}

## Когда выбрать TBMQ Community Edition {#tbmq}

TBMQ Community Edition — MQTT-брокер с открытым исходным кодом, ориентированный на высокую нагрузку и кластерную архитектуру.

Рассмотрите TBMQ, если:

* один Mosquitto-брокер становится узким местом;
* нужна горизонтальная масштабируемость;
* важна долговременная доставка сообщений;
* нужна отказоустойчивость на уровне брокерского кластера;
* вы готовы сопровождать Apache Kafka®, базу данных и другие компоненты.

Типовая архитектура:

```text
Устройства → TBMQ → Kafka → бэкенд / обработчики / хранилища
```

TBMQ сложнее Mosquitto в эксплуатации, но лучше подходит для сценариев, где MQTT-брокер является критичным высоконагруженным компонентом.

Базу данных для TBMQ или ThingsBoard можно вынести в сервис Yandex Managed Service for PostgreSQL, чтобы не администрировать СУБД самостоятельно, либо развернуть ее в кластере вместе с остальными компонентами.

## Когда выбрать ThingsBoard Community Edition {#thingsBoard}

ThingsBoard Community Edition — IoT-платформа с открытым исходным кодом. Она включает MQTT API, управление устройствами, хранение телеметрии, дашборды и механизм rule engine.

Рассмотрите ThingsBoard CE, если:

* вам нужна не только передача MQTT-сообщений, но и IoT-платформа;
* пользователям нужен пользовательский интерфейс для устройств и телеметрии;
* нужны дашборды и механизм rule engine;
* вы хотите управлять данными учетных записей устройств в платформе;
* вы готовы адаптировать топики, payload и бэкенд-интеграции под ThingsBoard.

ThingsBoard CE не является drop-in-заменой Yandex IoT Core. Устройства и бэкенд-приложения обычно нужно адаптировать под API и модель данных ThingsBoard.

Типовая архитектура:

```text
Устройства → ThingsBoard CE → Rule Engine → дашборд / бэкенд / хранилища
```

Также возможна архитектура, где Mosquitto остается MQTT-брокером, а ThingsBoard получает данные через интеграцию или API-шлюз:

```text
Устройства → Mosquitto → ThingsBoard CE → дашборд / Rule Engine
```

## Что не переносится автоматически {#limitations}

При миграции на опенсорс-решение не переносятся автоматически:

* реестры и устройства как управляемые ресурсы Yandex Cloud;
* алиасы топиков;
* пароли устройств и реестров;
* интеграции с IAM;
* публикация сообщений через gRPC-интерфейс Yandex IoT Core;
* триггеры;
* экспорт в Yandex Data Streams;
* мониторинговые топики Yandex IoT Core;
* поведение постоянных топиков без настройки retained-сообщений;
* роли и права доступа на уровне Yandex Cloud.

Для каждого пункта нужно выбрать замену:

* реестры и устройства — собственная база данных, конфигурация брокера или IoT-платформа.
* пароли — новый `password_file`, Dynamic Security plugin Mosquitto или данные учетных записей в IoT-платформе.
* сертификаты — собственный корневой сертификат и mTLS.
* алиасы — явные MQTT-топики или слой совместимости в бэкенде.
* публикация через gRPC-интерфейс — прямой совместимой замены нет, потому что в Yandex IoT Core использовалась IAM-авторизация. Если такой сценарий нужен, реализуйте отдельный бэкенд-адаптер с нужной схемой авторизации, который будет принимать gRPC/API-запросы от ваших систем и публиковать сообщения в Mosquitto;
* триггеры — MQTT-подписчик.
* экспорт — MQTT-подписчик, который пишет в потоки данных Yandex Data Streams или другое хранилище.
* мониторинг — метрики брокера, логи, проверки работоспособности и пользовательские heartbeat-топики.

## Рекомендации по эксплуатации {#recommendations}

### Безопасность {#security}

* Используйте MQTTS на порту `8883`.
* Отключите анонимный доступ.
* Ограничивайте устройства через ACL.
* Не используйте один общий пароль для всех устройств.
* Храните пароли, приватные ключи и корневой сертификат в защищенном хранилище.
* Регулярно ротируйте учетные данные.
* Ограничьте входящий трафик группами безопасности.
* Не открывайте административные интерфейсы в интернет.

### Надежность {#reliability}

* Храните персистентные данные брокера на постоянном диске.
* Настройте резервное копирование диска или каталога данных.
* Документируйте процедуру восстановления.
* Проверяйте восстановление на тестовом стенде.
* Используйте QoS 1 для важных сообщений.
* Убедитесь, что для retained-сообщений включено сохранение.
* Для критичных сценариев рассмотрите active/passive-схему или кластерный брокер.

### Наблюдаемость {#observability}

* Собирайте логи Mosquitto в Yandex Cloud Logging.
* Настройте алерты на недоступность порта `8883`.
* Мониторьте CPU, RAM, диск и сетевой трафик ВМ или поды.
* Отслеживайте количество подключенных клиентов.
* Отслеживайте ошибки аутентификации.
* Добавьте метрики в бэкенд-подписчика: количество сообщений, ошибки обработки, задержку доставки.

### Производительность {#efficiency}

* Проведите нагрузочное тестирование до переноса всех устройств.
* Проверьте лимиты CPU, RAM и сетевой пропускной способности.
* Разделяйте топики так, чтобы бэкенд-подписчики не получали лишние сообщения.
* Не используйте слишком широкие wildcard-подписки без необходимости.
* Для больших инсталляций планируйте шардинг или переход на кластерный брокер.

## План миграции {#migration-plan}

Используйте этот чек-лист для контроля миграции:

* Выбрано целевое решение: Eclipse Mosquitto, TBMQ CE или ThingsBoard CE.
* Выгружен список реестров, устройств, сертификатов и алиасов.
* Сгенерированы новые пароли устройств и подготовлен план их доставки в прошивку.
* Создан новый эндпоинт MQTT.
* Настроен TLS.
* Настроена аутентификация устройств.
* Настроены ACL для обоих префиксов: `$devices/...` и `devices/...` (если поэтапно мигрируете часть устройств).
* Проверена публикация `events`.
* Проверена публикация `state` с retained-сообщениями.
* Проверено получение `commands`.
* Проверено получение `config`.
* Прогнан smoke-тест ACL-изоляции (устройство не читает и не пишет чужие топики, анонимное подключение отклоняется).
* Конфигурация Mosquitto проверена на отсутствие дубликатов опций (`persistence`, `persistence_location`, `listener` и т. п. встречаются ровно один раз во всех файлах конфигурации).
* Реализована замена триггеров.
* Реализована замена экспорта в Yandex Data Streams, если он использовался.
* Настроены логи, метрики и алерты.
* Настроены резервные копии.
* Проведен пилотный перенос небольшой группы устройств.
* Проведено сравнение данных в старом и новом контуре.
* Перенесены все устройства.
* Отключена зависимость продакшен-систем от Yandex IoT Core.

## Полезные ссылки {#see-also}

* [Документация Eclipse Mosquitto](https://mosquitto.org/documentation/)
* [Документация TBMQ](https://thingsboard.io/docs/mqtt-broker/)
* [Документация ThingsBoard](https://thingsboard.io/docs/)
* [Документация Yandex Compute Cloud](../../compute/index.md)
* [Документация Yandex Managed Service for Kubernetes](../../managed-kubernetes/index.md)
* [Документация Yandex Object Storage](../../storage/index.md)
* [Документация Yandex Lockbox](../../lockbox/index.md)
* [Документация Yandex Monitoring](../../monitoring/index.md)
* [Документация Yandex Cloud Logging](../../logging/index.md)