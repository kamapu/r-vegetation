# Data types ----

# Factors
evaluation <- sample(x = c("high", "medium", "low"), size = 100, replace = TRUE)
evaluation <- as.factor(evaluation)

summary(evaluation)

evaluation <- factor(evaluation, levels = c("low", "medium", "high"))
summary(evaluation)

# time
now <- Sys.time()
now

again <- Sys.time()
again

difftime(again, now, units = "mins")
difftime(again, now, units = "secs")

# Date
today <- Sys.Date()
today

my_birthday <- as.Date("1978-10-27")
class(my_birthday)

today - my_birthday

?strptime
