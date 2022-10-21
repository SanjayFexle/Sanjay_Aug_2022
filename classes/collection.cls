public class collection {
    public void collectionList(){
     	List<String> fexleRow1 = new List<String>();
        List<String> fexleRow2 = new List<String>{'Monika','Yogesh','Ashu'};
        List<String> fexleRow3 = new List<String>{'AtnuDas','RajaRam','Arnab Roy'};
        List<String> copyofFexle3 = new List<String>(fexleRow3); //copy of fexle3
        fexleRow1.add('Anubhav');
        fexleRow1.add('Sanjay');
		fexleRow1.add('Palash');
		fexleRow1.add(0,'Killer'); //add in index value not replace or existing value
        System.debug(fexleRow1.contains('Sanjay'));  //return true if value in list.
        String name=fexleRow1.get(1); // index value return 
        System.assertEquals('Anubhav', name);
        System.debug(fexleRow1.Isempty()); //return true if there is no element in list
        fexleRow1.remove(0); // remove the element from list from specific place
        
        fexleRow2.set(1,'Aditya'); //replace value from list delete old one
        System.debug(fexleRow2.size());
        fexleRow2.sort(); //sorting row
         
        
        System.debug('\n' +'fexleRow1 Trainee names are :-' + fexleRow1 + '\n' + 'fexleRow2 Trainee names are :-' + fexleRow2 );
        System.debug( '\n' +'fexleRow3 Trainee names are :-' +fexleRow3 + '\n'+ 'copyofFexle3 Trainee names are :-' +copyofFexle3 );
  
       
    }
    
    public void collectionSet(){
        set<integer> sNum = new set<integer>{11,12,13}; 
            system.debug(sNum);
			sNum.clear(); //making set empty removing all element
            sNum.add(1);
            sNum.add(2);
            sNum.add(3);
  
        set<integer> sNum2 = new set<integer>{4,5,6};
            sNum.addAll(sNum2); //add all element of other set in sNum
        set<integer> cloneOfsNum = new set<integer>(sNum);
        	
        set<integer> check = new set<integer>{1,2,3,4,5,7}; 
            system.debug('Real set '+sNum);
            system.debug('clone set: '+cloneOfsNum);
        	system.debug(sNum.contains(1));  //contains return true if he find the element in set
        	system.debug(sNum.containsAll(check)); //Returns true if the set contains all of the elements in the specified set. 
        	system.debug(sNum.equals(check)); //Compares this set with the specified set and returns true if both sets are equal; otherwise, returns false.
        	
        	check.remove(1);
        	check.removeAll(cloneOfsNum);
	        system.debug(check.isEmpty()); //Returns true if the set has zero elements.
        	system.debug(check +''+cloneOfsNum);
    		system.debug(cloneofsNum.size()); //return the size of list
    }
    
    public void collectionMap(){
        map<Integer,String> vowels = new map<Integer,String>();
        vowels.put(1,'A');
        vowels.put(2,'E');
        vowels.put(3,'I');
        
        map<Integer,String> check = new map<Integer,String>();
        check=vowels.clone();
        System.debug(check);
        system.debug(check.containsKey(4)); //check map contain key Return True if not Return false
        system.debug(check.isEmpty());
        check.remove(1);
        check.size();
        System.debug(check);
        check.clear();
        System.debug(vowels.values());
        System.debug(vowels);
        
    }
    public void show(){
         map<String, map<String, List<String>>> MyMap = new map<String, map<String, List<String>>>
         {'India' => new map<String, List<String>>
            {'Rajasthan' => new List<String>{'Jaipur','Udaipur'},
             	'West' => new List<String>{'A','B'},
             	'east' => new List<String>{'c','d'}
            },
          'us' => new map<String, List<String>>
            {'A State' => new List<String>{'A1','A2'},
             	'B State' => new List<String>{'B1','B2'},
             	'C State' => new List<String>{'C1','C2'}
            }
         };
		System.debug(MyMap.get('India'));
    }
    
}