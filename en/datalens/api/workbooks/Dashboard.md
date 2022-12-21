# Dashboard

| Field | Type | Description |
------|-----|----------
| `tabs` | **list** * |
| `tabs[]` | **DashboardTab** |
| `tabs[]`.`id` | **str** * |
| `tabs[]`.`title` | **str** * |
| `tabs[]`.`items` | **list** * |
| `tabs[]`.`items[]` | **DashboardTabItem** |
| `tabs[]`.`items[]`.`id` | **str** * |
| `tabs[]`.`items[]`.`element` | [DashElement](DashElement.md) * |
| `tabs[]`.`items[]`.`placement` | **DashTabItemPlacement** * |
| `tabs[]`.`items[]`.`placement`.`x` | **int** * |
| `tabs[]`.`items[]`.`placement`.`y` | **int** * |
| `tabs[]`.`items[]`.`placement`.`h` | **int** * |
| `tabs[]`.`items[]`.`placement`.`w` | **int** * |
