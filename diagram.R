df <- read.csv("mao_b_dataanalysis_withID.csv")
head(df)

library(dplyr)
library(networkD3)

set.seed(39) # Фиксируем зерно для воспроизводимости (чтобы при каждом запуске были те же ID)

top30_ids <- df %>%
  distinct(`Molecule.ChEMBL.ID`) %>%  # Берем только уникальные
  slice_sample(n = 30) %>%            # Выбираем случайные 30
  pull(`Molecule.ChEMBL.ID`)

# 2. Фильтруем основной датафрейм по этим ID
df_sankey <- df %>%
  filter(`Molecule.ChEMBL.ID` %in% top30_ids) %>%
  mutate(
    Journal = ifelse(is.na(Journal) | Journal == "", "Not specified", Journal),
    Source = ifelse(is.na(`Source.Description`) | `Source.Description` == "", "Unknown Source", `Source.Description`)
  ) %>%
  select(Molecule = `Molecule.ChEMBL.ID`, Source, Journal)

# 3. Решаем проблему "Иглы" (добавляем префиксы, чтобы имена не дублировались)
# Если название источника совпадет с журналом, график "сломается"
link1 <- df_sankey %>% 
  count(Molecule, Source) %>% 
  mutate(Source = paste0("S: ", Source)) %>% # Префикс для Источника
  rename(source = Molecule, target = Source, value = n)

link2 <- df_sankey %>% 
  count(Source, Journal) %>% 
  mutate(Source = paste0("S: ", Source),
         Journal = paste0("J: ", Journal)) %>% # Префикс для Журнала
  rename(source = Source, target = Journal, value = n)

links <- bind_rows(link1, link2)

# 4. Узлы и визуализация
nodes <- data.frame(name = unique(c(links$source, links$target)))
links$source_id <- match(links$source, nodes$name) - 1
links$target_id <- match(links$target, nodes$name) - 1

sankeyNetwork(
  Links = links,
  Nodes = nodes,
  Source = "source_id",
  Target = "target_id",
  Value  = "value",
  NodeID = "name",
  fontSize = 12,
  nodeWidth = 30,
  sinksRight = FALSE,
  iterations = 0 # Помогает избежать "схлопывания" в тонкую линию
)