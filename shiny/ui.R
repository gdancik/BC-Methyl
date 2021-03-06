library(GEOquery)
load("data/GSE37817.RData")
load("data/GSE33510.RData")
load("data/GSE28094.RData")
load("data/GPL8490.RData")
load("data/GPL9183.RData")
load("data/TCGA.RData")
source("findbestprobe.R")

choices = c("red", "green", "blue", "purple", "orange")
geneChoices = unique(as.character(GPL8490$Symbol))
geneChoices2 = unique(as.character(GPL9183$Symbol))
geneChoices = sort(unique(c(geneChoices, as.character(rownames(TCGA.tumor)), geneChoices2)))
geneChoices = geneChoices[geneChoices!=""]

shinyUI(
  fluidPage(
    titlePanel("BC-BET: Methylation Biomarker Evaluation"),
    hr(),
    sidebarLayout(      
      sidebarPanel(width = 2,
        selectInput("Genes", "Select a gene:", 
                    choices=geneChoices, selected = "FGFR3"),

	hr(),
	HTML("<b> Gene Discovery: </b></br>"),
	HTML("<a href = \"https://github.com/gdancik/BC-Methyl/blob/master/geneList_fdr10.xlsx?raw=true\">Download Table </a>") 
      ),
      mainPanel(
 conditionalPanel(
        condition="$('html').hasClass('shiny-busy')",

		    HTML("<br><br>"),
                    HTML("<div class=\"progress\" style=\"height:25px !important\"><div class=\"progress-bar progress-bar-striped active\" role=\"progressbar\" aria-valuenow=\"100\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width:100%\">
        <span id=\"bar-text\"><b><font size=\"+1.5\">Loading, please wait...</font></b></span></div></div>")

), 

 conditionalPanel(
        condition="!$('html').hasClass('shiny-busy')",

      fluidRow(
        column(4, plotOutput("SummaryPlot", height = 300)),
        column(4, plotOutput("GenesPlot", height = 300)),
        column(4, plotOutput("GenesPlot2", height = 300))
        ),
      fluidRow(
        column(2),
        column(4, plotOutput("GenesPlot3", height = 300)),
        column(4, plotOutput("GenesPlot4", height = 300)),
        column(2)
        )
  ) # end conditional panel
      )
    )
  )
)
