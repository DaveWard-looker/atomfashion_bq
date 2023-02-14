- dashboard: inventory_overview
  title: Inventory Overview
  layout: newspaper
  elements:
  - title: Inventory Aging Report
    name: Inventory Aging Report
    model: atom_fashion
    explore: order_items
    type: looker_column
    fields: [inventory_items.days_in_inventory_tier, inventory_items.count]
    fill_fields: [inventory_items.days_in_inventory_tier]
    filters:
      inventory_items.is_sold: 'No'
    sorts: [inventory_items.days_in_inventory_tier]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    defaults_version: 1
    listen: {}
    row: 2
    col: 12
    width: 12
    height: 6
  - title: Order Shipment Status
    name: Order Shipment Status
    model: atom_fashion
    explore: order_items
    type: looker_column
    fields: [order_items.created_date, order_items.count, order_items.status]
    pivots: [order_items.status]
    fill_fields: [order_items.created_date]
    filters:
      order_items.status: "-Cancelled"
    sorts: [order_items.created_date desc, order_items.status]
    limit: 500
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_series: [Cancelled - order_items.count, Returned - order_items.count]
    series_types: {}
    series_colors:
      Complete - order_items.count: green
      Processing - order_items.count: red
      Shipped - order_items.count: orange
      Returned - order_items.count: grey
    defaults_version: 1
    listen:
      Date: order_items.created_date
    row: 22
    col: 0
    width: 24
    height: 6
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
    column_limit: 50
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
    row: 8
    col: 12
    width: 12
    height: 6
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
    column_limit: 50
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
    row: 8
    col: 0
    width: 12
    height: 6
  - title: Total Value of Inventory on Hand
    name: Total Value of Inventory on Hand
    model: atom_fashion
    explore: order_items
    type: single_value
    fields: [inventory_items.total_cost]
    filters:
      inventory_items.is_sold: 'No'
    limit: 500
    query_timezone: America/Los_Angeles
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen: {}
    row: 2
    col: 0
    width: 12
    height: 6
  - title: "# Orders Processing"
    name: "# Orders Processing"
    model: atom_fashion
    explore: order_items
    type: single_value
    fields: [order_items.count]
    filters:
      order_items.status: Processing
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Date: order_items.created_date
    row: 16
    col: 0
    width: 8
    height: 6
  - title: Total Amount Processing
    name: Total Amount Processing
    model: atom_fashion
    explore: order_items
    type: single_value
    fields: [order_items.total_sale_price]
    filters:
      order_items.status: Processing
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Date: order_items.created_date
    row: 16
    col: 8
    width: 8
    height: 6
  - title: "# Orders In Transit"
    name: "# Orders In Transit"
    model: atom_fashion
    explore: order_items
    type: single_value
    fields: [order_items.count]
    filters:
      order_items.status: Shipped
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    listen:
      Date: order_items.created_date
    row: 16
    col: 16
    width: 8
    height: 6
  - name: Inventory
    type: text
    title_text: Inventory
    body_text: ''
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Order Processing
    type: text
    title_text: Order Processing
    body_text: ''
    row: 14
    col: 0
    width: 24
    height: 2
  filters:
  - name: Date
    title: Date
    type: field_filter
    default_value: this quarter
    allow_multiple_values: true
    required: false
    model: atom_fashion
    explore: order_items
    listens_to_filters: []
    field: order_items.created_date
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
