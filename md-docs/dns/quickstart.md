# Как начать работать с Cloud DNS


Создайте [зоны DNS](concepts/dns-zone.md), добавьте в них `A`-записи для ваших тестовых [виртуальных машин](../compute/concepts/vm.md) и протестируйте доступность доменных имен.

## Перед началом работы {#before-begin}

1. Войдите в [консоль управления](https://console.yandex.cloud) или зарегистрируйтесь. Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. На странице [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если у вас еще нет [каталога](../resource-manager/concepts/resources-hierarchy.md#folder), [создайте его](../resource-manager/operations/folder/create.md). Во время создания каталога вы можете создать [виртуальную сеть](../vpc/concepts/network.md#network) по умолчанию с [подсетями](../vpc/concepts/network.md#subnet) во всех [зонах доступности](../overview/concepts/geo-scope.md).
1. [Создайте сеть](../vpc/quickstart.md) и подсети для подключения тестовых ВМ.
1. [Создайте](../compute/operations/vm-create/create-linux-vm.md) ВМ `test-vm-1` и `test-vm-2` в зоне доступности `ru-central1-a`. У ВМ `test-vm-1` должен быть [публичный IP-адрес](../vpc/concepts/address.md#public-addresses). Подключите их к подсетям одной сети.

## Создайте внутреннюю зону DNS {#create-private-zone}

В доменной зоне будут храниться [ресурсные записи](concepts/resource-record.md).

Создайте новую доменную зону:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте раздел **Cloud DNS** в каталоге, где требуется создать зону DNS.
  1. Нажмите кнопку **Создать зону**.
  1. Задайте настройки зоны:
     1. **Зона**: `testing`.
     1. **Тип**: `Внутренняя`.
     1. **Имя**: `test-zone`.
     1. **Сети**: сеть, в которой находятся ваши ВМ. 
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc dns zone create --name test-zone \
  --zone testing. \
  --private-visibility network-ids=<идентификатор_сети>
  ```

  Где `--private-visibility` — идентификатор сети с тестовыми ВМ.

{% endlist %}

### Добавьте во внутреннюю зону ресурсные записи {#add-private-resource-records}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте список зон и выберите зону `test-zone`.
  1. Выберите **Записи** в меню слева.
  1. Нажмите кнопку **Создать запись**. Задайте параметры записи:
     1. **Имя**: `test-vm-1`.
     1. **Тип**: `А`.
     1. **TTL (в секундах)**: `600`.
     1. **Значение**: [внутренний IP-адрес](../vpc/concepts/address.md#internal-addresses) ВМ `test-vm1`.
  1. Нажмите кнопку **Создать**.
  1. Нажмите кнопку **Создать запись** еще раз. Задайте параметры еще одной записи:
     1. **Имя**: `test-vm-2`.
     1. **Тип**: `А`.
     1. **TTL (в секундах)**: `600`.
     1. **Значение**: внутренний IP-адрес ВМ `test-vm2`.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Выполните команды:

  ```bash
  yc dns zone add-records --name test-zone \
  --record "test-vm-1 600 A <внутренний_IP-адрес_ВМ>"
  ```

  Где `--record` — запись, содержащая внутренний IP-адрес ВМ `test-vm-1`.

  ```bash
  yc dns zone add-records --name test-zone \
  --record "test-vm-2 600 A <внутренний_IP-адрес_ВМ>"
  ```

  Где `--record` — запись, содержащая внутренний IP-адрес ВМ `test-vm-2`.

{% endlist %}

### Протестируйте доступность имен во внутренней зоне {#test-private-resolving}

Подключитесь к `test-vm-1` через [SSH](../glossary/ssh-keygen.md):

```bash
ssh <публичный_IP-адрес_ВМ>
```

На ВМ попробуйте обратиться к `test-vm-2` по ее [доменному имени](../vpc/concepts/address.md#fqdn):

```bash
host test-vm-2.testing.
```

Убедитесь, что в ответ возвращается IP-адрес нужной ВМ:

```bash
host test-vm-2.testing.
test-vm-2.testing has address 10.0.0.9
```

## Создайте публичную зону DNS {#create-public-zone}

Если у вас есть зарегистрированное доменное имя, вы можете создать публичную доменную зону и добавить в нее запись. В примере будет использоваться доменное имя `example.com`.

Создайте новую публичную доменную зону:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте раздел **Cloud DNS** в каталоге, где требуется создать зону DNS.
  1. Нажмите кнопку **Создать зону**.
  1. Задайте настройки зоны:
     1. **Зона**: `example.com.`
     1. **Тип**: `Публичная`.
     1. **Имя**: `test-public-zone`.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc dns zone create --name test-public-zone \
  --zone example.com. \
  --public-visibility
  ```

{% endlist %}

### Добавьте в публичную зону ресурсные записи {#add-public-resource-records}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте список зон и выберите зону `test-public-zone`.
  1. Выберите **Записи** в меню слева.
  1. Нажмите кнопку **Создать запись**. Задайте параметры записи:
     1. **Имя**: `www`.
     1. **Тип**: `А`.
     1. **TTL (в секундах)**: `600`.
     1. **Значение**: публичный IP-адрес ВМ `test-vm-1`.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc dns zone add-records --name test-public-zone \
  --record "www 600 A <публичный_IP-адрес_ВМ>"
  ```

  Где `--record` — запись, содержащая публичный IP-адрес ВМ `test-vm-1`.

{% endlist %}

Делегируйте ваше доменное имя, указав адреса серверов имен `ns1.yandexcloud.net.` и `ns2.yandexcloud.net.` Yandex Cloud у вашего регистратора.

### Протестируйте доступность имен в публичной зоне {#test-public-resolving}

Убедитесь, что созданная запись указывает на публичный IP-адрес ВМ. На вашем компьютере выполните команду:

```bash
host www.example.com ns1.yandexcloud.net.
```

Результат:

```text
Using domain server:
Name: ns1.yandexcloud.net.
Address: 84.201.185.208#53
Aliases:

www.example.com has address <публичный_IP-адрес_ВМ_test-vm-1>
```