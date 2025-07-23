# Начало работы для управляющего метаданными

{% note info %}

{% include [preview-tp](../../_includes/preview-tp.md) %}

{% endnote %}

Работая с {{ data-catalog-full-name }} в роли управляющего метаданными, вы можете собирать и систематизировать метаданные об объектах {{ yandex-cloud }} и связях между ними.

{{ data-catalog-name }} поддерживает получение метаданных из следующих сервисов:

* {{ mch-full-name }};
* {{ mmy-full-name }};
* {{ mpg-full-name }};
* {{ data-transfer-full-name }}.

Чтобы начать работу с сервисом:

1. [Создайте каталог метаданных](#create-catalog).
1. [Создайте источник метаданных](#create-source).
1. [Создайте загрузки данных](#create-ingestions) из источников по расписанию.
1. [Проверьте загруженные метаданные](#test-data-ingestion).
1. [Создайте классификацию и теги](#classification).
1. [Создайте домен и поддомены](#domains).
1. [Создайте глоссарий и термины](#glossary).
1. [Разметьте полученные данные](#metadata-markup).

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за вычислительные ресурсы, объем хранилища и резервных копий кластера {{ mpg-full-name }} (см. [тарифы {{ mpg-name }}](../../managed-postgresql/pricing.md)).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога ресурсов, создайте его:

   {% include [create-folder](../../_includes/create-folder.md) %}

1. [Назначьте](../../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роли на каталог ресурсов:

    * `data-catalog.dataSteward` — чтобы создавать ресурсы Data Catalog и управлять ими;
    * [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../../vpc/concepts/network.md#network) кластера.

    {% include [note-managing-roles](../../_includes/mdb/note-managing-roles.md) %}

1. [Создайте кластер](../../managed-postgresql/operations/cluster-create.md#create-cluster) {{ mpg-name }}, из которого будут поставляться данные в качестве тестовой нагрузки.

## Создайте каталог метаданных {#create-catalog}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите [подготовленный ранее](#before-you-begin) каталог ресурсов.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. На панели слева выберите сервис ![image](../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.action_create-catalog }}**.
  1. Задайте **{{ ui-key.yacloud.common.name }}** каталога метаданных.
  1. Задайте **{{ ui-key.yacloud.common.description }}** каталога метаданных.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Создайте источник и загрузку метаданных {#create-source}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в [созданный ранее](#create-catalog) каталог метаданных.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/cloud-arrow-up-in.svg) **{{ ui-key.yacloud.data-catalog.label_sources }}** и нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-source-button }}**.
  1. Задайте **{{ ui-key.yacloud.common.name }}** источника.
  1. Задайте **{{ ui-key.yacloud.common.description }}** источника.
  1. Выберите **{{ ui-key.yacloud.data-catalog.label_source-database-type }}** — **PostgreSQL**.
  1. В блоке **Источник PostgreSQL** задайте параметры:

     * **ID папки** — каталог ресурсов, в котором создан кластер {{ mpg-name }}.
     * **Тип инсталляции** — **Кластер {{ mpg-name }}**.
     * **Кластер управляемой БД** — созданный ранее кластер {{ mpg-name }}.
     * **ID подключения** — подключение к созданному ранее кластеру {{ mpg-name }} в сервисе {{ connection-manager-full-name }}.
     * **Имя базы данных** в созданном ранее кластере {{ mpg-name }}.
     * (Опционально) **Выгружать из всех баз данных** — включите опцию, если необходимо выгружать данные из всех баз данных.
     * **Идентификатор сети** — укажите идентификатор сети.


  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**. 
  1. После этого вам откроется страница со списком источников в каталоге метаданных. В строке с только что созданным источником будет отображаться сообщение **{{ ui-key.yacloud.data-catalog.label_empty-ingestion-count-short }}**.
  1. Наведите курсор на это сообщение и в отобразившемся окне нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-ingestion-action }}**. 
  1. Задайте **{{ ui-key.yacloud.common.name }}** загрузки.
  1. Задайте **{{ ui-key.yacloud.common.description }}** загрузки.  
  1. В поле **Расписание** выберите **Каждый день**.
  1. В полях **Время начала** и **Время окончания** задайте время работы загрузки.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Проверьте загруженные метаданные {#test-data-ingestion}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в [созданный ранее](#create-catalog) каталог метаданных.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}**.

     В открывшемся списке отобразятся метаданные, полученные из созданного ранее кластера {{ mpg-name }}.

{% endlist %}

{% note tip %}

Загруженные из источника метаданные также отобразятся на вкладке **{{ ui-key.yacloud.data-catalog.label_source-data-tab }}** в этом источнике.

{% endnote %}

## Создайте классификацию и теги {#classification}

### Создайте классификацию {#create-classification}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в [созданный ранее](#create-catalog) каталог метаданных.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/tag.svg) **{{ ui-key.yacloud.data-catalog.label_tags-and-classification }}** и нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-classification-action }}**.
  1. Задайте **{{ ui-key.yacloud.common.name }}** классификации.
  1. Задайте **{{ ui-key.yacloud.common.description }}** классификации.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Создайте теги {#create-tags}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в [созданный ранее](#create-catalog) каталог метаданных.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/tag.svg) **{{ ui-key.yacloud.data-catalog.label_tags-and-classification }}** и откройте [созданную ранее](#create-classification) классификацию.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-tag-action }}**.
  1. В открывшемся окне задайте **{{ ui-key.yacloud.common.name }}** тега.
  1. Задайте **{{ ui-key.yacloud.common.description }}** тега.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Создайте домен и поддомены {#domains}

### Создайте домен {#create-domain}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в [созданный ранее](#create-catalog) каталог метаданных.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.data-catalog.label_domains }}** и нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-domain-action }}**.
  1. Задайте **{{ ui-key.yacloud.common.name }}** домена. 
  1. Задайте **{{ ui-key.yacloud.common.description }}** домена.
  1. Добавьте один или несколько [созданных ранее](#create-tags) тегов.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Создайте поддомен {#create-subdomain}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в [созданный ранее](#create-catalog) каталог метаданных.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.data-catalog.label_domains }}** и выберите [созданный ранее](#create-domain) домен.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_add-subdomain-action }}**.
  1. Задайте **{{ ui-key.yacloud.common.name }}** поддомена. 
  1. Задайте **{{ ui-key.yacloud.common.description }}** поддомена.
  1. Добавьте один или несколько [созданных ранее](#create-tags) тегов.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Создайте глоссарий и термины {#glossary}

### Создайте глоссарий {#create-glossary}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в [созданный ранее](#create-catalog) каталог метаданных.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}** и нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-glossary-action }}**.
  1. Задайте **{{ ui-key.yacloud.common.name }}** глоссария.
  1. Задайте **{{ ui-key.yacloud.common.description }}** глоссария.
  1. Добавьте один или несколько [созданных ранее](#create-tags) тегов.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Создайте термины {#create-terms}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в [созданный ранее](#create-catalog) каталог метаданных.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}** и выберите [созданный ранее](#create-glossary) глоссарий.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-term-action }}**.
  1. Задайте **{{ ui-key.yacloud.common.name }}** термина.
  1. Задайте **{{ ui-key.yacloud.common.description }}** термина.
  1. Укажите синонимы для термина.
  1. Добавьте один или несколько [созданных ранее](#create-tags) тегов.
  1. Добавьте связанные термины.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Разметьте полученные данные {#metadata-markup}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в [созданный ранее](#create-catalog) каталог метаданных.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud.data-catalog.title_search-data }}**.
  1. В строке с выбранным набором данных нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.data-catalog.action_set-domain }}**, **{{ ui-key.yacloud.data-catalog.label_add-tags }}** или **{{ ui-key.yacloud.data-catalog.label_add-terms }}**.
  1. В открывшемся окне выберите объект в иерархии доменов, тегов или терминов. При необходимости воспользуйтесь поиском.
  1. Добавьте выбранные объекты.

{% endlist %}

## Что дальше {#what-is-next}

* [Создайте термин](../operations/data-catalog/create-term.md) в глоссарии.
* [Создайте дочерний термин](../operations/data-catalog/create-term-child.md).
* [Измените глоссарий](../operations/data-catalog/update-glossary.md).
* [Измените термин в глоссарии](../operations/data-catalog/update-term.md).
* [Создайте тег](../operations/data-catalog/create-tag.md) в классификации.
* [Измените классификацию](../operations/data-catalog/update-classification.md).
* [Измените тег](../operations/data-catalog/update-tag.md) в классификации.