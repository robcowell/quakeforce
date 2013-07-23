//
// Generated by JSON2Apex http://json2apex.herokuapp.com/
//

public class SearchResult {

    public Integer totalResultsCount;
    public List<Geonames> geonames;

    public class Geonames {
        public String countryId {get; set;}
        public String adminCode1 {get; set;}
        public String countryName {get; set;}
        public String fclName {get; set;}
        public String countryCode {get; set;}
        public String lng {get; set;}
        public String fcodeName {get; set;}
        public String toponymName {get; set;}
        public String fcl {get; set;}
        public String name {get; set;}
        public String fcode {get; set;}
        public Integer geonameId {get; set;}
        public String lat {get; set;}
        public String adminName1 {get; set;}
        public Integer population {get; set;}
    }

    
    public static SearchResult parse(String json) {
        return (SearchResult) System.JSON.deserialize(json, SearchResult.class);
    }
    
    
}