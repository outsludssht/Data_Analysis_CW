df <- read.csv("mao_b_dataanalysis.csv")
head(df)

df$X.RO5.Violations <- factor(df$X.RO5.Violations)

df$Source_Type <- as.character(df$Source_Type)
df$Source_Type[df$Source_Type == ""] <- "Not specified"
df$Source_Type <- factor(df$Source_Type)

df$Source.Description <- factor(df$Source.Description)

df$Journal[df$Journal == ""] <- "Not specified"
df$Journal <- factor(df$Journal)

##################
library(ggplot2)

#case1
t.test(pChEMBL.Value ~ Source_Type, data = df, var.equal = FALSE)

ggplot(df, aes(x = Source_Type, y = pChEMBL.Value, fill = Source_Type)) +
  geom_boxplot() +
  labs(title = "pChEMBL by Source type", y = "pChEMBL Value", x = "Source Type") +
  theme_minimal()

#case2
anova_model <- aov(pChEMBL.Value ~ X.RO5.Violations, data = df)
summary(anova_model)

ggplot(df, aes(x = X.RO5.Violations, y = pChEMBL.Value, fill = X.RO5.Violations)) +
  geom_violin(trim = FALSE) +
  geom_jitter(width = 0.1, alpha = 0.4) +
  labs(title = "Distribution pChEMBL by Ro5 Violations",
       x = "#RO5 Violations", y = "pChEMBL Value") +
  theme_minimal()

#case3
cor.test(df$Molecular.Weight, df$pChEMBL.Value, method = "pearson")

ggplot(df, aes(x = Molecular.Weight, y = pChEMBL.Value)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(title = "Correlation between Molecular Weight and pChEMBL",
       x = "Molecular Weight", y = "pChEMBL Value") +
  theme_minimal()


#case4
df$Active <- ifelse(df$pChEMBL.Value > 6, "Yes", "No")
table_active <- table(df$Active, df$Source_Type)
chisq.test(table_active)

ggplot(df, aes(x = Source_Type, fill = Active)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  labs(title = "Proportion of active molecules by Source_Type", y = "Percentage (%)", x = "Source Type") +
  theme_minimal()



#case5
anova_year <- aov(pChEMBL.Value ~ factor(Document.Year), data = df)
summary(anova_year)

ggplot(df, aes(y = factor(Document.Year), x = pChEMBL.Value)) +
  geom_boxplot(fill = "lightblue") +
  labs(
    title = "pChEMBL Distribution by Year",
    y = "Document Year",
    x = "pChEMBL Value"
  ) +
  theme_minimal()

#case6
df_time <- df[!is.na(df$Time_hr), ]
anova_time <- aov(pChEMBL.Value ~ factor(Time_hr), data = df_time)
summary(anova_time)

ggplot(df_time, aes(x = Time_hr, y = pChEMBL.Value)) +
  geom_point(alpha = 0.6, color = "steelblue", size = 2) +
  geom_smooth(method = "loess", se = TRUE, color = "darkred") +
  labs(
    title = "pChEMBL by Time (hr)",
    x = "Time (hours)",
    y = "pChEMBL Value"
  ) +
  theme_minimal(base_size = 13)



