SELECT ivr_id,
       document_type,
       document_identification
FROM `keepcoding.ivr_detail`
WHERE document_identification <> 'UNKNOWN'
  AND (document_type <> 'UNKNOWN' AND document_type <> 'DESCONOCIDO');