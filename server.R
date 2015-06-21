
library(caret);library(dplyr)
wd.datapath = paste0(getwd(),"/Data")
wd.init = getwd()
setwd(wd.datapath)
titanic = read.csv("titanic3.csv", header = TRUE)
setwd(wd.init)

titanic<-mutate(titanic,survived = as.factor(survived))[!is.na(titanic$age)&!is.na(titanic$fare),]

randx = 838
set.seed(seed = randx)
in_train<-createDataPartition(y = titanic$survived,p=0.7,list=F)
train_set<-titanic[in_train,]

model<-glm(data=train_set,survived~sex+age+pclass+fare,family = binomial(link="logit"))


shinyServer(
        function(input, output) {
                newdata<-reactive({data.frame(
                                              age=ifelse(is.nan(input$age),0,input$age),
                                              sex=input$sex,
                                              pclass=input$pclass,
                                              fare=ifelse(is.nan(input$ticket_price),0,input$ticket_price))})
                inData<-reactive({data.frame(Name = c("Gender","Passenger class","Age","Ticket price"), 
                                             Value = as.character(c(input$sex,input$pclass,input$age,input$ticket_price)),
                                             stringsAsFactors=FALSE)})
                pred<-reactive({data.frame(Probability_Of_Survival=paste(as.character(round(plogis(predict(model,newdata()))*100,2)),"%"))})
                
                output$yourData <- renderTable({inData()})
                output$predicted <- renderTable({pred()})
                output$text <- renderText({
                        "This tool can be used to explore how gender, age and financial status could affect
                        probability of passenger survival on Titanic. By moving sliders or choosing certain radio
                        option one can manipulate the output - the probability of survival. The tool is not intended to
                        be perfect in terms of prediction quality, but rather is used as demonstration for shiny app.
                        
                        Issues: due to some bug in Shiny slider widget its not recommended to move slider to left end and further,
                        it will crash the app(widget tries to pop up NaN value instead of actual minimun for the slider).
                        More details is here: http://rpubs.com/falko13/titanic. And here: http://github.com/falko13/DevelopingDataProducts
                        "
                        
                }) 

                
        }
)




