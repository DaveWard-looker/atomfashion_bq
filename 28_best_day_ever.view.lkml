view: best_day_ever {
  derived_table: {
    datagroup_trigger: every_day
    sql:
      select day, best_day_vs_today
      from
        (select date_trunc(created_at_advance, day) as day, 'Best Day' as best_day_vs_today
        from ecomm.atom_order_items
        group by 1,2
        order by sum(sale_price) desc
        limit 1)

      union all

       (select CAST(current_date as timestamp) as day, 'Today' as best_day_vs_today)
       ;;
  }

  dimension_group: created {
    label: "Best Day"
    type: time
    timeframes: [date]
    sql: ${TABLE}.DAY ;;
  }

  dimension: best_day_vs_today {
    label: "Best Day vs Today"
    type: string
    sql: ${TABLE}.best_day_vs_today ;;
  }

}
