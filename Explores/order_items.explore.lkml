include: "/01_order_items.view.lkml"
include: "/11_order_facts.view.lkml"
include: "/02_users.view.lkml"
include: "/03_inventory_items.view.lkml"
include: "/27_city_sales_tax.view.lkml"
include: "/12_user_order_facts.view.lkml"
include: "/04_products.view.lkml"
include: "/13_repeat_purchase_facts.view.lkml"
include: "/24_distribution_centers.view.lkml"
include: "/28_best_day_ever.view.lkml"

explore: order_items {
  label: "(1) Order Information @{department_name}"
  description: "All information related to Orders placed including shipping information, user facts, and product information"
  view_name: order_items
  access_filter: {
    field: products.brand
    user_attribute: brand
  }
  # access_filter: {
  #   field: order_items.created_date
  #   user_attribute: time_horizon
  # }
#   sql_always_where: ${order_items.created_date} <= current_date() ;;

  join: order_facts {
    view_label: "Orders"
    relationship: many_to_one
    sql_on: ${order_facts.order_id} = ${order_items.order_id} ;;
  }

  join: inventory_items {
    type: left_outer
    relationship: one_to_one
    sql_on: ${inventory_items.id} = ${order_items.inventory_item_id} ;;
  }

  join: users {
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.user_id} = ${users.id} ;;
  }

  join: city_sales_tax {
    type: inner
    sql_on: ${users.city} = ${city_sales_tax.city}
          AND ${users.state} = ${city_sales_tax.state}
          AND ${users.country} = ${city_sales_tax.country}
      ;;
    relationship: many_to_one
  }

  join: user_order_facts {
    view_label: "Users"
    relationship: many_to_one
    sql_on: ${user_order_facts.user_id} = ${order_items.user_id} ;;
  }

  join: products {
    relationship: many_to_one
    sql_on: ${products.id} = ${inventory_items.product_id} ;;
  }

  join: repeat_purchase_facts {
    view_label: "Orders"
    relationship: many_to_one
    type: full_outer
    sql_on: ${order_items.order_id} = ${repeat_purchase_facts.order_id} ;;
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${distribution_centers.id} = ${inventory_items.product_distribution_center_id} ;;
    relationship: many_to_one
  }

  join: best_day_ever {
    view_label: "Order Items"
    type: inner
    sql_on: ${order_items.created_date} = ${best_day_ever.created_date} ;;
    relationship: many_to_one
  }
}
