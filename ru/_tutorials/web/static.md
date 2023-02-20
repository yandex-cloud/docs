# Статический веб-сайт в {{ objstorage-full-name }}

С помощью этой инструкции вы научитесь загружать [статические файлы](../../storage/concepts/hosting.md) вашего веб-сайта в [{{ objstorage-full-name }}](../../storage/) и привязывать к [бакету](../../storage/concepts/bucket.md) доменное имя.

Чтобы разместить статический веб-сайт в Object Storage:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте публичный бакет](#create-public-bucket).
1. [Включите веб-сайт для бакета](#turn-on-hosting).
1. [Настройте DNS](#configure-dns).
1. [Загрузите файлы веб-сайта](#upload-files).
1. [Проверьте работу сайта](#test-site).

Если сайт вам больше не нужен, [удалите файлы из хранилища и зону DNS](#clear-out).

Также инфраструктуру для размещения статического веб-сайта в {{ objstorage-name }} можно развернуть через {{ TF }} с помощью [готового файла конфигурации](#terraform).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки статического сайта входит:

* плата за хранение данных статического сайта (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md#prices-storage));
* плата за операции с данными (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md#prices-operations));
* стоимость исходящего трафика из {{ yandex-cloud }} в интернет (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md#prices-traffic)).
* плата за публичные DNS-запросы и зоны (см. [тарифы {{ dns-full-name }}](../../dns/pricing.md)).

{% endif %}

## Создайте публичный бакет {#create-public-bucket}

{% list tabs %}

- Консоль управления

  Чтобы создать бакет для файлов статического сайта:

  1. Перейдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }} и выберите каталог, в котором будете выполнять операции.
  1. На странице каталога нажмите кнопку **Создать ресурс** и выберите **Бакет**.
  1. В поле **Имя** введите имя бакета, например, `www.example.com`. Имя бакета станет частью доменного имени сайта. После настройки бакет будет доступен по двум адресам:

     * `http(s)://<имя_бакета>.{{ s3-web-host }}`
     * `http(s)://{{ s3-web-host }}/<имя_бакета>`

     Имя должно удовлетворять требованиям:

     {% include [bucket-name-reqs](../../_includes/bucket-name-reqs.md) %}

     {% note info %}

     Если вы планируете использовать собственный домен для веб-сайта, имя бакета должно в точности совпадать с именем вашего домена, а домен должен быть третьего и более уровня. Подробнее см. в разделе [{#T}](../../storage/operations/hosting/own-domain.md).

     {% endnote %}

  1. Укажите максимальный размер бакета в ГБ.
  1. Включите **Публичный** доступ на чтение объектов.
  1. Нажмите кнопку **Создать бакет**.

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Включите веб-сайт для бакета {#turn-on-hosting}

{% list tabs %}

- Консоль управления

  Необходимо загрузить и настроить индексную страницу и страницу ошибки. Для этого:

  1. Создайте на компьютере файлы:
      * `index.html` с текстом `Hello, world!`.
         Содержимое файла будет показываться при обращении к главной странице веб-сайта.
      * `error.html` с текстом `Error!`.
         Содержимое файла будет показываться при ответах веб-сайта с ошибками `4xx`.
  1. На вкладке **Объекты** на странице вашего бакета нажмите кнопку **Загрузить**. В открывшемся окне выберите созданные файлы и нажмите кнопку подтверждения.
  1. Нажмите кнопку **Загрузить**.
  1. Откройте вкладку **Веб-сайт** на странице вашего бакета.
  1. Выберите **Хостинг**.
  1. В поле **Главная страница** укажите `index.html`.
  1. В поле **Страница ошибки** укажите `error.html`.
  1. Нажмите кнопку **Сохранить**.
  1. Проверьте, что главная страница веб-сайта открывается. Для этого подключитесь к сайту через браузер по ссылке вида `http://<имя_бакета>.{{ s3-web-host }}`.
  1. Проверьте, что страница ошибки открывается. Для этого подключитесь к сайту через браузер по ссылке вида `http://<имя_бакета>.{{ s3-web-host }}/error-check`.

  {% note info %}

  По умолчанию сайт доступен только по протоколу HTTP, например, `http://www.example.com` или `http://www.example.com.{{ s3-web-host }}`. Чтобы поддержать для сайта протокол HTTPS, [загрузите собственный сертификат безопасности](../../storage/operations/hosting/certificate.md) в {{ objstorage-name }}.

  {% endnote %}

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Настройте DNS {#configure-dns}

Если у вас есть зарегистрированное доменное имя, назначьте его бакету. Для этого создайте в DNS запись [типа CNAME](../../dns/concepts/resource-record.md#cname).

Вы можете воспользоваться сервисом {{ dns-name }} для управления доменом.

{% note info %}

Имя бакета должно в точности совпадать с именем вашего домена, а домен должен быть третьего и более уровня. Подробнее см. в разделе [{#T}](../../storage/operations/hosting/own-domain.md).

{% endnote %}

В инструкции ниже описана настройка DNS для домена третьего уровня `www.example.com`.

### Добавьте зону {#create-dns-zone}

{% list tabs %}

- Консоль управления

  Чтобы добавить публичную зону:
  1. Откройте раздел **{{ dns-name }}** в каталоге, где требуется создать [зону DNS](../../dns/concepts/dns-zone.md).
  1. Нажмите кнопку **Создать зону**.
  1. Задайте настройки зоны:
	  * **Имя** зоны: `example-zone-1`.
	  * **Зона**: `example.com.`. Укажите ваш зарегистрированный домен.
	  * **Тип** — **Публичная**.
  1. Нажмите кнопку **Создать**.

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

### Добавьте запись типа CNAME {#create-cname-record}

{% list tabs %}

- Консоль управления

  Создайте в публичной зоне запись DNS [типа CNAME](../../dns/concepts/resource-record.md#cname):

  1. Выберите зону `example.com` из списка.
  1. Нажмите кнопку **Создать запись**.
  1. Задайте параметры записи:
	  * **Имя**: `www`.
	  * **Тип записи**: выберите значение `CNAME`.
	  * **TTL** (время кеширования записи): оставьте значение по умолчанию.
	  * **Значение**: введите `www.example.com.{{ s3-web-host }}.`.
  1. Нажмите кнопку **Создать**.

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

### Делегируйте доменное имя {#delegate-domain}

Делегирование — это перенос ответственности с серверов регистратора на ваши серверы. Для домена создаются ресурсные записи [типа NS](../../dns/concepts/resource-record.md#ns) ({% if product == "yandex-cloud" %}`ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`{% endif %}{% if product == "cloud-il" %}`ns1.{{ dns-ns-host-sld }}` и `ns2.{{ dns-ns-host-sld }}`{% endif %}).

Чтобы делегировать домен, укажите для него DNS-серверы в личном кабинете регистратора.

Делегирование происходит не сразу. Серверы интернет-провайдеров обычно обновляют записи до 24 часов (86400 секунд). Это обусловлено значением TTL, в течение которого кешируются записи для доменов.

Проверить делегирование домена можно с помощью [сервиса Whois]{% if lang == "ru" %}(https://www.reg.ru/whois/check_site){% endif %}{% if lang == "en" %}(https://www.reg.com/whois/check_site){% endif %} или утилиты `dig`:

```bash
dig +short NS example.com
```

Результат:

{% if product == "yandex-cloud" %}

```text
ns2.{{ dns-ns-host-sld }}.
ns1.{{ dns-ns-host-sld }}.
```

{% endif %}

{% if product == "cloud-il" %}

```text
ns2.{{ dns-ns-host-sld }}.
ns1.{{ dns-ns-host-sld }}.
```

{% endif %}

## Загрузите файлы веб-сайта {#upload-files}

После настройки и проверки доступности загрузите в бакет остальные файлы, необходимые для работы сайта. Используйте для этого [консоль управления]({{ link-console-main }}), [S3 API](../../storage/s3/api-ref/object/upload.md), [{{ TF }}](../infrastructure-management/terraform-quickstart.md) или другие [инструменты для работы с {{ objstorage-name }}](../../storage/tools/).

{% list tabs %}

- {{ TF }}

  См. раздел [Как создать инфраструктуру с помощью {{ TF }}](#terraform).

{% endlist %}

## Проверьте работу сайта {#test-site}

Чтобы проверить работу сайта, используйте один из стандартных адресов {{ objstorage-name }}:

* `http://www.example.com.{{ s3-web-host }}`
* `http://{{ s3-web-host }}/www.example.com`

Если вы настроили собственный домен, используйте адрес `http://www.example.com`.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за ресурсы:

* [Удалите загруженные файлы](../../storage/operations/objects/delete.md).
* [Удалите зону DNS](../../dns/operations/zone-delete.md).

## Как создать инфраструктуру с помощью {{ TF }} {#terraform}

{% include [terraform-definition](../terraform-definition.md) %}

Чтобы разместить статический веб-сайт в {{ objstorage-name }} с помощью {{ TF }}:

1. [Установите {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:
   
   {% list tabs %}
   
   - Готовый архив
 
     1. Создайте папку для файлов.
     1. Скачайте [архив](https://{{ s3-storage-host }}/doc-files/static.zip) (2 КБ).
     1. Разархивируйте архив в папку. В результате в ней должны появиться конфигурационный файл `static.tf`, файлы `index.html` и `error.html`.

   - Создание вручную

     1. Создайте папку для файлов.
     1. Создайте в папке конфигурационный файл `static.tf`:
  
          {% cut "static.tf" %}
     
          {% include [static-tf-config](../../_includes/web/static-tf-config.md) %}
     
          {% endcut %}

     1. Создайте в папке файл `index.html` с текстом `Hello world!`:
  
          {% cut "index.html" %}
     
          {% include [static-tf-config](../../_includes/web/index-html-config.md) %}
     
          {% endcut %}

     1. Создайте в папке файл `error.html` с текстом `Error!`:
  
          {% cut "error.html" %}
     
          {% include [static-tf-config](../../_includes/web/error-html-config.md) %}
     
          {% endcut %}

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:

   * [yandex_iam_service_account]({{ tf-provider-link }}/iam_service_account)
   * [yandex_resourcemanager_folder_iam_member]({{ tf-provider-link }}/resourcemanager_folder_iam_member)
   * [yandex_iam_service_account_static_access_key]({{ tf-provider-link }}/iam_service_account_static_access_key)
   * [yandex_storage_bucket]({{ tf-provider-link }}/storage_bucket)
   * [yandex_dns_zone]({{ tf-provider-link }}/dns_zone)
   * [yandex_dns_recordset]({{ tf-provider-link }}/dns_recordset)

1. В файле `static.tf` вставьте в блок `locals` следующие значения:

   * `token` — {% if product == "yandex-cloud" %}[OAuth-токен](../../iam/concepts/authorization/oauth-token.md) (если вы используете [аккаунт на Яндексе](../../iam/concepts/index.md#passport)) или [IAM-токен](../../iam/concepts/authorization/iam-token.md) (если вы используете аккаунт на Яндексе или [федеративный аккаунт](../../iam/concepts/index.md#saml-federation)) для доступа к {{ yandex-cloud }}. Время жизни IAM-токена — максимум 12 часов, но не больше времени жизни cookie у федерации.{% endif %} {% if product == "cloud-il" %}статический ключ (`secret`) сервисного аккаунта для доступа к {{ yandex-cloud }}.{% endif %}
   * `cloud_id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md), в котором будут создаваться ресурсы.
   * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором будут создаваться ресурсы.
 
1. Создайте ресурсы:

   {% include [terraform-validate-plan-apply](../terraform-validate-plan-apply.md) %}

1. [Проверьте работу сайта](#test-site).
