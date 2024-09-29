SELECT a.ivr_id,
       a.phone_number,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM `keepcoding.ivr_detail` AS b
            WHERE b.phone_number = a.phone_number
              AND b.start_date BETWEEN a.start_date - INTERVAL 1 DAY AND a.start_date
              AND a.ivr_id != b.ivr_id 
        ) THEN 1 ELSE 0
    END AS previous_24h_flag,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM `keepcoding.ivr_detail` AS c
            WHERE c.phone_number = a.phone_number
              AND c.start_date BETWEEN a.start_date AND a.start_date + INTERVAL 1 DAY
              AND a.ivr_id != c.ivr_id
        ) THEN 1 ELSE 0
    END AS next_24h_flag
FROM `keepcoding.ivr_detail` AS a;