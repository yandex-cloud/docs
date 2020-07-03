# Удалить политику удаления

Для обращения к [политике](../../concepts/lifecycle-policy.md) используйте ее идентификатор. Как узнать идентификатор политики, читайте в разделе [{#T}](lifecycle-policy-list.md).

{% list tabs %}
  
- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  1. Удалите политику, указав ее идентификатор:
  
      ```
      $ yc container repository lifecycle-policy delete crp6lg1868p3i0emkv1b
      ```
  
  1. Проверьте, что политика действительно удалена:
  
      ```
      $ yc container repository lifecycle-policy list --repository-name crp2hlbs67tj4ggrfodb/ubuntu
     
      +----+------+---------------+--------+---------+-------------+
      | ID | NAME | REPOSITORY ID | STATUS | CREATED | DESCRIPTION |
      +----+------+---------------+--------+---------+-------------+
      +----+------+---------------+--------+---------+-------------+
      ```
  
{% endlist %}
