### Выполняется контроль целостности {#vm-environment-integrity}

#|
|| **kind** | **severity** | **ID** ||
|| manual | low | runtime.vm-environment-integrity ||
|#

#### Описание

{% note warning "**Ручная проверка**" %}

Убедитесь, что критические ВМ имеют подписанные идентификационные документы. Проведите точечный сбор данных об использовании контроля целостности. Отметье вручную что контроль является выполненным.

{% endnote %}

Контроль целостности файлов

Множество стандартов по ИБ требуют выполнения контроля целостности критичных файлов. Для этого можно использовать бесплатные host-based решения:

* [Wazuh](https://documentation.wazuh.com/current/learning-wazuh/detect-fs-changes.html)
* [Osquery](https://osquery.readthedocs.io/en/stable/deployment/file-integrity-monitoring/)

В маркетплейсе облака также доступны платные решения — например, [Kaspersky Security](https://yandex.cloud/ru/marketplace/products/kaspersky/kaspersky-linux-hybrid-cloud-security-byol).

Контроль целостности среды запуска ВМ

В целях контроля среды запуска ВМ (например, доступ из ВМ к защищенному репозиторию только при запуске в облаке Yandex Cloud CLI) вы можете использовать механизм [Идентификационного документа](https://yandex.cloud/ru/docs/compute/concepts/metadata/identity-document). При создании ВМ формируется идентификационный документ (identity document), в котором хранятся сведения о самой ВМ: идентификаторы ВМ, продукта [Yandex Cloud Marketplace](https://yandex.cloud/ru/marketplace), образа диска и т.д. Такой документ подписывается сертификатом Yandex Cloud. [Сам документ и его подпись](https://yandex.cloud/ru/docs/compute/concepts/metadata/identity-document#signed-identity-documents) доступны процессам в ВМ через сервис метаданных, что позволяет процессам в виртуальной машине гарантированно идентифицировать среду запуска ВМ, образ диска и т.д. для ограничения доступа к контролируемым ресурсам.

#### Инструкции и решения по выполнению

* Соберите данные об использовании лучших практик безопасности Terraform из разных точек.