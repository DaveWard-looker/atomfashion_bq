include: "/22_sessions.view.lkml"
include: "/04_products.view.lkml"
include: "/21_events.view.lkml"
include: "/02_users.view.lkml"
include: "/12_user_order_facts.view.lkml"


explore: web_sessions {
  from: sessions
  view_name: sessions
  label: "Web Session Data"
  fields: [ALL_FIELDS*, -sessions.spend_per_session, -sessions.spend_per_purchase, -sessions.weeks_since_campaing_start]
  access_filter: {
    field: product_viewed.brand
    user_attribute: brand
  }

  join: events {
    type: left_outer
    sql_on: ${sessions.session_id} = ${events.session_id} ;;
    relationship: one_to_many
  }

  join: product_viewed {
    from: products
    type: left_outer
    sql_on: ${events.viewed_product_id} = ${product_viewed.id} ;;
    relationship: many_to_one
  }

  join: session_landing_page {
    from: events
    type: left_outer
    sql_on: ${sessions.landing_event_id} = ${session_landing_page.event_id} ;;
    fields: [session_landing_page.simple_page_info*]
    relationship: one_to_one
  }

  join: session_bounce_page {
    from: events
    type: left_outer
    sql_on: ${sessions.bounce_event_id} = ${session_bounce_page.event_id} ;;
    fields: [session_bounce_page.simple_page_info*]
    relationship: one_to_one
  }

  join: users {
    type: left_outer
    relationship: many_to_one
    sql_on: ${users.id} = ${sessions.session_user_id} ;;
  }

  join: user_order_facts {
    type: left_outer
    relationship: many_to_one
    sql_on: ${user_order_facts.user_id} = ${users.id} ;;
    view_label: "Users"
  }
}
