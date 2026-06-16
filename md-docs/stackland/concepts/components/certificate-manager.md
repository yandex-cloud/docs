# Certificate Manager

Компонент Certificate Manager отвечает за управление сертификатами, используемыми при межсервисном взаимодействии. Для управления сертификатами доступны два глобальных эмитента (`kind: ClusterIssuer`): Default CA Issuer (`stackland-default`) и Let's Encrypt HTTP01 (`stackland-letsencrypt`). Оба эмитента построены на наработках открытого проекта [cert-manager](https://cert-manager.io/).

## Default CA Issuer

Данный эмитент включен по умолчанию и не подлежит настройке. В случае если при установке Stackland был указан промежуточный CA (подробнее в разделе [Начало работы](../../quickstart.md#prepare-image)), сгенерированные сертификаты будут удостоверены им. В противном случае генерируются самоподписанные сертификаты.

## Let's Encrypt HTTP01

Сертификат удостоверяющего центра (CA) [Let's Encrypt](https://letsencrypt.org/ru/) распознается как доверенный всеми современными браузерами, поэтому данный вариант подойдет для сервисов, к которым ожидается подключение извне организации.

Let's Encrypt поддерживает несколько способов подтверждения владения доменом. В Certificate Manager поддержан самый распространенный — HTTP01. Все необходимое взаимодействие с удостоверяющим центром происходит автоматически и не требует вовлечения администратора кластера Stackland.

Эмитент Let's Encrypt HTTP01 выключен по умолчанию и требует дополнительной настройки перед использованием. Для этого нужно отредактировать глобальный ресурс `CertificateManagerConfig` и внести изменения в блок `clusterIssuers`, который должен выглядеть следующим образом:

```yaml
clusterIssuers:
  letsencryptHttp01:
    enabled: true                              # Включить поддержку Let's Encrypt HTTP01
    email: your-email@example.com              # Действительный адрес электронной почты, на который будут приходить уведомления Let's Encrypt
```

В процессе настройки в секрете `letsencrypt-private-key` в пространстве имен `stackland-certificate-manager` будет автоматически сохранен приватный ключ, предназначенный для взаимодействия с сервисом Let's Encrypt. При утере этого ключа отозвать сертификат, выпущенный Certificate Manager для домена, будет невозможно.

## Выпуск сертификата

Чтобы выпустить сертификат, создайте ресурс `Certificate`, указав желаемый тип эмитента: `stackland-default` для Default CA Issuer или `stackland-letsencrypt` для Let's Encrypt HTTP01. Кроме того, необходимо указать домен, для которого выписывается сертификат:

```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: my-public-cert
  namespace: default
spec:
  secretName: my-public-tls      # секрет, в котором будет сохранен сгенерированный приватный ключ
  issuerRef:
    name: stackland-letsencrypt  # или stackland-default
    kind: ClusterIssuer
  dnsNames:
  - app.example.com              # домен, для которого выписывается сертификат
```

В случае использования Let's Encrypt HTTP01, домен должен быть внешним, т.е. разрешаемым за пределами сети организации.

Можно также автоматически выписать сертификат для некоторого сервиса (`Ingress`), используя аннотации:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app
  annotations:
    cert-manager.io/cluster-issuer: stackland-letsencrypt  # или stackland-default
spec:
  tls:
  - hosts:
    - app.example.com       # домен, для которого выписывается сертификат
    secretName: my-app-tls  # секрет, в котором будет сохранен сгенерированный приватный ключ
  rules:
  - host: app.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-app
            port:
              number: 80
```