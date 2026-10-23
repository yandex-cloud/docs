[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for OpenSearch](../index.md) > [Пошаговые инструкции](index.md) > Кластеры > Восстановление из резервной копии

# Восстановление базы данных из снапшота


## Перед началом работы {before-you-begin}

Если вы копируете незашифрованный репозиторий напрямую из исходного бакета, перейдите к шагу 1 в разделе [«Восстановление базы данных»](#restore). Если бэкап уже выгружен через backup-exporter, сначала выполните шаги ниже, так как выгрузка backup-exporter шифруется через rclone crypt. OpenSearch не может читать её напрямую: сначала нужно распаковать ключи и расшифровать репозиторий.

### Чтение конфигурационного файла

В корне выгрузки кластера найдите каталог `__migration__/`. Скачайте `config-<timestamp>.json` нужного успешного запуска.

```bash
rclone lsf export-s3:export-bucket/cluster-id/__migration__/
rclone copyto export-s3:export-bucket/cluster-id/__migration__/config-<timestamp>.json ./export-config.json
jq '.opensearch | {encryption, repository, key_archive}' export-config.json
```

Здесь `export-s3` — настроенный rclone remote типа `s3` с доступом к бакету выгрузки. Если при экспорте задан дополнительный префикс, добавьте его перед `cluster-id/`.

Если `opensearch.encryption` имеет значение `rclone-crypt`, продолжайте выполнять действия по инструкции. Если метаданные отсутствуют и способ выгрузки неизвестен, уточните его у исполнителя экспорта, прежде чем подключать репозиторий.

### Получение ключей

В `opensearch.key_archive` указаны имя архива (`file`), идентификатор секрета Lockbox (`kek_secret_id`) и версия секрета (`kek_version_id`). Используйте архив из того же конфига. Не используйте произвольный архив из каталога.

```bash
umask 077
KEY_ARCHIVE=$(jq -er '.opensearch.key_archive.file' export-config.json)
REPOSITORY=$(jq -er '.opensearch.repository' export-config.json)
rclone copyto "export-s3:export-bucket/cluster-id/__migration__/${KEY_ARCHIVE}" "./${KEY_ARCHIVE}"
mkdir -p keys
7z x "./${KEY_ARCHIVE}" -o./keys
chmod 600 keys/opensearch-crypt.json
```

По запросу 7-Zip введите пароль из указанной версии секрета Lockbox. Внутри находится `opensearch-crypt.json` с настройками crypt и значениями `password`, `password2`, которые понадобятся для расшифровки репозитория.

### Настройка rclone crypt

1. Запустите `rclone config` и создайте remote `export-crypt`:

   | Параметр                  | Значение                                                   |
   |---------------------------|------------------------------------------------------------|
   | Тип                       | `crypt`                                                    |
   | remote                    | `export-s3:export-bucket/cluster-id/`                      |
   | filename_encryption       | `off`                                                      |
   | directory_name_encryption | `false`                                                    |
   | password                  | точное значение `password` из `keys/opensearch-crypt.json` |
   | password2                 | точное значение `password2` из того же файла               |

   Для каждого пароля выберите ввод собственного значения, не генерацию нового. Интерактивный `rclone config` сам преобразует пароли для записи в конфиг. Если вы заполняете `rclone.conf` вручную, открытые значения из JSON сначала нужно обработать через `rclone obscure`.

   Передавайте пароль без завершающего перевода строки, например через `printf '%s'`. В старых версиях rclone перевод строки может стать частью пароля.

1. Проверьте чтение через crypt remote:

   ```basb
   rclone lsf "export-crypt:${REPOSITORY}/"
   rclone copyto "export-crypt:${REPOSITORY}/index.latest" ./index.latest
   ```

   Через crypt remote имена видны без добавленного суффикса `.bin`, а содержимое расшифровывается при чтении.

### Расшифровка репозитория

1. Настройте remote `restore-s3` типа s3 для бакета, который будет читать целевой OpenSearch. Затем скопируйте репозиторий в отдельное пустое место, но не поверх зашифрованной выгрузки:

   ```bash
   rclone copy "export-crypt:${REPOSITORY}/" \
     "restore-s3:restore-bucket/${REPOSITORY}/" --progress
   
   rclone check "export-crypt:${REPOSITORY}/" \
     "restore-s3:restore-bucket/${REPOSITORY}/" --download --one-way
   ```

1. Скопируйте выбранный репозиторий, но без `__migration__/`. После успешной проверки вы увидите папку `restore-bucket/${REPOSITORY}/` с файлами snapshot-репозитория, которые может читать OpenSearch.

После расшифровки перейдите в раздел [«Восстановление базы данных»](#restore). На шаге 2 укажите бакет с **расшифрованными файлами** и соответствующий `base_path`: в приведённых выше командах это `restore-bucket` и значение `REPOSITORY`.

Основной сценарий восстановление базы данных требует `backups-safe/`. Если в метаданных выгрузки указан `backups/`, возможность внешнего восстановления из имеющихся snapshot нужно подтвердить отдельно.

### Клонирование backups-safe/

{% note warning %}

Этот шаг нужно делать только в том случае, если вы копируете незашифрованный репозиторий напрямую из исходного бакета.

{% endnote %}

Клонируйте из бакета папку `backups-safe/` с помощью утилиты **rclone**. Весь бакет копировать не нужно. Пример:

```bash
rclone --config rclone.conf copy --no-check-certificate --progress --s3-upload-concurrency 50 source:yandexcloud-dbaas-<cid>/backups-safe destination:<target-s3-bucket>/backups-safe
```

## Восстановление базы данных {#restore}

1. Создайте во внешнем облаке кластер OpenSearch последней версии.

   Далее для работы со снапшотами используется [публичный API OpenSearch](https://opensearch.org/docs/latest/api-reference/index/).

1. [Создайте](https://opensearch.org/docs/latest/api-reference/snapshots/create-repository/#s3-repository) новый S3 репозиторий и передайте в запросе параметры подключения к `<target-s3-bucket>`.

   **Важно**: `base_path` задайте равным `backups-safe`.

   Далее считаем, что имя нового репозитория `yc-automatic-backups-safe`.

1. [Получите](https://opensearch.org/docs/latest/api-reference/snapshots/get-snapshot/) идентификатор последнего снапшота: 

   ```bash
   curl --user ... https://new.opensearch.host:9200/_snapshot/yc-automatic-backups-safe/_latest
   ```

   Пример ответа:

   ```json
   {
       "snapshots": [
           {
               "snapshot": "yc-automatic-backups-safe-2026-10-12-13:37-abcdef",
               "uuid": "gkp3q-9TQg2RVVRSaix_Gw",
               "version_id": 136408427,
               "version": "2.19.6",
               ...
               "state": "SUCCESS",
               ...
           }
       ]
   }
   ```

1. Убедитесь, что версия вашего кластера OpenSearch выше или равна версии кластера из снапшота с помощью запроса:

   ```bash
   curl --user ... https://new.opensearch.host:9200/:
   ```

   Пример ответа:

   ```json
   {
       "name": "...",
       "cluster_name": "...",
       "cluster_uuid": "...",
       "version": {
           "distribution": "opensearch",
           "number": "2.19.6",
           ...
       },
       "tagline": "The OpenSearch Project: https://opensearch.org/"
   }
   ```

1. Если у вас установлен ISM-плагин, отключите его:

   ```bash
   curl --user ... "https://new.opensearch.host:9200/_cluster/settings" -X PUT --data-binary '{"persistent": {"plugins.index_state_management.enabled": false}}'
   ```

   Если ISM-плагин не установлен, перейдите к следующему шагу.

1. [Восстановите](https://opensearch.org/docs/latest/api-reference/snapshots/restore-snapshot/) из найденного снапшота всё, кроме state и индекса `.opendistro-ism-config`:

   ```bash
   curl --user ... "https://new.opensearch.host:9200/_snapshot/yc-automatic-backups-safe/yc-automatic-backups-safe-2026-10-12-13:37-abcdef/_restore?wait_for_completion=true" -X POST --data-binary '{"include_global_state": false, "indices": "*,-.opendistro-ism-config"}'
   ```

1. Восстановите `.opendistro-ism-config`:

   ```bash
   curl --user ... "https://new.opensearch.host:9200/_snapshot/yc-automatic-backups-safe/yc-automatic-backups-safe-2026-10-12-13:37-abcdef/_restore?wait_for_completion=true" -X POST --data-binary '{"include_global_state": false, "indices": ".opendistro-ism-config"}'
   ```

1. Восстановите state:

   ```bash
   curl --user ... "https://new.opensearch.host:9200/_snapshot/yc-automatic-backups-safe/yc-automatic-backups-safe-2026-10-12-13:37-abcdef/_restore?wait_for_completion=true" -X POST --data-binary '{"include_global_state": true}'
   ```

Восстановление кластера завершено.

После завершения восстановления проверьте работоспособность кластера и что все данные восстановились. Если у вас был установлен ISM-плагин, рекомендуем проверить его настройки и если они подходят, ISM-плагин можно включить обратно. Для этого запустите команду из п.4, заменив `{"plugins.index_state_management.enabled": false}` на `{"plugins.index_state_management.enabled": true}`.