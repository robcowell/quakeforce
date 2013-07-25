public with sharing class QuakeControllerExtension {

    public String location {get; set;}
    public String debugString {get; set;}
    public List<SearchResult.Geonames> LocationResults {get; set;}
    public List<QuakeResults.Earthquakes> QuakeList {get;set;}
    
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
    
	public PageReference getQuakes()
    {
    	//System.debug('Longitude passed = ' + Apexpages.currentPage().getParameters().get('Lng'));
    	
    	double longitude = double.valueOf(Apexpages.currentPage().getParameters().get('lng'));
    	double latitude = double.valueOf(Apexpages.currentPage().getParameters().get('lat'));

		double north = latitude+2;
		double south = latitude-2;
		double east = longitude+2;
		double west = longitude-2;
	
	
		String url =  'http://api.geonames.org/earthquakesJSON?north=' + north + '&south=' + south + '&east=' + east + '&west=' + west + '&username=robjcowell';
	HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndPoint(url);
        
        Http http = new Http();
  
   try {
 
        //Execute web service call here     
        HTTPResponse res = http.send(req);  

        //Helpful debug messages
//        debugString = res.getBody();
        QuakeResults qr = QuakeResults.parse(res.getBody());
	

		QuakeList = qr.earthquakes;
   }
	catch(System.CalloutException e) {
        debugString = e.getMessage();
}       

        return null;
    }
}