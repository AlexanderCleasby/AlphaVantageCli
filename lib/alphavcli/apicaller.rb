require 'json'

class Alphavcli::Apicaller

    def initialize
        @@URL_ROOT="https://www.alphavantage.co/query?pikey=#{Alphavcli::APIKEY}"
    end
    def search(qurery)
        puts @@URL_ROOT+"query?function=SYMBOL_SEARCH&keywords=#{query}"
        data = open(@@URL_ROOT+"query?function=SYMBOL_SEARCH&keywords=#{query}")
        #data = open("https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=#{@query}&apikey=#{Alphavcli::APIKEY}").read
        #data = JSON.parse(data)
    end
    
end