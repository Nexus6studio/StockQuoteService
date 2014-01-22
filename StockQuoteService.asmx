<%@ WebService Language="C#" Class="StockQuoteService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

[WebService(Namespace = "http://services.nexus6studio.com/",Description="Provides access to stock quotes with a 20 minute delay.")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class StockQuoteService  : System.Web.Services.WebService {

    [WebMethod(Description="Provides access to an individual stock quote.",CacheDuration=1200)]
    public StockQuote GetStockQuote(string StockTickerSymbol)
    {
        const string yahooFinanceUrl = "http://finance.yahoo.com/d/quotes.csv?s={0}&f=sl1d1t1c1ohgv&e=.csv";
        const string notAvailableValue = "N/A";
        StockQuote sq = new StockQuote();

        try
        {
            System.Net.WebClient wc = new System.Net.WebClient();
            byte[] rawData = wc.DownloadData(string.Format(yahooFinanceUrl, StockTickerSymbol.Trim().ToUpper()));
            string processedData = System.Text.ASCIIEncoding.ASCII.GetString(rawData);
            string[] values = processedData.Split(',');
            sq.ChangePercentage = values[4].Replace('"', ' ').Trim();
            sq.Date = values[2].Replace('"', ' ').Trim();
            sq.DayHigh = values[6].Replace('"', ' ').Trim();
            sq.DayLow = values[7].Replace('"', ' ').Trim();
            sq.LastTrade = values[1].Replace('"', ' ').Trim();
            sq.Open = values[5].Replace('"', ' ').Trim();
            sq.TradeTime = values[3].Replace('"', ' ').Trim();
            sq.Volume = values[8].Replace('"', ' ').Trim();
            sq.StockTickerSymbol = values[0].Replace('"', ' ').Trim();
        }
        catch (Exception)
        {
            //TODO : add event logging of exception here
            sq.ChangePercentage = notAvailableValue;
            sq.Date = notAvailableValue;
            sq.DayHigh = notAvailableValue;
            sq.DayLow = notAvailableValue;
            sq.LastTrade = notAvailableValue;
            sq.Open = notAvailableValue;
            sq.TradeTime = notAvailableValue;
            sq.Volume = notAvailableValue;
            sq.StockTickerSymbol = StockTickerSymbol.Trim().ToUpper();
        }
        
        return sq;
    }

    [WebMethod(Description="Provides access to a group of stock quotes.",CacheDuration=1200)]    
    public StockQuote[] GetStockQuotes(string[] StockTickerSymbols)
    {
        System.Collections.Generic.List<StockQuote> values = new System.Collections.Generic.List<StockQuote>();
        foreach(string stockTickerSymbol in StockTickerSymbols)
        {
            values.Add(this.GetStockQuote(stockTickerSymbol));
        }
        return values.ToArray();
    }
    
    public struct StockQuote
    {
        public string LastTrade;
        public string Open;
        public string Volume;
        public string ChangePercentage;
        public string DayLow;
        public string DayHigh;
        public string TradeTime;
        public string Date;
        public string StockTickerSymbol;
    }
    
}
