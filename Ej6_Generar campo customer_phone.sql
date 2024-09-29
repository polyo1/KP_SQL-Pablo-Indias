SELECT ivr_id,
      document_type,
      document_identification,
      MAX(customer_phone) AS customer_phone
  FROM `bigdata-sql-pi.keepcoding.ivr_detail`
  WHERE customer_phone<>'UNKNOWN' 
    AND (customer_phone<>'UNKNOWN' 
    AND customer_phone<>'DESCONOCIDO')
GROUP BY ivr_id,document_identification,document_type;