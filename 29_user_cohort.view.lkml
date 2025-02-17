view: user_cohort {

  derived_table: {
    sql:
        SELECT
          users.*,
          user_order_facts.*,
          CASE
            WHEN user_order_facts.lifetime_orders  < 0 THEN 'Below 0'
            WHEN user_order_facts.lifetime_orders  = 0 THEN '0'
            WHEN user_order_facts.lifetime_orders  = 1 THEN '1'
            WHEN user_order_facts.lifetime_orders  = 2 THEN '2'
            WHEN user_order_facts.lifetime_orders  >= 3 AND user_order_facts.lifetime_orders  < 5 THEN '3 to 4'
            WHEN user_order_facts.lifetime_orders  >= 5 AND user_order_facts.lifetime_orders  < 10 THEN '5 to 9'
            WHEN user_order_facts.lifetime_orders  >= 10 THEN '10 or Above'
            ELSE 'Undefined'
            END AS lifetime_orders_tier,

          CASE
            WHEN user_order_facts.lifetime_revenue  < 0 THEN 'Below 0'
            WHEN user_order_facts.lifetime_revenue  >= 0 AND user_order_facts.lifetime_revenue  < 25 THEN '0 to 24'
            WHEN user_order_facts.lifetime_revenue  >= 25 AND user_order_facts.lifetime_revenue  < 50 THEN '25 to 49'
            WHEN user_order_facts.lifetime_revenue  >= 50 AND user_order_facts.lifetime_revenue  < 100 THEN '50 to 99'
            WHEN user_order_facts.lifetime_revenue  >= 100 AND user_order_facts.lifetime_revenue  < 200 THEN '100 to 199'
            WHEN user_order_facts.lifetime_revenue  >= 200 AND user_order_facts.lifetime_revenue  < 500 THEN '200 to 499'
            WHEN user_order_facts.lifetime_revenue  >= 500 AND user_order_facts.lifetime_revenue  < 1000 THEN '500 to 999'
            WHEN user_order_facts.lifetime_revenue  >= 1000 THEN '1000 or Above'
            ELSE 'Undefined'
            END AS lifetime_revenue_tier,
          CASE WHEN users.latitude  IS NOT NULL AND users.longitude  IS NOT NULL THEN (
            COALESCE(CAST(users.latitude  AS STRING),'') || ',' ||
            COALESCE(CAST(users.longitude  AS STRING),'')) ELSE NULL END
             AS location,
          CASE WHEN user_order_facts.lifetime_orders > 1  THEN 'Yes' ELSE 'No' END
             AS repeat_customer
        FROM @{schema}.atom_users as users
        LEFT JOIN ${user_order_facts.SQL_TABLE_NAME} as user_order_facts
        on users.id = user_order_facts.user_id
        WHERE
          {% condition user_cohort.id_filter %} id {% endcondition %}
          AND {% condition user_cohort.zip_filter %} zip {% endcondition %}
          AND {% condition user_cohort.first_name_filter %} first_name {% endcondition %}
          AND {% condition user_cohort.last_name_filter %} last_name {% endcondition %}
          AND {% condition user_cohort.email_filter %} email {% endcondition %}
          AND {% condition user_cohort.age_filter %} age {% endcondition %}
          AND {% condition user_cohort.city_filter %} city {% endcondition %}
          AND {% condition user_cohort.gender_filter %} gender {% endcondition %}
          AND {% condition user_cohort.state_filter %} state {% endcondition %}
          AND {% condition user_cohort.location_filter %} location {% endcondition %}
          AND {% condition user_cohort.country_filter %} country {% endcondition %}
          AND {% condition user_cohort.traffic_source_filter %} traffic_source {% endcondition %}
          AND {% condition user_cohort.created_at_filter %} created_at_advance {% endcondition %}
          AND {% condition user_cohort.first_order_filter %} first_order_advance {% endcondition %}
          AND {% condition user_cohort.latest_order_filter %} latest_order_advance {% endcondition %}
          AND {% condition user_cohort.days_as_customer_filter %} days_as_customer {% endcondition %}
          AND {% condition user_cohort.repeat_customer_filter %} repeat_customer {% endcondition %}
          AND {% condition user_cohort.lifetime_orders_filter %} lifetime_orders {% endcondition %}
          AND {% condition user_cohort.lifetime_orders_tier_filter %} lifetime_orders_tier {% endcondition %}
          AND {% condition user_cohort.lifetime_revenue_filter %} lifetime_revenue {% endcondition %}
          AND {% condition user_cohort.lifetime_revenue_tier_filter %} lifetime_revenue_tier {% endcondition %}
          AND {% condition user_cohort.distinct_months_with_orders_filter %} distinct_months_with_orders {% endcondition %}
          ;;
  }

  filter: id_filter {
    label: "User ID"
    group_label: "User Info"
    suggest_explore: users_filters
    suggest_dimension: users_filters.id
  }

  filter: first_name_filter {
    label: "First Name"
    group_label: "User Info"
    suggest_explore: users_filters
    suggest_dimension: users_filters.first_name
  }

  filter: last_name_filter {
    label: "Last Name"
    group_label: "User Info"
    suggest_explore: users_filters
    suggest_dimension: users_filters.last_name
  }

  filter: age_filter {
    type: number
    label: "Age"
    group_label: "User Info"
    suggest_explore: users_filters
    suggest_dimension: users_filters.age
  }

  filter: zip_filter {
    label: "Zip"
    group_label: "User Location"
    suggest_explore: users_filters
    suggest_dimension: users_filters.zip
  }

  filter: state_filter {
    label: "State"
    group_label: "User Location"
    suggest_explore: users_filters
    suggest_dimension: users_filters.state
  }

  filter: city_filter {
    label: "City"
    group_label: "User Location"
    suggest_explore: users_filters
    suggest_dimension: users_filters.city
  }

  filter: country_filter {
    label: "Country"
    group_label: "User Location"
    suggest_explore: users_filters
    suggest_dimension: users_filters.country
  }

  filter: gender_filter {
    label: "Gender"
    group_label: "User Info"
    suggest_explore: users_filters
    suggest_dimension: users_filters.gender
  }

  filter: email_filter {
    label: "Email"
    group_label: "User Info"
    suggest_explore: users_filters
    suggest_dimension: users_filters.email
  }

  filter: traffic_source_filter {
    label: "Traffic Source"
    group_label: "User Info"
    suggest_explore: users_filters
    suggest_dimension: users_filters.traffic_source
  }

  filter: location_filter {
    label: "Location"
    group_label: "User Location"
    suggest_explore: users_filters
    suggest_dimension: users_filters.location
  }

  filter: created_at_filter {
    type: date
    group_label: "Dates"
    label: "Created At Date"
  }

  filter: first_order_filter {
    group_label: "Dates"
    type: date
    label: "First Order Date"
  }

  filter: latest_order_filter {
    type: date
    group_label: "Dates"
    label: "Lastest Order Date"
  }

  filter: days_as_customer_filter {
    type: number
    group_label: "Purchase Behavior"
    label: "Days as Customer"
  }

  filter: lifetime_orders_filter {
    type: number
    group_label: "Purchase Behavior"
    label: "Lifetime Orders"
  }

  filter: lifetime_revenue_filter {
    type: number
    group_label: "Purchase Behavior"
    label: "Lifetime Revenue"
  }

  filter: repeat_customer_filter {
    type: yesno
    group_label: "Purchase Behavior"
    label: "Is Repeat Customer?"
  }

  filter: lifetime_orders_tier_filter {
    type: string
    group_label: "Purchase Behavior"
    label: "Lifetime Orders Tier"
    suggest_explore: user_order_facts_filters
    suggest_dimension: user_order_facts_filters.lifetime_orders_tier
  }

  filter: lifetime_revenue_tier_filter {
    type: string
    group_label: "Purchase Behavior"
    label: "Lifetime Revenue Tier"
    suggest_explore: user_order_facts_filters
    suggest_dimension: user_order_facts_filters.lifetime_revenue_tier
  }

  filter: distinct_months_with_orders_filter {
    type: number
    group_label: "Purchase Behavior"
    label: "Distinct Months with Orders"
  }

##DIMENSIONS

  dimension: id {
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: first_name {
    hidden: yes
    type: string
    sql: ${TABLE}."FIRST_NAME" ;;
  }

  dimension: last_name {
    hidden: yes
    type: string
    sql: ${TABLE}."LAST_NAME" ;;
  }

  dimension: email {
    hidden: yes
    type: string
    sql: ${TABLE}."EMAIL" ;;
  }

  dimension: age {
    hidden: yes
    type: number
    sql: ${TABLE}."AGE" ;;
  }

  dimension: city {
    hidden: yes
    type: string
    sql: ${TABLE}."CITY" ;;
  }

  dimension: state {
    hidden: yes
    type: string
    sql: ${TABLE}."STATE" ;;
  }

  dimension: country {
    hidden: yes
    type: string
    sql: ${TABLE}."COUNTRY" ;;
  }

  dimension: zip {
    hidden: yes
    type: string
    sql: ${TABLE}."ZIP" ;;
  }

  dimension: latitude {
    hidden: yes
    type: number
    sql: ${TABLE}."LATITUDE" ;;
  }

  dimension: longitude {
    hidden: yes
    type: number
    sql: ${TABLE}."LONGITUDE" ;;
  }

  dimension: gender {
    hidden: yes
    type: string
    sql: ${TABLE}."GENDER" ;;
  }

  dimension_group: created_at {
    hidden: yes
    type: time
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension: traffic_source {
    hidden: yes
    type: string
    sql: ${TABLE}."TRAFFIC_SOURCE" ;;
  }

  dimension: location {
    hidden: yes
    type: location
    sql_latitude: ${TABLE}."latitude" ;;
    sql_longitude: ${TABLE}."longitude" ;;
  }

  dimension_group: first_order {
    hidden: yes
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: latest_order {
    hidden: yes
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.latest_order ;;
  }

  dimension: days_as_customer {
    hidden: yes
    description: "Days between first and latest order"
    type: number
    sql: DATEDIFF('day', ${TABLE}.first_order, ${TABLE}.latest_order)+1 ;;
  }

  dimension: days_as_customer_tiered {
    hidden: yes
    type: tier
    tiers: [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      30,
      60,
      90,
      180
    ]
    sql: ${days_as_customer} ;;
  }

  ##### Lifetime Behavior - Order Counts ######

  dimension: lifetime_orders {
    hidden: yes
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension: repeat_customer {
    hidden: yes
    description: "Lifetime Count of Orders > 1"
    type: yesno
    sql: ${lifetime_orders} > 1 ;;
  }

  dimension: lifetime_orders_tier {
    hidden: yes
    type: tier
    tiers: [
      0,
      1,
      2,
      3,
      5,
      10
    ]
    sql: ${lifetime_orders} ;;
    style: integer
  }

  dimension: distinct_months_with_orders {
    hidden: yes
    type: number
    sql: ${TABLE}.number_of_distinct_months_with_orders ;;
  }

  ##### Lifetime Behavior - Revenue ######

  dimension: lifetime_revenue {
    hidden: yes
    type: number
    description: "Total Revenue generated by a User (up to the latest day)"
    sql: ${TABLE}.lifetime_revenue ;;
    value_format_name: usd_0
  }

  dimension: lifetime_revenue_tier {
    hidden: yes
    type: tier
    tiers: [
      0,
      25,
      50,
      100,
      200,
      500,
      1000
    ]
    sql: ${lifetime_revenue} ;;
    style: integer

  }


#   measure: average_lifetime_orders {
#     type: average
#     value_format: "#.##"
#     sql: ${lifetime_orders} ;;
#   }


#   measure: average_lifetime_revenue {
#     type: average
#     sql: round(${lifetime_revenue}, 2) ;;
#     value_format_name: usd_0
#
#   }

}