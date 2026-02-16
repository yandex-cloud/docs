Depending on whether the parameter is enabled, the following resource records will be created automatically for access to {{ objstorage-name }}:
* The parameter is not used:

  Name | Type | Value
  --- | --- | ---
  storage.pe.yandexcloud.net | A | <internal_IP_address_of_service_connection>
  *.storage.pe.yandexcloud.net | A | <internal_IP_address_of_service_connection>

* The parameter is used:

  Name | Type | Value
  --- | --- | ---
  storage.pe.yandexcloud.net | A | <internal_IP_address_of_service_connection>
  *.storage.pe.yandexcloud.net | A | <internal_IP_address_of_service_connection>
  {{ s3-storage-host }} | A | <internal_IP_address_of_service_connection>
  *.{{ s3-storage-host }} | A | <internal_IP_address_of_service_connection>
