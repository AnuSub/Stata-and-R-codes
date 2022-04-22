#install and load packages
#install.packages("LCA")
#install.packages("poLCA", dependencies = TRUE)
library(poLCA)
library(haven)
library(readxl)
#install.packages("ggplot")
#install.packages("ggwordcloud")
library(dplyr, quietly = TRUE, warn.conflicts = FALSE)
library(tidyr, quietly = TRUE)
library(foreign)
#install.packages("matrix")


sink("/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/Release64-1.3.2/LCA_50iters.txt")
data <- read_dta("/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/Release64-1.3.2/ClusteringData_LongCOVIDPatients.dta")
f <- cbind(I1_SOB,
           I2_Wheezing,
           I3_ChestPain,
           I4_LimbSwelling,
           I5_Palpitations,
           I6_PresyncopeDizzy,
           I7_Fatigue,
           I8_CognitiveProblems,
           I9_insomnia,
           I10_anosmia,
           I11_cough,
           I12_dysphagia,
           I13_EarPain,
           I14_HoarseVoice,
           I15_NasalCongestion_Sneeze,
           I16_Phlegm,
           I17_AbdominalPain,
           I18_Bloating,
           I19_BowelIncontinence,
           I20_Constipation,
           I21_Diarrhoea,
           I22_GastricReflux,
           I23_NauseaVomitting,
           I24_WeightLoss,
           I25_JointPain,
           I26_Parasthenia,
           I27_AnxietyDepression,
           I28_Anorexia,
           I29_DryScalySkin,
           I30_HairLoss,
           I31_HivesItchySkin,
           I32_NailChanges,
           I33_PurpuraRash,
           I34_DryEye,
           I35_RedWateryEye,
           I36_SexualDysfunction,
           I37_Menorrhagia,
           I38_VaginalDischarge,
           I39_AllergiesAngioedema,
           I40_Bodyache,
           I41_FeverChills,
           I42_DryMouth,
           I43_Haemoptysis,
           I44_HEadache,
           I45_HotFlushes,
           I46_MouthUlcer,
           I47_PolyUria,
           I48_UrinaryIncontinence,
           I49_UrinaryRetension,
           I50_Vertigo) ~ 1

set.seed(3000)
lc2<-poLCA(f, data=data, nclass=2, na.rm = FALSE, nrep=50, maxiter=10000,verbose=FALSE)
set.seed(3000)
lc3<-poLCA(f, data=data, nclass=3, na.rm = FALSE, nrep=50, maxiter=10000,verbose=FALSE)
set.seed(3000)
lc4<-poLCA(f, data=data, nclass=4, na.rm = FALSE, nrep=50, maxiter=10000,verbose=FALSE) 
set.seed(3000)
lc5<-poLCA(f, data=data, nclass=5, na.rm = FALSE, nrep=50, maxiter=10000,verbose=FALSE)
set.seed(3000)
lc6<-poLCA(f, data=data, nclass=6, na.rm = FALSE, nrep=50, maxiter=10000,verbose=FALSE)
set.seed(3000)
lc7<-poLCA(f, data=data, nclass=7, na.rm = FALSE, nrep=50, maxiter=10000,verbose=FALSE) 
set.seed(3000)
lc8<-poLCA(f, data=data, nclass=8, na.rm = FALSE, nrep=50, maxiter=10000,verbose=FALSE)
set.seed(3000)
lc9<-poLCA(f, data=data, nclass=9, na.rm = FALSE, nrep=50, maxiter=10000,verbose=FALSE)
set.seed(3000)
lc10<-poLCA(f, data=data, nclass=10, na.rm = FALSE, nrep=50, maxiter=10000,verbose=FALSE)
set.seed(3000)
lc11<-poLCA(f, data=data, nclass=11, na.rm = FALSE, nrep=50, maxiter=10000,verbose=FALSE)
set.seed(3000)
lc12<-poLCA(f, data=data, nclass=12, na.rm = FALSE, nrep=50, maxiter=10000,verbose=FALSE)

# generate dataframe with fit-values to create elbow plot
results <- data.frame(Model2=c("Modell 2"),
                      log_likelihood=lc2$llik,
                      df = lc2$resid.df,
                      BIC=lc2$bic,
                      ABIC=  (-2*lc2$llik) + ((log((lc2$N + 2)/24)) * lc2$npar),
                      CAIC = (-2*lc2$llik) + lc2$npar * (1 + log(lc2$N)), 
                      likelihood_ratio=lc2$Gsq)
results$Model2<-as.integer(results$Model2)
results[1,1]<-c("Modell 2")
results[2,1]<-c("Modell 3")
results[3,1]<-c("Modell 4")
results[4,1]<-c("Modell 5")
results[5,1]<-c("Modell 6")
results[6,1]<-c("Modell 7")
results[7,1]<-c("Modell 8")
results[8,1]<-c("Modell 9")
results[9,1]<-c("Modell 10")
results[10,1]<-c("Modell 11")
results[11,1]<-c("Modell 12")


results[1,2]<-lc2$llik
results[2,2]<-lc3$llik
results[3,2]<-lc4$llik
results[4,2]<-lc5$llik
results[5,2]<-lc6$llik
results[6,2]<-lc7$llik
results[7,2]<-lc8$llik
results[8,2]<-lc9$llik
results[9,2]<-lc105$llik
results[10,2]<-lc11$llik
results[11,2]<-lc12$llik

results[1,3]<-lc2$resid.df
results[2,3]<-lc3$resid.df
results[3,3]<-lc4$resid.df
results[4,3]<-lc5$resid.df
results[5,3]<-lc6$resid.df
results[6,3]<-lc7$resid.df
results[7,3]<-lc8$resid.df
results[8,3]<-lc9$resid.df
results[9,3]<-lc10$resid.df
results[10,3]<-lc11$resid.df
results[11,3]<-lc12$resid.df

