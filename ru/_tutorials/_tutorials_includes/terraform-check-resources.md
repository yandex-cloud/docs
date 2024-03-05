1. Проверьте конфигурацию командой:

   ```bash
   terraform validate
   ```

   Если конфигурация является допустимой, появится сообщение:

   ```text
   Success! The configuration is valid.
   ```

1. Отформатируйте файлы конфигураций в текущем каталоге и подкаталогах:

   ```bash
   terraform fmt
   ```

   Результат:

   ```text
   main.tf
   variables.tf
   ```