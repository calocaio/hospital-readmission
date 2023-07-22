-- Databricks notebook source
-- MAGIC %md
-- MAGIC Notas importantes: nosso benchmark é de 30 dias para readmissão 
-- MAGIC
-- MAGIC problemas enfrentados pelos planos de saúde: Envelhecimento da população, prevenção de doenças crônicas 
-- MAGIC
-- MAGIC doenças(primeiro diagnóstico) por grupo étnico e faixa etária 
-- MAGIC
-- MAGIC doenças que causam readmissão por faixa etária 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC Juntando todas as tabelas

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC WITH tb_admission AS 
-- MAGIC (
-- MAGIC SELECT t2.description as descricao, t1.* FROM sandbox.twitch.diabetic_data as t1
-- MAGIC
-- MAGIC LEFT JOIN sandbox.twitch.admission_type_id as t2
-- MAGIC ON t1.admission_type_id = t2.admission_type_id
-- MAGIC
-- MAGIC
-- MAGIC LEFT JOIN sandbox.twitch.admission_source_id as t3
-- MAGIC ON t1.admission_source_id = t3.admission_source_id
-- MAGIC )
-- MAGIC
-- MAGIC
-- MAGIC SELECT * 
-- MAGIC FROM tb_admission as t4
-- MAGIC
-- MAGIC LEFT JOIN sandbox.twitch.discharge_disposition_id as t5
-- MAGIC ON t5.discharge_disposition_id = t4.discharge_disposition_id
-- MAGIC
-- MAGIC
-- MAGIC
-- MAGIC
-- MAGIC

-- COMMAND ----------

-- MAGIC %python
-- MAGIC #jogando o resultado do SQL para Python
-- MAGIC
-- MAGIC import pandas as pd
-- MAGIC from datetime import datetime
-- MAGIC
-- MAGIC df = _sqldf #SQL cell result stored as PySpark data frame _sqldf, será que  o projeto em Spark?
-- MAGIC #também dá pra fazer usando SQLite
-- MAGIC pandas_df = df.toPandas() 
-- MAGIC
-- MAGIC #pandas_df.describe() #para informações numéricas
-- MAGIC pandas_df.info()

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC
-- MAGIC SELECT description, 
-- MAGIC admission_type_id
-- MAGIC FROM sandbox.twitch.diabetic_data
-- MAGIC WHERE description IS NOT NULL

-- COMMAND ----------

-- MAGIC %python
-- MAGIC pandas_df.race.unique()

-- COMMAND ----------

-- MAGIC %python
-- MAGIC import pandas as pd 
-- MAGIC
-- MAGIC pandas_df['readmitted'] = pandas_df['readmitted'].replace({'<30': 'Yes', '>30': 'No', 'NO': 'No'})

-- COMMAND ----------

-- MAGIC %python
-- MAGIC pandas_df

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC SELECT patient_nbr,
-- MAGIC count(patient_nbr) 
-- MAGIC FROM sandbox.twitch.diabetic_data
-- MAGIC
-- MAGIC group by patient_nbr

-- COMMAND ----------

-- MAGIC %sql
-- MAGIC
-- MAGIC SELECT * 
-- MAGIC FROM sandbox.twitch.diabetic_data
-- MAGIC WHERE patient_nbr = 3616155

-- COMMAND ----------


