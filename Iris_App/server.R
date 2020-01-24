library(shiny)
shinyServer(function(input, output) {
    
    
    
    output$plot <- renderPlot({
        if(length(input$checkSpecies) == 0){
            iris_new <- iris}
        else if(length(input$checkSpecies) == 1) {
            switch(input$checkSpecies,
                   "setosa"= {iris_new <- iris[1:50,]},
                   "virginica"= {iris_new <- iris[101:150,]},
                   "versicolor"= {iris_new <- iris[51:100,]}
            ) # end switch
        }
        else if(length(input$checkSpecies) == 2) {
            if(all(c("versicolor", "setosa") %in% input$checkSpecies)) {iris_new <- iris[1:100,]}
            else if(all(c("setosa", "virginica") %in% input$checkSpecies)) {iris_new <- iris[c(1:50,100:150),]}
            else if(all(c("versicolor", "virginica") %in% input$checkSpecies)) {iris_new <- iris[51:150,]}
        }
        else if ( all(c("versicolor", "setosa", "virginica") %in% input$checkSpecies)) {iris_new <- iris} 
        
                model1 <- lm(Sepal.Width ~ Sepal.Length, data = iris_new)
        model2 <- lm(Petal.Width ~ Petal.Length, data = iris_new)
        
        model1pred <- reactive({
            predict(model1, newdata = data.frame(Sepal.Length = input$slider))
        })
        
        model2pred <- reactive({
            predict(model2, newdata = data.frame(Petal.Length = input$slider))
        })
        if(input$checkModel=="sepal"){
            plot(iris_new$Sepal.Length, iris_new$Sepal.Width, xlab = "Sepal Length (cm)",
                 ylab = "Sepal Width (cm)", bty = "n", pch = 16,
                 col = ifelse(iris_new$Species == "setosa","blueviolet", ifelse(iris_new$Species == "versicolor", "cyan3", "aquamarine4")),
                 xlim = c(min(iris_new$Sepal.Length), max(iris_new$Sepal.Length)),
                 ylim = c(min(iris_new$Sepal.Width), max(iris_new$Sepal.Width)))
            abline(model1, col = "darkorange2", lwd = 2)
            points(input$slider, model1pred(), col = "white", pch = 16, cex = 2)
            points(input$slider, model1pred(), col = "darkorange2", pch = 1, cex = 2)
        }
        if(input$checkModel=="petal"){
            plot(iris_new$Petal.Length, iris_new$Petal.Width, xlab = "Petal Length (cm)",
                 ylab = "Petal Width (cm)", bty = "n", pch = 16,
                 col = ifelse(iris_new$Species == "setosa","blueviolet", ifelse(iris_new$Species == "versicolor", "cyan3", "aquamarine4")),
                 xlim = c(min(iris_new$Petal.Length), max(iris_new$Petal.Length)),
                 ylim = c(min(iris_new$Petal.Width), max(iris_new$Petal.Width)))
            abline(model2, col = "darkorange2", lwd = 2)
            points(input$slider, model2pred(), col = "white", pch = 16, cex = 2)
            points(input$slider, model2pred(), col = "darkorange2", pch = 1, cex = 2)
        }
    })
   
    output$pred <- renderText({
        
        
        if(length(input$checkSpecies) == 0){
            iris_new <- iris}
        else if(length(input$checkSpecies) == 1) {
            switch(input$checkSpecies,
                   "setosa"= {iris_new <- iris[1:50,]},
                   "virginica"= {iris_new <- iris[101:150,]},
                   "versicolor"= {iris_new <- iris[51:100,]}
            ) # end switch
        }
        else if(length(input$checkSpecies) == 2) {
            if(all(c("versicolor", "setosa") %in% input$checkSpecies)) {iris_new <- iris[1:100,]}
            else if(all(c("setosa", "virginica") %in% input$checkSpecies)) {iris_new <- iris[c(1:50,100:150),]}
            else if(all(c("versicolor", "virginica") %in% input$checkSpecies)) {iris_new <- iris[51:150,]}
        }
        else if ( all(c("versicolor", "setosa", "virginica") %in% input$checkSpecies)) {iris_new <- iris} 
        
        model1 <- lm(Sepal.Width ~ Sepal.Length, data = iris_new)
        model2 <- lm(Petal.Width ~ Petal.Length, data = iris_new)
        
        model1pred <- reactive({
            predict(model1, newdata = data.frame(Sepal.Length = input$slider))
        })
        
        model2pred <- reactive({
            predict(model2, newdata = data.frame(Petal.Length = input$slider))
        })
        
        if(input$checkModel=="sepal"){
            c("For a sepal length of", input$slider,"cm, the predicted sepal width is", round(model1pred(),2), "cm")
        } else if(input$checkModel=="petal"){
            c("For a petal length of", input$slider,"cm, the predicted petal width is", round(model2pred(),2), "cm")
        }
    })
})