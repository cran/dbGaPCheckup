## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----individual_checks, echo=FALSE--------------------------------------------
fn.path <- system.file("extdata", "Functions.xlsx",
   package = "dbGaPCheckup", mustWork=TRUE)
fns <- readxl::read_xlsx(fn.path)
knitr::kable(fns, caption = "List of function names and types.")

## -----------------------------------------------------------------------------
library(dbGaPCheckup)

## ----ds, echo=FALSE-----------------------------------------------------------
DS.path <- system.file("extdata", "DS_Example.txt",
   package = "dbGaPCheckup", mustWork=TRUE)
DS.data <- read.table(DS.path, header=TRUE, sep="\t",
   quote="", as.is = TRUE)

## ---- echo=FALSE--------------------------------------------------------------
knitr::kable(DS.data[1:6,], caption="First six lines of an example dbGaP data set.") 

## ----dd, echo=FALSE, message=FALSE--------------------------------------------
DD.path <- system.file("extdata", "3b_SSM_DD_Example1.xlsx",
   package = "dbGaPCheckup", mustWork=TRUE)
DD.dict <- readxl::read_xlsx(DD.path)

## ---- echo=FALSE--------------------------------------------------------------
knitr::kable(DD.dict[1:6,], caption = "First six lines of an example dbGaP data dictionary.")

## ----data1, message=FALSE-----------------------------------------------------
data(ExampleD)

## ----cr1----------------------------------------------------------------------
e1_report <- check_report(DD.dict.D, DS.data.D, non.NA.missing.codes=c(-4444, -9999))

## ----cr_invest----------------------------------------------------------------
e1_report$Message[2]
e1_report$Information$pkg_field_check.Info

## ----add_missing--------------------------------------------------------------
DD.dict_updated <- add_missing_fields(DD.dict.D, DS.data.D)

## ----cr2----------------------------------------------------------------------
e1_report.v2 <- check_report(DD.dict_updated, DS.data.D, non.NA.missing.codes=c(-4444, -9999)) # Note! Don't forget to call in the updated version of the data dictionary here! 

## ----data2, message=FALSE-----------------------------------------------------
data(ExampleL)

## ----cr3----------------------------------------------------------------------
e2_report <- check_report(DD.dict.L, DS.data.L) 

## ----name_check---------------------------------------------------------------
field_check(DD.dict.L) # pass
pkg_field_check(DD.dict.L) # pass
dimension_check(DD.dict.L, DS.data.L) # pass
name_check(DD.dict.L, DS.data.L) # failed

## ----name_check2--------------------------------------------------------------
DS.data_updated <- name_correct(DD.dict.L, DS.data.L)

## ----cr4----------------------------------------------------------------------
e2_report.v2 <- check_report(DD.dict.L, DS.data_updated, non.NA.missing.codes=c(-4444, -9999)) # Calling in updated data set

## ----data3, message=FALSE-----------------------------------------------------
data(ExampleB)

## ----cr5----------------------------------------------------------------------
e3_report <- check_report(DD.dict.B, DS.data.B)

## ----cr6----------------------------------------------------------------------
e3_report.v2 <- check_report(DD.dict.B, DS.data.B, non.NA.missing.codes=c(-9999))

## ----value_meaning------------------------------------------------------------
value_meaning_table(DD.dict.B)

## ----data4, message=FALSE-----------------------------------------------------
data(ExampleH)

## ----cr7----------------------------------------------------------------------
e4_report <- check_report(DD.dict.H, DS.data.H, non.NA.missing.codes=c(-4444, -9999))

## ----exp1---------------------------------------------------------------------
dictionary_search(DD.dict.H, search.term=c("SUP_SKF"), search.column=c("VARNAME"))

## ----exp2---------------------------------------------------------------------
table(DS.data.H$SUP_SKF)

## ----exp3---------------------------------------------------------------------
dictionary_search(DD.dict.H, search.term=c("skinfold"))

## ----exp4---------------------------------------------------------------------
table(DS.data.H$ABD_SKF)

## ----data5, message=FALSE-----------------------------------------------------
data(ExampleA)

