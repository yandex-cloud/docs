# ycp_monitoring_quick_links (Resource)

Monitoring quick links

## Schema

### Required

- `project_id` (String) Project identifier

### Optional

- `id` (String) The ID of this resource.
- `items` (Block List) Quick link items (see [below for nested schema](#nestedblock--items))
- `timeouts` (Block, Optional) (see [below for nested schema](#nestedblock--timeouts))

<a id="nestedblock--items"></a>
### Nested Schema for `items`

Optional:

- `folders` (Block List) Folders (see [below for nested schema](#nestedblock--items--folders))
- `links` (Block List) Links (see [below for nested schema](#nestedblock--items--links))

<a id="nestedblock--items--folders"></a>
### Nested Schema for `items.folders`

Required:

- `title` (String) Folder title

Optional:

- `items` (Block List) Folder items (see [below for nested schema](#nestedblock--items))


<a id="nestedblock--items--links"></a>
### Nested Schema for `items.links`

Required:

- `title` (String) Link title
- `url` (String) Link URL



<a id="nestedblock--timeouts"></a>
### Nested Schema for `timeouts`

Optional:

- `create` (String)
- `delete` (String)
- `read` (String)
- `update` (String)




## Example
```
resource ycp_monitoring_quick_links menu {
  project_id = "project_id_here"
  items {
    links {
      title = "abc url"
      url   = "/abc"
    }
  }
  items {
    folders {
      title = "folders1"
      items {
        links {
          title = "abc2 url"
          url   = "/abc2"
        }
      }
    }
  }
}
```
