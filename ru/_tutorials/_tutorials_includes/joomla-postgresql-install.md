После того как ВМ `joomla-pg-tutorial-web` перейдет в статус `RUNNING`, выполните:
1. В блоке **{{ ui-key.yacloud.compute.instance.overview.section_network }}** на странице ВМ в [консоли управления]({{ link-console-main }}) найдите публичный IP-адрес ВМ.
1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH. Для этого можно использовать утилиту `ssh` в Linux и macOS и программу [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) для Windows.

   Рекомендуемый способ аутентификации при подключении по SSH — с помощью пары ключей. Не забудьте настроить использование созданной пары ключей: закрытый ключ должен соответствовать открытому ключу, переданному на ВМ.
1. Скачайте и распакуйте архив с Joomla:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo mkdir -p /var/www/html/
     curl https://downloads.joomla.org/cms/joomla3/3-8-7/Joomla_3-8-7-Stable-Full_Package.tar.gz?format=gz --output Joomla_3-8-7-Stable-Full_Package.tar.gz --location
     sudo mv Joomla_3-8-7-Stable-Full_Package.tar.gz /var/www/html/
     (cd /var/www/html/ && sudo tar -zxvf Joomla_3-8-7-Stable-Full_Package.tar.gz)
     sudo rm /var/www/html/Joomla_3-8-7-Stable-Full_Package.tar.gz
     sudo mv /var/www/html/htaccess.txt /var/www/html/.htaccess
     ```

    {% endlist %}

1. Установите дополнительные компоненты:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo dnf install epel-release
     sudo dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
     sudo yum -y install --enablerepo remi-modular httpd php php-pgsql php php-common php-mbstring php-zip php-xml nano wget php-json
     sudo dnf module enable postgresql:13
     sudo dnf install postgresql-server
     ```

   {% endlist %}

1. Получите и настройте использование SSL-сертификата:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo mkdir ~apache/.postgresql
     sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
     sudo chmod 0600 ~apache/.postgresql/root.crt
     sudo chown -R apache:apache ~apache/.postgresql
     ```

   {% endlist %}