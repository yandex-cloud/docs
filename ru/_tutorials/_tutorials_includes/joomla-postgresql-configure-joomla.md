Настройте Joomla по [инструкции](https://docs.joomla.org/J3.x:Installing_Joomla/ru) на сайте проекта. В процессе настройки вам потребуются параметры подключения к БД.
1. Получите адреса хостов кластера БД в консоли управления:
   1. Откройте каталог, в котором создан кластер БД, и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
   1. Выберите кластер `joomla-pg-tutorial-db-cluster`.
   1. Перейдите на вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}**.
   1. В поле **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** скопируйте адреса хостов.
1. На шаге **Database** в веб-установщике Joomla заполните поля:
   * **Тип базы данных** — `{{ PG }}`.
   * **Имя сервера базы данных**:

     ```text
     <адрес_хоста_1>,<адрес_хоста_2>,<адрес_хоста_3> port=6432 sslmode=verify-full target_session_attrs=read-write
     ```

   * **Имя пользователя** — `joomla`.
   * **Пароль** — укажите пароль пользователя БД.
   * **Имя базы данных** — `joomla-pg-tutorial-db`.
1. Для проверки безопасности Joomla! может потребовать создать или удалить специальный тестовый файл. На ВМ перейдите в каталог `/var/www/html/installation` и создайте или удалите там указанный файл.
1. Создайте пустой файл `configuration.php` для сохранения конфигурации и настройте права для записи в каталог:

   ```bash
   sudo touch /var/www/html/configuration.php
   sudo chmod 655 /var/www/html/configuration.php
   sudo chown -R apache:apache /var/www/html/
   sudo restorecon -R /var/www/html
   ```

1. После завершения установки удалите директорию `installation`. Это требование безопасности Joomla!:

   ```bash
   sudo rm -rf /var/www/html/installation
   ```