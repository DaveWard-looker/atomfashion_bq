include: "/01_order_items.view.lkml"
include: "/11_order_facts.view.lkml"
include: "/02_users.view.lkml"
include: "/03_inventory_items.view.lkml"
include: "/12_user_order_facts.view.lkml"
include: "/04_products.view.lkml"
include: "/29_user_cohort.view.lkml"

explore: users {
  description: "Please update rows per page and page number parameters"
  # always_filter: {
  #   filters: [users.rows_per_page: "50",users.page_number: "1"]
  # }
  label: "(8) User Cohort Analysis"
  fields: [ALL_FIELDS*, -order_items.tax_amount, -order_items.days_until_next_order]
  join: order_items {
    type: left_outer
    sql_on: ${users.id} = ${order_items.user_id} ;;
    relationship: one_to_many
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: one_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: user_order_facts {
    view_label: "Users"
    type: left_outer
    relationship: one_to_one
    sql_on: ${users.id} = ${user_order_facts.user_id} ;;
  }

  join: order_facts {
    view_label: "Orders"
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.order_id} = ${order_facts.order_id}  ;;
  }

  join: user_cohort {
    view_label: "0.Build User Cohort"
    type: inner
    sql_on: ${users.id} = ${user_cohort.id} ;;
    relationship: one_to_one
  }
}
