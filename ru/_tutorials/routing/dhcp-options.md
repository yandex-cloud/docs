# Настройки DHCP для работы с корпоративным DNS-сервером


Если вам необходимо, чтобы виртуальные машины разрешали имена в приватной корпоративной зоне DNS, используйте [опции DHCP](../../vpc/concepts/dhcp-options.md) в конфигурации [подсетей](../../vpc/operations/subnet-create.md). Например, для узлов подсети можно указать DNS-суффикс и DNS-сервер.

Для выполнения данного сценария у вас уже должен быть развернут корпоративный DNS-сервер, доступный для виртуальных машин в облаке. Вы можете также выполнить развертывание Active Directory, чтобы создать инфраструктуру с DNS-сервером:

* Облачную сеть `ad-network` с подсетями в разных [зонах доступности](../../overview/concepts/geo-scope.md):
  * `ad-subnet-a` (10.1.0.0/16);
  * `ad-subnet-b` (10.2.0.0/16);
  * `ad-subnet-c` (10.3.0.0/16);
* Контроллеры домена и бастионный хост:
  * `ad-vm-a` (10.1.0.3);
  * `ad-vm-b` (10.2.0.3);
  * `jump-server-vm` (10.3.0.x).

В рамках сценария вы добавите новую подсеть `10.128.0.0/24` с указанием DNS-суффикса и DNS-сервера, а также создадите ВМ и проверите работу сети.

Чтобы добавить подсеть с настройками DHCP:

