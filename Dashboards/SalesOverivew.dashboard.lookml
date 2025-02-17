- dashboard: sales_overview
  title: Sales Overview
  layout: newspaper
  description: ''
  preferred_slug: PEdgnAL0iZ21489OgKCl3v
  elements:
  - title: Sales, Returns & Tax this Quarter
    name: Sales, Returns & Tax this Quarter
    model: atom_fashion
    explore: order_items
    type: looker_line
    fields: [order_items.total_sale_price, order_items.created_date, order_items.total_returns,
      order_items.total_tax_amount]
    fill_fields: [order_items.created_date]
    sorts: [order_items.created_date]
    limit: 500
    column_limit: 50
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
    show_null_points: false
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: order_items.total_sale_price,
            id: order_items.total_sale_price, name: Total Sale Price}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}, {label: !!null '', orientation: right, series: [{axisId: order_items.total_returns,
            id: order_items.total_returns, name: Total Returns}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    series_colors:
      order_items.total_sale_price: "#295cf5"
      order_items.total_returns: "#f5ac1e"
    defaults_version: 1
    listen:
      Date: order_items.created_date
    row: 6
    col: 0
    width: 24
    height: 7
  - title: First Order vs Repeat Customer Split
    name: First Order vs Repeat Customer Split
    model: atom_fashion
    explore: order_items
    type: looker_column
    fields: [order_items.created_date, order_facts.is_first_purchase, order_items.order_count]
    pivots: [order_facts.is_first_purchase]
    fill_fields: [order_items.created_date, order_facts.is_first_purchase]
    sorts: [order_items.created_date desc, order_facts.is_first_purchase]
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
    series_colors:
      order_items.total_sale_price: "#295cf5"
      No - order_items.order_count: "#295cf5"
      Yes - order_items.order_count: "#f51a32"
    show_null_points: false
    interpolation: linear
    defaults_version: 1
    listen:
      Date: order_items.created_date
    row: 13
    col: 0
    width: 24
    height: 7
  - title: Total Sales Price
    name: Total Sales Price
    model: atom_fashion
    explore: order_items
    type: single_value
    fields: [order_items.total_sale_price, order_items.order_count, order_items.average_days_to_process,
      order_items.average_spend_per_user]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: ''
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
    defaults_version: 1
    listen:
      Date: order_items.created_date
    row: 0
    col: 0
    width: 6
    height: 6
  - title: Total Order Count
    name: Total Order Count
    model: atom_fashion
    explore: order_items
    type: single_value
    fields: [order_items.total_sale_price, order_items.order_count, order_items.average_days_to_process,
      order_items.average_spend_per_user]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: ''
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
    defaults_version: 1
    hidden_fields: [order_items.total_sale_price]
    listen:
      Date: order_items.created_date
    row: 0
    col: 18
    width: 6
    height: 6
  - title: Average Days to Process
    name: Average Days to Process
    model: atom_fashion
    explore: order_items
    type: single_value
    fields: [order_items.total_sale_price, order_items.order_count, order_items.average_days_to_process,
      order_items.average_spend_per_user]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: ''
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
    defaults_version: 1
    hidden_fields: [order_items.total_sale_price, order_items.order_count]
    listen:
      Date: order_items.created_date
    row: 0
    col: 12
    width: 6
    height: 6
  - title: Average Spend per User
    name: Average Spend per User
    model: atom_fashion
    explore: order_items
    type: single_value
    fields: [order_items.total_sale_price, order_items.order_count, order_items.average_days_to_process,
      order_items.average_spend_per_user]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    single_value_title: ''
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
    defaults_version: 1
    hidden_fields: [order_items.total_sale_price, order_items.order_count, order_items.average_days_to_process]
    listen:
      Date: order_items.created_date
    row: 0
    col: 6
    width: 6
    height: 6
  - title: Top 5 Selling Product Categories
    name: Top 5 Selling Product Categories
    model: atom_fashion
    explore: order_items
    type: looker_grid
    fields: [order_items.count, order_items.total_sale_price, products.category_type]
    fill_fields: [products.category_type]
    sorts: [order_items.count desc]
    limit: 5
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
      order_items.count:
        is_active: true
      order_items.total_sale_price:
        is_active: true
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
    listen:
      Date: order_items.created_date
    row: 20
    col: 0
    width: 12
    height: 6
  - title: Orders by State
    name: Orders by State
    model: atom_fashion
    explore: order_items
    type: looker_map
    fields: [order_items.total_sale_price, users.state]
    sorts: [order_items.total_sale_price desc]
    limit: 500
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: custom
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map_latitude: 37.99626096764872
    map_longitude: -93.27742338180543
    map_zoom: 4
    map_value_colors: [red, blue]
    defaults_version: 1
    listen:
      Date: order_items.created_date
    row: 20
    col: 12
    width: 12
    height: 6
  filters:
  - name: Date
    title: Date
    type: field_filter
    default_value: this quarter
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: atom_fashion
    explore: order_items
    listens_to_filters: []
    field: order_items.created_date
