---
title: Как добавить домен в {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете добавить свой домен для защиты в {{ sws-full-name }}.
---

# Добавить домен

Для добавления домена вам потребуется:

* Адрес домена, на котором работает веб-приложение. У вас должен быть доступ к кабинету управления доменом, чтобы изменить А-запись.
* (для HTTPS) Действительный приватный ключ и TLS-сертификат для этого домена в [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded формате. Поддерживаются сертификаты с ключами RSA-2048 и RSA-4096.
* (Опционально) Действительный приватный ключ и TLS-сертификат для защиты соединения между прокси-сервером и сервером, на котором находится ваше веб-приложение.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}** и выберите прокси-сервер, для которого нужно добавить домен.
  1. В меню слева перейдите на вкладку ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}** и нажмите кнопку **{{ ui-key.yacloud.smart-web-security.ProxyServer.Domains.createDomain_49MGX }}**.
  1. Введите адрес домена, на котором находится ваше веб-приложение.
   
     Вы можете добавить [wildcard-домен](https://en.wikipedia.org/wiki/Wildcard_DNS_record), например `*.example.com`. В этом случае будут обрабатываться запросы ко всем поддоменам указанного домена.

  1. (Опционально) Введите описание домена.
  1. Нажмите **{{ ui-key.yacloud.common.continue }}**.
  
  1. Укажите протокол соединения вашего веб-приложения с пользователями и дополнительные параметры:
  
      * **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.httpsAndHttp_bpVzd }}** — зашифрованное соединение HTTPS и поддержка HTTP для редких сценариев. Например, для переходного периода или поддержки старого оборудования.

         * (Опционально) Включите опцию **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.redirectHttpToHttps_kuxH2 }}**, чтобы запросы, полученные по HTTP, отправлялись по HTTPS.
         * (Опционально) Разверните блок **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.connectionSettings_7Q85M }}** и измените номера используемых портов и версию HTTPS.

             По умолчанию используется версия HTTP/2, HTTP-порт `80` и HTTPS-порт `443`.
      * **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.https_qWPJb }}** — зашифрованное соединение HTTPS.

         * (Опционально) Разверните блок **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.connectionSettings_7Q85M }}** и измените номер используемого порта и версию HTTPS.

             По умолчанию используется версия HTTP/2 и HTTPS-порт `443`.
      * **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.http_4Dbmc }}** — незашифрованное соединение. Рекомендуем использовать только в тестовых целях. Для этого варианта не нужен сертификат, но трафик между пользователем и вашим приложением будет передаваться в открытом виде.

         * (Опционально) Разверните блок **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.connectionSettings_7Q85M }}** и измените номер используемого порта.

             По умолчанию используется HTTP-порт `80`.
  1. При использовании HTTPS выберите выпущенный на указанный домен сертификат из [{{ certificate-manager-name }}](../../certificate-manager/index.yaml) или нажмите кнопку **{{ ui-key.yacloud.common.create }}** и выберите:

       * **{{ ui-key.yacloud.certificate-manager.CertificateField.userCertificate_bChXn }}** — если у вашего веб-приложения уже есть TLS-сертификат.

          1. Введите произвольное имя сертификата и описание.
          1. (Опционально) Включите защиту от удаления, чтобы запретить удаление сертификата.
          1. Скопируйте или загрузите сертификат, цепочку промежуточных сертификатов и приватный ключ в формате PEM.
          1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.CertificateImportDialog.createCertificate_x7Ww3 }}**.

       * **{{ ui-key.yacloud.certificate-manager.CertificateField.letsEncryptCertificate_5ack4 }}** — если у вашего веб-приложения нет TLS-сертификата.

          1. Введите произвольное имя сертификата и описание.
          1. (Опционально) Включите защиту от удаления, чтобы запретить удаление сертификата.
          1. Нажмите кнопку **{{ ui-key.yacloud.certificate-manager.RequstCertificateDialog.createCertificate_b5eZg }}**. В интерфейсе появится инструкция по созданию необходимой для [подтверждения прав на домен](../../certificate-manager/concepts/challenges.md#dns) ресурсной [CNAME-записи](../../dns/concepts/resource-record.md#cname) в [публичной зоне DNS](../../dns/concepts/dns-zone.md#public-zones) вашего домена.

              {% note info %}

              Вы можете [создать](../../dns/operations/resource-record-create.md) нужную запись вручную либо, если ваш домен делегирован {{ dns-full-name }}, воспользоваться [инструкцией](../../certificate-manager/concepts/challenges.md#cname) для автоматического создания ресурсной записи.

              {% endnote %}
          
             Дождитесь подтверждения прав на домен. Обычно проверка занимает несколько минут.
          1. Чтобы посмотреть статус проверки, нажмите **{{ ui-key.yacloud.certificate-manager.overview.button_validation_show-logs }}**.

             После того как статус проверки прав изменится на `Valid`, сертификат будет выпущен и перейдет в статус `Issued`. Пока сертификат не будет выпущен, вы не сможете продолжить добавление домена.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.continue }}**.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.DomainForm.TargetResourcesSection.targetResources_hqBQm }}** задайте настройки целевых ресурсов:

      1. Введите IP-адрес сервера и порт, на котором работает ваше веб-приложение.
      1. (Опционально) Введите комментарий для сервера.
      1. (Опционально) Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.DomainForm.TargetResourcesSection.addResource_qyJWd }}**, чтобы добавить подключения к дополнительным целевым ресурсам.
      1. (Опционально) Разверните блок **{{ ui-key.yacloud.smart-web-security.DomainForm.TargetResourcesSection.connectTargetResources_1mGNK }}**, чтобы задать дополнительные настройки подключения:

          * В поле **{{ ui-key.yacloud.smart-web-security.DomainForm.TargetResourcesSection.protocol_q33c8 }}** выберите протокол подключения: `HTTPS` или `HTTP`.
          * (Опционально) Если вы выбрали протокол `HTTPS` и используете несколько доменных имен и сертификатов, в поле **{{ ui-key.yacloud.smart-web-security.DomainForm.TargetResourcesSection.sni_mHMUX }}** добавьте [SNI](https://ru.wikipedia.org/wiki/Server_Name_Indication)-обработчик для маршрутизации трафика на основе имени домена.
          * Если вы выбрали протокол `HTTPS`, загрузите файл TLS-сертификата.
          * Выберите версию протокола — `HTTP/2` или `HTTP/1.1`.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.CreateDomain.createDomain_b2Ykj }}**.

{% endlist %}

После добавления домена [создайте профиль безопасности](profile-create.md) и [подключите](host-connect.md) его к домену.

### См. также {#see-also}

* [{#T}](proxy-create.md)
* [{#T}](profile-create.md)
* [{#T}](setup-infrastructure.md)
* [{#T}](validate-availability.md)
* [{#T}](host-connect.md)
