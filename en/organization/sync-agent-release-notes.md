---
title: '{{ org-sync-agent-name }} releases'
description: This page presents a list of sync agent releases and the updates of each.
---

# {{ org-sync-agent-name }} releases

## Current version {#latest-release}

### Version 0.40.0 (10/03/26) {#version0.40.0}

#### Changes to {{ org-sync-agent-name }}

* Now you can get an IAM token from the metadata service to access the {{ org-full-name }} API.

{% cut "Checksums" %}

| Platform   | Checksum (sha-256) |
|-------------|-----------------------------|
| `linux/amd64` | `c999643fd28d08076ff1d25ddf11e56a4a854fa4f2189109994b68d33974f698` |
| `linux/arm64` | `74462de7defbd5beacab48d181697eb8d5efafbd198ff9ee55a38f9e34f38df5` |
| `darwin/amd64` | `42a80a36d1d91bb095df3db1a57bc9f4002bcea30ecb87edf922d82c4aa16b96` |
| `darwin/arm64` | `5b5f5a8ac35b3eef908ee4bf67414cbf58cd4be5b7d55cf3f67f10604ca17f78` |
| `windows/amd64` | `d1e8c771afff4a08eb4fcc23dcba0352796a3f67ede7a9329650a3c4b5a8c12c` |
| `windows/arm64` | `bd490392a86f809b66f70416f779058147d19f1f8700f4a30e62b2f17a202000` |

{% endcut %}

### Version 0.39.0 (27/02/26) {#version0.39.0}

#### Changes to {{ org-sync-agent-name }} {#changes-version0.39.0}

* Added the `use_session_api` setting to run multiple agents simultaneously.  

* Changed the validation of groups and organization units in the filter.  

* Fixed an issue where a password hash was missing when moving an entire organization unit into another.  

* Added new attributes: `employee_id`, `department`, `company_name`, and `job_title`.  

{% cut "Checksums" %}

| Platform   | Checksum (sha-256) |
|-------------|-----------------------------|
| `linux/amd64` | `03d148741cc24631d6d7a5385f4571ec91291de0e517387d38011183eda793e4` |
| `linux/arm64` | `2300e3f421094db85d7c339a35af33973da8afb21e51d4bda6c81cf1c1e18e8c` |
| `darwin/amd64` | `0e7e693ecefe8aa4c7c49569cbc6fee674c0d6a8172ef349916578c04c0fe9b4` |
| `darwin/arm64` | `ed1c8ab0117531b6732bb522ee9343af525511fbabe09d8e0c6eb55830582a5a` |
| `windows/amd64` | `0d86277fdb4ebd5483c2cdcebb2eb3cf6e39e5cdf8c7a82193ccf1011c49c31a` |
| `windows/arm64` | `4c2219e7abd00747c3422425456300d98775c426ba46e7fe73f4bc7d6fe30510` |

{% endcut %}

### Version 0.38.0 (8/12/25) {#version0.38.0}

#### Changes in the {{ org-full-name }} sync agent {#changes-version0.38.0}

* Fixed incorrect parsing of AD objects containing unknown attributes.

* Fixed CN escaping in LDAP filters.

{% cut "Checksums" %}

| Platform   | Checksum (sha-256) |
|-------------|-----------------------------|
| `linux/amd64` | `87ccbc96e8d99baa6353d97688643f3b9284cfa01b4cde8982884c4620e73ae7` |
| `linux/arm64` | `083d112c4bdf7d9ffbe89e6744120f657dd8da2ec8186156009a4e2d199c99ad` |
| `darwin/amd64` | `077fde2da16904c288638f284626db34ff4758aa64d7d1483f54cd713c451bc2` |
| `darwin/arm64` | `a79770081bf4943380613e73d45a43036922dd43b2f0e65e39e41c2fe520a05f` |
| `windows/amd64` | `d9a9b6b4475c02d26a2f489ba0c62c37b468f763366cc265e9ea4859badc2fd2` |
| `windows/arm64` | `89cf257f59abd98c191fa2329899c473b24a586fc54a1a3bf9eebfd976265067` |

{% endcut %}

### Version 0.37.0 (28/11/25) {#version0.37.0}

#### Changes in the {{ org-full-name }} sync agent {#changes-version0.37.0}

* The `replacement_domain` value is now substituted regardless of whether the UPN domain matches the domain in the filter.

{% cut "Checksums" %}

| Platform   | Checksum (sha-256) |
|-------------|-----------------------------|
| linux/amd64 | `1e5326bec14143fce1a1ba0ce4e7526dba386d8359228be1395cb4d52e8e118e` |
| linux/arm64 | `91f704dc50224cd9f4d4510025ad3dc96a88f72c46b0dece4fd7016bc6e88c05` |
| darwin/amd64 | `d5c4a2494f46900b8fa363cb438df9e6d36dbdaf8f5d2c8b5045e212c981f96e` |
| darwin/arm64 | `14921f083d91229ec5f86049993c3b7272dcb39722528c396405acd088b227b3` |
| windows/amd64 | `706dfb4814cd581473187245e8336267d5a720f7c512ad14db167f05ef15f43f` |
| windows/arm64 | `cf0bf71bd9dd17cc89dc514f90c7637d1df1929d1e35db29f86d9a2957535e29` |

{% endcut %}
