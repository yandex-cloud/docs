# Entity naming rules

This section lists conventions used for naming entities

in {{ yandex-cloud }} APIs. By entities we mean resources, methods, messages, fields, and so on.

## Product naming

Full names are defined for all {{ yandex-cloud }} products. Usually, a full name is used in the service documentation and web interface. Abbreviations are allowed for some products and can also be used in documentation to make it easier to read.

All services also have their Russian-language names defined. They are used in legal and accounting documents.

Below are the names for one {{ yandex-cloud }} service.

| Type of name | Example |
| ----- | ----- |
| Full product name | {{ compute-full-name }} |
| Abbreviated name | {{ compute-name }} |
| Name for legal documents | Cloud computing ({{ compute-full-name }}) |
| API name (used in the documentation URL, in the domain name) | compute |
| Repository path | yandex/cloud/compute/v1/ |
| Package name in .proto files | compute |
| Interface names in .proto files | compute.DiskService, compute.InstanceService, and so on. |

## Domain names

Service domain names conform to [RFC 1035](https://www.ietf.org/rfc/rfc1035.txt)
and are based on the \<service>.{{ api-host }} pattern. For example, 
{{ compute-full-name }} will have a domain like: compute.{{ api-host }}.

## Package naming

Package names are specified in .proto files and based on the yandex.cloud.\<service>.\<version> pattern.
For example, the {{ compute-full-name }} package:

> ```
> package yandex.cloud.compute.v1;
> ```

## Interface naming (service in gRPC)

An interface defines a set of methods available for a resource. Interface descriptions are
given in the `service` directive.
Interfaces have compound names formed by adding the <q>Service</q>
suffix to the resource name. For example:

> ```
> service DiskService {
>  ...
> }
> ```

{% note info %}

The term "interfaces" is introduced to avoid confusion between a service in gRPC terms and a service in {{ yandex-cloud }} terms.

{% endnote %}

## Method naming
Methods called in relation to a single object are named by a single verb. For example, Get is a method used to get a disk.

> ```
> rpc Get (GetDiskRequest) returns (Disk) {
>  option (google.api.http) = { get: "/compute/v1/disks/{disk_id}" };
> }
> ```

Methods that perform an action on one object relative to another one
have compound names. For example, attach a disk to a VM.

Names of such methods are written in CamelCase and based on the <q>ActionObject</q> pattern. For example, AttachDisk.

> ```
> rpc AttachDisk (AttachInstanceDiskRequest) returns (operation.Operation) {
>  option (yandex.api.operation) = {
>    metadata: "AttachInstanceDiskMetadata"
>    response: "Instance"
>  };
>  option (google.api.http) = { post: "/compute/v1/instances/{instance_id}:attachDisk" body: "*"};
> }
> ```
Method names may contain prepositions (<q>At</q>, <q>By</q>, or <q>From</q>).

> ```
> rpc GetLatestByFamily (GetImageLatestByFamilyRequest) returns (Image) {
>   option (google.api.http) = { get: "/compute/v1/images:latestByFamily" };
> }
> ```

## gRPC message naming

Messages that describe a request/response are named according to the
<q>method name + Request/Response suffix</q> pattern.

For example:

> ```
> message ListDiskTypesRequest {
>   int64 page_size = 1;
>   string page_token = 2;
> }
> 
> message ListDiskTypesResponse {
>   repeated DiskType disk_types = 1;
>   string next_page_token = 2;
> }
> ```

Names for messages that describe resource views contain nouns.
Compound names are allowed. Examples: <q>Disk</q>, <q>DiskType</q>.

> ```
> message Disk {
> ...
> }
> ```

## Naming fields {#naming-rules}

Fields are named according to the <q>lower_case_underscore</q> principle. For example,
<q>folder_id</q>.

The names of fields that designate time use the postfix
<q>At</q>. For example, `created_at`.

To indicate the passive voice, the field name uses the postfix
<q>By</q> (that is, if the field answers the questions <q>Who? By whom?</q>).

For example, `created_by`.


## Then we describe all types of fields (enum, repeated, etc.).
