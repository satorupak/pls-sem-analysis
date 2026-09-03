#installing seminr package from outside source
install.packages("C:/Users/sator/OneDrive - IIT Delhi/R/seminr_2.3.3.zip", repos = NULL, type = "source")
library(seminr)

install.packages("readxl")
library(readxl)

data <- read_excel("C:/Users/sator/OneDrive - IIT Delhi/PROPOSAL/OWN WORK/EXCEL/SEM data 2 new.xlsx",'18 april')
HRdata$NE1 <- as.numeric(as.character(data$NE1)) 

data$HR <- rowSums(data[, c("HR1", "HR2","HR3","HR4","HR5","HR6","HR7","HR8","HR9","HR10","HR11","HR12","SC5","SC6","SC7")])
data$SS <- rowSums(data[, c("SS1", "SS2","SS3","SS4","SS5","SS6")])
data$SP <- rowSums(data[, c("SP1", "SP3","SP4", "DM")])
data$LS <- rowSums(data[, c("LS1","LS3","LS4","LS5")])
data$DG <- rowSums(data[, c("DG1", "DG2")])
data$CD <- rowSums(data[, c("CD2","CD3")])
data$HC <- rowSums(data[, c("HC1","HC2","HC6","HC7")])
data$HE <- rowSums(data[, c("HE1", "HE2","HE3")])
data$PH <- rowSums(data[, c("PH1", "PH2","PH3","PH4","PH5","PH6")])
data$SC <- rowSums(data[, c("SC1", "SC2","SC3","SC4")])

data$PE <- rowSums(data[, c("PE1", "PE2","PE3","PE4","PE5")])
data$NE <- rowSums(data[, c("NE1", "NE2","NE3","NE4")])


mm <- constructs(
  composite("Household resilience", single_item("HR"), mode_A),
  composite("Social support", single_item("SS"), mode_A),
  composite("Sense of place", single_item("SP"), mode_A),
  composite("Leadership", single_item("LS"), mode_A),
  composite("Post-disaster assistance", single_item("DG"), mode_A),
  composite("Community development", single_item("CD"), mode_A),
  composite("Housing condition", single_item("HC"), mode_A),
  composite("Household economic condition", single_item("HE"), mode_A),
  composite("Physical infrastructure", single_item("PH"), mode_A),
  composite("Social infrastructure", single_item("SC"), mode_A),
  composite("Previous experience", single_item("PE"),mode_A),
  composite("Nature of experience", single_item("NE"),mode_A),
  composite("Children and elderly", single_item("CHOL"),mode_A),
  composite("Adult literacy rate", single_item("EDU"),mode_A)
)


sm<- relationships(
  paths(from="Social support",to="Household resilience"),
  paths(from="Physical infrastructure",to="Household resilience"),
  paths(from="Social infrastructure",to="Household resilience"),
  paths(from="Sense of place",to="Household resilience"),
  paths(from="Children and elderly",to="Household resilience"),
  paths(from="Household economic condition",to="Household resilience"),
  paths(from="Previous experience",to="Household resilience"),
  paths(from="Adult literacy rate",to="Household resilience"),
  paths(from="Nature of experience",to="Household resilience"),
  paths(from="Community development",to="Household resilience"),
  
  
  paths(from="Sense of place",to="Social support"),
  paths(from="Leadership",to="Sense of place"),
  paths(from="Community development",to="Sense of place"),
  paths(from="Household economic condition",to="Housing condition"),
  paths(from="Housing condition",to="Nature of experience"),
  paths(from="Children and elderly",to="Nature of experience")
)


pls_model <- estimate_pls(
  data = data,
  measurement_model = mm,
  structural_model = sm
)

summary(pls_model)
plot(pls_model)


boot_pls_model <- bootstrap_model(
  seminr_model = pls_model,
  nboot = 5000, 
  cores = parallel::detectCores(),
  seed = 123
)

sum_boot_pls_model <- summary(boot_pls_model, alpha =
                                0.10)
sum_boot_pls_model$bootstrapped_weights
sum_boot_pls_model$bootstrapped_paths
sum_boot_pls_model$bootstrapped_total_paths


pls_pred <- predict_pls(
  model=pls_model, 
  technique = predict_DA,
  noFolds = 10, 
  reps = 1)

sum_pls_pred<- summary(pls_pred)

print (sum_pls_pred)