results[1,4]<-lc2$bic
results[2,4]<-lc3$bic
results[3,4]<-lc4$bic
results[4,4]<-lc5$bic
results[5,4]<-lc6$bic
results[6,4]<-lc7$bic
results[7,4]<-lc8$bic
results[8,4]<-lc9$bic
results[9,4]<-lc10$bic
results[10,4]<-lc11$bic
results[11,4]<-lc12$bic

results[1,5]<-(-2*lc2$llik) + ((log((lc2$N + 2)/24)) * lc2$npar) #abic
results[2,5]<-(-2*lc3$llik) + ((log((lc3$N + 2)/24)) * lc3$npar)
results[3,5]<-(-2*lc4$llik) + ((log((lc4$N + 2)/24)) * lc4$npar)
results[4,5]<-(-2*lc5$llik) + ((log((lc5$N + 2)/24)) * lc5$npar)
results[5,5]<-(-2*lc6$llik) + ((log((lc6$N + 2)/24)) * lc6$npar)
results[6,5]<-(-2*lc7$llik) + ((log((lc7$N + 2)/24)) * lc7$npar) #abic
results[7,5]<-(-2*lc8$llik) + ((log((lc8$N + 2)/24)) * lc8$npar)
results[8,5]<-(-2*lc9$llik) + ((log((lc9$N + 2)/24)) * lc9$npar)
results[9,5]<-(-2*lc10$llik) + ((log((lc10$N + 2)/24)) * lc10$npar)
results[10,5]<-(-2*lc11$llik) + ((log((lc11$N + 2)/24)) * lc11$npar)
results[11,5]<-(-2*lc12$llik) + ((log((lc12$N + 2)/24)) * lc12$npar)

results[1,6]<- (-2*lc2$llik) + lc2$npar * (1 + log(lc2$N)) #caic
results[2,6]<- (-2*lc3$llik) + lc3$npar * (1 + log(lc3$N))
results[3,6]<- (-2*lc4$llik) + lc4$npar * (1 + log(lc4$N))
results[4,6]<- (-2*lc5$llik) + lc5$npar * (1 + log(lc5$N))
results[5,6]<- (-2*lc6$llik) + lc6$npar * (1 + log(lc6$N))
results[6,6]<- (-2*lc7$llik) + lc7$npar * (1 + log(lc7$N)) #caic
results[7,6]<- (-2*lc8$llik) + lc8$npar * (1 + log(lc8$N))
results[8,6]<- (-2*lc9$llik) + lc9$npar * (1 + log(lc9$N))
results[9,6]<- (-2*lc10$llik) + lc10$npar * (1 + log(lc10$N))
results[10,6]<- (-2*lc11$llik) + lc11$npar * (1 + log(lc11$N))
results[11,6]<- (-2*lc12$llik) + lc12$npar * (1 + log(lc12$N))

results[1,7]<-lc2$Gsq
results[2,7]<-lc3$Gsq
results[3,7]<-lc4$Gsq
results[4,7]<-lc5$Gsq
results[5,7]<-lc6$Gsq
results[6,7]<-lc7$Gsq
results[7,7]<-lc8$Gsq
results[8,7]<-lc9$Gsq
results[9,7]<-lc10$Gsq
results[10,7]<-lc11$Gsq
results[11,7]<-lc12$Gsq

View(results)

# Order categories of results$model in order of appearance
install.packages("forcats")
library("forcats")
results$Model <- as_factor(results$Model) 
results2<-tidyr::gather(results,Kriterium,Guete,4:7)
results2
write_dta(results2, "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/Release64-1.3.2/DataForelbowPlot.dta")
sink()

#Elbow plot
library(ggplot2)
results2 <- read_dta("Y:/TLC/Observational Study/Rebuttal Work/LCA Plugin/Release64-1.3.2/DataForelbowPlot.dta")
fit.plot<-ggplot(results2) + 
  geom_point(aes(x=Model,y=Guete),size=3) +
  geom_line(aes(Model, Guete, group = 1)) +
  theme_bw()+
  labs(x = "", y="", title = "") + 
  facet_grid(Kriterium ~. ,scales = "free") +
  theme_bw(base_size = 16, base_family = "") +   
  theme(panel.grid.major.x = element_blank() ,
        panel.grid.major.y = element_line(colour="grey", size=0.5),
        legend.title = element_text(size = 16, face = 'bold'),
        axis.text = element_text(size = 16),
        axis.title = element_text(size = 16),
        legend.text=  element_text(size=16),
        axis.line = element_line(colour = "black")) # Achsen etwas dicker
fit.plot

table(lc3$predclass)
POST = round(lc3$posterior,2)
colnames(POST) <- c("Class1", "Class2", "Class3")
NewData <- cbind(data, POST)
write.dta(NewData, "/rds/projects/s/subramaa-pcos-aa/TLC/Observational Study/Rebuttal Work/LCA Plugin/Release64-1.3.2/DataWithPosteriorProbabilityForClass.dta")

#store rho and indicator variable names in a separate excel file for the 3 class model with optimal fit
#to create word cloud 
data <- read_excel("Y:/TLC/Observational Study/Rebuttal Work/LCA Plugin/Release64-1.3.2/WordCloud_LCPatients.xlsx")
View(data)
library(ggwordcloud)
plot_data <- data %>%
  filter(size>0)
  
set.seed(42)
ggplot(
  plot_data,
  aes(
    label = word, size = size,
    type = class, color = class
  )
) +
  geom_text_wordcloud_area() +
  #scale_size_area(max_size = 20) +
  #scale_x_discrete(breaks = NULL) +
  theme_minimal() +
  facet_wrap(~class)

           