project_name: "atomfashion"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }

constant: department_name {
  value: "IT Team"
}

# To be inserted in Constant file
constant: navigation_buttons_style {
  value: "display: table; text-align:center; margin: 0 auto; color: #fff; background-color: #4285F4; border-color: #4285F4; float: left; font-weight: 400; text-align: center; vertical-align: middle; cursor: pointer; user-select: none; padding: 10px; margin: 5px; font-size: 1rem; line-height: 1.5; border-radius: 5px;"
}

constant: navigation_buttons_filters {
  value: "Brand={{ _filters['products.brand'] | url_encode }}&Category={{ _filters['products.category'] | url_encode }}"
}

constant: marketing_report_buttons_filters {
  value: "Brand={{ _filters['products.brand'] | url_encode }}"
}


constant: drill_link {
  value: "<a href=\"/explore/atom_fashion/web_sessions?fields=users.age,users.age_tier,users.approx_location,users.city,users.id,users.created_date,users.email,users.gender,users.gender_short,users.generation,users.history,users.zip,users.state,users.name,users.location&f[users.page_number]=1&f[users.rows_per_page]=50&f[{{ _field._name }}]={{value}}&sorts=users.created_date+desc&limit=5000&column_limit=50&vis=%7B%7D&filter_config=%7B%22users.page_number%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%222%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%2C%22users.rows_per_page%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22100%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%2C%22users.country%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22UK%22%7D%2C%7B%7D%5D%2C%22id%22%3A2%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded\">{{ rendered_value }}</a>"
}

constant: drill_link_2 {
  value: "
  {if drill_level._parameter_value == 'level_1' }
  <a href=\"/explore/atom_fashion/web_sessions?fields=users.age,users.age_tier,users.approx_location,users.city,users.id,users.created_date,users.email,users.gender,users.gender_short,users.generation,users.history,users.zip,users.state,users.name,users.location&f[users.page_number]=1&f[users.rows_per_page]=50&f[{{ _field._name }}]={{value}}&sorts=users.created_date+desc&limit=5000&column_limit=50&vis=%7B%7D&filter_config=%7B%22users.page_number%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%222%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%2C%22users.rows_per_page%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22100%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%2C%22users.country%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22UK%22%7D%2C%7B%7D%5D%2C%22id%22%3A2%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded\">{{ rendered_value }}</a>
  {elsif drill_level._parameter_value == 'level_2' }
  <a href=\"/explore/atom_fashion/web_sessions?fields=users.age,users.age_tier,users.approx_location,users.city,users.email,users.gender,users.gender_short,users.generation,users.history,users.zip,users.state,users.name,users.location&f[users.page_number]=1&f[users.rows_per_page]=50&f[{{ _field._name }}]={{value}}&sorts=users.created_date+desc&limit=5000&column_limit=50&vis=%7B%7D&filter_config=%7B%22users.page_number%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%222%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%2C%22users.rows_per_page%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22100%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%2C%22users.country%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22UK%22%7D%2C%7B%7D%5D%2C%22id%22%3A2%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded\">{{ rendered_value }}</a>
  {{else}}
  <a href=\"/explore/atom_fashion/web_sessions?fields=users.city,users.email,users.gender,users.gender_short,users.generation,users.history,users.zip,users.state,users.name,users.location&f[users.page_number]=1&f[users.rows_per_page]=50&f[{{ _field._name }}]={{value}}&sorts=users.created_date+desc&limit=5000&column_limit=50&vis=%7B%7D&filter_config=%7B%22users.page_number%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%222%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%2C%22users.rows_per_page%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22100%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%2C%22users.country%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22UK%22%7D%2C%7B%7D%5D%2C%22id%22%3A2%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded\">{{ rendered_value }}</a>
  {{endif}}
"
}


constant: connection {
  value: "looker_bq_hub"
  export: override_required
}

constant: schema {
  value: "ecomm_hub"
  export: override_required
}

constant: brand_name {
  value: "Nike"
  export: override_optional
}
