Приложение [{{ unified-agent-full-name }}](../../monitoring/concepts/data-collection/unified-agent/) позволяет принимать и передавать логи пользовательских приложений в сервис [{{ cloud-logging-full-name }}](../../logging/).

В этом руководстве вы настроите передачу логов из тестового Python-приложения. Приложение будет передавать логи в {{ unified-agent-short-name }} на [вход http](../../monitoring/concepts/data-collection/unified-agent/inputs#http_input). Полученные логи {{ unified-agent-short-name }} будет отправлять через выход [yc_logs](../../monitoring/concepts/data-collection/unified-agent/outputs#yc_logs_output) в {{ cloud-logging-name }} в лог-группу по умолчанию — `default`.

Чтобы настроить передачу логов:

1. [Подготовьте облако к работе](#before-begin).
1. [Установите и настройте {{ unified-agent-full-name }}](#configure-ua).
1. [Создайте и запустите приложение, генерирующее логи](#generate-logs).
1. [Посмотрите логи](#read-logs).

Если созданные ресурсы больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

1. Плата за постоянно работающие ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));

1. Плата за запись и хранение логов в лог-группе (см. [тарифы {{ cloud-logging-full-name }}](../../logging/pricing.md)).


## Подготовьте инфраструктуру {#infrastructure-prepare}

### Создайте сервисный аккаунт {#sa-create}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт `sa-logger` в каталоге, куда будут записываться логи.
1. [Назначьте](../../iam/operations/roles/grant.md) сервисному аккаунту [роль](../../logging/security/#logging-writer) `logging.writer`.

### Создайте ВМ {#vm-create}

1. [Создайте ВМ](../../compute/operations/vm-create/create-linux-vm.md) из публичного образа [Ubuntu 24.04](/marketplace/products/yc/ubuntu-24-04-lts).
   
   В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** укажите сервисный аккаунт `sa-logger`.
   
1. [Подключитесь к ВМ](../../compute/operations/vm-connect/ssh.md#vm-connect) по [SSH](../../glossary/ssh-keygen.md).

## Установите и настройте {{ unified-agent-short-name }} {#configure-ua}

1. Скачайте последнюю версию deb-пакета:

      ```bash
      ubuntu_name="ubuntu-22.04-jammy" ua_version=$(curl --silent https://storage.yandexcloud.net/yc-unified-agent/latest-version) bash -c 'curl --silent --remote-name https://storage.yandexcloud.net/yc-unified-agent/releases/${ua_version}/deb/${ubuntu_name}/yandex-unified-agent_${ua_version}_amd64.deb'
      ```
1. Посмотрите версию deb-пакета с помощью команды `ls`.
   
1. Установите {{ unified-agent-short-name }} из deb-пакета, указав его версию:

   ```bash
   sudo dpkg -i yandex-unified-agent_24.09.03_amd64.deb
   ```
   
   Другие способы установки описаны в разделе [{#T}](../../monitoring/concepts/data-collection/unified-agent/installation.md). 

1. Проверьте, что {{ unified-agent-short-name }} запущен:

   ```bash
   sudo systemctl status unified-agent.service
   ```

1. Откройте конфигурационный файл {{ unified-agent-short-name }}:
   
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

1. Перезапустите {{ unified-agent-short-name }}:

   ```bash
   sudo systemctl restart unified-agent.service
   ```

1. Посмотрите статус службы {{ unified-agent-short-name }}:

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

   Где `unified_agent_url` — публичный IP-адрес виртуальной машины с {{ unified-agent-short-name }}.

   По умолчанию {{ unified-agent-short-name }} принимает данные на всех интерфейсах. Поэтому публичный IP-адрес можно указывать, 
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

    1. В [консоли  управления]({{ link-console-main }}) перейдите в каталог, который указали в настройках {{ unified-agent-full-name }}.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
    1. Выберите лог-группу по умолчанию `default`.
    1. Перейдите на вкладку **{{ ui-key.yacloud.common.logs }}**.
    1. На открывшейся странице отобразятся записи.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы посмотреть записи в лог-группе, выполните команду:
    ```
    yc logging read --folder-id=<идентификатор_каталога>
    ```

    Где `--folder-id` — идентификатор каталога, который указан в настройках {{ unified-agent-full-name }}.

- API {#api}

    Чтобы посмотреть записи в лог-группе, воспользуйтесь вызовом gRPC API [LogReadingService/Read](../../logging/api-ref/grpc/log_reading_service.md#Read).

{% endlist %}

## Удалите созданные ресурсы {#delete-resources}

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Удалите виртуальную машину](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите лог-группу](../../logging/operations/delete-group.md).