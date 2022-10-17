# Compliance

{% if product == "yandex-cloud" %}

## Russian Federal law No. 152-FZ "On personal data" {#law}

In {{ yandex-cloud }}, measures were implemented to protect personal data pursuant to Resolution No. 1119 and FSTEC Order No. 21 regarding requirements for 1st-level protection (UZ-1).

When a client, acting as an operator, places personal data on {{ yandex-cloud }} resources, the client entrusts {{ yandex-cloud }} to process this data. {{ yandex-cloud }} is committed to respecting the confidentiality of personal data, ensuring its security during processing, and meeting all legal requirements pertaining to the protection of processed personal data.

For more information, see:

* [Certificate of conformance](https://storage.yandexcloud.net/yc-compliance/conformance_ru_certificate.pdf).
* [Statement of compliance of the Personal Data Protection System with the Requirements of Federal Law No. 152 "On Personal Data"]{% if lang == "ru" %}(https://storage.yandexcloud.net/yc-compliance/conformance_ru_pdp.pdf){% endif %}{% if lang == "en" %}(https://storage.yandexcloud.net/yc-compliance/conformance_en_pdp.pdf){% endif %}.
* [Data Processing Agreement]{% if lang == "ru" %}(https://yandex.ru/legal/cloud_dpa/?lang=ru){% endif %}{% if lang == "en" %}(https://yandex.ru/legal/cloud_dpa/?lang=en){% endif %}.
* [Customer actions to protect personal data]{% if lang == "ru" %}(https://storage.yandexcloud.net/yc-compliance/recomendations/FZ-152-RU.pdf){% endif %}{% if lang == "en" %}(https://storage.yandexcloud.net/yc-compliance/recomendations/FZ-152-EN.pdf){% endif %}.

## GDPR (General Data Protection Regulation) {#gdpr}

The General Data Protection Regulation (GDPR) regulates the collection and processing of personal data of individuals who reside in the European Economic Area. It was designed to strengthen data privacy protection and ensure the transparency of data collection, storage, and processing on the internet.

{{ yandex-cloud }} meets key GDPR requirements. Procedures have been put in place to process requests from personal data subjects regarding personal data receipt, modification, and deletion. Data protection measures have been implemented and a procedure for notifying users of incidents has also been established.

For more information, see the [Data Processing Addendum](https://yandex.com/legal/cloud_dpa/).

{% endif %}

## ISO certification {#iso}

{% if product == "yandex-cloud" %}

The {{ yandex-cloud }} Information Security Management System (ISMS) satisfies the requirements of the International Organization for Standardization (ISO). This is evidenced by certificates of compliance for ISO 27001, ISO 27017, and ISO 27018.

ISO 27001 defines the requirements for information security (IS) management systems, including their implementation, operation, maintenance, and regular improvement. The ISO 27001 guidelines help organizations guarantee a high level of security for their core information assets.

ISO 27017 includes a set of practical information security recommendations for cloud providers. These recommendations supplement the ISMS implementation requirements set out in ISO 27001 and are intended for cloud service providers.

ISO 27018 addresses the requirements for the security of personal data processed by cloud service providers. The standard sets out information security guidelines for protecting the personal information of clients. They supplement the requirements of the basic standard, ISO 27001.

[ISO 27001/27017/27018 certificate](https://storage.yandexcloud.net/yc-compliance/certificates/ISO_27001_Certificate_TUV_AUSTRIA_SC_092022_EN.pdf).

{% endif %}

{% if product == "cloud-il" %}

ISO 27001 defines the requirements for information security (IS) management systems, including their implementation, operation, maintenance, and regular improvement. The ISO 27001 guidelines help organizations guarantee a high level of security for their core information assets.

[ISO 27001 certificate](https://storage.cloudil.com/cloudil-compliance/ISO%20certificates/%D7%A7%D7%9C%D7%90%D7%95%D7%93.%20%D7%90%D7%99%D7%99%20%D7%90%D7%9C%20%D7%A1%D7%99%D7%A1%D7%98%D7%9E%D7%A1-1.pdf).

{% endif %}

{% if product == "yandex-cloud" %}

## PCI DSS {#pci-dss}

PCI DSS (Payment Card Industry Data Security Standard) contains a set of requirements for cardholder data protection. They are mandatory and apply to all companies that process data from payment systems like Visa, MasterCard, American Express, JCB, and MIR.

By ensuring that our cloud infrastructure meets PCI DSS requirements, we enable {{ yandex-cloud }} clients to use cloud services to process payment card data with verified high levels of security.

{{ yandex-cloud }} has a certificate of compliance with PCI DSS v3.2.1. Compliance with the standard is checked by a QSA auditor on an annual basis.

For more information, see:

* [PCI DSS certificate for {{ yandex-cloud }}]{% if lang == "ru" %}(https://storage.yandexcloud.net/yc-compliance/certificates/PCI_DSS_Yandex_Cloud_RU.pdf){% endif %}{% if lang == "en" %}(https://storage.yandexcloud.net/yc-compliance/certificates/PCI_DSS_Yandex_Cloud_EN.pdf){% endif %}.
* [PCI DSS certificate for the Yandex data center](https://storage.yandexcloud.net/yc-compliance/certificates/PCI_DSS_Yandex.pdf).
* [PCI DSS Attestation of Compliance (AOC) for {{ yandex-cloud }}](https://storage.yandexcloud.net/yc-compliance/certificates/PCI_DSS_Yandex_Cloud_AOC.pdf).
* [PCI DSS Attestation of Compliance (AOC) for the Yandex data center](https://storage.yandexcloud.net/yc-compliance/certificates/PCI_DSS%20_Yandex_Cloud_AOC_datacenter.pdf).
* [Responsibility matrix](https://storage.yandexcloud.net/yc-compliance/certificates/PCI_DSS_responsibility_matrix-new.pdf).
* [Requirements and recommendations for building a PCI DSS](https://storage.yandexcloud.net/yc-compliance/certificates/YC_PCI_DSS_Guide.pdf).

## PCI PIN Security {#pci-pin-security}

The payment card industry standard defines requirements for securely processing and transmitting PIN codes and managing cryptographic keys used to protect PIN codes. {{ yandex-cloud }} customers can host acquiring and PIN code transaction processing infrastructure components in the cloud.

For more information, see:

* [PCI PIN AOC for {{ yandex-cloud }}](https://storage.yandexcloud.net/yc-compliance/certificates/PCI_PIN_AOC_Yandex_Cloud.pdf).
* [PCI PIN Security certificate for {{ yandex-cloud }}](https://storage.yandexcloud.net/yc-compliance/certificates/PCI_PIN_Yandex_Cloud_2022.pdf).

## PCI 3-D Secure (PCI 3DS) {#pci-3d-secure}

The PCI 3-D Secure (PCI 3DS) standard defines the requirements for infrastructure used to receive payments through the 3-D Secure protocol. The protocol implements an additional request to authenticate a card transaction. Protocol components, such as the Access Control Server (3DS Server or Directory Server) are normally deployed on the card issuer side.

{{ yandex-cloud }} customers are able to deploy components implementing the 3-D Secure protocol in the cloud infrastructure.

For more information, see:

* [PCI 3-D AOC for {{ yandex-cloud }}](https://storage.yandexcloud.net/yc-compliance/certificates/PCI_3DS_AOC_Yandex_Cloud.pdf).
* [PCI 3DS certificate for {{ yandex-cloud }}](https://storage.yandexcloud.net/yc-compliance/certificates/PCI_3DS_Yandex_Cloud_2022.pdf).

## GOST R 57580.1-2017 {#gost}

GOST R 57580.1-2017 is the Russian national security standard for banking and financial operations. The standard was approved January 1, 2018, and offers a comprehensive approach to developing an information protection process in financial organizations. It also contains requirements for information protection at all lifecycle stages of automated systems and applications used by companies and banks. The standard sets the obligation to apply information protection measures for credit and non-credit financial organizations.

Cloud services comply with this standard in order to enable organizations that are hosting their systems and applications in the cloud to meet the requirements of the Central Bank (defined in the Bank of Russia regulations 683-P and 684-P) and ensure compliance with the standard for their systems deployed in the cloud.

The {{ yandex-cloud }} platform received a [statement of evaluation of compliance](https://storage.yandexcloud.net/yc-compliance/conformance_ru_finance.pdf) with the information security requirements established by the Bank of Russia regulations. The statement certifies that the information security management and control system of Yandex.Cloud, LLC was evaluated for compliance with the requirements of GOST R 57580.1-2017 for extended information security. At audit completion, the overall score was R=0.89 (the fourth level of compliance). According to GOST R 57580.2-2018, this means that the organizational and technical measures as part of the information protection system are implemented fully and continuously in accordance with global approaches (methods) established in the organization.

{{ yandex-cloud }} services can be used by systemically important financial institutions, financial institutions that provide payment infrastructure services for systemically important payment systems, and systemically important financial market utilities.

For more information, see:

* [Statement of Compliance](https://storage.yandexcloud.net/yc-compliance/conformance_ru_finance.pdf).
* [Allocation of responsibilities to comply with GOST R 57580.1-2017 requirements](https://storage.yandexcloud.net/yc-compliance/RST_577580_Yandex.Cloud_responsibility_matrix.pdf).

## Cloud Security Alliance {#csa}

{{ yandex-cloud }} is a corporate member of the Cloud Security Alliance, an international organization with the mission to promote the use of best practices for providing information security in cloud computing and raise awareness thereof.

{{ yandex-cloud }} meets the requirements of the Security, Trust, Assurance and Risk (STAR) program at Level 1: Self-Assessment.

For a high-level description of platform security measures in one of the most popular formats, Consensus Assessments Initiative Questionnaire (CAIQ) v.4, see the [CSA STAR](https://cloudsecurityalliance.org/star/registry/yandex-cloud/services/yandex-cloud/) registry.

We also participate in the Trusted Cloud Provider program that shows our commitment to a comprehensive security approach, including through continuous improvement of our employees' skills and active involvement in the international professional community.

## Central Registry of Russian Computer and Database Software{#reestr}

{{ yandex-cloud }} is included in the register of software created pursuant to article 12.1 of the Federal Law "On Information, Information Technologies, and Information Protection" by the basic class "02.05 Software tools for cloud and distributed computing, visualization tools, and data storage systems" and additional classes "02.09 Database management systems", "04.07 Linguistic software", and "04.13 Systems for collecting, storing, processing, analyzing, modeling, and visualizing datasets".

The fact that the platform is included in the Register proves that {{ yandex-cloud }} and its individual services of the above-mentioned classes are developed in Russia, which may be an advantage for companies with higher requirements for using software made in Russia. [Information about the registration entry in the Register](https://reestr.digital.gov.ru/reestr/310636/?sphrase_id=583415).
{% endif %}

{% if product == "cloud-il" %}

## Israeli regulatory requirements and industry standards {#regulatory-requirements}

{{ yandex-cloud }} complies with the regulatory requirements of Israel as well as industry standards:

* Protection of Privacy Law, 5741-1981.
* Privacy Protection Regulations (Data Security), 5777-2017.
* Privacy Protection Regulations (Transfer of Data to Overseas Databases), 5761-2001.

{% endif %}