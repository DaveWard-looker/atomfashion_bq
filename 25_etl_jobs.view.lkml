view: etl_jobs {
  sql_table_name: @{schema}.etl_jobs ;;

  dimension_group: completed {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.completed_at ;;
  }

  dimension: git_head {
    type: string
    sql: ${TABLE}.git_head ;;
  }

  dimension: hostname {
    type: string
    sql: ${TABLE}.hostname ;;
  }

  measure: count {
    type: count
  }
}