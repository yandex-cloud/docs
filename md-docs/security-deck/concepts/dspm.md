# Модуль контроля данных ({{ dspm-name }})

{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

[Модуль контроля данных]({{ link-sd-main }}dspm/) или {{ dspm-name }} ({{ dspm-full-name }}) — это инструмент, помогающий оперативно обнаруживать чувствительную информацию, сохраненную в [бакетах](../../storage/concepts/bucket.md) {{ objstorage-full-name }} и на дисках в {{ yandex-360 }}. Это позволит своевременно настраивать [политики доступа](../../storage/concepts/policy.md), обезличивать данные и принимать другие меры защиты.

## Анализ данных {#discovery-mode}

{% note info %}

Функциональность анализа данных находится на [стадии Preview](../../overview/concepts/launch-stages.md) и в настоящее время не тарифицируется.

После перехода в стадию общего доступа анализ данных будет тарифицироваться отдельно от [сканирований](dspm.md#scanning) источников данных.

{% endnote %}

Одна из ключевых возможностей {{ dspm-name }} — это анализ всех данных, хранящихся в бакетах в заданном окружении. [Анализ](../operations/dspm/discovery-mode.md) запускается автоматически при создании окружения, сканируются все данные в бакетах. 

С помощью анализа вы можете точнее определять, в каких ресурсах могут находиться чувствительные данные, и получить готовый источник данных для последующего подробного сканирования. Поиск чувствительных данных при этом занимает меньше времени, чем сканирование источника данных, созданного вручную.

## Сканирование на наличие чувствительной информации {#scanning}

{{ dspm-name }} находит чувствительную информацию в бакетах с помощью сканирования _источников данных_. Сканирование можно выполнять как однократно, так и по заданному расписанию.

Сканирование на наличие чувствительной информации выполняется от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

Чтобы [создать сканирование](../operations/dspm/create-scan.md), пользователь должен обладать [ролью](../security/dspm-roles.md#dspm-editor) `dspm.editor` на каталог, [заданный](../quickstart-overview.md#configure-sd) в настройках {{ sd-name }} в качестве хранилища по умолчанию, а также [ролью](../../iam/security/index.md#iam-serviceAccounts-user) `iam.serviceAccounts.user` на сервисный аккаунт, от имени которого будет выполняться сканирование.

{% note warning %}

Для выполнения сканирования сервисному аккаунту должна быть [назначена](../../iam/operations/sa/assign-role-for-sa.md) [роль](../security/dspm-roles.md#dspm-worker) `dspm.worker` на все сканируемые бакеты. Если бакеты [зашифрованы](../../storage/concepts/encryption.md), сервисному аккаунту также необходима [роль](../../kms/security/index.md#kms-keys-decrypter) `kms.keys.decrypter` на соответствующие [ключи шифрования](../../kms/concepts/key.md) {{ kms-full-name }}.

{% endnote %}

Прежде чем начать сканирование, необходимо выбрать источник данных и задать _категории данных_ для поиска.

### Источник данных {#data-source}

Источник данных содержит настройки и информацию о _ресурсах_, в которых будет выполняться сканирование:

* бакетах {{ objstorage-name }};
* [каталогах](../../resource-manager/concepts/resources-hierarchy.md#folder) {{ yandex-cloud }};
* [облаках](../../resource-manager/concepts/resources-hierarchy.md#cloud) {{ yandex-cloud }};
* [общих дисках]({{ link-yandex }}/support/yandex-360/business/disk/web/{{ lang }}/share/shared-disks) {{ yandex-360 }};
* [общих папках]({{ link-yandex }}/support/yandex-360/business/disk/web/{{ lang }}/share/shared-folders) {{ yandex-360 }}.

При добавлении в источник данных каталогов и облаков в сканирование попадут бакеты выбранных типов, имеющиеся в выбранных облаках и/или каталогах. При этом будут сканироваться не только те бакеты, которые существуют в выбранных облаках и каталогах в момент создания источника данных, но и бакеты, которые в них могут появиться позднее — к моменту выполнения сканирования.

Для источника данных вы можете задать следующие области сканирования:

* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_all }}` — чтобы при сканировании проверялись все файлы, сохраненные в бакетах.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_docx_txt }}` — чтобы при сканировании проверялись текстовые файлы с расширениями `.doc`, `.docx` и `.txt`.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_xlsx_csv }}` — чтобы при сканировании проверялись табличные файлы с расширениями `.xls`, `.xlsx` и `.csv`.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_pptx }}` — чтобы при сканировании проверялись файлы презентаций с расширениями `.ppt` и `.pptx`.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_pdf }}` — чтобы при сканировании проверялись документы с расширением `.pdf`.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_html_xml }}` — чтобы при сканировании проверялись файлы с расширениями `.html` и `.xml`.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_images }}` — чтобы при сканировании проверялись изображения с расширениями `.jpg`, `.jpeg`, `.png`, `.gif`, `.webp` и `.svg`.
* `{{ ui-key.yacloud_org.dspm.scan-resource-group.file_type_custom }}` — чтобы при сканировании проверялись файлы, имена которых соответствуют или не соответствуют заданным шаблонам:

    * **{{ ui-key.yacloud_org.dspm.scan-resource-group.label_field-includeRegex }}** — задайте шаблон, которому должны соответствовать имена файлов, проверяемые при сканировании.
    * **{{ ui-key.yacloud_org.dspm.scan-resource-group.label_field-excludeRegex }}** — задайте шаблон, которому должны соответствовать имена файлов, игнорируемые при сканировании.

    Шаблоны задаются в форме [регулярных выражений](https://ru.wikipedia.org/wiki/Регулярные_выражения) с использованием синтаксиса [RE2](https://github.com/google/re2/wiki/Syntax). Вы можете задать шаблоны в обоих полях, в этом случае выборка файлов при сканировании будет осуществляться с логикой `И`.

Вы можете выбрать одновременно несколько фильтров, при этом фильтры будут применяться с логикой `ИЛИ`.

Вы можете добавить в один источник данных одновременно несколько бакетов, каталогов и/или облаков, а также создать в источнике данных одновременно несколько групп ресурсов с разными настройками области сканирования. Вы также можете добавить один бакет одновременно в несколько источников данных с разными настройками области сканирования.

### Категории данных {#data-categories}

При создании нового сканирования вы можете указать категории данных для поиска отдельно в тексте и на изображениях.

Вы можете выбрать как все доступные категории одновременно, так и любую их комбинацию.

Доступные категории данных для сканирования:

* **{{ ui-key.yacloud_components.security.dspm.card_title_text }}**:
  * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_personal-data_w5gVm }}` — ФИО, адреса электронной почты, номера телефонов, СНИЛС.
  * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_financial-data_kTC5e }}` — данные банковских карт.
  * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_secrets_4CdGy }}` — облачные ключи доступа, пароли, токены, SSH-ключи и т. п.
* **{{ ui-key.yacloud_components.security.dspm.card_title_image }}**:
  * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_personal-data_w5gVm }}` — ФИО, адреса электронной почты, номера телефонов, СНИЛС.
  * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_financial-data_kTC5e }}` — данные банковских карт.
  * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_medical-data-images_7EQ2X }}` — данные медицинских документов и снимков.
  * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_other_wUrAZ }}` — данные личных документов: военных билетов, пенсионных удостоверений, документов об образовании и т.п.

Для того чтобы создавать источники данных, создавать и запускать сканирования, а также просматривать результаты сканирования, пользователю должны быть назначены соответствующие [роли](../security/index.md).

#### См. также {#see-also}

* [{#T}](../operations/dspm/create-data-source.md)
* [{#T}](../operations/dspm/create-scan.md)