# AWS CLI

[AWS CLI](https://docs.aws.amazon.com/cli/) — это интерфейс командной строки для работы с сервисами AWS. Общий [порядок вызова команд](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html) смотрите в официальной документации Amazon.

## Подготовка к работе {#before-you-begin}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роли](../security/index.md), необходимые для вашего проекта. Подробнее о ролях в [документации Identity and Access Management](../../iam/concepts/access-control/roles.md).
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статические ключи доступа. Надежно сохраните идентификатор и секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.

## Установка {#installation}

Для установки AWS CLI воспользуйтесь [инструкцией](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) на сайте разработчика.

## Настройка {#setup}

Для настройки AWS CLI в терминале введите команду `aws configure`. Команда запросит значения для следующих параметров:
1. `AWS Access Key ID` — идентификатор статического ключа, созданного при [подготовке к работе](#before-you-begin).
1. `AWS Secret Access Key` — содержимое статического ключа.
1. `Default region name` — регион `ru-central1`.

    Для работы с Yandex Cloud Postbox всегда указывайте регион — `ru-central1`. Другие значения региона могут привести к ошибке авторизации.

1. Значения остальных параметров оставьте без изменений.

### Конфигурационные файлы {#config-files}

В результате работы команда `aws configure` сохранит статический ключ и регион.

* Формат статического ключа в `.aws/credentials`:

  ```ini
  [default]
    aws_access_key_id = <идентификатор_статического_ключа>
    aws_secret_access_key = <содержимое_статического_ключа>
  ```

* Формат региона по умолчанию в `.aws/config`:

  ```ini
  [default]
    region = ru-central1
  ```

* Вы можете создать несколько профилей для разных сервисных аккаунтов, указав их данные в файле `.aws/credentials`:

  ```ini
  [default]
    aws_access_key_id = <идентификатор_статического_ключа_1>
    aws_secret_access_key = <содержимое_статического_ключа_1>
  [<имя_профиля_2>]
    aws_access_key_id = <идентификатор_статического_ключа_2>
    aws_secret_access_key = <содержимое_статического_ключа_2>
  ...
  [<имя_профиля_n>]
    aws_access_key_id = <идентификатор_статического_ключа_n>
    aws_secret_access_key = <содержимое_статического_ключа_n>
  ```

  Где `default` — профиль по умолчанию.