# Fixing the `Failed authentication with /` error


## Issue description {#issue-description}

You see the following errors in {{ mkf-full-name }} cluster logs:

```
{
 hostname: "[rc1c-sjg**************.mdb.yandexcloud.net](http://rc1c-sjg**************.mdb.yandexcloud.net/)",
 message: "\[SocketServer listenerType=ZK_BROKER, nodeId=1\] 
 Failed authentication with /10.X.X.X (channelId=10.X.X.X:9091-10.X.X.Y:43598-3694) 
 (SSL handshake failed) (org.apache.kafka.common.network.Selector)",
 origin: "kafka_server",
 severity: "INFO"
 }
```

## Solution {#issue-resolution}

Such errors mean there are connection issues on the application side. Check the logs and settings of the application running on the `10.Х.Х.Х` host for errors.

Typical causes involve incorrect protocol configuration, certificate, or authentication secrets for the {{ KF }} cluster. For example, the `SSL handshake failed` error points to SSL or TLS certificate issues.