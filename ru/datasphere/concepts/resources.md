# Ресурсы проектов {{ ml-platform-name }}

В проектах {{ ml-platform-name }} можно создавать ресурсы — вспомогательные объекты, которые помогают повысить скорость работы с данными, автоматизировать рутинные действия и выполнять специальные операции.

Ресурсы, созданные или доступные в проекте, можно посмотреть на странице проекта в блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**.

Вы можете использовать ресурсы в нескольких проектах, не создавая их повторно. Чтобы ресурс стал доступен для всех проектов [сообщества](community.md), поделитесь им на вкладке **{{ ui-key.yc-ui-datasphere.common.access }}**. Для этого вам минимально необходимы роли `Editor` в проекте и `Developer` в сообществе, в котором вы хотите опубликовать ресурс. Ресурсы сообщества доступны на странице сообщества в блоке **{{ ui-key.yc-ui-datasphere.spaces-page.community-resources }}**.

Ресурсы проектов {{ ml-platform-name }}:

* [Секреты](secrets.md)
* [Docker-образы](docker.md)
* [Датасеты](dataset.md)
* [Коннекторы S3](s3-connector.md)
* [Ноды и алиасы](deploy/index.md#python-nodes)
* [Шаблоны {{ dataproc-name }}](data-processing-template.md)
* [Коннекторы Spark](spark-connector.md)
* [Модели](models/index.md)
* [Дообученные фундаментальные модели](models/tuned-models.md)
* [Файловые хранилища](filestores.md)

Подробнее о ресурсной модели {{ ml-platform-name }} см. [{#T}](resource-model.md).
