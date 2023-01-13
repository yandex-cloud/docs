# Working with {{ iot-full-name }} from an Android device in Java

In this scenario, you'll learn how to connect to {{ iot-full-name }} from an Android device using the [Paho](https://www.eclipse.org/paho/) library and Java programming language. It assumes that you know how to develop Android apps in Java using Android Studio.

{% note info %}

The source code used in this scenario is available on [GitHub](https://github.com/yandex-cloud/examples/tree/master/iot/Samples/java_android/YandexIoTCoreConnectionExample).

{% endnote %}

Once connected, you can exchange messages between your device and registry:

* [Send messages](../operations/publish.md).
* [Subscribe a device or registry to receive messages](../operations/subscribe.md).

To connect to {{ iot-full-name }} and start messaging:

* [Before you start](#before-you-begin)
* [Create the necessary {{ iot-full-name }} resources](#resources)
    * [Create a registry and add a certificate to it](#registry)
    * [Create a device and add a certificate to it](#device)
* [Connect to {{ iot-full-name }}](#connect)
* [Log in to {{ iot-full-name }}](#auth)
    * [Authorization using X.509 certificates](#certs)
    * [Authorization using a username and password](#log-pass)
* [Establish a connection](#connect)
* [Subscribe to a topic and get data messages](#subscribe)
* [Send a data message](#publish)
* [Terminate the connection](#disconnect)

## Before you start {#before-you-begin}

1. If you don't have the {{ yandex-cloud }} command line interface yet, [install and initialize it](../../cli/quickstart.md#install).
1. Download and install [Android Studio](https://developer.android.com/studio), a development environment for Android.

## Create the necessary {{ iot-full-name }} resources{#resources}

### Create a registry and add a certificate to it {#registry}

If you already have a certificate, go directly to the second step.

1. Create a certificate for the registry (skip this step if you already have a registry certificate):

   ```shell script
    openssl req -x509 \
      -newkey rsa:4096 \
      -keyout registry-key.pem \
      -out registry-cert.pem \
      -nodes \
      -days 365 \
      -subj '/CN=localhost'
   ```

1. Create a registry:

    ```
    yc iot registry create --name my-registry
    ```

1. Add a certificate to the registry:

    ```
    yc iot registry certificate add \
      --registry-name my-registry \ # Registry name.
      --certificate-file registry-cert.pem # Path to the public part of the certificate.
    ```

### Create a device and add a certificate to it {#device}

If you already have a certificate, go directly to the second step.

1. (optional) Create a certificate for the device:

   ```shell script
    openssl req -x509 \
      -newkey rsa:4096 \
      -keyout device-key.pem \
      -out device-cert.pem \
      -nodes \
      -days 365 \
      -subj '/CN=localhost'
   ```

1. Create a device:

    ```
    yc iot device create --name my-device
    ```

1. Add a certificate to the device:

    ```
    yc iot device certificate add \
      --device-name my-device \ # Device name.
      --certificate-file device-cert.pem # Path to the public part of the certificate.
    ```

## Connect to {{ iot-full-name }} {#connect}

Before connecting, configure the connection parameters using the following code:

```java
String clientId = "YandexIoTCoreAndroidTextClient";  
int connectionTimeout = 60;
int keepAliveInterval = 60;      
MqttAndroidClient mqttAndroidClient = new MqttAndroidClient(getApplicationContext(),"ssl://mqtt.cloud.yandex.net:8883", clientId);

// Setting up the connection parameters.
MqttConnectOptions options = new MqttConnectOptions();
options.setKeepAliveInterval(keepAliveInterval);
```

Where:

* `MqttAndroidClient` is a class that specifies the {{ iot-full-name }} connection parameters. Client address, port, and ID.
* `MqttConnectOptions` is a class that sets the connection options. You can use the default settings, but we recommend setting the `keepAliveInterval` parameter. Its value determines the frequency of sending `PINGREQ` commands. The lower this parameter value, the faster the client realizes that a connection terminated abnormally. However, this increases the frequency of sending payable `PINGREQ` commands.

## Log in to {{ iot-full-name }} {#auth}

There are two [authorization](../concepts/authorization.md) methods:

* [Using X.509 certificates](#certs).
* [Using a username and password](#log-pass).

### Authorization using X.509 certificates {#certs}

For this type of authorization, it's most convenient to use [PKCS#12](https://en.wikipedia.org/wiki/PKCS12) certificates in PFX format. You can generate a certificate in PKCS#12 format from PEM certificates using the command:

```shell script
openssl pkcs12 -export -in cert.pem -inkey key.pem -out keystore.p12
```

To load certificates in your project, use the following method:

```java
private SSLSocketFactory getSocketFactory(final InputStream caCrtFile, final InputStream devCert, final String password)
```

Certificates are loaded in several stages:

1. Load the certificate used for server authentication:

    ```java
    // Loading the CA certificate.
    CertificateFactory cf = CertificateFactory.getInstance("X.509");
    X509Certificate caCert = (X509Certificate) cf.generateCertificate(caCrtFile);
    
    // Using the CA certificate for server authentication.
    KeyStore serverCaKeyStore = KeyStore.getInstance(KeyStore.getDefaultType());
    serverCaKeyStore.load(null, null);
    serverCaKeyStore.setCertificateEntry("ca", caCert);
    TrustManagerFactory tmf = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
    tmf.init(serverCaKeyStore);
    ```

1. Load the client certificate used for server authorization:

    ```
    KeyStore clientKeystore = KeyStore.getInstance("PKCS12");
    clientKeystore.load(devCert, password.toCharArray());
    ```

As a result, the method returns `AdditionalKeyStoresSSLSocketFactory`:

```
return new AdditionalKeyStoresSSLSocketFactory(clientKeystore, serverCaKeyStore);
```

The `AdditionalKeyStoresSSLSocketFactory` class is inherited from `SSLSocketFactory` and used for working with self-signed certificates. At the last stage, pass the obtained `sslSocketFactory` instance to the connection parameters:

```
options.setSocketFactory(sslSocketFactory);
```

### Authorization using a username and password {#log-pass}

Since {{ iot-full-name }} requires the TLS protocol for authorization with a username and password, initialize the `AdditionalKeyStoresSSLSocketFactory` class by invoking the method:

```java
private SSLSocketFactory getSocketFactory(final InputStream caCrtFile, final InputStream devCert, final String password)
```

Pass the `null` value as `devCert`. This only loads the certificate from the server certification authority:

```java
// Load CA certificate    
CertificateFactory cf = CertificateFactory.getInstance("X.509");
        X509Certificate caCert = (X509Certificate) cf.generateCertificate(caCrtFile);

// CA certificate is used to authenticate server
KeyStore serverCaKeyStore = KeyStore.getInstance(KeyStore.getDefaultType());
serverCaKeyStore.load(null, null);
serverCaKeyStore.setCertificateEntry("ca", caCert);
TrustManagerFactory tmf = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
tmf.init(serverCaKeyStore);

return new AdditionalKeyStoresSSLSocketFactory(null, serverCaKeyStore);
```

In the connection settings, specify the username (registry or device ID) and password:

```java
options.setUserName(mqttUserName);
options.setPassword(mqttPassword.toCharArray());
```

and the `SSLSocketFactory` from the code above:

```java
options.setSocketFactory(sslSocketFactory);
```

## Establish a connection {#connect}

Establish a connection to {{ iot-full-name }} using the following code:

```
mqttAndroidClient.connect(options,null, new IMqttActionListener() {
   @Override
   public void onSuccess(IMqttToken asyncActionToken) {
   }

   @Override
   public void onFailure(IMqttToken asyncActionToken, Throwable exception) {
   }
});
```

## Subscribe to a topic and get data messages {#subscribe}

Use a callback function to process the received data:

```
mqttAndroidClient.setCallback(new MqttCallback() {
   @Override
   public void messageArrived(String topic, MqttMessage message) throws Exception {   }
});
```

Subscribe to a topic using the following code. In the `subscribe` method, specify the topic that you want to subscribe to and the QoS.

```java
IMqttToken subToken = mqttAndroidClient.subscribe(topic, qos);
subToken.setActionCallback(new IMqttActionListener() {
   @Override
   public void onSuccess(IMqttToken asyncActionToken) {
       // Publishing a message.
   }

   @Override
   public void onFailure(IMqttToken asyncActionToken,
                         Throwable exception) {
       // The message can't be subscribed to. The user may not have been
       // authorized to subscribe to the specified topic.
       System.out.println("Failed to subscribe");
   }
});
```

## Send a data message {#publish}

Send messages using the following code. In the `publish` method, specify the topic that you want to send a message to and the message text. You can optionally specify the desired level of quality of service for a `MqttMessage` class instance.

```
IMqttDeliveryToken publish = mqttAndroidClient.publish("<topic>", new MqttMessage("Your message text.".getBytes()));
```

Handle connection loss events and track message delivery using callback functions:

```
mqttAndroidClient.setCallback(new MqttCallback() {
   @Override
   public void connectionLost(Throwable cause) {

   }
, MqttMessage message) throws Exception {   }

   @Override
   public void deliveryComplete(IMqttDeliveryToken token) {

   }
});
```

## Terminate the connection {#disconnect}

Disconnect from {{ iot-full-name }} using the following methods:

```
mqttAndroidClient.disconnect();
mqttAndroidClient.close();
```

Where:

* The `disconnect` method terminates the server connection.
* The `close` method releases `MqttAndroidClient` class resources.

