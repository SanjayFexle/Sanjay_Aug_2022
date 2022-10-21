@isTest 
private class Apex2Test {
    @isTest static void show1(){
        String  n = Apex2.Exam(33, 30, 36);
        String s = 'Fail';
        System.assertEquals(s, n);
    }
    
    @isTest static void show2(){
        String  n = Apex2.Exam(45, 45, 56);
        String s = '3 Division';
        System.assertEquals(s, n);
    }
    
    @isTest static void show3(){
        String  n = Apex2.Exam(61, 70, 71);
        String s = '2 Division';
        System.assertEquals(s,n );
    }
    
    @isTest static void show4(){
        String  n = Apex2.Exam(75, 76, 80);
        String s = '1 Division';
        System.assertEquals('1 Division', n);
    }
    
    @isTest static void show5(){
        String  n = Apex2.Exam(91, 95, 90);
        String s = 'Merit';
        System.assertEquals('Merit', n);
    }

}