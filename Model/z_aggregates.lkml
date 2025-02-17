include: "/Model/atom_fashion.model.lkml"

# Place in `atom_fashion` model
explore: +order_items {
  aggregate_table: rollup__created_date {
    query: {
      dimensions: [
        order_items.created_date,
        products.brand,
        products.category,
        created_date
      ]
      measures: [order_count, total_sale_price]
      timezone: America/Los_Angeles
    }

    materialization: {
      datagroup_trigger: every_day
    }
  }
}


# Place in `atom_fashion` model
explore: +order_items {
  aggregate_table: rollup__created_date__created_month__created_week__products_brand__products_category__products_category_type__users_city__users_country__users_state {
    query: {
      dimensions: [
        order_items.created_date,
        products.brand,
        products.category,
        products.category_type,
        users.city,
        users.country,
        users.state
      ]
      measures: [total_sale_price, total_tax_amount]
      timezone: America/Los_Angeles
    }

    materialization: {
      datagroup_trigger: every_day
    }
  }
}
