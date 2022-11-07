dashboardPage(skin = "green",
  
  #HEADER
  dashboardHeader(title = "Waste Management"),
  
  #SIDEBAR
  dashboardSidebar(
    sidebarMenu(
      menuItem("Background", tabName = "tab_Background", icon = icon("book")
               ),
      menuItem("Management", tabName = "tab_Management", icon = icon("recycle")
               ),
      menuItem("GitHub", icon = icon("cat"), 
               href = "https://github.com/dinaraulliyah/Capstone-DV")
    )
  ),
  
  #BODY
  dashboardBody(
    tabItems(
      #PAGE 1
      tabItem(tabName = "tab_Background",
              #Brief Topic
              fluidPage(h2(tags$b("Waste Generation in Bandung")
                           ),
                        br(),
                        div(style = "text-align:justify",
                            p("High waste generation has become a problem in many big cities in Indonesia. 
                              Bandung as a metropolitan city also handles its waste 
                              but also does not even have a waste management system that can reduce it effectively.", 
                              "So, the most of waste ends up in the Sarimukti Landfill which currently uses 
                              open dumping methods for managing this problem.", 
                              "This data is published for academic purposes or for someone 
                              who is searching for specific data that correlates with waste generation.", 
                              "One of the variables that are usually used in this topic is population.", 
                              "The high population, and the high waste generation because 
                              everyone in the city has to eat, buy clothes, etc.", 
                              "At the end of the day, those things are turning into waste."),
                            br()
                            )
                        ),
              
              #Population Data and Filter
              fluidPage(box(width = 8,
                            height = 450,
                            title = tags$b("Population in Bandung"),
                            plotlyOutput("pop_plot")
                            ),
                        box(width = 4,
                            height = 450,
                            sliderInput(inputId = "pop_year",
                                        label = "Choose Year",
                                        min = 2015,
                                        max = 2021,
                                        value = c(2019, 2021)
                                        ),
                            checkboxGroupInput(inputId = "Pop_check",
                                               label = "Choose Data",
                                               choices = unique(pop_data$Data)
                                               )
                        ),
              
              
              #Waste Generation
              fluidPage(
                box(width = 8,
                    height = 450,
                    title = tags$b("Waste Generation in Bandung"),
                    plotlyOutput("wg_line")
                    ),
                box(width = 4,
                    height = 450,
                    h3("It Generated Everyday"),
                    div(style = "text-align:justify",
                        p("Bandung produces more than 1.500 tons of waste every day.",
                          "So it is not surprising that the generation of waste continues to increase every year.",
                          "Although in 2020 the waste generation in Bandung looks abnormal, 
                          but that does not mean the data is invalid.",
                          "This may happen because 2020 itself is a crisis year and is different from other years."),
                        br(),
                        h3("What can we learn from it?"),
                        p("We definitely don't want the city we live in to become a sea of garbage. 
                          Therefore, it is important to start from the smallest things and things that we can do ourselves. 
                          Just start buying essential products, minimalist life is fun, right? However, anything in excess is not good. 
                          Including excessive food consumption, excessive spending, etc.")
                        )
                    )
              )
            )
          ),
      
      #PAGE 2
      tabItem(tabName = "tab_Management",
              fluidPage(h2(tags$b("Municipal Waste Management in Bandung")
                           )
                        ),
                        
              #Source of Waste and Waste Management Explanation
              fluidPage(
                box(width = 6,
                    height = 520,
                    title = tags$b("Source of Waste in Bandung"),
                    echarts4rOutput("sw_pie")
                    ),
                box(width = 6,
                    height = 520,
                    h3("Who are generates the waste?"),
                    div(style = "text-align:justify",
                        p("Not only you, definitely. There are 7 sources that generating waste in Bandung.", 
                          "The 7 sources are adjust, in reality more than this because there are a lot of places in Bandung.",
                          "Mostly, there was no specific waste management for every places.",
                          "All of the waste will be picked up and distributed to TPS or TPA (Landfill).",
                          "Some place like market may be has its TPS, but again it is not reduce the waste significantly.",
                          "This may happen because there just seperate the type of waste and mostly the waste is already mixed.",
                          "The mixed waste usually doesn't have the original value even if it seperated then, 
                          the value is decrease because it we have to do more effort to recycle this mixed waste.",
                          "Even the condition getting worse everyday, the waste that scattered on the road is not included.", 
                          "With that said, I hope we can be more empathy and help from the very simple things such as only buy things you need,
                          seperating our waste, and even now the 'digital waste bank' had launch and can pick up your waste directly.",
                          "So, what are you waiting for? Let's make the earth more livable, not 'wastable'."),
                        h3("How is the waste managed?"),
                        p("Technically, Bandung has 4 types of managing waste. The 4 type of it are TPS, ITF non-incinerator, and waste bank.",
                          "The TPA (landfill) is not included because the authority is hanled by Kabupaten Bandung and West Java Province, 
                          not the city itself. Other than that, waste is handled by informal sectors or the worst, 
                          unhandled like the scattered waste that mentioned before",
                          "At the end of the day, the most of waste is handled in TPA (landfill). Of course, it is not the best practice of waste management.
                          Therefore, the waste will produce carbon emission which makes global warming even more pronounced.")
                    )
                )
              ),
              
              #Waste Management Type in Bandung
              fluidPage(h2(tags$b("Waste Management Type in Bandung 2021")), 
                        plotlyOutput("wm_bar"))
      )
    )
  )
)
