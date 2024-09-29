SELECT calls.ivr_id AS calls_ivr_id,
    CASE 
        WHEN calls.vdn_label LIKE 'ATC%' THEN 'FRONT'
        WHEN calls.vdn_label LIKE 'TECH%' THEN 'TECH'
        WHEN calls.vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
        ELSE 'RESTO'
    END AS vdn_aggregation
FROM `keepcoding.ivr_calls` AS calls;