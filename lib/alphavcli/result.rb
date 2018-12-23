class Result
    attr_accessor :ticker, :name, :daily
    @@all = []
    def initialize(ticker,name=nil)
        @ticker=ticker
        @name=name
        @@all.push(self)
    end

    def self.new_from_ticker(ticker)
        new_result = self.new(ticker)
        self.new(ticker) 
    end

    def getTimeSeries
        data = open("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{@ticker}&apikey=#{Alphavcli::Cli.returnKey}").read
        data = JSON.parse(data)
        
        #data = data["Time Series (Daily)"]
        @daily = data = data["Time Series (Daily)"].map{|k,v|
            {:day=>k, :price=>v["4. close"].to_f}
        }
    end

    def week
        getTimeSeries
    end

    def self.all
        @@all
    end

    

end