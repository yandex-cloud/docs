# Как подключить собственный домен к бакету


## Описание сценария {#case-description}

Необходимо подключить к бакету собственный домен.

## Решение {#case-resolution}

Для подключения собственного домена к бакету нужно:

1. [Создать бакет с именем домена]; 
2. [Настроить бакет в качестве хостинга](../../../storage/operations/hosting/setup);
3. Настроить DNS: [добавить CNAME запись](../../../storage/operations/hosting/own-domain);
4. [Добавить свой сертификат в {{ certificate-manager-full-name }}](../../../certificate-manager/operations);
5. [Привязать сертификат к бакету для работы HTTPS](../../../storage/operations/hosting/certificate).

{% note info %}

В пункте **4.** можно заменить свой сертификат на бесплатный Let's Encrypt, выпущенный [при помощи {{ certificate-manager-full-name }}](../../../certificate-manager/operations/managed/cert-create).

{% endnote %}

После успешного выполнения всех шагов доступ к файлам будет работать по ссылкам вида `<доменное_имя>/[filekey]`.
