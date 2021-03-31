# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: transcript_with_messages {
  join: transcript_with_messages__messages {
    view_label: "Transcript With Messages: Messages"
    sql: LEFT JOIN UNNEST(${transcript_with_messages.messages}) as transcript_with_messages__messages ;;
    relationship: one_to_many
  }
}

view: transcript_with_messages {
  sql_table_name: `looker-private-demo.call_center.transcript_with_messages`
    ;;

  dimension: agent_id {
    type: string
    sql: ${TABLE}.agent_id ;;
  }

  dimension: client_id {
    type: number
    sql: ${TABLE}.client_id ;;
  }

  dimension_group: conversation_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.conversation_end_at ;;
  }

  dimension: conversation_id {
    type: string
    sql: ${TABLE}.conversation_id ;;
  }

  dimension_group: conversation_start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.conversation_start_at ;;
  }

  dimension: messages {
    hidden: yes
    sql: ${TABLE}.messages ;;
  }

  dimension: resolved_on_call {
    type: string
    sql: ${TABLE}.resolved_on_call ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: transcript_with_messages__messages {
  dimension: answer_end {
    type: number
    sql: ${TABLE}.answer_end ;;
  }

  dimension: answer_start {
    type: number
    sql: ${TABLE}.answer_start ;;
  }

  dimension: intent_id {
    type: string
    sql: ${TABLE}.intent_id ;;
  }

  dimension: issue_subtopic {
    type: string
    sql: ${TABLE}.issue_subtopic ;;
  }

  dimension: issue_topic {
    type: string
    sql: ${TABLE}.issue_topic ;;
  }

  dimension: live_agent_speaking {
    type: yesno
    sql: ${TABLE}.live_agent_speaking ;;
  }

  dimension: message_id {
    type: string
    sql: ${TABLE}.message_id ;;
  }

  dimension: response {
    type: string
    sql: ${TABLE}.response ;;
  }

  dimension: row {
    type: number
    sql: ${TABLE}.row ;;
  }

  dimension: sentiment {
    type: number
    sql: ${TABLE}.sentiment ;;
  }

  dimension: user_end {
    type: number
    sql: ${TABLE}.user_end ;;
  }

  dimension: user_question {
    type: string
    sql: ${TABLE}.user_question ;;
  }

  dimension: user_start {
    type: number
    sql: ${TABLE}.user_start ;;
  }
}
