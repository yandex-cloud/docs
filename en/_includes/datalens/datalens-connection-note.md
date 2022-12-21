 

{% note warning %}

When connecting an external DB that is not a {{ yandex-cloud }} resource, grant database access to the following IP ranges belonging to {{ datalens-short-name }} (the `/` character separates the subnet mask):

{% list tabs %}

- ipv4

  * `178.154.242.176/28`
  * `178.154.242.192/28`
  * `178.154.242.208/28`
  * `178.154.242.128/28`
  * `178.154.242.144/28`
  * `178.154.242.160/28`

- ipv6

  * `2a02:6b8:c03:500:0:f83d:a987:0/112`
  * `2a02:6b8:c02:900:0:f83d:a987:0/112`
  * `2a02:6b8:c0e:500:0:f83d:a987:0/112`

{% endlist %}

{% endnote %}

