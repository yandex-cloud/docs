1. [Get your cloud ready](#before-you-begin).
1. [Create and configure a public DNS zone](#configure-dns).
1. [Add a certificate to {{ certificate-manager-name }}](#add-certificate).
1. [Create a cloud network and subnets](#create-network).
1. [Create a security group](#create-security-group).
1. [Create a bucket in {{ objstorage-name }}](#create-buckets).
1. [Upload the file of your service to the bucket](#upload-files).
1. [Create an {{ alb-name }} backend group](#create-l7backend).
1. [Create an HTTP router and a virtual host](#create-route-hosts).
1. [Create an L7 load balancer](#create-balancer).
1. [Create a CDN resource](#create-cdn-resource).
1. [Create a CNAME resource record for the CDN resource](#create-cdn-cname-record).
1. [Test the service](#check).

If you no longer need the resources you created, [delete them](#clear-out).

## Supported tools {#supported-tools}

You can use various supported tools to perform these steps. You can complete most of the steps in this tutorial using any standard tool, such as the [management console]({{ link-console-main }}), [{{ yandex-cloud }} CLI](../../cli/index.yaml), and [{{ yandex-cloud }} API](../../api-design-guide/index.yaml). Each step lists its respective supported tools.

Some steps do not support certain tools: currently, you cannot [create an {{ alb-name }} backend group with buckets as backends](#create-l7backend) via the {{ yandex-cloud }} CLI.

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

We will use a folder named `example-folder` in our example.

### Required paid resources {#paid-resources}

{% include [paid-resources](../_tutorials_includes/cdn-storage-integration/paid-resources.md) %}

## Create and configure a public DNS zone {#configure-dns}

{% note info %}

This guide describes a scenario where [{{ dns-full-name }}](../../dns/index.yaml) handles domain management.

If you do not want to delegate management of your domain to {{ yandex-cloud }}, you can complete the required DNS setup using tools provided by your domain administrator. To create resource records, use your domain administrator’s tutorials or contact their support.

{% endnote %}

To configure a public DNS zone in the {{ yandex-cloud }} infrastructure:

1. {% include [delegate-domain](../_tutorials_includes/protected-access-to-content/delegate-domain.md) %}
1. Create a public [DNS zone](../../dns/concepts/dns-zone.md) in {{ dns-full-name }}.

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select `example-folder`.
      1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
      1. Click **{{ ui-key.yacloud.dns.button_zone-create }}**.
      1. Specify the zone settings consistent with your domain:

         1. **{{ ui-key.yacloud.dns.label_zone }}**: Domain zone. Its name must end with a trailing dot. For example, `example.com.` matches the `example.com` domain. To create a domain name with non-Latin characters, use the [Punycode](https://{{ lang }}.wikipedia.org/wiki/Punycode) encoding.
         1. **{{ ui-key.yacloud.common.type }}**: `{{ ui-key.yacloud.dns.label_public }}`.
         1. **{{ ui-key.yacloud.common.name }}**: `my-domain-zone`.

      1. Click **{{ ui-key.yacloud.common.create }}**.

    - {{ yandex-cloud }} CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run this command:

      ```bash
      yc dns zone create \
        --name my-domain-zone \
        --zone <domain_name> \
        --public-visibility
      ```

      Where `--zone` is your domain name, e.g., `example.com.`. The `--zone` parameter value must end with a trailing dot. For example, `example.com.` matches the `example.com` domain.

      Result:

      ```text
      id: dns6b0mdas5r********
      folder_id: b1gt6g8ht345********
      created_at: "2026-02-05T10:42:16.017Z"
      name: my-domain-zone
      zone: example.com.
      public_visibility: {}
      ```

      For more information about the `yc dns zone create` command, see the [CLI reference](../../cli/cli-ref/dns/cli-ref/zone/create.md).

    - API {#api}

      To create a public DNS zone, use the [create](../../dns/api-ref/DnsZone/create.md) REST API method for the [DnsZone](../../dns/api-ref/DnsZone/index.md) resource or the [DnsZoneService/Create](../../dns/api-ref/grpc/DnsZone/create.md) gRPC API call.

    {% endlist %}

## Add a certificate to {{ certificate-manager-name }} {#add-certificate}

{% include [certificate-usage](../../_includes/cdn/certificate-usage.md) %}

This guide describes a scenario where the CDN resource is issued a new Let's Encrypt® certificate.

1. Add a Let's Encrypt® [certificate](../../certificate-manager/concepts/managed-certificate.md) for your domain to {{ certificate-manager-name }}:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select `example-folder`.
      1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
      1. Click **{{ ui-key.yacloud.certificate-manager.button_empty-action }}** and select **{{ ui-key.yacloud.certificate-manager.action_request }}**.
      1. In the window that opens, specify `mymanagedcert` in the **{{ ui-key.yacloud.certificate-manager.metadata.field_name }}** field.
      1. In the **{{ ui-key.yacloud.certificate-manager.request.field_domains }}** field, enter a name for your domain, e.g., `example.com`.
      1. Select the [domain rights check type](../../certificate-manager/concepts/challenges.md) for `{{ ui-key.yacloud.certificate-manager.request.challenge-type_label_dns }}`.
      1. Click **{{ ui-key.yacloud.certificate-manager.request.button_request }}**.

    - {{ yandex-cloud }} CLI {#cli}

      Run this command:

      ```bash
      yc certificate-manager certificate request \
        --name mymanagedcert \
        --challenge dns \
        --domains <domain_name>
      ```

      Where `<domain_name>` is your domain name, e.g., `example.com`.

      Result:

      ```text
      id: fpq7t9dpi4o0********
      folder_id: b1gt6g8ht345********
      created_at: "2026-02-05T11:00:15.952968372Z"
      name: mymanagedcert
      type: MANAGED
      domains:
        - example.com
      status: VALIDATING
      updated_at: "2026-02-05T11:00:15.952968372Z"
      ```

      For more information about the `yc certificate-manager certificate request` command, see the [CLI reference](../../cli/cli-ref/certificate-manager/cli-ref/certificate/request.md).

      Save the ID (`id`) of the certificate you created, as you will need it when creating a CDN resource.

    - API {#api}

      To add a certificate, use the [requestNew](../../certificate-manager/api-ref/Certificate/requestNew.md) REST API method for the [Certificate](../../certificate-manager/api-ref/Certificate/) resource or the [CertificateService/RequestNew](../../certificate-manager/api-ref/grpc/Certificate/requestNew.md) gRPC API call.

    {% endlist %}

    A new certificate with the `Validating` status will appear in the certificate list. This status means that a Let's Encrypt® certificate was requested and you need to pass a [domain rights check](../../certificate-manager/operations/managed/cert-validate.md) for it to be successfully processed.

1. To successfully issue the certificate, pass a domain rights check:

    {% list tabs group=instructions %}

    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select `example-folder`.
        1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_certificate-manager }}**.
        1. From the list of certificates, select `mymanagedcert`.
        1. In the window that opens, under **{{ ui-key.yacloud.certificate-manager.overview.section_challenges }}**, select `CNAME record` and click **{{ ui-key.yacloud.component.dns-integration.button_add-domain }}** in the section with your domain below.
        1. In the window that opens, confirm creating the resource record.

        Checking rights for a domain may take from a few minutes to a few days. Wait until the check is complete. As a result, the certificate will be issued and get the `Issued` status.

    - {{ yandex-cloud }} CLI {#cli}

        1. Get the values of the resource record required for validation:

            ```bash
            yc certificate-manager certificate get \
              --name mymanagedcert \
              --full
            ```

            Result:

            ```text
            id: fpq7t9dpi4o0********
            folder_id: b1gt6g8ht345********
            created_at: "2026-02-05T11:00:15.952Z"
            name: mymanagedcert
            type: MANAGED
            domains:
              - example.com
            status: VALIDATING
            updated_at: "2026-02-05T11:00:15.952Z"
            challenges:
              - domain: example.com
                type: DNS
                created_at: "2026-02-05T11:00:15.952968372Z"
                updated_at: "2026-02-05T11:00:19.659820021Z"
                status: PENDING
                message: Create a record in your DNS provider.
                dns_challenge:
                  name: _acme-challenge.example.com.
                  type: CNAME
                  value: fpq7t9dpi4o0********.cm.yandexcloud.net.
              - domain: example.com
                type: DNS
                created_at: "2026-02-05T11:00:15.952968372Z"
                updated_at: "2026-02-05T11:00:19.659820021Z"
                status: PENDING
                message: Create a record in your DNS provider.
                dns_challenge:
                  name: _acme-challenge.example.com.
                  type: TXT
                  value: 77LcWo8-Qx4sHJuFDoNCpptLZkyWVW5A2dY********
            ```

            For more information about the `yc certificate-manager certificate get` command, see the [CLI reference](../../cli/cli-ref/certificate-manager/cli-ref/certificate/get.md).

            Save the value of the `value` field from the `CNAME` type section under `challenges.dns_challenge`. You will need this value in the next step.

        1. Create a CNAME [resource record](../../dns/concepts/resource-record.md) to pass a domain rights check:

            ```bash
            yc dns zone add-records \
              --name my-domain-zone \
              --record "_acme-challenge 600 CNAME <dns_challenge_value>"
            ```

            Where `<dns_challenge_value>` is the value you saved in the previous step, required for the domain rights check using a CNAME record.

            Result:

            ```text
            +--------+------------------------------+-------+------------------------------------------+-----+
            | ACTION |             NAME             | TYPE  |                   DATA                   | TTL |
            +--------+------------------------------+-------+------------------------------------------+-----+
            | +      | _acme-challenge.example.com. | CNAME | fpq7t9dpi4o0********.cm.yandexcloud.net. | 600 |
            +--------+------------------------------+-------+------------------------------------------+-----+
            ```

            For more information about the `yc dns zone add-records` command, see the [CLI reference](../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

            Checking rights for a domain may take from a few minutes to a few days. Wait until the check is complete. As a result, the certificate will be issued and get the `Issued` status.

        1. Make sure that the certificate status has switched to `Issued`:

            ```bash
            yc certificate-manager certificate get \
              --name mymanagedcert
            ```

            Result:

            ```text
            id: fpq7t9dpi4o0********
            folder_id: b1gt6g8ht345********
            created_at: "2026-02-05T11:00:15.952Z"
            name: mymanagedcert
            type: MANAGED
            domains:
              - example.com
            status: ISSUED
            issuer: CN=R12,O=Let's Encrypt,C=US
            subject: CN=example.com
            serial: 57bc7967996d73d63d9d52e337c********
            updated_at: "2026-02-05T13:29:23.658Z"
            issued_at: "2026-02-05T13:29:23.658Z"
            not_after: "2026-05-06T12:30:49Z"
            not_before: "2026-02-05T12:30:50Z"
            ```

            Save the certificate ID you got as you will need it later to create the CDN resource.

    - API {#api}

      To get the information required to pass the domain rights check, use the [get](../../certificate-manager/api-ref/Certificate/get.md) REST API method for the [Certificate](../../certificate-manager/api-ref/Certificate/) resource or the [CertificateService/Get](../../certificate-manager/api-ref/grpc/Certificate/get.md) gRPC API call with the `view=FULL` parameter.
      
      To create a CNAME resource record in a DNS zone, use the [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) REST API method for the [DnsZone](../../dns/api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md) gRPC API call.

    {% endlist %}

    {% note info %}

    {% include [checking-domain-rights-cname](../../_includes/certificate-manager/checking-domain-rights-cname.md) %}

    {% endnote %}

    If your domain is managed from outside {{ yandex-cloud }}, to create the resource record for the domain rights check, use tools provided by your domain administrator. For more information, see [{#T}](../../certificate-manager/concepts/challenges.md).

## Create a cloud network and subnets {#create-network}

All resources will belong to the same [cloud network](../../vpc/concepts/network.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. At the top right, click **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_name }}** field, specify `example-network`.
  1. In the **{{ ui-key.yacloud.vpc.networks.create.field_advanced }}** field, select `{{ ui-key.yacloud.vpc.networks.create.field_is-default }}`.
  1. Click **{{ ui-key.yacloud.vpc.networks.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Create a network named `example-network`:

      ```bash
      yc vpc network create example-network
      ```

      Result:

      ```text
        id: enpqm699f18v********
        folder_id: b1gt6g8ht345********
        created_at: "2026-02-05T11:57:02Z"
        name: example-network
        default_security_group_id: enp4qvbg2ri1********
      ```

      For more information about the `yc vpc network create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/network/create.md).

  1. Create subnets in all [availability zones](../../overview/concepts/geo-scope.md):

      * `{{ region-id }}-a`:

          ```bash
          yc vpc subnet create example-subnet-{{ region-id }}-a \
            --zone {{ region-id }}-a \
            --network-name example-network \
            --range 192.168.1.0/24
          ```

          Result:

          ```text
          id: e9b0fo0hvhpd********
          folder_id: b1gt6g8ht345********
          created_at: "2026-02-05T12:00:21Z"
          name: example-subnet-{{ region-id }}-a
          network_id: enpqm699f18v********
          zone_id: {{ region-id }}-a
          v4_cidr_blocks:
            - 192.168.1.0/24
          ```

          Save the subnet ID you got as you will need it later to create an L7 load balancer.

      * `{{ region-id }}-b`:

          ```bash
          yc vpc subnet create example-subnet-{{ region-id }}-b \
            --zone {{ region-id }}-b \
            --network-name example-network \
            --range 192.168.2.0/24
          ```

          Result:

          ```text
          id: e2lo05oe9slo********
          folder_id: b1gt6g8ht345********
          created_at: "2026-02-05T12:02:02Z"
          name: example-subnet-{{ region-id }}-b
          network_id: enpqm699f18v********
          zone_id: {{ region-id }}-b
          v4_cidr_blocks:
            - 192.168.2.0/24
          ```

          Save the subnet ID you got as you will need it later to create an L7 load balancer.

      * `{{ region-id }}-d`:

          ```bash
          yc vpc subnet create example-subnet-{{ region-id }}-d \
            --zone {{ region-id }}-d \
            --network-name example-network \
            --range 192.168.3.0/24
          ```

          Result:

          ```text
          id: fl8bpb6lnu80********
          folder_id: b1gt6g8ht345********
          created_at: "2026-02-05T12:03:23Z"
          name: example-subnet-{{ region-id }}-d
          network_id: enpqm699f18v********
          zone_id: {{ region-id }}-d
          v4_cidr_blocks:
            - 192.168.3.0/24
          ```

          Save the subnet ID you got as you will need it later to create an L7 load balancer.

      For more information about the `yc vpc subnet create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/subnet/create.md).

- API {#api}

  1. To create `example-network`, use the [create](../../vpc/api-ref/Network/create.md) REST API method for the [Network](../../vpc/api-ref/Network/index.md) resource or the [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md) gRPC API call.
  1. To create `example-subnet-{{ region-id }}-a`, `example-subnet-{{ region-id }}-b`, and `example-subnet-{{ region-id }}-d` in three availability zones, use the [create](../../vpc/api-ref/Subnet/create.md) REST API method for the [Subnet](../../vpc/api-ref/Subnet/index.md) resource or the [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md) gRPC API call.

{% endlist %}

## Create a security group {#create-security-group}

[Security groups](../../vpc/concepts/security-groups.md) contain rules that allow the L7 load balancer to receive incoming traffic and send it to backend buckets.

To create security groups:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**.
  1. At the top right, click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
  1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** field, specify `example-sg`.
  1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select `example-network`.
  1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, create the following rules [using the instructions below](../../vpc/operations/security-group-create.md):
   
      | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | Source /<br/>destination | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
      | --- | --- | --- | --- | --- | --- |
      | `Egress` | `any` | `All` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | `Ingress` | `ext-http` | `80` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | `Inbound` | `ext-https` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | `Inbound` | `healthchecks` | `30080` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}` | — |

  1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  Run this command:

  ```bash
  yc vpc security-group create example-sg \
    --network-name example-network \
    --rule "direction=egress,port=any,protocol=any,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=80,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=443,protocol=tcp,v4-cidrs=[0.0.0.0/0]" \
    --rule "direction=ingress,port=30080,protocol=tcp,predefined=loadbalancer_healthchecks"
  ```
  
  Result:
  
  ```text
  id: enp9dpfa774h********
  folder_id: b1gt6g8ht345********
  created_at: "2026-02-05T12:29:47Z"
  name: example-sg
  network_id: enpqm699f18v********
  status: ACTIVE
  rules:
    - id: enpa11mk1r50********
      direction: EGRESS
      protocol_name: ANY
      protocol_number: "-1"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
    - id: enp4aob2uiam********
      direction: INGRESS
      ports:
        from_port: "80"
        to_port: "80"
      protocol_name: TCP
      protocol_number: "6"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
    - id: enpn8onb4lda********
      direction: INGRESS
      ports:
        from_port: "443"
        to_port: "443"
      protocol_name: TCP
      protocol_number: "6"
      cidr_blocks:
        v4_cidr_blocks:
          - 0.0.0.0/0
    - id: enp6j82kiu2p********
      direction: INGRESS
      ports:
        from_port: "30080"
        to_port: "30080"
      protocol_name: TCP
      protocol_number: "6"
      predefined_target: loadbalancer_healthchecks
  ```

  Save the security group ID as you will need it later to create an L7 load balancer.

  For more information about the `yc vpc security-group create` command, see the [CLI reference](../../cli/cli-ref/vpc/cli-ref/security-group/create.md).

- API {#api}

  Use the [create](../../vpc/api-ref/SecurityGroup/create.md) REST API method for the [SecurityGroup](../../vpc/api-ref/SecurityGroup/index.md) resource or the [SecurityGroupService/Create](../../vpc/api-ref/grpc/SecurityGroup/create.md) gRPC API call.

  To add a rule for load balancer health checks, use the `loadbalancer_healthchecks` parameter in under [predefinedTarget](../../vpc/api-ref/SecurityGroup/create.md#yandex.cloud.vpc.v1.CreateSecurityGroupRequest) for the REST API or under [SecurityGroupRuleSpec.target.predefined_target](../../vpc/api-ref/grpc/SecurityGroup/create.md#yandex.cloud.vpc.v1.SecurityGroupRuleSpec) for the gRPC API.

{% endlist %}

## Create an {{ objstorage-name }} bucket {#create-buckets}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a unique [name](../../storage/concepts/bucket.md#naming) for the bucket.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** and **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** fields, select `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- {{ yandex-cloud }} CLI {#cli}

  Run this command, specifying the unique bucket [name](../../storage/concepts/bucket.md#naming):

  ```bash
  yc storage bucket create \
    --name <bucket_name> \
    --public-read \
    --public-list
  ```

  Result:

  ```text
  name: my-cdn-bucket
  folder_id: b1gt6g8ht345********
  anonymous_access_flags:
    read: true
    list: true
  default_storage_class: STANDARD
  versioning: VERSIONING_DISABLED
  created_at: "2026-02-05T12:35:03.639102Z"
  resource_id: e3e8qar9vrim********
  ```

- API {#api}

  Use the [create](../../storage/api-ref/Bucket/create.md) REST API method for the [Bucket](../../storage/api-ref/Bucket/index.md) resource or the [BucketService/Create](../../storage/api-ref/grpc/Bucket/create.md) gRPC API call.

{% endlist %}

## Upload the file of your service to the bucket {#upload-files}

1. {% include [create-index-html](../_tutorials_includes/cdn-storage-integration/create-index-html.md) %}
1. Upload the file to the bucket:

    {% list tabs group=instructions %}
    
    - Management console {#console}

        1. In the [management console]({{ link-console-main }}), select `example-folder`.
        1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
        1. Select the previously created bucket.
        1. Click ![arrow-up-from-line](../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}** and select the `index.html` file for uploading.
        1. In the window that opens, click **{{ ui-key.yacloud.storage.button_upload }}**.

    - {{ yandex-cloud }} CLI {#cli}

      Upload the `index.html` file to the bucket:

      ```bash
      yc storage s3api put-object \
        --bucket <bucket_name> \
        --key index.html \
        --content-type "text/html" \
        --body <local_path_to_file>
      ```

      Where:

      * `--bucket`: Name of the bucket you created earlier.
      * `--body`: Local path to the HTML file created earlier, e.g., `./index.html`.
      
      Result:
      
      ```text
      etag: '"2f613d0f35668e1d98fa9c6b********"'
      request_id: a809736f********
      ```

      For more information about the `yc storage s3api put-object` command, see the [CLI reference](../../storage/cli-ref/s3api/put-object.md).

   - API {#api}
   
     Use the [upload](../../storage/s3/api-ref/object/upload.md) REST API method.

   {% endlist %}

## Create an {{ alb-name }} backend group {#create-l7backend}

{% list tabs group=instructions %}
   
- Management console {#console}
   
  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.alb.label_backend-groups }}**.
  1. At the top right, click **{{ ui-key.yacloud.alb.button_backend-group-create }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify `example-bg`.
  1. In the **{{ ui-key.yacloud.alb.label_backend-type }}** field, select `{{ ui-key.yacloud.alb.label_proto-http }}` as the [backend group type](../../application-load-balancer/concepts/backend-group.md#group-types).
  1. Under **{{ ui-key.yacloud.alb.label_backends }}**, click **{{ ui-key.yacloud.common.add }}** and set up the backend:
      1. In the **{{ ui-key.yacloud.common.name }}** field, specify `example-backend`.
      1. In the **{{ ui-key.yacloud.alb.label_backend-weight }}** field, specify `100`.
      1. In the **{{ ui-key.yacloud.common.type }}** field, select `{{ ui-key.yacloud.alb.label_bucket }}` as the [backend type](../../application-load-balancer/concepts/backend-group.md#types).
      1. In the **{{ ui-key.yacloud.alb.label_bucket }}** field, select the bucket you created earlier.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  If you are going to complete the next steps in the {{ yandex-cloud }} CLI, copy the ID of the `example-bg` backend group as you will need it later.

- {{ yandex-cloud }} CLI {#cli}

  Currently, the {{ yandex-cloud }} CLI does not support creating a backend group with the `bucket` backend [type](../../application-load-balancer/concepts/backend-group.md#group-types). Use the management console or API to create the backend group.

- API {#api}

  Use the [create](../../application-load-balancer/api-ref/BackendGroup/create.md) REST API method for the [BackendGroup](../../application-load-balancer/api-ref/BackendGroup/index.md) resource or the [BackendGroupService/Create](../../application-load-balancer/api-ref/grpc/BackendGroup/create.md) gRPC API call.
     
{% endlist %} 

## Create an HTTP router and a virtual host {#create-route-hosts}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.alb.label_http-routers }}**.
  1. At the top right, click **{{ ui-key.yacloud.alb.button_http-router-create }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify `example-router`.
  1. Create a virtual host named `example-vh`:
  
     1. Under **{{ ui-key.yacloud.alb.label_virtual-hosts }}**, click **{{ ui-key.yacloud.alb.button_virtual-host-add }}**.
     1. In the **{{ ui-key.yacloud.common.name }}** field, specify `example-vh`.
     1. In the **{{ ui-key.yacloud.alb.label_authority }}** field, specify your domain name, e.g., `example.com`.
     1. Click **{{ ui-key.yacloud.alb.button_add-route }}**.
     1. In the **{{ ui-key.yacloud.common.name }}** field, specify `example-route`.
     1. In the **{{ ui-key.yacloud.alb.label_path }}** field, select `{{ ui-key.yacloud.alb.label_match-prefix }}` and specify the `/` path.
     1. From the **{{ ui-key.yacloud.alb.label_http-methods }}** list, select `GET`.
     1. In the **{{ ui-key.yacloud.alb.label_route-action }}** field, keep `{{ ui-key.yacloud.alb.label_route-action-route }}`.
     1. From the **{{ ui-key.yacloud.alb.label_backend-group }}** list, select `example-bg`.

  1. Do not change the other settings. Click **{{ ui-key.yacloud.common.create }}**.
  
- {{ yandex-cloud }} CLI {#cli}

  1. Create an HTTP router `example-router`:
  
      ```bash
      yc alb http-router create example-router
      ```
      
      Result:
      
      ```text
      id: ds78i77j8lg0********
      name: example-router
      folder_id: b1gt6g8ht345********
      created_at: "2026-02-05T13:09:27.917359782Z"
      ```
      
      For more information about the `yc alb http-router create` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/http-router/create.md).

  1. Create a virtual host named `example-vh`:
  
      ```bash
      yc alb virtual-host create example-vh \
        --http-router-name example-router \
        --authority <domain_name>
      ```

      Where `<domain_name>` is your domain name, e.g., `example.com`.
      
      Result:
      
      ```text
      done (1s)
      name: example-vh
      authority:
        - example.com
      ```
      
      For more information about the `yc alb virtual-host create` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/create.md).
     
  1. Create a route named `example-route` in the `example-vh` virtual host:
  
      ```bash
      yc alb virtual-host append-http-route example-route \
        --http-router-name example-router \
        --virtual-host-name example-vh \
        --prefix-path-match "/" \
        --backend-group-name example-bg
      ```
      
      Result:
      
      ```text
      done (1s)
      name: example-vh
      authority:
        - example.com
      routes:
        - name: example-route
          http:
            match:
              path:
                prefix_match: /
            route:
              backend_group_id: ds7glpil29lb********
      ```

      For more information about the `yc alb virtual-host append-http-route` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/virtual-host/append-http-route.md).

- API {#api}

  1. To create the `example-router` HTTP router, use the [create](../../application-load-balancer/api-ref/HttpRouter/create.md) REST API method for the [HttpRouter](../../application-load-balancer/api-ref/HttpRouter/index.md) resource or the [HttpRouterService/Create](../../application-load-balancer/api-ref/grpc/HttpRouter/create.md) gRPC API call.
  1. To create the `example-vh` virtual host associated with the router, use the [create](../../application-load-balancer/api-ref/VirtualHost/create.md) REST API method for the [VirtualHost](../../application-load-balancer/api-ref/VirtualHost/index.md) resource or the [VirtualHostService/Create](../../application-load-balancer/api-ref/grpc/VirtualHost/create.md) gRPC API call.

{% endlist %}

## Create an L7 load balancer {#create-balancer}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. At the top right, click **{{ ui-key.yacloud.alb.button_load-balancer-create }}** and select **{{ ui-key.yacloud.alb.label_alb-create-form }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify `example-balancer`.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**:

     1. In the **{{ ui-key.yacloud.mdb.forms.label_network }}** field, select `example-network`.
     1. In the **{{ ui-key.yacloud.mdb.forms.field_security-group }}** field, select `{{ ui-key.yacloud.component.security-group-field.label_sg-from-list }}` and then, from the list that opens, the `example-sg` security group you created earlier.
      
  1. Under **{{ ui-key.yacloud.alb.section_allocation-settings }}**, select the three subnets for the load balancer nodes (`example-subnet-{{ region-id }}-a`, `example-subnet-{{ region-id }}-b`, and `example-subnet-{{ region-id }}-d`) and enable traffic to these subnets.
  1. Under **{{ ui-key.yacloud.alb.label_listeners }}**, click **{{ ui-key.yacloud.alb.button_add-listener }}** and set up the listener:
  
     1. In the **{{ ui-key.yacloud.common.name }}** field, specify `example-listener`.
     1. Under **{{ ui-key.yacloud.alb.section_external-address-specs }}**:
        * In the **{{ ui-key.yacloud.alb.label_port }}** field, specify `80`.
        * In the **{{ ui-key.yacloud.common.type }}** field, select `{{ ui-key.yacloud.alb.label_address-auto }}`.
      
  1. In the **{{ ui-key.yacloud.alb.label_http-router }}** field, select `example-router`.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  
- {{ yandex-cloud }} CLI {#cli}

  1. Create a load balancer named `example-balancer`:
  
      ```bash
      yc alb load-balancer create example-balancer \
        --network-name example-network \
        --security-group-id <example-sg_security_group_ID> \
        --location zone={{ region-id }}-a,subnet-id=<example-subnet-{{ region-id }}-a_ID> \
        --location zone={{ region-id }}-b,subnet-id=<example-subnet-{{ region-id }}-b_ID> \
        --location zone={{ region-id }}-d,subnet-id=<example-subnet-{{ region-id }}-d_ID>
      ```

      Where:

      * `--security-group-id`: Security group ID you saved when creating the security group.
      * `subnet_id`: Subnet IDs in three availability zones you saved when creating the subnets.
        
      Result:
      
      ```text
      done (7m17s)
      id: ds790ardig7r********
      name: example-balancer
      folder_id: b1gt6g8ht345********
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: enpqm699f18v********
      allocation_policy:
        locations:
          - zone_id: {{ region-id }}-a
            subnet_id: e9b0fo0hvhpd********
          - zone_id: {{ region-id }}-b
            subnet_id: e2lo05oe9slo********
          - zone_id: {{ region-id }}-d
            subnet_id: fl8bpb6lnu80********
      security_group_ids:
        - enp9dpfa774h********
      created_at: "2026-02-05T13:30:25.695763710Z"
      ```
      
      For more information about the `yc alb load-balancer create` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/load-balancer/create.md).
     
  1. Add a listener to the load balancer:
  
      ```bash
      yc alb load-balancer add-listener \
        --name example-balancer \
        --listener-name example-listener \
        --external-ipv4-endpoint port=80 \
        --http-router-name example-router
      ```
      
      Result:
      
      ```text
      done (9m53s)
      id: ds790ardig7r********
      name: example-balancer
      folder_id: b1gt6g8ht345********
      status: ACTIVE
      region_id: {{ region-id }}
      network_id: enpqm699f18v********
      listeners:
        - name: example-listener
          endpoints:
            - addresses:
                - external_ipv4_address:
                    address: 158.160.***.***
              ports:
                - "80"
          http:
            handler:
              http_router_id: ds78i77j8lg0********
      allocation_policy:
        locations:
          - zone_id: {{ region-id }}-a
            subnet_id: e9b0fo0hvhpd********
          - zone_id: {{ region-id }}-b
            subnet_id: e2lo05oe9slo********
          - zone_id: {{ region-id }}-d
            subnet_id: fl8bpb6lnu80********
      security_group_ids:
        - enp9dpfa774h********
      ```

      Save the listener IP address (the `address` field value), as you will need it later to create a CDN resource.

      For more information about the `yc alb load-balancer add-listener` command, see the [CLI reference](../../cli/cli-ref/application-load-balancer/cli-ref/load-balancer/add-listener.md).

- API {#api}

  To create an L7 load balancer, use the [create](../../application-load-balancer/api-ref/LoadBalancer/create.md) REST API method for the [LoadBalancer](../../application-load-balancer/api-ref/LoadBalancer/index.md) resource or the [LoadBalancerService/Create](../../application-load-balancer/api-ref/grpc/LoadBalancer/create.md) gRPC API call.
          
{% endlist %}

## Create a CDN resource {#create-cdn-resource}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.
  1. Click **{{ ui-key.yacloud.cdn.button_resource-create }}**.
  1. Configure the basic CDN resource settings:

      * Under **{{ ui-key.yacloud.cdn.label_section-content }}**:

          * Enable **{{ ui-key.yacloud.cdn.label_access }}**.
          * In the **{{ ui-key.yacloud.cdn.label_content-query-type }}** field, select `{{ ui-key.yacloud.cdn.value_query-type-one-origin }}`.
          * In the **{{ ui-key.yacloud.cdn.label_source-type }}** field, select `{{ ui-key.yacloud.cdn.value_source-type-balancer }}` and then, in the field that appears, `example-balancer`.
          * In the **{{ ui-key.yacloud.cdn.label_ip-address }}** field, select the IP address assigned to the load balancer (the only one in the list).
          * In the **{{ ui-key.yacloud.cdn.label_protocol }}** field, select `{{ ui-key.yacloud.common.label_http }}`.
          * In the **{{ ui-key.yacloud.cdn.label_personal-domain }}** field, specify your domain name, e.g., `example.com`.

              {% note alert %}

              The specified domain name will become the primary one, and you will not be able to edit it after you create a CDN resource.

              {% endnote %}

      * Under **{{ ui-key.yacloud.cdn.label_section-additional }}**:

          * In the **{{ ui-key.yacloud.cdn.label_redirect }}** field, select `{{ ui-key.yacloud.cdn.value_redirect-http-to-https }}`.
          * In the **{{ ui-key.yacloud.cdn.label_certificate-type }}** field, specify `{{ ui-key.yacloud.cdn.value_certificate-custom }}` and select the `mymanagedcert` [certificate](#add-certificate) you previously created for your domain name.
          * In the **{{ ui-key.yacloud.cdn.label_host-header }}** field, select `{{ ui-key.yacloud.cdn.value_host-header-resend }}`.
  1. Click **{{ ui-key.yacloud.common.continue }}**.
  1. Keep the default settings for **{{ ui-key.yacloud.cdn.label_resource-cache }}**, **{{ ui-key.yacloud.cdn.label_resource-http-headers }}**, and **{{ ui-key.yacloud.cdn.value_stepper-additional }}** and click **{{ ui-key.yacloud.common.continue }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Create an origin group named `example-origin-group`, specifying the load balancer IP address you saved earlier:

      ```bash
      yc cdn origin-group create --name "example-origin-group" \
        --origin source=<load_balancer_IP_address>:80,enabled=true
      ```

      Result:

      ```text
      id: "12756795849********"
      folder_id: b1gt6g8ht345********
      name: example-origin-group
      use_next: true
      origins:
        - id: "68784"
          origin_group_id: "12756795849********"
          source: 158.160.***.***:80
          enabled: true
          provider_type: ourcdn
      provider_type: ourcdn
      ```

      Save the origin group ID (the `origin_group_id` field value), as you will need it later to create a CDN resource.

      For more information about the `yc cdn origin-group create` command, see the [CLI reference](../../cli/cli-ref/cdn/cli-ref/origin-group/create.md).

  1. Create a CDN resource:
  
      ```bash
      yc cdn resource create \
        --cname <domain_name> \
        --origin-group-id <origin_group_ID> \
        --origin-protocol http \
        --cert-manager-ssl-cert-id <certificate_ID> \
        --forward-host-header
      ```

      Where:

      * `--cname`: Your domain's name, e.g., `example.com`.
      * `--origin-group-id`: Origin group ID you got in the previous step.
      * `--cert-manager-ssl-cert-id`: ID of the `mymanagedcert` certificate you created [earlier](#add-certificate).

      Result:

      ```text
      id: bc8rpt67l6dl********
      folder_id: b1gt6g8ht345********
      cname: example.com
      created_at: "2026-02-05T14:05:24.913996Z"
      updated_at: "2026-02-05T14:05:24.913996Z"
      active: true
      options:
        edge_cache_settings:
          enabled: true
          default_value: "86400"
        browser_cache_settings: {}
        query_params_options:
          ignore_query_string:
            enabled: true
            value: true
        slice: {}
        host_options:
          forward_host_header:
            enabled: true
            value: true
        static_headers:
          enabled: true
        stale: {}
        allowed_http_methods:
          enabled: true
          value:
            - GET
            - HEAD
            - OPTIONS
        static_request_headers:
          enabled: true
        custom_server_name: {}
        ignore_cookie:
          enabled: true
          value: true
        secure_key:
          type: DISABLE_IP_SIGNING
      origin_group_id: "12756795849********"
      origin_group_name: example-origin-group
      origin_protocol: HTTP
      ssl_certificate:
        type: CM
        status: READY
        data:
          cm:
            id: fpq7t9dpi4o0********
      provider_type: ourcdn
      provider_cname: d88c6ee6********.topology.gslb.yccdn.ru
      ```

      Save the new resource `id` and `provider_cname` as you will need them later.

      For more information about the `yc cdn resource create` command, see the [CLI reference](../../cli/cli-ref/cdn/cli-ref/resource/create.md).

  1. Enable client redirects for the CDN resource, specifying the ID you saved in the previous step:

      ```bash
      yc cdn resource update <CDN_resource_ID> \
        --redirect-http-to-https
      ```

      For more information about the `yc cdn resource update` command, see the [CLI reference](../../cli/cli-ref/cdn/cli-ref/resource/update.md).

- API {#api}

  To create a CDN resource, use the [create](../../cdn/api-ref/Resource/create.md) REST API method for the [Resource](../../cdn/api-ref/Resource/index.md) resource or the [ResourceService/Create](../../cdn/api-ref/grpc/Resource/create.md) gRPC API call.
  
{% endlist %}

## Create a CNAME resource record for the CDN resource {#create-cdn-cname-record}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Get](../../cdn/operations/resources/get-resources-info.md#get-cname) the CDN provider domain name value.
  1. In the [management console]({{ link-console-main }}), select `example-folder`.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}** and select the DNS zone you created [earlier](#configure-dns).
  1. Click **{{ ui-key.yacloud.dns.button_record-set-create }}**.
  1. Specify the record settings:

        * In the **{{ ui-key.yacloud.common.name }}** field, select `{{ ui-key.yacloud.dns.label_fqdn-equal-to-zone }}`.
        * In the **{{ ui-key.yacloud.common.type }}** field, select the `CNAME` [record type](../../dns/concepts/resource-record.md#rr-types).
        * In the **{{ ui-key.yacloud.dns.label_records }}** field, specify the [domain name](../../cdn/operations/resources/get-resources-info.md#get-cname) value of the CDN provider.

  1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Create a CNAME resource record in {{ dns-name }}:

      ```bash
      yc dns zone add-records \
        --name my-domain-zone \
        --record "@ 600 CNAME <cname_value>"
      ```

      Where `<cname_value>` is the CNAME provider value you got ealier.

      Result:

      ```text
      +--------+--------------+-------+-----------------------------------------+-----+
      | ACTION |     NAME     | TYPE  |                  DATA                   | TTL |
      +--------+--------------+-------+-----------------------------------------+-----+
      | +      | example.com. | CNAME | d88c6ee6********.topology.gslb.yccdn.ru | 600 |
      +--------+--------------+-------+-----------------------------------------+-----+
      ```

      For more information about the `yc dns zone add-records` command, see the [CLI reference](../../cli/cli-ref/dns/cli-ref/zone/add-records.md).

- API {#api}

  To get the CNAME record value for a CDN resource, use the [getProviderCName](../../cdn/api-ref/Resource/getProviderCName.md) REST API method for the [Resource](../../cdn/api-ref/Resource/index.md) resource or the [ResourceService/GetProviderCName](../../cdn/api-ref/grpc/Resource/getProviderCName.md) gRPC API call.

  To create a CNAME resource record in a DNS zone, use the [updateRecordSets](../../dns/api-ref/DnsZone/updateRecordSets.md) REST API method for the [DnsZone](../../dns/api-ref/DnsZone/index.md) resource or the [DnsZoneService/UpdateRecordSets](../../dns/api-ref/grpc/DnsZone/updateRecordSets.md) gRPC API call.

{% endlist %}

{% include [after-creation-tip-tutorials](../../_includes/cdn/after-creation-tip-tutorials.md) %}

If your domain is managed from outside {{ yandex-cloud }}, to create the resource record for the CDN resource, use tools provided by your domain administrator. For more information, see [{#T}](../../certificate-manager/concepts/challenges.md).

## Test the service {#check}

{% include [test](../_tutorials_includes/cdn-storage-integration/test.md) %}

## How to delete the resources you created {#clear-out}

To shut down the infrastructure and stop paying for the resources you created:

1. If you set up CNAME records in {{ dns-name }}, [delete](../../dns/operations/zone-delete.md) `example-dns-zone`.
1. Delete the CDN resource with `example.com` as its primary domain name.
1. [Delete](../../application-load-balancer/operations/application-load-balancer-delete.md) the `example-balancer` L7 load balancer.
1. [Delete](../../storage/operations/objects/delete.md) all objects from the bucket.
1. [Delete](../../storage/operations/buckets/delete.md) the bucket.
1. [Delete](../../vpc/operations/subnet-delete.md) the `example-subnet-{{ region-id }}-a`, `example-subnet-{{ region-id }}-b`, and `example-subnet-{{ region-id }}-d` subnets.
1. [Delete](../../vpc/operations/security-group-delete.md) the `example-sg` security group.
1. [Delete](../../vpc/operations/network-delete.md) `example-network`.
1. [Delete](../../certificate-manager/operations/managed/cert-delete.md) the `mymanagedcert` certificate if you no longer need it.