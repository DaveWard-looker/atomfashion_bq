# The name of this view in Looker is "Goals"
view: goals {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.salesforce.goals`
    ;;
  drill_fields: [goal_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: goal_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.Goal_ID ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called " Inside Bookings " in Explore.

  dimension: _inside_bookings_ {
    type: number
    sql: ${TABLE}._Inside_Bookings_ ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total__inside_bookings_ {
    type: sum
    sql: ${_inside_bookings_} ;;
  }

  measure: average__inside_bookings_ {
    type: average
    sql: ${_inside_bookings_} ;;
  }

  dimension: _inside_east_bookings_ {
    type: number
    sql: ${TABLE}._Inside_East_Bookings_ ;;
  }

  dimension: _inside_emea_bookings_ {
    type: number
    sql: ${TABLE}._Inside_EMEA_Bookings_ ;;
  }

  dimension: _inside_west_bookings_ {
    type: number
    sql: ${TABLE}._Inside_West_Bookings_ ;;
  }

  dimension: _outside_bookings_ {
    type: number
    sql: ${TABLE}._Outside_Bookings_ ;;
  }

  dimension: _outside_east_bookings_ {
    type: number
    sql: ${TABLE}._Outside_East_Bookings_ ;;
  }

  dimension: _outside_emea_bookings_ {
    type: number
    sql: ${TABLE}._Outside_EMEA_Bookings_ ;;
  }

  dimension: _outside_west_bookings_ {
    type: number
    sql: ${TABLE}._Outside_West_Bookings_ ;;
  }

  dimension: _total_bookings_ {
    type: number
    sql: ${TABLE}._Total_Bookings_ ;;
  }

  dimension: quarter {
    type: string
    sql: ${TABLE}.Quarter ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.Year ;;
  }

  measure: count {
    type: count
    drill_fields: [goal_id]
  }
}
