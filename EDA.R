# install.packages("ggplot2", repos='http://cloud.r-project.org')
# install.packages("plotly", repos='http://cloud.r-project.org')

library(ggplot2)
library(plotly)
library(lubridate)
library(tm)
library(wordcloud)


# Loading the cleaned data set into R data frame
spillincidents <- read.csv('https://dnaik2awsbucket.s3.amazonaws.com/Spill_Incidents.csv', header=TRUE)
spillincidents

spillincidents <- cbind(RowNumber = seq_along(spillincidents[,1]), spillincidents)

View(spillincidents)
attach(spillincidents)

# Locality : String, Nominal Data
locality <- toupper(spillincidents$Locality)
locality_freq <- table(locality)

print(paste("Count: ", length(locality)))
print(paste("Unique: ", length(unique(locality))))
print(paste("Top: ", names(locality_freq[which.max(locality_freq)])))
print(paste("Frequency distribution:"))
print(locality_freq)


# County : String, Nominal Data
county <- spillincidents$County
county_freq <- table(county)

print(paste("Count: ", length(county)))
print(paste("Unique: ", length(unique(county))))
print(paste("Top: ", names(county_freq[which.max(county_freq)])))
print(paste("Frequency distribution:"))
print(county_freq)

# Research Question 4: Are there any specific regions (counties or localities) more prone to spilling incidents?
address <- paste(locality, county, sep = ", ")
address_freq <- table(address)

#address_freq
address_freq <- sort(address_freq, decreasing = TRUE)
top_address_freq <- address_freq[1:20]

address_df <- as.data.frame(top_address_freq)
colnames(address_df) <- c("Address", "Frequency")
address_df <- address_df[order(-address_df$Frequency), ]

plot_ly(data = address_df, x = ~Address, y = ~Frequency, type = "bar", name = "Address") %>%
  layout(title = "Topmost Locations affected by spills",
         xaxis = list(title = "Address"),
         yaxis = list(title = "Frequency"))

# Research Question 5: How often do spills affect water bodies, and are there specific water bodies more frequently impacted by hazardous material spills?
# Waterbody : String, Nominal Data
library(dplyr)

# Filter out rows where Waterbody contains "UNKNOWN" and is not NA
spillincidents <- spillincidents %>% filter(!grepl("UNKNOWN", Waterbody, ignore.case = TRUE) & !is.na(Waterbody))

rownames(df) <- NULL

waterbody <- spillincidents$Waterbody
waterbody_freq <- table(waterbody)

waterbody_df <- as.data.frame(waterbody_freq)
colnames(waterbody_df) <- c("Waterbody", "Frequency")
waterbody_df <- waterbody_df[waterbody != "" & waterbody != "NONE", ] 

waterbody_df <- waterbody_df[order(-waterbody_df$Frequency), ]

print(paste("Count: ", length(waterbody)))
print(paste("Unique: ", length(unique(waterbody))))
top_waterbodies <- head(waterbody_df, 20)
print(waterbody_freq)

print(top_waterbodies)

corpus <- Corpus(VectorSource(waterbody))

corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)

tdm <- TermDocumentMatrix(corpus)
m <- as.matrix(tdm)
word_freq <- sort(rowSums(m), decreasing=TRUE)
wordcloud(names(word_freq), word_freq, scale=c(3, 0.5), min.freq=5,
          random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))


# Material Family : String, Nominal Data
mat_family <- spillincidents$Material.Family
mat_family_freq <- table(mat_family)

print(paste("Count: ", length(mat_family)))
print(paste("Unique: ", length(unique(mat_family))))
print(paste("Top: ", names(mat_family[which.max(mat_family_freq)])))
print(paste("Frequency distribution:"))
print(mat_family_freq)

plot_ly(labels = names(mat_family_freq), values = mat_family_freq, type = 'pie') %>%
  layout(title = "Frequency of Material Families")


# Spill Date : Interval Data
spill_date <- spillincidents$Spill.Date
spill_date <- as.Date(spill_date, format = "%m/%d/%Y") # Converting into Date format

spillincidents$Year <- format(spill_date, "%Y")

print(summary(spill_date))

ggplot(spillincidents, aes(x = factor(Year))) +
  geom_line(stat = "count", aes(group = 1), color = "blue") +
  labs(title = "Distribution of Spills by Year",
       x = "Year",
       y = "Frequency") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))


mat_name <- spillincidents$Material.Name
mat_name_freq <- table(mat_name)

# Spill Number : Ordinal Data
spill_number <- spillincidents$Spill.Number
spill_number_freq <- table(spill_number)
duplicate_spills <- names(spill_number_freq)[spill_number_freq > 1]
print(duplicate_spills) # indicates more than one materials spilled on a that spill incident





