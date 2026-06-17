# Метаданные виртуальной машины

{% note info %}

[Получить](metadata/accessing-metadata.md) прямой доступ (без аутентификации) к метаданным можно через специальный [сервис метаданных](#metadata-formats), доступный внутри ВМ по URL `http://169.254.169.254`. Сервис метаданных внутри ВМ доступен для всех виртуальных машин, независимо от их сетевых настроек и наличия доступа в интернет.

{% endnote %}

_Метаданные виртуальной машины_ — это метаинформация (дополнительная информация) о [виртуальной машине](vm.md).

Сервис метаданных виртуальной машины хранит метаданные в [каталогах](metadata/directories.md) в виде пар ключ-значение. 

Метаданные могут использоваться:
* Для работы процесса [cloud-init](https://cloudinit.readthedocs.io/en/latest/index.html) при создании ВМ.
* Для передачи в ключе `user-data` необходимой информации сервисам или приложениям, которые запускаются на ВМ уже после ее создания.
* Для получения изнутри ВМ данных, необходимых для аутентификации в Yandex Cloud.

Идентификатор виртуальной машины, идентификатор [образа](image.md) Cloud Marketplace, а также ряд других значений из состава метаданных формируют уникальный [идентификационный документ](metadata/identity-document.md) этой виртуальной машины.

## Параметры сервиса метаданных ВМ {#metadata-formats}

В Yandex Cloud доступ к метаданным ВМ можно получить в формате [Google Compute Engine](https://en.wikipedia.org/wiki/Google_Compute_Engine) (поддерживаются не все поля). Этот формат является наиболее безопасным и рекомендуемым форматом работы с метаданными ВМ. При [обращении](metadata/accessing-metadata.md) к сервису метаданных необходимо использовать HTTP-заголовок `Metadata-Flavor:Google`.

В виртуальных машинах Compute Cloud доступны следующие настройки сервиса метаданных ВМ:

* `gce-http-endpoint` — обеспечивает доступ к метаданным с использованием формата Google Compute Engine. Возможные значения: `enabled`, `disabled`. Если для опции задано значение `disabled`, то запрос к метаданным завершится ошибкой `400` (`BadRequest`). Значение по умолчанию: `enabled`.
* `gce-http-token` — обеспечивает доступ к получению через метаданные Google Compute Engine [IAM-токена](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта, подключенного к ВМ. Возможные значения: `enabled`, `disabled`. Если для опции задано значение `disabled`, то запрос на получение токена завершится ошибкой `400` (`BadRequest`). Значение по умолчанию: `enabled`.

Получить текущие значения параметров сервиса метаданных ВМ вы можете вместе с [информацией о ВМ](metadata/accessing-metadata.md#external-access) с помощью [CLI](../../cli/cli-ref/compute/cli-ref/instance/get.md) и [API](../api-ref/Instance/get.md).

Настроить параметры сервиса метаданных вы можете при [создании](../operations/index.md#vm-create) или [изменении](../operations/vm-control/vm-update.md) ВМ. Подробнее о том, как настроить параметры сервиса метаданных, читайте в [инструкции](../operations/vm-metadata/setup-metadata-service.md).

## Примеры использования {#examples}

* [Безопасная передача пароля в скрипт инициализации](../tutorials/secure-password-script/index.md)
* [Безопасное хранение паролей для GitLab CI в виде секретов Yandex Lockbox](../../tutorials/security/gitlab-lockbox-integration.md)

#### Полезные ссылки {#see-also}

* [Каталоги метаданных](metadata/directories.md)
* [Ключи, обрабатываемые в публичных образах Yandex Cloud](metadata/public-image-keys.md)
* [Передача метаданных в виртуальные машины](metadata/sending-metadata.md)
* [Доступ к метаданным виртуальных машин](metadata/accessing-metadata.md)
* [Идентификационный документ](metadata/identity-document.md)
* [Шаблон виртуальной машины](instance-groups/instance-template.md)