[Документация Yandex Cloud](../../index.md) > [Yandex Message Queue](../index.md) > [Пошаговые инструкции](index.md) > Настройка AWS CLI

# Настройка AWS CLI

Для управления очередями и сообщениями в Message Queue можно использовать [AWS CLI](https://aws.amazon.com/ru/cli/).

Чтобы настроить AWS CLI для работы с Message Queue:

1. [Установите](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) утилиту командной строки AWS CLI.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт с ролью `editor`.
1. [Создайте](../../iam/operations/authentication/manage-access-keys.md#create-access-key) статические ключи доступа. Надежно сохраните идентификатор и секретный ключ. После того, как вы закроете окно, параметры секретного ключа станут недоступны.
1. Настройте AWS CLI:

   1. Запустите интерактивную настройку профиля:
   
      ```bash
      aws configure
      ```
   
   1. Укажите полученный ранее идентификатор ключа сервисного аккаунта:
   
      ```bash
      AWS Access Key ID [****************ver_]: <идентификатор_ключа_сервисного_аккаунта>
      ```
   
   1. Укажите полученный ранее секретный ключ сервисного аккаунта:
   
      ```bash
      AWS Secret Access Key [****************w5lb]: <секретный_ключ_сервисного_аккаунта>
      ```
   
   1. Укажите имя региона по умолчанию `ru-central1`:
   
      ```bash
      Default region name [ru-central1]: ru-central1
      ```
   
   1. Укажите формат выходных данных по умолчанию `json`:
   
      ```bash
      Default output format [None]: json
      ```
   
   1. Чтобы посмотреть текущие настройки профиля, выполните команду:
   
      ```bash
      aws configure list
      ```
   
      Результат:
   
      ```text
            Name                    Value             Type    Location
            ----                    -----             ----    --------
         profile                <not set>             None    None
      access_key     ****************aBc1 shared-credentials-file
      secret_key     ****************DeF2 shared-credentials-file
          region              ru-central1      config-file    ~/.aws/config
      ```