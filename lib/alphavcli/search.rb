require 'json'


class Alphavcli::Search

    attr_accessor :query, :results, :ticker, :name
    @@histroy = []
    
    def initialize(query)
        data = open("https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=#{query}&apikey=#{Alphavcli::Cli.returnKey}").read
        data = JSON.parse(data)
        
        
        @query=query
        @results = data["bestMatches"].map{|e|
            Result.new(e["1. symbol"],e["2. name"])
            #{:ticker=>e["1. symbol"],:name=>e["2. name"]}
        }
        @@histroy.push(self)
        

        
    end

    def self.history
        @@histroy
    end
    
    

    def display
        max = @results.map{|result| result["1. symbol"].length}.max
        @results.each{|result|
        puts result["1. symbol"]+(" "*(30-result["1. symbol"].length)) + result["2. name"]}
    end

    def spacetimes(n)
        out = 3
    end

end