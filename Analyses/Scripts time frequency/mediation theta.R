#The necessary criteria before mediation.

library(lme4) # for the analysis
library(lmerTest)# to get p-value estimations that are not part of the standard lme4 packages

data <- read.csv("E:/Mi unidad/Experimento competition/Scripts/extracting time frequency/tablefiltered.csv")
data$task <- ifelse(data$task == "H", 1, 0)
data$category <- ifelse(data$task == "F", 1, 0)

#Effect of task on RTs
m.RTtask= lmer(RT~task+Congruency+(task|subject),data)
summary(m.RTtask)
anova(m.RTtask)
confint(m.RTtask, parm = names(fixef(m.RTtask))[-1], method = "Wald")


#Effect of task on theta
m.mediatorthetatask= lmer(theta~task+Congruency+(task|subject),data)
summary(m.mediatorthetatask)
anova(m.mediatorthetatask)
confint(m.mediatorthetatask, parm = names(fixef(m.mediatorthetatask))[-1], method = "Wald")


#Complete model: Rts predicted by theta and task
m.complete=lmer(RT~theta+task+Congruency+(task|subject),data)
summary(m.complete)
anova(m.complete) #using anova to have the F values
confint(m.complete, parm = names(fixef(m.complete))[-1], method = "Wald")

#Mediation
library(mediation)
library(lmerTest)
detach("package:lmerTest", unload=TRUE)
library(lme4)
m.mediatorthetatask= lmer(theta~task+Congruency+(task|subject),data)
m.complete=lmer(RT~theta+task+Congruency+(task|subject),data)
results= mediate(model.m = m.mediatorthetatask, model.y = m.complete, 
                              treat = "task", mediator = "theta", 
                              sims = 5000)
summary(results)
