@isTest
private class Apex1Testing {
    @isTest static void check(){

        String n = Apex1.Result('Jaipur');
        System.assertEquals('Pass', n);

    }
    @isTest static void check1(){
        String n = Apex1.Result('Kota');
        String s = 'Fail';
        System.assertEquals(s, n);
    }

}