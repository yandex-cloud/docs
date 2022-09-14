# Fault tolerant website with DNS load balancing

This tutorial describes how to set up a website with load balancing between two availability zones. This protects the website from failures in one of the zones.

To set up a fault tolerant website with DNS load balancing:

1. [In different availability zones, create two VMs with a pre-installed web server](#create-web-server-vm)
1. [Upload the website files](#upload-files)
1. [In different availability zones, create two VMs for DNS load balancers](#create-dns-balancer-vm)
1. [Install and configure the DNS load balancer software](#install-configure-dns-balancer)
1. [Configure DNS](#configure-dns)
1. [Test the fault tolerance](#test-ha)

## Before you start {#before-begin}

Before creating VMs:

1. Go to the {{ yandex-cloud }} [management console]({{ link-console-main }}) and select the folder where you want to perform the operations.
1. Make sure the selected folder has a network with subnets in the availability zones `{{ region-id }}-a` and `{{ region-id }}-b`. To do this, click the **{{ vpc-name }}** tile on the folder page. If the list contains a network, click on its name to see the list of subnets. If the subnets or network you need are not listed, [create them](../../vpc/quickstart.md).

## 1. Create VMs with a pre-installed web server {#create-web-server-vm}

Create two VMs in sequence, following the instructions:

1. On the folder page, click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter the VM name:
   * `dns-lb-tutorial-web-{{ region-id }}-a` for the first VM
   * `dns-lb-tutorial-web-{{ region-id }}-b` for the second VM

1. Select the [availability zone](../../overview/concepts/geo-scope.md):
   * `{{ region-id }}-a` for the first VM
   * `{{ region-id }}-b` for the second VM

1. Choose one public image for both VMs:
   * **LEMP** for Linux, nginx, MySQL, and PHP
   * **LAMP** for Linux, Apache, MySQL, and PHP

1. In the **Computing resources** section:
    - Choose the platform.
    - Specify the required amount of vCPUs and RAM.

    The characteristics of both VMs must match.

    The minimum configuration is enough for functional testing:
    * **Platform**: Intel Ice Lake.
    * **Guaranteed vCPU share**: 20%.
    * **vCPU**: 2.
    * **RAM**: 1 GB.

1. In the **Network settings** section, select the subnet to connect the VM to when creating it.

1. Specify data required for accessing the VM.
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the public key file.
You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.

1. Click **Create VM**.

Creating the VM may take several minutes. When the VM status changes to `RUNNING`, you can [upload the website files to it](#upload-files).

When a VM is created, it is assigned an IP address and hostname (FQDN). This data can be used for SSH access.

#### See also

- [{#T}](../../compute/operations/vm-connect/ssh.md)

## 2. Upload the website files {#upload-files}

For the `dns-lb-tutorial-web-{{ region-id }}-a` and `dns-lb-tutorial-web-{{ region-id }}-b`VMs, do the following:

{% include [upload-files](../_tutorials_includes/upload-web-site-files.md) %}

## 3. Create VMs for DNS load balancers {#create-dns-balancer-vm}

Create two VMs in sequence, following the instructions:

1. On the folder page, click **Create resource** and select **Virtual machine**.

1. In the **Name** field, enter the VM name:
   * `dns-lb-tutorial-slb-{{ region-id }}-a` for the first VM
   * `dns-lb-tutorial-slb-{{ region-id }}-b` for the second VM

1. Select the [availability zone](../../overview/concepts/geo-scope.md):
   * `{{ region-id }}-a` for the first VM
   * `{{ region-id }}-b` for the second VM

1. Select the **Ubuntu** or **CentOS** public image. Supported **Ubuntu** versions: 16.04 or higher.

1. In the **Computing resources** section:
    - Choose the platform.
    - Specify the required amount of vCPUs and RAM.

    The characteristics of both VMs must match.

    The minimum configuration is enough for functional testing:
    * **Platform**: Intel Ice Lake.
    * **Guaranteed vCPU share**: 20%.
    * **vCPU**: 2.
    * **RAM**: 1 GB.

1. In the **Network settings** section, select the subnet to connect the VM to when creating it.

1. Specify data required for accessing the VM.
    - Enter the username in the **Login** field.
    - In the **SSH key** field, paste the contents of the public key file.
You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTYgen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.

1. Click **Create VM**.

Creating the VM may take several minutes. When the VM status changes to `RUNNING`, you can [install and configure the DNS load balancer software](#install-configure-dns-balancer).

When a VM is created, it is assigned an IP address and hostname (FQDN). This data can be used for SSH access.

#### See also

- [{#T}](../../compute/operations/vm-connect/ssh.md)

## 4. Install and configure the DNS load balancer software {#install-configure-dns-balancer}

For the `dns-lb-tutorial-slb-{{ region-id }}-a` and `dns-lb-tutorial-slb-{{ region-id }}-b` VMs, do the following:

1. Go to the VM page of the [management console]({{ link-console-main }}). In the **Network** section, find the VM's public IP address.

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH. You can use the `ssh` tool on Linux and macOS and [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) for Windows.

   The recommended authentication method when connecting over SSH is using a key pair.  Don't forget to set up the created key pair: the private key must match the public key sent to the VM.

1. Set the required dependencies:

   {% list tabs %}

   - Ubuntu 16/18

     ```bash
     sudo apt-get update
     sudo apt-get install pdns-server pdns-backend-remote memcached python3-yaml python3-memcache python3-pip
     ```

   - CentOS 6/7

     ```bash
     sudo yum check-update
     sudo yum -y install epel-release
     sudo yum -y install pdns pdns-backend-remote memcached python34-yaml python34-setuptools git nano
     sudo service memcached start
     sudo chkconfig pdns on
     sudo chkconfig memcached on
     ```

   {% endlist %}

1. Install `polaris-gslb`:

   ```bash
   git clone https://github.com/polaris-gslb/polaris-gslb.git
   cd polaris-gslb
   sudo python3 setup.py install
   ```

1. Copy the configuration files for polaris-gslb

   {% list tabs %}

   - Ubuntu 16/18

     ```bash
     sudo cp /opt/polaris/etc/pdns.conf.dist /etc/powerdns/pdns.conf
     cd /opt/polaris/etc
     sudo cp polaris-lb.yaml.dist polaris-lb.yaml
     sudo cp polaris-health.yaml.dist polaris-health.yaml
     sudo cp polaris-pdns.yaml.dist polaris-pdns.yaml
     sudo cp polaris-topology.yaml.dist polaris-topology.yaml
     ```

   - CentOS 6

     ```bash
     sudo cp /opt/polaris/etc/pdns.conf.dist /etc/pdns/pdns.conf
     cd /opt/polaris/etc
     sudo cp polaris-lb.yaml.dist polaris-lb.yaml
     sudo cp polaris-health.yaml.dist polaris-health.yaml
     sudo cp polaris-pdns.yaml.dist polaris-pdns.yaml
     sudo cp polaris-topology.yaml.dist polaris-topology.yaml
     sudo cp -a /opt/polaris/bin/polaris-health /etc/init.d/polaris-health
     sudo chkconfig polaris-health on
     ```

   - CentOS 7

     ```bash
     sudo cp /opt/polaris/etc/pdns.conf.dist /etc/pdns/pdns.conf
     cd /opt/polaris/etc
     sudo cp polaris-lb.yaml.dist polaris-lb.yaml
     sudo cp polaris-health.yaml.dist polaris-health.yaml
     sudo cp polaris-pdns.yaml.dist polaris-pdns.yaml
     sudo cp polaris-topology.yaml.dist polaris-topology.yaml
     ```

   {% endlist %}

1. Find out the internal address of the VM:

   ```bash
   hostname -i
   ```

1. In the `pdns.conf` configuration file, specify the VM's internal IP address. You can edit the configuration file using the `nano` utility:

     {% list tabs %}

     - Ubuntu 16/18

       ```bash
       sudo nano /etc/powerdns/pdns.conf
       ```

     - CentOS 6/7

       ```bash
       sudo nano /etc/pdns/pdns.conf
       ```

     {% endlist %}

   The `pdns.conf` file has the format:

   ```
   # Polaris specific PDNS configuration

   #################################
   # launch    Which backends to launch and order to query them in
   #
   # Python3 binary must be in the $PATH!
   launch=remote
   remote-connection-string=pipe:command=/opt/polaris/bin/polaris-pdns,timeout=2000

   local-address=<INTERNAL IP ADRESS>

   #################################
   # distributor-threads   Default number of Distributor (backend) threads to start
   #
   # distributor-threads=3

   # logs received from a Polaris remotebackend will be logged from loglevel 6
   #
   # loglevel=6

   # If not using the topology load balancing method, comment out the caching
   # options below to greatly improve the backend performance

   #################################
   # cache-ttl Seconds to store packets in the PacketCache
   #
   # cache-ttl=20
   cache-ttl=0

   #################################
   # negquery-cache-ttl    Seconds to store negative query results in the QueryCache
   #
   # negquery-cache-ttl=60
   negquery-cache-ttl=0

   #################################
   # query-cache-ttl   Seconds to store query results in the QueryCache
   #
   # query-cache-ttl=20
   query-cache-ttl=0
   ```

   Specify the internal IP address in the `local-address` parameter value in place of `<INTERNAL IP ADDRESS>`.

1. Configure `polaris-gslb`. You can edit the configuration files using the `nano` utility:

   1. `sudo nano /opt/polaris/etc/polaris-lb.yaml`

      The `polaris-lb.yaml` file has the format:

       ```
       pools:
           www-example:
               monitor: http
               monitor_params:
                   hostname: www.example.com
                   url_path: /
               lb_method: wrr
               fallback: any
               members:
               - ip: <dns-lb-tutorial-web-{{ region-id }}-a PUBLIC IP>
                 name: dns-lb-tutorial-web-{{ region-id }}-a
                 weight: 1
               - ip: <dns-lb-tutorial-web-{{ region-id }}-b PUBLIC IP>
                 name: dns-lb-tutorial-web-{{ region-id }}-b
                 weight: 1

       globalnames:
           www.example.com:
               pool: www-example
               ttl: 1
       ```

       Specify the following in the file:
       * Your domain name instead of `www.example.com`.
       * In place of `<dns-lb-tutorial-web-{{ region-id }}-a PUBLIC IP>`, enter the public IP address of the `dns-lb-tutorial-web-{{ region-id }}-a` VM.
       * In place of `<dns-lb-tutorial-web-{{ region-id }}-b PUBLIC IP>`,  enter the public IP address of the `dns-lb-tutorial-web-{{ region-id }}-b` VM.

       You can find out the VM's public address in the **Network** section on the VM page in the [management console]({{ link-console-main }}).

   1. `sudo nano /opt/polaris/etc/polaris-pdns.yaml`

      The `polaris-pdns.yaml` file has the format:

      ```
      ###############################
      # SOA record format
      # MNAME                RNAME                           SERIAL REFRESH RETRY EXPIRE MINIMUM
      # polaris.example.com. hostmaster.polaris.example.com. 42     3600    600   86400  1

      ###############################
      # SOA MNAME, must end with a dot.
      #
      SOA_MNAME: dns-lb-tutorial-slb-{{ region-id }}-a.example.com.

      ###############################
      # SOA_RNAME, must end with a dot.
      #
      SOA_RNAME: hostmaster.example.com.

      ###############################
      # SOA serial can either be an absolute numeric value e.g. 1(default), or "auto",
      # which automatically sets the serial to seconds since the epoch of the last state
      # update.
      #
      # SOA_SERIAL: 1

      ###############################
      # SOA REFRESH
      #
      # SOA_REFRESH: 3600

      ###############################
      # SOA RETRY
      #
      # SOA_RETRY: 600

      ###############################
      # SOA EXPIRE
      #
      # SOA_EXPIRE: 86400

      ###############################
      # SOA MINIMUM
      #
      # SOA_MINIMUM: 1

      ###############################
      # TTL to set on SOA record
      #
      # SOA_TTL: 86400

      ################################
      # Whether to log a detailed request/response information to pdns.
      # If set to "true", pdns.conf "loglevel" option must be set to 6 or higher.
      #
      # Setting to "false" will improve the backend performance.
      #
      # LOG: false

      ################################
      # Memcache hostname/ip:port to use e.g. "192.168.1.10:12345",
      # if port is omitted the default memcache port is used.
      #
      # SHARED_MEM_HOSTNAME: 127.0.0.1
      ```

      In the file, specify your domain name instead of `www.example.com`.

1. If CentOS 6 is installed on the VM, skip this step.

   Set up status checks for `polaris-gslb`:
   1. Add the `systemd Unit` file to check the status of `polaris-gslb`. You can edit the file using the `nano` utility:

       ```
       sudo mkdir -p /etc/systemd/system
       sudo nano /etc/systemd/system/polaris-health.service
       ```

      Make the `polaris-health.service` file look like:

       ```
       [Unit]
       Description=Polaris-GSLB Health Check
       After=network-online.target

       [Service]
       ExecStart=/opt/polaris/bin/polaris-health start
       Type=forking
       Restart=on-failure
       RestartSec=1
       StartLimitInterval=0

       [Install]
       WantedBy=multi-user.target
       ```
   1. Add `polaris-health` to OS autoload:

       ```bash
       sudo systemctl enable polaris-health
       ```

1. Restart PowerDNS:

   ```bash
   sudo service pdns restart
   ```

1. Run a status check for `polaris-health`:

   ```bash
   sudo service polaris-health start
   ```

1. This step should only be performed on a VM running CentOS 6.

   Open network port 53 using the `iptables` utility:

   ```bash
   sudo iptables -I INPUT -p tcp -m tcp --dport 53 -j ACCEPT
   sudo iptables -I INPUT -p udp -m udp --dport 53 -j ACCEPT
   sudo iptables-save | sudo tee /etc/sysconfig/iptables
   ```

## 5. Configure DNS {#configure-dns}

The domain name that you want to use for your website must be associated with the created VMs.

The instructions below describe how to configure an external DNS service using as an example [reg.ru](https://www.reg.ru/) for `www.example.com` and `example.com` domain names:

To configure an external DNS server, do the following:

1. Find the public IP addresses of the `dns-lb-tutorial-slb-{{ region-id }}-a` and `dns-lb-tutorial-slb-{{ region-id }}-b` VMs in the **Network** section on the VM pages in the [management console]({{ link-console-main }}).
1. Log in to the control panel of the external DNS service. Go to the list of your domains and click on the domain name you need.
1. Create two A records:
   * For the `dns-lb-tutorial-slb-{{ region-id }}-a` VM:
      * **IP Address**: your VM's public IP address.
      * **Subdomain**: `dns-lb-tutorial-slb-{{ region-id }}-a`.
   * For the `dns-lb-tutorial-slb-{{ region-id }}-b` VM:
      * **IP Address**: your VM's public IP address.
      * **Subdomain**: `dns-lb-tutorial-slb-{{ region-id }}-b`.
1. Create two NS records with the following field values:
   * For the `dns-lb-tutorial-slb-{{ region-id }}-a` VM:
      * **Subdomain**: `www`.
      * **Canonical name**: `dns-lb-tutorial-slb-{{ region-id }}-a.example.com.`.
   * For the `dns-lb-tutorial-slb-{{ region-id }}-b` VM:
     * **Subdomain**: `www`.
     * **Value**: `dns-lb-tutorial-slb-{{ region-id }}-b.example.com.`.
1. Wait 15-20 minutes for DNS record changes to take effect. The waiting time may differ for your DNS service.

## 6. Test the fault tolerance {#test-ha}

### 6.1. DNS load balancers {#test-dns-balancers}

1. In the **Network** section on the VM page of the [management console]({{ link-console-main }}), find the public IP address of the `dns-lb-tutorial-slb-{{ region-id }}-a` VM.
1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
1. Stop the DNS service to simulate a failure of the DNS load balancer:

   ```bash
   sudo service pdns stop
   ```
1. Connect to your website through a browser. The connection should be successful, even though one of the DNS load balancers has failed.
1. After the check is complete, restart the DNS service:

   ```bash
   sudo service pdns start
   ```

### 6.2. Web servers {#test-web-servers}

1. In the **Network** section on the VM page of the [management console]({{ link-console-main }}), find the public IP address of the `dns-lb-tutorial-web-{{ region-id }}-a` VM.

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.

1. Stop the web service to simulate a failure on the web server:

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

1. Connect to your website through a browser. The connection should be successful, even though one of the web servers has failed.

1. After the check is complete, restart the web service:

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

