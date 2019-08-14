# Настройка виртуальной машины в качестве NAT-шлюза

В Яндекс.Облаке можно настроить связь нескольких виртуальных машин с интернетом через NAT-шлюз. При этом будет использован только один публичный IP-адрес — тот, который будет присвоен шлюзу.

{% note important %}

Для корректной работы NAT-шлюза необходимо поместить его в подсеть без таблиц маршрутизации.

{% endnote %}

## Подготовьтесь к работе {#before-begin}

Создайте подсеть для NAT-шлюза.

1. Создайте [облачную сеть](../../vpc/operations/network-create.md) с любым именем, например `nat-instance-network`.
1. Создайте в облачной сети [подсеть](../../vpc/operations/subnet-create.md) для NAT-шлюза с любым именем, например `nat-subnet`. Не привязывайте к ней таблицы маршрутизации.

## Создайте NAT-шлюз {#create-nat-instance}

Вы можете автоматически создать NAT-шлюз c помощью YC CLI или создать ВМ и настроить ее вручную.

### Создание NAT-шлюза с помощью YC CLI из готового образа {#yc-create}

1. Создайте виртуальную машину со следующими параметрами:

    - Имя ВМ: `nat-instance`.
    - Зона доступности: `ru-central1-a`.
    - Имя хоста: `nat-instance`.
    - Параметры для создания загрузочного диска: `"image-family=nat-instance-ubuntu,size=40"`.
    - Каталог с образом: `standard-images`.
    - Путь до файла с публичной частью SSH ключа: `ssh-key.pub`.
    - Сетевой интерфейс: `subnet-name="nat-subnet,nat-ip-version=ipv4"`.
    - Объем оперативной памяти: 2.
    - Количество ядер: 2.
    
    ```
    $ yc compute instance create \
    --name nat-instance \
    --zone ru-central1-a \
    --hostname nat-instance \
    --create-boot-disk "image-family=nat-instance-ubuntu,size=40" \
    --image-folder-id=standard-images \
    --ssh-key ssh-key.pub \
    --network-interface subnet-name="nat-subnet,nat-ip-version=ipv4" \
    --memory 2 \
    --cores 2
    done (18s)
    id: fhmp220q3kgoqfop85q6
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-08-12T11:18:41Z"
    name: nat-instance
    zone_id: ru-central1-a
    platform_id: standard-v2
    ...
    ```

1. Посмотрите внутренний IP-адрес шлюза.

    1. В консоли управления в {{ compute-name }} в разделе **Виртуальные машины** из списка ВМ выберите NAT-шлюз. В примере это ВМ с именем `nat-instance`. 
    1. Нажмите на строку с именем ВМ для получения подробной информации о ней.
    1. Внутренний IP-адрес будет указан в разделе **Сеть**.

1. Укажите внутренний IP-адрес при создании кластера {{ k8s }}.

    - Консоль управления: укажите в поле **Адрес шлюза** в разделе **Сетевые настройки кластера** на странице создания кластера {{ k8s }}.
    - YC CLI: укажите с помощью параметра `--default-gateway-v4-address`.        

{% endlist %}

### Ручное создание и настройка NAT-шлюза {#create}

[Создайте](../../compute/quickstart/quick-create-linux.md) виртуальную машину, которая будет служить шлюзом для доступа в интернет. У виртуальной машины должен быть публичный IP-адрес для связи с интернетом.

После создания виртуальной машины настройте возможность маршрутизации:

{% list tabs %}

- Ubuntu 18
  
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
     $ sudo systemctl restart systemd-networkd
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
        
  1. Укажите внутренний IP-адрес при создании кластера {{ k8s }}.
  
      - Консоль управления: укажите в поле **Адрес шлюза** в разделе **Сетевые настройки кластера** на странице создания кластера {{ k8s }}.
      - YC CLI: укажите с помощью параметра `--default-gateway-v4-address`. 
  
- CentOS 7
  
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
        
  1. Укажите внутренний IP-адрес при создании кластера {{ k8s }}.
    
      - Консоль управления: укажите в поле **Адрес шлюза** в разделе **Сетевые настройки кластера** на странице создания кластера {{ k8s }}.
      - YC CLI: укажите с помощью параметра `--default-gateway-v4-address`.      
  
{% endlist %}
