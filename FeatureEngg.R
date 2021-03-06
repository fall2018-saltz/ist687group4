
#Converting string variables into categorical variables
df$Airline.Status <- factor(df$Airline.Status)
df$Gender <- factor(df$Gender)
df$Type.of.Travel <- factor(df$Type.of.Travel)
df$Class <- factor(df$Class)
df$Airline.Code <- factor(df$Airline.Code)
df$Flight.cancelled <- factor(df$Flight.cancelled)

#Let's take an initial look at all our variables
str(df)

# 'data.frame':	129886 obs. of  35 variables:
#   $ Satisfaction                    : num  4.5 4 2.5 4 5 5 3.5 4 4 4 ...
# $ Airline.Status                  : Factor w/ 4 levels "Blue","Gold",..: 1 1 1 1 4 2 2 4 1 1 ...
# $ Age                             : int  31 56 21 43 49 49 35 33 44 51 ...
# $ Gender                          : Factor w/ 2 levels "Female","Male": 2 2 1 2 2 1 2 2 1 1 ...
# $ Price.Sensitivity               : int  1 2 2 1 1 1 1 1 1 1 ...
# $ Year.of.First.Flight            : int  2007 2006 2006 2007 2006 2010 2011 2010 2003 2005 ...
# $ No.of.Flights.p.a.              : int  28 41 8 9 14 0 15 4 8 12 ...
# $ X..of.Flight.with.other.Airlines: int  7 3 7 9 10 4 5 17 6 7 ...
# $ Type.of.Travel                  : Factor w/ 3 levels "Business travel",..: 1 1 3 1 1 1 1 1 1 1 ...
# $ No..of.other.Loyalty.Cards      : int  2 0 0 2 0 1 0 2 0 0 ...
# $ Shopping.Amount.at.Airport      : int  0 15 0 10 8 0 0 0 0 25 ...
# $ Eating.and.Drinking.at.Airport  : int  75 60 135 45 26 65 60 90 90 80 ...
# $ Class                           : Factor w/ 3 levels "Business","Eco",..: 1 1 1 2 2 2 2 2 2 2 ...
# $ Day.of.Month                    : int  18 11 25 20 25 16 6 5 21 19 ...
# $ Flight.date                     : Factor w/ 90 levels "1/1/14","1/10/14",..: 69 3 18 44 49 8 87 55 14 11 ...
# $ Airline.Code                    : Factor w/ 14 levels "AA","AS","B6",..: 9 9 9 9 9 9 9 9 9 9 ...
# $ Airline.Name                    : Factor w/ 14 levels "Cheapseats Airlines Inc. ",..: 3 3 3 3 3 3 3 3 3 3 ...
# $ Orgin.City                      : Factor w/ 295 levels "Aberdeen, SD",..: 169 169 179 169 179 169 169 169 179 169 ...
# $ Origin.State                    : Factor w/ 52 levels "Alabama","Alaska",..: 51 51 51 51 51 51 51 51 51 51 ...
# $ Destination.City                : Factor w/ 296 levels "Aberdeen, SD",..: 73 73 73 73 73 73 73 73 73 73 ...
# $ Destination.State               : Factor w/ 52 levels "Alabama","Alaska",..: 44 44 44 44 44 44 44 44 44 44 ...
# $ Scheduled.Departure.Hour        : int  15 11 12 11 12 18 6 18 12 18 ...
# $ Departure.Delay.in.Minutes      : int  0 2 34 26 0 0 0 0 0 0 ...
# $ Arrival.Delay.in.Minutes        : int  3 5 14 39 0 0 0 1 0 0 ...
# $ Flight.cancelled                : Factor w/ 2 levels "No","Yes": 1 1 1 1 1 1 1 1 1 1 ...
# $ Flight.time.in.minutes          : int  134 120 122 141 144 123 119 138 114 118 ...
# $ Flight.Distance                 : int  821 821 853 821 853 821 821 821 853 821 ...
# $ Arrival.Delay.greater.5.Mins    : Factor w/ 2 levels "no","yes": 1 1 2 2 1 1 1 1 1 1 ...
# $ Departure.Delay.in.Minutes.0    : int  0 2 34 26 0 0 0 0 0 0 ...
# $ Arrival.Delay.in.Minutes.0      : int  3 5 14 39 0 0 0 1 0 0 ...
# $ Flight.time.in.minutes.0        : int  134 120 122 141 144 123 119 138 114 118 ...
# $ Arrival.Delay.in.Minutes.0.Est  : num  3 5 14 39 0 0 0 1 0 0 ...
# $ Flight.time.in.minutes.0.Est    : num  134 120 122 141 144 123 119 138 114 118 ...
# $ SatisfactionNumeric             : num  4.5 4 2.5 4 5 5 3.5 4 4 4 ...
# $ binarySat                       : Factor w/ 2 levels "High","Low": 1 1 2 1 1 1 2 1 1 1 ...



##Cleaning: Most of our data has already been cleaned in previous stages
##here we just fine tune a little more
#Since X..of.Flight.with.other.Airlines variable shows a percentage
#value we subset it to below 100
df <- subset(df,df$X..of.Flight.with.other.Airlines<=100)
#Also for modelling we ignore satisfaction for cancelled flights
df <- subset(df,df$Flight.cancelled=="No")

