[Документация Yandex Cloud](../../../index.md) > [Yandex Compute Cloud](../../index.md) > [Пошаговые инструкции](../index.md) > Диски > Управление > Перенести образ диска в стороннее S3-хранилище без вспомогательной ВМ

# Перенос образа диска Yandex Compute Cloud в S3-совместимое хранилище стороннего провайдера без вспомогательной ВМ

Вы можете сохранить копию [диска](../../concepts/disk.md) Yandex Compute Cloud в объектном хранилище другого провайдера. Такая копия позволяет хранить данные за пределами Yandex Cloud и использовать их для восстановления.

В этой инструкции вы выгрузите [снимок](../../concepts/snapshot.md) или [образ](../../concepts/image.md) диска в S3-совместимое хранилище без создания вспомогательной ВМ. Затем с помощью утилиты `yc-nbs-export-unpack` восстановите образ в файл `.raw` или на блочное устройство. Далее чтобы запустить ВМ у другого провайдера, импортируйте полученный образ по инструкции этого провайдера.

Чтобы перенести образ диска в S3-совместимое хранилище:

1. [Подготовьте бакет и доступ к нему](#prepare-bucket).
1. [Заполните заявку и выгрузите снимок или образ](#export-snapshot).
1. [Подготовьте утилиту](#prepare-tool).
1. [Настройте доступ к хранилищу](#configure-access).
1. [Подготовьте ключ шифрования](#prepare-encryption-key), если диск зашифрован.
1. [Восстановите образ](#restore-image).

## Подготовьте бакет и доступ к нему {#prepare-bucket}

Для выгрузки снимка или образа поддерживаются S3-совместимые хранилища сторонних провайдеров и Yandex Object Storage.

Для Yandex Object Storage [создайте бакет](../../../storage/quickstart.md) и [статический ключ доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) сервисного аккаунта с [ролью](../../../storage/operations/buckets/iam-access.md) `storage.admin` на этот бакет.

Чтобы получить выгрузку в бакет стороннего провайдера, например Selectel:

1. [Создайте](https://docs.selectel.ru/s3/buckets/create-bucket/) бакет в Selectel:

   {% note info %}

   В примере используется приватный бакет [Selectel](https://selectel.ru/) в регионе `ru-7`. Для другого S3-совместимого хранилища замените параметры подключения и проверьте требования провайдера к доступу и размеру объектов.

   {% endnote %}

   * Укажите имя, например `disk-snapshot-dr-bucket`. Если имя занято, выберите другое и замените его в командах ниже.
   * Выберите приватный доступ.
   * Выберите тип адресации `Path-Style`.
   * Выберите холодный класс хранения.

     {% note warning %}

     Перед загрузкой ознакомьтесь с [условиями тарификации](https://docs.selectel.ru/s3/about/payment/#storage-types), включая чтение данных и минимальный срок хранения.

     {% endnote %}

1. На вкладке **Подключение** [создайте](https://docs.selectel.ru/access-control/manage/edit-user-data-or-role/#issue-s3-key) ключ S3 с именем `disk-snapshot-bucket-key`. В поле владельца ключа выберите **Мне** для разового переноса либо отдельного [сервисного пользователя Selectel](https://docs.selectel.ru/access-control/manage/add-user/#add-service-user) для постоянного использования.
1. Для сервисного пользователя предоставьте полный доступ к операциям с нужным бакетом, включая:

   * чтение, запись и удаление объектов;
   * просмотр содержимого бакета;
   * операции составной загрузки (_multipart upload_).

1. Сохраните `Access key` и `Secret key` в защищенном месте. Они понадобятся при заполнении формы экспорта и настройке утилиты.

## Заполните заявку и выгрузите снимок или образ {#export-snapshot}

1. Откройте [форму экспорта снимка или образа диска](https://console.yandex.cloud/compute-snapshot-backup-request) в консоли управления и следуйте указаниям на странице.
1. Дождитесь выгрузки файлов в указанный бакет.
1. Найдите в бакете каталог с именем вашего снимка или образа и убедитесь, что в нем есть файл `manifest.json`. В командах ниже этот каталог обозначен как `<каталог_диска>`.

Если выгрузка завершилась с ошибкой или файлы не появились в бакете, обратитесь в [техническую поддержку](https://center.yandex.cloud/support) и укажите идентификатор операции выгрузки. Его можно найти в [списке операций Yandex Compute Cloud](../operation-logs.md#get-operations).

## Подготовьте утилиту {#prepare-tool}

1. Скачайте архив [по ссылке](https://storage.yandexcloud.net/yc-export-tools/yc-nbs-export-tool.1.0.tar.gz).
1. Распакуйте архив и перейдите в каталог `yc-nbs-export-unpack-<версия>`.

   Например, для версии 1.0:

   ```bash
   tar -xzf yc-nbs-export-tool.1.0.tar.gz
   cd yc-nbs-export-unpack-0.1.0
   ```

1. Выберите бинарный файл для вашей системы. Доступные платформы перечислены в файле `BINARIES.json`.

   #|
   || Система | x64 (Intel/AMD) | ARM64 ||
   || Linux | `bin/linux-x64/` | `bin/linux-arm64/` ||
   || macOS | `bin/macos-x64/` | `bin/macos-arm64/` ||
   || Windows | `bin/windows-x64/` | — ||
   |#

   Например, для Linux на x64 выполните:

   ```bash
   ./bin/linux-x64/yc-nbs-export-unpack --help
   ```

   Для Windows используйте PowerShell и соответствующий файл `.exe`:

   ```powershell
   .\bin\windows-x64\yc-nbs-export-unpack.exe --help
   ```

   Команды ниже приведены для Linux x64. Для другой системы замените `./bin/linux-x64/yc-nbs-export-unpack` на путь к выбранному бинарному файлу.

   {% cut "Если бинарного файла для вашей платформы нет" %}

   Подготовьте окружение Python и установите зависимости:

   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   python3 -m pip install -r requirements.txt
   ```

   Проверьте запуск утилиты:

   ```bash
   python3 yc-nbs-export-unpack --help
   ```

   В командах ниже используйте `python3 yc-nbs-export-unpack` вместо `./bin/linux-x64/yc-nbs-export-unpack`.

   {% endcut %}

## Настройте доступ к хранилищу {#configure-access}

Задайте ключи доступа к S3 через переменные окружения:

```bash
export AWS_ACCESS_KEY_ID='<идентификатор_ключа>'
export AWS_SECRET_ACCESS_KEY='<секретный_ключ>'
# Для временных ключей также задайте AWS_SESSION_TOKEN
```

Вместо `<идентификатор_ключа>` и `<секретный_ключ>` подставьте идентификатор и секретный ключ доступа к бакету.

{% cut "Другие способы передачи ключей" %}

Вы можете сохранить ключи в файле `~/.aws/credentials`:

```ini
[default]
aws_access_key_id = <идентификатор_ключа>
aws_secret_access_key = <секретный_ключ>
```

Для временных ключей добавьте `aws_session_token` в тот же раздел. Именованный профиль выбирается параметром `--s3-profile NAME` или переменной `AWS_PROFILE`. Другой путь к файлу можно задать переменной `AWS_SHARED_CREDENTIALS_FILE`.

При этих способах не указывайте `--s3-credentials-file`. Если профиль не выбран явно через `--s3-profile`, переменные с ключами имеют приоритет над файлом `~/.aws/credentials`.

Также можно создать JSON-файл:

```json
{
  "id": "<идентификатор_ключа>",
  "secret": "<секретный_ключ>"
}
```

Передайте путь к нему параметром `--s3-credentials-file`. JSON-файл имеет приоритет над переменными окружения и не может использоваться одновременно с `--s3-profile`.

{% endcut %}

## Подготовьте ключ шифрования {#prepare-encryption-key}

Этот шаг нужен только для [зашифрованного диска](../../concepts/encryption.md).

1. Скачайте из бакета файлы `<каталог_диска>/encrypted.dek` и `<каталог_диска>/kek.id`. Они содержат зашифрованный ключ диска (DEK) и идентификатор ключа, которым он зашифрован.
1. [Расшифруйте DEK](../../../kms/operations/symmetric-encryption.md#decryption) с помощью [Yandex Cloud CLI](../../../cli/quickstart.md#install). Пользователю должна быть [назначена роль](../../../kms/operations/key-access.md#add-access-binding) `kms.keys.decrypter` на указанный ключ.

   ```bash
   yc kms symmetric-crypto decrypt \
     --id <kek_id> \
     --profile <имя_профиля> \
     --ciphertext-file encrypted.dek \
     --plaintext-file decrypted.dek
   ```

   Где `<kek_id>` — идентификатор из файла `kek.id`, а `<имя_профиля>` — имя профиля CLI.

При восстановлении образа передайте в параметре `--decryption-key` содержимое файла `decrypted.dek`, закодированное в Base64. Например, с помощью [OpenSSL](https://docs.openssl.org/3.5/man1/openssl-enc/) командой `openssl base64 -A -in decrypted.dek`.

## Восстановите образ {#restore-image}

Утилита прочитает манифест и данные снимка или образа из S3-хранилища, при необходимости расшифрует их и восстановит содержимое диска. Результат можно сохранить в файл образа `.raw` для дальнейшего импорта или записать на блочное устройство.

Чтобы сохранить образ в файл с ключами доступа из переменных окружения, выполните команду:

```bash
AWS_ACCESS_KEY_ID='<идентификатор_ключа>' \
AWS_SECRET_ACCESS_KEY='<секретный_ключ>' \
./bin/linux-x64/yc-nbs-export-unpack \
  --s3-endpoint <эндпоинт_S3> \
  --s3-region <регион_хранилища> \
  --s3-bucket <имя_бакета> \
  --manifest-key <каталог_диска>/manifest.json \
  --output <путь_к_файлу_образа> \
  --workers 10
```

Где:

* `AWS_ACCESS_KEY_ID` — идентификатор ключа доступа к бакету.
* `AWS_SECRET_ACCESS_KEY` — секретный ключ доступа к бакету.
* `--s3-endpoint` — эндпоинт S3-хранилища. Например, `https://storage.yandexcloud.net` для Yandex Object Storage или `https://s3.ru-7.storage.selcloud.ru` для бакета в Selectel.
* `--s3-region` — регион хранилища. Например, `ru-central1` для Yandex Object Storage или `ru-7` для бакета в Selectel.
* `--s3-bucket` — имя бакета, в который выгружен снимок или образ.
* `--manifest-key` — путь к файлу `manifest.json` относительно бакета. Вместо `<каталог_диска>` укажите путь к каталогу с выгруженными файлами.
* `--output` — путь к файлу, в который будет сохранен образ, например `my_disk.raw`. Файл не должен существовать.

  Вместо файла образ можно [выгрузить на блочное устройство](#restore-to-device).

* `--workers` — количество параллельных обработчиков.

Для временных ключей также передайте `AWS_SESSION_TOKEN`.

### Примеры {#examples}

#### Сохранение образа в файл с ключами из JSON-файла {#restore-with-json}

```bash
./bin/linux-x64/yc-nbs-export-unpack \
  --s3-endpoint https://s3.ru-7.storage.selcloud.ru \
  --s3-region ru-7 \
  --s3-credentials-file my_cred.json \
  --s3-bucket disk-snapshot-dr-bucket \
  --manifest-key my_disk/manifest.json \
  --output my_disk.raw \
  --workers 10
```

Где `--s3-credentials-file` — путь к JSON-файлу с ключами доступа.

#### Сохранение образа в файл с именованным профилем {#restore-with-profile}

Добавьте профиль `recovery` в `~/.aws/credentials`:

```ini
[recovery]
aws_access_key_id = <идентификатор_ключа>
aws_secret_access_key = <секретный_ключ>
```

Передайте имя профиля в команду:

```bash
./bin/linux-x64/yc-nbs-export-unpack \
  --s3-endpoint https://s3.ru-7.storage.selcloud.ru \
  --s3-region ru-7 \
  --s3-profile recovery \
  --s3-bucket disk-snapshot-dr-bucket \
  --manifest-key my_disk/manifest.json \
  --output my_disk.raw \
  --workers 10
```

Где `--s3-profile` — имя профиля с ключами доступа в файле `~/.aws/credentials`. Вместо `--s3-profile recovery` можно задать переменную окружения `AWS_PROFILE=recovery`, если переменные `AWS_ACCESS_KEY_ID` и `AWS_SECRET_ACCESS_KEY` не заданы. Иначе будут использованы ключи из переменных окружения.

#### Восстановление образа на блочное устройство {#restore-to-device}

{% note warning %}

Восстановление на блочное устройство поддерживается только в Linux. Данные на целевом блочном устройстве будут перезаписаны.

{% endnote %}

[Используйте профиль](#restore-with-profile) `recovery` и выполните команду, указав целевое устройство.

```bash
./bin/linux-x64/yc-nbs-export-unpack \
  --s3-endpoint https://s3.ru-7.storage.selcloud.ru \
  --s3-region ru-7 \
  --s3-profile recovery \
  --s3-bucket disk-snapshot-dr-bucket \
  --manifest-key my_disk/manifest.json \
  --device /dev/vdc \
  --overwrite-device \
  --workers 10
```

Где:

* `--s3-profile` — имя профиля с ключами доступа в файле `~/.aws/credentials`.
* `--device` — путь к целевому блочному устройству, например `/dev/vdc`.
* `--overwrite-device` — разрешение перезаписать данные на устройстве.

#### Сохранение образа зашифрованного диска в файл {#restore-encrypted-disk}

Используйте [профиль `recovery`](#restore-with-profile) и [подготовьте ключ шифрования](#prepare-encryption-key). Выполните команду:

```bash
./bin/linux-x64/yc-nbs-export-unpack \
  --s3-endpoint https://s3.ru-7.storage.selcloud.ru \
  --s3-region ru-7 \
  --s3-profile recovery \
  --s3-bucket disk-snapshot-dr-bucket \
  --manifest-key my_disk/manifest.json \
  --output my_disk.raw \
  --decryption-key "$(openssl base64 -A -in decrypted.dek)" \
  --workers 10
```

Где `--decryption-key` — содержимое файла `decrypted.dek`, закодированное в Base64 утилитой [OpenSSL](https://docs.openssl.org/3.5/man1/openssl-enc/).

#### Полезные ссылки {#see-also}

[Перенос образа диска с вспомогательной ВМ](disk-migration-to-external-s3.md).