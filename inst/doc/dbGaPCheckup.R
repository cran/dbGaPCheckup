## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----individual_checks, echo=FALSE--------------------------------------------
fn.path <- system.file("extdata", "Functions.xlsx",
   package = "dbGaPCheckup", mustWork=TRUE)
fns <- readxl::read_xlsx(fn.path)
knitr::kable(fns, caption="List of function names and types.")

## ----load_libraries-----------------------------------------------------------
library(dbGaPCheckup)

## ----data---------------------------------------------------------------------
DS.path <- system.file("extdata", "DS_Example.txt",
   package = "dbGaPCheckup", mustWork=TRUE)
DS.data <- read.table(DS.path, header=TRUE, sep="\t", quote="", as.is = TRUE)

## ----dict---------------------------------------------------------------------
DD.path <- system.file("extdata", "3b_SSM_DD_Example2f.xlsx",
   package = "dbGaPCheckup", mustWork=TRUE)
DD.dict <- readxl::read_xlsx(DD.path)

## ----cr1----------------------------------------------------------------------
report <- check_report(DD.dict = DD.dict, DS.data = DS.data, non.NA.missing.codes=c(-4444, -9999))

## ----add_missing--------------------------------------------------------------
DD.dict.updated <- add_missing_fields(DD.dict, DS.data)

## ----cr2----------------------------------------------------------------------
report.v2 <- check_report(DD.dict = DD.dict.updated , DS.data = DS.data, non.NA.missing.codes=c(-4444, -9999))

## ----label_data---------------------------------------------------------------
DS_labelled_data <- label_data(DD.dict.updated, DS.data, non.NA.missing.codes=c(-9999))
labelled::var_label(DS_labelled_data$SEX)
labelled::val_labels(DS_labelled_data$SEX)
attributes(DS_labelled_data$SEX)
labelled::na_values(DS_labelled_data$HX_DEPRESSION)

