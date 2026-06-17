# Поля ресурса YCCertificate

Ресурс `YCCertificate` содержит параметры сертификата Certificate Manager для настройки TLS-соединений в ресурсе `Gateway`.

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](gwin-index.md).

{% endnote %}

## YCCertificate {#yc-certificate}

```yaml
apiVersion: gwin.yandex.cloud/v1
kind: YCCertificate
metadata:
  name: <string>
  namespace: <string>
spec: <YCCertificateSpec>
```

Где:

* `apiVersion`: `gwin.yandex.cloud/v1`
* `kind`: `YCCertificate`
* `metadata` (`ObjectMeta`, обязательное)

  Метаданные ресурса.

  * `name` (`string`, обязательное)

    Имя ресурса. Подробнее о формате смотрите в [документации Kubernetes](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

  * `namespace` (`string`)

    [Пространство имен](../concepts/index.md#namespace), к которому относится ресурс. Значение по умолчанию — `default`.

* `spec` (`YCCertificateSpec`, обязательное)

  Спецификация ресурса. Подробности [ниже](#spec).

## YCCertificateSpec {#spec}

```yaml
certificateRef:
  certificateID: <string>
  certificateName: <string>
  folderID: <string>
```

Где:

* `certificateRef` (обязательное)

  Параметры сертификата Certificate Manager. Вы можете задать либо `certificateID`, либо `certificateName` и `folderID`. Если каталог сертификата совпадает с каталогом размещения балансировщика, вы можете задать только `certificateName`.

  * `certificateID` (`string`)
  
    Идентификатор сертификата.

  * `certificateName` (`string`)
  
    Имя сертификата. Используется вместе с параметром `folderID`. Если каталог сертификата совпадает с каталогом размещения балансировщика, вы можете задать только `certificateName`.

  * `folderID` (`string`)
  
    Каталог размещения сертификата. Используется вместе с параметром `certificateName`.