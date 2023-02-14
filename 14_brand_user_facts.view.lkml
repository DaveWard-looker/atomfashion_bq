view: brand_user_facts {
  derived_table: {
    datagroup_trigger: every_day
    sql: select product_brand as brand
        , order_items.user_id as user_id
        , count(*) as total_orders
        , sum(sale_price) as total_sale_price
        , RANK() OVER(partition by product_brand order by sum(sale_price) desc, user_id) as rank
from ecomm.atom_order_items as order_items
left join ecomm.atom_inventory_items as inventory_items on order_items.inventory_item_id = inventory_items.id
group by 1, 2
       ;;
  }

  dimension: primary_key {
    primary_key: yes
    type: string
    hidden: yes
    sql: CONCAT(${brand}, '-', ${user_id}) ;;
  }

  dimension: brand {
    type: string
    sql: trim(${TABLE}.brand) ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: total_orders {
    type: number
    sql: ${TABLE}.total_orders ;;
  }

  dimension: total_sale_price {
    type: number
    sql: ${TABLE}.total_sale_price ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  set: detail {
    fields: [brand, user_id, total_orders, total_sale_price, rank]
  }
}
