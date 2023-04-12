{% snapshot inventory_snapshot %}

  {{
    config(
      target_database='dev_db',
      target_schema='dbt_zacharyshapirorapid7com',
      strategy='check',
      unique_key = 'product_id',
      check_cols =['inventory'],
    )
  }}

  SELECT * FROM {{ source('postgres', 'products') }}

{% endsnapshot %}