StockQuoteService
=================


This is a simple asmx webservice that was originally published in 2002.  It provides access to stock quotes(20 minute delay).  There is no guarantee of service.  This webservice was featured in an MSDN article April 2004 ("Accessing Web Services in Excel Using Visual Studio Tools for the Microsoft Office System" and used as an educational reference by numerous organizations. 

=================

The implementation contains 2 methods and a single data structure (type): 
- StockQuote GetStockQuote(string) 
- StockQuote[] GetStockQuotes(string[]) 

=================

Simple Example: 
ServiceReference1.StockQuoteServiceSoapClient stockquotesvc = new ServiceReference1.StockQuoteServiceSoapClient();
ServiceReference1.StockQuote stockQuote= stockquotesvc.GetStockQuote("t");
Console.WriteLine(stockQuote.LastTrade);
