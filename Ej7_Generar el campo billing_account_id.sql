SELECT ivr_id,
       document_type,
       document_identification,
  MAX(customer_phone) AS customer_phone
 FROM `keepcoding.ivr_detail`
WHERE customer_phone IS NOT NULL
GROUP BY ivr_id, document_type, document_identification;