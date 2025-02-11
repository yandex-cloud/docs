# Using the yandex-lemmer plugin in {{ mos-full-name }}


With `yandex-lemmer`, you can add a filter to [improve text search in Russian](../../managed-opensearch/concepts/plugins.md#yandex-lemmer) across {{ OS }} documents.

To test the plugin, compare [standard search results](#search-without-yandex-lemmer) to [`yandex-lemmer` search results](#search-with-yandex-lemmer) and then [refine your filter](#improve-search).

After testing, [delete](#clear-out) the created resources if you no longer need them.

## Getting started {#before-you-begin}

1. Prepare the infrastructure:

    {% list tabs group=instructions %}

    * Manually {#manual}

        1. [Create a {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-create.md#create-cluster) in desired configuration with the following settings:

            * `yandex-lemmer` and `analysis-icu` plugins enabled.
            * Public access to a group of hosts with the `DATA` role enabled.

        1. If using security groups in your cluster, make sure they are [configured correctly](../../managed-opensearch/operations/connect.md#configuring-security-groups) and allow connecting to the cluster.

    * Using {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [opensearch-yandex-lemmer.tf](https://github.com/yandex-cloud-examples/yc-opensearch-yandex-lemmer/blob/main/opensearch-yandex-lemmer.tf) configuration file to the same working directory. The file describes:

            * [Network](../../vpc/concepts/network.md#network).
            * [Subnet](../../vpc/concepts/network.md#subnet).
            * [Security group](../../vpc/concepts/security-groups.md) and rules required to connect to a {{ mos-name }} cluster.
            * {{ mos-name }} cluster.

        1. In the `opensearch-yandex-lemmer.tf` file, specify these variables:

            * `version`: {{ OS }} version.
            * `admin_password`: {{ OS }} admin password.

        1. Check that the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. [Install an SSL certificate](../../managed-opensearch/operations/connect.md#ssl-certificate).

1. Check the connection to the cluster using [cURL](https://curl.haxx.se/):

    {% include [default-connstring](../../_includes/mdb/mos/default-connstring.md) %}

    You can obtain the host FQDN with a [list of hosts in the cluster](../../managed-opensearch/operations/host-groups.md#list-hosts).

    A message like this is displayed if the connection is successful:

    ```bash
    {
      "name" : "....{{ dns-zone }}",
      "cluster_name" : "...",
      "cluster_uuid" : "...",
      "version" : {
      "distribution" : "opensearch",
      ...
      },
      "tagline" : "The OpenSearch Project: https://opensearch.org/"
    }
    ```

## Run a search without yandex-lemmer {#search-without-yandex-lemmer}

1. Add a document to the index named `simple-index`.

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request POST 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/simple-index/_doc?pretty' \
        --data '{
                  "book": "The Night It Rained",
                  "author": "Eugenia Riley"
                }'
    ```

    `simple-index` will be created automatically when you create the document. By default, indexes use the [built-in text analyzer]({{ os.docs }}/analyzers/supported-analyzers/index/#built-in-analyzers) named `Standard`.

1. Perform this search:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/simple-index/_search?pretty' \
        --data '{
                  "query": {
                    "query_string": {
                      "query": "book: when it rains"
                    }
                  }
                }'
    ```

    The result contains the following lines:

    ```bash
    ...
    "hits" : {
      "total" : {
        "value" : 0,
        "relation" : "eq"
      },
      "max_score" : null,
      "hits" : [ ]
    }
    ...
    ```

    The book was not found because of mismatch between the source document and the search query: `it rained` vs. `it rains`.

## Run a search with yandex-lemmer {#search-with-yandex-lemmer}

1. Create an index named `lemmer-index`, specify in it the `lemmer` analyzer parameters, and connect it for the `book` field:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request PUT "https://<address_of_{{ OS }}_host_with_DATA_role>:9200/lemmer-index?pretty" \
        --data '{
                  "mappings": {
                    "properties": {
                      "book": {
                        "type": "text",
                        "analyzer": "lemmer"
                      }
                    }
                  },
                  "settings": {
                    "analysis": {
                      "analyzer": {
                        "lemmer": {
                          "type": "custom",
                          "tokenizer": "standard",
                          "filter": [
                            "yandex_lemmer"
                          ]
                        }
                      }
                    }
                  }
                }'
    ```

1. Add a document to `lemmer-index`:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request POST 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/lemmer-index/_doc?pretty' \
        --data '{
                  "book": "The Night It Rained",
                  "author": "Eugenia Riley"
                }'
    ```

1. Perform this search:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/lemmer-index/_search?pretty' \
        --data '{
                  "query": {
                    "query_string": {
                      "query": "book: when it rains"
                    }
                  }
                }'
    ```

    The result contains the following lines:

    ```bash
    ...
    "hits" : {
      "total" : {
        "value" : 1,
        "relation" : "eq"
      },
      "max_score" : 0.9993168,
      "hits" : [
        {
          "_index" : "lemmer-index",
          "_id" : "zoGb_ZIB-3clfLPNjPbo",
          "_score" : 0.9993168,
          "_source" : {
            "book" : "The Night It Rained",
            "author" : "Eugenia Riley"
          }
        }
      ]
    }
    ...
    ```

    The book was found.

1. To see how the `lemmer` analyzer works, run this command:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/lemmer-index/_analyze?pretty' \
        --data '{"field":"book","text":"it rained"}'
    ```

    Result:

    ```bash
    {
      "tokens" : [
        {
          "token" : "rained",
          "start_offset" : 0,
          "end_offset" : 3,
          "type" : "<ALPHANUM>",
          "position" : 0
        },
        {
          "token" : "rain",
          "start_offset" : 0,
          "end_offset" : 3,
          "type" : "<ALPHANUM>",
          "position" : 0
        },
        {
          "token" : "it",
          "start_offset" : 4,
          "end_offset" : 9,
          "type" : "<ALPHANUM>",
          "position" : 1
        }
      ]
    }
    ```

    After getting through the `yandex_lemmer` filter, the `rained` token transforms into two tokens:

    * `rained`: Source token.
    * `rain`: Root form of `rained`.

    After getting through the `yandex_lemmer` filter, the `it` token remains unchanged because the source token matches the root form of the word.

## Refine your search {#improve-search}

To refine a text search, add more filters to `yandex-lemmer`:

* `nfc`: Performs [NFC normalization](https://www.unicode.org/faq/normalization.html) (text mapping), where the same letter is represented by different characters. This filter is available if the `analysis-icu` plugin is enabled.
* `lowercase`: Converts text to lower case.
* `yo_ye`: Repalces the letter "ё" with "е". `yandex-lemmer` does not distinguish between these letters (it will find both `ёлка` and `елка`), but such a replacement allows you to improve the percentage of analyzer cache hits and save some disk space.

To use additional filters:

1. Create an index named `index-with-filters` and add into it the `yandex-lemmer` filter and additional filters for the `lemmer-improved` analyzer:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request PUT "https://<address_of_{{ OS }}_host_with_DATA_role>:9200/index-with-filters?pretty" \
        --data '{
                  "mappings": {
                    "properties": {
                      "book": {
                        "type": "text",
                        "analyzer": "lemmer-improved"
                      }
                    }
                  },
                  "settings": {
                    "analysis": {
                      "filter": {
                        "nfc": {
                          "type": "icu_transform",
                          "id": "NFC"
                        },
                        "yo_ye": {
                          "type": "pattern_replace",
                          "pattern": "ё",
                          "replacement": "е"
                        }
                      },
                      "analyzer": {
                        "lemmer-improved": {
                          "type": "custom",
                          "tokenizer": "standard",
                          "filter": [
                            "nfc",
                            "lowercase",
                            "yo_ye",
                            "yandex_lemmer"
                          ]
                        }
                      }
                    }
                  }
                }'
    ```

1. Add a document to the index:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request POST "https://<address_of_{{ OS }}_host_with_DATA_role>.mdb.yandexcloud.net:9200/index-with-filters/_doc?pretty" \
        --data '{
                  "book": "Чёрный тюльпан",
                  "author": "Александр Дюма"
                }'
    ```

    Here, the letter "и" (code 1048) and the "˘" [breve](https://ru.wikipedia.org/wiki/Кратка) (code 774) are used instead of "й".

1. Perform this search:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/index-with-filters2/_search?pretty' \
        --data '{
                  "query": {
                    "query_string": {
                      "query": "book: черный тюльпан"
                    }
                  }
                }'
    ```

    Here, the book name includes the letter "й" (code 1049).

    The result contains the following lines:

    ```bash
    ...
    "hits" : {
      "total" : {
        "value" : 1,
        "relation" : "eq"
      },
      "max_score" : 0.2876821,
      "hits" : [
        {
          "_index" : "index-with-filters2",
          "_id" : "34EO_pIB-3clfLPNvvbY",
          "_score" : 0.2876821,
          "_source" : {
            "book" : "Чёрный тюльпан",
            "author" : "Александр Дюма"
          }
        }
      ]
    }
    ...
    ```

    The book was found.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

* Manually {#manual}

    [Delete the {{ mos-name }}](../../managed-opensearch/operations/cluster-delete.md) cluster.

* Using {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
