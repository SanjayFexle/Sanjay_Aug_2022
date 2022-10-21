public class mapAssigmentDynamic {
    
    map<String ,Map<String,Map<String,List<String>>>> mainMap = new map<String ,Map<String,Map<String,List<String>>>> ();
  
    List<String> citiesCollectionByWord = new List<String>();
    
	List<String> citiesCollectionByLength = new List<String>();
        
    public mapAssigmentDynamic(){
        List<City__c> citiesList = [SELECT  Name, 
                 State_Lookup__r.Name,
                           State_Lookup__r.Country_Lookup__r.Name,
                                        State_Lookup__r.Country_Lookup__r.CountryCode_Lookup__r.Name                                                            
                                                                                                   FROM City__c];
		
        for(City__c cityName : citiesList){
            if(mainMap.containsKey(cityName.State_Lookup__r.Country_Lookup__r.CountryCode_Lookup__r.Name)){
                if(mainMap.get(cityName.State_Lookup__r.Country_Lookup__r.CountryCode_Lookup__r.Name).containsKey(cityName.State_Lookup__r.Country_Lookup__r.Name)){
                    if(mainMap.get(cityName.State_Lookup__r.Country_Lookup__r.CountryCode_Lookup__r.Name).get(cityName.State_Lookup__r.Country_Lookup__r.Name).containsKey(cityName.State_Lookup__r.Name)){
                        mainMap.get(cityName.State_Lookup__r.Country_Lookup__r.CountryCode_Lookup__r.Name).get(cityName.State_Lookup__r.Country_Lookup__r.Name).get(cityName.State_Lookup__r.Name).add(cityName.Name);
                    }else{
                        mainMap.get(cityName.State_Lookup__r.Country_Lookup__r.CountryCode_Lookup__r.Name).get(cityName.State_Lookup__r.Country_Lookup__r.Name).put(cityName.State_Lookup__r.Name,new List<String>{cityName.Name}); 
                    }
                }
                else {
                    map<String , List<String>> StateMap = new map<String , List<String>>();
                    if(StateMap.get(cityName.State_Lookup__r.Name)==Null){
                        StateMap.put(cityName.State_Lookup__r.Name,new List<String>());
                    }
                    StateMap.get(cityName.State_Lookup__r.Name).add(cityName.Name);
                    mainMap.get(cityName.State_Lookup__r.Country_Lookup__r.CountryCode_Lookup__r.Name).put(cityName.State_Lookup__r.Country_Lookup__r.Name,StateMap);
                }
            }else if(!MainMap.containsKey(cityName.State_Lookup__r.Country_Lookup__r.CountryCode_Lookup__r.Name)){
                map<string, map<String , List<String>>> countryMap = new map<string,map<String , List<String>>>();
                if(countryMap.get(cityName.State_Lookup__r.Country_Lookup__r.Name)==Null){
                   countryMap.put(cityName.State_Lookup__r.Country_Lookup__r.Name,new map<String , List<String>>());
                }
                countryMap.get(cityName.State_Lookup__r.Country_Lookup__r.Name).put(cityName.State_Lookup__r.Name,new List<String>{cityName.Name});           
                mainMap.put(cityName.State_Lookup__r.Country_Lookup__r.CountryCode_Lookup__r.Name,countryMap);               
            }
        }
        System.debug(mainMap);
    }
    
    public  List<String>  citiesName(String combination){
         for(String countryCodeFilter : mainMap.keySet()){
            if(countryCodeFilter.startsWith(combination)){
                for(String countryFilter: mainMap.get(countryCodeFilter).keyset()){
                    if(countryFilter.startsWith(combination)){
                        for(String stateFilter :mainMap.get(countryCodeFilter).get(countryFilter).keyset()){
                            if(stateFilter.startsWith(combination)){
                               for(String citiesFilter : mainMap.get(countryCodeFilter).get(countryFilter).get(stateFilter)){
                                   if(citiesFilter.startsWith(combination)){
                                         citiesCollectionByWord.add(citiesFilter);
                                    }
                               }
                            }
                        }
                    }
                }
            }
        }
        //System.debug(citiesCollectionByWord);
        return citiesCollectionByWord;
    }
    
    public List<String> citiesLength(Integer find){
         for(String countryCodeFilter : mainMap.keySet()){
                for(String countryFilter: mainMap.get(countryCodeFilter).keyset()){
                        for(String stateFilter :mainMap.get(countryCodeFilter).get(countryFilter).keyset()){
                               for(String citiesFilter : mainMap.get(countryCodeFilter).get(countryFilter).get(stateFilter)){
                                   if(citiesFilter.length()>=find){
                                        citiesCollectionByLength.add(citiesFilter);
                                   }
                               }
                            }
                        }
                    }
                
        //System.debug(citiesCollectionByLength);
        return citiesCollectionByWord;
        
    }

}