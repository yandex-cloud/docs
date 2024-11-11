After the `joomla-pg-tutorial-web` VM's status changes to `RUNNING`, do the following:
1. Under **{{ ui-key.yacloud.compute.instance.overview.section_network }}** on the VM page in the [management console]({{ link-console-main }}), find the VM's public IP address.
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM via SSH. To do this, use `ssh` in Linux or macOS, or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) in Windows.

   The recommended authentication method when connecting over SSH is using a key pair. Make sure to configure the generated key pair so that the private key matches the public key sent to the VM.
1. Download and unpack the Joomla archive:

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

1. Install additional components:

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

1. Get and configure the SSL certificate:

   {% list tabs %}

   - CentOS Stream

     ```bash
     sudo mkdir ~apache/.postgresql
     sudo wget "https://crls.yandex.net/allCLCAs.pem" -O ~apache/.postgresql/root.crt
     sudo chmod 0600 ~apache/.postgresql/root.crt
     sudo chown -R apache:apache ~apache/.postgresql
     ```

   {% endlist %}