- dashboard: products_overview
  title: Products Overview
  layout: newspaper
  embed_style:
    background_color: "#ffc0cb"
    show_title: true
    title_color: "#a30076"
    show_filters_bar: false
    tile_text_color: red
    text_tile_text_color: "#9c9129"
  elements:
  - title: Out of Stock Items
    name: Out of Stock Items
    model: atom_fashion
    explore: order_items
    type: looker_grid
    fields: [products.item_name, inventory_items.number_on_hand]
    filters:
      inventory_items.number_on_hand: '0'
      products.brand: ''
    sorts: [products.item_name]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      inventory_items.number_on_hand:
        is_active: false
    truncate_column_names: false
    defaults_version: 1
    series_types: {}
    listen:
      Product Name: products.item_name
    row: 0
    col: 0
    width: 12
    height: 7
  - title: Overstocked Items
    name: Overstocked Items
    model: atom_fashion
    explore: order_items
    type: looker_grid
    fields: [products.item_name, inventory_items.number_on_hand]
    filters:
      inventory_items.number_on_hand: ">20"
      products.brand: ''
    sorts: [inventory_items.number_on_hand desc]
    limit: 500
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_cell_visualizations:
      inventory_items.number_on_hand:
        is_active: true
        palette:
          palette_id: d937c795-0b34-44c0-951c-82978ae819bd
          collection_id: 04466cb5-eea5-4cc5-aad9-74e97f466b2e
    truncate_column_names: false
    defaults_version: 1
    series_types: {}
    listen:
      Product Name: products.item_name
    row: 0
    col: 12
    width: 12
    height: 7
  filters:
  - name: Product Name
    title: Product Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: atom_fashion
    explore: order_items
    listens_to_filters: []
    field: products.item_name
