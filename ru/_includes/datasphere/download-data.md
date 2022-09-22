Данные небольшого объема (до 100 МБ) можно загрузить в проект {{ ml-platform-name }} через интерфейс JupyterLab. Больший объем информации рекомендуем загружать из сетевых хранилищ и баз данных. Также для работы с большим объемом данных удобно использовать [датасеты](../../datasphere/concepts/dataset.md).

Чтобы загрузить данные в проект через интерфейс JupyterLab:

1. В блоке ![folder](../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** выберите папку, в которую нужно загрузить данные.
1. Слева сверху нажмите кнопку ![upload](../../_assets/datasphere/jupyterlab/upload.svg).
1. Выберите файлы, которые нужно загрузить. 

[Подробнее о хранилище проекта](../../datasphere/concepts/project.md#storage).

{{ ml-platform-name }} позволяет загружать данные из разных источников:

* [{#T}](../../datasphere/operations/data/connect-to-s3.md).
* [{#T}](../../datasphere/operations/data/connect-to-google-drive.md).
* [{#T}](../../datasphere/operations/data/connect-to-clickhouse.md).
* [{#T}](../../datasphere/operations/data/connect-to-postgresql.md).
* [{#T}](../../datasphere/operations/data/connect-to-ya-disk.md).