## ----id_check-----------------------------------------------------------------
id_check(DS.data.A)

## ----misc_format_check--------------------------------------------------------
misc_format_check(DD.dict.A, DS.data.A) 

## ----row_check----------------------------------------------------------------
row_check(DS.data.A)

## ----NA_check-----------------------------------------------------------------
NA_check(DD.dict.A, DS.data.A)

## ----minmax_check-------------------------------------------------------------
minmax_check(DD.dict.A, DS.data.A)

## ----minmax_check2------------------------------------------------------------
b <- minmax_check(DD.dict.A, DS.data.A)
b$Information[[1]]$OutOfRangeValues

## ----minmax_check3------------------------------------------------------------
minmax_check(DD.dict.A, DS.data.A, non.NA.missing.codes=c(-4444, -9999))

## ----label--------------------------------------------------------------------
DS_labelled_data <- label_data(DD.dict.A, DS.data.A, non.NA.missing.codes=c(-9999))
labelled::var_label(DS_labelled_data$SEX)
labelled::val_labels(DS_labelled_data$SEX)
attributes(DS_labelled_data$SEX)
labelled::na_values(DS_labelled_data$HX_DEPRESSION)

## ----dataA1, warning=FALSE----------------------------------------------------
data(ExampleB)

## ----misssum------------------------------------------------------------------
missingness_summary(DS.data.B, non.NA.missing.codes = c(-9999), threshold = 95)

## ----vmt----------------------------------------------------------------------
results.list <- value_missing_table(DD.dict.B, DS.data.B, non.NA.missing.codes = c(-9999))
results <- results.list$report

## ----vmt1a, echo=FALSE--------------------------------------------------------
knitr::kable(results$Information$details$CheckA.AllMInD, 
      caption = "Table Check A: List of variables for 
      which user-defined missing value code is not present
      in the data.") 

## ----vmt2b, echo=FALSE--------------------------------------------------------
knitr::kable(results$Information$details$CheckB.AllVsInD, 
      caption = "Table Check B: List of variables for which 
      a VALUES entry defines an encoded code value, but that 
      value is not present in the data.") 

## ----inspect------------------------------------------------------------------
# Smoking 
table(DS.data.B$LENGTH_SMOKING_YEARS)
dictionary_search(DD.dict.B, search.term=c("LENGTH_SMOKING_YEARS"), search.column=c("VARNAME"))

# Heart rate 
table(DS.data.B$HEART_RATE)
dictionary_search(DD.dict.B, search.term=c("HEART_RATE"), search.column=c("VARNAME"))

## ----vmt3c, echo=FALSE--------------------------------------------------------
knitr::kable(results$Information$details$CheckC.AllSetMInSetV, 
      caption = "Table Check C: List of variables for which 
      user-defined missing value code(s) are not defined in 
      a VALUES entry.") 

## ----vmt4d, echo=FALSE--------------------------------------------------------
knitr::kable(results$Information$details$CheckD.All_MInSetD_InSetV, 
      caption = "Table Check D: List of variables for which a 
      user-defined missing value code is present in the data for 
      a given variable, but that variable does not have a 
      corresponding VALUES entry.") 

## ----vmt4e, echo=FALSE--------------------------------------------------------
knitr::kable(results$Information$details$CheckE.All_VNotInM_NotInD, 
      caption = "Table Check E: List of variables for which a 
      VALUES entry is NOT defined as a missing value code 
      AND is NOT identified in the data") 

## ----prep_data, echo=FALSE----------------------------------------------------
# Create data set with missing value codes 
# replaced with NA's (embedded in create_report function)
library(dplyr)
non.NA.missing.codes <- c(-4444, -9999)
dataset.na <- DS.data
for (value in na.omit(non.NA.missing.codes)) {
  dataset.na <- dataset.na %>% 
    mutate(across(everything(), ~na_if(.x, value)))
}

## ----applyfun, results="asis"-------------------------------------------------
dat_function_selected(DS.data.B, DD.dict.B, sex.split = TRUE, sex.name = "SEX", start = 3, end = 6, dataset.na=dataset.na, h.level=4)

