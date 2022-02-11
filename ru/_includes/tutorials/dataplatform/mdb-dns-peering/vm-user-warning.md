{% note warning %}

* Если вы создали виртуальные машины с Ubuntu 20.04 LTS из образа `{{ compute-ubuntu-lts-image-id }}`, то используйте имя пользователя `ubuntu` при подключении.

{% if audience != "internal" %}

* Если вы использовали другой образ, то имя пользователя может отличаться. О том, как узнать это имя, см. в [документации {{ compute-full-name }}](../../../../compute/concepts/vm-metadata.md#keys-processed-in-public-images).

{% else %}

* Если вы использовали другой образ, то имя пользователя может отличаться.

{% endif %}

{% endnote %}