view: products {
  sql_table_name: @{schema}.atom_products ;;

  ## ATOM.VIEW SQL
  #   create view @{schema}.products as
  #     select *,
  #     CASE WHEN LEFT(brand, 1) in ('A', 'B', 'N', 'P') or brand = 'Columbia' THEN 'Columbia'
  #                   WHEN LEFT(brand, 1) in ('D', 'E',  'X', 'J', 'K', 'M', 'W')  or brand = 'Calvin Klein' THEN 'Calvin Klein'
  #                   WHEN LEFT(brand, 1) in ('C', 'H', 'I','R') THEN 'Carhartt'
  #                   WHEN LEFT(brand, 1) in ('L', 'G', 'O') THEN 'Levi''s'
  #                   ELSE 'Dockers'
  #               END as brand_name
  #     from @{schema}.products


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: category {
    sql: trim(${TABLE}.category) ;;

    link: {
      label: "Go to {{value}} Dashboard"
      url: "/dashboards/38?Category={{value | url_encode}}"
      icon_url: "http://www.google.com/s2/favicons?domain=looker.com"
    }

    link: {
      label: "Google"
      url: "http://www.google.com/search?q={{value}}"
      icon_url: "http://www.google.com/s2/favicons?domain=google.com"
    }

    link: {
      label: "Wikipedia"
      url: "http://www.google.com/search?q=site:wikipedia.com+{{value}}&btnI"
      icon_url: "http://www.google.com/s2/favicons?domain=wikipedia.com"
    }

    link: {
      label: "Twitter"
      url: "http://www.google.com/search?q=site:twitter.com+{{value}}&btnI"
      icon_url: "http://www.google.com/s2/favicons?domain=twitter.com"
    }

    link: {
      label: "Facebook"
      url: "http://www.google.com/search?q=site:facebook.com+{{value}}&btnI"
      icon_url: "http://www.google.com/s2/favicons?domain=facebook.com"
    }

  }

  dimension: product_image {
    type: string
    sql: concat(${category}, '-',${department}) ;;
    html: <img width="100%" src="https://storage.cloud.google.com/atom-products/{{ value | encode_uri }}.jpg" /> ;;
  }


  dimension: category_type {
    type: string
#     link: {
#       label: "View {{value}} inventory"
#       url: "/dashboards/137?Product%20Category%20Type={{ value | encode_uri }}"
#     }
    case: {
      when: {
        sql: ${category} = 'Blazers & Jackets'
            or ${category} = 'Dresses'
            or ${category} = 'Jumpsuits & Rompers'
            or ${category} = 'Suits'
            or ${category} = 'Suits & Sport Coats'
            or ${category} = 'Outerwear & Coats'
            ;;
        label: "Formal Wear"
      }
      when: {
        sql:  ${category} = 'Pants'
            or ${category} = 'Pants & Capris'
            or ${category} = 'Shorts'
            or ${category} = 'Skirts'
            or ${category} = 'Jeans'
        ;;
        label: "Bottoms"
      }
      when: {
        sql: ${category} = 'Sweaters'
            or ${category} = 'Tops & Tees'
            or ${category} = 'Fashion Hoodies & Sweatshirts'
        ;;
        label: "Tops"
      }
      else: "Other"
      # Possibly more when statements
    }
    alpha_sort: yes

  }


  dimension: item_name {
    sql: REPLACE(trim(${original_item_name}), ${original_brand}, ${brand}) ;;
  }

  dimension: original_item_name {
    hidden: yes
    sql: INITCAP(${TABLE}.name) ;;
  }
  dimension: original_brand {
    hidden: yes
    type: string
    sql: INITCAP(${TABLE}.brand) ;;
  }

  dimension: brandlink {
    hidden: no
    type: string
    sql: lower(regexp_replace(${TABLE}.brand_name , '[^a-zA-Z0-9]', '')) ;;
  }

  dimension: brand {
        sql: trim(${TABLE}.brand_name) ;;
      type: string
      html:{{value}} <img src = "http://www.google.com/s2/favicons?domain={{brandlink._value}}.com" /> ;;
      link: {
        label: "Google search for {{value}}"
        url: "https://www.google.com/search?q={{value}}"
        icon_url: "https://www.google.com/favicon.ico"
      }
      link: {
        label: "{{value}} Dashboard"
        url: "/dashboards/3?Brand={{value}}"
        icon_url: "https://www.google.com/s2/favicons?domain=looker.com"
      }
      link: {
        label: "{{value}} website"
        url: "http://www.{{brandlink._rendered_value}}.com"
        icon_url: "http://www.google.com/s2/favicons?domain={{brandlink._value}}.com"
      }
      link: {
        label: "{{value}} Facebook Page"
        url: "https://www.facebook.com/{{brandlink._value}}"
        icon_url: "https://www.google.com/s2/favicons?domain=facebook.com"
      }
      action: {
        label: "Send a query to the Marketing Team about {{ value }}"
        icon_url: "http://www.google.com/s2/favicons?domain={{brandlink._value}}.com"
        url: "https://fashionlydw.free.beeceptor.com"
        param: {
          name: "Message Query about this brand"
          value: "Hi I would like to make a query about {{ value }}  "
        }
      }
     }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: department {
    sql: trim(${TABLE}.department) ;;
  }

  dimension: sku {
    sql: ${TABLE}.sku ;;
  }

  dimension: distribution_center_id {
    type: number
    sql: ${TABLE}.distribution_center_id ;;
  }

  ## MEASURES ##

  measure: count {
    type: count
  }

  measure: brand_count {
    type: count_distinct
    sql: ${brand} ;;
  }

  measure: category_count {
    alias: [category.count]
    type: count_distinct
    sql: ${category} ;;
  }

  measure: department_count {
    alias: [department.count]
    type: count_distinct
    sql: ${department} ;;
  }

  measure: average_retail_price {
    type: average
    sql: ${retail_price} ;;
    value_format: "$#,##0.00"
  }

  set: detail {
    fields: [
      id,
      item_name,
      brand,
      category,
      department,
      retail_price,
      customers.count,
      orders.count,
      order_items.count,
      inventory_items.count
    ]
  }

  set: detail2 {
    fields: [
      category_count,
      brand_count,
      department_count,
      count,
      customers.count,
      orders.count,
      order_items.count,
      inventory_items.count,
      products.count
    ]
  }

  set: simple {
    fields: [
      id,
      item_name,
      brand,
      category,
      department,
      retail_price,
      brandlink,
      count
    ]
  }
}
