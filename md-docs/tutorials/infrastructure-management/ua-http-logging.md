[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Базовая инфраструктура](../infrastructure/index.md) > Инструменты > Передача логов через HTTP-вход Unified Agent в Cloud Logging

# Передача логов через HTTP-вход Unified Agent в Yandex Cloud Logging

Приложение [Yandex Unified Agent](../../monitoring/concepts/data-collection/unified-agent/index.md) позволяет принимать и передавать логи пользовательских приложений в сервис [Yandex Cloud Logging](../../logging/index.md).

В этом руководстве вы настроите передачу логов из тестового Python-приложения. Приложение будет передавать логи в Unified Agent на [вход http](../../monitoring/concepts/data-collection/unified-agent/inputs.md#http_input). Полученные логи Unified Agent будет отправлять через выход [yc_logs](../../monitoring/concepts/data-collection/unified-agent/outputs.md#yc_logs_output) в Cloud Logging в лог-группу по умолчанию — `default`.

Чтобы настроить передачу логов:

1. [Подготовьте облако к работе](#before-begin).
1. [Установите и настройте Yandex Unified Agent](#configure-ua).
1. [Создайте и запустите приложение, генерирующее логи](#generate-logs).
1. [Посмотрите логи](#read-logs).

Если созданные ресурсы больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

1. Плата за постоянно работающие ВМ ([тарифы Yandex Compute Cloud](../../compute/pricing.md));

1. Плата за запись и хранение логов в лог-группе ([тарифы Yandex Cloud Logging](../../logging/pricing.md)).

## Подготовьте инфраструктуру {#infrastructure-prepare}

### Создайте сервисный аккаунт {#sa-create}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `sa-logger` в каталоге, куда будут записываться логи.
1. [Назначьте](../../iam/operations/roles/grant.md) сервисному аккаунту [роль](../../logging/security/index.md#logging-writer) `logging.writer`.

### Создайте ВМ {#vm-create}

1. [Создайте ВМ](../../compute/operations/vm-create/create-linux-vm.md) из публичного образа [Ubuntu 24.04](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-24-04-lts).
   
   В блоке **Доступ** укажите сервисный аккаунт `sa-logger`.
   
1. [Подключитесь к ВМ](../../compute/operations/vm-connect/ssh.md#vm-connect) по [SSH](../../glossary/ssh-keygen.md).

## Установите и настройте Unified Agent {#configure-ua}

1. Скачайте последнюю версию deb-пакета:

      ```bash
      ubuntu_name="ubuntu-22.04-jammy" ua_version=$(curl --silent https://storage.yandexcloud.net/yc-unified-agent/latest-version) bash -c 'curl --silent --remote-name https://storage.yandexcloud.net/yc-unified-agent/releases/${ua_version}/deb/${ubuntu_name}/yandex-unified-agent_${ua_version}_amd64.deb'
      ```
1. Посмотрите версию deb-пакета с помощью команды `ls`.
   
1. Установите Unified Agent из deb-пакета, указав его версию:

   ```bash
   sudo dpkg -i yandex-unified-agent_24.09.03_amd64.deb
   ```
   
   Другие способы установки описаны в разделе [Установка и обновление Yandex Unified Agent](../../monitoring/concepts/data-collection/unified-agent/installation.md). 

1. Проверьте, что Unified Agent запущен:

   ```bash
   sudo systemctl status unified-agent.service
   ```

1. Откройте конфигурационный файл Unified Agent:
   
   ```bash
   sudo nano /etc/yandex/unified_agent/config.yml
   ```

1. Добавьте в файл конфигурацию для приема и отправки логов:

   ```yaml
   status:
     port: "16241"

   routes:
      - input:
         plugin: http
         config:
            port: 22132
        channel:
         output:
            plugin: yc_logs
            config:
               folder_id: "b1grj7grr1kn********"
               iam:
                  cloud_meta: {}
   
   import:
   - /etc/yandex/unified_agent/conf.d/*.yml
   ```

   Где `folder_id` — идентификатор каталога, в который будут записываться логи.

1. Проверьте, что файл конфигурации составлен верно (команда должна вывести содержимое файла):

   ```bash
   unified_agent check-config -c /etc/yandex/unified_agent/config.yml
   ```

1. Перезапустите Unified Agent:

   ```bash
   sudo systemctl restart unified-agent.service
   ```

1. Посмотрите статус службы Unified Agent:

   ```bash
   sudo systemctl status unified-agent.service
   ```

## Создайте и запустите приложение, генерирующее логи {#generate-logs}

1. Создайте файл `logtest.py`:

   ```py
   import time
   import requests
   import random

   # Возможные URL для запросов
   urls = [
      '/',
      '/admin',
      '/hello',
      '/docs',
      '/api/resource1',
      '/api/resource2',
      '/api/resource3'
   ]

   # Конфигурация HTTP-входа Unified Agent
   unified_agent_url = 'http://51.250.98.18:22132/write'

   # Возможные коды ответа и их вероятности
   response_codes = [200, 201, 400, 404, 500]
   response_weights = [0.7, 0.1, 0.1, 0.05, 0.05]

   # Генерация и отправка логов на HTTP-вход
   def generate_and_send_logs():
      while True:
         url = random.choice(urls)
         status_code = random.choices(response_codes, response_weights)[0]
         log_message = f"Requested {url}, received status code {status_code}"
         print(log_message)
         
         # Отправка лога на HTTP-вход Unified Agent
         send_logs_to_http(log_message)
         
         # Отправка логов каждые 5 секунд
         time.sleep(5)

   # Отправка логов на HTTP-вход
   def send_logs_to_http(log_message):
      headers = {"Content-Type": "text/plain"}
      response = requests.post(unified_agent_url, headers=headers, data=log_message)
      if response.status_code == 200:
         print("Log sent successfully")
      else:
         print(f"Failed to send log: {response.status_code}")

   if __name__ == "__main__":
      generate_and_send_logs()
   ```

   Где `unified_agent_url` — публичный IP-адрес виртуальной машины с Unified Agent.

   По умолчанию Unified Agent принимает данные на всех интерфейсах. Поэтому публичный IP-адрес можно указывать, 
   даже когда источник логов находится на той же ВМ. Если публичного адреса нет, укажите `localhost`.

1. Обновите версии установленных пакетов:

    ```bash
    sudo apt-get update
    ```

1. Установите Python:

   ```bash
   sudo apt install python3
   ```

1. Запустите приложение:
   ```bash
   python3 logtest.py
   ```

## Посмотрите логи {#read-logs}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли  управления](https://console.yandex.cloud) перейдите в каталог, который указали в настройках Yandex Unified Agent.
    1. Перейдите в сервис **Cloud Logging**.
    1. Выберите лог-группу по умолчанию `default`.
    1. Перейдите на вкладку **Логи**.
    1. На открывшейся странице отобразятся записи.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы посмотреть записи в лог-группе, выполните команду:
    ```
    yc logging read --folder-id=<идентификатор_каталога>
    ```

    Где `--folder-id` — идентификатор каталога, который указан в настройках Yandex Unified Agent.

- API {#api}

    Чтобы посмотреть записи в лог-группе, воспользуйтесь вызовом gRPC API [LogReadingService/Read](../../logging/api-ref/grpc/LogReading/read.md).

{% endlist %}

## Удалите созданные ресурсы {#delete-resources}

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите лог-группу](../../logging/operations/delete-group.md).