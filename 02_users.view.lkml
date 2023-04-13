view: users {
  # derived_table: {
  #   sql:
  #   select * from ecomm.atom_users
  #   limit {% parameter rows_per_page %}
  #       offset {{ rows_per_page._parameter_value | times: page_number._parameter_value | minus: rows_per_page._parameter_value }}
  #   ;;
  # }
  # parameter: rows_per_page {
  #   description: "This specifies the number of rows on each page. When viewing within the UI it should be set at 500 or below. When downloading it should be set higher than table count value"
  #   default_value: "50"
  #   type: number
  # }

  # parameter: page_number {
  #   description: "Specify the page you which to view. When downloading this value should be set to 1"
  #   default_value: "1"
  #   type: number
  # }


  sql_table_name: ecomm.atom_users ;;

  ## ATOM.VIEW SQL
  #   create view daveward-ps-dev.ecomm.users as
  #     select *,
  #     DATEADD(d,1,created_at) as created_at_advance
  #     from ecomm.users


  ## Demographics ##



  dimension: id {
    primary_key: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.id ;;
    tags: ["atom-notification"]
    drill_fields: [detail*]
    #html: @{drill_link} ;;
  }

  dimension: first_name {
    hidden: yes
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    hidden: yes
    sql: ${TABLE}.last_name ;;
  }

  dimension: name {
    sql: initcap(${first_name} || ' ' || ${last_name}) ;;
    drill_fields: [detail*]
    #html: @{drill_link} ;;
  }

  measure: count_of_davids2 {
    type: count_distinct
    sql: id ;;
    filters: [first_name: "David"]
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
    drill_fields: [detail*]
    #html: @{drill_link} ;;
  }

  dimension: age_tier {
    type: tier
    description: "User Ages tiered by the following grouping [0,10,20,30,40,50,60,70]"
    tiers: [
      0,
      10,
      20,
      30,
      40,
      50,
      60,
      70
    ]
    style: integer
    sql: ${age} ;;
    drill_fields: [detail*]
    #html: @{drill_link} ;;
  }

  dimension: generation {
    order_by_field: generation_order
    type: string
    sql: CASE WHEN ${age} <= 25 THEN 'Gen Z'
              WHEN ${age} <= 40 THEN 'Millenials'
              WHEN ${age} <= 55 THEN 'Gen X'
              WHEN ${age} <= 76 THEN 'Baby Boomers'
            ELSE 'Silent'
            END;;
    # drill_fields: [detail*]
    # html: @{drill_link} ;;
  }

  dimension: generation_order {
    hidden: yes
    type: number
    sql: CASE WHEN ${generation} = 'Gen Z' THEN 5
              WHEN ${generation} = 'Millenials' THEN 4
              WHEN ${generation} = 'Gen X' THEN 3
              WHEN ${generation} = 'Baby Boomers' THEN 2
            ELSE 1
            END;;
    drill_fields: [detail*]

  }

  dimension: gender {
    sql: ${TABLE}.gender ;;
    drill_fields: [detail*]
    #html: @{drill_link_2}} ;;
  }

  dimension: gender_short {
    sql: LOWER(LEFT(${gender},1)) ;;
    #html: @{drill_link_2} ;;
  }

  dimension: user_image {
    sql: ${image_file} ;;
    # html: <img src="{{ value }}" width="220" height="220"/>;;
    drill_fields: [detail*]
  }

  dimension: email {
    drill_fields: [detail*]
    sql: ${TABLE}.email ;;
    tags: ["atom-notification"]
    action: {
      label: "Email Promotion to Customer"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "https://sendgrid.com/favicon.ico"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      form_param: {
        name: "Subject"
        required: yes
        default: "Thank you {{ users.name._value }}"
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Dear {{ users.name._value }},

        Thanks for your loyalty to the Look.  We'd like to offer you a 10% discount
        on your next purchase!  Just use the code LOYAL when checking out!

        Your friends at the Look"
      }
    }
    required_fields: [name]
    #html: @{drill_link} ;;
  }

  dimension: image_file {
    hidden: yes
    sql: ('http://www.looker.com/_content/docs/99-hidden/images/'||${gender_short}||'.jpg') ;;
    #html: @{drill_link} ;;
  }

  ## Demographics ##

  dimension: city {
    sql: ${TABLE}.city ;;
    drill_fields: [detail*]
    #html: @{drill_link} ;;
  }

  dimension: state {
    full_suggestions: yes
    map_layer_name: us_states
    sql: ${TABLE}.state ;;
    drill_fields: [detail*]
    #html: @{drill_link} ;;
  }

  dimension: state_region {
    full_suggestions: yes
    sql: ${TABLE}.state ;;

    case: {
      when: {
        sql: ${state} in ('Connecticut', 'Maine', 'Massachusetts', 'New Hampshire',
          'Rhode Island', 'Vermont', 'New Jersey', 'New York', 'Pennsylvania', 'Delaware');;
        label: "Northeast"
      }
      when: {
        sql: ${state} in ('Illinois', 'Indiana', 'Michigan', 'Ohio', 'Wisconsin'
          , 'Iowa', 'Kansas', 'Minnesota', 'Missouri', 'Nebraska', 'North Dakota', 'South Dakota');;
        label: "Midwest"
      }
      when: {
        sql: ${state} in ('Florida', 'Georgia', 'Maryland', 'North Carolina', 'South Carolina', 'Virginia'
                  , 'District of Columbia', 'West Virginia'
                  , 'Alabama', 'Kentucky', 'Mississippi', 'Tennessee'
                  , 'Arkansas', 'Louisiana', 'Oklahoma', 'Texas');;
        label: "South"
      }
      when: {
        sql: ${state} in ('Arizona', 'Colorado', 'Idaho', 'Montana', 'Nevada', 'New Mexico', 'Utah', 'Wyoming');;
        label: "Mountain"
      }
      when: {
        sql: ${state} in ('Alaska', 'California', 'Hawaii', 'Oregon', 'Washington');;
        label: "Pacific"
      }
      else: "Not In US"
    }
    alpha_sort: yes
    #html: @{drill_link} ;;
  }

  dimension: zip {
    drill_fields: [detail*]
    type: zipcode
    sql: ${TABLE}.zip ;;
    #html: @{drill_link} ;;
  }

  dimension: country {
    drill_fields: [detail*]
    sql: ${TABLE}.country ;;
    #html: @{drill_link} ;;
  }

  dimension: location {
    drill_fields: [detail*]
    type: location
    sql_latitude: ${TABLE}.latitude ;;
    sql_longitude: ${TABLE}.longitude ;;
    #html: @{drill_link} ;;
  }

  dimension: approx_location {
    drill_fields: [detail*]
    type: location
    sql_latitude: round(${TABLE}.latitude,1) ;;
    sql_longitude: round(${TABLE}.longitude,1) ;;
    #html: @{drill_link} ;;
  }

  ## Other User Information ##

  dimension_group: created {
    drill_fields: [detail*]
    type: time
    description: "Date a user account was first created"
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.created_at_advance ;;
    #html: @{drill_link} ;;
  }

  dimension: history {
    sql: ${TABLE}.id ;;
    html: <a href="/explore/thelook/order_items?fields=order_items.detail*&f[users.id]={{ value }}">Order History</a>
      ;;
    #html: @{drill_link} ;;
  }

  dimension: traffic_source {
    sql: ${TABLE}.traffic_source ;;
    drill_fields: [detail*]
    #html: @{drill_link} ;;
  }

  ## MEASURES ##

  measure: count {
    description: "Count of the distinct number of Users"
    type: count
    drill_fields: [detail*]
    #html: @{drill_link} ;;
  }

  measure: count_percent_of_total {
    label: "Count (Percent of Total)"
    type: percent_of_total
    value_format_name: decimal_1
    sql: ${count} ;;
    #html: @{drill_link} ;;
  }

  measure: average_age {
    type: average
    value_format_name: decimal_2
    sql: ${age} ;;
    #html: @{drill_link} ;;
  }

  dimension: is_user_created_in_last_60_days {
    hidden: yes
    type: yesno
    sql: date_diff( ${created_date}, current_date(), days) < 60 ;;
    #html: @{drill_link} ;;
  }

  dimension: is_user_created_in_last_month {
    hidden: yes
    type: yesno
    sql: date_diff( ${created_date}, current_date(), days) < 30 ;;
    #html: @{drill_link} ;;
  }

  dimension: is_user_created_in_last_day {
    hidden: yes
    type: yesno
    sql: ${created_date} = current_date()-7 ;;
    #html: @{drill_link} ;;
  }

  measure: count_users_this_month {
    hidden: yes
    type: count

    filters: {
      field: is_user_created_in_last_month
      value: "yes"
    }
    drill_fields: [detail*]
  }

  measure: count_users_today {
    hidden: yes
    type: count

    filters: {
      field: is_user_created_in_last_day
      value: "yes"
    }
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      id,
      name,
      email,
      age,
      state,
      country,
      city,
      age,
      age_tier,
      generation,
      location,
      approx_location,
      created_date,
      orders.count,
      order_items.count
    ]
  }

  set: simple {
    fields: [
      id,
      name,
      email,
      age,
      age_tier,
      gender,
      created_date,
      count
    ]
  }

  # measure: pages_in_table {
  #   type: number
  #   sql: ${count}/{{rows_per_page._parameter_value }} ;;
  # }


  parameter: drill_level {
    type: unquoted
    allowed_value: {
      label: "level 1"
      value: "level_1"
    }
    allowed_value: {
      label: "level 2"
      value: "level_2"
    }
    allowed_value: {
      label: "level 3"
      value: "level_3"
    }
    allowed_value: {
      label: "level 4"
      value: "level_4"
    }
    allowed_value: {
      label: "level 5"
      value: "level_5"
    }
    allowed_value: {
      label: "level 6"
      value: "level_6"
    }
    allowed_value: {
      label: "level 7"
      value: "level_7"
    }
    allowed_value: {
      label: "level 8"
      value: "level_8"
    }
    allowed_value: {
      label: "level 9"
      value: "level_9"
    }
    allowed_value: {
      label: "level 10"
      value: "level_10"
    }
    allowed_value: {
      label: "level 11"
      value: "level_11"
    }
    allowed_value: {
      label: "level 12"
      value: "level_12"
    }
    allowed_value: {
      label: "level 13"
      value: "level_13"
    }
    allowed_value: {
      label: "level 14"
      value: "level_14"
    }
    allowed_value: {
      label: "level 15"
      value: "level_15"
    }
  }

}
