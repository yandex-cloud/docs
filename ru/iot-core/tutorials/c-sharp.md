# Работа с {{ iot-full-name }} на языке C#

В этом сценарии вы узнаете, как подключиться к {{ iot-full-name }} с помощью библиотеки [Paho](https://www.eclipse.org/paho/clients/dotnet/) на языке программирования С\#. Данный сценарий предполагает, что вы имеете навыки разработки с использованием платформы .NET на языке C\#.

{% note info %}

Исходный код, который используется в этом сценарии, доступен на [GitHub](https://github.com/yandex-cloud/examples/tree/master/iot/Samples/c%23/). Взаимодействие с {{ iot-full-name }} инкапсулировано в классе [YaClient](https://github.com/yandex-cloud/examples/blob/master/iot/Samples/c%23/YaClient.cs), который вы можете использовать в своих проектах.

{% endnote %}

После подключения вы сможете:
* [Отправлять сообщения](../operations/publish.md).
* [Подписывать устройство или реестр на получение сообщений](../operations/subscribe.md).

Чтобы подключиться к {{ iot-full-name }} и начать обмен сообщениями:
* [Подготовьтесь к работе](#before-you-begin)
* [Создайте необходимые ресурсы {{ iot-full-name }}](#resources)
    * [Создайте реестр и добавьте ему сертификат](#registry)
    * [Создайте устройство и добавьте ему сертификат](#device)
* [Подключитесь к {{ iot-full-name }}](#connect)
* [Авторизуйтесь в {{ iot-full-name }}](#auth)
    * [Авторизация с помощью сертификатов](#certs)
    * [Авторизация по логину и паролю](#log-pass)
* [Установите соединение](#establish-connection)
* [Подпишитесь на топик и получайте сообщения](#subscribe)
* [Отправьте сообщение](#publish)
* [Завершите соединение](#disconnect)

## Подготовьтесь к работе {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите и инициализируйте его](../../cli/quickstart.md#install).
1. Скачайте и установите среду разработки для платформы .Net. Например, [Microsoft Visual Studio](https://visualstudio.microsoft.com/ru/vs/).

## Создайте необходимые ресурсы {{ iot-full-name }} {#resources}

### Создайте реестр и добавьте ему сертификат {#registry}

Если у вас уже есть сертификат, начните со второго шага.

1. Создайте сертификат для реестра (пропустите этот шаг, если у вас уже есть сертификат реестра): 
    
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

1. (опционально) Создайте сертификат для устройства: 
    
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

## Подключитесь к {{ iot-full-name }} {#connect}

Перед подключением настройте параметры соединения с помощью следующего кода:

```C#
// Настройка TLS-соединения
MqttClientOptionsBuilderTlsParameters tlsOptions = new MqttClientOptionsBuilderTlsParameters
{
  SslProtocol = SslProtocols.Tls12,
  UseTls = true
};

// Подключение обработчика для валидации сервера
tlsOptions.CertificateValidationCallback += CertificateValidationCallback;

// Настройка параметров соединения
var options = new MqttClientOptionsBuilder()
    .WithClientId($"Test_C#_Client_{Guid.NewGuid()}")
    .WithTcpServer(MqttServer, MqttPort)
    .WithTls(tlsOptions)
    .WithCleanSession()
    .WithCredentials(id, password)
    .WithKeepAlivePeriod(TimeSpan.FromSeconds(90))
    .WithKeepAliveSendInterval(TimeSpan.FromSeconds(60))
    .Build();

var factory = new MqttFactory();
IMqttClient mqttClient = factory.CreateMqttClient();

// Подключение обработчика события о получении данных
mqttClient.UseApplicationMessageReceivedHandler(DataHandler);

// Подключение обработчика события о соединении с {{ iot-full-name }}
mqttClient.UseConnectedHandler(ConnectedHandler);

// Подключение обработчика события о потери связи с {{ iot-full-name }}
mqttClient.UseDisconnectedHandler(DisconnectedHandler);
```

Где:

* `MqttClientOptionsBuilderTlsParameters` — класс, в котором указываются параметры использования TLS при подключении к {{ iot-full-name }}.
* `MqttClientOptionsBuilder` — класс-конструктор для установки параметров соединения. Вы можете оставить настройки по умолчанию, но рекомендуется задать параметры `WithKeepAlivePeriod` и `WithKeepAliveSendInterval`. От значения этих параметров зависит:
    * Частота отправки команд `PINGREQ`.
    * Время реакции клиента на обрыв соединения. 
    
        Чем меньше значения указанных параметров, тем быстрее клиент понимает, что соединение было разорвано нештатным путем. Но для этого чаще отправляются тарифицируемые команды `PINGREQ`.

## Авторизуйтесь в {{ iot-full-name }} {#auth}

Есть два способа [авторизации](../concepts/authorization.md):
* [С помощью X.509-сертификатов](#certs).
* [По логину и паролю](#log-pass).

### Авторизация с помощью сертификатов {#certs}

При авторизации с помощью X.509-сертификатов удобнее всего использовать сертификаты [PKCS#12](https://ru.wikipedia.org/wiki/PKCS12) в PFX-формате. Чтобы сгенерировать сертификат в PKCS#12-формате из PEM-сертификатов, выполните команду:

```shell script
openssl pkcs12 -export -out cert.pfx -inkey key.pem -in cert.pem
```

Для загрузки сертификатов в проекте используйте следующий код:

```C#
X509Certificate2 certificate = new X509Certificate2(certPath);
```

Сертификат клиента, применяемый для авторизации на сервере, указывается при настройке TLS-соединения:

```C#
X509Certificate2 certificate = new X509Certificate2(certPath);
List<byte[]> certificates = new List<byte[]>();
certificates.Add(certificate.Export(X509ContentType.SerializedCert));

// Настройка TLS-соединения
MqttClientOptionsBuilderTlsParameters tlsOptions = new MqttClientOptionsBuilderTlsParameters
{
  Certificates = certificates,
  SslProtocol = SslProtocols.Tls12,
  UseTls = true
};
```

Сертификат, применяемый для аутентификации сервера, используется в обработчике для валидации сервера:

```C#
private static X509Certificate2 rootCrt = new X509Certificate2("rootCA.crt");

private static bool CertificateValidationCallback(X509Certificate cert, X509Chain chain, SslPolicyErrors errors, IMqttClientOptions opts)
{
  try
  {
    if (errors == SslPolicyErrors.None)
    {
      return true;
    }

    if (errors == SslPolicyErrors.RemoteCertificateChainErrors)
    {
      chain.ChainPolicy.RevocationMode = X509RevocationMode.NoCheck;
      chain.ChainPolicy.VerificationFlags = X509VerificationFlags.NoFlag;
      chain.ChainPolicy.ExtraStore.Add(rootCrt);

      chain.Build((X509Certificate2)rootCrt);
      // Сравнение отпечатков сертификатов
      var res = chain.ChainElements.Cast<X509ChainElement>().Any(a => a.Certificate.Thumbprint == rootCrt.Thumbprint);
      return res;
    }
  }
  catch { }

  return false;
}
```

### Авторизация по логину и паролю {#log-pass}

При авторизации по логину и паролю в {{ iot-full-name }} требуется TLS-протокол. Для этого используйте класс `MqttClientOptionsBuilderTlsParameters`:

```C#
// Настройка TLS-соединения
MqttClientOptionsBuilderTlsParameters tlsOptions = new MqttClientOptionsBuilderTlsParameters
{
  SslProtocol = SslProtocols.Tls12,
  UseTls = true
};

// Подключение обработчика для валидации сервера
tlsOptions.CertificateValidationCallback += CertificateValidationCallback;
```

В настройках соединения с помощью метода `WithCredentials` укажите логин `id` (идентификатор реестра или устройства) и пароль `password`:

```C#
// Настройка параметров соединения
var options = new MqttClientOptionsBuilder()
    .WithClientId($"Test_C#_Client_{Guid.NewGuid()}")
    .WithTcpServer(MqttServer, MqttPort)
    .WithTls(tlsOptions)
    .WithCleanSession()
    .WithCredentials(id, password)
    .WithKeepAlivePeriod(TimeSpan.FromSeconds(90))
    .WithKeepAliveSendInterval(TimeSpan.FromSeconds(60))
    .Build();
```

## Установите соединение {#establish-connection}

Установите соединение с {{ iot-full-name }} с помощью следующего кода:

```C#
mqttClient.ConnectAsync(options, CancellationToken.None);
```

## Подпишитесь на топик и получайте сообщения {#subscribe}

Для получения сообщений используйте функцию обратного вызова: 

```C#
...
  mqttClient.UseApplicationMessageReceivedHandler(DataHandler);
...

private Task DataHandler(MqttApplicationMessageReceivedEventArgs arg)
{
  return Task.CompletedTask;
}
```

Подпишитесь на топик с помощью следующего кода. В методе `SubscribeAsync` нужно указать топик `topic`, на который вы хотите подписаться, и уровень качества обслуживания `qos`.

```C#
mqttClient.SubscribeAsync(topic, qos);
```

## Отправьте сообщение {#publish}

Отправьте сообщение с помощью следующего кода. В методе `PublishAsync` нужно указать топик `topic`, в который вы хотите отправить сообщение, текст сообщения и желаемый уровень качества обслуживания `qos`.

```C#
mqttClient.PublishAsync(topic, "Ваш текст сообщения.", qos);
```

Обрабатывайте события о потере связи и отслеживайте доставку сообщений с помощью функций обратного вызова:

```C#
...
  mqttClient.UseConnectedHandler(ConnectedHandler);
  mqttClient.UseDisconnectedHandler(DisconnectedHandler);
...

private Task ConnectedHandler(MqttClientConnectedEventArgs arg)
{
  return Task.CompletedTask;
}

private static Task DisconnectedHandler(MqttClientDisconnectedEventArgs arg)
{
  return Task.CompletedTask;
}
```

## Завершите соединение {#disconnect}

Завершите соединение с {{ iot-full-name }} с помощью следующего кода:

```C#
mqttClient.DisconnectAsync();
```
