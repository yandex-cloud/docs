# Настроить виртуальную машину в качестве NAT-шлюза

В Яндекс.Облаке можно настроить связь нескольких виртуальных машин с интернетом через NAT-шлюз. При этом будет использован только один публичный IP-адрес — тот, который будет присвоен шлюзу.

## Создание NAT-шлюза {#create-nat-instance}

[Создайте](../../compute/quickstart/quick-create-linux.md) виртуальную машину, которая будет служить шлюзом для доступа в интернет. У виртуальной машины должен быть публичный IP-адрес для связи с интернетом.

После создания виртуальной машины настройте возможность маршрутизации:

---

**[!TAB Ubuntu 18]**

1. Подключитесь к виртуальной машине, используя ее публичный IP-адрес:

   ```
   $ ssh <публичный IP-адрес ВМ>
   ```

1. Включите маршрутизацию в конфигурации **sysctl**. Вы можете отредактировать файл конфигурации с помощью редактора `nano`:

   ```
   $ sudo nano /etc/sysctl.conf
   ```

   Добавьте в конфигурацию следующие параметры:

   ```
   net.ipv4.ip_forward = 1
   net.ipv4.conf.all.accept_redirects = 1
   net.ipv4.conf.all.send_redirects = 1
   ```

1. Примените изменения конфигурации и перезапустите сетевую службу:

   ```
   $ sudo sysctl -p /etc/sysctl.conf
   $ sudo systemctl restart network.service
   ```

1. Настройте правила трансляции адресов.
   1. Обновите репозитории и установите пакеты `iptables-persistent` и `netfilter-persistent`:

      ```
      $ sudo apt-get update
      $ sudo apt install iptables-persistent netfilter-persistent 
      ```
   
   1. Запустите установленные службы:

      ```
      $ sudo systemctl start netfilter-persistent 
      $ sudo systemctl enable netfilter-persistent
      ```
   
   1. Включите NAT:

      ```
      $ sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
      ```
   
   1. Сохраните конфигурацию `netfilter`:

      ```
      $ sudo netfilter-persistent save
      ```
      
1. Укажите публичный IP-адрес NAT-шлюза при создании кластера Kubernetes с помощью флага `--default-gateway-v4-address`.      

**[!TAB CentOS 7]**

1. Подключитесь к виртуальной машине, используя ее публичный IP-адрес:

   ```
   $ ssh <публичный IP-адрес ВМ>
   ```

1. Включите маршрутизацию в конфигурации **sysctl**. Вы можете отредактировать файл конфигурации с помощью редактора `nano`:

   ```
   $ sudo nano /etc/sysctl.conf
   ```

   Добавьте в конфигурацию следующие параметры:

   ```
   net.ipv4.ip_forward = 1
   net.ipv4.conf.all.accept_redirects = 1
   net.ipv4.conf.all.send_redirects = 1
   ```

1. Примените изменения конфигурации и перезапустите сетевую службу:

   ```
   $ sudo sysctl -p /etc/sysctl.conf
   $ sudo systemctl restart network.service
   ```

1. Настройте правила трансляции адресов.

   1. Установите пакет `iptables-services`:

      ```
      $ sudo yum install -y iptables-services 
      ```
   
   1. Включите NAT:

      ```
      $ sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
      ```

   1. Включите `iptables`:

      ```
      $ sudo systemctl enable iptables
      ```

   1. Сохраните конфигурацию `iptables`:

      ```
      $ sudo service iptables save
      ```
      
1. Укажите публичный IP-адрес NAT-шлюза при создании кластера Kubernetes с помощью флага `--default-gateway-v4-address`.     

---
