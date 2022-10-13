# Создать документ Microsoft Office 365 в {{wiki-name}}

Чтобы вставить на {{wiki-name}} документ Office 365, создайте новую страницу типа **Word, Excel, PowerPoint** и свяжите ее с документом одним из способов:

* [Создайте новый документ Office 365 через интерфейс {{wiki-name}}.](#new-from-wiki)

* [Укажите ссылку на существующий документ](#embed-existing), который сохранен на портале Sharepoint или в личной папке OneDrive.

* [Загрузите документ с вашего компьютера через интерфейс {{wiki-name}}.](#import-doc)

По умолчанию встроенный облачный документ занимает всю страницу, и на нее нельзя добавить другой контент. Если есть такая необходимость, вы можете [встроить документ на страницу с помощью iframe](embed-iframe.md).

## Создать новый документ из интерфейса {{wiki-name}} {#new-from-wiki}

Из интерфейса {{wiki-name}} вы можете создать на портале Sharepoint документ Word, Excel или PowerPoint и встроить его на новую вики-страницу.

1. На верхней панели {{wiki-name}} нажмите кнопку **Создать**.

1. Выберите тип страницы **Word, Excel, PowerPoint**.

1. Задайте название и адрес страницы так же, как при [создании вики-страницы](../create-page.md).

1. Выберите способ **Создать новый документ Microsoft 365**.

1. Выберите тип документа, который вы хотите создать.

1. Нажмите кнопку **Создать**. На портале Sharepoint будет создан пустой документ и встроен на новую вики-страницу.

1. Чтобы наполнить документ содержанием, на вики-странице нажмите кнопку [**Редактировать в облаке**](co-edit.md#edit-button). Документ откроется в приложении Office 365 в новой вкладке браузера.

1. Чтобы управлять доступом к документу, измените [настройки доступа к вики-странице](../page-management/access-setup.md). По умолчанию для новой страницы действует опция **Как у родительской страницы**. Подробнее см. [Настроить доступ к документам](doc-access.md).

{% note alert %} 

Если вы не [авторизованы на портале Office 365](ms-office.md#office-login), вы не сможете просмотреть созданный документ. Если у вас нет лицензии Office 365, отправьте запрос через [форму](https://help.yandex-team.ru/?form=soft).

{% endnote %}

## Встроить существующий документ на новую страницу {#embed-existing}

Если у вас есть документы, которые вы храните в корпоративном облаке Office 365, вы можете встраивать эти документы в вики-страницы. Документы, предназначенные для широкой аудитории, рекомендуется хранить на [сайте вашего проекта или отдела](./create-sharepoint.md#shared-site). 

{% note alert %} 

Если ваши документы хранятся в личной папке OneDrive, перед встраиванием на {{wiki-name}} перенесите их на сайт отдела. Иначе в случае увольнения или отзыва лицензии Office 365 все файлы в личной папке будут удалены.

{% endnote %}

Чтобы вставить документ на новую страницу:

1. Найдите файл на [портале Sharepoint]({{link-sharepoint-common}}) или в [личной папке OneDrive]({{link-sharepoint-personal}}) и убедитесь, что доступ к файлу открыт для пользователей, с которыми вы хотите поделиться файлом на {{wiki-name}}.

1. Скопируйте ссылку на документ или получите код для встраивания.
    * Откройте документ в браузере и скопируйте ссылку из адресной строки.
    * Откройте папку с документом на [портале Sharepoint]({{link-sharepoint-common}}) или в [личном разделе OneDrive]({{link-sharepoint-personal}}). Наведите указатель на документ, нажмите значок ![](../../_assets/wiki/share-opt.png) и выберите **Копировать ссылку**.
   
   По ссылке документ будет встроен с параметрами по умолчанию. Чтобы настроить внешний вид документа на странице и другие параметры, используйте код для встраивания.
   
   {% cut "Как получить код для встраивания" %}

   1. Откройте документ.
   1. Выберите меню **Файл** → **Поделиться** → **Внедрить** (в PowerPoint меню **Файл** → **Общий доступ** → **Внедрение**).
   1. Настройте параметры вставки документа.
   1. Скопируйте текст из поля **Код внедрения**.
   
   {% endcut %}

1. На верхней панели {{wiki-name}} нажмите кнопку **Создать**.

1. Выберите тип страницы **Word, Excel, PowerPoint**.

1. Так же, как при создании вики-страницы, задайте название и выберите, в каком разделе  будет находиться страница.

1. Выберите способ **Добавить существующий документ Microsoft 365**.

1. В поле **Код документа** вставьте код для встраивания или ссылку на документ.

1. Нажмите кнопку **Создать**. 
   
   Документ будет встроен на созданную вики-страницу.

{% note alert %} 

Если документ был создан через интерфейс Sharepoint, на него не действуют настройки доступа вики-страницы, на которую встроен документ. Управлять доступом к таким документам можно только через интерфейс Sharepoint. Подробнее см. [Настроить доступ к документам](doc-access.md).

{% endnote %}

## Создать страницу из локального документа {#import-doc}

Из интерфейса {{wiki-name}} вы можете загрузить на портал Sharepoint файл формата DOCX, XLSX или PPTX и встроить его на новую вики-страницу.

1. На верхней панели {{wiki-name}} нажмите кнопку **Создать**.

1. Выберите тип страницы **Word, Excel, PowerPoint**.

1. Так же, как при создании вики-страницы, задайте название и выберите, в каком разделе  будет находиться страница.

1. Выберите способ **Загрузить документ с компьютера**.

1. Нажмите кнопку **Загрузить файл** и выберите документ, который вы хотите вставить на вики-страницу. 

1. Нажмите кнопку **Создать**.
   Выбранный файл будет загружен на портал Sharepoint от имени робота и встроен на созданную вики-страницу. 

1. Чтобы управлять доступом к документу, измените [настройки доступа к вики-странице](../page-management/access-setup.md). По умолчанию для новой страницы действует опция **Как у родительской страницы**. Подробнее см. [Настроить доступ к документам](doc-access.md). 

{% note alert %} 

Если вы не [авторизованы на портале Office 365](ms-office.md#office-login), вы не сможете просмотреть созданный документ. Если у вас нет лицензии Office 365, отправьте запрос через [форму](https://help.yandex-team.ru/?form=soft).

{% endnote %}