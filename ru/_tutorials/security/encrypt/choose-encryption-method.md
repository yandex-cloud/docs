# Какой способ шифрования выбрать?

В таблице ниже приведено сравнение шифрования средствами {{ yandex-cloud }} (CLI, API, SDK) и другими библиотеками (AWS Encryption SDK, Google Tink). Ознакомьтесь с таблицей и выберите наиболее подходящий для вас способ.

Особенность | [API](../../../kms/tutorials/encrypt/cli-api.md) | [CLI](../../../kms/tutorials/encrypt/cli-api.md) | [SDK](../../../kms/tutorials/encrypt/sdk.md) |  [Google Tink](../../../kms/tutorials/encrypt/google-tink.md) | [AWS Encryption SDK](../../../kms/tutorials/encrypt/aws-encryption-sdk.md) |
----|:---:|:---:|:---:|:---:|:---:|
Простота аутентификации| ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg) |
Неограниченный объем открытого текста при шифровании | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/yes.svg) | ![image](../../../_assets/common/yes.svg)|
Потоковое шифрование| ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/no.svg) | ![image](../../../_assets/common/yes.svg) |

Для шифрования данных большого объема рекомендуется использовать AWS Encryption SDK и Google Tink, так как они работают [по схеме envelope encryption](../../../kms/concepts/envelope.md).

Также вы можете самостоятельно реализовать схему envelope encryption с помощью API или SDK {{ yandex-cloud }} на основе криптографических методов, предоставляемых {{ kms-full-name }}.

{% note warning %}

Если вы хотите реализовать схему envelope encryption самостоятельно, учтите все [особенности реализации этой схемы](../../../kms/concepts/envelope.md#specify).

{% endnote %}
