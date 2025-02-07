1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ compute-name }}**.
1. Перейдите на страницу ВМ из созданной ранее группы.
1. Скопируйте **{{ ui-key.yacloud.compute.instance.overview.label_public-ipv4 }}** из блока **{{ ui-key.yacloud.compute.instance.overview.section_network }}**.
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md#vm-connect) к ВМ по протоколу SSH.
1. Остановите веб-сервис, чтобы сымитировать сбой в работе веб-сервера:

   ```bash
   sudo service nginx stop
   ```

1. Откройте ваш сайт в браузере. Несмотря на сбой в работе одного из веб-серверов, сайт должен успешно открыться.
1. После завершения проверки запустите веб-сервис:

   ```bash
   sudo service nginx start
   ```