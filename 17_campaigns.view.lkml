view: campaigns {

  ## ATOM.VIEW SQL
    # create view daveward-ps-dev.ecomm.campaigns as
    # select *,
    #   dateadd(d,1,created_at) as created_at_advance
    # from ecomm.campaigns

  derived_table: {
    datagroup_trigger: every_day
    sql: SELECT *
      FROM   ecomm.atom_campaigns
      UNION ALL
      SELECT 9999                 AS id,
      NULL                        AS advertising_channel,
      0                           AS amount,
      NULL                        AS bid_type,
      'Total'                     AS campaign_name,
      '60'                        AS period,
      DATE_SUB(current_date(), INTERVAL 1 DAY) AS created_at,
      DATE_SUB(current_date(), INTERVAL 1 DAY) AS created_at_advance;;
  }


##### Campaign Facts #####

  filter: campaign_selector {
    type: string
    suggest_dimension: campaign_name
  }

  dimension: campaign_benchmark {
    type: string
    sql: case when ( {% condition campaign_selector %} ${campaign_name} {% endcondition %}) then ${campaign_name} else 'Benchmark' end  ;;
  }

  dimension: campaign_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: advertising_channel {
    type: string
    sql: ${TABLE}.advertising_channel ;;
  }

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: bid_type {
    type: string
    sql: ${TABLE}.bid_type ;;
  }

  dimension: campaign_name {
    full_suggestions: yes
    type: string
    sql:  CONCAT(CAST(${campaign_id} as STRING) , ' - ',  CAST(${campaign_name_raw} as STRING)) ;;

#     link: {
#       label: "Campaign Performance Dashboard"
#       icon_url: "http://www.looker.com/favicon.ico"
#       url: "https://snowflakedemo.looker.com/dashboards/116?Campaign Name={{ value | encode_uri }}"
#     }
#     link: {
#       label: "View on AdWords"
#       icon_url: "https://www.google.com/s2/favicons?domain=www.adwords.google.com"
#       url: "https://adwords.google.com/aw/adgroups?campaignId={{ campaign_id._value | encode_uri }}"
#     }
#     link: {
#       label: "Pause Campaign"
#       icon_url: "https://www.google.com/s2/favicons?domain=www.adwords.google.com"
#       url: "https://adwords.google.com/aw/ads?campaignId={{ campaign_id._value | encode_uri }}"
#     }
  }

  dimension: campaign_name_raw {
    label: "Campaign Abbreviated"
    sql: ${TABLE}.campaign_name ;;
#     link: {
#       label: "Campaign Performance Dashboard"
#       icon_url: "http://www.looker.com/favicon.ico"
#       url: "https://snowflakedemo.looker.com/dashboards/116?Campaign Name={{ campaign_name._value | encode_uri }}"
#     }
#     link: {
#       label: "View on AdWords"
#       icon_url: "https://www.google.com/s2/favicons?domain=www.adwords.google.com"
#       url: "https://adwords.google.com/aw/adgroups?campaignId={{ campaign_id._value | encode_uri }}"
#     }
#     link: {
#       label: "Pause Campaign"
#       icon_url: "https://www.google.com/s2/favicons?domain=www.adwords.google.com"
#       url: "https://adwords.google.com/aw/ads?campaignId={{ campaign_id._value | encode_uri }}"
#     }
  }

  dimension: campaign_type {
    sql: ARRAY_REVERSE(SPLIT(${campaign_name_raw}, "-"))[SAFE_OFFSET(0)];;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CREATED_AT_advance ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: DATE_ADD( ${created_date}, INTERVAL 1 DAY) ;;
  }

  dimension: day_of_quarter {
    type: number
    sql: DATE_DIFF(
        CAST(CONCAT(${created_quarter}, '-01') as date),
        ${created_raw}, day)
       ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period  ;;
  }

  dimension: is_active_now {
    type: yesno
    sql: ${end_date} >= CURRENT_DATE ;;
  }

  measure: count {
    type: count
    drill_fields: [campaign_id, campaign_name, adgroups.count]
  }

  set: detail {
    fields: [
      campaign_id, campaign_name, adgroups.count
    ]
  }
}
