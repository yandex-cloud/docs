# Поля ресурса YCCertificate

Ресурс `YCCertificate` содержит параметры сертификата {{ certificate-manager-name }} для настройки TLS-соединений в ресурсе `Gateway`.

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

    Имя ресурса. Подробнее о формате см. в [документации {{ k8s }}](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

  * `namespace` (`string`)

    [Пространство имен](../../../managed-kubernetes/concepts/index.md#namespace), к которому относится ресурс. Значение по умолчанию — `default`.

* `spec` (`YCCertificateSpec`, обязательное)

  Спецификация ресурса. Подробнее см. [ниже](#spec).

## YCCertificateSpec {#spec}

```yaml
certificateRef:
  certificateID: <string>
  certificateName: <string>
  folderID: <string>
```

Где:

* `certificateRef` (обязательное)

  Параметры сертификата {{ certificate-manager-name }}. Вы можете задать либо `certificateID`, либо `certificateName` и `folderID`. Если каталог сертификата совпадает с каталогом размещения балансировщика, вы можете задать только `certificateName`.

  * `certificateID` (`string`)
  
    Идентификатор сертификата.

  * `certificateName` (`string`)
  
    Имя сертификата. Используется вместе с параметром `folderID`. Если каталог сертификата совпадает с каталогом размещения балансировщика, вы можете задать только `certificateName`.

  * `folderID` (`string`)
  
    Каталог размещения сертификата. Используется вместе с параметром `certificateName`.
