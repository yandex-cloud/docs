1. [Узнайте](../../../compute/operations/vm-info/get-info.md) публичный IP-адрес любой ВМ из созданной группы.
1. [Подключитесь](../../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
1. Остановите веб-сервис, чтобы сымитировать сбой в работе веб-сервера:

    {% list tabs %}

    - LAMP

      ```bash
      sudo service apache2 stop
      ```

    - LEMP

      ```bash
      sudo service nginx stop
      ```

    {% endlist %}

1. [Узнайте](../../../network-load-balancer/operations/load-balancer-list.md#get) IP-адрес обработчика.
1. Откройте сайт в браузере, используя адрес обработчика.

    Несмотря на сбой в работе одного из веб-серверов, подключение должно пройти успешно.

1. После завершения проверки снова запустите веб-сервис:

    {% list tabs %}

    - LAMP

        ```bash
        sudo service apache2 start
        ```

    - LEMP

        ```bash
        sudo service nginx start
        ```

    {% endlist %}