view: inventory_items {
  sql_table_name: @{schema}.atom_inventory_items ;;

## ATOM.VIEW SQL
  #   create view @{schema}.inventory_items as
  #     select *,
  #     DATEADD(d,1,created_at) as created_at_advance,
  #     DATEADD(d,1,sold_at) as sold_at_advance
  #     from @{schema}.inventory_items

  ## DIMENSIONS ##

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    value_format: "$#,##0.00"
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month, raw]
    sql: TIMESTAMP(${TABLE}.created_at_advance);;
  }

  dimension: product_id {
    type: number
    hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.sold_at_advance ;;
  }

  dimension: is_sold {
    type: yesno
    sql: ${sold_raw} is not null ;;
  }

  dimension: days_in_inventory {
    description: "days between created and sold date"
    type: number
    sql:  TIMESTAMP_DIFF(coalesce(${sold_raw}, CURRENT_TIMESTAMP()), TIMESTAMP(${created_raw}), DAY)  ;;
  }

  dimension: days_in_inventory_tier {
    description: "Tiered groupings of the number of days in inventory broken out doubled groupings"
    type: tier
    sql: ${days_in_inventory} ;;
    style: integer
    tiers: [
      0,
      5,
      10,
      20,
      40,
      80,
      160,
      360
    ]
  }

  dimension: days_since_arrival {
    description: "days since created - useful when filtering on sold yesno for items still in inventory"
    type: number
    sql: TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), TIMESTAMP(${created_raw}), DAY) ;;
  }

  dimension: days_since_arrival_tier {
    type: tier
    sql: ${days_since_arrival} ;;
    style: integer
    tiers: [
      0,
      5,
      10,
      20,
      40,
      80,
      160,
      360
    ]
  }

  dimension: product_distribution_center_id {
    hidden: yes
    sql: ${TABLE}.product_distribution_center_id ;;
  }

  ## MEASURES ##

  measure: sold_count {
    type: count

    filters: {
      field: is_sold
      value: "Yes"
    }
  }

  measure: sold_percent {
    type: number
    value_format: "#.0\%"
    sql: 100.0 * ${sold_count}/NULLIF(${count},0) ;;
  }

  measure: total_cost {
    type: sum
    value_format_name: big_money
    sql: ${cost} ;;
    drill_fields: [simple*]
  }

  measure: total_cost_negative {
    hidden: yes
    label: "Total Cost"
    type: sum
    value_format_name: usd
    sql: -1.0*${cost} ;;
  }

  measure: average_cost {
    type: average
    value_format: "$#,##0.00"
    sql: ${cost} ;;
    drill_fields: [simple*]
  }

  measure: count {
    type: count
    drill_fields: [simple*]
  }

  measure: number_on_hand {
    type: number
    sql: ${count} - ${sold_count} ;;
    drill_fields: [simple*]
  }


  set: detail {
    fields: [
      id,
      products.item_name,
      products.category,
      products.brand,
      products.department,
      cost,
      created_time,
      sold_time
    ]
  }

  set: simple {
    fields: [
      id,
      cost,
      created_time,
      sold_time,
      count,
      total_cost,
      average_cost
    ]
  }
}
