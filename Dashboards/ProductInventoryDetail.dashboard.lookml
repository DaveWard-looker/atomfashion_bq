- dashboard: product_inventory_detail
  title: Product Inventory Detail
  layout: newspaper
  elements:
  - title: Product Category Inventory Detail
    name: Product Category Inventory Detail
    model: atom_fashion
    explore: order_items
    type: looker_grid
    fields: [inventory_items.count, products.category, products.item_name]
    filters: {}
    sorts: [inventory_items.count desc]
    limit: 500
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
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    defaults_version: 1
    hidden_fields: []
    series_types: {}
    listen:
      Product Category Type: products.category_type
    row: 0
    col: 0
    width: 8
    height: 6
  filters:
  - name: Product Category Type
    title: Product Category Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: atom_fashion
    explore: order_items
    listens_to_filters: []
    field: products.category_type
