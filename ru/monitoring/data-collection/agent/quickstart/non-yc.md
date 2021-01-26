# Поставка метрик с хостов вне Яндекс.Облака

Для поставки в {{ monitoring-full-name }} метрик с хостов, расположенных за пределами Яндекс.Облака, используются авторизованные ключи сервисных аккаунтов для обмена [JWT](https://ru.wikipedia.org/wiki/JSON_Web_Token) на IAM-токен. Описанная методика может также применяться для отправки метрик с виртуальных машин Яндекс.Облака без привязанного сервисного аккаунта.

Чтобы настроить {{unified-agent-full-name}} для сбора метрик с использованием авторизованного ключа, выполните следующие шаги:

1. Настройте сервисный аккаунт, от имени которого будут записываться метрики в {{ monitoring-full-name }} и создайте авторизованный ключ.

   1. Создайте сервисный аккаунт с ролью `editor` в каталоге, куда будут записываться метрики. Подробнее необходимые для этого шаги описаны в разделах [{#T}](../../../../iam/operations/sa/create.md) и [{#T}](../../../../iam/operations/sa/assign-role-for-sa.md).

   1. Создайте авторизованный ключ для созданного сервисного аккаунта, например, при помощи утилиты `yc`, выполнив следующую команду, заменив строку `<SA_ID>` на идентификатор сервисного аккаунта:

       ```bash
       yc iam key create --service-account-id <SA_ID> --output jwt_params.json
       ```

       Подробнее создание авторизованных ключей описано в разделе [{#T}](../../../../iam/operations/authorized-key/create.md).

   1. Доставьте файл **jwt_params.json** с параметрами авторизованного ключа на хост, где установлен {{unified-agent-short-name}}.

       Пример файла **jwt_params.json**:
       ```json
       {
           "id": "ajt...",
           "service_account_id": "aje...",
           "created_at": "2021-01-14T13:18:51.070026Z",
           "key_algorithm": "RSA_2048",
           "public_key": "-----BEGIN PUBLIC KEY-----\nMD...",
           "private_key": "-----BEGIN PRIVATE KEY-----\nMI..."
       }
       ```

1. Установите и настройте {{unified-agent-full-name}}.

   1. Установите {{unified-agent-short-name}} в свою виртуальную машину, выполнив в домашнем каталоге следующую команду:

       {% include [ua-docker-install](../../../../_includes/monitoring/ua-docker-install.md) %}

       Другие способы установки агента описаны в разделе [{#T}](../installation.md).

   1. Создайте в домашнем каталоге файл **config.yml** со следующим содержимым, заменив строку `<FOLDER_ID>` на идентификатор каталога, куда будут записываться метрики, и указав имя файла с параметрами JWT в секции `iam.jwt.file` :

       **config.yml:**
       ```yaml
       status:
         port: 16241
       routes:
         - input:
             plugin: linux_metrics
             config:
               poll_period: 15s
               namespace: sys
           channel:
             output:
               plugin: yc_metrics
               config:
                 folder_id: <FOLDER_ID>
                 iam:
                   jwt:
                     file: "jwt_params.json"
       ```

1. Убедитесь, что метрики поступают в {{ monitoring-full-name }}.

   1. Перейдите по адресу [monitoring.cloud.yandex.ru](https://monitoring.cloud.yandex.ru), перейдите в раздел «Обзор метрик» и выберите каталог, в который собираются системные метрики, в строке запроса. Собранные системные метрики имеют в имени префикс `sys`.

## Что дальше {#next-steps}

- [Изучите концепции Unified Agent](../concepts.md)
- [Узнайте подробнее о конфигурировании Unified Agent](../configuration.md)
- [Ознакомьтесь с рекомендациями по эксплуатации Unified Agent](../best-practices.md)
