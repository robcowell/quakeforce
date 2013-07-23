public with sharing class QuakeControllerExtension {

    public String location {get; set;}
    public String debugString {get; set;}
    public String searchResult {get; set;}
    public List<String> XMLData {get; set;}
    
    public PageReference runSearch() {
    
        System.debug('Hitting webservice');
        location = Apexpages.currentPage().getParameters().get('location');
        String url = 'http://api.geonames.org/search?q=' + location + '&maxRows=10&username=robjcowell';
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndPoint(url);
        
        Http http = new Http();
  
   try {
 
        //Execute web service call here     
        HTTPResponse res = http.send(req);  

        //Helpful debug messages
        debugString = res.toString();
        //searchResult = res.getBody();
        System.debug(debugString);
        XMLData = new List<String>();
        Xmlstreamreader reader = res.getXmlStreamReader();
        XMLData=XMLParser(res.getBody());
        
} catch(System.CalloutException e) {
        debugString = e.getMessage();
}       
        return null;
    }

	public List<String> XMLParser(String strXML)
	{
		
		List<String> Locations = new List<String>();
		
		Dom.Document doc = new Dom.Document();
		doc.load(strXML);
		dom.Xmlnode Envelope = doc.getRootElement();
		for(dom.Xmlnode child : Envelope.getChildElements())
		{
			Locations.add(child.getChildElements()[0].getText());
		}
		
		return Locations;
	}
	
}