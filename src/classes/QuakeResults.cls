//http://api.geonames.org/earthquakesJSON?north=44.1&south=-9.9&east=-22.4&west=55.2&username=robjcowell

public class QuakeResults {
	public static void consumeObject(JSONParser parser) {
		Integer depth = 0;
		do {
			JSONToken curr = parser.getCurrentToken();
			if (curr == JSONToken.START_OBJECT || 
				curr == JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == JSONToken.END_OBJECT ||
				curr == JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}

	public class Earthquakes {
		public String eqid {get;set;}
		public Double magnitude {get;set;}
		public Double lng {get;set;}
		public String src {get;set;}
		public String DateAndTime {get;set;}	//cos datetime is a reserved word
		public Double depth {get;set;}
		public Double lat {get;set;}

		public Earthquakes(JSONParser parser) {
			while (parser.nextToken() != JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != JSONToken.VALUE_NULL) {
						if (text == 'eqid') {
							eqid = parser.getText();
						} else if (text == 'magnitude') {
							magnitude = parser.getDoubleValue();
						} else if (text == 'lng') {
							lng = parser.getDoubleValue();
						} else if (text == 'src') {
							src = parser.getText();
						} else if (text == 'datetime') {
							DateAndTime = parser.getText();
						} else if (text == 'depth') {
							depth = parser.getDoubleValue();
						} else if (text == 'lat') {
							lat = parser.getDoubleValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Earthquakes consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public List<Earthquakes> earthquakes {get;set;}

	public QuakeResults(JSONParser parser) {
		while (parser.nextToken() != JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != JSONToken.VALUE_NULL) {
					if (text == 'earthquakes') {
						earthquakes = new List<Earthquakes>();
						while (parser.nextToken() != JSONToken.END_ARRAY) {
							earthquakes.add(new Earthquakes(parser));
						}
					} else {
						System.debug(LoggingLevel.WARN, 'Root consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static QuakeResults parse(String json) {
		return new QuakeResults(System.JSON.createParser(json));
	}
	
	
}