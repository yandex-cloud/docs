# Общее описание процесса установки

В поставку On-premises Yandex Object Storage включены два архива:

* `install-kit.tar.gz` — инструменты для первоначальной установки на пустые хосты;
* `yc-storage-<версия>.tar.gz` — ПО Object Storage, где `<версия>` — поставляемая версия.

Также предоставлены следующие значения, которые потребуются на этапе конфигурации:

* размер квоты хранилища;
* поставленные версии `yc-storage-operator` и Object Storage.

Для выполнения установки необходим установочный хост, соответствующий [минимальным требованиям](environment-preparation.md#installation-host).

На верхнем уровне процесс установки состоит из двух этапов:

1. Подготовка хостов стенда для установки Object Storage:
    * установка ОС, настройка сети и разметка NVMe;
    * развертывание кластера Kubernetes и локального OCI Registry;
    * наполнение OCI Registry требуемыми образами из поставки.

1. Установка Object Storage в развернутый кластер Kubernetes.

![installation](../_assets/install/installation.svg)

## Подробности об установке и настройке {#see-also}

* [Подготовка окружения](environment-preparation.md)
* [Настройка параметров инсталляции](setup-install-params.md)
* [Шаги установки](installation-steps.md)
* [Устранение неисправностей при установке](../troubleshooting/installation-errors.md)
* [После установки](getting-started.md)