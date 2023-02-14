view: products {
  sql_table_name: ecomm.atom_products ;;

  ## ATOM.VIEW SQL
  #   create view ecomm.products as
  #     select *,
  #     CASE WHEN LEFT(brand, 1) in ('A', 'B', 'N', 'P') or brand = 'Columbia' THEN 'Columbia'
  #                   WHEN LEFT(brand, 1) in ('D', 'E',  'X', 'J', 'K', 'M', 'W')  or brand = 'Calvin Klein' THEN 'Calvin Klein'
  #                   WHEN LEFT(brand, 1) in ('C', 'H', 'I','R') THEN 'Carhartt'
  #                   WHEN LEFT(brand, 1) in ('L', 'G', 'O') THEN 'Levi''s'
  #                   ELSE 'Dockers'
  #               END as brand_name
  #     from ecomm.products


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

  dimension: brand {
        sql: trim(${TABLE}.brand_name) ;;

#     sql: CASE WHEN LEFT(${TABLE}.brand, 1) in ('A', 'B', 'N', 'P') or ${TABLE}.brand = 'Columbia' THEN 'Columbia'
#               WHEN LEFT(${TABLE}.brand, 1) in ('D', 'E',  'X', 'J', 'K', 'M', 'W')  or ${TABLE}.brand = 'Calvin Klein' THEN 'Calvin Klein'
#               WHEN LEFT(${TABLE}.brand, 1) in ('C', 'H', 'I','R') THEN 'Carhartt'
#               WHEN LEFT(${TABLE}.brand, 1) in ('L', 'G', 'O') THEN 'Levi''s'
#               ELSE 'Dockers'
#           END;;


    link: {
      label: "Website"
      url: "http://www.google.com/search?q={{ value | encode_uri }}+clothes&btnI"
      icon_url: "http://www.google.com/s2/favicons?domain=www.{{ value | encode_uri }}.com"
    }

    link: {
      label: "Facebook"
      url: "http://www.google.com/search?q=site:facebook.com+{{ value | encode_uri }}+clothes&btnI"
      icon_url: "https://static.xx.fbcdn.net/rsrc.php/yl/r/H3nktOa7ZMg.ico"
    }

#     link: {
#       label: "Brand Analytics Dashboard"
#       url: "/dashboards/5?Brand%20Name={{ value | encode_uri }}"
#       icon_url: "http://www.looker.com/favicon.ico"
#     }
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
      count
    ]
  }
}
