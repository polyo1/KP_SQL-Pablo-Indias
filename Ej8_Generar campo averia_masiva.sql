SELECT  ivr_id,
        document_type,
        document_identification,
    MAX(customer_phone) AS customer_phone,
    CASE
        WHEN MAX(CASE WHEN module_name = 'AVERIA_MASIVA' THEN 1 ELSE 0 END) = 1 THEN 1
        ELSE 0
    END AS averia_masiva
   FROM `keepcoding.ivr_detail`
GROUP BY ivr_id, document_type, document_identification;