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

1. Укажите имя региона по умолчанию `{{ region-id }}`:

   ```bash
   Default region name [{{ region-id }}]: {{ region-id }}
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
       region              {{ region-id }}      config-file    ~/.aws/config
   ```