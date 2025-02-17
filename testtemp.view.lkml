view: testtemp {
  sql_table_name: testtemp ;;

  dimension: person_id {
    type: number
    sql: ${TABLE}.PersonID ;;
  }
  measure: count {
    type: count
  }
}
