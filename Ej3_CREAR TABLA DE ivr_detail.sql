DROP TABLE IF EXISTS `keepcoding.ivr_detail`;

CREATE TABLE IF NOT EXISTS `keepcoding.ivr_detail` AS
  SELECT calls.ivr_id,
         phone_number,
         ivr_result,
         vdn_label,
         start_date,
         FORMAT_DATE('%Y%m%d', CAST(start_date AS DATE)) AS calls_start_date_id,
         end_date,
         FORMAT_DATE('%Y%m%d', CAST(end_date AS DATE)) AS calls_end_date_id,
         total_duration,
         customer_segment,
         ivr_language,
         steps_module,
         module_aggregation,
         modules.module_sequece,
         module_name,
         module_duration,
         module_result,
         step_name,
         step_result,
         step_description_error,
         document_type,
         document_identification,
         customer_phone,
         billing_account_id
   FROM `keepcoding.ivr_calls` AS calls
INNER JOIN `keepcoding.ivr_modules` AS modules
     ON calls.ivr_id = modules.ivr_id
INNER JOIN `keepcoding.ivr_steps` AS steps
     ON modules.module_sequece = steps.module_sequece
     AND modules.ivr_id = steps.ivr_id;
