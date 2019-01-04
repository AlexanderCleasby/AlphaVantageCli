class Alphavcli::Cli
    def initialize
    
        if File.exist?(File.expand_path('../../userfiles/apikey.json', File.dirname(__FILE__)))
            @@apikey= JSON.parse(File.read(File.expand_path('../../userfiles/apikey.json', File.dirname(__FILE__))))["apikey"]
        else
            puts "No api Key found."
            getkey
        end
        #
    end

    def getkey
        puts "Please go to https://www.alphavantage.co/ to claim your free API key and enter it."
        @@apikey=gets.chomp

        open(File.expand_path('../../userfiles/apikey.json', File.dirname(__FILE__)),'w'){
            |f| f.puts JSON.generate(:apikey=>@apikey)
        }
    end

    def call

        loop {
            puts '
Please enter the number cooresponding to the action you would like to take.
        
"Search" - Search to find security by keyword.
"Returns - Get data directly from a ticker you know"
"exit" quit program'

            select = gets.chomp
            case select
            
            when "Search"
                searchDisplay
                #Alphavcli::Search.new
            when "Returns"
                returnsFromTicker
            when "exit"
                break
            else
                puts "#{select} is not a valid action"
            end
            }
    end

    def searchDisplay
        puts 'Enter a search term'
        query=gets.chomp
        if Alphavcli::Search.history.find{|search| search.query==query} != nil
            new_search = Alphavcli::Search.history.find{|search| search.query==query}
        else
            new_search = Alphavcli::Search.new(query)
        end
        puts 'Please select a security'
        new_search.results.each_with_index{|res,i|
        puts "#{i+1}. #{res.ticker} - #{res.name}"}
        puts "Select the number that cooresponds to the secutity you are interested in"
        select = gets.chomp.to_i
        dataLanding(new_search.results[select-1])
    end

    def dataLanding(sec)
        
        loop {
            puts "What would you like to know about #{sec.name}?"
            puts '"Daily" - Display return from the past day
"Weekly" - Display returns from the past week
"Back" - Go Back to main menu'
            select=gets.chomp
            case select
            when "Daily"
                
                sec.getTimeSeries
                diplay(sec.daily[0..10])
                #display(sec.getTimeSeries)
            when "Weekly"
                sec.getTimeSeries
                diplay(sec.daily[0..7*10],7)
            when "back"
                break
            else
                puts "#{select} is not a valid action!"
            end
        }
    end

    def returnsFromTicker
        puts "Please enter the ticker you are intersted in."
        ticker = gets.chomp
        new_result=Result.new_from_ticker(ticker)
        dataLanding(new_result)
    end

    def diplay(data,interval=1)
        
        data[0,data.length-2].each_with_index{|day,i|
        if i % interval == 0
            puts day[:day]+"  "+ "%.2f" % day[:price] + "  "+ "%.4f" % (((day[:price]-data[i+interval][:price])/data[i+interval][:price])*100) +'%'
        end
        }
    end

    def self.returnKey
        @@apikey
    end

    def invalid_key
        puts "that is an invalid key"
        getkey
    end
end