* [Подготовьте облако к работе](#before-begin).
* [Создайте подсеть](#create-subnet).
* [Проверьте работу сети](#check-config).

Если инфраструктура вам больше не нужна, [удалите](#clear-out) созданные ресурсы.

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Чтобы полностью пройти данный сценарий, необходимо развернуть Active Directory. Если вы используете собственные DNS-серверы, доступные для виртуальных машин облака, указывайте в сценарии свои значения DNS-суффикса и IP-адресов.


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за объем дисков виртуальных машин (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамических или статических публичных IP-адресов (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* стоимость исходящего трафика из {{ yandex-cloud }} в интернет (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).



## Создайте подсеть {#create-subnet}

Чтобы создать новую подсеть с настройками DHCP, выполните следующее:

{% list tabs %}

- Консоль управления

	Чтобы создать подсеть:
	1. Откройте раздел **{{ vpc-name }}** в каталоге, где требуется создать подсеть.
	1. Нажмите на имя облачной сети `ad-network`.
	1. Нажмите кнопку **Добавить подсеть**.
	1. Заполните форму:
		* Укажите название подсети: `test-subnet-1`. Выберите зону доступности `{{ region-id }}-a`.
		* Введите CIDR подсети: `10.128.0.0/24`. Подробнее про диапазоны IP-адресов в подсетях читайте в разделе [Облачные сети и подсети](../../vpc/concepts/network.md).
	1. Задайте **Настройки DHCP**:
		* В поле **Доменное имя** укажите DNS-суффикс: `yantoso.net`.
		* В поле **Серверы доменных имен** нажмите кнопку **Добавить DNS-сервер** и укажите адрес DNS-сервера: `10.1.0.3`. Повторите то же для адреса `10.2.0.3`.
	1. Нажмите кнопку **Создать подсеть**.

- CLI

	{% include [include](../../_includes/cli-install.md) %}

	Выполните следующую команду:
	```
	yc vpc subnet create --name test-subnet-1 \
	    --description "My test subnet" \
	    --folder-id <id каталога> \
	    --network-name ad-network \
	    --zone {{ region-id }}-a \
	    --range 10.128.0.0/24 \
	    --domain-name yantoso.net \
	    --domain-name-server 10.1.0.3,10.2.0.3
	```

	Где `<id каталога>` — идентификатор каталога, в котором создаются ресурсы. Если каталог указан в профиле CLI, параметр можно не использовать.

	Результат:
	```
	id: e2ldy0b1prtj837re3fb
	folder_id: b1gbvco8fejm38siik76
	created_at: "2021-07-12T13:28:54Z"
	name: test-subnet-1
	description: My test subnet
	network_id: enpl0t90hept99f9hsh4
	zone_id: {{ region-id }}-a
	v4_cidr_blocks:
	- 10.128.0.0/24
	dhcp_options:
	  domain_name_servers:
	  - 10.1.0.3
	  - 10.2.0.3
	  domain_name: yantoso.net
	```

{% endlist %}

## Проверьте работу сети {#check-config}

Чтобы проверить конфигурацию, создайте ВМ и подключитесь к ней по RDP:

1. Подготовьте ВМ:

	{% list tabs %}
	
	- Консоль управления
	
		1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
		1. В поле **Имя** введите имя виртуальной машины: `vm-for-tests-in-subnet`.
		1. Выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`.
		1. В блоке **Выбор образа/загрузочного диска** нажмите Windows Server. В выпадающем списке выберите версию ОС **2016 Datacenter**.
		1. В блоке **Диски** укажите размер загрузочного диска 50 ГБ.
		1. В блоке **Вычислительные ресурсы**:
		      * Выберите [платформу](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
		      * Укажите необходимое количество vCPU и объем RAM:
		         * **vCPU** — 2.
		         * **Гарантированная доля vCPU** — 100%.
		         * **RAM** — 4 ГБ.
		      * При необходимости сделайте виртуальную машину [прерываемой](../../compute/concepts/preemptible-vm).
		1. В блоке **Сетевые настройки** выберите из списка подсеть `ad-network / test-subnet-1`.
		1. В блоке **Доступ** укажите данные для доступа на виртуальную машину:
		      * В поле **Пароль** укажите ваш пароль.
		1. Нажмите кнопку **Создать ВМ**.
	
	- CLI
	
		{% include [include](../../_includes/cli-install.md) %}
	
		Чтобы установить на виртуальной машине пароль, подготовьте файл metadata.yaml со следующим содержимым:
		```
		#ps1
		net user administrator '<пароль>'
		```

		Выполните команду, чтобы создать виртуальную машину:
		```
		yc compute instance create \
		    --name vm-for-tests-in-subnet \
		    --metadata-from-file user-data=metadata.yaml \
		    --zone {{ region-id }}-a \
		    --cores 2 \
		    --memory 4 \
		    --network-interface subnet-name=test-subnet-1,nat-ip-version=ipv4 \
		    --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk
		```

		Если команда выполнена успешно, сохраните IP-адрес из поля `one_to_one_nat`. Адрес будет использован на следующем шаге, чтобы создать подключение по RDP:

		```
		...
		status: RUNNING
		...
		primary_v4_address:
		  address: 10.128.0.26
		...
		one_to_one_nat:
		  address: 130.193.40.112
		  ip_version: IPV4
		...
		```

	{% endlist %}

1. Подождите несколько минут и [подключитесь к виртуальной машине](../../compute/operations/vm-connect/rdp.md) по RDP.

1. На виртуальной машине запустите PowerShell.

1. Чтобы посмотреть конфигурацию сети Windows, выполните команду:

	```
	ipconfig /all
	```

	Результат:
	```
	Windows IP Configuration
	
	   Host Name . . . . . . . . . . . . : epdpjtgc4i5eudo
	   Primary Dns Suffix  . . . . . . . :
	   Node Type . . . . . . . . . . . . : Hybrid
	   IP Routing Enabled. . . . . . . . : No
	   WINS Proxy Enabled. . . . . . . . : No
	   DNS Suffix Search List. . . . . . : yantoso.net
	
	Ethernet adapter Ethernet 2:
	
	   Connection-specific DNS Suffix  . : yantoso.net
	   Description . . . . . . . . . . . : Red Hat VirtIO Ethernet Adapter #2
	   Physical Address. . . . . . . . . : D0-0D-19-9F-60-C2
	   DHCP Enabled. . . . . . . . . . . : Yes
	   Autoconfiguration Enabled . . . . : Yes
	   Link-local IPv6 Address . . . . . : fe80::1f0:5a1e:76ea:3ded%3(Preferred)
	   IPv4 Address. . . . . . . . . . . : 10.128.0.11(Preferred)
	   Subnet Mask . . . . . . . . . . . : 255.255.255.0
	   Lease Obtained. . . . . . . . . . : Wednesday, July 14, 2021 11:00:09 AM
	   Lease Expires . . . . . . . . . . : Saturday, August 20, 2157 5:33:50 PM
	   Default Gateway . . . . . . . . . : 10.128.0.1
	   DHCP Server . . . . . . . . . . . : 10.128.0.2
	   DHCPv6 IAID . . . . . . . . . . . : 114298137
	   DHCPv6 Client DUID. . . . . . . . : 00-01-00-01-28-80-7B-90-D0-0D-19-9F-60-C2
	   DNS Servers . . . . . . . . . . . : 10.1.0.3
	                                       10.2.0.3
	   NetBIOS over Tcpip. . . . . . . . : Enabled
	
	Tunnel adapter isatap.yantoso.net:
	
	   Media State . . . . . . . . . . . : Media disconnected
	   Connection-specific DNS Suffix  . : yantoso.net
	   Description . . . . . . . . . . . : Microsoft ISATAP Adapter
	   Physical Address. . . . . . . . . : 00-00-00-00-00-00-00-E0
	   DHCP Enabled. . . . . . . . . . . : No
	   Autoconfiguration Enabled . . . . : Yes
	```

1. Проверьте, есть ли связь с контроллером домена `yantoso.net`. 

	Для этого выполните команду:
	```
	ping ad-vm-a
	```
	
	Результат в случае успешного соединения: 
	```
	PS C:\Users\Administrator> ping ad-vm-a
	
	Pinging ad-vm-a.yantoso.net [10.1.0.3] with 32 bytes of data:
	Reply from 10.1.0.3: bytes=32 time=1ms TTL=127
	Reply from 10.1.0.3: bytes=32 time<1ms TTL=127
	Reply from 10.1.0.3: bytes=32 time<1ms TTL=127
	Reply from 10.1.0.3: bytes=32 time<1ms TTL=127
	
	Ping statistics for 10.1.0.3:
	    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
	Approximate round trip times in milli-seconds:
	    Minimum = 0ms, Maximum = 1ms, Average = 0ms
	```

## Как удалить созданные ресурсы {#clear-out}

Чтобы освободить ресурсы, выполните следующие шаги:

1. Удалите виртуальную машину `vm-for-tests-in-subnet`.

	{% list tabs %}
	
	- Консоль управления
	
		1. Выберите каталог, которому принадлежит ВМ. 
		1. На дашборде каталога перейдите в сервис {{ compute-name }}.
		1. Выберите виртуальную машину → нажмите значок ![image](../../_assets/options.svg) → выберите пункт **Удалить**.
		1. Подтвердите удаление.
	
	- CLI
	
		{% include [include](../../_includes/cli-install.md) %}

		{% include [default-catalogue](../../_includes/default-catalogue.md) %}

		Для удаления ВМ выполните:
		```
		yc compute instance delete vm-for-tests-in-subnet
		```

	{% endlist %}

1. Удалите подсеть `test-subnet-1`.

	{% list tabs %}
	
	- Консоль управления
	
		1. Откройте раздел **{{ vpc-name }}** в каталоге, где требуется удалить подсеть.
		1. Нажмите на имя облачной сети, в которой находится подсеть: `ad-network`.
		1. Нажмите значок ![image](../../_assets/options.svg) в строке подсети `test-subnet-1`.
		1. В открывшемся меню нажмите кнопку **Удалить**.
		1. Подтвердите действие нажатием кнопки **Удалить**.
	
	- CLI

		{% include [include](../../_includes/cli-install.md) %}

		{% include [default-catalogue](../../_includes/default-catalogue.md) %}

		Чтобы удалить подсеть, выполните:
		```
		yc vpc subnet delete --name test-subnet-1
		```

	{% endlist %}

