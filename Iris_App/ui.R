library(shiny)
shinyUI(fluidPage(
    titlePanel("Predict Iris' flower Sepal and Petal Width and Length"),
    sidebarLayout(
        sidebarPanel(
            checkboxGroupInput("checkSpecies", "What species do you want to include in the prediction?", c("Iris setosa (Bristle-pointed iris)"="setosa",
                                                                               "Iris versicolor (Northern blue flag)"="versicolor",
                                                                               "Iris virginica (Virginia iris)"="virginica"), c("setosa","versicolor","virginica")),
            helpText("Note: among the three different species of iris, you can choose the one, the two or all three that you want to include in your prediction model"),
            radioButtons("checkModel", "Which model do you want?", c("Sepal Length ~ Sepal Width"="sepal",
                                                                    "Petal Length ~ Petal Width"="petal"), "sepal"),
            helpText("Note: you want to predict the SEPAL width based on the SEPAL length, or would you like to predict the width of the PETALS based on their length?"),
            sliderInput("slider", "What is the sepal/petal length?", step = .01, 0, 10, value = 5.0),
            helpText("Note: you can choose the sepals'/petals' length, from 0 to 10 cm with a step of 0.01 cm,
                     but you must keep in mind that the prediction is far more accurate as long as the white circle remains visible on the orange line")
        ),
        mainPanel(
            plotOutput("plot"),
            h3(textOutput("pred"))
        )
    )
))