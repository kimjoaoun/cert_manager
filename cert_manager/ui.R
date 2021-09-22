library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Portal de Certificados - R para Cientistas Sociais"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            textInput("nomeInput", label = "Nome utilizado na inscriçao:"),
            textInput("emailInput", label = "E-mail de inscriçao:"),
            actionButton("generate", label = "Gerar Certificado"),
        ),

        # Show a plot of the generated distribution
        mainPanel(
            textOutput("status"),
            imageOutput("certificado")
        )
    )
))
