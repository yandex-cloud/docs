
{% note warning %}

When connecting an external database which is not a {{ yandex-cloud }} resource:

* When using your own SSL certificate, make sure it matches the one on the database side.
* Grant database access to the following {{ datalens-short-name }} IP ranges (`/` is followed by subnet mask length):

  {% list tabs group=ip_address %}

  - ipv4 {#ipv4}

    * `178.154.242.176/28`
    * `178.154.242.192/28`
    * `178.154.242.208/28`
    * `178.154.242.128/28`
    * `178.154.242.144/28`
    * `178.154.242.160/28`
    * `130.193.60.0/28`

  - ipv6 {#ipv6}

    * `2a02:6b8:c03:500:0:f83d:a987:0/112`
    * `2a02:6b8:c02:900:0:f83d:a987:0/112`
    * `2a02:6b8:c0e:500:0:f83d:a987:0/112`
    * `2a02:6b8:c41:1300:0:f83d:a987:0/112`

  {% endlist %}

{% endnote %}

