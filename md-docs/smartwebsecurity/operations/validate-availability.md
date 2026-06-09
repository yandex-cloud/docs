# Проверить доступность ресурсов

Убедитесь, что [прокси-сервер](../concepts/domain-protect.md#proxy), [домен](../concepts/domain-protect.md#domain) и ваша инфраструктура настроены корректно, а балансировщик прокси-сервера имеет доступ к привязанным ресурсам:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В разделе ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}** выберите созданный прокси-сервер.
  1. В меню слева перейдите на вкладку ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}** и выберите созданный домен.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.Domain.Overview.targetResources_cNZPL }}** убедитесь, что ваш ресурс находится в статусе **{{ ui-key.yacloud.smart-web-security.DomainTargetStateStatus.statusHealthy_5F2ks }}**.
  
      Если это не так, прокси-сервер не может соединиться с вашим ресурсом. Проверьте адрес вашего веб-сервера и настройки сети. Убедитесь, что к веб-серверу разрешен доступ с [IP-адресов {{ yandex-cloud }}](../../overview/concepts/public-ips.md).
  1. На панели слева убедитесь, что ваш домен находится в статусе **{{ ui-key.yacloud.smart-web-security.DomainTargetStateStatus.statusHealthy_5F2ks }}**. 
      
      Если это не так, проверьте адрес домена и А-запись, а также валидность сертификата.

{% endlist %}

### См. также {#see-also}

* [{#T}](setup-infrastructure.md)
* [{#T}](proxy-create.md)
* [{#T}](domain-create.md)
* [{#T}](host-connect.md)