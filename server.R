shinyServer(function(input, output) {
#PAGE 1
    output$pop_plot <- renderPlotly({

      #Population Data
      pop_data <- dps %>% 
        filter(Data == c("Population", "Population birth", "Population death", 
                         "In migration", "Out migration", "Working people", 
                         "Residents not working")) %>%
        select("Data", "Year", "Value") %>%
        mutate(Population = glue("Population : {comma(Value)} people"))
      
      #Static Plot Population
      pop_plot <- ggplot(pop_data, aes(x = Year, 
                                       y = Value, 
                                       color = Data, 
                                       group = Data)) + 
        geom_line(size = 1) +
        geom_point(color = "black", size = 2, 
                   aes(text = Population)) +
        labs(title = "Population Growth in Bandung") +
        scale_y_continuous(labels = comma) +
        theme_minimal()
      
      # Interactive Plot Population
      ggplotly(pop_plot, tooltip = "text")

    })

    output$wg_line <- renderPlotly({
      
      #Waste Generation Data
      wg <- dps %>% 
        filter(Data == "Waste generation") %>%
        select("Data", "Year", "Value") %>%
        mutate(Waste = glue("Waste generation : {comma(Value)} ton"))
      
      #Waste Generation Static Plot
      wg_line <- ggplot(data = wg, aes(x = Year, y = Value, group = Data)) +
        geom_line(color = "brown", size = 1) +
        geom_point(color = "black", size = 2, aes(text = Waste)) +
        labs(title = "Waste Generation in Bandung") +
        scale_y_continuous(labels = comma) +
        theme_minimal()
      
      #Waste Generation Interactive Plot
      ggplotly(wg_line, tooltip = "text")
      
    })
    
    output$sw_pie <- renderEcharts4r({
      
      #Source of Waste Data
      sw <- dps %>% 
        filter(Data == c("Household", "Public facility", "Market", "Commercial", "District", "Office area", "Other")) %>%
        select("Data", "Value") %>%
        mutate(Percentage = glue("Proportion : {(Value)}%"))
      
      #Source of Waste Interactive Plot
      sw_pie <- sw %>%
        e_charts(Data)  %>% 
        e_pie(Value, radius = c("50%", "70%")) %>%
        e_tooltip()
      
    })
    
    #PAGE 2
    output$wm_bar <- renderPlotly({
      
    #Waste Management Data  
      wm <- dps %>%
        filter(Data %in% c("TPS", "Waste bank", "TPA", "ITF non-incinerator", "Informal handled", "Not handled waste"),
               Year == "2021") %>%
        select(Data, Year, Value) %>%
        mutate(Managed = glue("Value : {comma(Value)} ton")) %>%
        arrange(desc(Value))
      
    #Waste Management Static Plot
      wm_bar <- ggplot(data = wm, 
                       mapping = aes(x = Value, 
                                     y = reorder(Data, Value), 
                                     fill = Data,
                                     text = Managed)) + 
        geom_bar(stat = "identity") + 
        scale_x_continuous(labels = comma) +
        labs(x = "",
             y = "Type of Waste Management") +
        theme_minimal()
      
    #Waste Management Interactive Plot
    ggplotly(wm_bar, tooltip = "text")
        
    })
})
