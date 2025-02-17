view: order_facts {
  derived_table: {
    datagroup_trigger: every_day
    sql: SELECT
          order_items.order_id AS order_id
        , COUNT(*) AS items_in_order
        , SUM(sale_price) AS order_amount
        , SUM(inventory_items.cost) AS order_cost
        , RANK() OVER (PARTITION BY order_items.user_id ORDER BY order_items.created_at) AS order_sequence_number
      FROM @{schema}.order_items AS order_items
      LEFT JOIN @{schema}.inventory_items AS inventory_items
        ON order_items.inventory_item_id = inventory_items.id
      GROUP BY order_items.order_id, order_items.user_id, order_items.created_at
       ;;
  }

  ## DIMENSIONS ##

  dimension: order_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: items_in_order {
    type: number
    sql: ${TABLE}.items_in_order ;;
  }

  dimension: order_amount {
    type: number
    sql: ${TABLE}.order_amount ;;
  }

  dimension: order_cost {
    type: number
    sql: ${TABLE}.order_cost ;;
  }

  dimension: order_sequence_number {
    description: "chronological number of order relative to all orders for this user"
    type: number
    sql: ${TABLE}.order_sequence_number ;;
  }

  dimension: is_first_purchase {
    type: yesno
    sql: ${order_sequence_number} = 1 ;;
  }

  ########## Sets ##########

  set: simple {
    fields: [order_id, items_in_order, order_amount, order_cost, is_first_purchase]
  }
}