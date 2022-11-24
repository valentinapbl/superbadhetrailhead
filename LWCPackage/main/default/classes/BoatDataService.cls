public with sharing class BoatDataService {
    @AuraEnabled(cacheable=true)
    public static List<BoatType__c> getBoatTypes() {
        return [
            SELECT Id, Name
            FROM BoatType__c
       ];
    }
    @AuraEnabled(cacheable=true)
    public static List<Boat__c> getBoats(String boatTypeId) {
        if(String.isNotBlank(boatTypeId)){
        return [
            SELECT Id, Name, Description__c, Geolocation__Latitude__s, Geolocation__Longitude__s, 
            Picture__c, Contact__r.Name, BoatType__c, BoatType__r.Name, Length__c, Price__c 
            FROM Boat__c WHERE BoatType__c =: boatTypeId
       ];} else{
        return [
            SELECT Id, Name, Description__c, Geolocation__Latitude__s, Geolocation__Longitude__s, 
            Picture__c, Contact__r.Name, BoatType__c, BoatType__r.Name, Length__c, Price__c
            FROM Boat__c
       ];
       }
    }
    @AuraEnabled
    public static String updateBoatList(Object data){
        List<Boat__c> boatsForUpdate = (List<Boat__c>) JSON.deserialize(
            JSON.serialize(data),
            List<Boat__c>.class
        );
        
        update boatsForUpdate;
        return 'Success: Boats updated successfully';
    }
}