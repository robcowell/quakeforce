public with sharing class QuakeControllerExtension {

    public String location {get; set;}
    public String debugString {get; set;}
    public List<SearchResult.Geonames> LocationResults {get; set;}
    
    public PageReference runSearch() {
    
        System.debug('Hitting webservice');
        
        location = Encodingutil.urlEncode(Apexpages.currentPage().getParameters().get('location'),'UTF-8');
        String url = 'http://api.geonames.org/searchJSON?q=' + location + '&maxRows=10&username=robjcowell';
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndPoint(url);
        
        Http http = new Http();
  
   try {
 
        //Execute web service call here     
        HTTPResponse res = http.send(req);  

        //Helpful debug messages
        debugString = res.getBody();
        SearchResult result = SearchResult.parse(res.getBody());
        LocationResults = new List<SearchResult.Geonames>();
        for(SearchResult.Geonames geoname : result.geonames)
        {
        	LocationResults.add(geoname);
        }
        
       
} catch(System.CalloutException e) {
        debugString = e.getMessage();
}       
        return null;
    }
	
}