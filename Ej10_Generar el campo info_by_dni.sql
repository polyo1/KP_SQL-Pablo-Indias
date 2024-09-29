SELECT ivr_id,
       document_type,
       document_identification,
       MAX(customer_phone) AS customer_phone,
    CASE
        WHEN MAX(CASE WHEN step_name = 'CUSTOMERINFOBYDNI.TX' AND step_result = 'OK' THEN 1 ELSE 0 END) = 1 THEN 1
        ELSE 0
    END AS customer_identified_flag
FROM `keepcoding.ivr_detail`
GROUP BY ivr_id, document_type, document_identification;