##Converting string categorical variables to discrete numeric variables
#The approach we follow here is to make the different levels of these
#variables numeric by using as.numeric function
#Different levels can be found as follows
levels(df$Airline.Status)
#Now we set these variables to integer value so that we can use them
#for creating our model
df$Airline.Status <- as.numeric(df$Airline.Status)
#This transforms the variable as follows
#1="Blue",2="Gold",3="Platinum",4="Silver" 
#Similarly for other variables
levels(df$Gender)
df$Gender <- as.numeric(df$Gender=="Female")
#1="Female",0="Male" 
levels(df$Type.of.Travel)
df$Type.of.Travel <- as.numeric(df$Type.of.Travel)
#1="Business travel",2="Mileage tickets",3="Personal Travel"
levels(df$Class)
df$Class <- as.numeric(df$Class)
#1="Business",2="Eco",3="Eco Plus"
levels(df$Airline.Code)
df$Airline.Code <- as.numeric(df$Airline.Code)
#1="AA",2="AS",3="B6",4="DL",5="EV",6="F9",7="FL",8="HA",9="MQ",10="OO",11="OU",
#12="US",13="VX",14="WN"


##New variables
#Here we create a new variable which incorporates the entire expenditure
#amount at airports for each customer comprising of expenditure
#on food and shopping
df['Expenditure.at.Airport'] <- df$Shopping.Amount.at.Airport + 
  df$Eating.and.Drinking.at.Airport
#Both the variables have a similar right skewed distribution and 
#so does the resultant

##Removing some variables
#Here we remove variables which cannot be used for modelling
df <- subset(df,select = -c(Satisfaction)) 
#We already have Satisfaction's cleaned version so we drop the old one

df <- subset(df,select = -c(Year.of.First.Flight)) 
#This doesn't help our model

df <- subset(df,select = -c(Flight.date)) 
#This provides repititive information as we already have a day of month variable
#however the day of week or the month maybe extracted for further use

df <- subset(df,select = -c(Shopping.Amount.at.Airport))
df <- subset(df,select = -c(Eating.and.Drinking.at.Airport))
#As we have already used these in Expenditure.at.Airport we drop them

df <- subset(df,select = -c(Airline.Name)) 
#This data is aready covered in Airline.Code variable

df <- subset(df,select = -c(Orgin.City))
df <- subset(df,select = -c(Destination.City))
#Due to the high number of factors it is difficult to logically use them in
#our model

df <- subset(df,select = -c(Origin.State))
df <- subset(df,select = -c(Destination.State))
#State variables require advanced conditioning to be used

df <- subset(df,select = -c(Flight.cancelled))
#We already used this variable to subset our data

df <- subset(df,select = -c(Departure.Delay.in.Minutes.0))
df <- subset(df,select = -c(Flight.time.in.minutes))
df <- subset(df,select = -c(Flight.time.in.minutes.0))
df <- subset(df,select = -c(Arrival.Delay.in.Minutes))
df <- subset(df,select = -c(Arrival.Delay.in.Minutes.0))
#These variables are uncleaned copy of already present variables

df <- subset(df,select = -c(Arrival.Delay.greater.5.Mins))
#Since we are using the actual delay variable this will have redundant information

##Renaming columns
#Here we rename columns logically
names(df)[names(df) == 'Arrival.Delay.in.Minutes.0.Est'] <- 'Arrival.Delay.in.Minutes'
names(df)[names(df) == 'Flight.time.in.minutes.0.Est'] <- 'Flight.time.in.minutes'
names(df)[names(df) == 'SatisfactionNumeric'] <- 'Satisfaction'

#Now let's look at our data after performing feature engg
str(df)
# 'data.frame':	127479 obs. of  19 variables:
#   $ Airline.Status                  : num  1 1 1 1 4 2 2 4 1 1 ...
# $ Age                             : int  31 56 21 43 49 49 35 33 44 51 ...
# $ Gender                          : num  0 0 1 0 0 1 0 0 1 1 ...
# $ Price.Sensitivity               : int  1 2 2 1 1 1 1 1 1 1 ...
# $ No.of.Flights.p.a.              : int  28 41 8 9 14 0 15 4 8 12 ...
# $ X..of.Flight.with.other.Airlines: int  7 3 7 9 10 4 5 17 6 7 ...
# $ Type.of.Travel                  : num  1 1 3 1 1 1 1 1 1 1 ...
# $ No..of.other.Loyalty.Cards      : int  2 0 0 2 0 1 0 2 0 0 ...
# $ Class                           : num  1 1 1 2 2 2 2 2 2 2 ...
# $ Day.of.Month                    : int  18 11 25 20 25 16 6 5 21 19 ...
# $ Airline.Code                    : num  9 9 9 9 9 9 9 9 9 9 ...
# $ Scheduled.Departure.Hour        : int  15 11 12 11 12 18 6 18 12 18 ...
# $ Departure.Delay.in.Minutes      : int  0 2 34 26 0 0 0 0 0 0 ...
# $ Flight.Distance                 : int  821 821 853 821 853 821 821 821 853 821 ...
# $ Arrival.Delay.in.Minutes        : num  3 5 14 39 0 0 0 1 0 0 ...
# $ Flight.time.in.minutes          : num  134 120 122 141 144 123 119 138 114 118 ...
# $ Satisfaction                    : num  4.5 4 2.5 4 5 5 3.5 4 4 4 ...
# $ binarySat                       : chr  "High" "High" "Low" "High" ...
# $ Expenditure.at.Airport          : int  75 75 135 55 34 65 60 90 90 105 ...



#So we have gone from all the 35 variables to 19 variables (2 dependent variables) 
#which are ready to be modelled.
