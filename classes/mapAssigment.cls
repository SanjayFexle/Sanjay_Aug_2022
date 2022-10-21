public class mapAssigment {
    
     Map<String, Map<String, Map<String,List<String>>>> mainMap ;
    
    Integer citiesLength;
    
    public void mapAssigmentV1(){
        citiesLength = 7;
        List<String> citiesList = new List<String>();
        
        List<String> citiesByLength = new List<String>();
        
        mainMap =  new Map<String, Map<String, Map<String,List<String>>>>{
            'SInd' => new Map<String, Map<String,List<String>>>{
                'SIndia' => new Map<String,List<String>>{
                    'SRaj' => new List<String>{'Jaipur','Jodhpur','Sikar','Sirohi'},
                    'PUN' => new List<String>{'Chandigarh','Ambala','Amritsar','SirHind'},
                    'Sikkim' => new List<String>{'SPakyong','Pelling','Gangtok'}
                }
            }
        };
            System.debug(mainMap);
            for(string countryCodeMap : mainMap.keySet()){
                //System.debug(countryCodeMap);
                if(countryCodeMap.startsWith('S')){
                    for(String countryMap : mainMap.get(countryCodeMap).keyset()){
                        if(countryMap.startsWith('S')){
                            //System.debug(countryMap);
                            for(String stateMap : mainMap.get(countryCodeMap).get(countryMap).keySet()){
                                if(stateMap.startsWith('S')){
                                    //System.debug(stateMap);
                                    for(String citiesMap : mainMap.get(countryCodeMap).get(countryMap).get(stateMap)){
                                        if(citiesMap.startsWith('S')){
                                            citiesList.add(citiesMap);
                                        	System.debug('\nCountry Code: ' + countryCodeMap +'\nCountry Name: '+ countryMap +'\nState: '+stateMap +'\n Cities: '+citiesMap   );    
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            System.debug('List of cities are start with S '+citiesList);
    
        for(String A : mainMap.keySet()){
            for(String B : mainMap.get(A).keySet()){
                for(String C : mainMap.get(A).get(B).keySet()){
                    for(String D : mainMap.get(A).get(B).get(C)){
                        if(D.length()>=citiesLength){
                            citiesByLength.add(D);
                        }
                    }
                
            	}
            }
        }
        System.debug('List of cities are length equal or more than ' +citiesLength+' are '+citiesByLength);
        
    }
}