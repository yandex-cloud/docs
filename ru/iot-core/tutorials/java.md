# Работа с {{ iot-full-name }} на языке Java

В этом сценарии вы узнаете, как подключиться к {{ iot-full-name }} с помощью библиотеки [Paho](https://www.eclipse.org/paho/clients/java/) на языке программирования Java. Данный сценарий предполагает, что вы имеете навыки разработки с использованием экосистемы Java.

{% note info %}

Исходный код, который используется в этом сценарии, доступен на [GitHub](https://github.com/yandex-cloud/examples/tree/master/iot/Samples/java).

{% endnote %}

После подключения вы сможете:
* [Отправлять сообщения](../operations/publish.md).
* [Подписывать устройство или реестр на получение сообщений](../operations/subscribe.md).

Чтобы подключиться к {{ iot-full-name }} и начать обмен сообщениями:
* [Подготовьтесь к работе](#before-you-begin)
* [Создайте необходимые ресурсы {{ iot-full-name }}](#resources)
    * [Создайте реестр и добавьте ему сертификат](#registry)
    * [Создайте устройство и добавьте ему сертификат](#device)
* [Подключитесь к {{ iot-full-name }}](#configure)
* [Авторизуйтесь в {{ iot-full-name }}](#auth)
    * [Авторизация с помощью сертификатов](#certs)
    * [Авторизация по логину и паролю](#log-pass)
* [Установите соединение](#connect)
* [Подпишитесь на топик и получайте сообщения](#subscribe)
* [Отправьте сообщение](#publish)
* [Завершите соединение](#disconnect)

## Подготовьтесь к работе {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите и инициализируйте его](../../cli/quickstart.md#install).
1. Скачайте и установите [Java Development Kit](https://www.oracle.com/java/technologies/javase-downloads.html).

## Создайте необходимые ресурсы {{ iot-full-name }} {#resources}

### Создайте реестр и добавьте ему сертификат {#registry}

Если у вас уже есть сертификат, начните со второго шага.

1. Создайте сертификат для реестра: 

   ```shell script
   openssl req -x509 \
     -newkey rsa:4096 \
     -keyout registry-key.pem \
     -out registry-cert.pem \
     -nodes \
     -days 365 \
     -subj '/CN=localhost'
   ```

1. Создайте реестр:

   ```shell script
   yc iot registry create --name my-registry
   ```

1. Добавьте сертификат реестру:

   ```shell script
   yc iot registry certificate add \
     --registry-name my-registry \ # Имя реестра.
     --certificate-file registry-cert.pem # Путь к публичной части сертификата.
   ```

### Создайте устройство и добавьте ему сертификат {#device}

Если у вас уже есть сертификат, начните со второго шага.

1. Создайте сертификат для устройства: 

   ```shell script
   openssl req -x509 \
     -newkey rsa:4096 \
     -keyout device-key.pem \
     -out device-cert.pem \
     -nodes \
     -days 365 \
     -subj '/CN=localhost'
   ```

1. [Посмотрите список реестров](../operations/registry/registry-list.md#registry-list), в которых можно создать устройство, или [создайте новый реестр](../operations/registry/registry-create.md).
1. Создайте устройство:

   ```shell script
   yc iot device create --registry-name my-registry --name my-device
   ```

1. Добавьте сертификат устройству:

   ```shell script
   yc iot device certificate add \
     --device-name my-device \ # Имя устройства.
     --certificate-file device-cert.pem # Путь к публичной части сертификата.
   ```

## Подключитесь к {{ iot-full-name }} {#configure}

Перед подключением настройте параметры соединения `connOpts` с помощью следующего кода:

```java
String clientId = "YandexIoTCoreTestJavaClient";
int keepAliveInterval = 60;
MqttClient client = new MqttClient("ssl://mqtt.cloud.yandex.net:8883", clientId);

// Установка обработчика асинхронных событий
client.setCallback(listener);

// Настройка параметров соединения.
MqttConnectOptions connOpts = new MqttConnectOptions();
connOpts.setKeepAliveInterval(keepAliveInterval);

```

Где:

* `MqttClient` — класс, в котором указываются параметры подключения к {{ iot-full-name }}:
    * Адрес и порт.
    * Идентификатор клиента.
* `MqttConnectOptions` — класс для установки параметров соединения. Вы можете оставить настройки по умолчанию, но рекомендуется задать параметр `keepAliveInterval`. От его значения зависит частота отправки команд `PINGREQ`. Чем меньше значение `keepAliveInterval`, тем быстрее клиент понимает, что соединение было разорвано нештатным путем. Но для этого чаще отправляются тарифицируемые команды `PINGREQ`.
* `listener` — класс, реализующий интерфейс `MqttCallback`. Он используется для обработки событий о потере связи с сервером (`connectionLost`), доставке сообщения (`deliveryComplete`) и получении нового сообщения (`messageArrived`).

## Авторизуйтесь в {{ iot-full-name }} {#auth}

Есть два способа [авторизации](../concepts/authorization.md):
* [С помощью X.509-сертификатов](#certs).
* [По логину и паролю](#log-pass).

### Авторизация с помощью сертификатов {#certs}

При авторизации с помощью X.509-сертификатов используются сертификаты в формате [PKCS#12](https://ru.wikipedia.org/wiki/PKCS12) (файлы с расширением .p12). Чтобы сгенерировать такой сертификат из PEM-сертификатов, выполните команду:

```shell script
openssl pkcs12 -export -in cert.pem -inkey key.pem -out keystore.p12
```

#### Структура файлов {#file-structure}

В примере, доступном на [GitHub](https://github.com/yandex-cloud/examples/tree/master/iot/Samples/java), сертификаты загружаются из файлов, организованных следующим образом:

```
  /my_registry        Директория реестра |текущая директория|. Пример нужно запускать из этой директории.
  `- /device          Директория устройства |device|.
  |  `- cert.pem      Сертификат устройства в PEM-формате.
  |  `- key.pem       Ключ устройства в PEM-формате.
  |  `- keystore.p12  Сертификат и ключ устройства в PKCS#12-формате.
  `- cert.pem         Сертификат реестра в PEM-формате.
  `- key.pem          Ключ реестра в PEM-формате.
  `- keystore.p12     Сертификат и ключ реестра в PKCS#12-формате.
```

#### Загрузка сертификатов {#cert-load}

Сертификат удостоверяющего центра задан в виде статической переменной `TRUSTED_ROOT`.

Для загрузки сертификатов в примере используется метод:
```java
private SSLSocketFactory getSocketFactoryWithCerts(String certsDir)
```

Загрузка сертификатов происходит в несколько этапов:
1. Загрузите сертификат, используемый для аутентификации сервера:

    ```java
    // Загрузка сертификата удостоверяющего центра из статической переменной `TRUSTED_ROOT`.
    InputStream is = new ByteArrayInputStream(TRUSTED_ROOT.getBytes(StandardCharsets.UTF_8));
    CertificateFactory cFactory = CertificateFactory.getInstance("X.509");
    X509Certificate caCert = (X509Certificate) cFactory.generateCertificate(is);
    
    // Использование сертификата удостоверяющего центра для аутентификации сервера.
    KeyStore tks = KeyStore.getInstance(KeyStore.getDefaultType());
    tks.load(null);
    tks.setCertificateEntry("caCert", caCert);
    TrustManagerFactory tmf = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
    tmf.init(tks);
    ```
1. Загрузите сертификат клиента, используемый для авторизации на сервере, из файла `keystore.p12`:

    ```java
    final char[] emptyPassword = "".toCharArray();
    KeyStore ks = KeyStore.getInstance("PKCS12");
    ks.load(new FileInputStream(Paths.get(certsDir, "keystore.p12").toString()), emptyPassword);
    KeyManagerFactory kmf = KeyManagerFactory.getInstance("SunX509");
    kmf.init(ks, emptyPassword);
    ```
1. Получите экземпляр класса `SSLSocketFactory`:
    ```java
    SSLContext ctx = SSLContext.getInstance("TLS");
    ctx.init(kmf.getKeyManagers(), tmf.getTrustManagers(), null);
    SSLSocketFactory sslSocketFactory = ctx.getSocketFactory();
    ```

После чего полученный выше экземпляр `sslSocketFactory` нужно передать в параметры соединения:

```java
connOpts.setSocketFactory(sslSocketFactory);
```

### Авторизация по логину и паролю {#log-pass}

Так как при авторизации по логину и паролю {{ iot-full-name }} требует TLS-протокол, то необходимо загрузить сертификат, используемый для аутентификации сервера:

```java
//Загружаем сертификат удостоверяющего центра из статической переменной `TRUSTED_ROOT`.
private SSLSocketFactory getSocketFactory()
                throws Exception {
    InputStream is = new ByteArrayInputStream(TRUSTED_ROOT.getBytes(StandardCharsets.UTF_8));
    CertificateFactory cFactory = CertificateFactory.getInstance("X.509");
    X509Certificate caCert = (X509Certificate) cFactory.generateCertificate(
            is);

    TrustManagerFactory tmf = TrustManagerFactory
            .getInstance(TrustManagerFactory.getDefaultAlgorithm());
    KeyStore tks = KeyStore.getInstance(KeyStore.getDefaultType());
    tks.load(null); // Вам не нужно загружать из файла экземпляр класса `KeyStore`.
    tks.setCertificateEntry("caCert", caCert);
    tmf.init(tks);

    SSLContext ctx = SSLContext.getInstance("TLS");
    ctx.init(null, tmf.getTrustManagers(), null);
    return ctx.getSocketFactory();
}

```

В настройках соединения укажите логин (идентификатор реестра или устройства) и пароль:

```java
connOpts.setUserName(login.trim());
connOpts.setPassword(password.trim().toCharArray());
```

и `sslSocketFactory`, получаемый из кода выше:

```java
SSLSocketFactory sslSocketFactory = getSocketFactory();
connOpts.setSocketFactory(sslSocketFactory);
```

## Установите соединение {#connect}

Установите соединение с {{ iot-full-name }} с помощью метода:

```java
client.connect(connOpts);
```

Метод `connect` является блокирующим. Выход из него происходит после завершения процесса установки соединения.

Для обработки события о потере связи с сервером вы можете использовать метод `connectionLost` интерфейса `MqttCallback`:

```java
@Override
public void connectionLost(Throwable cause) {
}
```

При этом установить обработчик событий (с помощью метода `setCallback`) необходимо до вызова метода `connect`:

```java
client.setCallback(listener);
...
client.connect(connOpts);
...
```

Где `listener` — класс, реализующий интерфейс `MqttCallback`.


## Подпишитесь на топик и получайте сообщения {#subscribe}

Подпишитесь на топик с помощью следующего кода. В методе `subscribe` нужно указать топик `topic`, на который вы хотите подписаться, и уровень качества обслуживания `qos`.

```java
client.subscribe(topic, qos);
```

Для обработки события о получении нового сообщения вы можете использовать метод `messageArrived` интерфейса `MqttCallback`:

```java
@Override
public void messageArrived(String topic, MqttMessage message){
}
```

При этом установить обработчик событий (с помощью метода `setCallback`) необходимо до вызова метода `connect`:

```java
client.setCallback(listener);
...
client.connect(connOpts);
...
```

Где `listener` — класс, реализующий интерфейс `MqttCallback`.

Также для обработки события о получении нового сообщения вы можете использовать метод `messageArrived` интерфейса `IMqttMessageListener`:

```java
client.subscribe(topic, qos, messageListener);
```

Где `messageListener` — класс, реализующий интерфейс `IMqttMessageListener`.



## Отправьте сообщение {#publish}

Отправьте сообщение с помощью следующего кода. В методе `publish` нужно указать топик `topic`, в который вы хотите отправить сообщение, и текст сообщения с помощью класса `MqttMessage`. При необходимости можно указать желаемый уровень качества обслуживания `qos` для экземпляра класса `MqttMessage`.

```java
MqttMessage msg = new MqttMessage(message);
msg.setQos(qos);
client.publish(topic, msg);
```

Для обработки события о доставке сообщения вы можете использовать метод `deliveryComplete` интерфейса `MqttCallback`:

```java
@Override
public void deliveryComplete(IMqttDeliveryToken token) {
}
```

При этом установить обработчик событий (с помощью метода `setCallback`) необходимо до вызова метода `connect`:

```java
client.setCallback(listener);
...
client.connect(connOpts);
...
```

Где `listener` — класс, реализующий интерфейс `MqttCallback`.


## Завершите соединение {#disconnect}

Завершите соединение с {{ iot-full-name }} с помощью методов:

```java
client.disconnect();
client.close();
```

Где:

* Метод `disconnect` закрывает соединение с сервером. 
* Метод `close` освобождает ресурсы класса `MqttClient`.
