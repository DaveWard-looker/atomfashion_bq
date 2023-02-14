view: projected_revenue {
    derived_table: {
      sql: WITH DATE_TABLE AS (
        SELECT X.*,
               EXTRACT(YEAR FROM DAY)  AS YEAR,
               EXTRACT(MONTH FROM DAY) AS MONTH
        FROM (
        SELECT PRODUCTS.BRAND                                                AS BRAND,
               DATE_ADD('2014-01-01', INTERVAL F.NUMBER DAY)                 AS DAY
        FROM ecomm.atom_order_items as order_items
        LEFT JOIN ecomm.atom_inventory_items as inventory_items ON ORDER_ITEMS.INVENTORY_ITEM_ID = INVENTORY_ITEMS.ID
        LEFT JOIN ecomm.atom_products as products ON INVENTORY_ITEMS.PRODUCT_ID = PRODUCTS.ID
        CROSS JOIN (SELECT number FROM UNNEST(GENERATE_ARRAY(0,3649)) AS number) F

        GROUP BY 1,2
        ORDER BY 1,2)
        X),
DAILY_HISTORY AS
      (
               SELECT D.*,
                      SUM(REVENUE) OVER(PARTITION BY BRAND,YEAR ORDER BY DAY ROWS UNBOUNDED PRECEDING)        AS YTD_REVENUE
               FROM (
               SELECT   PRODUCTS.BRAND                                                                        AS BRAND,
                        EXTRACT(YEAR FROM ORDER_ITEMS.CREATED_AT)                                             AS YEAR,
                        CAST(ORDER_ITEMS.CREATED_AT as date)                                                       AS DAY,
                        SUM(SALE_PRICE)                                                                       AS REVENUE
               FROM     ecomm.atom_order_items as order_items
               LEFT JOIN ecomm.atom_inventory_items as inventory_items ON ORDER_ITEMS.INVENTORY_ITEM_ID = INVENTORY_ITEMS.ID
               LEFT JOIN ecomm.atom_products as products ON INVENTORY_ITEMS.PRODUCT_ID = PRODUCTS.ID
               GROUP BY 1,2,3) D)

SELECT  ROW_NUMBER() OVER (ORDER BY DAY) AS PK,
        BRAND,
        YEAR,
        DAY,
        CASE WHEN DAY < CURRENT_DATE() THEN REVENUE
              ELSE LAST_REVENUE*(1+LAST_VALUE(PERCENT_CHANGE IGNORE NULLS) OVER (PARTITION BY BRAND ORDER BY DAY ROWS UNBOUNDED PRECEDING))
              END                                                                         AS REVENUE,
        CASE WHEN DAY >= CURRENT_DATE() THEN 'Yes' ELSE 'No' END AS PROJECTED
FROM (
SELECT Y.*,
      1.0*(YTD_REVENUE - LAST_YTD_REVENUE)/NULLIF(LAST_YTD_REVENUE,0) AS PERCENT_CHANGE
FROM (
SELECT DT.BRAND                                                                                                                            AS BRAND,
       DT.YEAR                                                                                                                             AS YEAR,
       DT.DAY                                                                                                                              AS DAY,
       DH.REVENUE                                                                                                                          AS REVENUE,
       DH.YTD_REVENUE                                                                                                                      AS YTD_REVENUE,
       CASE WHEN (MOD(DT.YEAR,4) = 0 AND DT.MONTH > 2)
            THEN LAG(DH.REVENUE,366) OVER(PARTITION BY DT.BRAND ORDER BY DT.DAY)
            ELSE LAG(DH.REVENUE,365) OVER(PARTITION BY DT.BRAND ORDER BY DT.DAY)
            END                                                                                                                            AS LAST_REVENUE,
      CASE WHEN (MOD(DT.YEAR,4) = 0 AND DT.MONTH > 2)
            THEN LAG(DH.YTD_REVENUE,366) OVER(PARTITION BY DT.BRAND ORDER BY DT.DAY)
            ELSE LAG(DH.YTD_REVENUE,365) OVER(PARTITION BY DT.BRAND ORDER BY DT.DAY)
            END                                                                                                                            AS LAST_YTD_REVENUE
FROM DATE_TABLE DT
LEFT JOIN DAILY_HISTORY DH ON CAST(DT.DAY as date) = CAST(DH.DAY as date) AND DT.BRAND = DH.BRAND
ORDER BY 1,2,3) Y) YY
             ;;
      datagroup_trigger: every_day
    }

    dimension: pk {
      primary_key: yes
      hidden: yes
      type: string
      sql: ${TABLE}.pk ;;
    }

    dimension: year {
      hidden: yes
      type: number
      sql: ${TABLE}.year ;;
    }

    dimension: brand {
      hidden: yes
      type: string
      sql: ${TABLE}.brand ;;
    }

    dimension_group: day {
      label: "Created"
      timeframes: [raw,date,day_of_month,week_of_year,month,quarter,year,day_of_year,month_name,month_num]
      type: time
      sql: CAST(${TABLE}.day as timestamp) ;;
    }

    dimension: revenue {
      type: number
      sql: ${TABLE}.revenue ;;
      value_format_name: usd
    }

    measure: total_revenue {
      description: "This measure can only be grouped by date formats"
      type: sum
      sql: ${revenue} ;;
      value_format_name: usd_0
      drill_fields: [day_month,actual_revenue,projected_revenue,total_revenue]
    }

    measure: projected_revenue {
      description: "This measure can only be grouped by date formats"
      type: sum
      sql: ${revenue} ;;
      filters: {
        field: projected
        value: "Yes"
      }
      value_format_name: usd_0
      drill_fields: [day_month,total_revenue]
    }

    measure: actual_revenue {
      description: "This measure can only be grouped by date formats"
      type: sum
      sql: ${revenue} ;;
      filters: {
        field: projected
        value: "No"
      }
      value_format_name: usd_0
      drill_fields: [day_month,total_revenue]
    }

    dimension: projected {
      type: yesno
      sql: ${TABLE}.projected = 'Yes' ;;
    }

  }

#   set: detail {
#     fields: [year, day, revenue, projected]
#   }
