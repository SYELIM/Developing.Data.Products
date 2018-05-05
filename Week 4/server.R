#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
Sys.setlocale("LC_TIME","C")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        USArrests$upsp <- ifelse(USArrests$UrbanPop - 50 > 0, USArrests$UrbanPop - 50 ,0)
        model1 <- lm(Assault ~ UrbanPop, data = USArrests)
        model2 <- lm(Assault ~ upsp + UrbanPop, data = USArrests)
        
        model1pred <- reactive({
                upInput <- input$sliderUP
                predict(model1, newdata = data.frame(UrbanPop = upInput))
        })
        
        model2pred <- reactive({
                upInput <- input$sliderUP
                predict(model2, newdata = data.frame(UrbanPop = upInput,
                                                     upsp = ifelse(upInput - 50 > 0,
                                                                   upInput - 50, 0)))
        })
        
        output$plot1 <- renderPlot({
                upInput <- input$sliderUP
                
                plot(USArrests$UrbanPop, USArrests$Assault, xlab = "Urban Population %",
                     ylab = "Assault Arrest per 100,000 Residents", bty = "n", pch = 16,
                     xlim = c(1,100), ylim = c(20, 270))
                if(input$showModel1){
                        abline(model1, col="green", lwd=2)
                }
                if(input$showModel2){
                        model2lines <- predict(model2, newdata = data.frame(
                                UrbanPop = 1:100, upsp = ifelse(1:100 - 50 > 0, 1:100 - 50,0)
                        ))
                        lines(1:100, model2lines, col = "purple", lwd =2)
                }
                legend(90, 100, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
                       col = c("green", "purple"), bty = "n", cex = 1.2)
                points(upInput, model1pred(), col = "green", pch = 16, cex = 2)
                points(upInput, model2pred(), col = "purple", pch = 16, cex = 2)
                })
        
        output$pred1 <- renderText({
                model1pred()
        })
        
        output$pred2 <- renderText({
                model2pred()
        })
                
                   
        })







